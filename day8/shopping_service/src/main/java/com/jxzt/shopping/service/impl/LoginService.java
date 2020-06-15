package com.jxzt.shopping.service.impl;

import com.jxzt.shopping.bean.User;
import com.jxzt.shopping.dao.ILoginDao;
import com.jxzt.shopping.service.ILoginService;
import com.jxzt.shopping.utils.ObjectException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class LoginService implements ILoginService {
    //关联dao层
    @Autowired
    private ILoginDao loginDao;
    @Override
    public User isLogin(String userName, String passWord) throws ObjectException {
                  User user = loginDao.isLogin(userName,passWord);

                  if (user ==null){
                    throw new ObjectException("用户名或密码错误");
                  }else {
                      System.out.println("登录成功!");
                  }
                   return user;
    }
}
