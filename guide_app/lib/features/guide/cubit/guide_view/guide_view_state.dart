part of 'guide_view_cubit.dart';

@immutable
abstract class GuideViewState {}

class GuideViewInitial extends GuideViewState {}

class GuideViewLoadingState extends GuideViewState {}

class GuideViewErrorState extends GuideViewState {
  GuideViewErrorState(this.message);
  final String message;
}

class GuideViewSuccessState extends GuideViewState {
  GuideViewSuccessState(this.guide);
  final GuideDto guide;
}
