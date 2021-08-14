import 'package:flutter/widgets.dart';

import '../../data/enums/overlay_alignment.dart';
import '../states/overlay_widget_state.dart';

class OverlayBuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final Widget overlayChild, child;

  final bool initialShow, maintainState, opaque;
  final OverlayAlignment? alignment;
  final double? verticalSpacing, horizontalSpacing, height, width;

  const OverlayBuilder({
    Key? key,
    required this.builder,
    required this.overlayChild,
    required this.child,
    required this.initialShow,
    required this.maintainState,
    required this.opaque,
    this.alignment,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  OverlayWidgetState createState() => OverlayWidgetState();
}
