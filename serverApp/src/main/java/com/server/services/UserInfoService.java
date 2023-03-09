package com.server.services;

import com.server.dto.PageRequestDTO;
import com.server.dto.UserInfoDTO;
import com.server.repository.GuideHandleRepository;
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

    private final GuideHandleRepository guideHandleRepository;

    public UserInfoService(UserRepository userRepository,
                           GuideHandleRepository guideHandleRepository) {
        this.userRepository = userRepository;
        this.guideHandleRepository = guideHandleRepository;
    }

    public UserInfoDTO getUserInfoByEmail(String email) {
        if (email == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var user = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("The user does not exist"));

        return new UserInfoDTO(
                user.getEmail(),
                user.getLogin(),
                user.getBirthday(),
                user.getRole(),
                user.getIsBlocked(),
                guideHandleRepository.getCountOfGuidesByUser(email)
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
                        user.getIsBlocked(),
                        guideHandleRepository.getCountOfGuidesByUser(user.getEmail())
                ))
                .toList();
    }
}
