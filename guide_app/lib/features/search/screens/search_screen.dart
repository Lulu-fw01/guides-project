import 'package:flutter/material.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:provider/provider.dart';

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
        decoration: _searchFieldDecoration(theme),
      );

  InputDecoration _searchFieldDecoration(MainTheme theme) => InputDecoration(
      hintText: 'Поиск',
      hintStyle: TextStyle(color: theme.onSurfaceVariant),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.surface),
          borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.surface),
          borderRadius: BorderRadius.circular(16)),
      prefixIcon: Icon(
        Icons.search,
        color: theme.onSurfaceVariant,
      ),
      suffixIcon: _searchTextController.text.isEmpty
          ? null
          : IconButton(
              icon: Icon(
                Icons.clear,
                color: theme.onSurfaceVariant,
              ),
              onPressed: _clearSearchInput,
            ),
      filled: true,
      fillColor: theme.surface);

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}
