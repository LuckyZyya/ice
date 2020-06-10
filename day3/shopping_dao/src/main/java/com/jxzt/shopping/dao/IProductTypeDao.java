package com.jxzt.shopping.dao;

import com.jxzt.shopping.bean.ProductType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * mybatis面向接口编程
 */
public interface IProductTypeDao {
//查询所有商品类型
    public List<ProductType> findProductTypeAll();

    public ProductType findByProductTypeName(@Param("name") String name);
    /**
     * 添加数据
     * @param name
     * @param statu
     */
    public void addProductType(@Param("name")String name,@Param("statu")int statu);
}
