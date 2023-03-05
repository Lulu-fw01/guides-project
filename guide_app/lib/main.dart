import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/repository/credentials_repository.dart';
import 'package:guide_app/common/widgets/user_credentials.dart';
import 'package:guide_app/features/main/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/cubit/init_cubit.dart';
import 'package:guide_app/features/auth/screens/auth_screen.dart';

String? token;
String? email;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = CredentialsRepository();

  token = await repo.getToken();
  email = await repo.getEmail();

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
            create: (BuildContext context) => InitCubit(email, token),
            child: BlocBuilder<InitCubit, InitState>(builder: (context, state) {
              if (state is InitAuthorized) {
                return UserCredentials(
                    email: state.email,
                    token: state.token,
                    child: const MainScreen());
              }
              return const AuthScreen();
            }),
          ),
        ));
  }
}
