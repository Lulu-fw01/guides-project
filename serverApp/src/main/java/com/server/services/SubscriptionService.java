package com.server.services;

import com.server.repository.SubscriptionRepository;
import org.springframework.stereotype.Service;
import com.server.entities.Subscription;

@Service
public class SubscriptionService {

    private final SubscriptionRepository subscriptionRepository;

    public SubscriptionService(SubscriptionRepository subscriptionRepository) {
        this.subscriptionRepository = subscriptionRepository;
    }

    public void subscribe(Subscription subscription) {
        subscriptionRepository.save(subscription);
    }
}
