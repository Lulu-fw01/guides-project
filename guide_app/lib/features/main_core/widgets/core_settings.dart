import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/client/guide_client.dart';
import '../../../common/cubit/guide_utils_cubit.dart';
import '../../../common/repository/guide/guide_repository.dart';
import '../../../common/widgets/user_credentials.dart';
import '../../favorites/client/favorites_client.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../../favorites/cubit/favorites_page_cubit.dart';
import '../../favorites/provider/favorites_content_provider.dart';
import '../../favorites/provider/favorites_provider.dart';
import '../../favorites/repository/favorites_repository.dart';
import '../../profile/provider/profile_provider.dart';
import '../../search/bloc/search_bloc.dart';
import '../../search/client/search_client.dart';
import '../../search/provider/search_page_provider.dart';
import '../../search/provider/search_results_provider.dart';
import '../../search/provider/search_screen_provider.dart';
import '../../search/repository/search_repository.dart';
import '../provider/core_provider.dart';
import '../../main/provider/main_scaffold_provider.dart';

/// All repositories, providers
/// and blocs of this app.
class CoreSettings extends StatelessWidget {
  const CoreSettings({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
                )),
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
          ChangeNotifierProvider<FavoritesContentProvider>(
              create: (context) => FavoritesContentProvider()),
          ChangeNotifierProvider<SearchResultsProvider>(
              create: (context) => SearchResultsProvider()),
          ChangeNotifierProvider<CoreProvider>(
              create: (context) => CoreProvider()),
          ChangeNotifierProvider<MainScaffoldProvider>(
              create: (context) => MainScaffoldProvider()),

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
                        searchRepository:
                            RepositoryProvider.of<SearchRepository>(context,
                                listen: false))),
                // Favorites cubit settings.
                BlocProvider<FavoritesCubit>(
                    create: (context) => FavoritesCubit(
                        favoritesRepository:
                            RepositoryProvider.of<FavoritesRepository>(context,
                                listen: false))
                      // Adding on guide added to favorites listeners.
                      ..addOnAddedListener(Provider.of<SearchResultsProvider>(
                              context,
                              listen: false)
                          .toggleFavorites)
                      ..addOnAddedListener(
                          Provider.of<ProfileProvider>(context, listen: false)
                              .toggleFavorites)
                      ..addOnAddedListener(
                          Provider.of<FavoritesContentProvider>(context,
                                  listen: false)
                              .addToFavorites)
                      // Adding on guide removed from favorites listeners.
                      ..addOnRemovedListener(Provider.of<SearchResultsProvider>(
                              context,
                              listen: false)
                          .toggleFavorites)
                      ..addOnRemovedListener(
                          Provider.of<ProfileProvider>(context, listen: false)
                              .toggleFavorites)
                      ..addOnRemovedListener(
                          Provider.of<FavoritesContentProvider>(context,
                                  listen: false)
                              .removeFromFavorites)),
                BlocProvider<FavoritesPageCubit>(
                    create: (context) => FavoritesPageCubit(
                        favoritesRepository:
                            RepositoryProvider.of<FavoritesRepository>(context,
                                listen: false))),
                // Guide utils cubit settings.
                BlocProvider<GuideUtilsCubit>(
                    create: ((context) => GuideUtilsCubit(
                        guideRepository: RepositoryProvider.of<GuideRepository>(
                            context,
                            listen: false))
                      ..addOnGuideRemoveListener(
                          (Provider.of<SearchResultsProvider>(context,
                                  listen: false)
                              .removeGuide))
                      ..addOnGuideRemoveListener(
                          Provider.of<ProfileProvider>(context, listen: false)
                              .removeGuide)
                      ..addOnGuideRemoveListener(
                          Provider.of<FavoritesContentProvider>(context,
                                  listen: false)
                              .removeGuide)))
              ],
              // TODO move this inside core_scaffold.dart.
              child: child);
        }),
      ),
    );
  }
}
