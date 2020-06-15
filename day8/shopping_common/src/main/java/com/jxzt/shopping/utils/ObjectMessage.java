package com.jxzt.shopping.utils;

public class ObjectMessage {

    private int sta;//成功状态 1  失败状态 0
    private String msg;//信息
    private Object obj;//携带任何类
    public ObjectMessage() {
    }

    public ObjectMessage(int sta, String msg, Object obj) {
        this.sta = sta;
        this.msg = msg;
        this.obj = obj;
    }

    public ObjectMessage(int sta, String msg) {
        this.sta = sta;
        this.msg = msg;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }

    public int getSta() {
        return sta;
    }

    public void setSta(int sta) {
        this.sta = sta;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Override
    public String toString() {
        return "ObjectMessage{" +
                "sta=" + sta +
                ", msg='" + msg + '\'' +
                '}';
    }
}
