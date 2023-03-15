package com.server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GuideInfoPageResponse {
    private Integer pageAmount;

    private List<GuideInfoDTO> guideInfoDTOS;

    private Integer currentPageNumber;
}
