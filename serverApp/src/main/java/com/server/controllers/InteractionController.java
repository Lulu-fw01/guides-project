package com.server.controllers;

import com.server.dto.GuideDTO;
import com.server.dto.InteractionDTO;
import com.server.services.InteractionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/interactions")
public class InteractionController {

    // TODO: get amount of likes/dislikes for each guide

    private final InteractionService interactionService;

    @Autowired
    public InteractionController(InteractionService interactionService) {
        this.interactionService = interactionService;
    }

    @GetMapping("{email}")
    @Operation(summary = "Get list of posts user interacted with")
    @SecurityRequirement(name = "Bearer Authentication")
    public List<InteractionDTO> getPostsUserInteractedWith(@PathVariable String email) {
        return interactionService.getPostsUserInteractedWith(email);
    }

    @PostMapping("reaction")
    @Operation(summary = "Set reaction")
    @SecurityRequirement(name = "Bearer Authentication")
    public void setReaction(@RequestBody InteractionDTO interactionDTO) {
        interactionService.setReaction(interactionDTO);
    }

    @DeleteMapping("reaction")
    @Operation(summary = "Delete reaction")
    @SecurityRequirement(name = "Bearer Authentication")
    public void deleteReaction(@RequestBody InteractionDTO interactionDTO) {
        interactionService.deleteReaction(interactionDTO);
    }

    @GetMapping("top")
    @Operation(summary = "Get top rated guides")
    @SecurityRequirement(name = "Bearer Authentication")
    public List<GuideDTO> getTopRated() {
        return interactionService.getTopRated();
    }
}
