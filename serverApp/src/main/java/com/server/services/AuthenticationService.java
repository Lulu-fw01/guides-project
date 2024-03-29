package com.server.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.server.dto.JwtResponseDTO;
import com.server.dto.LoginDTO;
import com.server.dto.RegisterDTO;
import com.server.entities.User;
import com.server.enums.UserRoles;
import com.server.repository.UserRepository;

import java.util.HashMap;
import java.util.Objects;
import java.util.stream.Stream;

@Service
public class AuthenticationService {

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    private final JwtService jwtService;

    private final AuthenticationManager authenticationManager;

    @Autowired
    public AuthenticationService(UserRepository userRepository,
                                 PasswordEncoder passwordEncoder,
                                 JwtService jwtService,
                                 AuthenticationManager authenticationManager) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
    }

    public JwtResponseDTO register(RegisterDTO registerRequestBody) {
        if (registerRequestBody == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (Stream.of(registerRequestBody.getEmail(), registerRequestBody.getLogin(),
                        registerRequestBody.getPassword())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format:" +
                            " email, login, password, date");
        }

        if (userRepository.findByEmail(registerRequestBody.getEmail()).isPresent()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Пользователь уже зарегистрирован на данную почту");
        }

        if (userRepository.findByLogin(registerRequestBody.getLogin()).isPresent()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Логин занят");
        }

        if (registerRequestBody.getLogin().length() < 2 || registerRequestBody.getLogin().length() > 20) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Логин не может быть менее двух или более 20 символов");
        }

        var user = new User(
                registerRequestBody.getEmail(),
                registerRequestBody.getLogin(),
                passwordEncoder.encode(registerRequestBody.getPassword()),
                registerRequestBody.getDate(), // mock date
                UserRoles.USER,
                false
        );

        userRepository.save(user);

        var jwt = jwtService.generateToken(new HashMap<>(), user);

        return new JwtResponseDTO(jwt);
    }

    public JwtResponseDTO login(LoginDTO loginRequestBody) {
        if (loginRequestBody == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (Stream.of(loginRequestBody.getEmail(), loginRequestBody.getPassword())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format:" +
                            " email, password");
        }

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequestBody.getEmail(),
                        loginRequestBody.getPassword()
                )
        );

        var user = userRepository
                .findByEmail(loginRequestBody.getEmail())
                .orElseThrow();

        var jwt = jwtService.generateToken(new HashMap<>(), user);

        return new JwtResponseDTO(jwt);
    }
}
