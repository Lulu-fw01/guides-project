import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:provider/provider.dart';

class GuideEditScreen extends StatefulWidget {
  const GuideEditScreen({super.key});

  @override
  GuideEditScreenState createState() => GuideEditScreenState();
}

class GuideEditScreenState extends State<GuideEditScreen> {

  bool _isPreview = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryContainer,
        actions: [_buildNextButton(theme)],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isPreview ? Markdown(data: '',) : TextField(),
      )),
    );
  }

  Widget _buildNextButton(MainTheme theme) {
    return TextButton(
        onPressed: () {},
        child: Text(
          'Дальше',
          style: TextStyle(color: theme.onSurface),
        ));
  }
}
