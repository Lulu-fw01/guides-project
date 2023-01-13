package paper.controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import paper.entities.Subscription;
import paper.services.SubscriptionService;

@RestController
@RequestMapping("api/v1/subscriptions")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;

    public SubscriptionController(SubscriptionService subscriptionService) {
        this.subscriptionService = subscriptionService;
    }

    @PostMapping
    public void subscribe(@RequestBody Subscription subscription) {
        subscriptionService.subscribe(subscription);
    }

    // TODO: add unsubscribe method
    // TODO: get list of subscribers/subscriptions
}
