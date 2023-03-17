import 'package:flutter/material.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget profileAppBar(
    BuildContext context, void Function() onMenuButtonClick) {
  final theme = Provider.of<MainTheme>(context);
  return AppBar(
    backgroundColor: theme.surface,
    actions: [
      IconButton(
          onPressed: onMenuButtonClick,
          icon: Icon(
            Icons.menu,
            color: theme.onSurface,
          ))
    ],
  );
}
