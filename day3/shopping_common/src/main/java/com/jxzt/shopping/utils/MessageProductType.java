package com.jxzt.shopping.utils;

public class MessageProductType {
    private  int sta;//成功状态是1 失败0
    private  String msg;//信息

    public MessageProductType() {
    }

    public MessageProductType(int sta, String msg) {
        this.sta = sta;
        this.msg = msg;
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
        return "MessageProductType{" +
                "sta=" + sta +
                ", msg='" + msg + '\'' +
                '}';
    }
}
