package com.server.repository;

import com.server.entities.Guide;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GuideHandleRepository extends PagingAndSortingRepository<Guide, Long> {

    @Query(value = "SELECT * FROM guides WHERE id IN :ids", nativeQuery = true)
    List<Guide> findByIds(@Param("ids") List<Long> ids);

    @Query(value = "SELECT * FROM guides WHERE creator_email = :email", nativeQuery = true)
    List<Guide> findByUser(@Param("email") String email, Pageable pageable);
}
