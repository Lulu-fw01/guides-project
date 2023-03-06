package com.server.controllers;

import com.server.dto.CreateGuideDTO;
import com.server.dto.GuideDTO;
import com.server.dto.GuidePageDTO;
import com.server.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.server.entities.Guide;
import com.server.services.GuideHandleService;

import java.util.List;

@RestController
@RequestMapping(path = "api/v1/guide-handling")
public class GuideHandleController {

    private final GuideHandleService guideHandleService;

    @Autowired
    public GuideHandleController(GuideHandleService guideHandleService) {
        this.guideHandleService = guideHandleService;
    }

    @PostMapping
    public void createGuide(@RequestBody CreateGuideDTO guide) {
        guideHandleService.createGuide(guide);
    }

    @DeleteMapping
    public void removeGuide(@RequestBody Long id) {
        guideHandleService.removeGuide(id);
    }

    @PostMapping("/get-page")
    public List<GuideDTO> getListOfAllGuides(@RequestBody GuidePageDTO guidePageDTO) {
        return guideHandleService.getListOfAllGuides(guidePageDTO);
    }

    @PostMapping("/get-by-user")
    public List<GuideDTO> getListOfGuidesByUser(@RequestBody UserDTO userDTO) {
        return guideHandleService.getListOfGuidesByUser(userDTO);
    }

    @PutMapping
    public void editGuide(@RequestBody GuideDTO guide) {
        guideHandleService.editGuide(guide);
    }

    // TODO: PATCH method to edit instead of PUT
}
