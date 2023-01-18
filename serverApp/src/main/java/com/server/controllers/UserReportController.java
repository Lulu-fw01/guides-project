package com.server.controllers;

import com.server.dto.UserReportDTO;
import com.server.entities.UserReport;
import com.server.services.UserReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/user-reports")
public class UserReportController {

    private final UserReportService userReportService;

    @Autowired
    public UserReportController(UserReportService userReportService) {
        this.userReportService = userReportService;
    }

    @PostMapping
    public void createReport(@RequestBody UserReportDTO userReport) {
        userReportService.createReport(userReport);
    }

    // TODO: add moderator actions
}
