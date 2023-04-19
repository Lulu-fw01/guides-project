import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/themes/main_theme.dart';
import '../cubit/auth_cubit.dart';
import 'input_field.dart';

/// Login form.
class Login extends StatelessWidget {
  Login({super.key, this.onSignUpClicked});

  final void Function()? onSignUpClicked;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<MainTheme>(context);
    final authCubit = Provider.of<AuthCubit>(context);

    return Form(
      key: _formKey,
      child: Column(
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
          _buildLoginButton(theme, authCubit),
          const SizedBox(
            height: 8,
          ),
          _buildSignUpButton(authCubit, theme)
        ],
      ),
    );
  }

  /// Email or login input
  Widget _buildLoginInput(MainTheme theme) {
    return buildInput(theme, 'Почта или логин',
        keyboardType: TextInputType.emailAddress,
        controller: _emailController, validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь";
      }
      return null;
    });
  }

  /// Password input text field.
  Widget _buildPasswordInput(MainTheme theme) {
    return buildInput(theme, 'Пароль',
        obscureText: true,
        enableSuggestions: false,
        autoCorrect: false,
        controller: _passwordController, validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь";
      }
      return null;
    });
  }

  /// Login button.
  Widget _buildLoginButton(MainTheme theme, AuthCubit authCubit) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(left: 24, right: 24),
              backgroundColor: theme.onSurface,
              textStyle: const TextStyle(fontSize: 14)),
          onPressed: () => _onLoginButtonClick(authCubit),
          child: const Text('Войти'));

  void _onLoginButtonClick(AuthCubit authCubit) {
    if (_formKey.currentState!.validate()) {
      debugPrint('signup clicked');
      authCubit.signIn(_emailController.text, _passwordController.text);
    }
  }

  /// TextButton, after click go to sign up screen.
  Widget _buildSignUpButton(AuthCubit authCubit, MainTheme theme) => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: theme.onSurface,
          padding: const EdgeInsets.only(left: 12, right: 12),
        ),
        onPressed: onSignUpClicked,
        child: Text(
          'Зарегистрироваться',
          style: TextStyle(color: theme.onSurface),
        ),
      );
}
