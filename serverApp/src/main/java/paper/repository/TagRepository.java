package paper.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import paper.compositeId.TagId;
import paper.models.Tag;

@Repository
public interface TagRepository extends JpaRepository<Tag, TagId> {
}
