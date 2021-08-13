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

    if (widget.initialShow) {
      Future.microtask(show);
    }
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    void update() {
      remove();

      Future.microtask(show);
    }

    if ((widget.args != null) & (oldWidget.args != null)) {
      final args = widget.args!;
      final oldArgs = oldWidget.args!;
      final length = args.length;

      if (length != oldArgs.length) {
        update();
      } else {
        for (var i = 0; i < length; i++) {
          if (args[i] != oldArgs[i]) {
            update();
            break;
          }
        }
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    remove();

    super.dispose();
  }
}
