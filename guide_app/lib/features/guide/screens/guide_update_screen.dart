import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/repository/guide/guide_repository.dart';
import '../../main_core/provider/core_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => GuideViewCubit(
                guideRepository: RepositoryProvider.of<GuideRepository>(context,
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
              Provider.of<CoreProvider>(context, listen: false).goToMain();
            }
          },
          builder: (context, state) {
            if (state is GuideViewSuccessState) {
              return GuideInput(
                guideDto: state.guide,
                onSuccess: () {
                  Provider.of<CoreProvider>(context, listen: false).goToMain();
                },
                onBackButtonClick: () {
                  Provider.of<CoreProvider>(context, listen: false).goToMain();
                },
              );
            }
            // TODO later refactor this and GuideInput.
            return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          },
        );
      }),
    );
  }
}
