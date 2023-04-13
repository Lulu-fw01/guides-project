import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/main_theme.dart';

/// Popup menu for guide card.
class GuideCardPopupMenuBtn extends StatelessWidget {
  const GuideCardPopupMenuBtn({super.key, this.onEdit, this.onRemove});
  final void Function()? onEdit;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    final popUpItems = <PopupMenuEntry<GuideCardMenuItem>>[];
    if (onEdit != null) {
      popUpItems.add(_buildEdit(theme));
    }
    if (onRemove != null) {
      popUpItems.add(_buildRemove(theme));
    }

    return PopupMenuButton(
        icon: const Icon(Icons.more_horiz),
        color: theme.surface,
        itemBuilder: (context) => popUpItems);
  }

  /// Button to remove guide.
  PopupMenuItem<GuideCardMenuItem> _buildRemove(MainTheme theme) {
    return PopupMenuItem<GuideCardMenuItem>(
      onTap: onRemove,
      value: GuideCardMenuItem.delete,
      child: Row(
        children: [
          Icon(
            Icons.delete,
            color: theme.buttonRed,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            'Удалить',
            style: theme.buttonsRedText,
          ),
        ],
      ),
    );
  }

  /// Edit button.
  PopupMenuItem<GuideCardMenuItem> _buildEdit(MainTheme theme) {
    return PopupMenuItem<GuideCardMenuItem>(
      onTap: onEdit,
      value: GuideCardMenuItem.edit,
      child: Row(
        children: [
          const Icon(
            Icons.edit,
            color: MainTheme.readableColor,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            'Редактировать',
            style: theme.normalText,
          ),
        ],
      ),
    );
  }
}

enum GuideCardMenuItem { edit, delete }
