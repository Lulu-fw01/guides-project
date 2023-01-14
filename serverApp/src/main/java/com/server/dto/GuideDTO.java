package com.server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GuideDTO {

    private Long id;

    private String creatorEmail;

    private String title;

    private byte[] fileBytes;

    private Timestamp editDate;

    private Boolean isBlocked;
}
