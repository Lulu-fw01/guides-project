package com.server.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.server.compositeId.FavoriteId;
import com.server.entities.FavoriteItem;

import java.util.List;


@Repository
public interface FavoriteItemRepository extends JpaRepository<FavoriteItem, FavoriteId> {

    @Query(value =
            "SELECT guide_id FROM favourites f WHERE f.user_email IN " +
            "(SELECT email FROM users u WHERE u.email = :email)", nativeQuery = true)
    List<Long> findFavoritesByConcreteUser(@Param("email") String email);
}
