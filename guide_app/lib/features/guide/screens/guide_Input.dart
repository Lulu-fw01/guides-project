import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../cubit/guide_cubit.dart';
import '../widgets/tool_bar.dart';

/// Guide input screen.
class GuideInput extends StatelessWidget {
  GuideInput({super.key});
  final _quillController = quill.QuillController.basic();

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
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.secondaryContainer,
          actions: [_buildNextButton(guideCubit, theme)],
        ),
        floatingActionButton: ToolBar(quillController: _quillController),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 56),
                child: quill.QuillEditor.basic(
                    controller: _quillController, readOnly: false))),
      ),
    );
  }

  Widget _buildNextButton(GuideCubit guideCubit, MainTheme theme) {
    return TextButton(
        onPressed: () => onNextButtonClick(guideCubit),
        child: Text(
          'Дальше',
          style: TextStyle(color: theme.onSurface),
        ));
  }

  void onNextButtonClick(GuideCubit guideCubit) {
    guideCubit.createNewGuide(_quillController.document);
  }
}

// class GuideEditScreenState extends State<GuideEditScreen> {
//   final _fileDataController = TextEditingController();
//   final _quillController = quill.QuillController.basic();

//   @override
//   void initState() {
//     super.initState();
//     _fileDataController.addListener(() {
//       setState(() {
//         //data = _fileDataController.text;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _fileDataController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Provider.of<MainTheme>(context);
//     final guideCubit = Provider.of<GuideCubit>(context);
//     return BlocListener<GuideCubit, GuideState>(
//       listener: (context, state) {
//         if (state is GuideErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               duration: const Duration(seconds: 3),
//               content: Text(state.message)));
//         }
//         if (state is GuideLoadingState) {
//           // TODO implemet something for loading.
//         }
//         if (state is GuideSuccessState) {
//           Navigator.of(context).pop();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: theme.secondaryContainer,
//           actions: [_buildNextButton(guideCubit, theme)],
//         ),
//         floatingActionButton: _buildToolbarV1(theme),
//         backgroundColor: Colors.white,
//         body: SafeArea(
//             child: Padding(
//                 padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 56),
//                 child: quill.QuillEditor.basic(
//                     controller: _quillController, readOnly: false))),
//       ),
//     );
//   }

//   Widget _buildNextButton(GuideCubit guideCubit, MainTheme theme) {
//     return TextButton(
//         onPressed: () => onNextButtonClick(guideCubit),
//         child: Text(
//           'Дальше',
//           style: TextStyle(color: theme.onSurface),
//         ));
//   }

//   void onNextButtonClick(GuideCubit guideCubit) {
//     guideCubit.createNewGuide(_quillController.document);
//   }

//   Widget _buildGuideInput() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: _fileDataController,
//             scrollPadding: const EdgeInsets.all(20.0),
//             keyboardType: TextInputType.multiline,
//             maxLines: null,
//             autofocus: true,
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildToolbarV1(MainTheme theme) {
//     return quill.QuillToolbar.basic(
//       customButtons: const [
//         //quill.QuillCustomButton(icon: Icons.image)
//       ],
//       controller: _quillController,
//       iconTheme: quill.QuillIconTheme(
//           iconSelectedColor: theme.onSurface,
//           iconSelectedFillColor: Colors.white,
//           iconUnselectedFillColor: Colors.white),
//       dialogTheme: quill.QuillDialogTheme(
//         labelTextStyle: TextStyle(color: theme.onSurface),
//         inputTextStyle: TextStyle(color: theme.onSurface),
//       ),
//       showClearFormat: false,
//       showIndent: false,
//       showInlineCode: false,
//       showDividers: false,
//       showStrikeThrough: false,
//       showSearchButton: false,
//       showFontSize: false,
//       showFontFamily: false,
//       showRightAlignment: false,
//       showLeftAlignment: false,
//       showCenterAlignment: false,
//       showUnderLineButton: false,
//       showBackgroundColorButton: false,
//       showColorButton: false,
//       showListCheck: false,
//       showRedo: false,
//       showUndo: false,
//       showLink: false,
//     );
//   }

//   // TODO implement our more beautiful toolbar.
//   Widget _buildToolbarV2() {
//     return const quill.QuillToolbar(
//       children: [],
//     );
//   }
// }

/// First variant of guide edit screen.
  // Widget _buildMarkDownPage(GuideCubit guideCubit, MainTheme theme) {
  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: theme.secondaryContainer,
  //         actions: [_buildNextButton(guideCubit, theme)],
  //         bottom: TabBar(
  //           labelColor: theme.onSurface,
  //           indicatorColor: theme.onSurface,
  //           tabs: const [
  //             Tab(
  //               child: Text('Редактор'),
  //             ),
  //             Tab(
  //               child: Text('Превью'),
  //             )
  //           ],
  //         ),
  //       ),
  //       backgroundColor: Colors.white,
  //       body: SafeArea(
  //           child: Padding(
  //               padding: const EdgeInsets.all(16.0),
  //               child: TabBarView(
  //                 children: [_buildGuideInput(), Markdown(data: data)],
  //               ))),
  //     ),
  //   );
  // }
