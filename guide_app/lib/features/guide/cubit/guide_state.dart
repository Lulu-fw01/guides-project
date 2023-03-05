part of 'guide_cubit.dart';

@immutable
abstract class GuideState {}

class GuideInitial extends GuideState {}

class GuideLoadingState extends GuideState {}

class GuideErrorState extends GuideState {
  GuideErrorState(this.message);
  final String message;
}
