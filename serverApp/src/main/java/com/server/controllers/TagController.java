package com.server.controllers;

import com.server.dto.TagDTO;
import org.springframework.web.bind.annotation.*;
import com.server.entities.Tag;
import com.server.services.TagService;

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

    // TODO: fix deleting
//    @DeleteMapping
//    public void deleteTag(@RequestBody Tag tag) {
//        tagService.deleteTag(tag);
//    }
}
