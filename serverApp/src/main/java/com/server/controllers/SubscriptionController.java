package com.server.controllers;

import com.server.dto.SubscriptionDTO;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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

    // TODO: add unsubscribe method
    // TODO: get list of subscribers/subscriptions
}
