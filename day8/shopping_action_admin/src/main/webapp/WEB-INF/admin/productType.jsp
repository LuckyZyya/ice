<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wangh
  Date: 2020/6/5
  Time: 14:59
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
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <!--导入分页插件-->
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <!--实现标签点击效果-->
    <script>
        $(function(){
            //找到ul
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},//指定点击当前页面
                totalPages:${pageInfo.pages},//总页数
                pageUrl:function (type,page,current) {
                    //改变新的请求数据
                    /**
                     * type:按钮类型：首页|尾页|上一页|下一页
                     * page:点击按钮1，2，3，4
                     * current：当前页面
                     */
                    return "${pageContext.request.contextPath}/productType/findAll?pageNumber="+page;
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

            /* 设置添加商品添加数据*/
            /* 设置添加商品添加数据*/
            $("#addProductTypeBtn").click(function () {
                //使用Ajax提交方式
                $.ajax({
                    /*向控制层提交操作*/
                    type:"POST",/*提交方式POST|GET*/
                    url:"${pageContext.request.contextPath}/productType/add",/*请求地址*/
                    data:{"name":$("#productTypeName").val().toString().trim(),"status":$("#productTypeStatus").val().toString().trim(),
                        "status":$("#productTypeStatus").val().toString().trim()

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
                            window.location.href="${pageContext.request.contextPath}/productType/findAll?pageNumber=${pageInfo.pages}";
                        }else{
                            window.alert(result.msg);
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

            $("#updateProductType").click(function () {
                //请求控制器
                $.ajax({
                    type:"POST",
                    url:"${pageContext.request.contextPath}/productType/updateProductType",
                    data:{"id":$("#proTypeNum").val(),"name":$("#proTypeName").val()},
                    async:true,
                    dataType:"JSON",
                    success:function (result,textStatus) {
                        if(result.sta===1){
                            //window.alert(result.msg);
                            window.location.href="${pageContext.request.contextPath}/productType/findAll?pageNumber=${pageInfo.pageNum}";
                        }else {
                            window.alert(result.msg);
                        }

                    },
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            });

        });

        function updateFindShow(id) {
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/productType/updateFindShow",
                data:{"id":id},
                async:true,
                dataType:"JSON",
                success:function (result,textStatus) {

                    console.log(result.obj.id);
                    console.log(result.obj.name);
                    if(result.sta===1){
                        $("#proTypeNum").val(result.obj.id);
                        $("#proTypeName").val(result.obj.name);
                    }else {
                        window.alert(result.msg);
                    }
                },
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function deleteProductType(id) {
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/productType/deleteProductTypeById",
                data:{"id":id},
                async:true,
                dataType:"JSON",
                success:function (result,textStatus) {
                    if(result.sta===1){
                        window.alert(result.msg);
                        window.location.href="${pageContext.request.contextPath}/productType/findAll?pageNumber=${pageInfo.pageNum}";
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
<div class="panel panel-default" id="userSet">
    <div class="panel-heading">
        <h3 class="panel-title">商品类型管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加商品类型" class="btn btn-primary" id="doAddProTpye">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">类型名称</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${pageInfo.list}" var="productType">
                    <tr>
                        <td>${productType.id}</td>
                        <td>${productType.name}</td>
                        <td>
                            <c:if test="${productType.status == 1}">启用</c:if>
                            <c:if test="${productType.status == 0}">禁用</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm doProTypeModify" onclick="updateFindShow(${productType.id})" value="修改">
                            <input type="button" class="btn btn-warning btn-sm doProTypeDelete"  onclick="deleteProductType(${productType.id})" value="删除">
                            <input type="button" class="btn btn-danger btn-sm doProTypeDisable" value="禁用">
                        </td>
                    </tr>
                </c:forEach>
                <%--<tr>
                    <td>1</td>
                    <td>aaaa</td>
                    <td>启用</td>
                    <td class="text-center">
                        <input type="button" class="btn btn-warning btn-sm doProTypeModify" value="修改">
                        <input type="button" class="btn btn-warning btn-sm doProTypeDelete" value="删除">
                        <input type="button" class="btn btn-danger btn-sm doProTypeDisable" value="禁用">
                    </td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>aaaa</td>
                    <td>启用</td>
                    <td class="text-center">
                        <input type="button" class="btn btn-warning btn-sm doProTypeModify" value="修改">
                        <input type="button" class="btn btn-warning btn-sm doProTypeDelete" value="删除">
                        <input type="button" class="btn btn-success btn-sm doProDisable" value="启用">
                    </td>
                </tr>--%>
                </tbody>
            </table>
            <%--2.实现分页标签 --%>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>

<!-- 添加商品类型 start -->
<div class="modal fade" tabindex="-1" id="ProductType">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">添加商品类型</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="productTypeName" class="col-sm-4 control-label">商品类型名称：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="productTypeName">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="productTypeName" class="col-sm-4 control-label">商品类型状态：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="productTypeStatus">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary addProductType"  id="addProductType">添加</button>
                <button class="btn btn-primary cancel" data-dismiss="modal" >取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 添加商品类型 end -->

<!-- 修改商品类型 start -->
<div class="modal fade" tabindex="-1" id="myProductType">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">修改商品类型</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="proTypeNum" class="col-sm-4 control-label">编号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="proTypeNum" readonly>
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="proTypeName" class="col-sm-4 control-label">类型名称</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="proTypeName">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" id="updateProductType" >修改</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改商品类型 end -->
</body>

</html>