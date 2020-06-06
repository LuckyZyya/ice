package com.zying.shopping_parent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/productManager")
public class AdminProductManager {
    @RequestMapping("/findAll")
    public String findProductManagerServiceData(){
        return "productManager";
    }
}
