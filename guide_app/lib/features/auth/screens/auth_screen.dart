import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/providers/view_provider.dart';
import 'package:guide_app/features/auth/widget/guide_logo.dart';
import 'package:guide_app/features/auth/widget/login.dart';
import 'package:guide_app/features/auth/widget/sign_up.dart';
import 'package:provider/provider.dart';

/// Screen for user authorization.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _inputView = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: 500),
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
        _controller.animateBack(0, duration: const Duration(milliseconds: 300));
      }
      return;
    }
    if (_inputView) {
      debugPrint('Second back');
      _controller.animateBack(0, duration: const Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, right: 64, left: 64),
          child: ChangeNotifierProvider(
            create: (context) => ViewProvider(),
            child: _buildLogin(),
          ),
        ),
      ),
    ));
  }

  Widget _buildLogin() => Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [_buildDynamicGuideLogo(), Login(onViewChange: _viewChange,)],
      );

  Widget _buildSignUp() => Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildDynamicGuideLogo(), SignUp()],
      );

  Widget _buildDynamicGuideLogo() {
    return Consumer<ViewProvider>(
      builder: (context, view, child) {
        return SizeTransition(
          sizeFactor: _animation,
          axis: Axis.vertical,
          child: Center(
            child: Column(
              children: const [
                SizedBox(height: 8,),
                GuideLogo(),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
