import 'package:flutter/widgets.dart';

import 'overlay_builder.dart';

class OverlayFullscreen extends StatelessWidget {
  final Key? _overlayKey;
  final Widget overlayChild, child;
  final bool initialShow, maintainState, opaque;

  const OverlayFullscreen({
    Key? key,
    required this.overlayChild,
    required this.child,
    this.initialShow = false,
    this.maintainState = false,
    this.opaque = false,
  })  : _overlayKey = key,
        super(key: null);

  Widget onBuild(_) => Positioned.fill(child: overlayChild);

  @override
  Widget build(BuildContext context) {
    return OverlayBuilder(
      key: _overlayKey,
      builder: onBuild,
      overlayChild: overlayChild,
      child: child,
      initialShow: initialShow,
      maintainState: maintainState,
      opaque: opaque,
    );
  }
}
