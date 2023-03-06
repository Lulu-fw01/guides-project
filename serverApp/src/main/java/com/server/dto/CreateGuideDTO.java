package com.server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateGuideDTO {

    private String creatorEmail;

    private String title;

    private String fileBytes;
}
