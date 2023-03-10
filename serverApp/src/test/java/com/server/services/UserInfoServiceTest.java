package com.server.services;

import com.server.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.server.ResponseStatusException;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class UserInfoServiceTest {

    @InjectMocks
    private UserInfoService userInfoService;

    @Mock
    private UserRepository userRepository;

    @Test
    public void getUserInfoByEmailNull() {
        assertThrows(
                ResponseStatusException.class,
                () -> userInfoService.getUserInfoByEmail(null)
        );
    }

    @Test
    public void getAllUsersNull() {
        assertThrows(
                ResponseStatusException.class,
                () -> userInfoService.getAllUsers(null)
        );
    }

    @Test
    public void getNonExistingUser() {
        assertThrows(
                UsernameNotFoundException.class,
                () -> userInfoService.getUserInfoByEmail("email")
        );
    }
}