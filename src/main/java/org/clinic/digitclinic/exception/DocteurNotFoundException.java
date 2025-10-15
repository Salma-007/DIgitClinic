package org.clinic.digitclinic.exception;

public class DocteurNotFoundException extends RuntimeException {
    public DocteurNotFoundException(String message) {
        super(message);
    }
}
