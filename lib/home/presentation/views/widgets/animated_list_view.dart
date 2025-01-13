import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/helpers/animations_method.dart';
import 'listview_item.dart';

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({
    super.key,
    required this.controller,
  });

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final animations = createAnimations(index, controller);

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: animations['slide']!.value,
              child: Opacity(
                opacity: animations['fade']!.value,
                child: Transform.scale(
                  scale: animations['scale']!.value,
                  child: ListviewItem(
                    index: index,
                    controller: controller,
                  ),
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemCount: AppConstants.itemsList.length,
    );
  }
}
