package com.server.controllers;

import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.springframework.web.bind.annotation.*;
import com.server.dto.CommentaryDTO;
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
    public void addCommentary(@RequestBody CommentaryDTO commentary) {
        commentaryService.addCommentary(commentary);
    }

    @DeleteMapping
    public void deleteCommentary(@RequestBody CommentaryDTO commentary) {
        commentaryService.deleteCommentary(commentary);
    }

    // TODO: PUT or PATCH method to edit commentary?

    @GetMapping
    public List<CommentaryDTO> commentariesByPost(@RequestBody Long id) {
        return commentaryService.getCommentariesByPost(id);
    }
}
