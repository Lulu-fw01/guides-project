package com.server.controllers;

import com.server.dto.CommentaryIdDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;
import com.server.dto.CommentaryDTO;
import com.server.services.CommentaryService;

import java.util.List;


@RestController
@RequestMapping("api/v1/commentaries")
public class CommentaryController {

    private final CommentaryService commentaryService;

    public CommentaryController(CommentaryService commentaryService) {
        this.commentaryService = commentaryService;
    }

    @PostMapping
    @Operation(summary = "Add commentary to a guide")
    @SecurityRequirement(name = "Bearer Authentication")
    public void addCommentary(@RequestBody CommentaryDTO commentary) {
        commentaryService.addCommentary(commentary);
    }

    @DeleteMapping
    @Operation(summary = "Delete commentary")
    @SecurityRequirement(name = "Bearer Authentication")
    public void deleteCommentary(@RequestBody CommentaryIdDTO commentary) {
        commentaryService.deleteCommentary(commentary);
    }

    // TODO: PUT or PATCH method to edit commentary?

    @GetMapping("{id}")
    @Operation(summary = "Get list of commentaries by guide id")
    @SecurityRequirement(name = "Bearer Authentication")
    public List<CommentaryDTO> commentariesByPost(@PathVariable("id") Long id) {
        return commentaryService.getCommentariesByPost(id);
    }
}
