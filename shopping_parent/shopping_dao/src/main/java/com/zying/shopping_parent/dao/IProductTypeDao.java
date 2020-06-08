package com.zying.shopping_parent.dao;

import com.zying.shopping_parent.bean.ProductType;

import java.util.List;
/**
 * mybatis 面向接口编程|接口映射文件
 */
public interface IProductTypeDao {

        /**
         * 查询
         *      表中一条数据 对应是一个对象
         *      查询表所有数据 对应集合
         */

public  List<ProductType> findProductTypeAll();
}
