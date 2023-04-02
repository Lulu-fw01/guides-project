import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/client/guide_client.dart';
import '../../../common/repository/guide/guide_repository.dart';
import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/user_credentials.dart';
import '../../favorites/client/favorites_client.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../../favorites/cubit/favorites_page_cubit.dart';
import '../../favorites/provider/favorites_provider.dart';
import '../../favorites/repository/favorites_repository.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../../guide/screens/guide_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../profile/provider/profile_provider.dart';
import '../../profile/screens/profile_screen.dart';
import '../../profile/widgets/profile_fab.dart';
import '../../search/bloc/search_bloc.dart';
import '../../search/client/search_client.dart';
import '../../search/provider/search_page_provider.dart';
import '../../search/provider/search_screen_provider.dart';
import '../../search/repository/search_repository.dart';
import '../../search/screens/search_screen.dart';
import '../widgets/core_app_bar.dart';

/// Main component of the app with navigation bottom bar.
/// This widget contains all main repositories, provider, BLoCs.
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
    return MultiRepositoryProvider(
      // All repositories of app initialized here.
      providers: [
        RepositoryProvider<GuideRepository>(
          create: (context) => GuideRepository(
              email: credentials.email,
              guideClient: GuideClient(credentials.token)),
        ),
        RepositoryProvider<SearchRepository>(
            create: (context) => SearchRepository(
                searchClient: SearchClient(credentials.token))),
        RepositoryProvider<FavoritesRepository>(
            create: (context) => FavoritesRepository(
                  email: credentials.email,
                  favoritesClient: FavoritesClient(credentials.token),
                ))
      ],
      // All providers of app initialized here.
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProfileProvider>(
              create: (context) => ProfileProvider()),
          ChangeNotifierProvider<SearchScreenProvider>(
            create: (context) => SearchScreenProvider(),
          ),
          ChangeNotifierProvider<SearchPageProvider>(
              create: (context) => SearchPageProvider()),
          ChangeNotifierProvider<FavoritesProvider>(
              create: (context) => FavoritesProvider()),

          // TODO add later maybe.
          // ChangeNotifierProvider<SearchInputProvider>(
          //     create: (context) => SearchInputProvider()
          //       ..addSearchListener(Provider.of<SearchPageProvider>(context),
          //           Provider.of<SearchBloc>(context))),
        ],
        child: Builder(builder: (context) {
          // All Blocs of the app initialized here.
          return MultiBlocProvider(
            providers: [
              BlocProvider<SearchBloc>(
                  create: (context) => SearchBloc(
                      searchRepository: RepositoryProvider.of<SearchRepository>(
                          context,
                          listen: false))),
              BlocProvider<FavoritesCubit>(
                  create: (context) => FavoritesCubit(
                      favoritesRepository:
                          RepositoryProvider.of<FavoritesRepository>(context,
                              listen: false))
                    // Adding on guide added to favorites listeners.
                    ..addOnAddedListener(
                        Provider.of<SearchPageProvider>(context, listen: false)
                            .toggleFavorites)
                    ..addOnAddedListener(
                        Provider.of<ProfileProvider>(context, listen: false)
                            .toggleFavorites)
                    ..addOnAddedListener(
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .addToFavorites)
                    // Adding on guide removed from favorites listeners.
                    ..addOnRemovedListener(
                        Provider.of<SearchPageProvider>(context, listen: false)
                            .toggleFavorites)
                    ..addOnRemovedListener(
                        Provider.of<ProfileProvider>(context, listen: false)
                            .toggleFavorites)
                    ..addOnRemovedListener(
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .removeFromFavorites)),
              BlocProvider<FavoritesPageCubit>(
                  create: (context) => FavoritesPageCubit(
                      favoritesRepository:
                          RepositoryProvider.of<FavoritesRepository>(context,
                              listen: false))),
            ],
            // TODO move scaffold inside another widget.
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildCoreAppBar(context, selectedPageIndex),
              body: SafeArea(
                  child: Container(
                      color: Colors.white, child: _pages[selectedPageIndex])),
              bottomNavigationBar: _buildBottomNavigationBar(theme),
              floatingActionButton: selectedPageIndex == 3
                  ? ProfileFab(
                      onPressed: () => _onCreateNewGuidePressed(context))
                  : null,
            ),
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
