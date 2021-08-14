import 'package:flutter/widgets.dart';

import '../widgets/overlay_builder.dart';

mixin OverlayWidgetStateMixin<T extends OverlayBuilder> on State<T> {
  OverlayEntry? _overlayEntry;
  late final _state = Overlay.of(context)!;

  bool get isShowing => _overlayEntry != null;

  void show() {
    _overlayEntry = OverlayEntry(
      builder: widget.builder,
      maintainState: widget.maintainState,
      opaque: widget.opaque,
    );

    _state.insert(_overlayEntry!);
  }

  void remove() {
    _overlayEntry?.remove();

    _overlayEntry = null;
  }

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
