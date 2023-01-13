package paper.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import paper.entities.Guide;

@Repository
public interface GuideHandleRepository extends JpaRepository<Guide, Long> {
}
