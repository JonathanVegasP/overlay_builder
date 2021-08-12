import 'package:flutter/widgets.dart';

import '../states/overlay_widget_state.dart';

class OverlayImpl extends StatefulWidget {
  final WidgetBuilder builder;
  final Widget child;
  final bool initialShow, maintainState, opaque;

  const OverlayImpl({
    Key? key,
    required this.builder,
    required this.child,
    required this.initialShow,
    required this.maintainState,
    required this.opaque,
  }) : super(key: key);

  @override
  OverlayWidgetState createState() => OverlayWidgetState();
}
