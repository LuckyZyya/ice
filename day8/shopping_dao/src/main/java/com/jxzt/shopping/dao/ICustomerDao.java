package com.jxzt.shopping.dao;

import com.jxzt.shopping.bean.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ICustomerDao {
    public List<Customer> findCustomerAll();
    //根据用户id查询数据并且返回页面
    public Customer updateFindShow(@Param("id")int id);

    //修改customer用户信息
    public int  modifyCustomerInfo(Customer customer);

    //判断name是否存在
    public Customer findCustomerByName(@Param("name") String name);

    //启用/禁用该用户
    public int changeCustomerState(@Param("id")int id,@Param("is_valid")int is_valid);

    //添加用户数据
    public boolean addCustomer(Customer customer);

    //查询操作
    public List<Customer> queryCustomer(Customer customer);

    //删除操作
    public int delCustomer(int id);


}
