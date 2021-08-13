import 'package:flutter/widgets.dart';

import '../states/overlay_widget_state.dart';

class OverlayBuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final Widget child;
  final bool initialShow, maintainState, opaque;
  final List? args;

  const OverlayBuilder({
    Key? key,
    required this.builder,
    required this.child,
    required this.initialShow,
    required this.maintainState,
    required this.opaque,
    this.args,
  }) : super(key: key);

  @override
  OverlayWidgetState createState() => OverlayWidgetState();
}
