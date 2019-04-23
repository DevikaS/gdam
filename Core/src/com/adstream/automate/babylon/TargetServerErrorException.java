package com.adstream.automate.babylon;

/**
 * User: keda
 * Date: 11.04.14
 */
public class TargetServerErrorException extends RuntimeException {
    public TargetServerErrorException() {
        super();
    }

    public TargetServerErrorException(String message) {
        super(message);
    }
}
