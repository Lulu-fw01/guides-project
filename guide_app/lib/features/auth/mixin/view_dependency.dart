import 'package:flutter/widgets.dart';

/// View dependency mixin. Need it when keyboard 
/// view changes and we want to redraw something.
mixin ViewDependency {
  abstract final void Function(bool inputView)? onViewChange;

  /// Add listener to [node] if it is not null.
  void addOnViewChange(FocusNode node) {
    if (onViewChange != null) {
      node.addListener(() => onViewChange!(node.hasFocus));
    }
  }
}
