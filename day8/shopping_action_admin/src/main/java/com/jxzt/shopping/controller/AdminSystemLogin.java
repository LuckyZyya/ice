package com.jxzt.shopping.controller;

import com.jxzt.shopping.bean.User;
import com.jxzt.shopping.service.ILoginService;
import com.jxzt.shopping.utils.ObjectMessage;
import com.jxzt.shopping.utils.ObjectException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@Controller
@RequestMapping("/admin")
public class AdminSystemLogin {
        @Autowired
        private ILoginService loginService;





    @RequestMapping(value = "/checkCode")
    @ResponseBody
    public void getVerifyCodeImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置验证码字符的字体和字号。
        Font mFont = new Font("Arial Black", Font.PLAIN, 22);

        //清除缓存，每次访问该页面时都从服务器端读取
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");

        // 设置验证码图片的长度和高度。
        int width = 86, height = 40;
        BufferedImage image = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        //画图画板
        Graphics g = image.getGraphics();
        //定义一个随机数
        Random random = new Random();
        //设置画板背景颜色
//          g.setColor(getRandColor(200, 250));
        g.setColor(new Color(160, 177, 185));
        //设置画板的填充范围
        g.fillRect(1, 1, width - 1, height - 1);
//          g.setColor(new Color(102, 102, 102));
        g.drawRect(0, 0, width - 1, height - 1);
        //设置字体
        g.setFont(mFont);

        //显示字符串，4位长度。
        String sRand = "";
        for (int i = 0; i < 4; i++) {
            String tmp = getRandomChar();
            sRand += tmp;
            //设置每个数字的颜色
            g.setColor(new Color(20 + random.nextInt(110), 20 + random
                    .nextInt(110), 20 + random.nextInt(110)));
            //在画板上写数字，起始位置
            g.drawString(tmp, 20 * i + 5, 27);
        }

        HttpSession session = request.getSession();
        // 把验证码防到session中，用来前台对比。
        sRand.toLowerCase();
        session.setAttribute("verifycode", sRand.toLowerCase());
        // System.out.println(sRand.toLowerCase()+"--------------------------》");
        //显示图片
        g.dispose();
        //转换成一张图片，格式为JPEG
        ImageIO.write(image, "JPEG", response.getOutputStream());
    }

    /**
     * 随机获得颜色，RGB格式
     *
     * @param fc
     * @param bc
     * @return
     */
    Color getRandColor(int fc, int bc) {
        Random random = new Random();
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

    private String getRandomChar() {
        int rand = (int) Math.round(Math.random() * 2);
        long itmp = 0;
        char ctmp = '\u0000';
        switch (rand) {
            case 1:
                itmp = Math.round(Math.random() * 25 + 65);
                ctmp = (char) itmp;
                return String.valueOf(ctmp);
            case 2:
                itmp = Math.round(Math.random() * 25 + 97);
                ctmp = (char) itmp;
                return String.valueOf(ctmp);
            default:
                itmp = Math.round(Math.random() * 9);
                return String.valueOf(itmp);
        }
    }




    @RequestMapping( "/sysLogin")
    @ResponseBody
    public ObjectMessage isLogin(String userName, String passWord, String checkCode, HttpServletRequest request, HttpSession session) {

        System.out.println(userName + "====" + passWord + checkCode);
            checkCode.toLowerCase();
        ObjectMessage objectMessage = new ObjectMessage();
        User user = null;
        String vcode = (String) request.getSession().getAttribute("verifycode");
        System.out.println("c:"+checkCode+"v:"+vcode);
        if (!(vcode.equals(checkCode))) {
            objectMessage.setMsg("验证码错误");
            objectMessage.setSta(2);
        } else {
            try {
                user = loginService.isLogin(userName, passWord);

                objectMessage.setMsg("登录成功");
                objectMessage.setSta(1);
                session.setAttribute("systemUserName", user.getName());
            } catch (ObjectException e) {
                System.out.println("ssss"+e.getMessage());
                objectMessage.setSta(0);
                objectMessage.setMsg(e.getMessage());

            }
        }
            return objectMessage;

        }




    //登陆成功，跳转到main.jsp
    @RequestMapping("/main")
    public String main() {
        return "main";//刷新验证码
    }





    /*public  String isLogin(@RequestParam("userName")String userName, @RequestParam("passWord")String passWord, HttpSession session){

          User user =  loginService.isLogin(userName,passWord);

            System.out.println(user);

        return  "main";//main.jsp
    }*/







}

