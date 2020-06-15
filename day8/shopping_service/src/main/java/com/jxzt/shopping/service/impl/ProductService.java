package com.jxzt.shopping.service.impl;

import com.jxzt.shopping.bean.Product;
import com.jxzt.shopping.dao.IProductDao;
import com.jxzt.shopping.service.IProductService;
import com.jxzt.shopping.utils.ObjectException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class ProductService implements IProductService {

    //关联dao层
    @Autowired
    private IProductDao productDao;
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    @Override
    public List<Product> selectProduct() {
        System.out.println("dao");
        return productDao.findAllProduct();

    }

    @Override
    public void addProduct(String pname, double pprice, String ptype, String img) throws ObjectException{
                Product product=null;
                   product =  productDao.findProductByName(pname);
                if(product == null){
                    productDao.addProduct(pname,pprice,ptype,img);
                }
                else {
                    throw new ObjectException("商品名称已存在!");
                }
    }

    @Override
    public Product findProductById(int id) throws ObjectException {
        Product product = productDao.findProductById(id);
        if(product == null){
            throw new ObjectException("查询失败");
        }
        System.out.println(product);
        return product;
    }

    @Override
    public void updateProduct(int id, String pname, double pprice, String ptype, String img) throws ObjectException {
        Product product=null;
        product =  productDao.findProductByName(pname);
        if(product == null){
            productDao.updateProduct(id,pname,pprice,ptype,img);
        }

    }

    @Override
    public void deleteProducteById(int id) throws ObjectException {
        int num = productDao.deleteProductById(id);
        if(num !=1){
            throw  new ObjectException("删除失败");
        }
    }


}
