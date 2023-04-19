import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/cubit/guide_utils_cubit.dart';
import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/snack_bars.dart';
import '../../../common/widgets/user_credentials.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../../favorites/widgets/favorites_state_snack_bar.dart';
import '../../guide/screens/guide_screen.dart';
import '../../profile/widgets/profile_fab.dart';
import '../provider/main_scaffold_provider.dart';
import '../widgets/main_app_bar.dart';

/// Main screen of the app.
/// This is screen with bottom navigation bar.
class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        final snack = buildFavoritesStateSnackBar(context, state);
        if (snack == null) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
      child: BlocListener<GuideUtilsCubit, GuideUtilsState>(
        listener: (context, state) {
          final snack = buildGuideUtilsSnackBar(context, state);
          if (snack == null) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(snack);
        },
        child: Consumer<MainScaffoldProvider>(
            builder: (context, mainScaffoldProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildMainAppBar(
                context, mainScaffoldProvider.selectedPageIndex),
            body: SafeArea(
                child: Container(
                    color: Colors.white,
                    child: mainScaffoldProvider.getCurrentPage())),
            bottomNavigationBar:
                _buildBottomNavigationBar(context, mainScaffoldProvider),
            floatingActionButton: mainScaffoldProvider.selectedPageIndex == 3
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

// TODO later use widget from core_navigation_bar.
  Widget _buildBottomNavigationBar(
      BuildContext context, MainScaffoldProvider mainScaffoldProvider) {
    final theme = Provider.of<MainTheme>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(width: 1, color: theme.onSurface.withOpacity(0.4))),
      ),
      child: NavigationBar(
          height: 80,
          selectedIndex: mainScaffoldProvider.selectedPageIndex,
          backgroundColor: theme.readableBackColor,
          onDestinationSelected: (int index) {
            mainScaffoldProvider.changePage(index);
          },
          destinations: [
            // NavigationDestination(
            //     icon: const Icon(Icons.home_outlined),
            //     selectedIcon: Icon(
            //       Icons.home,
            //       color: theme.onSurface,
            //     ),
            //     label: "Главное"),
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
