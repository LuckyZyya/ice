package com.jxzt.shopping.dao;

import com.jxzt.shopping.bean.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IProductDao {
    List<Product> findAllProduct();

    public Product findProductByName(String name);

    public void addProduct(@Param("name") String pname, @Param("price") double pprice, @Param("type") String ptype,@Param("image") String img);

    Product findProductById(@Param("id") int id);

    public void updateProduct(@Param("id") int id, @Param("name") String pname, @Param("price") double pprice, @Param("type") String ptype, @Param("image") String img);

    public int deleteProductById(@Param("id") int id);
}
