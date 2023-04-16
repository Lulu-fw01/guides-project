package com.server.dto;

import com.server.enums.ReportCategory;
import com.server.enums.ReportStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GuideReportDTO {
    private String reporterEmail;

    private Long guideId;

    private String comment;

    private ReportCategory reportCategory;
}
