import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/providers/view_provider.dart';
import 'package:guide_app/features/auth/widget/guide_logo.dart';
import 'package:guide_app/features/auth/widget/login.dart';
import 'package:guide_app/features/auth/widget/sign_up.dart';
import 'package:provider/provider.dart';

/// Screen for user authorization.
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 56, right: 64, left: 64),
        child: ChangeNotifierProvider(
          create: (context) => ViewProvider(),
          child: _buildLogin(),
        ),
      ),
    ));
  }

  Widget _buildLogin() => Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildDynamicGuideLogo(),
          Login()
        ],
      );

  Widget _buildSignUp() => Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildDynamicGuideLogo(), SignUp()],
      );

  Widget _buildDynamicGuideLogo() => Consumer<ViewProvider>(
        builder: (context, view, child) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: view.isInputView
                  ? Container()
                  : Column(
                      children: [
                        const GuideLogo(),
                        SizedBox(
                          height: view.isInputView ? 0 : 16,
                        ),
                      ],
                    ));
        },
      );
}
