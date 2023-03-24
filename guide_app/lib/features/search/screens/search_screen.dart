import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../widgets/search_input_decoration.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final _searchTextController = TextEditingController();

  void _clearSearchInput() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<MainTheme>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchInput(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchInput(MainTheme theme) => TextField(
        onChanged: (text) {
          setState(() {});
        },
        controller: _searchTextController,
        cursorColor: theme.onSurface,
        style: TextStyle(color: theme.onSurface),
        decoration: searchInputDecoration(
            theme, _searchTextController, _clearSearchInput),
      );

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}
