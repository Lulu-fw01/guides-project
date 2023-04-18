import 'package:flutter/widgets.dart';

import '../../favorites/screens/favorites_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../search/screens/search_screen.dart';

/// Provider for controlling
/// pages of [MainScaffold].
class MainScaffoldProvider extends ChangeNotifier {
  int selectedPageIndex = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen()
  ];

  void changePage(int newIndex) {
    if (newIndex < -1 ||
        newIndex >= _pages.length ||
        newIndex == selectedPageIndex) {
      return;
    }
    selectedPageIndex = newIndex;
    notifyListeners();
  }

  Widget getCurrentPage() {
    return _pages[selectedPageIndex];
  }
}
