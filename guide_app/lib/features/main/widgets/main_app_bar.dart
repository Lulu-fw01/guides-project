import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../cubit/init_cubit.dart';
import '../../favorites/widgets/favorites_app_bar.dart';
import '../../profile/widgets/profile_app_bar.dart';
import '../../search/widgets/search_app_bar.dart';

/// Builder for all pages of [MainScaffold].
PreferredSizeWidget? buildMainAppBar(
    BuildContext context, int selectedPageIndex) {
  final initCubit = Provider.of<InitCubit>(context);
  switch (selectedPageIndex) {
    case 0:
      return searchAppBar(context);
    case 1:
      return favoritesAppBar(context);
    case 2:
      return profileAppBar(context, () {
        initCubit.logout();
      });
    default:
      return null;
  }
}
