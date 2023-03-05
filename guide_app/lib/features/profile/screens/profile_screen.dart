import 'package:flutter/material.dart';
import 'package:guide_app/cubit/init_cubit.dart';
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

    return ElevatedButton(
        onPressed: () {
          initCubit.logout();
        },
        child: const Text('Logout'));
  }
}
