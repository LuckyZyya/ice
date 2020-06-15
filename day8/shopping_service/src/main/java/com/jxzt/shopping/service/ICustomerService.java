package com.jxzt.shopping.service;

import com.jxzt.shopping.bean.Customer;
import com.jxzt.shopping.utils.ObjectException;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ICustomerService {
    public List<Customer> selectCustomer();

    //根据用户id查询数据并且返回页面
    public Customer updateFindShow(@Param("id")int id) throws ObjectException;

    //修改customer用户信息
    public int  modifyCustomerInfo(Customer customer);

    //启用/禁用该用户
    public boolean changeCustomerState(@Param("id")int id,@Param("is_valid")int is_valid);

    //添加用户数据
    public boolean addCustomer(Customer customer) throws ObjectException;

    //查询操作
    public List<Customer> queryCustomer(Customer customer);

    //删除customer
    public boolean  delCustomer(int id);
}



