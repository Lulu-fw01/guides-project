import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import 'search_input_decoration.dart';

/// Search input.
class SearchInput extends StatefulWidget {
  const SearchInput({required this.onTextChanged, super.key});
  final void Function(String) onTextChanged;

  @override
  SearchInputState createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  final _searchTextController = TextEditingController();

  void _clearSearchInput() {
    // TODO update state in provider.
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<MainTheme>(context);

    return TextField(
      onChanged: (text) {
        widget.onTextChanged(text);
      },
      controller: _searchTextController,
      cursorColor: theme.onSurface,
      style: TextStyle(color: theme.onSurface),
      decoration: searchInputDecoration(
          theme, _searchTextController, _clearSearchInput),
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}
