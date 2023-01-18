package com.server.entities;

import com.server.enums.ReportCategory;
import com.server.enums.ReportStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "guide_reports", schema = "public")
public class GuideReport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reporter_email", referencedColumnName = "email")
    private User reporterEmail;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "guide_id", referencedColumnName = "id")
    private Guide guideId;

    @Column(name = "comment")
    private String comment;

    @Column(name = "category")
    @Enumerated(EnumType.STRING)
    private ReportCategory category;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private ReportStatus status;
}
