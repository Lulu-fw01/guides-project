import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/cubit/init_cubit.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:guide_app/features/profile/widgets/profile_content.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final initCubit = Provider.of<InitCubit>(context);
    final theme = Provider.of<MainTheme>(context);
    return BlocProvider(
        create: (context) => ProfileCubit(), child: ProfileContent());
  }
}
