import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../../common/dto/guide_cards_page.dart';
import '../../../common/exceptions/app_exception.dart';
import '../repository/i_search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

/// BLoC that controls guides searching.
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchGuidesByTitleEvent>((event, emit) async {
      await _onSearchGuidesByTitle(event, emit);
    }, transformer: restartable());
  }
  bool isLoadingPage = false;
  String lastSearchPhrase = '';

  final ISearchRepository searchRepository;
  final log = Logger('SearchBloc');

  /// Search guides by title.
  Future<void> _onSearchGuidesByTitle(
      SearchGuidesByTitleEvent event, Emitter<SearchState> emit) async {
    lastSearchPhrase = event.searchPhrase;
    emit(SearchLoadingState());
    try {
      // Try to get next search page.
      final page = await searchRepository.searchGuidesByTitle(
          event.searchPhrase, event.pageNum);
      if (emit.isDone) {
        return;
      }
      // This part only for last event.
      log.fine(
          'Search by title ${event.searchPhrase} page ${event.pageNum} was loaded.');
      emit(SearchByTitleSuccessState(event.searchPhrase, page));
    } on ResponseException catch (e) {
      // Got error http response.
      String message = e.responseBody != null ? e.responseBody!.message : '';
      log.warning('Got ResponseException with message: $message', e);
      emit(SearchErrorState(message));
    } on AppException catch (e) {
      final message = e.message != null ? e.message! : '';
      log.warning('Got AppException with message: $message', e);
      emit(SearchErrorState(message));
    }
  }
}
