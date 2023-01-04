import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/providers/view_provider.dart';
import 'package:guide_app/features/auth/widget/guide_logo.dart';
import 'package:guide_app/features/auth/widget/login.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 64, left: 64),
        child: ChangeNotifierProvider(
          create: (context) => ViewProvider(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDynamicGuideLogo(),
              const SizedBox(
                height: 64,
              ),
              Login()
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildDynamicGuideLogo() => Consumer<ViewProvider>(
        builder: (context, view, child) {
          return view.isInputView ? Container() : const GuideLogo();
        },
      );
}
