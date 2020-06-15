package com.jxzt.shopping.dao;

import com.jxzt.shopping.bean.ProductType;
import com.jxzt.shopping.utils.ObjectException;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * mybatis面向接口编程
 */
public interface IProductTypeDao {
//查询所有商品类型
    public List<ProductType> findProductTypeAll();
    //先查询商品名称是否存在
    public ProductType findByProductTypeName(@Param("name") String name);

    /**
     * 添加数据
     * @param name
     * @param status
     */
    public void addProductType(@Param("name") String name,@Param("status") int status)throws ObjectException;

    public  ProductType findProductTypeById(@Param("id") int id);

    public Integer updateProductType(@Param("id") int id, @Param("name") String name);

     public Integer deleteProductTypeById(@Param("id") int id);

/**
 *
 */


}
