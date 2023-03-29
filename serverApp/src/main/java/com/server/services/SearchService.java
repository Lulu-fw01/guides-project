package com.server.services;

import com.server.dto.GuideInfoDTO;
import com.server.dto.GuideInfoPageResponse;
import com.server.repository.GuideHandleRepository;
import com.server.utils.AuthUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;


@Component
public class SearchService {

    private final GuideHandleRepository guideHandleRepository;

    private final FavoriteItemService favoriteItemService;

    @Autowired
    public SearchService(GuideHandleRepository guideHandleRepository, FavoriteItemService favoriteItemService) {
        this.guideHandleRepository = guideHandleRepository;
        this.favoriteItemService = favoriteItemService;
    }

    public GuideInfoPageResponse getGuidesByTitle(String title, String pageNumber, String pageSize) {
        if (title == null || pageNumber == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        System.out.println(AuthUtil.getAuthenticatedUser());

        try {
            var numOfAllGuidesByTitle = guideHandleRepository.searchByTitle(title).size();

            int totalPages = getTotalPages(Integer.parseInt(pageSize), numOfAllGuidesByTitle);

            var guideInfoDTOList = guideHandleRepository
                    .searchByTitle(title, PageRequest.of(Integer.parseInt(pageNumber), Integer.parseInt(pageSize), Sort.by("edit_date").descending()))
                    .stream()
                    .map(guide -> new GuideInfoDTO(
                            guide.getId(),
                            guide.getCreatorEmail().getLogin(),
                            guide.getTitle(),
                            guide.getEditDate(),
                            guide.getIsBlocked(),
                            favoriteItemService.checkIfAddedToFavorites(guide.getId(), AuthUtil.getAuthenticatedUser())
                    ))
                    .toList();

            return new GuideInfoPageResponse(
                    totalPages,
                    guideInfoDTOList,
                    Integer.parseInt(pageNumber)
            );
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse pageNumber and/or pageSize values to Integer");
        }
    }

    public GuideInfoPageResponse getGuidesByCategory(String category, String pageNumber, String pageSize) {
        if (category == null || pageNumber == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        try {
            var numOfAllGuidesByTitle = guideHandleRepository.searchByCategory(category).size();

            int totalPages = getTotalPages(Integer.parseInt(pageSize), numOfAllGuidesByTitle);

            var guideInfoDTOList = guideHandleRepository
                    .searchByCategory(category, PageRequest.of(Integer.parseInt(pageNumber), Integer.parseInt(pageSize), Sort.by("edit_date").descending()))
                    .stream()
                    .map(guide -> new GuideInfoDTO(
                            guide.getId(),
                            guide.getCreatorEmail().getLogin(),
                            guide.getTitle(),
                            guide.getEditDate(),
                            guide.getIsBlocked(),
                            favoriteItemService.checkIfAddedToFavorites(guide.getId(), AuthUtil.getAuthenticatedUser())
                    ))
                    .toList();

            return new GuideInfoPageResponse(
                    totalPages,
                    guideInfoDTOList,
                    Integer.parseInt(pageNumber)
            );
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse pageNumber and/or pageSize values to Integer");
        }
    }

    public GuideInfoPageResponse getGuidesByAuthor(String author, String pageNumber, String pageSize) {
        if (author == null || pageNumber == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        try {
            var numOfAllGuidesByAuthor = guideHandleRepository.searchByAuthor(author).size();

            int totalPages = getTotalPages(Integer.parseInt(pageSize), numOfAllGuidesByAuthor);

            var dtos = guideHandleRepository
                    .searchByAuthor(author, PageRequest.of(Integer.parseInt(pageNumber), Integer.parseInt(pageSize), Sort.by("edit_date").descending()))
                    .stream()
                    .map(guide -> new GuideInfoDTO(
                            guide.getId(),
                            guide.getCreatorEmail().getLogin(),
                            guide.getTitle(),
                            guide.getEditDate(),
                            guide.getIsBlocked(),
                            favoriteItemService.checkIfAddedToFavorites(guide.getId(), author)
                    ))
                    .toList();

            return new GuideInfoPageResponse(
                    totalPages,
                    dtos,
                    Integer.parseInt(pageNumber)
            );
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse pageNumber and/or pageSize values to Integer");
        }
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
