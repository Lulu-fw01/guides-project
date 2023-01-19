package com.server.repository;

import com.server.compositeId.TagId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.server.entities.Tag;

import java.util.List;

@Repository
public interface TagRepository extends JpaRepository<Tag, TagId> {

    @Query(value = "SELECT category_name FROM tags WHERE guide_id = :id", nativeQuery = true)
    List<String> findTagsByGuideId(@Param("id") Long id);
}
