package com.server.controllers;

import com.server.dto.PageRequestDTO;
import com.server.dto.UserInfoDTO;
import com.server.services.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/users")
public class UserInfoController {

    private final UserInfoService userInfoService;

    @Autowired
    public UserInfoController(UserInfoService userInfoService) {
        this.userInfoService = userInfoService;
    }

    @PostMapping("all")
    public List<UserInfoDTO> getListOfAllUsers(@RequestBody PageRequestDTO userPagingDTO) {
        return userInfoService.getAllUsers(userPagingDTO);
    }

    @GetMapping("{email}")
    public UserInfoDTO getUserByEmail(@PathVariable String email) {
        return userInfoService.getUserInfoByEmail(email);
    }
}
