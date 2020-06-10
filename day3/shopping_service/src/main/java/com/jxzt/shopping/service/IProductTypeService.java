package com.jxzt.shopping.service;

import com.jxzt.shopping.bean.ProductType;
import com.jxzt.shopping.utils.ProductTypeException;

import java.util.List;

public interface IProductTypeService {

    public List<ProductType> selectProductType();

    /**
     * 需求：如果商品类型名称存在则抛出异常，证明商品名称存在  否则添加成功
     * 添加商品类型状态statu  商品名称 name
     */

    public void addProductType(String name, int statu) throws ProductTypeException;
}
