import 'package:flutter/material.dart';
import 'package:guide_app/features/auth/widget/guide_logo.dart';
import 'package:guide_app/features/auth/widget/login.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 64, left: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            GuideLogo(),
            SizedBox(height: 64,),
            Login()
          ],
        ),
      ),
    ));
  }
}
