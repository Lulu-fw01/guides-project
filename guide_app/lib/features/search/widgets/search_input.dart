import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../bloc/search_bloc.dart';
import '../provider/search_provider.dart';
import 'search_input_decoration.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

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
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);

    return Focus(
      onFocusChange: (value) {
        if (value) {
          searchProvider.searchStarted();
        } else {
          // TODO no search but check that search result is clear.
        }
      },
      child: TextField(
        onChanged: (text) {
          setState(() {
            // TODO uncomment.
            // TODO check if input is clear.
            // Provider.of<SearchBloc>(context)
            //     .add(SearchGuidesByTitleEvent(searchPhrase: text, pageNum: 0));
          });
        },
        controller: _searchTextController,
        cursorColor: theme.onSurface,
        style: TextStyle(color: theme.onSurface),
        decoration: searchInputDecoration(
            theme, _searchTextController, _clearSearchInput),
      ),
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}
