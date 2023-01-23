import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/features/auth/client/auth_client.dart';
import 'package:guide_app/features/auth/cubit/auth_cubit.dart';
import 'package:guide_app/features/auth/repository/auth_repository.dart';
import 'package:guide_app/features/auth/widget/guide_logo.dart';
import 'package:guide_app/features/auth/widget/login.dart';
import 'package:guide_app/features/auth/widget/sign_up.dart';

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
    // TODO Add bloc listener.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, right: 64, left: 64),
            child: BlocProvider(
                create: (context) =>
                    AuthCubit(AuthRepository(AuthClient()), () {}),
                child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                  if (state is AuthLoginState) {
                    return _buildLogin();
                  }
                  if (state is AuthSignUpState) {
                    return _buildSignUp();
                  }
                  return const CircularProgressIndicator();
                })),
          ),
        ));
  }

  Widget _buildLogin() => Column(
        children: [
          _buildDynamicGuideLogo(),
          Login(
            onViewChange: _viewChange,
          )
        ],
      );

  // TODO wrap with listView, maybe do something with center widget in build method.
  Widget _buildSignUp() => Column(
        children: [
          _buildDynamicGuideLogo(),
          SignUp(
            onViewChange: _viewChange,
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
