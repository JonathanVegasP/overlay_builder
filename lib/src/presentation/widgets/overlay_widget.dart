import 'package:flutter/widgets.dart';

import '../../data/enums/overlay_alignment.dart';
import 'overlay_builder.dart';

/// [OverlayWidget] is used to display an overlay widget that overlays its
/// [child]
class OverlayWidget extends StatelessWidget {
  final Key? _overlayKey;

  /// [overlayChild] is used to get the current overlay
  /// widget. When it changes the current overlay will be updated
  final Widget overlayChild;

  /// [child] is used to get the current widget that the [OverlayWidget] is
  /// wrapping and then display it in the application interface
  final Widget child;

  /// [initialShow] when true, then it will build the [overlayChild] on the
  /// first frame. Defaults to [false]
  final bool initialShow;

  /// Whether this entry must be included in the tree even if there is a fully
  /// [opaque] entry above it.
  ///
  /// By default, if there is an entirely [opaque] entry over this one, then this
  /// one will not be included in the widget tree (in particular, stateful widgets
  /// within the overlay entry will not be instantiated). To ensure that your
  /// overlay entry is still built even if it is not visible, set [maintainState]
  /// to true. This is more expensive, so should be done with care. In particular,
  /// if widgets in an overlay entry with [maintainState] set to true repeatedly
  /// call [State.setState], the user's battery will be drained unnecessarily.
  ///
  /// This is used by the [Navigator] and [Route] objects to ensure that routes
  /// are kept around even when in the background, so that [Future]s promised
  /// from subsequent routes will be handled properly when they complete.
  /// Defaults to [false]
  final bool maintainState;

  /// Whether this entry occludes the entire overlay.
  ///
  /// If an entry claims to be opaque, then, for efficiency, the overlay will
  /// skip building entries below that entry unless they have [maintainState]
  /// set. Defaults to [false]
  final bool opaque;

  /// [alignment] is used to align the [overlayChild] based on its [child]'s
  /// constraints. Defaults to [OverlayAlignment.bottomCenter]
  final OverlayAlignment alignment;

  /// [verticalSpacing] is used to add padding vertically to its [overlayChild].
  /// Defaults to [0.0], can be negative
  final double verticalSpacing;

  /// [verticalSpacing] is used to add padding horizontally to its
  /// [overlayChild]. Defaults to [0.0], can be negative
  final double horizontalSpacing;

  const OverlayWidget({
    Key? key,
    required this.overlayChild,
    required this.child,
    this.initialShow = false,
    this.maintainState = false,
    this.opaque = false,
    this.alignment = OverlayAlignment.bottomCenter,
    this.verticalSpacing = 0.0,
    this.horizontalSpacing = 0.0,
  })  : _overlayKey = key,
        super(key: null);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, viewPort) {
      return OverlayBuilder(
        key: _overlayKey,
        overlayChild: overlayChild,
        child: child,
        initialShow: initialShow,
        maintainState: maintainState,
        opaque: opaque,
        alignment: alignment,
        verticalSpacing: verticalSpacing,
        horizontalSpacing: horizontalSpacing,
        height: viewPort.maxHeight,
        width: viewPort.maxWidth,
        builder: (overlayContext) {
          final box = context.findRenderObject() as RenderBox;

          final origin = box.localToGlobal(Offset.zero);

          Offset offset;

          switch (alignment) {
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

          offset = offset.translate(horizontalSpacing, verticalSpacing);

          Widget child = FractionalTranslation(
            translation: const Offset(-0.5, -0.5),
            child: overlayChild,
          );

          if (viewPort.hasBoundedHeight & viewPort.hasBoundedWidth) {
            child = ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: viewPort.maxWidth,
                height: viewPort.maxHeight,
              ),
              child: child,
            );
          }

          return Positioned(
            top: offset.dy,
            left: offset.dx,
            child: child,
          );
        },
      );
    });
  }
}
