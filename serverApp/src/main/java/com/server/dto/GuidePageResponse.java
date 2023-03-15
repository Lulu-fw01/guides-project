package com.server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GuidePageResponse {
    private Integer pageAmount;

    private List<GuideDTO> guideDTOList;

    private Integer currentPageNumber;
}
