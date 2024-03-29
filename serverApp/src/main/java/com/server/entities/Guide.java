package com.server.entities;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "guides", schema = "public")
public class Guide {

    public Guide(User email, String title, String fileBytes, Timestamp editDate, Boolean isBlocked) {
        this.creatorEmail = email;
        this.title = title;
        this.fileBytes = fileBytes;
        this.editDate = editDate;
        this.isBlocked = isBlocked;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator_email", referencedColumnName = "email")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private User creatorEmail;

    @Column(name = "title")
    private String title;

    @Column(name = "file_bytes")
    private String fileBytes;

    @Column(name = "edit_date")
    private Timestamp editDate;

    @Column(name = "is_blocked")
    private Boolean isBlocked;
}
