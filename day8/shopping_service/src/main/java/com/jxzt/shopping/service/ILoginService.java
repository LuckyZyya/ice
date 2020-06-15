package com.jxzt.shopping.service;

import com.jxzt.shopping.bean.User;
import com.jxzt.shopping.utils.ObjectException;

public interface ILoginService {

    public User isLogin(String userName, String passWord)throws ObjectException;
}
