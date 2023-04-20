import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';

import '../../../common/dto/guide_dto.dart';
import '../../../common/themes/main_theme.dart';
import '../cubit/guide_cubit.dart';
import '../widgets/tool_bar.dart';

/// Guide input screen.
class GuideInput extends StatelessWidget {
  GuideInput(
      {super.key, this.guideDto, this.onBackButtonClick, this.onSuccess}) {
    if (guideDto != null) {
      final jsonDoc = jsonDecode(guideDto!.content);
      _quillController = quill.QuillController(
        document: quill.Document.fromJson(jsonDoc),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _quillController = quill.QuillController.basic();
    }
  }
  final GuideDto? guideDto;
  late final quill.QuillController _quillController;
  final void Function()? onBackButtonClick;
  final void Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    final guideCubit = Provider.of<GuideCubit>(context);
    return BlocListener<GuideCubit, GuideState>(
      listener: (context, state) {
        if (state is GuideErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 3),
              content: Text(state.message)));
        }
        if (state is GuideLoadingState) {
          // TODO implemet something for loading.
        }
        if (state is GuideSuccessState) {
          if (onSuccess != null) {
            onSuccess!();
          } else {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: onBackButtonClick != null
              ? BackButton(
                  onPressed: () {
                    onBackButtonClick!();
                  },
                )
              : null,
          backgroundColor: Colors.white,
          actions: [
            guideDto == null
                ? _buildNextButton(guideCubit, theme)
                : _buildSaveButton(guideCubit, theme)
          ],
        ),
        floatingActionButton: ToolBar(quillController: _quillController),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1, color: theme.onSurface.withOpacity(0.4))),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 56),
              child: quill.QuillEditor.basic(
                  controller: _quillController, readOnly: false)),
        )),
      ),
    );
  }

  Widget _buildNextButton(GuideCubit guideCubit, MainTheme theme) {
    return TextButton(
        onPressed: () => _onNextButtonClick(guideCubit),
        child: Text(
          'Дальше',
          style: TextStyle(color: theme.onSurface),
        ));
  }

  Widget _buildSaveButton(GuideCubit guideCubit, MainTheme theme) {
    return TextButton(
        onPressed: () => _onSaveButtonClick(guideCubit),
        child: Text(
          'Сохранить',
          style: TextStyle(color: theme.onSurface),
        ));
  }

  void _onNextButtonClick(GuideCubit guideCubit) {
    guideCubit.createNewGuide(_quillController.document);
  }

  void _onSaveButtonClick(GuideCubit guideCubit) {
    guideCubit.updateGuide(guideDto!.id, _quillController.document);
  }
}
