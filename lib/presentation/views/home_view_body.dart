import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_constants.dart';
import 'widgets/listview_item.dart';
import '../controller/menu_provider.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), 
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateAnimation(double height) {
    final maxHeight =
        MediaQuery.of(context).size.height * 0.8; // Maximum height
    final minHeight = 75.h; // Minimum height
    final progress = (height - minHeight) / (maxHeight - minHeight);

    // Invert the progress for reverse behavior
    _controller.value = 1 - progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuProvider>();

    // Listen to changes in the container height
    if (provider.isPressed) {
      _updateAnimation(provider.dragContainerHeight);

      // Use a post-frame callback to reset the flag after the current frame
      SchedulerBinding.instance.addPostFrameCallback((_) {
        provider.resetIsPressed();
      });
    }

    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 50.h),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final animationDelay = index / AppConstants.itemsList.length;
              final slideAnimation = Tween<Offset>(
                begin: Offset(0, 1), // Start offscreen (below)
                end: Offset(0, 0), // Move to original position
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    animationDelay,
                    (animationDelay + 1 / AppConstants.itemsList.length)
                        .clamp(0.0, 1.0),
                    curve: Curves.easeInOut,
                  ),
                ),
              );

              final fadeAnimation = Tween<double>(
                begin: 0, // Start fully transparent
                end: 1, // End fully opaque
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    animationDelay,
                    (animationDelay + 1 / AppConstants.itemsList.length)
                        .clamp(0.0, 1.0),
                    curve: Curves.easeInOut,
                  ),
                ),
              );

              final scaleAnimation = Tween<double>(
                begin: 0.5, // Start scaled down
                end: 1, // End at normal scale
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    animationDelay,
                    (animationDelay + 1 / AppConstants.itemsList.length)
                        .clamp(0.0, 1.0),
                    curve: Curves.easeInOut,
                  ),
                ),
              );

              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: slideAnimation.value,
                    child: Opacity(
                      opacity: fadeAnimation.value,
                      child: Transform.scale(
                        scale: scaleAnimation.value,
                        child: ListviewItem(
                          index: index,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemCount: AppConstants.itemsList.length,
          ),
        ),
        AnimatedPositionedDirectional(
          duration: Duration(milliseconds: 400),
          curve: Curves.linearToEaseOut,
          bottom: 0,
          start: 0,
          end: 0,
          height: provider.dragContainerHeight,
          child: GestureDetector(
            onPanUpdate: (details) {
              // Update the container height
              provider.onPadUpdate(details);

              // Trigger the animation
              _updateAnimation(provider.dragContainerHeight);
            },
            onPanEnd: (details) {
              // Pause the animation when the drag ends
              _controller.stop();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    spacing:
                        constraints.maxHeight * .4, // Use spacing attribute
                    children: [
                      Icon(
                        Icons.drag_handle_outlined,
                        size: 40.w,
                        color: AppColors.blue,
                      ),
                      Expanded(
                        child: Text(
                          provider.selectedValue.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 40.sp,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
