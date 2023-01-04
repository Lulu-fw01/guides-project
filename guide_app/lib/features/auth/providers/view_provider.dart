import 'package:flutter/widgets.dart';

/// Provider for changing view from input to standard.
class ViewProvider with ChangeNotifier {
  bool _isInputView = false;

  set isInputView(bool view) {
    if (_isInputView != view) {
      _isInputView = view;
      notifyListeners();
    }
  }

  bool get isInputView => _isInputView;
}
