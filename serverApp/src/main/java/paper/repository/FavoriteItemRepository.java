package paper.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import paper.compositeId.FavoriteId;
import paper.entities.FavoriteItem;


@Repository
public interface FavoriteItemRepository extends JpaRepository<FavoriteItem, FavoriteId> {
}
