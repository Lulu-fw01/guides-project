import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/repository/guide/guide_repository.dart';
import 'package:guide_app/cubit/init_cubit.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:guide_app/features/profile/widgets/profile_content.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final initCubit = Provider.of<InitCubit>(context);
    final guideRepo = Provider.of<GuideRepository>(context);
    return BlocProvider(
        create: (context) => ProfileCubit(guideRepository: guideRepo)..getNextPage(0),
        child: ProfileContent());
  }
}
