import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';

/// Widget that display error message
/// with try again button.
/// TODO maybe move to common later.
class FullScreenError extends StatelessWidget {
  const FullScreenError(
      {super.key, required this.onPressed, this.message = ""});
  final String message;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.informationText,
          ),
        ],
      ),
    );
  }
}
