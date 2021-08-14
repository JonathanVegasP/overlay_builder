import 'package:flutter/widgets.dart';

import '../mixins/overlay_widget_state_mixin.dart';
import '../widgets/overlay_builder.dart';

/// [OverlayWidgetState] is used with a [GlobalKey] to get the current
/// [OverlayBuilder]'s state for showing, removing or known when it is
/// showing an overlay widget
class OverlayWidgetState extends State<OverlayBuilder>
    with OverlayWidgetStateMixin {
  @override
  Widget build(BuildContext context) => widget.child;
}
