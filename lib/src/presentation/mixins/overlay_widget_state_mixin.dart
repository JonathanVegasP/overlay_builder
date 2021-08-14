import 'package:flutter/widgets.dart';

import '../widgets/overlay_builder.dart';

mixin OverlayWidgetStateMixin<T extends OverlayBuilder> on State<T> {
  OverlayEntry? _overlayEntry;
  late final _state = Overlay.of(context)!;

  /// [isShowing] is used to known when the overlay is
  /// showing
  bool get isShowing => _overlayEntry != null;

  /// [show] is used to show the
  /// [OverlayBuilder.overlayChild] widget overlaying its screen or child
  void show() {
    assert(
      !isShowing,
      'Cannot show an overlay widget when it is already showing',
    );

    _overlayEntry = OverlayEntry(
      builder: widget.builder,
      maintainState: widget.maintainState,
      opaque: widget.opaque,
    );

    _state.insert(_overlayEntry!);
  }

  /// [remove] is used to remove the
  /// [OverlayBuilder.overlayChild] widget when it is overlaying its screen or
  /// child
  void remove() {
    _overlayEntry?.remove();

    _overlayEntry = null;
  }

  /// [toggle] is used to show or remove the
  /// [OverlayBuilder.overlayChild] widget
  void toggle() {
    if (isShowing) {
      remove();
    } else {
      show();
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialShow) Future.microtask(show);
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    void update() {
      remove();

      Future.microtask(show);
    }

    if ((oldWidget.overlayChild != widget.overlayChild) |
        (oldWidget.alignment != widget.alignment)) {
      update();
    } else if ((oldWidget.verticalSpacing != widget.verticalSpacing) |
        (oldWidget.horizontalSpacing != widget.horizontalSpacing)) {
      update();
    } else if ((oldWidget.height != widget.height) |
        (oldWidget.width != widget.width)) {
      update();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    assert(() {
      remove();

      Future.microtask(show);

      return true;
    }());

    super.reassemble();
  }

  @override
  void dispose() {
    remove();

    super.dispose();
  }
}
