package com.server.services;

import com.server.compositeId.FavoriteId;
import com.server.dto.FavoriteItemDTO;
import com.server.repository.FavoriteItemRepository;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.server.entities.FavoriteItem;


@Service
public class FavoriteItemService {

    private final FavoriteItemRepository favoriteItemRepository;
    private final GuideHandleRepository guideHandleRepository;
    private final UserRepository userRepository;

    @Autowired
    public FavoriteItemService(FavoriteItemRepository favoriteItemRepository,
                               GuideHandleRepository guideHandleRepository,
                               UserRepository userRepository) {
        this.favoriteItemRepository = favoriteItemRepository;
        this.guideHandleRepository = guideHandleRepository;
        this.userRepository = userRepository;
    }

    public void addToFavorites(FavoriteItemDTO favoriteItemDTO) {
        var favoriteItem = new FavoriteItem(
                new FavoriteId(
                        guideHandleRepository
                                .findById(favoriteItemDTO.getGuideId())
                                .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")),
                        userRepository
                                .findByEmail(favoriteItemDTO.getUserEmail())
                                .orElseThrow(() -> new UsernameNotFoundException("User does not exist"))
                )
        );
        favoriteItemRepository.save(favoriteItem);
    }
}
