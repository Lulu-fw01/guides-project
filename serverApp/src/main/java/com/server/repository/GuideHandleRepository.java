package com.server.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.server.entities.Guide;

@Repository
public interface GuideHandleRepository extends JpaRepository<Guide, Long> {
}
