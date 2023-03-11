import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/client/guide_client.dart';
import 'package:guide_app/common/repository/guide/guide_repository.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/cubit/init_cubit.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:guide_app/features/profile/widgets/profile_content.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    final initCubit = Provider.of<InitCubit>(context);
    final theme = Provider.of<MainTheme>(context);
    return BlocProvider(
        // TODO move repository to provider.
        create: (context) =>
            ProfileCubit(GuideRepository(email, GuideClient(token))),
        child: ProfileContent());
  }
}
