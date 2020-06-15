package com.jxzt.shopping.service;

import com.jxzt.shopping.bean.Product;
import com.jxzt.shopping.utils.ObjectException;

import java.util.List;

public interface IProductService {
    List<Product> selectProduct();


   public void addProduct(String pname, double pprice, String ptype, String img) throws ObjectException;

    public Product findProductById(int id) throws ObjectException;

    public void updateProduct(int id, String pname, double pprice, String ptype, String img) throws ObjectException;

     void deleteProducteById(int id) throws ObjectException;
}
