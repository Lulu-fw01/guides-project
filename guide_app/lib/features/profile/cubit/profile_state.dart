part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileRefreshLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  ProfileErrorState(this.message);
  final String message;
}

class ProfileSuccessState extends ProfileState {
  ProfileSuccessState(this.nextPage);
  final GuideCardsPage nextPage;
}

class ProfileRefreshSuccessState extends ProfileState {
  ProfileRefreshSuccessState(this.nextPage, this.userInfo);
  final GuideCardsPage nextPage;
  final UserInfoDto userInfo;
}

class ProfileHeadIsReadyState extends ProfileState {}
