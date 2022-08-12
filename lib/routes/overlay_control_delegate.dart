class OverlayControlDelegate {
  Function(String? nameRoute)? emitRoute;
  Function(String? nameRoute)? emitTab;
  static OverlayControlDelegate? _instance;

  factory OverlayControlDelegate() {
    return _instance ??= OverlayControlDelegate._();
  }

  OverlayControlDelegate._();
}