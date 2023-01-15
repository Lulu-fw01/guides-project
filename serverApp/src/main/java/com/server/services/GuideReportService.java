package com.server.services;

import com.server.entities.GuideReport;
import com.server.repository.GuideReportRepository;
import com.server.utils.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Objects;
import java.util.stream.Stream;

@Service
public class GuideReportService implements ReportService, Validator {

    private final GuideReportRepository guideReportRepository;

    @Autowired
    public GuideReportService(GuideReportRepository guideReportRepository) {
        this.guideReportRepository = guideReportRepository;
    }

    @Override
    public <T> void createReport(T report) {
        nullBodyRequestCheck(report);

        checkIfSomeFieldIsNull((GuideReport) report);

        guideReportRepository.save((GuideReport) report);
    }

    @Override
    public <T> void checkIfSomeFieldIsNull(T obj) {
        var report = (GuideReport) obj;
        if (Stream.of(report.getReporterEmail(),
                        report.getGuideId(),
                        report.getComment(),
                        report.getCategory(),
                        report.getStatus())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format: " +
                            "reporter email, guide id, comment, category, status");
        }
    }

    @Override
    public <T> void nullBodyRequestCheck(T obj) {
        var report = (GuideReport) obj;
        if (report == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Request body is null");
        }
    }

    // TODO: implement later
    @Override
    public void resolve() {

    }

    @Override
    public void reject() {

    }
}
