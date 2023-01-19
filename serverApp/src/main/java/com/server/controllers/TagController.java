package com.server.controllers;

import com.server.dto.TagDTO;
import org.springframework.web.bind.annotation.*;
import com.server.entities.Tag;
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
    public void addTag(@RequestBody TagDTO tag) {
        tagService.addTag(tag);
    }

    @GetMapping
    public List<String> getTags(@RequestBody Long id) {
        return tagService.getTags(id);
    }

    @DeleteMapping
    public void removeTag(@RequestBody TagDTO tag) {
        tagService.deleteTag(tag);
    }
}
