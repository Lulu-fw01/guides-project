import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/themes/main_theme.dart';
import '../cubit/auth_cubit.dart';
import 'input_field.dart';

/// Sign up form.
class SignUp extends StatefulWidget {
  const SignUp({super.key, this.onLoginClicked});

  final void Function()? onLoginClicked;

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

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
            "Регистрация",
          ),
          const SizedBox(
            height: 8,
          ),
          _buildEmailInput(theme),
          const SizedBox(
            height: 8,
          ),
          _buildLoginInput(theme),
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
          _buildSignUpButton(theme, authCubit),
          const SizedBox(
            height: 8,
          ),
          _buildLoginButton(authCubit, theme)
        ],
      ),
    );
  }

  /// Name input.
  Widget _buildNameInput(MainTheme theme) {
    return buildInput(theme, 'Имя', keyboardType: TextInputType.name,
        validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь";
      }
      if (value.contains(RegExp(r'^[A-Za-z0-9_.]+$'))) {}
      return null;
    });
  }

  /// Login input.
  Widget _buildLoginInput(MainTheme theme) {
    return buildInput(theme, 'Логин', keyboardType: TextInputType.name,
        validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь.";
      }
      if (!RegExp(r"^[a-z0-9._-]*$").hasMatch(value)) {
        return "Логин может содержать прописные латинские буквы, цифры и символы - _ .";
      }
      return null;
    }, controller: _loginController);
  }

  Widget _buildEmailInput(MainTheme theme) {
    return buildInput(theme, 'Email', keyboardType: TextInputType.emailAddress,
        validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь.";
      }
      return null;
    }, controller: _emailController);
  }

  /// Password input text field.
  Widget _buildPasswordInput(MainTheme theme) {
    return buildInput(theme, 'Пароль',
        obscureText: true,
        enableSuggestions: false,
        autoCorrect: false, validator: (value) {
      // TODO add more.
      if (value == null || value == "") {
        return "Введите что-нибудь.";
      }
      if (value.length < 8) {
        return "Длина пароля должна быть не меньше 8 символов.";
      }
      if (!RegExp(r"^[a-zA-Z0-9@$*#_-]*$").hasMatch(value)) {
        return "Пароль может содержать латинские буквы, цифры и символы @ \$ * # _ -";
      }
      return null;
    }, controller: _passwordController);
  }

  Widget _buildRepeatPasswordInput(MainTheme theme) {
    return buildInput(theme, 'Пароль еще раз',
        obscureText: true,
        enableSuggestions: false,
        autoCorrect: false, validator: (value) {
      // TODO add more.
      if (value == null || value == "") {
        return "Введите что-нибудь.";
      }
      if (value != _passwordController.text) {
        return "Пароли не совпадают.";
      }
      return null;
    }, controller: _password2Controller);
  }

  /// Login button.
  Widget _buildSignUpButton(MainTheme theme, AuthCubit authCubit) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(left: 24, right: 24),
              backgroundColor: theme.onSurface,
              textStyle: const TextStyle(fontSize: 14)),
          onPressed: () => _onSignUpButtonClick(authCubit),
          child: const Text(
            'Зарегистрироваться',
          ));

  /// TextButton, after click go to sign up screen.
  Widget _buildLoginButton(AuthCubit authCubit, MainTheme theme) => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: theme.onSurface,
          padding: const EdgeInsets.only(left: 12, right: 12),
        ),
        onPressed: widget.onLoginClicked,
        child: Text(
          'Войти',
          style: TextStyle(color: theme.onSurface),
        ),
      );

  void _onSignUpButtonClick(AuthCubit authCubit) {
    if (_formKey.currentState!.validate()) {
      debugPrint('signup clicked');
      authCubit.signUp(_loginController.text, _emailController.text,
          _passwordController.text);
    }
  }
}
