package com.server.repository;

import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import org.hibernate.type.BooleanType;
import org.hibernate.type.LongType;
import org.hibernate.type.StringType;
import org.hibernate.type.TimestampType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.server.compositeId.FavoriteId;
import com.server.entities.FavoriteItem;

import java.util.List;


@Repository
public interface FavoriteItemRepository extends JpaRepository<FavoriteItem, FavoriteId> {

    @Query(value =
            "SELECT guide_id FROM favorites f WHERE f.user_email IN " +
                    "(SELECT email FROM users u WHERE u.email = :email) ORDER BY add_date_time DESC",
            nativeQuery = true
    )
    List<Long> findFavoritesByConcreteUser(@Param("email") String email);

    default NativeQuery<Object[]> getPagesByCursor(Session session, Integer pageSize, Integer cursor, String email) {
        return session.createNativeQuery(
                        "SELECT id, creator_email, title, file_bytes, edit_date, is_blocked " +
                                "FROM guides " +
                                "JOIN (SELECT * FROM favorites f WHERE f.user_email IN (SELECT email FROM users u WHERE u.email = '" + email + "')) as ord " +
                                "ON ord.guide_id = guides.id " +
                                "WHERE (SELECT add_date_time FROM favorites WHERE guide_id = " + cursor + " AND user_email = '" + email + "')" + " > " + "ord.add_date_time " +
                                "ORDER BY add_date_time DESC " +
                                "LIMIT " + pageSize
                )
                .addScalar("id", LongType.INSTANCE)
                .addScalar("creator_email", StringType.INSTANCE)
                .addScalar("title", StringType.INSTANCE)
                .addScalar("file_bytes", StringType.INSTANCE)
                .addScalar("edit_date", TimestampType.INSTANCE)
                .addScalar("is_blocked", BooleanType.INSTANCE);
    }

    default NativeQuery<Object[]> getAllPages(Session session, Integer pageSize, String email) {
        return session.createNativeQuery(
                        "SELECT id, creator_email, title, file_bytes, edit_date, is_blocked " +
                                "FROM guides " +
                                "JOIN (SELECT * FROM favorites f WHERE f.user_email IN (SELECT email FROM users u WHERE u.email = '" + email + "')) as ord " +
                                "ON ord.guide_id = guides.id " +
                                "ORDER BY add_date_time DESC " +
                                "LIMIT " + pageSize
                )
                .addScalar("id", LongType.INSTANCE)
                .addScalar("creator_email", StringType.INSTANCE)
                .addScalar("title", StringType.INSTANCE)
                .addScalar("file_bytes", StringType.INSTANCE)
                .addScalar("edit_date", TimestampType.INSTANCE)
                .addScalar("is_blocked", BooleanType.INSTANCE);
    }
}
