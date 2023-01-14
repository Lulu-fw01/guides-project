package com.server.entities;

import com.server.compositeId.TagId;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "tags", schema = "public")
public class Tag implements Serializable {

    @EmbeddedId
    private TagId tagId;
}
