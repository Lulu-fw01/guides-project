import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../cubit/init_cubit.dart';
import '../../favorites/widgets/favorites_app_bar.dart';
import '../../profile/widgets/profile_app_bar.dart';

PreferredSizeWidget? buildCoreAppBar(
    BuildContext context, int selectedPageIndex) {
  final initCubit = Provider.of<InitCubit>(context);
  switch (selectedPageIndex) {
    case 2:
      return favoritesAppBar(context);
    case 3:
      return profileAppBar(context, () {
        initCubit.logout();
      });
    default:
      return null;
  }
}
