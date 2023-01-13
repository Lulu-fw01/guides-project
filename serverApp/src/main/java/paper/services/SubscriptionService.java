package paper.services;

import org.springframework.stereotype.Service;
import paper.entities.Subscription;
import paper.repository.SubscriptionRepository;

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
