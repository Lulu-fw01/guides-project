package com.server.services;

import com.server.compositeId.FavoriteId;
import com.server.dto.FavoriteItemDTO;
import com.server.dto.GuideDTO;
import com.server.dto.GuideInfoDTO;
import com.server.repository.FavoriteItemRepository;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.server.entities.FavoriteItem;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;


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
        if (favoriteItemDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

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

    public void removeFromFavorites(FavoriteItemDTO favoriteItemDTO) {
        if (favoriteItemDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var id = new FavoriteId(
                guideHandleRepository
                        .findById(favoriteItemDTO.getGuideId())
                        .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")),
                userRepository
                        .findByEmail(favoriteItemDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist"))
        );

        favoriteItemRepository.deleteById(id);
    }

    public List<GuideInfoDTO> getFavorites(String email) {
        if (email == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var guideIds = favoriteItemRepository
                .findFavoritesByConcreteUser(email);

        return guideHandleRepository
                .findByIds(guideIds)
                .stream()
                .map(guide -> new GuideInfoDTO(
                        guide.getId(),
                        guide.getCreatorEmail().getLogin(),
                        guide.getTitle(),
                        guide.getEditDate(),
                        guide.getIsBlocked(),
                        checkIfAddedToFavorites(guide.getId(), email)
                ))
                .toList();
    }

    public Boolean checkIfAddedToFavorites(Long guideId, String email) {
        var id = new FavoriteId(
                guideHandleRepository
                        .findById(guideId)
                        .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")),
                userRepository
                        .findByEmail(email)
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist"))
        );

        return favoriteItemRepository.existsById(id);
    }
}
