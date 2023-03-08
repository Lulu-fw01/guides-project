package com.server.services;

import com.server.dto.CreateGuideDTO;
import com.server.entities.Guide;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class GuideHandleServiceTest {

    @InjectMocks
    private GuideHandleService guideHandleService;

    @Mock
    private GuideHandleRepository guideHandleRepository;

    @Mock
    private UserRepository userRepository;

    @Test
    public void nullBodyRequestTest() {
        assertThrows(ResponseStatusException.class,
                () -> guideHandleService.nullBodyRequestCheck(null));
    }

    @Test
    public void checkIfSomeFieldIsNullTest() {
        assertThrows(ResponseStatusException.class,
                () -> guideHandleService.checkIfSomeFieldIsNull(
                        new Guide(null, "title", "c", new Timestamp(System.currentTimeMillis()), false)
                ));
    }

    @Test
    public void createGuideForNonExistingUser() {
        assertThrows(UsernameNotFoundException.class,
                () -> guideHandleService.createGuide(new CreateGuideDTO()));
    }

    // TODO: add more tests
}