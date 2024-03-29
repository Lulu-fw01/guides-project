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

    private String creatorLogin;

    private String title;

    private String fileBytes;

    private Timestamp editDate;

    private Boolean isBlocked;

    private Boolean addedToFavorites;
}
