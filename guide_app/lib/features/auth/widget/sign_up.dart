import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/cubit/auth_cubit.dart';
import 'package:guide_app/features/auth/mixin/view_dependency.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_app/common/themes/main_theme.dart';

import 'input_field.dart';

/// Sign up form.
class SignUp extends StatelessWidget with ViewDependency {
  SignUp({super.key, this.onViewChange});

  @override
  final void Function(bool inputView)? onViewChange;

  final _loginFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _repeatPasswordFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<MainTheme>(context);
    final authCubit = Provider.of<AuthCubit>(context);

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
        _buildNameInput(theme),
        const SizedBox(
          height: 8,
        ),
        _buildLoginInput(theme),
        const SizedBox(
          height: 8,
        ),
        _buildEmailInput(theme),
        const SizedBox(
          height: 8,
        ),
        _buildPasswordInput(theme),
        const SizedBox(
          height: 8,
        ),
        _buildRepeatPasswordInput(theme),
        const SizedBox(
          height: 32,
        ),
        _buildSignUpButton(theme),
        const SizedBox(
          height: 8,
        ),
        _buildLoginButton(authCubit, theme)
      ],
    );
  }

  /// Name input.
  Widget _buildNameInput(MainTheme theme) {
    addOnViewChange(_nameFocus);
    return buildInput(theme, _nameFocus, 'Имя',
        keyboardType: TextInputType.name);
  }

  /// Login input.
  Widget _buildLoginInput(MainTheme theme) {
    addOnViewChange(_loginFocus);
    return buildInput(theme, _loginFocus, 'Логин',
        keyboardType: TextInputType.name);
  }

  Widget _buildEmailInput(MainTheme theme) {
    addOnViewChange(_emailFocus);
    return buildInput(theme, _emailFocus, 'Email',
        keyboardType: TextInputType.emailAddress);
  }

  /// Password input text field.
  Widget _buildPasswordInput(MainTheme theme) {
    addOnViewChange(_passwordFocus);
    return buildInput(theme, _passwordFocus, 'Пароль',
        obscureText: true, enableSuggestions: false, autoCorrect: false);
  }

  Widget _buildRepeatPasswordInput(MainTheme theme) {
    addOnViewChange(_repeatPasswordFocus);
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
      child: const Text(
        'Зарегистрироваться',
      ));

  /// TextButton, after click go to sign up screen.
  Widget _buildLoginButton(AuthCubit authCubit, MainTheme theme) => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: theme.onSurface,
          padding: const EdgeInsets.only(left: 12, right: 12),
        ),
        child: Text(
          'Войти',
          style: TextStyle(color: theme.onSurface),
        ),
        onPressed: () {
          authCubit.goToLogin();
        },
      );
}
