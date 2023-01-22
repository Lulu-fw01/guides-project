import 'package:flutter/material.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/features/favorites/screens/favorites_screen.dart';
import 'package:guide_app/features/guide/screens/guide_edit_screen.dart';
import 'package:guide_app/features/home/screens/home_screen.dart';
import 'package:guide_app/features/main/widgets/favorites_app_bar.dart';
import 'package:guide_app/features/profile/screens/profile_screen.dart';
import 'package:guide_app/features/search/screens/search_screen.dart';
import 'package:provider/provider.dart';

/// Main component of the app with navigation bottom bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedPageIndex = 0;
  static const _pages = [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
          child:
              Container(color: Colors.white, child: _pages[selectedPageIndex])),
      bottomNavigationBar: _buildBottomNavigationBar(theme),
      floatingActionButton: selectedPageIndex == 3
          ? FloatingActionButton(
              backgroundColor: theme.onSurfaceVariant,
              onPressed: () {
                _onCreateNewGuidePressed(context);
              },
              child: Icon(
                Icons.add,
                color: theme.onSurface,
              ),
            )
          : null,
    );
  }

  void _onCreateNewGuidePressed(BuildContext context) {
    final theme = Provider.of<MainTheme>(context, listen: false);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => Provider(
          create: (context) => theme,
          builder: (context, child) => GuideEditScreen(),
        ),    ));
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    switch (selectedPageIndex) {
      case 2:
        return favoritesAppBar(context);
      default:
        return null;
    }
  }

  Widget _buildBottomNavigationBar(MainTheme theme) => NavigationBar(
          height: 80,
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
          ]);
}
