import 'package:flutter/widgets.dart';

/// Provider for state management
/// screens of the app.
class CoreProvider extends ChangeNotifier {
  CoreProvider();
  CoreMode currentMode = CoreMode.main;

  int? guideToUpdateId;

  void updateGuide(int guideId) {
    guideToUpdateId = guideId;
    currentMode = CoreMode.updatingGuide;
    notifyListeners();
  }

  void goToMain() {
    currentMode = CoreMode.main;
    notifyListeners();
  }
}

enum CoreMode {
  /// Main screen.
  main,

  /// Screen for updating guide.
  updatingGuide
}
