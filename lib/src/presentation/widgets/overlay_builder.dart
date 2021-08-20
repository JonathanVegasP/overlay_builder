import 'package:flutter/widgets.dart';

import '../../data/enums/overlay_alignment.dart';
import '../../data/enums/overlay_type.dart';
import '../states/overlay_widget_state.dart';

/// [OverlayBuilder] is used to display an overlay widget based on its [type].
class OverlayBuilder extends StatefulWidget {
  /// [overlayChild] is used to get the current overlay
  /// widget. When it changes the current overlay will be updated.
  final Widget overlayChild;

  /// [child] is used to get the current widget that the [OverlayBuilder] is
  /// wrapping and then display it in the application interface.
  final Widget child;

  /// [initialShow] when true, then it will build the [overlayChild] on the
  /// first frame. Defaults to [false].
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
  /// Defaults to [false].
  final bool maintainState;

  /// Whether this entry occludes the entire overlay.
  ///
  /// If an entry claims to be opaque, then, for efficiency, the overlay will
  /// skip building entries below that entry unless they have [maintainState]
  /// set. Defaults to [false].
  final bool opaque;

  /// [type] is used to render the overlay widget based on its type. If it is
  /// [OverlayType.fullscreen] then will render an overlay widget that overlays
  /// the entire screen, else if it is [OverlayType.positioned] then will render
  /// an overlay widget that overlays its child. Defaults to
  /// [OverlayType.positioned].
  final OverlayType type;

  /// [alignment] is used to align the [overlayChild] based on its [child]'s
  /// constraints when [type] is [OverlayType.positioned]. Defaults to
  /// [OverlayAlignment.bottomCenter].
  final OverlayAlignment alignment;

  /// [verticalSpacing] is used to add padding vertically to its [overlayChild]
  /// when [type] is [OverlayType.positioned]. Defaults to [0.0], can be negative.
  final double verticalSpacing;

  /// [horizontalSpacing] is used to add padding horizontally to its
  /// [overlayChild] when [type] is [OverlayType.positioned]. Defaults to [0.0],
  /// can be negative.
  final double horizontalSpacing;

  /// [OverlayBuilder] constructor is used to create a new widget to handle the
  /// overlay widget based on its [type].
  const OverlayBuilder({
    Key? key,
    required this.overlayChild,
    required this.child,
    this.initialShow = false,
    this.maintainState = false,
    this.opaque = false,
    this.type = OverlayType.positioned,
    this.alignment = OverlayAlignment.bottomCenter,
    this.verticalSpacing = .0,
    this.horizontalSpacing = .0,
  }) : super(key: key);

  @override
  OverlayWidgetState createState() => OverlayWidgetState();
}
