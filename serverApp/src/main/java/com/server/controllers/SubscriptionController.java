package com.server.controllers;

import com.server.dto.SubscriptionDTO;
import org.springframework.web.bind.annotation.*;
import com.server.services.SubscriptionService;

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

    // TODO: get list of subscribers/subscriptions
}
