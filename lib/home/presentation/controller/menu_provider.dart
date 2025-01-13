import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_constants.dart';

enum ItemStatus {
  lights,
  aircon,
  heating,
  speakers,
  fridge,
  calendar,
}

class MenuProvider extends ChangeNotifier {
  //selected value for the text in the draggable container
  var selectedValue = AppConstants.itemsList[0].itemStatus;
  int index = 0;

  void selectValue(ItemStatus itemStatus) {
    selectedValue = itemStatus;
    index = itemStatus.index;

    notifyListeners();
  }

  double dragContainerHeight = 75.h;

  void setDragContainerHeightToMax() {
    dragContainerHeight = AppConstants.dragContainerMaxHeight;

    notifyListeners();
  }

  void setDragContainerHeightToMin() {
    dragContainerHeight = AppConstants.dragContainerMinHeight;

    notifyListeners();
  }
// Track if the button was pressed

  bool isPressed = false;

  void setIsPressed(bool value) {
    isPressed = value;
    notifyListeners();
  }

  void resetIsPressed() {
    isPressed = false;
    notifyListeners();
  }

  // Update the height of the draggable container
  void onPadUpdate(DragUpdateDetails details) {
    dragContainerHeight -= details.delta.dy;
    dragContainerHeight =
        dragContainerHeight.clamp(75.h, AppConstants.dragContainerMaxHeight);
    notifyListeners();
  }

}
