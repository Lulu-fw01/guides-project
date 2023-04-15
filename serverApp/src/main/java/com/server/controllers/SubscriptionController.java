package com.server.controllers;

import com.server.dto.SubscriptionDTO;
import com.server.dto.UserDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;
import com.server.services.SubscriptionService;

import java.util.List;

@RestController
@RequestMapping("api/v1/subscriptions")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;

    public SubscriptionController(SubscriptionService subscriptionService) {
        this.subscriptionService = subscriptionService;
    }

    @PostMapping
    @Operation(summary = "Subscribe to a user")
    @SecurityRequirement(name = "Bearer Authentication")
    public void subscribe(@RequestBody SubscriptionDTO subscription) {
        subscriptionService.subscribe(subscription);
    }

    @DeleteMapping
    @Operation(summary = "Unsubscribe")
    @SecurityRequirement(name = "Bearer Authentication")
    public void unsubscribe(@RequestBody SubscriptionDTO subscription) {
        subscriptionService.unsubscribe(subscription);
    }

    @GetMapping("subscribers/{userEmail}")
    @Operation(summary = "Get list of subscribers")
    @SecurityRequirement(name = "Bearer Authentication")
    public List<UserDTO> getSubscribers(@PathVariable String userEmail) {
        return subscriptionService.getSubscribers(userEmail);
    }

    @GetMapping("{userEmail}")
    @Operation(summary = "Get list of subscriptions")
    @SecurityRequirement(name = "Bearer Authentication")
    public List<UserDTO> getSubscriptions(@PathVariable String userEmail) {
        return subscriptionService.getSubscriptions(userEmail);
    }
}
