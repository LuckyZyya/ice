package com.jxzt.shopping.test;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidPooledConnection;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.sql.SQLException;

public class TestDB {

    public static void main(String[] args) {
        ApplicationContext springDB = new ClassPathXmlApplicationContext("spring-dao.xml");
        DruidDataSource dd = (DruidDataSource) springDB.getBean("dataSource");
    //连接数据库

        try {
            DruidPooledConnection conn = dd.getConnection();
            System.out.println(conn);
        } catch (SQLException e){
            e.printStackTrace();
        }
        }

}
