import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../cubit/init_cubit.dart';
import '../provider/profile_provider.dart';
import 'profile_bottom_sheet.dart';

PreferredSizeWidget profileAppBar(
    BuildContext context, void Function() onMenuButtonClick) {
  final theme = Provider.of<MainTheme>(context);
  final profileProvider = Provider.of<ProfileProvider>(context);
  final initCubit = Provider.of<InitCubit>(context, listen: false);

  switch (profileProvider.profileScreenState) {
    case ProfileScreenMode.profileInfo:
      return AppBar(
        backgroundColor: theme.surface,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.0),
                    )),
                    builder: (context) {
                      return ProfileBottomSheet(
                        theme: theme,
                        onLogout: () {
                          initCubit.logout();
                          Navigator.pop(context);
                        },
                      );
                    });
              },
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
