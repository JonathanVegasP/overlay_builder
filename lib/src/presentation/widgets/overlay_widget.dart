import 'package:flutter/widgets.dart';

import '../../data/enums/overlay_alignment.dart';
import 'overlay_builder.dart';

class OverlayWidget extends StatelessWidget {
  final Key? _overlayKey;
  final Widget overlayChild, child;
  final bool initialShow, maintainState, opaque;
  final OverlayAlignment alignment;
  final double verticalSpacing, horizontalSpacing;

  const OverlayWidget({
    Key? key,
    required this.overlayChild,
    required this.child,
    this.initialShow = false,
    this.maintainState = false,
    this.opaque = false,
    this.alignment = OverlayAlignment.bottomCenter,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
  })  : _overlayKey = key,
        super(key: null);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, viewPort) {
      return OverlayBuilder(
        key: _overlayKey,
        args: [
          alignment,
          verticalSpacing,
          horizontalSpacing,
          viewPort.maxHeight,
          viewPort.maxWidth
        ],
        child: child,
        initialShow: initialShow,
        maintainState: maintainState,
        opaque: opaque,
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
