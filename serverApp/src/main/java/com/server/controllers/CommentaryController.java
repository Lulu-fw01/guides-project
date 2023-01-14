package com.server.controllers;

import org.springframework.web.bind.annotation.*;
import com.server.dto.CommentaryResponseDTO;
import com.server.entities.Commentary;
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
    public void addCommentary(@RequestBody Commentary commentary) {
        commentaryService.addCommentary(commentary);
    }

    @DeleteMapping
    public void deleteCommentary(@RequestBody Commentary commentary) {
        commentaryService.deleteCommentary(commentary);
    }

    // TODO: PUT or PATCH method to edit commentary?

    @GetMapping
    public List<CommentaryResponseDTO> commentariesByPost(@RequestBody Long id) {
        return commentaryService.getCommentariesByPost(id);
    }
}
