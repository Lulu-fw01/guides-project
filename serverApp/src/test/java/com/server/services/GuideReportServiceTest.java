package com.server.services;

import com.server.repository.GuideHandleRepository;
import com.server.repository.GuideReportRepository;
import com.server.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class GuideReportServiceTest {

    @Mock
    private GuideReportRepository guideReportRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private GuideHandleRepository guideHandleRepository;

    @InjectMocks
    private GuideReportService guideReportService;

    @Test
    public void createNullReport() {
        assertThrows(ResponseStatusException.class,
                () -> guideReportService.createReport(null));
    }
}