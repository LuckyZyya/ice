package com.zying.shopping_parent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/customerManager")
public class AdminCustomerManager {
    @RequestMapping("/findAll")
    public String findCustomerManagerServiceData(){
        return "customerManager";
    }
}
