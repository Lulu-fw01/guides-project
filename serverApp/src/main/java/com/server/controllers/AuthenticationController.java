package com.server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.server.dto.JwtResponseDTO;
import com.server.dto.LoginDTO;
import com.server.dto.RegisterDTO;
import com.server.services.AuthenticationService;

@RestController
@RequestMapping("api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @Autowired
    public AuthenticationController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }

    @PostMapping("/register")
    public JwtResponseDTO register(@RequestBody RegisterDTO registerRequestBody) {
        return authenticationService.register(registerRequestBody);
    }

    @GetMapping
    public JwtResponseDTO login(@RequestBody LoginDTO loginRequestBody) {
        return authenticationService.login(loginRequestBody);
    }
}
