import 'package:flutter/material.dart';

import '../widgets/core.dart';
import '../widgets/core_settings.dart';

/// Main component of the app with navigation bottom bar.
/// This widget contains all main repositories, provider, BLoCs.
class MainCore extends StatelessWidget {
  const MainCore({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoreSettings(child: Core());
  }
}
