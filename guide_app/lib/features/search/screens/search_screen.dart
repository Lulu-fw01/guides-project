import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/search_input.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO либо поиск, либо просмотр гайда
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchInput(),
          ],
        ),
      ),
    );
  }
}
