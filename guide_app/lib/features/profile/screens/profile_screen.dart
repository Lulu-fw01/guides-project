import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/repository/guide/guide_repository.dart';
import '../cubit/profile_cubit.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_core.dart';

/// PRofile screen.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guideRepo = Provider.of<GuideRepository>(context);
    return BlocProvider(
        create: (context) => ProfileCubit(guideRepository: guideRepo),
        child: Builder(builder: (context) {
          // Call getNextPage only if there were no calls before.
          if (Provider.of<ProfileProvider>(context).pageNum == 0 &&
              Provider.of<ProfileCubit>(context).state is ProfileInitialState) {
            Provider.of<ProfileCubit>(context).getNextPage(0);
          }
          return const ProfileCore();
        }));
  }
}
