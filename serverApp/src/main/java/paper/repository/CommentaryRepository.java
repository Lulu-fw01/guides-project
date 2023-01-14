package paper.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import paper.entities.Commentary;

import java.util.List;

@Repository
public interface CommentaryRepository extends JpaRepository<Commentary, Long> {

    @Query(value = "SELECT * FROM comments WHERE guide_id = (SELECT id FROM guides WHERE id = :id)",
            nativeQuery = true)
    List<Commentary> commentariesByPost(@Param("id") Long id);
}
