# Hidden Menu Challenge

This Flutter project demonstrates a **draggable bottom sheet** with **animated list items**. The bottom sheet can be dragged up and down, and the list items animate based on the container's height. Additionally, clicking on a list item updates the container's height and triggers the animation.

---

## Features

- **Draggable Bottom Sheet**:
  - The bottom sheet can be dragged up and down to resize it.
  - The height of the container is clamped between a minimum and maximum value.

- **Animated List Items**:
  - List items animate into view when the container is dragged up.
  - List items animate out of view when the container is dragged down.
  - The animation includes **slide**, **fade**, and **scale** effects.

- **Button Interaction**:
  - Clicking on a list item updates the container's height to its maximum value.
  - The animation is triggered when the container's height changes.

- **Provider State Management**:
  - The app uses `Provider` to manage the state of the container's height and animation.

---

## How It Works

### Animation Logic

- The `AnimationController` is used to control the animation of the list items.
- The animation progress is tied to the container's height:
  - When the container is dragged up, the animation plays in **reverse** (items animate out of view).
  - When the container is dragged down, the animation plays **forward** (items animate into view).

### Drag Gesture Handling

- The `GestureDetector` listens for drag updates (`onPanUpdate`) and drag end events (`onPanEnd`).
- The container's height is updated based on the drag gesture, and the animation is triggered.

### Button Interaction

- When a list item is clicked, the container's height is updated to its maximum value.
- The `isPressed` flag is set to `true`, which triggers the animation.
- After the animation is updated, the `isPressed` flag is reset using a **post-frame callback** to avoid rebuild loops.

---

## Code Structure

### Key Files

1. **`HomeView` Widget**:
   - The main widget that builds the UI and handles the animation logic.
   - Uses `AnimatedPositionedDirectional` to animate the bottom sheet.
   - Uses `ListView.separated` to display the list items.

2. **`ListviewItem` Widget**:
   - Represents a single item in the list.
   - Handles the button click and updates the container's height.

3. **`MenuProvider`**:
   - Manages the state of the container's height and the `isPressed` flag.
   - Provides methods to update the height and reset the flag.

---

## Dependencies

- [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil): For responsive UI design.
- [`provider`](https://pub.dev/packages/provider): For state management.

---

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

---

## Acknowledgments

- Thanks to the Flutter team for the amazing framework.
- Inspired by [Flutter's DraggableScrollableSheet](https://api.flutter.dev/flutter/material/DraggableScrollableSheet-class.html).
