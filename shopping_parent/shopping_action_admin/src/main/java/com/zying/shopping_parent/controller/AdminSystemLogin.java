package com.zying.shopping_parent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminSystemLogin {
@RequestMapping("/sysLogin")
public  String isLogin(){
    return  "main";//main.jsp
}
}
