import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';

PreferredSizeWidget favoritesAppBar(BuildContext context) {
  final theme = Provider.of<MainTheme>(context);
  return AppBar(
    backgroundColor: theme.surface,
    title: const Center(child: Text('Избранное')),
  );
}
