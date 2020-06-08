package com.zying.shopping_parent.service.impl;
import com.zying.shopping_parent.bean.ProductType;
import com.zying.shopping_parent.dao.IProductTypeDao;
import com.zying.shopping_parent.service.IProductTypeService;
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
}
