package com.server.repository;

import com.server.compositeId.SubscriptionId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.server.entities.Subscription;

import java.util.List;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, SubscriptionId> {

    @Query(value = "SELECT user_email FROM subscriptions WHERE subscription_user_email = :email", nativeQuery = true)
    List<String> getSubscribers(@Param("email") String email);

    @Query(value = "SELECT subscription_user_email FROM subscriptions WHERE user_email = :email", nativeQuery = true)
    List<String> getSubscriptions(@Param("email") String email);
}
