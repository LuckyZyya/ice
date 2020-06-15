package com.jxzt.shopping.utils;

/**
 * 自定义异常
 */
public class ObjectException extends Exception {


    public ObjectException() {
        super();
    }

    public ObjectException(String message) {
        super(message);
    }

    public ObjectException(String message, Throwable cause) {
        super(message, cause);
    }

    public ObjectException(Throwable cause) {
        super(cause);
    }

    protected ObjectException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
