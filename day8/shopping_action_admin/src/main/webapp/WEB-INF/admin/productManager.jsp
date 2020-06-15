<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zzz19980601
  Date: 2020/6/5
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/file.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script>
        $(function(){
            //找到ul
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${pageInfos.pageNum},//指定点击当前页面
                totalPages:${pageInfos.pages},//总页数
                pageUrl:function (type,page,current) {
                    //改变新的请求数据
                    /**
                     * type:按钮类型：首页|尾页|上一页|下一页
                     * page:点击按钮1，2，3，4
                     * current：当前页面
                     */
                    return "${pageContext.request.contextPath}/productManager/findAllProduct?pageNumber="+page;
                },
                itemTexts:function (type,page,current) {
                    switch (type) {
                        case "first":
                            return "首页";
                        case "prev":
                            return "上一页";
                        case "next":
                            return "下一页";
                        case "last":
                            return "末页";
                        case "page":
                            return page;
                    }
                }
            });

            //上传图像预览
            $('#product-image').on('change',function() {
                $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
            });
            $('#pro-image').on('change',function() {
                $('#img2').attr('src', window.URL.createObjectURL(this.files[0]));
            });

            //添加商品
            $("#addProduct").click(function () {
                $.ajax({
                    /*向控制层提交操作*/
                    type:"POST",/*提交方式POST|GET*/
                    url:"${pageContext.request.contextPath}/productManager/addProduct",/*请求地址*/
                    data:{"productName":$("#product-name").val().toString().trim(),
                        "productPrice":$("#product-price").val().toString().trim(),
                        "productImage":$("#product-image").val().toString().trim(),
                        "productType":$("#product-type-sel").val().toString().trim()
                    },/*请求数据*/
                    async:true,/*异步提交方式*/
                    /*Controller 返回过信息*/
                    dataType:"JSON",
                    success:function (result,textStatus) {
                        //result:返回结果JSON字符串
                        //textStatus：描述状态的字符串
                        /* console.log(result);
                         window.alert(result.msg);*/
                        if(result.sta == 1){
                            window.alert(result.msg);

                        }else {
                        }



                    },
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        //XMLHttpRequest:即XMLHttpRequest对象状态
                        console.log(XMLHttpRequest.status);
                        // textStatus:错误信息
                        // errorThrown:捕获的错误对象

                    }

                });
            });
        });


        function updateProductShow(id) {
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/productManager/productFindShow",
                data:{"id":id},
                async:true,
                dataType:"JSON",
                success:function (result,textStatus) {
                             console.log(result.obj.id);
                            console.log(result.obj.name);
                            console.log(result.obj.price);
                    if(result.sta===1){
                        $("#pro-num").val(result.obj.id);
                        $("#pro-name").val(result.obj.name);
                        $("#pro-price").val(result.obj.price);
                        $("#pro-type").val(result.obj.type);
                    }else {
                        window.alert(result.msg);
                    }
                },
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }


        function deleteProduct(id) {
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/productManager/deleteProduct",
                data:{"id":id},
                async:true,
                dataType:"JSON",
                success:function (result,textStatus) {

                    if(result.sta===1){
                    window.alert(result.msg);
                    }else {
                        window.alert(result.msg);
                    }
                },
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }






    </script>
</head>

<body>
<div class="panel panel-default" id="userPic">
    <div class="panel-heading">
        <h3 class="panel-title">商品管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加商品" class="btn btn-primary" id="doAddPro">
        <br>
        <br>
        <div class="show-list">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">商品</th>
                    <th class="text-center">价格</th>
                    <th class="text-center">简介</th>
                    <th class="text-center">图片</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${pageInfos.list}" var="product">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.price}</td>
                    <td>${product.info}</td>
                    <td><img src="${pageContext.request.contextPath}/${product.image}" width="50px" height="50px"></td>
                    <td>
                    <c:if test="${product.product_type_id == 1}">启用</c:if>
                    <c:if test="${product.product_type_id == 0}">禁用</c:if>
                    </td>
                    <td class="text-center">
                        <input type="button" class="btn btn-warning btn-sm doProModify" onclick="updateProductShow(${product.id})" value="修改">
                        <input type="button" class="btn btn-warning btn-sm doProDelete" onclick="deleteProduct(${product.id})" value="删除">
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
            <!--分页-->
            <ul id="pagination"></ul>
        </div>
    </div>
</div>

<!-- 添加商品 start -->
<div class="modal fade" tabindex="-1" id="Product">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/productManager/addProduct" class="form-horizontal" method="post"enctype="multipart/form-data">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal" >&times;</button>
                    <h4 class="modal-title">添加商品</h4>
                </div>
                <div class="modal-body text-center row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="product-name" class="col-sm-4 control-label">商品名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="product-name" id="product-name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-price" class="col-sm-4 control-label">商品价格：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="product-price" id="product-price">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-image" class="col-sm-4 control-label">商品图片：</label>
                            <div class="col-sm-8">
                                <a href="javascript:;" class="file">选择文件
                                    <input type="file"  id="product-image"  name="multipartFile">
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
                            <div class="col-sm-8">
                                <select class="form-control" name="product-type">
                                    <option value="0">请选择</option>
                                    <option value="电子产品">电子产品</option>
                                    <option value="化妆品">化妆品</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <!-- 显示图像预览 -->
                        <img style="width: 160px;height: 180px;" id="img">
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加商品 end -->

<!-- 修改商品 start -->
<div class="modal fade" tabindex="-1" id="myProduct">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/productManager/updateProduct" class="form-horizontal" method="post"enctype="multipart/form-data">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改商品</h4>
                </div>
                <div class="modal-body text-center row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="pro-num" class="col-sm-4 control-label">商品编号：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="pro-num" id="pro-num" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-name" class="col-sm-4 control-label">商品名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="pro-name" id="pro-name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-price" class="col-sm-4 control-label">商品价格：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="pro-price" id="pro-price">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-image" class="col-sm-4 control-label">商品图片：</label>
                            <div class="col-sm-8">
                                <a class="file">

                                    选择文件 <input type="file" name="multipartFiles"  id="multipartFiles">
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">商品类型：</label>
                            <div class="col-sm-8">
                                <select class="form-control"  name="pro-type" id="product-type-sel">
                                    <option>请选择</option>
                                    <option>电子产品</option>
                                    <option>化妆品</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <!-- 显示图像预览 -->
                        <img style="width: 160px;height: 180px;" id="img2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary updatePro" type="submit">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
    <!-- 修改商品 end -->
</body>

</html>