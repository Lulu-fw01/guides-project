import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/client/guide_client.dart';
import 'package:guide_app/common/repository/guide/guide_repository.dart';
import 'package:guide_app/features/guide/cubit/guide_cubit.dart';
import 'package:guide_app/features/guide/screens/guide_edit_screen.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO add different variations of screen: edit, watch.
    return BlocProvider(
        // TODO move repository in reository provider in main screen.
        create: (context) => GuideCubit(GuideRepository(GuideClient())),
        child: const GuideEditScreen());
  }
}
