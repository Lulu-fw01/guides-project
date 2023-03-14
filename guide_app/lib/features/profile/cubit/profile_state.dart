part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  ProfileErrorState(this.message);
  final String message;
}

class ProfileSuccessState extends ProfileState {
  ProfileSuccessState(this.guideCards);
  final List<GuideCardDto> guideCards;
}

class ProfileHeadIsReadyState extends ProfileState {}
