import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/client/guide_client.dart';
import '../../../common/repository/guide/guide_repository.dart';
import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/user_credentials.dart';
import '../cubit/guide_cubit.dart';
import '../cubit/guide_view/guide_view_cubit.dart';
import 'guide_Input.dart';

/// Screen for updating guide.
class GuideUpdateScreen extends StatelessWidget {
  const GuideUpdateScreen(
      {super.key,
      required this.email,
      required this.token,
      required this.guideId});
  final String email;
  final String token;
  final int guideId;

  /// Show [GuideUpdateScreen].
  // static void showGuideUpdateScreen(BuildContext context, int guideId) {
  //   final credentials = UserCredentials.of(context);
  //   final theme = Provider.of<MainTheme>(context, listen: false);

  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (BuildContext context) => Provider(
  //       create: (context) => theme,
  //       builder: (context, child) => GuideUpdateScreen(
  //         email: credentials.email,
  //         token: credentials.token,
  //         guideId: guideId,
  //       ),
  //     ),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          GuideRepository(email: email, guideClient: GuideClient(token)),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => GuideViewCubit(
                  guideRepository: RepositoryProvider.of<GuideRepository>(
                      context,
                      listen: false))),
          BlocProvider(
            create: (context) => GuideCubit(
                RepositoryProvider.of<GuideRepository>(context, listen: false)),
          )
        ],
        child: Builder(builder: (context) {
          final guideViewCubit =
              Provider.of<GuideViewCubit>(context, listen: false);
          guideViewCubit.showGuide(guideId);
          return BlocConsumer<GuideViewCubit, GuideViewState>(
            listener: (context, state) {
              if (state is GuideViewErrorState) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is GuideViewSuccessState) {
                return GuideInput();
              }
              return Container();
            },
          );
        }),
      ),
    );
  }
}
