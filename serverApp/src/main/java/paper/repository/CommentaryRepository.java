package paper.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import paper.entities.Commentary;

@Repository
public interface CommentaryRepository extends JpaRepository<Commentary, Long> {
}
