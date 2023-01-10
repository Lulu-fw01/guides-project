part of 'init_cubit.dart';

@immutable
abstract class InitState {}

class InitCubitInitial extends InitState {}

class InitLoading extends InitState {}

class InitAuthorized extends InitState {}

class InitUnauthorized extends InitState {}
