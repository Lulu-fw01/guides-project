package com.server.controllers;

import com.server.dto.FavoriteItemDTO;
import com.server.dto.GuideInfoPageResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.server.services.FavoriteItemService;


@RestController
@RequestMapping("api/v1/favorites")
public class FavoriteItemController {

    private final FavoriteItemService favoriteItemService;

    @Autowired
    public FavoriteItemController(FavoriteItemService favoriteItemService) {
        this.favoriteItemService = favoriteItemService;
    }

    @PostMapping
    public void addToFavorites(@RequestBody FavoriteItemDTO favoriteItem) {
        favoriteItemService.addToFavorites(favoriteItem);
    }

    @GetMapping("{email}/{pageNumber}/{pageSize}")
    public GuideInfoPageResponse getFavorites(@PathVariable String email,
                                              @PathVariable String pageNumber,
                                              @PathVariable String pageSize) {
        return favoriteItemService.getFavorites(email, pageNumber, pageSize);
    }

    @DeleteMapping
    public void removeFromFavorites(@RequestBody FavoriteItemDTO favoriteItem) {
        favoriteItemService.removeFromFavorites(favoriteItem);
    }
}
