package com.jxzt.shopping.dao;

import com.jxzt.shopping.bean.User;
import org.apache.ibatis.annotations.Param;

public interface ILoginDao {
    public User isLogin(@Param("userName") String userName, @Param("passWord") String passWord);
}
