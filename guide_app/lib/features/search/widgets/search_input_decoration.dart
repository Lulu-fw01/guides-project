import 'package:flutter/material.dart';

import '../../../common/themes/main_theme.dart';

InputDecoration searchInputDecoration(
        MainTheme theme, bool isEmpty, void Function() onClearClick) =>
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
        suffixIcon: isEmpty
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

InputDecoration simpleSearchInputDecoration(MainTheme theme) => InputDecoration(
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
    filled: true,
    fillColor: theme.surface);
