package com.server.controllers;

import com.server.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
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
    public GuidePageResponse getListOfAllGuides(@RequestBody PageRequestDTO pageRequestDTO) {
        return guideHandleService.getListOfAllGuides(pageRequestDTO);
    }

    @PostMapping("/get-by-user")
    public GuidePageResponse getListOfGuidesByUser(@RequestBody UserGuidePageDTO userDTO) {
        return guideHandleService.getListOfGuidesByUser(userDTO);
    }

    @GetMapping("/{id}")
    public GuideDTO getGuideById(@PathVariable Long id) {
        return guideHandleService.getGuideById(id);
    }

    @PostMapping("/get-by-user/info")
    public GuideInfoPageResponse getListOfGuideInfoByUser(@RequestBody UserGuidePageDTO userDTO) {
        return guideHandleService.getListOfGuideInfoByUser(userDTO);
    }

    @PutMapping
    public void editGuide(@RequestBody GuideDTO guide) {
        guideHandleService.editGuide(guide);
    }

    // TODO: PATCH method to edit instead of PUT
}
