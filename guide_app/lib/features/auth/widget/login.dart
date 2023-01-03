import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_app/common/themes/main_theme.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<MainTheme>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          style: GoogleFonts.lato(
              color: theme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.w500),
          "Вход",
        ),
        const SizedBox(
          height: 8,
        ),
        _buildLoginInput(theme),
        const SizedBox(
          height: 8,
        ),
        _buildPasswordInput(theme),
        const SizedBox(
          height: 32,
        ),
        _buildLoginButton(theme),
        const SizedBox(
          height: 8,
        ),
        _buildSignUpButton(theme)
      ],
    );
  }

  Widget _buildLoginInput(MainTheme theme) => TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: theme.onSurface),
        cursorColor: theme.onSurface,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: theme.onSurface)),
            suffixStyle: TextStyle(color: theme.onSurface),
            hintText: 'Почта или логин',
            hintStyle: TextStyle(color: theme.onSurfaceVariant)),
        textInputAction: Platform.isIOS ? TextInputAction.continueAction : null,
      );

  /// Password input text field
  Widget _buildPasswordInput(MainTheme theme) => TextField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: theme.onSurface),
        cursorColor: theme.onSurface,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: theme.onSurface)),
            suffixStyle: TextStyle(color: theme.onSurface),
            hintText: 'Пароль',
            hintStyle: TextStyle(color: theme.onSurfaceVariant)),
        textInputAction: Platform.isIOS ? TextInputAction.continueAction : null,
      );

  /// Login button.
  Widget _buildLoginButton(MainTheme theme) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 24, right: 24),
          backgroundColor: theme.onSurface,
          textStyle: const TextStyle(fontSize: 14)),
      onPressed: () {},
      child: const Text('Войти'));

  /// TextButton, after click go to sign up screen.
  Widget _buildSignUpButton(MainTheme theme) => TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 12, right: 12),
        ),
        child: Text(
          'Зарегистрироваться',
          style: TextStyle(color: theme.onSurface),
        ),
        onPressed: () {},
      );
}
