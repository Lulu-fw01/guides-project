package paper.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import paper.compositeId.FavoriteId;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "favourites", schema = "public")
public class FavoriteItem {

    @EmbeddedId
    private FavoriteId favoriteId;
}
