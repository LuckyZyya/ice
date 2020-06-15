package com.jxzt.shopping.bean;

import java.util.Date;
public class Customer {
    private Integer id;
    private String name;
    private String login_name;
    private String password;
    private String phone;
    private String address;
    private int is_valid;
    private Date regist_date;

    public Customer() {
    }

    public Customer(Integer id) {
        this.id = id;
    }
    public Customer(Integer id, String name, String login_name, String password, String phone, String address, int is_valid, Date regist_date) {
        this.id = id;
        this.name = name;
        this.login_name = login_name;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.is_valid = is_valid;
        this.regist_date = regist_date;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogin_name() {
        return login_name;
    }

    public void setLogin_name(String login_name) {
        this.login_name = login_name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getIs_valid() {
        return is_valid;
    }

    public void setIs_valid(int is_valid) {
        this.is_valid = is_valid;
    }

    public Date getRegist_date() {
        return regist_date;
    }

    public void setRegist_date(Date regist_date) {
        this.regist_date = regist_date;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", login_name='" + login_name + '\'' +
                ", password='" + password + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", is_valid=" + is_valid +
                ", regist_date=" + regist_date +
                '}';
    }
}
