package com.jxzt.shopping.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jxzt.shopping.bean.ProductType;

import com.jxzt.shopping.service.IProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/productType")
public class AdminProductType {

    /**
     * 注入service 接口
     *  service 层注入Dao层接口
     */
    @Autowired
    private IProductTypeService productTypeService;

    /**
     * 创建Servlet
     *   request、session
     * @param model
     * @return
     */
    @RequestMapping("/findAll")
    public String findProductTypeServiceData(Integer pageNumber,Model model){
//        设置分页技术
if (ObjectUtils.isEmpty(pageNumber)){
pageNumber=1;
}
PageHelper.startPage(pageNumber,5);
        List<ProductType> productTypes = productTypeService.selectProductType();
//        1.将productType数据封装到PageHelper中PageInfo
        PageInfo<ProductType> pageInfo=new PageInfo<ProductType>(productTypes);
pageInfo.getPageNum();//获取当前页面
        pageInfo.getPages();//总条数
        //将数据保存在Model
        model.addAttribute("pageInfo",pageInfo);
        return "productType";
    }
    @RequestMapping("/add")
    public  void  addProductTypeData(String name){
System.out.println("============="+name);
    }
}
