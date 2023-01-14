import 'package:flutter/material.dart';
import 'package:guide_app/common/themes/main_theme.dart';

InputDecoration searchInputDecoration(MainTheme theme,
        TextEditingController controller, void Function() onClearClick) =>
    InputDecoration(
        hintText: 'Поиск',
        hintStyle: TextStyle(color: theme.onSurfaceVariant),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.surface),
            borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.surface),
            borderRadius: BorderRadius.circular(16)),
        prefixIcon: Icon(
          Icons.search,
          color: theme.onSurfaceVariant,
        ),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(
                  Icons.clear,
                  color: theme.onSurfaceVariant,
                ),
                onPressed: onClearClick,
              ),
        filled: true,
        fillColor: theme.surface);
