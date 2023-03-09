part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  ProfileErrorState(this.message);
  final String message;
}

class ProfileHeadIsReadyState extends ProfileState {}
