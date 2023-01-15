package com.server.entities;

import com.server.compositeId.InteractionId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "interactions", schema = "public")
@Entity
public class Interaction {

    @EmbeddedId
    private InteractionId interactionId;

    private Integer mark;

    private Timestamp viewDate;
}
