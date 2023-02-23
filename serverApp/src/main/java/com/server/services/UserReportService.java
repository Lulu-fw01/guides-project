package com.server.services;

import com.server.dto.UserReportDTO;
import com.server.entities.UserReport;
import com.server.repository.UserReportRepository;
import com.server.repository.UserRepository;
import com.server.utils.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Objects;
import java.util.stream.Stream;

@Service
public class UserReportService implements ReportService, Validator<UserReport> {

    private final UserReportRepository userReportRepository;
    private final UserRepository userRepository;

    @Autowired
    public UserReportService(UserReportRepository userReportRepository, UserRepository userRepository) {
        this.userReportRepository = userReportRepository;
        this.userRepository = userRepository;
    }

    @Override
    public <T> void createReport(T reportDTOGen) {
        var reportDTO = (UserReportDTO) reportDTOGen;
        var report = new UserReport(
                userRepository
                        .findByEmail(reportDTO.getReporterEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User reporter does not exist")),
                userRepository
                        .findByEmail(reportDTO.getReporterEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("Violator user does not exist")),
                reportDTO.getComment(),
                reportDTO.getReportCategory(),
                reportDTO.getReportStatus()
        );

        nullBodyRequestCheck(report);

        checkIfSomeFieldIsNull(report);

        userReportRepository.save(report);
    }

    @Override
    public void checkIfSomeFieldIsNull(UserReport obj) {
        if (Stream.of(obj.getReporterEmail(),
                        obj.getViolatorEmail(),
                        obj.getComment(),
                        obj.getCategory(),
                        obj.getStatus())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format: " +
                            "reporter email, violator email, comment, category, status");
        }
    }

    @Override
    public void nullBodyRequestCheck(UserReport obj) {
        if (obj == null) {
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
