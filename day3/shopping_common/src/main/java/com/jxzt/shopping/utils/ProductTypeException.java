package com.jxzt.shopping.utils;

public class ProductTypeException extends Exception {
    /*
    自定义异常
     */
    public ProductTypeException() {
        super();
    }

    public ProductTypeException(String message) {
        super(message);
    }

    public ProductTypeException(String message, Throwable cause) {
        super(message, cause);
    }

    public ProductTypeException(Throwable cause) {
        super(cause);
    }
}
