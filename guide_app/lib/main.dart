import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/repository/token_repository.dart';
import 'package:guide_app/features/main/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/cubit/init_cubit.dart';
import 'package:guide_app/features/auth/screens/auth_screen.dart';

String? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final tokenRepository = TokenRepository();

  // TODO remove later.
  tokenRepository.removeToken();

  token = await tokenRepository.getToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appTheme = MainTheme();
    return MaterialApp(
        theme: appTheme.lightTheme,
        home: Provider<MainTheme>.value(
          value: appTheme,
          child: BlocProvider(
            create: (BuildContext context) => InitCubit(token != null),
            child: BlocBuilder<InitCubit, InitState>(builder: (context, state) {
              /*if (state is InitLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }*/
              if (state is InitAuthorized) {
                return MainScreen();
              }
              return AuthScreen();
            }),
          ),
        ));
  }
}
