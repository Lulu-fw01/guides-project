package paper.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import paper.entities.FavoriteItem;
import paper.services.FavoriteItemService;


@RestController
@RequestMapping("api/v1/favorites")
public class FavoriteItemController {

    private final FavoriteItemService favoriteItemService;

    @Autowired
    public FavoriteItemController(FavoriteItemService favoriteItemService) {
        this.favoriteItemService = favoriteItemService;
    }

    @PostMapping
    public void addToFavorites(@RequestBody FavoriteItem favoriteItem) {
        favoriteItemService.addToFavorites(favoriteItem);
    }

    // TODO: return list of favorites by user using GET method
    // TODO: add DELETE method
}
