import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../data/enums/overlay_type.dart';
import '../mixins/overlay_widget_state_mixin.dart';
import '../widgets/overlay_builder.dart';

/// [OverlayWidgetState] is used with a [GlobalKey] to get the current
/// [OverlayBuilder]'s state for showing, removing or known when it is
/// showing an overlay widget.
class OverlayWidgetState extends State<OverlayBuilder>
    with OverlayWidgetStateMixin {
  /// [OverlayWidgetState] constructor is used to create a new state and be
  /// handled with a [GlobalKey] to get the current [OverlayBuilder]'s state for
  /// showing, removing or known when it is showing an overlay widget.
  OverlayWidgetState() : super();

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    scheduleMicrotask(() => this.constraints = constraints);

    return widget.child;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == OverlayType.positioned) {
      return LayoutBuilder(builder: _builder);
    }

    return widget.child;
  }
}
