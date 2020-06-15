<%--
  Created by IntelliJ IDEA.
  User: 18237
  Date: 2020/6/5
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>backend</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script>
        $(function () {
            //    找到分页容器
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion: 3,
                currentPage: ${pageInfo.pageNum},
                totalPages: ${pageInfo.pages}, //总页数
                pageUrl: function (type, page, current) {
                    /*window.alert("page="+page);*/
                    return "${pageContext.request.contextPath}/customer/findAll?pageNumber=" + page;
                },
                itemTexts: function (type, page, current) {
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


            //添加客户
            $("#addCustomer").click(function () {
                const form_data = new FormData(document.getElementById("addCustomerForm"));
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/customer/addCustomer",
                    data: form_data,
                    contentType: false,
                    async: true,
                    processData: false,
                    dataType: "JSON",
                    success: function (result, textStatus) {
                        console.log(result)
                        if (result.sta == 1) {
                            //添加成功跳转页面
                            window.location.href = "${pageContext.request.contextPath}/customer/findAll?pageNumber=${pageInfo.pages}";
                        } else {
                            //弹出错误提示
                            window.alert(result.msg)
                        }
                    }
                });
            });

            //修改客户信息
            $("#updateCustomer").click(function () {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/customer/modifyCustomerInfo",
                    data: JSON.stringify({
                        "id": Number($("#id").val()),
                        "name": $("#name").val().toString().trim(),
                        "login_name": $("#loginName").val().toString().trim(),
                        "phone": $("#phone").val().toString().trim(),
                        "address": $("#address").val().toString().trim()
                    }),
                    async: true,
                    contentType: "application/json",
                    dataType: "JSON",
                    success: function (result, textStatus) {
                        console.log(result)
                        if (result.sta == 1) {//如果查询成功
                            window.location.href = "${pageContext.request.contextPath}/customer/findAll?pageNumber=${pageInfo.pageNum}";
                        } else {
                            window.alert(result.msg)
                            console.log("修改失败！")
                        }
                    }
                    ,
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                })
                ;
            })
        })

        //打开修改模态框
        function updateFindShow(id) {
            console.log(id)
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/customer/updateFindShow",
                data: {
                    "id": Number(id)
                },
                async: true,
                dataType: "JSON",
                /*result:返回结果；textStatus:描述状态的字符串*/
                success: function (result, textStatus) {
                    //result可能是xmlDoc、jsonObj、html、text等等
                    //this;  //调用本次ajax请求时传递的options参数
                    console.log(result)
                    if (result.sta == 1) {//如果查询成功
                        $("#id").val(result.obj.id)
                        $("#name").val(result.obj.name)
                        $("#loginName").val(result.obj.login_name)
                        $("#phone").val(result.obj.phone)
                        $("#address").val(result.obj.address)
                        // $("#proTypeName").val(result.data.name)
                    } else {
                        console.log("查询失败！")
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        //禁用、启用客户
        function changeCustomerState(id, is_valid) {
            console.log(id)
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/customer/changeCustomerState",
                data: {
                    "id": Number(id),
                    "is_valid": Number(is_valid)
                },
                async: true,
                dataType: "JSON",
                /*result:返回结果；textStatus:描述状态的字符串*/
                success: function (result, textStatus) {
                    //result可能是xmlDoc、jsonObj、html、text等等
                    //this;  //调用本次ajax请求时传递的options参数
                    console.log(result)
                    if (result.sta == 1) {//如果修改成功
                        window.location.href = "${pageContext.request.contextPath}/customer/findAll?pageNumber=${pageInfo.pageNum}";
                    } else {
                        console.log("修改失败！")
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        //删除用户
        function delCustomer(id) {
            console.log(id)
            let is_delete = confirm("确认删除？")
            if(is_delete) {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/customer/delCustomer",
                    data: {
                        "id": Number(id)
                    },
                    async: true,
                    dataType: "JSON",
                    /*result:返回结果；textStatus:描述状态的字符串*/
                    success: function (result, textStatus) {
                        //result可能是xmlDoc、jsonObj、html、text等等
                        //this;  //调用本次ajax请求时传递的options参数
                        console.log(result)
                        if (result.sta == 1) {//如果查询成功
                            window.alert("删除成功！");
                            window.location.href = "${pageContext.request.contextPath}/customer/findAll?pageNumber=${pageInfo.pageNum}";
                        } else {
                            console.log("删除失败！")
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            }

        }
    </script>
</head>

<body>
<div class="panel panel-default" id="userInfo" id="homeSet">
    <div class="panel-heading">
        <h3 class="panel-title">客户管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加客户" class="btn btn-primary" id="doAddCustomer" data-toggle="modal"
               data-target="#addModal">
        <br>
        <div class="showusersearch">
            <form class="form-inline" method="post" action="${pageContext.request.contextPath}/customer/queryCustomer">

                <br>
                <div class="form-group">
                    <label for="customer_name">姓名:</label>
                    <input type="text" class="form-control" id="customer_name" name="name" placeholder="请输入姓名"
                           size="15px">
                </div>
                <div class="form-group">
                    <label for="customer_loginName">帐号:</label>
                    <input type="text" class="form-control" id="customer_loginName" name="login_name"
                           placeholder="请输入帐号"
                           size="15px">
                </div>
                <div class="form-group">
                    <label for="customer_phone">电话:</label>
                    <input type="text" class="form-control" id="customer_phone" name="phone" placeholder="请输入电话"
                           size="15px">
                </div>
                <div class="form-group">
                    <label for="customer_address">地址:</label>
                    <input type="text" class="form-control" id="customer_address" name="address" placeholder="请输入地址">
                </div>
                <div class="form-group">
                    <label for="customer_isValid">状态:</label>
                    <select class="form-control" id="customer_isValid" name="is_valid">
                        <option value="-1">全部</option>
                        <option value="1">---有效---</option>
                        <option value="0">---无效---</option>
                    </select>
                </div>
                <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
            </form>

        </div>

        <div class="show-list" style="position: relative;top: 30px;">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">序号</th>
                    <th class="text-center">姓名</th>
                    <th class="text-center">帐号</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">地址</th>
                    <th class="text-center">注册时间</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${pageInfo.list}" var="customer">
                    <tr>
                        <td>${customer.id}</td>
                        <td>${customer.name}</td>
                        <td>${customer.login_name}</td>
                        <td>${customer.phone}</td>
                        <td>${customer.address}</td>
                        <td><fmt:formatDate value="${customer.regist_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <c:if test="${customer.is_valid == 1}">有效</c:if>
                            <c:if test="${customer.is_valid == 0}">无效</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm doModify"
                                   onclick="updateFindShow(${customer.id});" value="修改">
                            <c:if test="${customer.is_valid == 1}"><input type="button"
                                                                          class="btn btn-danger btn-sm doDisable"
                                                                          onclick="changeCustomerState(${customer.id},0)"
                                                                          value="禁用"></c:if>
                            <c:if test="${customer.is_valid == 0}"><input type="button"
                                                                          class="btn btn-success btn-sm doProDisable"
                                                                          onclick="changeCustomerState(${customer.id},1)"
                                                                          value="启用"></c:if>
                            <input type="button" class="btn btn-danger btn-sm doProTypeDelete"
                                   onclick="delCustomer(${customer.id});"
                                   value="删除">
                        </td>
                    </tr>
                </c:forEach>

                <%--<tr>--%>
                <%--<td>1</td>--%>
                <%--<td>admin</td>--%>
                <%--<td>admin</td>--%>
                <%--<td>15996868058</td>--%>
                <%--<td>江苏南京</td>--%>
                <%--<td>有效</td>--%>
                <%--<td class="text-center">--%>
                <%--<input type="button" class="btn btn-warning btn-sm doModify" value="修改">--%>
                <%--<input type="button" class="btn btn-danger btn-sm doDisable" value="禁用">--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>2</td>--%>
                <%--<td>admin2</td>--%>
                <%--<td>admin2</td>--%>
                <%--<td>15996868058</td>--%>
                <%--<td>江苏南京</td>--%>
                <%--<td>无效</td>--%>
                <%--<td class="text-center">--%>
                <%--<input type="button" class="btn btn-warning btn-sm doModify" value="修改">--%>
                <%--<input type="button" class="btn btn-success btn-sm doDisable" value="禁用">--%>
                <%--</td>--%>
                <%--</tr>--%>
                </tbody>
            </table>

            <%--    分页--%>
            <c:if test="${pageInfo.pages > 0}">
                <div class="text-center">
                    <ul id="pagination">

                    </ul>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- 修改客户信息 start -->
<div class="modal fade" tabindex="-1" id="myModal">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">修改客户</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="id" class="col-sm-4 control-label">编号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="id" readonly>
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="name" class="col-sm-4 control-label">姓名：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="name" readonly>
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="loginName" class="col-sm-4 control-label">帐号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="loginName" required
                               Onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')">
                    </div>
                </div>
                <br>

                <div class="row text-right">
                    <label for="phone" class="col-sm-4 control-label">电话：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="phone">
                    </div>
                </div>
                <br>

                <div class="row text-right">
                    <label for="address" class="col-sm-4 control-label">地址：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="address">
                    </div>
                </div>
                <br>
            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" id="updateCustomer">修改</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改客户信息 end -->

<!-- 添加客户信息 start -->
<div class="modal fade" tabindex="-1" id="addModal">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">添加客户</h4>
            </div>
            <form id="addCustomerForm">
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="name" class="col-sm-4 control-label">姓名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="name" id="add_name" required autocomplete="false">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="loginName" class="col-sm-4 control-label">帐号：</label>
                        <div class="col-sm-4">
                            <%--    不能输入中文--%>
                            <input type="text" class="form-control" name="login_name" id="add_loginName" required
                                   Onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="loginName" class="col-sm-4 control-label">登陆密码：</label>
                        <div class="col-sm-4">
                            <%--    不能输入中文--%>
                            <input type="text" class="form-control" name="password" id="add_password" required
                                   Onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="phone" class="col-sm-4 control-label">电话：</label>
                        <div class="col-sm-4">
                            <%--    只能输入数字，最多11位--%>
                            <input type="text" class="form-control" name="phone" id="add_phone"
                                   oninput="value=value.replace(/[^\d]/g,'')" maxlength="11">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="address" class="col-sm-4 control-label">地址：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="address" id="add_address">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="add_is_valid" class="col-sm-4 control-label">状态：</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="is_valid" id="add_is_valid">
                                <option value="1" selected>启用</option>
                                <option value="0">禁用</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="modal-footer">
                        <button class="btn btn-warning updateProType" id="addCustomer">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 添加客户信息 end -->
</body>

</html>