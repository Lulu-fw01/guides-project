package com.server.controllers;

import com.server.dto.SubscriptionDTO;
import com.server.dto.UserDTO;
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
    public void subscribe(@RequestBody SubscriptionDTO subscription) {
        subscriptionService.subscribe(subscription);
    }

    @DeleteMapping
    public void unsubscribe(@RequestBody SubscriptionDTO subscription) {
        subscriptionService.unsubscribe(subscription);
    }

    @GetMapping("subscribers/{userEmail}")
    public List<UserDTO> getSubscribers(@PathVariable String userEmail) {
        return subscriptionService.getSubscribers(userEmail);
    }

    @GetMapping("{userEmail}")
    public List<UserDTO> getSubscriptions(@PathVariable String userEmail) {
        return subscriptionService.getSubscriptions(userEmail);
    }
}
