import 'package:flutter/widgets.dart';

import '../widgets/overlay.dart';

mixin OverlayWidgetStateMixin<T extends OverlayImpl> on State<T> {
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

    if (widget.initialShow) {
      Future.microtask(show);
    }
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    if (oldWidget.builder != widget.builder && isShowing) {
      remove();

      Future.microtask(show);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    remove();

    super.dispose();
  }
}
