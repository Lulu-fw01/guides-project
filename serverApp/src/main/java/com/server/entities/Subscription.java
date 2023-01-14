package com.server.entities;

import com.server.compositeId.SubscriptionId;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "subscriptions", schema = "public")
public class Subscription {

    @EmbeddedId
    private SubscriptionId subscriptionId;
}
