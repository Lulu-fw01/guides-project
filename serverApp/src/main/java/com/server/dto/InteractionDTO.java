package com.server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InteractionDTO {
    private String userEmail;

    private Long guideId;

    private Integer usersMark;

    private Timestamp viewDate;
}
