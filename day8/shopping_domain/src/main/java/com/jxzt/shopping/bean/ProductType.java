package com.jxzt.shopping.bean;
/**
 * 实体类product_type
 */
public class ProductType {

    private  int id;//商品编号
  private String name;//商品名称
  private int status;//商品状态

    //生成构造方法,set与get构造方法，toString
    public ProductType() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductType{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status=" + status +
                '}';
    }
}
