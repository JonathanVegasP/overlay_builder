# Overlay Builder

Build overlays using declarative programming

## Getting Started

* Install with command

Run this command with Flutter:

```
flutter pub add overlay_builder
```

* Install manually

Add this line to your package's pubspec.yaml and run `flutter pub/packages get`

```
dependencies:
    overlay_builder: ^1.0.0
```

## Usage

In your Dart code, you can use:

```dart
import 'package:overlay_builder/overlay_builder.dart';
```

To use **OverlayWidget** or **OverlayFullscreen**, you'll need a child anywhere to be rendered in the widget tree as below:

```dart
@override
Widget build(BuildContext context) {
  return const Text('Overlay Builder Demo');
}
```

Then only wrap the current child using **OverlayWidget** or **OverlayFullscreen** as below:

* OverlayWidget

Will render the **overlayChild** based on its child

```dart
@override
Widget build(BuildContext context) {
  return OverlayWidget(
	child: const Text('Overlay Builder Demo'),
	overlayChild: const Material(
	  type: MaterialType.transparency,
	  child: Center(child: Text('Overlay Test')),
	),
  );
}
```

* OverlayFullscreen

Will render the **overlayChild** on the entire screen

```dart
@override
Widget build(BuildContext context) {
  return OverlayFullscreen(
	child: const Text('Overlay Builder Demo'),
	overlayChild: Material(
	  type: MaterialType.transparency,
	  child: ColoredBox(
		color: Colors.black54,
		child: Column(
		  children: const [
			Text('Loading...'),
			SizedBox(height: 8),
			CircularProgressIndicator(
			  valueColor: AlwaysStoppedAnimation(Colors.black),
			),
		  ],
		),
	  ),
	)
  );
}
```

To show or remove the overlay is needed to use a **GlobalKey** as below:

```dart
final _overlay = GlobalKey<OverlayWidgetState>();

OverlayWidgetState get overlayController {
  return _overlay.currentState!;
  // or return _overlay.currentState; to not use Null Safety
}
```

Put the key in an **OverlayBuilder** widget as below:

* OverlayWidget

```dart
@override
Widget build(BuildContext context) {
  return OverlayWidget(
	key: _overlay,
	...
```

* OverlayFullscreen

```dart
@override
Widget build(BuildContext context) {
  return OverlayFullscreen(
	key: _overlay,
	...
```

Then use the key to show, remove or known when the overlay is showing as below:

```dart
void doSomething() {
  // Use this method to show the overlay
  // overlayController.show();

  // Use this method do remove the overlay
  // overlayController.remove();

  // Use this getter to known if the overlay is showing
  // overlayController.isShowing;

  // Use this method to show or remove the overlay
  overlayController.toggle();
}
```

## APIS

The Overlay Builder has many apis to build layout with custom overlays

#### OverlayWidget

Is used to display an overlay widget that overlays its **child**

* Props

| Name | Description | Required |
| :--: | ----------- | -------- |
| overlayChild | Is used to get the current overlay widget. When it changes the current overlay will be updated | true |
| child | Is used to get the current widget that the **OverlayWidget** is wrapping and then display it in the application interface | true |
| initialShow | When true, then it will build the **overlayChild** on the first frame. Defaults to **false** | false |
| maintainState | Whether this entry must be included in the tree even if there is a fully **opaque** entry above it. By default, if there is an entirely **opaque** entry over this one, then this one will not be included in the widget tree (in particular, stateful widgets within the overlay entry will not be instantiated). To ensure that your overlay entry is still built even if it is not visible, set **maintainState** to true. This is more expensive, so should be done with care. In particular, if widgets in an overlay entry with **maintainState** set to true repeatedly call **State.setState**, the user's battery will be drained unnecessarily. This is used by the **Navigator** and **Route** objects to ensure that routes are kept around even when in the background, so that **Future**s promised from subsequent routes will be handled properly when they complete. Defaults to **false** | false |
| opaque | Whether this entry occludes the entire overlay. If an entry claims to be opaque, then, for efficiency, the overlay will skip building entries below that entry unless they have **maintainState** set. Defaults to **false** | false |
| alignment | Is used to align the **overlayChild** based on its **child**'s constraints. Defaults to **OverlayAlignment.bottomCenter** | false |
| verticalSpacing | Is used to add padding vertically to its **overlayChild**. Defaults to **0.0**, can be negative | false |
| horizontalSpacing | Is used to add padding horizontally to its **overlayChild**. Defaults to **0.0**, can be negative | false |

#### OverlayFullscreen

Is used to display an overlay widget that overlays the entire screen

* Props

| Name | Description | Required |
| :--: | ----------- | -------- |
| overlayChild | Is used to get the current overlay widget. When it changes the current overlay will be updated | true |
| child | Is used to get the current widget that the **OverlayFullscreen** is wrapping and then display it in the application interface | true |
| initialShow | When true, then it will build the **overlayChild** on the first frame. Defaults to **false** | false |
| maintainState | Whether this entry must be included in the tree even if there is a fully **opaque** entry above it. By default, if there is an entirely **opaque** entry over this one, then this one will not be included in the widget tree (in particular, stateful widgets within the overlay entry will not be instantiated). To ensure that your overlay entry is still built even if it is not visible, set **maintainState** to true. This is more expensive, so should be done with care. In particular, if widgets in an overlay entry with **maintainState** set to true repeatedly call **State.setState**, the user's battery will be drained unnecessarily. This is used by the **Navigator** and **Route** objects to ensure that routes are kept around even when in the background, so that **Future**s promised from subsequent routes will be handled properly when they complete. Defaults to **false** | false |
| opaque | Whether this entry occludes the entire overlay. If an entry claims to be opaque, then, for efficiency, the overlay will skip building entries below that entry unless they have **maintainState** set. Defaults to **false** | false |

#### OverlayAlignment

Is used with **OverlayWidget** to align the overlay widget

* Getters

| Name | Description |
| :--: | ----------- |
| topCenter | The center point along the top edge. |
| topLeft | The top left corner. |
| topRight | The top right corner. |
| center | The center point, both horizontally and vertically. |
| centerLeft | The center point along the left edge. |
| centerRight | The center point along the right edge. |
| bottomCenter | The center point along the bottom edge. |
| bottomLeft | The bottom left corner. |
| bottomRight | The bottom right corner. |

#### OverlayWidgetState

Is used with a **GlobalKey** to get the current **OverlayBuilder**'s state for showing, removing or known when it is showing an overlay widget

* Methods

| Name | Description |
| :--: | ----------- |
| show | Is used to show the **OverlayBuilder.overlayChild** widget overlaying its screen or child |
| remove | Is used to remove the **OverlayBuilder.overlayChild** widget when it is overlaying its screen or child |
| toggle | Is used to show or remove the **OverlayBuilder.overlayChild** widget |

* Getters

| Name | Description |
| :--: | ----------- |
| isShowing | is used to known when the overlay is showing |