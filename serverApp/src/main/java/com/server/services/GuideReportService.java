package com.server.services;

import com.server.dto.GuideReportDTO;
import com.server.entities.GuideReport;
import com.server.repository.GuideHandleRepository;
import com.server.repository.GuideReportRepository;
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
public class GuideReportService implements ReportService, Validator<GuideReport> {

    private final GuideReportRepository guideReportRepository;
    private final UserRepository userRepository;
    private final GuideHandleRepository guideHandleRepository;

    @Autowired
    public GuideReportService(GuideReportRepository guideReportRepository,
                              UserRepository userRepository,
                              GuideHandleRepository guideHandleRepository) {
        this.guideReportRepository = guideReportRepository;
        this.userRepository = userRepository;
        this.guideHandleRepository = guideHandleRepository;
    }

    @Override
    public <T> void createReport(T reportDTOGen) {
        var reportDTO = (GuideReportDTO) reportDTOGen;
        var report = new GuideReport(
                reportDTO.getId(),
                userRepository
                        .findByEmail(reportDTO.getReporterEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                guideHandleRepository
                        .findById(reportDTO.getGuideId())
                        .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")),
                reportDTO.getComment(),
                reportDTO.getReportCategory(),
                reportDTO.getReportStatus()
        );
        nullBodyRequestCheck(report);

        checkIfSomeFieldIsNull(report);

        guideReportRepository.save(report);
    }

    @Override
    public void checkIfSomeFieldIsNull(GuideReport obj) {
        if (Stream.of(obj.getReporterEmail(),
                        obj.getGuideId(),
                        obj.getComment(),
                        obj.getCategory(),
                        obj.getStatus())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format: " +
                            "reporter email, guide id, comment, category, status");
        }
    }

    @Override
    public void nullBodyRequestCheck(GuideReport obj) {
        if (obj == null) {
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
