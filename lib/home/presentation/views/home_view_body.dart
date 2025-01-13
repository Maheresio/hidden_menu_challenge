import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidden_menu_challenge/core/utils/app_constants.dart';
import 'package:hidden_menu_challenge/home/presentation/views/widgets/drag_container.dart';
import 'package:provider/provider.dart';
import 'widgets/animated_list_view.dart';
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
      duration: Duration(seconds: 1),
    )..forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateAnimation(double height) {
    final progress = (height - AppConstants.dragContainerMinHeight) /
        (AppConstants.dragContainerMaxHeight -
            AppConstants.dragContainerMinHeight);

    // AppConstants.dragContainerMaxHeightert the progress for reverse behavior
    _controller.value = 1 - progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuProvider>();

    // Listen to changes in the container height
    if (provider.isPressed) {
      _controller.reverse(from: .8);

      // Use a post-frame callback to reset the flag after the current frame
      SchedulerBinding.instance.addPostFrameCallback((_) {
        provider.resetIsPressed();
      });
    }

    return GestureDetector(
      onTap: () {
        if (provider.dragContainerHeight >
            AppConstants.dragContainerMinHeight) {
          provider.setDragContainerHeightToMin();
          _controller.forward(from: .2);
        }
      },
      behavior:
          HitTestBehavior.opaque, // Ensures the tap is detected in empty areas
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 14.w,
              end: 14.w,
              top: 50.h,
            ),
            child: AnimatedListView(controller: _controller),
          ),
          DragContainer(
            provider: provider,
            controller: _controller,
            updateAnimation: _updateAnimation,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            start:130.w,
            end: 0,
            top: 0,
            child: Text(
              'Maheresio',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
