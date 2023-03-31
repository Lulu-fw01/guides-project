package com.server.services;

import com.server.dto.FavoriteItemDTO;
import com.server.repository.FavoriteItemRepository;
import com.server.repository.GuideHandleRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class FavoriteItemServiceTest {

    @InjectMocks
    private FavoriteItemService favoriteItemService;

    @Mock
    private GuideHandleRepository guideHandleRepository;

    @Test
    public void addToFavoritesNull() {
        assertThrows(ResponseStatusException.class,
                () -> favoriteItemService.addToFavorites(null),
                "The request body is null");
    }

    @Test
    public void addToFavoritesNonExistingGuide() {
        when(guideHandleRepository.findById(anyLong()))
                .thenThrow(new IllegalArgumentException("Guide does not exist"));

        assertThrows(IllegalArgumentException.class,
                () -> favoriteItemService.addToFavorites(new FavoriteItemDTO(1L, "email")),
                "Guide does not exist");
    }

    @Test
    public void removeNull() {
        assertThrows(ResponseStatusException.class,
                () -> favoriteItemService.removeFromFavorites(null),
                "The request body is null");
    }

    @Test
    public void removeFromFavoritesNonExistingGuide() {
        when(guideHandleRepository.findById(anyLong()))
                .thenThrow(new IllegalArgumentException("Guide does not exist"));

        assertThrows(IllegalArgumentException.class,
                () -> favoriteItemService.removeFromFavorites(new FavoriteItemDTO(1L, "email")),
                "Guide does not exist");
    }

    @Test
    public void getFavoritesForNullEmail() {
        assertThrows(ResponseStatusException.class,
                () -> favoriteItemService.getFavorites(null, "pn", "ps"),
                "One of the parameters is null");
    }
}