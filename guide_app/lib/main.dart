import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'common/repository/credentials_repository.dart';
import 'common/themes/main_theme.dart';
import 'common/widgets/user_credentials.dart';
import 'cubit/init_cubit.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/main_core/screens/main_core.dart';

String? token;
String? email;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print(
          '${record.level.name}: ${record.time}: [${record.loggerName}]: ${record.message}');
    }
  });

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
                    child: const MainCore());
              }
              return const AuthScreen();
            }),
          ),
        ));
  }
}
