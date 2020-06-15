package com.jxzt.shopping.service.impl;

import com.jxzt.shopping.bean.Customer;
import com.jxzt.shopping.dao.ICustomerDao;
import com.jxzt.shopping.service.ICustomerService;
import com.jxzt.shopping.utils.ObjectException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class CustomerService implements ICustomerService {

    //关联dao层
    @Autowired
    private ICustomerDao customerDao;

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    @Override
    public List<Customer> selectCustomer() {
        return customerDao.findCustomerAll();
    }

    //根据用户id查询数据并且返回页面
    @Override
    public Customer updateFindShow(int id) throws ObjectException {
        Customer customer = customerDao.updateFindShow(id);
        if (customer == null) {
            throw new ObjectException("查询失败");
        }
        return customer;
    }

    //修改customer用户信息
    @Override
    public int modifyCustomerInfo(Customer customer) {
        Customer customer_is_exist = customerDao.findCustomerByName(customer.getName());
        if (customer_is_exist != null && customer_is_exist.getId() != customer.getId()) {
            //name已存在且非本人，修改失败
            return 2;
        } else {
            return customerDao.modifyCustomerInfo(customer) > 0 ? 1 : 0;//1:修改成功，0修改失败
        }
    }

    //启用/禁用该用户
    @Override
    public boolean changeCustomerState(int id, int is_valid) {
        return customerDao.changeCustomerState(id, is_valid) > 0;
    }

    //添加用户数据
    @Override
    public boolean addCustomer(Customer customer) throws ObjectException {
        //先查询是否存在
        System.out.println(customer.getLogin_name());
        Customer customer1 = customerDao.findCustomerByName(customer.getName());
        if (customer1 != null) {
            System.out.println("姓名已存在！");
            throw new ObjectException("姓名已存在！");//已存在类型名称
        } else {
            return customerDao.addCustomer(customer);
        }
    }

    //查询操作
    @Override
    public List<Customer> queryCustomer(Customer customer) {
        return customerDao.queryCustomer(customer);
    }

    //删除customer
    @Override
    public boolean delCustomer(int id) {
        return customerDao.delCustomer(id) > 0;
    }
}
