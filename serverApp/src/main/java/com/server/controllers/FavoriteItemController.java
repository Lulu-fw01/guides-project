package com.server.controllers;

import com.server.dto.FavoriteItemDTO;
import com.server.dto.GuideDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.server.entities.FavoriteItem;
import com.server.services.FavoriteItemService;

import java.util.List;


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

    @GetMapping
    public List<GuideDTO> getFavorites(@RequestBody String email) {
        return favoriteItemService.getFavorites(email);
    }

    @DeleteMapping
    public void removeFromFavorites(@RequestBody FavoriteItemDTO favoriteItem) {
        favoriteItemService.removeFromFavorites(favoriteItem);
    }
}
