import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../provider/favorites_provider.dart';

/// App bar of favorites screen.
PreferredSizeWidget favoritesAppBar(BuildContext context) {
  final theme = Provider.of<MainTheme>(context);
  final favoritesProvider = Provider.of<FavoritesProvider>(context);

  switch (favoritesProvider.favoritesScreenState) {
    case FavoritesScreenState.viewFavorites:
      return AppBar(
        backgroundColor: theme.readableBackColor,
        title: Center(
            child: Text(
          'Избранное',
          style: theme.titleText,
        )),
      );

    case FavoritesScreenState.viewGuide:
      return AppBar(
        backgroundColor: theme.readableBackColor,
        leading: IconButton(
          onPressed: () {
            favoritesProvider.showFavorites();
          },
          icon: Icon(Icons.arrow_back, color: theme.onSurface),
        ),
      );
  }
}
