package com.server.repository;

import com.server.compositeId.InteractionId;
import com.server.dto.InteractionDTO;
import com.server.dto.RatingDTO;
import com.server.entities.Guide;
import com.server.entities.Interaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InteractionRepository extends JpaRepository<Interaction, InteractionId> {

    @Query(value = "SELECT * FROM interactions WHERE user_email = :email", nativeQuery = true)
    List<Interaction> getPostsUserInteractedWith(@Param("email") String email);

    @Query(value = "SELECT user_email, guide_id, users_mark, view_date FROM interactions i " +
            "JOIN guides ON guide_id = guides.id " +
            "WHERE i.user_email = :email " +
            "ORDER BY i.view_date DESC " +
            "LIMIT 10", nativeQuery = true)
    List<InteractionDTO> getRecentlyViewed(@Param("email") String email);

    @Query(value = "SELECT guide_id, SUM(users_mark) as guide_rating " +
            "FROM interactions " +
            "GROUP BY guide_id " +
            "ORDER BY guide_rating " +
            "LIMIT 10", nativeQuery = true)
    List<RatingDTO> getTopRated();
}
