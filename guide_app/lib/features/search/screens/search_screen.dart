import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<MainTheme>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
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
                  filled: true,
                  fillColor: theme.surface),
            ),
          ],
        ),
      ),
    );
  }
}
