import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/full_screen_error.dart';
import '../cubit/guide_view/guide_view_cubit.dart';

/// Screen for reading guide.
class GuideViewScreen extends StatelessWidget {
  const GuideViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuideViewCubit, GuideViewState>(
        builder: (context, state) {
      final theme = Provider.of<MainTheme>(context);

      if (state is GuideViewLoadingState) {
        // Loading state.
        return Center(
            child: CircularProgressIndicator(
          color: theme.onSurface,
        ));
      } else if (state is GuideViewErrorState) {
        return FullScreenError(
          // Error state.
          // TODO add refresh.
          onPressed: () => {},
          message: state.message,
        );
      }

      final guide = (state as GuideViewSuccessState).guide;
      final jsonDoc = jsonDecode(guide.content);
      final quillController = quill.QuillController(
        document: quill.Document.fromJson(jsonDoc),
        selection: const TextSelection.collapsed(offset: 0),
      );
      return Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 1, color: theme.onSurface.withOpacity(0.4))),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 8,
                  ),
                  quill.QuillEditor(
                    controller: quillController,
                    readOnly: true,
                    scrollController: ScrollController(),
                    scrollable: false,
                    focusNode: FocusNode(),
                    autoFocus: true,
                    expands: false,
                    padding: EdgeInsets.zero,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    enableSelectionToolbar: false,
                  ),
                  Container(
                    height: 8,
                  )
                ],
              ),
            )),
      );
    });
  }
}
