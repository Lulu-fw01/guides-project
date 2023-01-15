package com.server.services;

import com.server.entities.UserReport;
import com.server.repository.UserReportRepository;
import com.server.utils.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Objects;
import java.util.stream.Stream;

@Service
public class UserReportService implements ReportService, Validator {

    private final UserReportRepository userReportRepository;

    @Autowired
    public UserReportService(UserReportRepository userReportRepository) {
        this.userReportRepository = userReportRepository;
    }

    @Override
    public <T> void createReport(T report) {
        nullBodyRequestCheck(report);

        checkIfSomeFieldIsNull((UserReport) report);

        userReportRepository.save((UserReport) report);
    }

    @Override
    public <T> void checkIfSomeFieldIsNull(T obj) {
        var report = (UserReport) obj;
        if (Stream.of(report.getReporterEmail(),
                        report.getViolatorEmail(),
                        report.getComment(),
                        report.getCategory(),
                        report.getStatus())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format: " +
                            "reporter email, violator email, comment, category, status");
        }
    }

    @Override
    public <T> void nullBodyRequestCheck(T obj) {
        var report = (UserReport) obj;
        if (report == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Request body is null");
        }
    }

    // TODO: implement
    @Override
    public void resolve() {

    }

    @Override
    public void reject() {

    }
}
