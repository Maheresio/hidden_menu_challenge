import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidden_menu_challenge/core/utils/app_constants.dart';
import 'package:hidden_menu_challenge/home/presentation/controller/menu_provider.dart';

import '../../../../core/utils/app_colors.dart';

class DragContainer extends StatelessWidget {
  const DragContainer({
    super.key,
    required this.provider,
    required this.controller,
    required this.updateAnimation,
  });

  final MenuProvider provider;
  final AnimationController controller;
  final Function(double) updateAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositionedDirectional(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      bottom: 0,
      start: 0,
      end: 0,
      height: provider.dragContainerHeight,
      child: GestureDetector(
        onPanUpdate: (details) {
          // Update the container height
          provider.onPadUpdate(details);

          // Trigger the animation
          updateAnimation(provider.dragContainerHeight);
        },
        onPanEnd: (details) {
          // Pause the animation when the drag ends
          controller.stop();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppConstants.circularRadius40),
              topRight: Radius.circular(AppConstants.circularRadius40),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                spacing: constraints.maxHeight * .4, // Use spacing attribute
                children: [
                  Icon(
                    Icons.drag_handle_outlined,
                    size: 40.w,
                    color: AppColors.blue,
                  ),
                  Expanded(
                    child: Text(
                      AppConstants.itemsList[provider.index].label,
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
    );
  }
}
