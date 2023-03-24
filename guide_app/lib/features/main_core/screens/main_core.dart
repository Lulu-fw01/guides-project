import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/client/guide_client.dart';
import '../../../common/repository/guide/guide_repository.dart';
import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/user_credentials.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../../guide/screens/guide_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../profile/provider/profile_provider.dart';
import '../../profile/screens/profile_screen.dart';
import '../../profile/widgets/profile_fab.dart';
import '../../search/screens/search_screen.dart';
import '../widgets/core_app_bar.dart';

/// Main component of the app with navigation bottom bar.
/// TODO later try to use stateleess widget.
class MainCore extends StatefulWidget {
  const MainCore({super.key});

  @override
  MainCoreState createState() => MainCoreState();
}

class MainCoreState extends State<MainCore> {
  int selectedPageIndex = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    final credentials = UserCredentials.of(context);
    return ChangeNotifierProvider<ProfileProvider>(
      create: (BuildContext context) => ProfileProvider(),
      child: RepositoryProvider(
        create: (context) =>
            GuideRepository(credentials.email, GuideClient(credentials.token)),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildCoreAppBar(context, selectedPageIndex),
            body: SafeArea(
                child: Container(
                    color: Colors.white, child: _pages[selectedPageIndex])),
            bottomNavigationBar: _buildBottomNavigationBar(theme),
            floatingActionButton: selectedPageIndex == 3
                ? ProfileFab(onPressed: () => _onCreateNewGuidePressed(context))
                : null,
          );
        }),
      ),
    );
  }

  void _onCreateNewGuidePressed(BuildContext context) {
    final theme = Provider.of<MainTheme>(context, listen: false);
    final credentials = UserCredentials.of(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => Provider(
        create: (context) => theme,
        builder: (context, child) =>
            GuideScreen(email: credentials.email, token: credentials.token),
      ),
    ));
  }

  // TODO remove later.
  // PreferredSizeWidget? _buildAppBar(BuildContext context) {
  //   final initCubit = Provider.of<InitCubit>(context);
  //   switch (selectedPageIndex) {
  //     case 2:
  //       return favoritesAppBar(context);
  //     case 3:
  //       return profileAppBar(context, () {
  //         initCubit.logout();
  //       });
  //     default:
  //       return null;
  //   }
  // }

  // TODO later use widget from core_navigation_bar.
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
