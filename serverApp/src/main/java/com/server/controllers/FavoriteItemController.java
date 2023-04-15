package com.server.controllers;

import com.server.config.JwtPropertiesConfig;
import com.server.dto.FavoriteItemDTO;
import com.server.dto.GuideInfoPageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
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
    @Operation(summary = "Add guide to favorites")
    @SecurityRequirement(name = "Bearer Authentication")
    public void addToFavorites(@RequestBody FavoriteItemDTO favoriteItem) {
        favoriteItemService.addToFavorites(favoriteItem);
    }

    @GetMapping("{email}/{cursor}/{pageSize}")
    @Operation(summary = "Get list of favorites by email and cursor")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuideInfoPageResponse getFavorites(@PathVariable String email,
                                              @PathVariable String cursor,
                                              @PathVariable String pageSize) {
        return favoriteItemService.getFavorites(email, cursor, pageSize);
    }

    @DeleteMapping
    @Operation(summary = "Remove guide from favorites")
    @SecurityRequirement(name = "Bearer Authentication")
    public void removeFromFavorites(@RequestBody FavoriteItemDTO favoriteItem) {
        favoriteItemService.removeFromFavorites(favoriteItem);
    }
}
