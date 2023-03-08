package com.server.dto;

import com.server.enums.UserRoles;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserInfoDTO {
    private String email;

    private String login;

    private Date birthday;

    private UserRoles role;

    private Boolean isBlocked;
}
