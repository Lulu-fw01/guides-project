package com.server.repository;

import com.server.entities.Interaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.server.entities.Guide;

import java.util.List;

@Repository
public interface GuideHandleRepository extends PagingAndSortingRepository<Guide, Long> {

    @Query(value = "SELECT * FROM guides WHERE id IN :ids", nativeQuery = true)
    List<Guide> findByIds(@Param("ids") List<Long> ids);

    @Query(value = "SELECT * FROM guides WHERE creator_email = :email", nativeQuery = true)
    List<Guide> findByUser(@Param("email") String email);
}
