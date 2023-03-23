part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchSuccessState extends SearchState {}

class SearchErrorState extends SearchState {}

class SearchLoadingState extends SearchState {}