/// [OverlayType] is used to render the overlay based on its type. If it is
/// [OverlayType.fullscreen] then will render an overlay widget that overlays
/// the entire screen, else if it is [OverlayType.positioned] then will render
/// an overlay widget that overlays its child.
enum OverlayType {
  /// Is used to render a fullscreen overlay widget.
  fullscreen,

  /// Is used to render a positioned overlay widget based on its child.
  positioned
}
