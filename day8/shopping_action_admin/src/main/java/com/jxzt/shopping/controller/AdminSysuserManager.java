package com.jxzt.shopping.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sysuserManager")
public class AdminSysuserManager {
    @RequestMapping("/sysuserManager")
    public String systemUserManagement(){
        return "sysuserManager";
    }

}
