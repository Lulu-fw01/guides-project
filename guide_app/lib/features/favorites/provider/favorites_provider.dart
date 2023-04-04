import 'package:flutter/widgets.dart';

/// This class controls favorites screen state.
class FavoritesProvider extends ChangeNotifier {
  FavoritesScreenState favoritesScreenState =
      FavoritesScreenState.viewFavorites;

  int? viewedGuideId;

  void setFavoritesScreenState(FavoritesScreenState newFavoritesScreenState) {
    favoritesScreenState = newFavoritesScreenState;
    notifyListeners();
  }

  /// Show chosen guide.
  /// [guideId] - id of the chosen guide.
  void showGuide(int guideId) {
    viewedGuideId = guideId;
    setFavoritesScreenState(FavoritesScreenState.viewGuide);
  }

  /// Go to profile info screen.
  void showFavorites() {
    setFavoritesScreenState(FavoritesScreenState.viewFavorites);
  }
}

enum FavoritesScreenState { viewFavorites, viewGuide }
