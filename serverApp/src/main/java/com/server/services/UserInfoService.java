package com.server.services;

import com.server.dto.PageRequestDTO;
import com.server.dto.UserInfoDTO;
import com.server.repository.UserRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class UserInfoService {

    private final UserRepository userRepository;

    public UserInfoService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserInfoDTO getUserInfoByEmail(String email) {
        if (email == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var user = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("The user does not exist"));

        return new UserInfoDTO(
                user.getEmail(), user.getLogin(), user.getBirthday(), user.getRole(), user.getIsBlocked()
        );
    }

    public List<UserInfoDTO> getAllUsers(PageRequestDTO userPagingDTO) {
        if (userPagingDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var users = userRepository.findAll(
                PageRequest.of(userPagingDTO.getPageNumber(), userPagingDTO.getPageSize(), Sort.by("email"))
        );

        return users
                .stream()
                .map(user -> new UserInfoDTO(
                        user.getEmail(),
                        user.getLogin(),
                        user.getBirthday(),
                        user.getRole(),
                        user.getIsBlocked()
                ))
                .toList();
    }
}
