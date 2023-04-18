import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/user_credentials.dart';
import '../../guide/screens/guide_update_screen.dart';
import '../../main/screens/main_scaffold.dart';
import '../provider/core_provider.dart';

/// This is widget that controlling
/// current screen of the app.
class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(builder: (context, coreProvider, child) {
      switch (coreProvider.currentMode) {
        case CoreMode.main:
          return const MainScaffold();
        case CoreMode.updatingGuide:
          final credentials = UserCredentials.of(context);
          return GuideUpdateScreen(
              email: credentials.email,
              token: credentials.token,
              guideId: coreProvider.guideToUpdateId!);
      }
    });
  }
}
