package com.zying.shopping_parent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/systemerManager")
public class AdminSystemerManager {
    @RequestMapping("/findAll")
    public String findSystemerManagerServiceData(){
        return "systemerManager";
    }
}
