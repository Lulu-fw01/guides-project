package com.server.controllers;

import com.server.dto.TagDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;
import com.server.services.TagService;

import java.util.List;

@RestController
@RequestMapping("api/v1/tags")
public class TagController {

    private final TagService tagService;

    public TagController(TagService tagService) {
        this.tagService = tagService;
    }

    @PostMapping
    @Operation(summary = "Create tag for guide")
    @SecurityRequirement(name = "Bearer Authentication")
    public void addTag(@RequestBody TagDTO tag) {
        tagService.addTag(tag);
    }

    @GetMapping("{id}")
    @Operation(summary = "Get tags for a guide")
    @SecurityRequirement(name = "Bearer Authentication")
    public List<String> getTags(@PathVariable("id") Long id) {
        return tagService.getTags(id);
    }

    @DeleteMapping
    @Operation(summary = "Remove tag from a guide")
    @SecurityRequirement(name = "Bearer Authentication")
    public void removeTag(@RequestBody TagDTO tag) {
        tagService.deleteTag(tag);
    }
}
