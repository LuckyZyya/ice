package com.zying.shopping_parent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/productType")
public class AdminProductType {
    @RequestMapping("/findAll")
    public String findProductTypeServiceData(){
        return "productType";
    }
}
