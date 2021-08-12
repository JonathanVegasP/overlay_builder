import 'package:flutter/widgets.dart';

import '../mixins/overlay_widget_state_mixin.dart';
import '../widgets/overlay.dart';

class OverlayWidgetState extends State<OverlayImpl>
    with OverlayWidgetStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
