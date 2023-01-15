package com.server.compositeId;

import com.server.entities.Guide;
import com.server.entities.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Embeddable
@Data
@AllArgsConstructor
@NoArgsConstructor
public class InteractionId implements Serializable {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_email", referencedColumnName = "email")
    private User email;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "guide_id", referencedColumnName = "id")
    private Guide id;
}
