package com.zying.shopping_parent.controller;

import com.zying.shopping_parent.bean.ProductType;
import com.zying.shopping_parent.service.IProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    public String findProductTypeServiceData(Model model){
        List<ProductType> productTypes = productTypeService.selectProductType();
        //将数据保存在Model
        model.addAttribute("productTypes",productTypes);
        return "productType";
    }
}
