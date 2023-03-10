import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:provider/provider.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    final profileCubit = Provider.of<ProfileCubit>(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          return Container();
        });

    //   ListView.separated(
    //       itemBuilder: (BuildContext context, int index) {},
    //       separatorBuilder: (BuildContext context, int index) => Divider(
    //             height: 3,
    //             color: theme.onSurface,
    //           ),
    //       itemCount: 0);
    // }

    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     UserInfo(
    //         userInfoDto: UserInfoDto('luchhalo@gmail.com', 'lulu',
    //             DateTime.utc(2001, 12, 13), 'User', false)),
    //     ElevatedButton(
    //         onPressed: () {
    //           initCubit.logout();
    //         },
    //         child: const Text('Logout')),
    //   ],
    // );
  }
}
