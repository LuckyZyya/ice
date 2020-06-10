package com.jxzt.shopping.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/productManager")
public class AdminProductManager {
    @RequestMapping("/productManager")
    public String productManager(){
        return "productManager";
    }
}
