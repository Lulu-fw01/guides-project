package com.server.utils;

public interface Validator<T> {
    void checkIfSomeFieldIsNull(T obj);

    void nullBodyRequestCheck(T obj);
}
