import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../../common/dto/guide_cards_page.dart';
import '../../../common/exceptions/app_exception.dart';
import '../repository/i_favorites_repository.dart';

part 'favorites_page_state.dart';

/// Cubit for controlling page which contains favorites guides
class FavoritesPageCubit extends Cubit<FavoritesPageState> {
  FavoritesPageCubit({required this.favoritesRepository})
      : super(FavoritesPageInitial());
  final IFavoritesRepository favoritesRepository;
  bool isLoadingPage = false;
  final log = Logger('FavoritesPageCubit');

  /// Load next page of favorites guides.
  /// [cursor] - id of the last guide.
  void getNextPage(int cursor) async {
    emit(LoadingFavoritesPageState());
    try {
      final nextPage = await favoritesRepository.getFavorites(cursor);
      log.fine('Favorites page with $cursor was loaded.');
      emit(SuccessFavoritesPageState(nextPage));
    } on ResponseException catch (e) {
      String message = e.responseBody != null ? e.responseBody!.message : '';
      log.warning('Got ResponseException with message: $message', e);
      emit(ErrorFavoritesPageState(message));
    } on AppException catch (e) {
      final message = e.message != null ? e.message! : '';
      log.warning('Got AppException with message: $message', e);
      emit(ErrorFavoritesPageState(message));
    }
  }

  /// Refresh favorites guides.
  Future<void> refresh() async {
    emit(RefreshLoadingFavoritesPageState());
    try {
      final nextPage = await favoritesRepository.getFavorites(-1);
      log.fine('Favorites page refresh successful.');
      emit(RefreshSuccessFavoritesPageState(nextPage));
    } on ResponseException catch (e) {
      String message = e.responseBody != null ? e.responseBody!.message : '';
      //log.warning('Got ResponseException with message: $message', e);
      emit(ErrorFavoritesPageState(message));
    } on AppException catch (e) {
      final message = e.message != null ? e.message! : '';
      //log.warning('Got AppException with message: $message', e);
      emit(ErrorFavoritesPageState(message));
    }
  }
}
