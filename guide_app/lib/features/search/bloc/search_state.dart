part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchByTitleSuccessState extends SearchState {
  SearchByTitleSuccessState(this.searchPhrase, this.nextPage);
  final String searchPhrase;
  final GuideCardsPage nextPage;
}

class SearchErrorState extends SearchState {
  SearchErrorState(this.message);
  final String message;
}

class SearchLoadingState extends SearchState {}

class SearchByAuthorSuccessState extends SearchState {}
