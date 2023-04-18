package com.server.services;

import com.server.compositeId.InteractionId;
import com.server.dto.GuideDTO;
import com.server.dto.InteractionDTO;
import com.server.dto.RatingDTO;
import com.server.entities.Interaction;
import com.server.repository.GuideHandleRepository;
import com.server.repository.InteractionRepository;
import com.server.repository.UserRepository;
import com.server.utils.AuthUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.NativeQuery;
import org.hibernate.type.IntegerType;
import org.hibernate.type.LongType;
import org.hibernate.type.StringType;
import org.hibernate.type.TimestampType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

@Service
public class InteractionService {
    private final InteractionRepository interactionRepository;
    private final UserRepository userRepository;
    private final GuideHandleRepository guideHandleRepository;
    private final FavoriteItemService favoriteItemService;

    @Autowired
    public InteractionService(InteractionRepository interactionRepository,
                              UserRepository userRepository,
                              GuideHandleRepository guideHandleRepository,
                              FavoriteItemService favoriteItemService) {
        this.interactionRepository = interactionRepository;
        this.userRepository = userRepository;
        this.guideHandleRepository = guideHandleRepository;
        this.favoriteItemService = favoriteItemService;
    }

    public List<InteractionDTO> getPostsUserInteractedWith(String email) {
        return interactionRepository
                .getPostsUserInteractedWith(email)
                .stream()
                .map(interaction -> new InteractionDTO(
                        interaction.getInteractionId().getEmail().getEmail(),
                        interaction.getInteractionId().getId().getId(),
                        interaction.getUsersMark()
                ))
                .toList();
    }

    public void setReaction(InteractionDTO interactionDTO) {
        if (interactionDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (Stream.of(interactionDTO.getGuideId(), interactionDTO.getUsersMark(), interactionDTO.getUserEmail())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Some of the attributes are null. \nConsider using userEmail, guideId, usersMark");
        }

        var interaction = new Interaction(
                new InteractionId(
                        userRepository
                                .findByEmail(interactionDTO.getUserEmail())
                                .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                        guideHandleRepository
                                .findById(interactionDTO.getGuideId())
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "The guide does not exist"))
                ),
                interactionDTO.getUsersMark(),
                new Timestamp(System.currentTimeMillis())
        );

        interactionRepository.save(interaction);
    }

    public void deleteReaction(InteractionDTO interactionDTO) {
        if (interactionDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (Stream.of(interactionDTO.getGuideId(), interactionDTO.getUserEmail())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Some of the attributes are null. \nConsider using userEmail, guideId");
        }

        var id = new InteractionId(
                userRepository
                        .findByEmail(interactionDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                guideHandleRepository
                        .findById(interactionDTO.getGuideId())
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "The guide does not exist"))
        );

        if (interactionRepository.existsById(id)) {
            interactionRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Id does not exist");
        }
    }

    public List<GuideDTO> getTopRated() {
        List<GuideDTO> result;
        try (SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory()) {
            Session session = sessionFactory.openSession();
            session.beginTransaction();

            NativeQuery<Object[]> query = session.createNativeQuery(
                            "SELECT guide_id, SUM(users_mark) as guide_rating " +
                                    "FROM interactions " +
                                    "GROUP BY guide_id " +
                                    "ORDER BY guide_rating " +
                                    "LIMIT 10")
                    .addScalar("guide_id", LongType.INSTANCE)
                    .addScalar("guide_rating", IntegerType.INSTANCE);

            var list = query.list();

            List<RatingDTO> ratings = new ArrayList<>();
            for (var item : list) {
                ratings.add(new RatingDTO((Long) item[0], (Integer) item[1]));
            }

            result = ratings
                    .stream()
                    .map(rated -> guideHandleRepository
                            .findById(rated.getGuideId())
                            .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")))
                    .map(guide -> new GuideDTO(
                            guide.getId(),
                            guide.getCreatorEmail().getLogin(),
                            guide.getTitle(),
                            guide.getFileBytes(),
                            guide.getEditDate(),
                            guide.getIsBlocked(),
                            favoriteItemService.checkIfAddedToFavorites(guide.getId(), AuthUtil.getAuthenticatedUser())
                    ))
                    .toList();

            session.getTransaction().commit();
        }
        return result;
    }
}
