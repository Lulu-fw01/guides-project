part of 'favorites_page_cubit.dart';

@immutable
abstract class FavoritesPageState {}

class FavoritesPageInitial extends FavoritesPageState {}

class LoadingFavoritesPageState extends FavoritesPageState {}

class RefreshLoadingFavoritesPageState extends FavoritesPageState {}

class ErrorFavoritesPageState extends FavoritesPageState {
  ErrorFavoritesPageState(this.errorMessage);
  final String errorMessage;
}

/// Next page of favorites guides was loaded successfully.
class SuccessFavoritesPageState extends FavoritesPageState {
  SuccessFavoritesPageState(this.nextPage);
  final GuideCardsPage nextPage;
}

class RefreshSuccessFavoritesPageState extends FavoritesPageState {
  RefreshSuccessFavoritesPageState(this.nextPage);
  final GuideCardsPage nextPage;
}
