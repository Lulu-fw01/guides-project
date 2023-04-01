import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../../common/dto/guide_card_dto.dart';
import '../../../common/exceptions/app_exception.dart';
import '../repository/i_favorites_repository.dart';

part 'favorites_state.dart';

/// Cubit for adding and removing guides from favorites.
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.favoritesRepository})
      : super(FavoritesInitial());
  final IFavoritesRepository favoritesRepository;

  List<void Function(GuideCardDto)> _onAddedToFavorites = [];
  List<void Function(GuideCardDto)> _onRemovedFromFavorites = [];

  void addOnAddedListener(void Function(GuideCardDto) newListener) {
    _onAddedToFavorites.add(newListener);
  }

  void addOnRemovedListener(void Function(GuideCardDto) newListener) {
    _onRemovedFromFavorites.add(newListener);
  }

  /// Add guide to favorites or remove.
  void toggleFavorite(GuideCardDto guideCardDto) {
    if (guideCardDto.addedToFavorites) {
      _removeGuideFromFavorites(guideCardDto);
    } else {
      _addGuideToFavorites(guideCardDto);
    }
  }

  void _addGuideToFavorites(GuideCardDto guideCardDto) async {
    try {
      await favoritesRepository.addToFavorites(guideCardDto.id);
      for (var func in _onAddedToFavorites) {
        func(guideCardDto);
      }
      emit(SuccessAddToFavoritesState());
    } on ResponseException catch (e) {
      String message = e.responseBody != null ? e.responseBody!.message : '';
      //log.warning('Got ResponseException with message: $message', e);
      emit(ErrorAddToFavoritesState(message));
    } on AppException catch (e) {
      final message = e.message != null ? e.message! : '';
      //log.warning('Got AppException with message: $message', e);
      emit(ErrorAddToFavoritesState(message));
    }
  }

  void _removeGuideFromFavorites(GuideCardDto guideCardDto) async {
    try {
      await favoritesRepository.removeFromFavorites(guideCardDto.id);
      for (var func in _onRemovedFromFavorites) {
        func(guideCardDto);
      }
      emit(SuccessRemoveFromFavoriteState());
    } on ResponseException catch (e) {
      String message = e.responseBody != null ? e.responseBody!.message : '';
      //log.warning('Got ResponseException with message: $message', e);
      emit(ErrorRemoveFromFavoriteState(message));
    } on AppException catch (e) {
      final message = e.message != null ? e.message! : '';
      //log.warning('Got AppException with message: $message', e);
      emit(ErrorRemoveFromFavoriteState(message));
    }
  }
}
