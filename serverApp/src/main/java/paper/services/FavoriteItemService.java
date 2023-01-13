package paper.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import paper.entities.FavoriteItem;
import paper.repository.FavoriteItemRepository;


@Service
public class FavoriteItemService {

    private final FavoriteItemRepository favoriteItemRepository;

    @Autowired
    public FavoriteItemService(FavoriteItemRepository favoriteItemRepository) {
        this.favoriteItemRepository = favoriteItemRepository;
    }

    public void addToFavorites(FavoriteItem favoriteItem) {
        favoriteItemRepository.save(favoriteItem);
    }
}
