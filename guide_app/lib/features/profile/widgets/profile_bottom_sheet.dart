import 'package:flutter/material.dart';

import '../../../common/themes/main_theme.dart';

/// Bottom sheet with function of profile screen.
class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet(
      {super.key, required this.theme, required this.onLogout});
  final MainTheme theme;
  final void Function() onLogout;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: MainTheme.errorRed,
          ),
          title: Text(
            'Выйти',
            style: theme.buttonsRedText,
          ),
          onTap: () {
            onLogout();
          },
        )
      ],
    );
  }
}
