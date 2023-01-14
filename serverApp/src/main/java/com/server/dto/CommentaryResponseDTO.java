package com.server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentaryResponseDTO {

    private Long id;

    private String userEmail;

    private Long guideId;

    private Timestamp editDate;

    private String contents;
}
