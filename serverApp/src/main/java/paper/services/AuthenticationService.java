package paper.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import paper.dto.JwtResponseDTO;
import paper.dto.LoginDTO;
import paper.dto.RegisterDTO;
import paper.entities.User;
import paper.enums.UserRoles;
import paper.repository.UserRepository;

import java.sql.Date;
import java.util.HashMap;

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
        // TODO handle mocks
        var user = new User(
               registerRequestBody.getEmail(),
               "mockName",
               "mockLogin",
                passwordEncoder.encode(registerRequestBody.getPassword()),
                Date.valueOf("2023-01-01"), // mock date
                UserRoles.user,
                false
        );

        userRepository.save(user);

        var jwt = jwtService.generateToken(new HashMap<>(), user);

        return new JwtResponseDTO(jwt);
    }

    public JwtResponseDTO login(LoginDTO loginRequestBody) {
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
