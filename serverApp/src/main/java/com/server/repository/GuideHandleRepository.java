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

    @Query(value = "SELECT * FROM guides WHERE title ILIKE CONCAT('%',:title,'%') ", nativeQuery = true)
    List<Guide> searchByTitle(@Param("title") String title, Pageable pageable);

    @Query(value = "SELECT * FROM guides WHERE id IN (SELECT guide_id FROM tags WHERE category_name = :category)", nativeQuery = true)
    List<Guide> searchByCategory(@Param("category") String category, Pageable pageable);

    @Query(value = "SELECT * FROM guides WHERE creator_email IN (SELECT email FROM users WHERE login ILIKE CONCAT('%',:author,'%'))", nativeQuery = true)
    List<Guide> searchByAuthor(@Param("author") String category, Pageable pageable);
}
