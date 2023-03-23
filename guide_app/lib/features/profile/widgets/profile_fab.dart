import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../provider/profile_provider.dart';

/// Floating action button of profile page.
class ProfileFab extends StatelessWidget {
  const ProfileFab({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);

    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      return profileProvider.profileScreenState == ProfileScreenMode.profileInfo
          ? FloatingActionButton(
              backgroundColor: theme.onSurfaceVariant,
              onPressed: onPressed,
              child: Icon(
                Icons.add,
                color: theme.onSurface,
              ),
            )
          : Container();
    });
  }
}
