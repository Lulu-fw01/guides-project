package com.server.services;

public interface ReportService {

    <T> void createReport(T report);

    void resolve();

    void reject();
}
