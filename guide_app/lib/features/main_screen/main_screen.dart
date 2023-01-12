import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:provider/provider.dart';

/// Main screen of the app with navigation bottom bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedPageIndex,
          backgroundColor: theme.surface,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: Icon(
                  Icons.home,
                  color: theme.onSurface,
                ),
                label: "Главное"),
            NavigationDestination(
                icon: const Icon(
                  Icons.search_outlined,
                ),
                selectedIcon: Icon(
                  Icons.search,
                  color: theme.onSurface,
                ),
                label: "Поиск"),
            NavigationDestination(
                icon: const Icon(Icons.bookmarks_outlined),
                selectedIcon: Icon(
                  Icons.bookmarks,
                  color: theme.onSurface,
                ),
                label: "Избранное"),
            NavigationDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: Icon(
                  Icons.person,
                  color: theme.onSurface,
                ),
                label: "Профиль")
          ]),
    );
  }
}
