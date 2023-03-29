import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../provider/search_screen_provider.dart';

/// Search screen app bar.
PreferredSizeWidget? searchAppBar(BuildContext context) {
  final theme = Provider.of<MainTheme>(context);
  final searchScreenProvider = Provider.of<SearchScreenProvider>(context);

  switch (searchScreenProvider.profileScreenState) {
    case SearchScreenMode.guideViewMode:
      return AppBar(
        backgroundColor: theme.readableBackColor,
        leading: IconButton(
          onPressed: () {
            searchScreenProvider.showSearch();
          },
          icon: Icon(Icons.arrow_back, color: theme.onSurface),
        ),
      );
    case SearchScreenMode.searchMode:
      return null;
  }
}
