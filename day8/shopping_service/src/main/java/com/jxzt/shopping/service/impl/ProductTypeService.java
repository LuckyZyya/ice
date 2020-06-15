package com.jxzt.shopping.service.impl;

import com.jxzt.shopping.bean.ProductType;
import com.jxzt.shopping.dao.IProductTypeDao;
import com.jxzt.shopping.service.IProductTypeService;
import com.jxzt.shopping.utils.ObjectException;
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
    @Override
    public List<ProductType> selectProductType() {
        return productTypeDao.findProductTypeAll();
    }
//处理业务
    @Override
    public void addProductType(String name, int statuss) throws ObjectException {
        //先进行根据商品名称来查询返回ProductType对象，如果对象不为空则商品名称存在，抛出异常
        ProductType byProductTypeName= productTypeDao.findByProductTypeName(name);
        if(byProductTypeName !=null){
            throw new ObjectException("商品名称已存在!");
        }else {

        }

        //为空，添加数据
        productTypeDao.addProductType(name, statuss);


    }

    @Override
    public ProductType updateFindByIdProductType(int id) throws ObjectException {
        ProductType productType = productTypeDao.findProductTypeById(id);
        if(productType == null){
            throw new ObjectException("查询失败");
        }
        return productType;
    }

    @Override
    public void updateProductType(int id, String name) throws ObjectException {

            int num = productTypeDao.updateProductType(id, name);
        if(num !=1){
            throw  new ObjectException("修改失败");
        }


    }

    @Override
    public void deleteProductTypeById(int id) throws ObjectException {
        int num = productTypeDao.deleteProductTypeById(id);
        if(num !=1){
            throw  new ObjectException("删除失败");
        }
    }
}
