package com.server.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import com.server.compositeId.FavoriteId;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.sql.Timestamp;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "favorites", schema = "public")
public class FavoriteItem {

    @EmbeddedId
    private FavoriteId favoriteId;

    @Column(name = "add_date_time")
    private Timestamp addedToFavoritesTime;
}
