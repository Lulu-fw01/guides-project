part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

/// Search guides by title
class SearchGuidesByTitleEvent extends SearchEvent {
  SearchGuidesByTitleEvent({required this.searchPhrase, required this.pageNum});

  /// Search phrase.
  final String searchPhrase;

  /// Page number.
  final int pageNum;
}
