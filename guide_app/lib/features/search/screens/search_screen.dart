import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/repository/guide/guide_repository.dart';
import '../../guide/cubit/guide_view/guide_view_cubit.dart';
import '../../guide/screens/guide_view_screen.dart';
import '../provider/search_screen_provider.dart';
import '../widgets/search_page.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenProvider>(
      builder: ((context, provider, child) {
        switch (provider.profileScreenState) {
          case SearchScreenMode.guideViewMode:
            return BlocProvider(
                create: (context) => GuideViewCubit(
                    guideRepository:
                        Provider.of<GuideRepository>(context, listen: false)),
                child: Builder(
                  builder: (context) {
                    if (provider.viewedGuideId != null) {
                      // TODO fix: if guide have been already loaded we should not reload it again.
                      Provider.of<GuideViewCubit>(context, listen: false)
                          .showGuide(provider.viewedGuideId);
                      return const GuideViewScreen();
                    }
                    return Container();
                  },
                ));
          case SearchScreenMode.searchMode:
            return const SearchPage();
        }
      }),
    );
  }
}
