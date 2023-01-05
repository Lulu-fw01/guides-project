import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/providers/view_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_app/common/themes/main_theme.dart';

import 'input_field.dart';

/// Sign up form.
class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _loginFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _repeatPasswordFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var viewProvider = Provider.of<ViewProvider>(context);
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
          "Регистрация",
        ),
        const SizedBox(
          height: 8,
        ),
        _buildNameInput(viewProvider, theme),
        const SizedBox(
          height: 8,
        ),
        _buildLoginInput(viewProvider, theme),
        const SizedBox(
          height: 8,
        ),
        _buildEmailInput(viewProvider, theme),
        const SizedBox(
          height: 8,
        ),
        _buildPasswordInput(viewProvider, theme),
        const SizedBox(
          height: 8,
        ),
        _buildRepeatPasswordInput(viewProvider, theme),
        const SizedBox(
          height: 32,
        ),
        _buildSignUpButton(theme),
        const SizedBox(
          height: 8,
        ),
        _buildLoginButton(theme)
      ],
    );
  }

  /// Name input.
  Widget _buildNameInput(ViewProvider provider, MainTheme theme) {
    _nameFocus.addListener(() => provider.isInputView = _nameFocus.hasFocus);
    return buildInput(theme, _nameFocus, 'Имя',
        keyboardType: TextInputType.name);
  }

  /// Login input.
  Widget _buildLoginInput(ViewProvider provider, MainTheme theme) {
    _loginFocus.addListener(() => provider.isInputView = _loginFocus.hasFocus);
    return buildInput(theme, _loginFocus, 'Логин',
        keyboardType: TextInputType.name);
  }

  Widget _buildEmailInput(ViewProvider provider, MainTheme theme) {
    _emailFocus.addListener(() => provider.isInputView = _emailFocus.hasFocus);
    return buildInput(theme, _emailFocus, 'Email',
        keyboardType: TextInputType.emailAddress);
  }

  /// Password input text field.
  Widget _buildPasswordInput(ViewProvider provider, MainTheme theme) {
    _passwordFocus
        .addListener((() => provider.isInputView = _passwordFocus.hasFocus));
    return buildInput(theme, _passwordFocus, 'Пароль',
        obscureText: true, enableSuggestions: false, autoCorrect: false);
  }

  Widget _buildRepeatPasswordInput(ViewProvider provider, MainTheme theme) {
    _repeatPasswordFocus.addListener(
        (() => provider.isInputView = _repeatPasswordFocus.hasFocus));
    return buildInput(theme, _repeatPasswordFocus, 'Пароль еще раз',
        obscureText: true, enableSuggestions: false, autoCorrect: false);
  }

  /// Login button.
  Widget _buildSignUpButton(MainTheme theme) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 24, right: 24),
          backgroundColor: theme.onSurface,
          textStyle: const TextStyle(fontSize: 14)),
      onPressed: () {},
      child: const Text('Зарегистрироваться'));

  /// TextButton, after click go to sign up screen.
  Widget _buildLoginButton(MainTheme theme) => TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 12, right: 12),
        ),
        child: Text(
          'Войти',
          style: TextStyle(color: theme.onSurface),
        ),
        onPressed: () {},
      );
}
