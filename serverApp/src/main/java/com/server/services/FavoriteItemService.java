package com.server.services;

import com.server.compositeId.FavoriteId;
import com.server.dto.*;
import com.server.repository.FavoriteItemRepository;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.NativeQuery;
import org.hibernate.type.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.server.entities.FavoriteItem;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;
import java.util.ArrayList;
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

    public GuideInfoPageResponse getFavorites(String email, String cursor, String pageSize) {
        if (email == null || cursor == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        var guideIds = favoriteItemRepository
                .findFavoritesByConcreteUser(email);

        List<GuideDTO> guides = new ArrayList<>();
        List<GuideDTO> allGuides = new ArrayList<>();

        try (SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory()) {
            Session session = sessionFactory.openSession();
            session.beginTransaction();

            NativeQuery<Object[]> query = session.createNativeQuery(
                            "SELECT id, creator_email, title, file_bytes, edit_date, is_blocked " +
                                    "FROM guides " +
                                    "JOIN (SELECT * FROM favorites f WHERE f.user_email IN (SELECT email FROM users u WHERE u.email = '" + email + "')) as ord " +
                                    "ON ord.guide_id = guides.id " +
                                    "WHERE (SELECT add_date_time FROM favorites WHERE guide_id = " + cursor + " AND user_email = '" + email + "')" + " > " + "ord.add_date_time " +
                                    "ORDER BY add_date_time DESC " +
                                    "LIMIT " + pageSize
                    )
                    .addScalar("id", LongType.INSTANCE)
                    .addScalar("creator_email", StringType.INSTANCE)
                    .addScalar("title", StringType.INSTANCE)
                    .addScalar("file_bytes", StringType.INSTANCE)
                    .addScalar("edit_date", TimestampType.INSTANCE)
                    .addScalar("is_blocked", BooleanType.INSTANCE);

            NativeQuery<Object[]> allQuery = session.createNativeQuery(
                            "SELECT id, creator_email, title, file_bytes, edit_date, is_blocked " +
                                    "FROM guides " +
                                    "JOIN (SELECT * FROM favorites f WHERE f.user_email IN (SELECT email FROM users u WHERE u.email = '" + email + "')) as ord " +
                                    "ON ord.guide_id = guides.id " +
                                    "ORDER BY add_date_time DESC " +
                                    "LIMIT " + pageSize
                    )
                    .addScalar("id", LongType.INSTANCE)
                    .addScalar("creator_email", StringType.INSTANCE)
                    .addScalar("title", StringType.INSTANCE)
                    .addScalar("file_bytes", StringType.INSTANCE)
                    .addScalar("edit_date", TimestampType.INSTANCE)
                    .addScalar("is_blocked", BooleanType.INSTANCE);

            var list = query.list();
            var allList = allQuery.list();

            for (var item : list) {
                guides.add(new GuideDTO(
                        (Long) item[0],
                        (String) item[1],
                        (String) item[2],
                        (String) item[3],
                        (Timestamp) item[4],
                        (Boolean) item[5],
                        checkIfAddedToFavorites((Long) item[0], email)
                ));
            }

            for (var item : allList) {
                allGuides.add(new GuideDTO(
                        (Long) item[0],
                        (String) item[1],
                        (String) item[2],
                        (String) item[3],
                        (Timestamp) item[4],
                        (Boolean) item[5],
                        checkIfAddedToFavorites((Long) item[0], email)
                ));
            }

            session.getTransaction().commit();
        }


        try {
            var pageNumberInt = Integer.parseInt(cursor);
            var pageSizeInt = Integer.parseInt(pageSize);

            int pageAmount;

            List<GuideInfoDTO> guideInfoList;

            if (pageNumberInt == -1) {
                pageAmount = getTotalPages(pageSizeInt, guideHandleRepository.findByIds(guideIds).size());
                guideInfoList = allGuides
                        .stream()
                        .map(guide -> new GuideInfoDTO(
                                guide.getId(),
                                guide.getCreatorLogin(),
                                guide.getTitle(),
                                guide.getEditDate(),
                                guide.getIsBlocked(),
                                checkIfAddedToFavorites(guide.getId(), email)
                        ))
                        .toList();
            } else {
                pageAmount = getTotalPages(pageSizeInt, guideHandleRepository.findByIds(guideIds).size());
                guideInfoList = guides
                        .stream()
                        .map(guide -> new GuideInfoDTO(
                                guide.getId(),
                                guide.getCreatorLogin(),
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
