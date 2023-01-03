package server.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import server.models.Guide;

@Repository
public interface GuideHandleRepository extends JpaRepository<Guide, Long> {
}
