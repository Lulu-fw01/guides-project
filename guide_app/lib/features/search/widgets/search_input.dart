import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import 'search_input_decoration.dart';

/// Search input.
class SearchInput extends StatelessWidget {
  const SearchInput({super.key, required this.onTextChange});
  final void Function(String) onTextChange;

  @override
  Widget build(BuildContext context) {
    // TODO maybe need later.
    // final searchInputProvider =
    //     Provider.of<SearchInputProvider>(context, listen: false)
    final textController = TextEditingController();
    var theme = Provider.of<MainTheme>(context);

    return TextField(
      controller: textController,
      onChanged: ((value) {
        onTextChange(value);
      }),
      cursorColor: theme.onSurface,
      style: TextStyle(color: theme.onSurface),
      decoration: simpleSearchInputDecoration(theme),
    );
  }
}

// TODO maybe this will be later.
/// Search input.
// class SearchInput extends StatefulWidget {
//   const SearchInput({super.key, required this.onTextChange});
//   final void Function(String) onTextChange;

//   @override
//   SearchInputState createState() => SearchInputState();
// }

// class SearchInputState extends State<SearchInput> {
//   final _searchTextController = TextEditingController();

//   void _clearSearchInput() {
//     setState(() {
//       _searchTextController.clear();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _searchTextController.addListener(() {
//       widget.onTextChange(_searchTextController.text);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var theme = Provider.of<MainTheme>(context);

//     return TextField(
//       controller: _searchTextController,
//       cursorColor: theme.onSurface,
//       style: TextStyle(color: theme.onSurface),
//       decoration: simpleSearchInputDecoration(theme),
//     );
//   }

//   @override
//   void dispose() {
//     _searchTextController.dispose();
//     super.dispose();
//   }
// }
