import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../cubit/favorites_cubit.dart';

/// Build guide snackbar with messages about favorites state.
SnackBar? buildFavoritesStateSnackBar(
    BuildContext context, FavoritesState state) {
  final theme = Provider.of<MainTheme>(context, listen: false);

  if (state is SuccessAddToFavoritesState) {
    return _buildSnackBar(theme, 'Гайд добавлен в избранное!');
  } else if (state is SuccessRemoveFromFavoriteState) {
    return _buildSnackBar(theme, 'Гайд удален из избранного!');
  } else if (state is ErrorAddToFavoritesState) {
    return _buildSnackBar(
        theme, 'Не получилось добавить гайд в избранное.', false);
  } else if (state is ErrorRemoveFromFavoriteState) {
    return _buildSnackBar(
        theme, 'Не получилось удалить гайд из избранного.', false);
  }
  return null;
}

SnackBar _buildSnackBar(MainTheme theme, String text, [positive = true]) {
  return SnackBar(
    duration: const Duration(milliseconds: 700),
    backgroundColor: theme.onSurface.withOpacity(0.8),
    content: Row(
      children: [
        Icon(positive ? Icons.check : Icons.close,
            color: positive ? MainTheme.successGreen : MainTheme.errorRed),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: theme.snackBarInfoText,
        ),
      ],
    ),
  );
}
