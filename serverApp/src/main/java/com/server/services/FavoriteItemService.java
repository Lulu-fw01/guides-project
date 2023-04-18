package com.server.services;

import com.server.compositeId.FavoriteId;
import com.server.dto.*;
import com.server.entities.Guide;
import com.server.repository.FavoriteItemRepository;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.NativeQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.server.entities.FavoriteItem;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

@Service
public class FavoriteItemService {

    private static final int FIRST_PAGE_CURSOR = -1;
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

        if (Stream.of(favoriteItemDTO.getUserEmail(), favoriteItemDTO.getGuideId())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Some of the attributes are null. Consider using guideId, userEmail");
        }

        var favoriteItem = new FavoriteItem(
                new FavoriteId(
                        guideHandleRepository
                                .findById(favoriteItemDTO.getGuideId())
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Guide does not exist")),
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

        if (Stream.of(favoriteItemDTO.getUserEmail(), favoriteItemDTO.getGuideId())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Some of the attributes are null. Consider using guideId, userEmail");
        }

        var id = new FavoriteId(
                guideHandleRepository
                        .findById(favoriteItemDTO.getGuideId())
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Guide does not exist")),
                userRepository
                        .findByEmail(favoriteItemDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist"))
        );

        favoriteItemRepository.deleteById(id);
    }

    public GuideInfoPageResponse getFavorites(String email, String cursor, String pageSize) {
        if (email == null || cursor == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        int cursorInt;
        int pageSizeInt;

        try {
            cursorInt = Integer.parseInt(cursor);
            pageSizeInt = Integer.parseInt(pageSize);

            if (pageSizeInt < 1) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Page size must not be less than 1");
            }
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse Integer from Path variable");
        }

        var guideIds = favoriteItemRepository
                .findFavoritesByConcreteUser(email);

        List<Guide> guides = new ArrayList<>();
        List<Guide> allGuides = new ArrayList<>();

        try (SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory()) {
            Session session = sessionFactory.openSession();
            session.beginTransaction();

            NativeQuery<Object[]> query = favoriteItemRepository.getPagesByCursor(session, pageSizeInt, cursorInt, email);

            NativeQuery<Object[]> allQuery = favoriteItemRepository.getAllPages(session, pageSizeInt, email);

            var list = query.list();
            var allList = allQuery.list();

            populateListsFromQueries(guides, allGuides, list, allList);

            session.getTransaction().commit();
        }

        int pageAmount;

        List<GuideInfoDTO> guideInfoList;

        pageAmount = getTotalPages(pageSizeInt, guideHandleRepository.findByIds(guideIds).size());
        if (cursorInt == FIRST_PAGE_CURSOR) {
            guideInfoList = allGuides
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
        } else {
            guideInfoList = guides
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

        return new GuideInfoPageResponse(
                pageAmount,
                guideInfoList,
                cursorInt
        );
    }

    private void populateListsFromQueries(List<Guide> guides, List<Guide> allGuides, List<Object[]> list, List<Object[]> allList) {
        for (var item : list) {
            guides.add(new Guide(
                    (Long) item[0],
                    userRepository
                            .findByEmail((String) item[1])
                            .orElseThrow(() -> new UsernameNotFoundException("User not found")),
                    (String) item[2],
                    (String) item[3],
                    (Timestamp) item[4],
                    (Boolean) item[5]
            ));
        }

        for (var item : allList) {
            allGuides.add(new Guide(
                    (Long) item[0],
                    userRepository
                            .findByEmail((String) item[1])
                            .orElseThrow(() -> new UsernameNotFoundException("User not found")),
                    (String) item[2],
                    (String) item[3],
                    (Timestamp) item[4],
                    (Boolean) item[5]
            ));
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
