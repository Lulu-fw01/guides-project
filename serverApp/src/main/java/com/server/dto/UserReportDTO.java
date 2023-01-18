package com.server.dto;

import com.server.enums.ReportCategory;
import com.server.enums.ReportStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserReportDTO {
    private Long id;

    private String reporterEmail;

    private String violatorEmail;

    private String comment;

    private ReportCategory reportCategory;

    private ReportStatus reportStatus;
}
