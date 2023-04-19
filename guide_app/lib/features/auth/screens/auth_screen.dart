import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/repository/credentials_repository.dart';
import '../../../common/themes/main_theme.dart';
import '../../../cubit/init_cubit.dart';
import '../client/auth_client.dart';
import '../cubit/auth_cubit.dart';
import '../repository/auth_repository.dart';
import '../widget/dynamic_guide_logo.dart';
import '../widget/login.dart';
import '../widget/sign_up.dart';

/// Screen for user authorization.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _inputView = false;
  bool _isSignUp = true;

  /// Time of guide logo animation i milliseconds.
  static const _animationTime = 500;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: _animationTime),
      reverseDuration: const Duration(milliseconds: _animationTime),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    final initCubit = Provider.of<InitCubit>(context);
    final theme = Provider.of<MainTheme>(context);
    final credentialsRepo = CredentialsRepository();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, right: 64, left: 64),
            child: BlocProvider(
                create: (context) => AuthCubit(
                    AuthRepository(AuthClient()),
                    (email, token) => _onSuccessAuth(
                        initCubit, credentialsRepo, email, token)),
                child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                  if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(state.errorMessage)));
                  }
                }, builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.onSurface,
                      ),
                    );
                  }
                  return _buildBody();
                })),
          ),
        ));
  }

  Widget _buildBody() => _isSignUp ? _buildSignUp() : _buildLogin();

  Widget _buildLogin() => Column(
        children: [
          const DynamicGuideLogo(),
          Login(
            onSignUpClicked: () => setState(() {
              _isSignUp = true;
            }),
          )
        ],
      );

  // TODO wrap with listView, maybe do something with center widget in build method.
  Widget _buildSignUp() => Column(
        children: [
          const DynamicGuideLogo(),
          SignUp(
            onLoginClicked: () => setState(() {
              _isSignUp = false;
            }),
          )
        ],
      );

  void _onSuccessAuth(InitCubit initCubit,
      CredentialsRepository credentialsRepository, String email, String token) {
    credentialsRepository.saveEmail(email);
    credentialsRepository.saveToken(token);
    initCubit.login(email, token);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
