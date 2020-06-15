package com.jxzt.shopping.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jxzt.shopping.bean.Product;
import com.jxzt.shopping.service.IProductService;
import com.jxzt.shopping.utils.ObjectException;
import com.jxzt.shopping.utils.ObjectMessage;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/productManager")
public class AdminProductManager {
    @Autowired
    private IProductService productService;

    @RequestMapping(value = "/addProduct", method= RequestMethod.POST)
    public String addProduct(@RequestParam("product-name") String pname , @RequestParam("product-price") double pprice,@RequestParam("product-type") String ptype, HttpServletRequest request, MultipartFile
                                    multipartFile) throws IOException {

        System.out.println("=="+pname+"=="+pprice+"=="+ptype);


        //使用UUID给图片重命名，并去掉四个“-”
        String name = UUID.randomUUID().toString().replaceAll("-", "");
        //获取文件的扩展名
        System.out.println(name);
        String ext = FilenameUtils.getExtension(multipartFile.getOriginalFilename());
        //设置图片上传路径
        String url = request.getSession().getServletContext().getRealPath("/upload");
        System.out.println(url);
        //以绝对路径保存重名命后的图片
        multipartFile.transferTo(new File(url+"/"+name + "." + ext));

        //图片绝对路径
        String img = "upload/"+name + "." + ext;
        try {
            productService.addProduct(pname,pprice,ptype,img);
        } catch (ObjectException e) {
            e.printStackTrace();
        }


        return "redirect:findAllProduct";
    }


    @RequestMapping(value = "/updateProduct", method= RequestMethod.POST)
    public String updateProduct(@RequestParam("pro-num") int id,@RequestParam("pro-name") String pname , @RequestParam("pro-price") double pprice,@RequestParam("pro-type") String ptype, HttpServletRequest request, MultipartFile
            multipartFiles) throws IOException {
        //使用UUID给图片重命名，并去掉四个“-”
        String name = UUID.randomUUID().toString().replaceAll("-", "");
        System.out.println(name);
        //获取文件的扩展名
        String ext = FilenameUtils.getExtension(multipartFiles.getOriginalFilename());
        //设置图片上传路径
        String url = request.getSession().getServletContext().getRealPath("/upload");
        System.out.println(url);
        //以绝对路径保存重名命后的图片
        multipartFiles.transferTo(new File(url+"/"+name + "." + ext));
        //图片绝对路径
        System.out.println(ext);
        String image ="upload/"+name + "." + ext;

        System.out.println("update完整图片名"+image);
        try {
            productService.updateProduct(id,pname,pprice,ptype,image);
        } catch (ObjectException e) {
            e.printStackTrace();
        }


        return "redirect:findAllProduct";
    }






    @RequestMapping("/productFindShow")
    @ResponseBody
    public ObjectMessage updateFindProductType(int id) {

        ObjectMessage objectMessage = new ObjectMessage();
        Product product = null;
        try {
            product = productService.findProductById(id);
            objectMessage.setObj(product);
            objectMessage.setSta(1);
            objectMessage.setMsg("查询成功");
        } catch (ObjectException e) {

            objectMessage.setSta(0);
            objectMessage.setMsg(e.getMessage());
        }
        objectMessage.setObj(product);
        return objectMessage;
    }

    @RequestMapping("/deleteProduct")
    @ResponseBody
    public ObjectMessage deleteProductById(int id) {
        ObjectMessage objectMessage = new ObjectMessage();
        try {
            productService.deleteProducteById(id);
            objectMessage.setSta(1);
            objectMessage.setMsg("删除成功");
        } catch (ObjectException e) {
            objectMessage.setSta(0);
            objectMessage.setMsg(e.getMessage());
        }
        return objectMessage;

    }







    @RequestMapping( value = "/findAllProduct")
    public String findProductTypeServiceData(Integer pageNumber, Model model){
        if (ObjectUtils.isEmpty(pageNumber)) {
            pageNumber = 1;
        }
        PageHelper.startPage(pageNumber, 5);
        List<Product> products = productService.selectProduct();
        //1.将集合productType数据装载到PageHelper的PageInfo对象中
        PageInfo<Product> pageInfo = new PageInfo<Product>(products);
        pageInfo.getPageNum();//获取总页数
        pageInfo.getPages();//总条数
        //将数据保存在Model
        model.addAttribute("pageInfos", pageInfo);
        return "productManager";
    }













    @RequestMapping("/productManager")
    public String productManager(){


        return "productManager";
    }





}
