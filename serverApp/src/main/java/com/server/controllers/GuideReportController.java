package com.server.controllers;

import com.server.dto.GuideReportDTO;
import com.server.services.GuideReportService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/guide-reports")
public class GuideReportController {

    private final GuideReportService guideReportService;

    @Autowired
    public GuideReportController(GuideReportService guideReportService) {
        this.guideReportService = guideReportService;
    }

    @PostMapping
    @Operation(summary = "Create guide report")
    @SecurityRequirement(name = "Bearer Authentication")
    public void createReport(@RequestBody GuideReportDTO guideReport) {
        guideReportService.createReport(guideReport);
    }

    // TODO: add moderator actions
}
