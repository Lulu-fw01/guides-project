package paper.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import paper.models.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, String> {
}
