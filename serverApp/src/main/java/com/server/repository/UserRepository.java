package com.server.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import com.server.entities.User;

import java.util.Optional;

@Repository
public interface UserRepository extends PagingAndSortingRepository<User, String> {

    Optional<User> findByEmail(String email);

    Optional<User> findByLogin(String login);
}
