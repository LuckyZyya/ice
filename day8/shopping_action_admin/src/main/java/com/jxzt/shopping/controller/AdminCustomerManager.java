package com.jxzt.shopping.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jxzt.shopping.bean.Customer;
import com.jxzt.shopping.bean.Product;
import com.jxzt.shopping.service.ICustomerService;
import com.jxzt.shopping.utils.ObjectException;
import com.jxzt.shopping.utils.ObjectMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/customer")


public class AdminCustomerManager {
    @Autowired
    private ICustomerService customerService;
@RequestMapping("/findAll")
public String findProductTypeServiceData(Integer pageNumber, Model model){
    if (ObjectUtils.isEmpty(pageNumber)) {
        pageNumber = 1;
    }
    PageHelper.startPage(pageNumber, 5);
    List<Customer> customers = customerService.selectCustomer();
    //1.将集合productType数据装载到PageHelper的PageInfo对象中
    PageInfo<Customer> pageInfo = new PageInfo<Customer>(customers);
    pageInfo.getPageNum();//获取总页数
    pageInfo.getPages();//总条数
    //将数据保存在Model
    model.addAttribute("pageInfo", pageInfo);
    return "customerManager";
}



    //根据id获取用户信息详情用于修改信息
    @RequestMapping("/updateFindShow")
    @ResponseBody
    public ObjectMessage updateFindShow(int id) throws ObjectException {
        ObjectMessage responseResult = new ObjectMessage();
        Customer customer = null;
        try {
            customer = customerService.updateFindShow(id);
        } catch (ObjectException e) {
            e.printStackTrace();
        }
        responseResult.setObj(customer);
        responseResult.setSta(1);
        responseResult.setMsg("查询成功");
        return responseResult;
    }

    //接收表单数据，对客户信息进行修改
    @RequestMapping("/modifyCustomerInfo")
    @ResponseBody
    public ObjectMessage modifyCustomerInfo(@RequestBody Customer customer) {
        ObjectMessage responseResult = new ObjectMessage();
        System.out.println(customer.toString());
        int result = customerService.modifyCustomerInfo(customer);
        String msg = result==1 ? "修改成功" : result==2 ? "姓名已存在，修改失败":"修改失败";
        responseResult.setSta(result);
        responseResult.setMsg(msg);
        return responseResult;
    }

    //禁用/启用该用户
    @RequestMapping("/changeCustomerState")
    @ResponseBody
    public ObjectMessage changeCustomerState(int id,int is_valid) {
        ObjectMessage responseResult = new ObjectMessage();
        boolean result = customerService.changeCustomerState(id,is_valid);
        responseResult.setObj(result);
        responseResult.setSta(result?1:0);
        responseResult.setMsg(result?"修改成功":"修改失败");
        return responseResult;
    }

    //添加用户
    @RequestMapping(value = "addCustomer", method = RequestMethod.POST)
    @ResponseBody
    public ObjectMessage addCustomer(Customer customer) {
        ObjectMessage message = new ObjectMessage();
        boolean result = false;
        int sta = 0;
        String msg  = "添加失败";
        if(customer.getName().length() > 0) {
            //如果存在name
            customer.setRegist_date(new Date());//设置当前时间为注册时间
            //开始做添加功能
            try {
                result = customerService.addCustomer(customer);
            } catch (ObjectException e) {
                e.printStackTrace();
            }
            msg = result ? "添加成功" : "添加失败";
            sta = result ? 1 : 0;//1成功，0失败
        }
        message.setMsg(msg);
        message.setSta(sta);

        return message;
    }

    //查询关键词，返回查询结果
    @RequestMapping(value = "/queryCustomer", method = RequestMethod.POST)
    public String queryCustomer(Integer pageNumber, Customer customer, Model model) {
        if (ObjectUtils.isEmpty(pageNumber)) {
            pageNumber = 1;
        }
        PageHelper.startPage(pageNumber, 5);

        System.out.println(customer.toString());
        List<Customer> customers = customerService.queryCustomer(customer);

        //把查询完的用户列表放在pageinfo中
        PageInfo<Customer> pageInfo = new PageInfo<Customer>(customers);
        pageInfo.getPageNum();//获取当前页面
        pageInfo.getPages();//总页数
        //将数据保存在Model
        model.addAttribute("pageInfo", pageInfo);
        return "customerManager";
    }

    //删除customer操作
    @RequestMapping("/delCustomer")
    @ResponseBody
    public ObjectMessage delCustomer(int id) {
        ObjectMessage responseResult = new ObjectMessage();

        Customer customer = new Customer(id);


        boolean result = customerService.delCustomer(id);
        String msg = result ? "删除成功" : "删除失败";
        int status = result ? 1 : 2;
        responseResult.setSta(status);
        responseResult.setMsg(msg);
        return responseResult;
    }






}



/*    public String customerManager(){
        return "customerManager";
    }
}*/
