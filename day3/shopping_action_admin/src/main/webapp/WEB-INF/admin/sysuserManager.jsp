<%--
  Created by IntelliJ IDEA.
  User: zzz19980601
  Date: 2020/6/5
  Time: 16:11
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
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <%--3.实现标签点击效果--%>
    <script>
        $(function () {
            //    找到ul
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion:3,//bootstrap的版本
                currentPage:${pageInfo.pageNum},/*指定点击当前页面*/
                totalPages:${pageInfo.pageSize},/*每页最多显示几条数据最多5，最少1*/
                pageUrl:function (type,page,current) { //改变新的请求数据
                    //type 按钮类型=>首页/末页/上一页/下一页
                    //page 点击按钮1.2.3.4
                    //current 点击当前页面
                    /*window.alert("page="+page);*/
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
        });
    </script>
</head>

<body>
<!-- 系统用户管理 -->
<div class="panel panel-default" id="adminSet">
    <div class="panel-heading">
        <h3 class="panel-title">系统用户管理</h3>
    </div>
    <div class="panel-body">
        <div class="showmargersearch">
            <form class="form-inline">
                <div class="form-group">
                    <label for="userName">姓名:</label>
                    <input type="text" class="form-control" id="userName" placeholder="请输入姓名">
                </div>
                <div class="form-group">
                    <label for="loginName">帐号:</label>
                    <input type="text" class="form-control" id="loginName" placeholder="请输入帐号">
                </div>
                <div class="form-group">
                    <label for="phone">电话:</label>
                    <input type="text" class="form-control" id="phone" placeholder="请输入电话">
                </div>
                <div class="form-group">
                    <label for="role">角色</label>
                    <select class="form-control" name="role" id="role">
                        <option value="-1">全部</option>
                        <option value="1">商品专员</option>
                        <option value="0">营销经理</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="status">状态</label>
                    <select class="form-control" name="isValid" id="status">
                        <option value="-1">全部</option>
                        <option value="1">---有效---</option>
                        <option value="0">---无效---</option>
                    </select>
                </div>
                <input type="button" value="查询" class="btn btn-primary" id="doSearch">
            </form>
        </div>
        <br>
        <input type="button" value="添加系统用户" class="btn btn-primary" id="doAddManger">
        <div class="show-list" style="position: relative; top: 10px;">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">序号</th>
                    <th class="text-center">姓名</th>
                    <th class="text-center">帐号</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">邮箱</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">注册时间</th>
                    <th class="text-center">角色</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <tr>
                    <td>1</td>
                    <td>admin</td>
                    <td>admin</td>
                    <td>15996868058</td>
                    <td>admin@itany.com</td>
                    <td>有效</td>
                    <td>2018-2-14</td>
                    <td>超级管理员</td>
                    <td class="text-center">
                        <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改">
                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用">
                    </td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>admin</td>
                    <td>admin</td>
                    <td>15996868058</td>
                    <td>admin@itany.com</td>
                    <td>有效</td>
                    <td>2018-2-14</td>
                    <td>超级管理员</td>
                    <td class="text-center">
                        <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改">
                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用">
                    </td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>admin</td>
                    <td>admin</td>
                    <td>15996868058</td>
                    <td>admin@itany.com</td>
                    <td>有效</td>
                    <td>2018-2-14</td>
                    <td>超级管理员</td>
                    <td class="text-center">
                        <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改">
                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用">
                    </td>
                </tr>
                </tbody>
            </table>
            <%--2.实现分页标签--%>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>

<!-- 添加系统用户 start -->
<div class="modal fade" tabindex="-1" id="myMangerUser">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">添加系统用户</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="marger-username" class="col-sm-4 control-label">用户姓名：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="marger-username">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="marger-loginName" class="col-sm-4 control-label">登录帐号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="marger-loginName">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" id="marger-password">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="marger-phone">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="marger-adrees" class="col-sm-4 control-label">联系邮箱：</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="marger-email">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="role" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                    <div class=" col-sm-4">
                        <select class="form-control">
                            <option>请选择</option>
                            <option>超级系统用户</option>
                            <option>商品系统用户</option>
                        </select>
                    </div>
                </div>
                <br>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary add-Manger" type="button">添加</button>
                <button class="btn btn-primary cancel" data-dismiss="modal" type="button">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 添加系统用户 end -->

<!-- 修改系统用户 start -->
<div class="modal fade" tabindex="-1" id="myModal-Manger">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">系统用户修改</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="MargerUsername" class="col-sm-4 control-label">用户编号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="MargerStaffId" readonly="readonly">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="MargerUsername" class="col-sm-4 control-label">用户姓名：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="MargerStaffname">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="MargerLoginName" class="col-sm-4 control-label">登录帐号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="MargerLoginName" readonly="readonly">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="MargerPhone" class="col-sm-4 control-label">联系电话：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="MargerPhone">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="MargerAdrees" class="col-sm-4 control-label">联系邮箱：</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="MargerAdrees">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="MargerRole" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                    <div class=" col-sm-4">
                        <select class="form-control" id="MargerRole">
                            <option>请选择</option>
                            <option>超级系统用户</option>
                            <option>商品系统用户</option>
                        </select>
                    </div>
                </div>
                <br>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary doMargerModal">修改</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改系统用户 end -->

</body>

</html>