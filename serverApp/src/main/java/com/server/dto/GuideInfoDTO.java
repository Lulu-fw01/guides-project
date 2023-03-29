package com.server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GuideInfoDTO {

    private Long id;

    private String creatorLogin;

    private String title;

    private Timestamp editDate;

    private Boolean isBlocked;

    private Boolean addedToFavorites;
}
