package com.server.utils;

public interface Validator {
    <T> void checkIfSomeFieldIsNull(T obj);

    <T> void nullBodyRequestCheck(T obj);
}
