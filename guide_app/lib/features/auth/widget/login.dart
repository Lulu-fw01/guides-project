import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/cubit/auth_cubit.dart';
import 'package:guide_app/features/auth/widget/input_field.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_app/common/themes/main_theme.dart';

class Login extends StatelessWidget {
  Login({super.key, this.onViewChange});

  final void Function(bool inputView)? onViewChange;

  final FocusNode _loginFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
        _buildSignUpButton(authCubit, theme)
      ],
    );
  }

  /// Email or login input
  Widget _buildLoginInput(MainTheme theme) {
    if (onViewChange != null) {
      _loginFocus.addListener(() => onViewChange!(_loginFocus.hasFocus));
    }
    return buildInput(theme, _loginFocus, 'Почта или логин',
        keyboardType: TextInputType.emailAddress);
  }

  /// Password input text field.
  Widget _buildPasswordInput(MainTheme theme) {
    if (onViewChange != null) {
      _passwordFocus
          .addListener((() => onViewChange!(_passwordFocus.hasFocus)));
    }
    return buildInput(theme, _passwordFocus, 'Пароль',
        obscureText: true, enableSuggestions: false, autoCorrect: false);
  }

  /// Login button.
  Widget _buildLoginButton(MainTheme theme) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 24, right: 24),
          backgroundColor: theme.onSurface,
          textStyle: const TextStyle(fontSize: 14)),
      onPressed: () {},
      child: const Text('Войти'));

  /// TextButton, after click go to sign up screen.
  Widget _buildSignUpButton(AuthCubit authCubit, MainTheme theme) => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: theme.onSurface,
          padding: const EdgeInsets.only(left: 12, right: 12),
        ),
        child: Text(
          'Зарегистрироваться',
          style: TextStyle(color: theme.onSurface),
        ),
        onPressed: () {
          authCubit.goToSignUp();
        },
      );
}
