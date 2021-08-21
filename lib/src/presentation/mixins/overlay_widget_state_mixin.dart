import 'package:flutter/widgets.dart';

import '../../data/enums/overlay_alignment.dart';
import '../../data/enums/overlay_type.dart';
import '../widgets/overlay_builder.dart';

/// [OverlayWidgetStateMixin] is the core implementation of
/// [OverlayWidgetState].
mixin OverlayWidgetStateMixin<T extends OverlayBuilder> on State<T> {
  OverlayEntry? _overlayEntry;
  late final _state = Overlay.of(context)!;
  BoxConstraints? _constraints;
  late WidgetBuilder _builder;

  /// [constraints] is used internally.
  @protected
  set constraints(BoxConstraints constraints) {
    if (_constraints != null) {
      final _constraints = this._constraints!;

      if ((_constraints.maxWidth != constraints.maxWidth) |
          (_constraints.maxHeight != constraints.maxHeight)) {
        remove();

        WidgetsBinding.instance!.addPostFrameCallback(show);
      }
    }

    _constraints = constraints;
  }

  /// [isShowing] is used to known when the overlay is showing.
  bool get isShowing => _overlayEntry != null;

  /// [show] is used to show the [OverlayBuilder.overlayChild] widget overlaying
  /// its screen or child.
  void show([_]) {
    assert(
      !isShowing,
      'Cannot show an overlay widget when it is already showing.',
    );

    final overlay = _overlayEntry = OverlayEntry(
      builder: _builder,
      maintainState: widget.maintainState,
      opaque: widget.opaque,
    );

    _state.insert(overlay);
  }

  /// [remove] is used to remove the [OverlayBuilder.overlayChild] widget when
  /// it is overlaying its screen or child.
  void remove() {
    _overlayEntry?.remove();

    _overlayEntry = null;
  }

  /// [toggle] is used to show or remove the [OverlayBuilder.overlayChild]
  /// widget.
  void toggle() {
    if (isShowing) {
      remove();
    } else {
      show();
    }
  }

  void _setBuilder() {
    _builder = widget.type == OverlayType.positioned
        ? (BuildContext overlayContext) {
            final box = context.findRenderObject() as RenderBox;

            final origin = box.localToGlobal(Offset.zero);

            late Offset offset;

            switch (widget.alignment) {
              case OverlayAlignment.topCenter:
                offset = box.size.topCenter(origin);
                break;
              case OverlayAlignment.topLeft:
                offset = box.size.topLeft(origin);
                break;
              case OverlayAlignment.topRight:
                offset = box.size.topRight(origin);
                break;
              case OverlayAlignment.center:
                offset = box.size.center(origin);
                break;
              case OverlayAlignment.centerLeft:
                offset = box.size.centerLeft(origin);
                break;
              case OverlayAlignment.centerRight:
                offset = box.size.centerRight(origin);
                break;
              case OverlayAlignment.bottomCenter:
                offset = box.size.bottomCenter(origin);
                break;
              case OverlayAlignment.bottomLeft:
                offset = box.size.bottomLeft(origin);
                break;
              case OverlayAlignment.bottomRight:
                offset = box.size.bottomRight(origin);
                break;
            }

            offset = offset.translate(
              widget.horizontalSpacing,
              widget.verticalSpacing,
            );

            Widget child = FractionalTranslation(
              translation: const Offset(-0.5, -0.5),
              child: widget.overlayChild,
            );

            final _constraints = this._constraints!;

            if (_constraints.hasBoundedHeight & _constraints.hasBoundedWidth) {
              child = ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: _constraints.maxWidth,
                  height: _constraints.maxHeight,
                ),
                child: child,
              );
            }

            return Positioned(top: offset.dy, left: offset.dx, child: child);
          }
        : (BuildContext context) => Positioned.fill(child: widget.overlayChild);
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialShow) WidgetsBinding.instance!.addPostFrameCallback(show);

    _setBuilder();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    void update() {
      remove();

      WidgetsBinding.instance!.addPostFrameCallback(show);
    }

    final hasNewType = oldWidget.type != widget.type;

    if (hasNewType) {
      _setBuilder();
    }

    if (!isShowing) {
    } else if (hasNewType | (oldWidget.overlayChild != widget.overlayChild)) {
      update();
    } else if (widget.type == OverlayType.fullscreen) {
    } else if ((oldWidget.alignment != widget.alignment) |
        (oldWidget.verticalSpacing != widget.verticalSpacing) |
        (oldWidget.horizontalSpacing != widget.horizontalSpacing)) {
      update();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    remove();

    super.dispose();
  }
}
