package com.jxzt.shopping.dao;

import com.jxzt.shopping.bean.ProductType;

import java.util.List;

/**
 * mybatis面向接口编程
 */
public interface IProductTypeDao {
//查询所有商品类型
    public List<ProductType> findProductTypeAll();


}
