package com.jxzt.shopping.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jxzt.shopping.bean.ProductType;

import com.jxzt.shopping.service.IProductTypeService;

import com.jxzt.shopping.utils.ObjectMessage;
import com.jxzt.shopping.utils.ObjectException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/productType")
public class AdminProductType {

    /**
     * 注入service 接口
     * service 层注入Dao层接口
     */
    @Autowired
    private IProductTypeService productTypeService;

    /**
     * 创建Servlet
     * request、session
     *
     * @param model
     * @return
     */
    @RequestMapping("/findAll")
    public String findProductTypeServiceData(Integer pageNumber, Model model) {
        if (ObjectUtils.isEmpty(pageNumber)) {
            pageNumber = 1;
        }
        PageHelper.startPage(pageNumber, 5);

        List<ProductType> productTypes = productTypeService.selectProductType();
        //1.将集合productType数据装载到PageHelper的PageInfo对象中
        PageInfo<ProductType> pageInfo = new PageInfo<ProductType>(productTypes);
        pageInfo.getPageNum();//获取总页数
        pageInfo.getPages();//总条数
        //将数据保存在Model
        model.addAttribute("pageInfo", pageInfo);
        return "productType";
    }

    @RequestMapping("/add")
    @ResponseBody
    public ObjectMessage addProductTypeData(String name, String status) {
        ObjectMessage objectMessage = new ObjectMessage();
        int statuss = 0;
        if (status != "") {
            statuss = Integer.parseInt(status);
        }
        try {
            productTypeService.addProductType(name, statuss);
            objectMessage.setSta(1);
            objectMessage.setMsg("成功");
        } catch (ObjectException e) {
            e.printStackTrace();
            objectMessage.setSta(0);
            objectMessage.setMsg(e.getMessage());
        }


        System.out.println(name + "===" + status);
        return objectMessage;
    }


    @RequestMapping("/updateFindShow")
    @ResponseBody
    public ObjectMessage updateFindProductType(int id) {

        ObjectMessage objectMessage = new ObjectMessage();
        ProductType productType = null;
        try {
            productType = productTypeService.updateFindByIdProductType(id);
            objectMessage.setObj(productType);
            objectMessage.setSta(1);
            objectMessage.setMsg("查询成功");
        } catch (ObjectException e) {

            objectMessage.setSta(0);
            objectMessage.setMsg(e.getMessage());
        }
        objectMessage.setObj(productType);
        return objectMessage;
    }

    @RequestMapping("/updateProductType")
    @ResponseBody
    public ObjectMessage updateProductType(int id, String name) {
        ObjectMessage objectMessage = new ObjectMessage();
        System.out.println("id=" + id + "  : name=" + name);
        try {
            productTypeService.updateProductType(id, name);
            objectMessage.setSta(1);
            objectMessage.setMsg("修改成功");
        } catch (ObjectException e) {
            objectMessage.setSta(0);
            objectMessage.setMsg(e.getMessage());
        }


        return objectMessage;
    }

    @RequestMapping("/deleteProductTypeById")
    @ResponseBody
    public ObjectMessage deleteProductTypeById(int id) {
        ObjectMessage objectMessage = new ObjectMessage();
        try {
            productTypeService.deleteProductTypeById(id);
            objectMessage.setSta(1);
            objectMessage.setMsg("修改成功");
        } catch (ObjectException e) {
            objectMessage.setSta(0);
            objectMessage.setMsg(e.getMessage());
        }
        return objectMessage;

    }
}

