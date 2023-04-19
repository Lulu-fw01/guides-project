package com.server.services;

import com.server.repository.UserReportRepository;
import com.server.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class UserReportServiceTest {

    @Mock
    private UserReportRepository userReportRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserReportService userReportService;

    @Test
    public void createReportNull() {
        assertThrows(ResponseStatusException.class,
                () -> userReportService.createReport(null)
        );
    }
}