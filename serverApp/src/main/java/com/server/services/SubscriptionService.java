package com.server.services;

import com.server.compositeId.SubscriptionId;
import com.server.dto.SubscriptionDTO;
import com.server.repository.SubscriptionRepository;
import com.server.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.server.entities.Subscription;
import org.springframework.web.server.ResponseStatusException;

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

    public void unsubscribe(SubscriptionDTO subscriptionDTO) {
        var id = new SubscriptionId(
                userRepository
                        .findByEmail(subscriptionDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                userRepository
                        .findByEmail(subscriptionDTO.getSubscriptionUserEmail())
                        .orElseThrow(() ->
                                new UsernameNotFoundException("The user you want to unsubscribe does not exist"))
        );

        if (subscriptionRepository.existsById(id)) {
            subscriptionRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The id does not exist");
        }
    }
}
