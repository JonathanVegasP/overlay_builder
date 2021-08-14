import 'package:flutter/widgets.dart';

import 'overlay_builder.dart';

/// [OverlayFullscreen] is used to display an overlay widget that overlays the
/// entire screen
class OverlayFullscreen extends StatelessWidget {
  final Key? _overlayKey;

  /// [overlayChild] is used to get the current overlay
  /// widget. When it changes the current overlay will be updated
  final Widget overlayChild;

  /// [child] is used to get the current widget that the [OverlayFullscreen] is
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

  const OverlayFullscreen({
    Key? key,
    required this.overlayChild,
    required this.child,
    this.initialShow = false,
    this.maintainState = false,
    this.opaque = false,
  })  : _overlayKey = key,
        super(key: null);

  @override
  Widget build(BuildContext context) {
    return OverlayBuilder(
      key: _overlayKey,
      builder: (context) => Positioned.fill(child: overlayChild),
      overlayChild: overlayChild,
      child: child,
      initialShow: initialShow,
      maintainState: maintainState,
      opaque: opaque,
    );
  }
}
