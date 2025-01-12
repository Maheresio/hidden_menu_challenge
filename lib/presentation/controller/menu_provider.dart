import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  var selectedValue = ItemStatus.aircon;

  void selectValue(ItemStatus itemStatus) {
    selectedValue = itemStatus;

    notifyListeners();
  }

  double dragContainerHeight = 75.h;

  final maxHeight = 1.sh * .8;
  final minHeight = 75.h;

  void setDragContainerHeightToMax() {
    dragContainerHeight = maxHeight;

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
    dragContainerHeight = dragContainerHeight.clamp(75.h, maxHeight);
    notifyListeners();
  }

  void updateAnimation(AnimationController controller) {
    final progress =
        (dragContainerHeight - minHeight) / (maxHeight - minHeight);

    // Invert the progress for reverse behavior
    controller.value = 1 - progress.clamp(0.0, 1.0);
  }
}
