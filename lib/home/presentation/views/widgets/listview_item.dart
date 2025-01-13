import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

class ListviewItem extends StatelessWidget {
  const ListviewItem(
      {super.key, required this.index, required this.controller});

  final int index;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuProvider>();
    return GestureDetector(
      onTap: () {
        provider.selectValue(AppConstants.itemsList[index].itemStatus);
        provider.setDragContainerHeightToMax();
        provider.setIsPressed(true);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: AppConstants.dragContainerMinHeight,
        ),
        child: Card(
          color:
              AppConstants.itemsList[index].itemStatus == provider.selectedValue
                  ? AppColors.white
                  : AppColors.blue,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w),
            child: Row(
              spacing: 20.w,
              children: [
                Icon(
                  AppConstants.itemsList[index].icon,
                  color: AppConstants.itemsList[index].itemStatus ==
                          provider.selectedValue
                      ? AppColors.darkBlue
                      : AppColors.white,
                ),
                Text(
                  AppConstants.itemsList[index].label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: AppConstants.itemsList[index].itemStatus ==
                            provider.selectedValue
                        ? AppColors.darkBlue
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
