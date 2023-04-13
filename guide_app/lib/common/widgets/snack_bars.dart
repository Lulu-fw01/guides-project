import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cubit/guide_utils_cubit.dart';
import '../themes/main_theme.dart';

/// Build guide snackbar with messages about guide remove.
SnackBar? buildGuideUtilsSnackBar(BuildContext context, GuideUtilsState state) {
  final theme = Provider.of<MainTheme>(context, listen: false);

  if (state is SuccessRemoveGuideState) {
    return _buildSnackBar(theme, 'Гайд удален!');
  } else if (state is ErrorRemoveGuideState) {
    return _buildSnackBar(theme, 'Не получилось удалить гайд', false);
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
