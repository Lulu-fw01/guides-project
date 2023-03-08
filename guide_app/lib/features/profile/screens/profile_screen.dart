import 'package:flutter/material.dart';
import 'package:guide_app/cubit/init_cubit.dart';
import 'package:guide_app/features/profile/dto/user_info_dto.dart';
import 'package:guide_app/features/profile/widgets/user_info.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfo(
            userInfoDto: UserInfoDto('luchhalo@gmail.com', 'lulu',
                DateTime.utc(2001, 12, 13), 'User', false)),
        ElevatedButton(
            onPressed: () {
              initCubit.logout();
            },
            child: const Text('Logout')),
      ],
    );
  }
}
