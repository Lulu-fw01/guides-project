package com.server.services;

import com.server.compositeId.FavoriteId;
import com.server.dto.FavoriteItemDTO;
import com.server.dto.GuideInfoDTO;
import com.server.dto.GuideInfoPageResponse;
import com.server.repository.FavoriteItemRepository;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.server.entities.FavoriteItem;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;

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
                ),
                new Timestamp(System.currentTimeMillis())
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

    public GuideInfoPageResponse getFavorites(String email, String pageNumber, String pageSize) {
        if (email == null || pageNumber == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        var guideIds = favoriteItemRepository
                .findFavoritesByConcreteUser(email);

        try {
            var pageNumberInt = Integer.parseInt(pageNumber);
            var pageSizeInt = Integer.parseInt(pageSize);

            var pageAmount = getTotalPages(pageSizeInt, guideHandleRepository.findByIds(guideIds).size());

            var guideInfoList = guideHandleRepository
                    .findByIds(guideIds, PageRequest.of(pageNumberInt, pageSizeInt))
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

            return new GuideInfoPageResponse(
                    pageAmount,
                    guideInfoList,
                    pageNumberInt
            );
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse Integer from Path variable");
        }
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

    private int getTotalPages(int pageSize, int numOfAllGuidesByUser) {
        int totalPages;
        if (numOfAllGuidesByUser % pageSize == 0) {
            totalPages = numOfAllGuidesByUser / pageSize;
        } else {
            totalPages = numOfAllGuidesByUser / pageSize + 1;
        }
        return totalPages;
    }
}
