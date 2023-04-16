package com.server.controllers;

import com.server.dto.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
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
    @Operation(summary = "Create guide")
    @SecurityRequirement(name = "Bearer Authentication")
    public void createGuide(@RequestBody CreateGuideDTO guide) {
        guideHandleService.createGuide(guide);
    }

    @DeleteMapping
    @Operation(summary = "Remove guide")
    @SecurityRequirement(name = "Bearer Authentication")
    public void removeGuide(@RequestBody Long id) {
        guideHandleService.removeGuide(id);
    }

    @PostMapping("get-page")
    @Operation(summary = "Get a page of all guides")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuidePageResponse getListOfAllGuides(@RequestBody PageRequestDTO pageRequestDTO) {
        return guideHandleService.getListOfAllGuides(pageRequestDTO);
    }

    @PostMapping("get-by-user")
    @Operation(summary = "Get guide page by user")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuidePageResponse getListOfGuidesByUser(@RequestBody UserGuidePageDTO userDTO) {
        return guideHandleService.getListOfGuidesByUser(userDTO);
    }

    @GetMapping("{id}")
    @Operation(summary = "Get guide by its id")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuideDTO getGuideById(@PathVariable Long id) {
        return guideHandleService.getGuideById(id);
    }

    @PostMapping("get-by-user/info")
    @Operation(summary = "Get page of guide info by user")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuideInfoPageResponse getListOfGuideInfoByUser(@RequestBody UserGuidePageDTO userDTO) {
        return guideHandleService.getListOfGuideInfoByUser(userDTO);
    }

    @PutMapping
    @Operation(summary = "Edit guide")
    @SecurityRequirement(name = "Bearer Authentication")
    public void editGuide(@RequestBody EditGuideDTO guide) {
        guideHandleService.editGuide(guide);
    }

    // TODO: PATCH method to edit instead of PUT
}
