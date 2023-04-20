package com.server.services;

import com.server.dto.LoginDTO;
import com.server.dto.RegisterDTO;
import com.server.entities.User;
import com.server.enums.UserRoles;
import com.server.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Date;
import java.util.HashMap;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class AuthenticationServiceTest {

    @Mock
    private JwtService jwtService;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AuthenticationService authenticationService;

    private User user;

    @BeforeEach
    public void initUser() {
        user = new User();
    }

    @Test
    public void registerWithNullRegisterBody() {
        assertThrows(ResponseStatusException.class, () -> authenticationService.register(null), "The request body is null");
    }

    @Test
    public void registerWhenOneAttributeIsMissing() {
        assertThrows(ResponseStatusException.class,
                () -> authenticationService.register(new RegisterDTO(null, "ll", "p", new Date(System.currentTimeMillis()))),
                "One of the transferred attributes is null." +
                        " Consider sending request in the following format:" +
                        " email, login, password, date");

        assertThrows(ResponseStatusException.class,
                () -> authenticationService.register(new RegisterDTO("e", null, "p", new Date(System.currentTimeMillis()))),
                "One of the transferred attributes is null." +
                        " Consider sending request in the following format:" +
                        " email, login, password, date");

        assertThrows(ResponseStatusException.class,
                () -> authenticationService.register(new RegisterDTO(null, null, null, null)),
                "One of the transferred attributes is null." +
                        " Consider sending request in the following format:" +
                        " email, login, password, date");
    }

    @Test
    public void registerWithIncorrectLogin() {
        assertThrows(ResponseStatusException.class,
                () -> authenticationService.register(new RegisterDTO("email", "l", "p", new Date(System.currentTimeMillis())))
        );

        assertThrows(ResponseStatusException.class,
                () -> authenticationService.register(new RegisterDTO("email", "llllllllllllllllllllll", "p", new Date(System.currentTimeMillis())))
        );
    }

    @Test
    public void registerDuplicateUser() {
        when(userRepository.findByEmail("email@email.com")).thenReturn(Optional.of(user));

        assertThrows(ResponseStatusException.class,
                () -> authenticationService.register(new RegisterDTO("email@email.com", "l", "p", new Date(System.currentTimeMillis()))),
                "The user already exists");
    }

    @Test
    public void saveUserToRepository() {
        when(userRepository.save(user)).thenReturn(user);

        assertEquals(userRepository.save(user), user);
    }

    @Test
    public void generateToken() {
        when(jwtService.generateToken(new HashMap<>(), user)).thenReturn("token");

        assertEquals(jwtService.generateToken(new HashMap<>(), user), "token");
    }

    @Test
    public void loginWithNullRegisterBody() {
        assertThrows(ResponseStatusException.class, () -> authenticationService.login(null), "The request body is null");
    }

    @Test
    public void loginWhenOneAttributeIsMissing() {
        assertThrows(ResponseStatusException.class,
                () -> authenticationService.login(new LoginDTO(null, "p")),
                "One of the transferred attributes is null." +
                        " Consider sending request in the following format:" +
                        " email, password");

        assertThrows(ResponseStatusException.class,
                () -> authenticationService.login(new LoginDTO(null, null)),
                "One of the transferred attributes is null." +
                        " Consider sending request in the following format:" +
                        " email, password");

        assertThrows(ResponseStatusException.class,
                () -> authenticationService.login(new LoginDTO("e", null)),
                "One of the transferred attributes is null." +
                        " Consider sending request in the following format:" +
                        " email, password");
    }
}