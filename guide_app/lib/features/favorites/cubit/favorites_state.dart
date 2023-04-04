part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class SuccessRemoveFromFavoriteState extends FavoritesState {}

class ErrorRemoveFromFavoriteState extends FavoritesState {
  ErrorRemoveFromFavoriteState(this.errorMessage);
  final String errorMessage;
}

class SuccessAddToFavoritesState extends FavoritesState {}

class ErrorAddToFavoritesState extends FavoritesState {
  ErrorAddToFavoritesState(this.errorMessage);
  final String errorMessage;
}
