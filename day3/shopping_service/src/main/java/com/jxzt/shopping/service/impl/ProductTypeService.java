package com.jxzt.shopping.service.impl;

import com.jxzt.shopping.bean.ProductType;
import com.jxzt.shopping.dao.IProductTypeDao;
import com.jxzt.shopping.service.IProductTypeService;
import com.jxzt.shopping.utils.ProductTypeException;
import com.mysql.jdbc.PacketTooBigException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
 *  @Transactional：类具有事务
 *      propagation = Propagation.REQUIRED此类具有事务功能
 *      rollbackFor = Exception.class：回滚|恢复
 *          -功能：回滚
 *              - 添加、删除、修改
 *           - 查询:不需要
 *                  - 支持事务功能
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class ProductTypeService implements IProductTypeService {

    //关联dao层
    @Autowired
    private IProductTypeDao productTypeDao;

    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
//    处理业务逻辑

    @Override
    public List<ProductType> selectProductType() {

        return productTypeDao.findProductTypeAll();
    }
//1.先根据商品名称来查询返回ProductType对象
    //如果商品名称不为空则商品名称存在 抛出异常
@Override
    public void addProductType(String name,int statu) throws ProductTypeException{
        ProductType byProductTypeName=productTypeDao.findByProductTypeName(name);
        if (byProductTypeName!=null){
throw new ProductTypeException("商品名称已存在");
        }
        //2.为空则 添加数据
    productTypeDao.addProductType(name,statu);
}



    //为空则添加数据
}
