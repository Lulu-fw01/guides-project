package com.server.controllers;

import com.server.dto.GuideDTO;
import com.server.dto.InteractionDTO;
import com.server.dto.UserDTO;
import com.server.services.InteractionService;
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

    @GetMapping
    public List<InteractionDTO> getPostsUserInteractedWith(@RequestBody UserDTO user) {
        return interactionService.getPostsUserInteractedWith(user);
    }

    @PostMapping("/reaction")
    public void setReaction(@RequestBody InteractionDTO interactionDTO) {
        interactionService.setReaction(interactionDTO);
    }

    @DeleteMapping("/reaction")
    public void deleteReaction(@RequestBody InteractionDTO interactionDTO) {
        interactionService.deleteReaction(interactionDTO);
    }

//    @GetMapping("/recently-viewed")
//    public List<GuideDTO> getRecentlyViewed(@RequestBody UserDTO user) {
//        return interactionService.getRecentlyViewed(user);
//    }
//
//    @GetMapping("/top")
//    public List<GuideDTO> getTopRated() {
//        return interactionService.getTopRated();
//    }
}
