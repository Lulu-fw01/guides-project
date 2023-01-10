import 'package:flutter/material.dart';
import 'package:guide_app/common/themes/main_theme.dart';

Widget buildInput(MainTheme theme, FocusNode focusNode, String hint,
        {TextInputType? keyboardType,
        TextEditingController? controller,
        String? Function(String?)? validator,
        bool obscureText = false,
        bool enableSuggestions = true,
        bool autoCorrect = true}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      focusNode: focusNode,
      keyboardType: keyboardType,
      style: TextStyle(color: theme.onSurface),
      cursorColor: theme.onSurface,
      decoration: buildInputDecoration(theme, hint),
      //textInputAction: Platform.isIOS ? TextInputAction.continueAction : null,
    );

/// Decoration for every TextField in auth screen.
InputDecoration buildInputDecoration(MainTheme theme, String hint) =>
    InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.onSurface)),
        suffixStyle: TextStyle(color: theme.onSurface),
        hintText: hint,
        hintStyle: TextStyle(color: theme.onSurfaceVariant));
