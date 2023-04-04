import 'package:flutter/material.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:provider/provider.dart';

import '../provider/profile_provider.dart';

PreferredSizeWidget profileAppBar(
    BuildContext context, void Function() onMenuButtonClick) {
  final theme = Provider.of<MainTheme>(context);
  final profileProvider = Provider.of<ProfileProvider>(context);

  switch (profileProvider.profileScreenState) {
    case ProfileScreenMode.profileInfo:
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
    case ProfileScreenMode.viewGuide:
      return AppBar(
        backgroundColor: theme.readableBackColor,
        leading: IconButton(
          onPressed: () {
            profileProvider.showProfileInfo();
          },
          icon: Icon(Icons.arrow_back, color: theme.onSurface),
        ),
      );
  }
}
