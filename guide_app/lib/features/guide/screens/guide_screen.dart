import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/client/guide_client.dart';
import '../../../common/repository/guide/guide_repository.dart';
import '../cubit/guide_cubit.dart';
import 'guide_edit_screen.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    // TODO add different variations of screen: edit, watch.
    return BlocProvider(
        // TODO move repository in reository provider in main screen.
        create: (context) => GuideCubit(
            GuideRepository(email: email, guideClient: GuideClient(token))),
        child: const GuideEditScreen());
  }
}
