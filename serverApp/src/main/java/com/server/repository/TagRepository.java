package com.server.repository;

import com.server.compositeId.TagId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.server.entities.Tag;

@Repository
public interface TagRepository extends JpaRepository<Tag, TagId> {
}
