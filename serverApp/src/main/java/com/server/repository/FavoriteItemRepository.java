package com.server.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.server.compositeId.FavoriteId;
import com.server.entities.FavoriteItem;


@Repository
public interface FavoriteItemRepository extends JpaRepository<FavoriteItem, FavoriteId> {
}
