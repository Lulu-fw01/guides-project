import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/cubit/auth_cubit.dart';
import 'package:guide_app/features/auth/mixin/view_dependency.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_app/common/themes/main_theme.dart';

import 'input_field.dart';

/// Sign up form.
class SignUp extends StatefulWidget {
  const SignUp({super.key, this.onViewChange});

  final void Function(bool inputView)? onViewChange;

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> with ViewDependency {
  @override
  void Function(bool inputView)? get onViewChange => widget.onViewChange;

  final _loginFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _repeatPasswordFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
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
    addOnViewChange(_nameFocus);
    return buildInput(theme, _nameFocus, 'Имя',
        keyboardType: TextInputType.name, validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь";
      }
      return null;
    });
  }

  /// Login input.
  Widget _buildLoginInput(MainTheme theme) {
    addOnViewChange(_loginFocus);
    return buildInput(theme, _loginFocus, 'Логин',
        keyboardType: TextInputType.name, validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь";
      }
      return null;
    });
  }

  Widget _buildEmailInput(MainTheme theme) {
    addOnViewChange(_emailFocus);
    return buildInput(theme, _emailFocus, 'Email',
        keyboardType: TextInputType.emailAddress, validator: (value) {
      if (value == null || value == "") {
        return "Введите что-нибудь";
      }
      return null;
    }, controller: _emailController);
  }

  /// Password input text field.
  Widget _buildPasswordInput(MainTheme theme) {
    addOnViewChange(_passwordFocus);
    return buildInput(theme, _passwordFocus, 'Пароль',
        obscureText: true,
        enableSuggestions: false,
        autoCorrect: false, validator: (value) {
      // TODO add more.
      if (value == null || value == "") {
        return "Введите что-нибудь";
      }
      return null;
    }, controller: _passwordController);
  }

  Widget _buildRepeatPasswordInput(MainTheme theme) {
    addOnViewChange(_repeatPasswordFocus);
    return buildInput(theme, _repeatPasswordFocus, 'Пароль еще раз',
        obscureText: true,
        enableSuggestions: false,
        autoCorrect: false, validator: (value) {
      // TODO add more.
      if (value == null || value == "") {
        return "Введите что-нибудь";
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
        onPressed: authCubit.goToLogin,
        child: Text(
          'Войти',
          style: TextStyle(color: theme.onSurface),
        ),
      );

  void _onSignUpButtonClick(AuthCubit authCubit) {
    if (_formKey.currentState!.validate()) {
      debugPrint('signup clicked');
      authCubit.signUp(_emailController.text, _passwordController.text);
    }
  }
}
