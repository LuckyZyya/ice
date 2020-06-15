package com.jxzt.shopping.service;

import com.jxzt.shopping.bean.ProductType;
import com.jxzt.shopping.utils.ObjectException;

import java.util.List;

public interface IProductTypeService {

    public List<ProductType> selectProductType();

    /**
     * 添加数据
     * 需求:如果商品类型名称已经存在，抛出异常，不能添加，否则添加成功
     * @param name 商品类型名
     * @param statuss 商品类型状态
     */

    public void addProductType(String name, int statuss) throws ObjectException;

    public ProductType updateFindByIdProductType(int id) throws ObjectException;

     public void updateProductType(int id,String name) throws ObjectException;

     public void  deleteProductTypeById(int id) throws ObjectException;
}
