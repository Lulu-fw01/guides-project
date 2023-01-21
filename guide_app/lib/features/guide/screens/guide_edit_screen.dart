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
  final _fileDataController = TextEditingController();
  String data = '';

  @override
  void initState() {
    super.initState();
    _fileDataController.addListener(() {
      setState(() {
        data = _fileDataController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fileDataController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.secondaryContainer,
          actions: [_buildNextButton(theme)],
          bottom: TabBar(
            labelColor: theme.onSurface,
            indicatorColor: theme.onSurface,
            tabs: const [
              Tab(
                child: Text('Редактор'),
              ),
              Tab(
                child: Text('Превью'),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(
                  children: [_buildGuideInput(), Markdown(data: data)],
                ))),
      ),
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

  Widget _buildGuideInput() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _fileDataController,
            scrollPadding: const EdgeInsets.all(20.0),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
          )
        ],
      ),
    );
  }
}
