import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/cubit/init_cubit.dart';
import 'package:guide_app/features/auth/client/auth_client.dart';
import 'package:guide_app/features/auth/cubit/auth_cubit.dart';
import 'package:guide_app/features/auth/repository/auth_repository.dart';
import 'package:guide_app/features/auth/widget/guide_logo.dart';
import 'package:guide_app/features/auth/widget/login.dart';
import 'package:guide_app/features/auth/widget/sign_up.dart';
import 'package:provider/provider.dart';

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

  void _viewChange(bool inputView) {
    debugPrint('inp: $inputView');
    if (_inputView != inputView) {
      _inputView = inputView;
      if (!_inputView) {
        debugPrint('foreward');
        _controller.forward();
      } else {
        debugPrint("back");
        _controller.reverse(from: 1);
      }
      return;
    }
    if (_inputView) {
      debugPrint('Second back');
      _controller.reverse(from: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final initCubit = Provider.of<InitCubit>(context);
    final theme = Provider.of<MainTheme>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, right: 64, left: 64),
            child: BlocProvider(
                create: (context) =>
                    AuthCubit(AuthRepository(AuthClient()), () {
                      initCubit.login();
                    }),
                child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                  if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(duration: const Duration(seconds: 3),  content: Text(state.errorMessage)));
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
          _buildDynamicGuideLogo(),
          Login(
            onViewChange: _viewChange,
            onSignUpClicked: () => setState(() {
              _isSignUp = true;
            }),
          )
        ],
      );

  // TODO wrap with listView, maybe do something with center widget in build method.
  Widget _buildSignUp() => Column(
        children: [
          _buildDynamicGuideLogo(),
          SignUp(
            onViewChange: _viewChange,
            onLoginClicked: () => setState(() {
              _isSignUp = false;
            }),
          )
        ],
      );

  Widget _buildDynamicGuideLogo() => SizeTransition(
        sizeFactor: _animation,
        axis: Axis.vertical,
        child: Center(
          child: Column(
            children: const [
              SizedBox(
                height: 8,
              ),
              GuideLogo(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      );

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
