import 'package:flutter/widgets.dart';

mixin ViewDependency {
  abstract final void Function(bool inputView)? onViewChange;

  void addOnViewChange(FocusNode node) {
    if (onViewChange != null) {
      node.addListener(() => onViewChange!(node.hasFocus));
    }
  }
}
