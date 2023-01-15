package com.server.controllers;

import com.server.entities.GuideReport;
import com.server.services.GuideReportService;
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
    public void createReport(@RequestBody GuideReport guideReport) {
        guideReportService.createReport(guideReport);
    }

    // TODO: add moderator actions
}
