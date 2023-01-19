package com.server.services;

import com.server.compositeId.SubscriptionId;
import com.server.dto.SubscriptionDTO;
import com.server.repository.SubscriptionRepository;
import com.server.repository.UserRepository;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.server.entities.Subscription;

@Service
public class SubscriptionService {

    private final SubscriptionRepository subscriptionRepository;
    private final UserRepository userRepository;

    public SubscriptionService(SubscriptionRepository subscriptionRepository, UserRepository userRepository) {
        this.subscriptionRepository = subscriptionRepository;
        this.userRepository = userRepository;
    }

    public void subscribe(SubscriptionDTO subscriptionDTO) {
        var subscription = new Subscription(
                new SubscriptionId(
                        userRepository
                                .findByEmail(subscriptionDTO.getUserEmail())
                                .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                        userRepository
                                .findByEmail(subscriptionDTO.getSubscriptionUserEmail())
                                .orElseThrow(() ->
                                        new UsernameNotFoundException("The user you want to subscribe does not exist"))
                )
        );
        subscriptionRepository.save(subscription);
    }
}
