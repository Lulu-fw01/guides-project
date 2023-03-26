import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../../common/dto/guide_cards_page.dart';
import '../../../common/exceptions/app_exception.dart';
import '../repository/i_search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchGuidesByTitleEvent>((event, emit) => _onSearchGuidesByTitle);
  }

  final ISearchRepository searchRepository;
  final log = Logger('SearchBloc');

  /// Search guides by title
  _onSearchGuidesByTitle(
      SearchGuidesByTitleEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      // Try to get next search page.
      final page = await searchRepository.searchGuidesByTitle(
          event.searchPhrase, event.pageNum);
      log.fine('Search by title page ${event.pageNum} was loaded.');
      emit(SearchByTitleSuccessState(page));
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
