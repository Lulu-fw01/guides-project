import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../../common/themes/main_theme.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key, required this.quillController});
  final quill.QuillController quillController;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);

    return quill.QuillToolbar.basic(
      customButtons: const [
        //quill.QuillCustomButton(icon: Icons.image)
      ],
      controller: quillController,
      iconTheme: quill.QuillIconTheme(
          iconSelectedColor: theme.onSurface,
          iconSelectedFillColor: Colors.white,
          iconUnselectedFillColor: Colors.white),
      dialogTheme: quill.QuillDialogTheme(
        labelTextStyle: TextStyle(color: theme.onSurface),
        inputTextStyle: TextStyle(color: theme.onSurface),
      ),
      showClearFormat: false,
      showIndent: false,
      showInlineCode: false,
      showDividers: false,
      showStrikeThrough: false,
      showSearchButton: false,
      showFontSize: false,
      showFontFamily: false,
      showRightAlignment: false,
      showLeftAlignment: false,
      showCenterAlignment: false,
      showUnderLineButton: false,
      showBackgroundColorButton: false,
      showColorButton: false,
      showListCheck: false,
      showRedo: false,
      showUndo: false,
      showLink: false,
    );
  }
}
