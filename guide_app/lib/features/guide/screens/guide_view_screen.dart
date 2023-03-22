import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../../common/themes/main_theme.dart';
import '../../profile/widgets/full_screen_error.dart';
import '../cubit/guide_view/guide_view_cubit.dart';

/// Screen for reading guide.
class GuideViewScreen extends StatelessWidget {
  GuideViewScreen({super.key});

  // TODO refactoring.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuideViewCubit, GuideViewState>(
        listener: ((context, state) {
      if (state is GuideViewErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(state.message)));
      }
    }), builder: (context, state) {
      final theme = Provider.of<MainTheme>(context);

      if (state is GuideViewLoadingState) {
        return Center(
            child: CircularProgressIndicator(
          color: theme.onSurface,
        ));
      } else if (state is GuideViewSuccessState) {
        final jsonDoc = jsonDecode(state.guide.content);
        final quillController = quill.QuillController(
          document: quill.Document.fromJson(jsonDoc),
          selection: const TextSelection.collapsed(offset: 0),
        );
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 56),
          // TODO remove cursor.
          child: quill.QuillEditor.basic(
              controller: quillController, readOnly: true),
        );
      } else if (state is GuideViewErrorState) {
        return FullScreenError(
          // TODO add refresh.
          onPressed: () => {},
          message: state.message,
        );
      }
      return Container();
    });
  }
}
