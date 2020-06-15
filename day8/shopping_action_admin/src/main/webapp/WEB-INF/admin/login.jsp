<%--
  Created by IntelliJ IDEA.
  User: zzz19980601
  Date: 2020/6/4
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>




<head>
    <title>在线商城-后台管理系统</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/DD_belatedPNG_0.0.8a-min.js"></script>

//验证码
    <script language="javascript" type="text/javascript">
        function changeimg(){
            var img=document.getElementById("img1");
            //防止页面缓存
            img.src="${pageContext.request.contextPath}/admin/checkCode"+ "?r="+Math.random();
        }
        DD_belatedPNG.fix('div, ul, img, li, input,p,ul,ol,h1,h2,h3,a,span,i');
    </script>



    <script>
        $(function(){
            $("#loginBtn").click(function () {
                $.ajax({
                    /*向控制层提交操作*/
                    type:"POST",/*提交方式POST|GET*/
                    url:"${pageContext.request.contextPath}/admin/sysLogin",/*请求地址*/
                    data:{"userName":$("#userName").val().toString().trim(),
                        "passWord":$("#passWord").val().toString().trim(),
                        "checkCode":$("#checkCode").val().toString().trim()

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
                            window.location.href="${pageContext.request.contextPath}/admin/main";
                        }else {
                            $("#checkCode").val(null);
                            changeimg();
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

        });

    </script>





</head>
<body>
<!-- 使用自定义css样式 div-signin 完成元素居中-->
<div class="container div-signin">
    <div class="panel panel-primary div-shadow">
        <!-- h3标签加载自定义样式，完成文字居中和上下间距调整 -->
        <div class="panel-heading">
            <h3>在线商城系统 3.0</h3>
            <span>ZSHOP Manager System</span>
        </div>
        <div class="panel-body">
            <!-- login form start -->
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户名：</label>
                    <div class="col-sm-9">
                        <input class="form-control" id="userName" name="userName" type="text" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                    <div class="col-sm-9">
                        <input class="form-control" id="passWord" name="passWord" type="password" placeholder="请输入密码" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">验证码：</label>
                    <div class="col-sm-4">
                        <input class="form-control" id="checkCode" type="text" placeholder="验证码">
                    </div>
                    <div class="col-sm-2">
                        <!-- 验证码 -->
                        <img id="img1" title="点击获取新验证码" src="${pageContext.request.contextPath}/admin/checkCode"  width="70px"; height="32px"; alt="" style="display:inline-block;">
                       <%-- <img class="img-rounded" src="${pageContext.request.contextPath}/images/image.jpg" style="height: 32px; width: 70px;"/>--%>
                    </div>
                    <div class="col-sm-2">
                        <button type="button" class="btn btn-link" onclick="changeimg()">看不清</button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-3">
                    </div>
                    <div class="col-sm-9 padding-left-0">
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-primary btn-block" id="loginBtn">登&nbsp;&nbsp;陆</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="reset" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-link btn-block">忘记密码？</button>
                        </div>
                    </div>
                </div>
            </form>
            <!-- login form end -->
        </div>
    </div>
</div>
<!-- 页尾 版权声明 -->
<div class="container">
    <div class="col-sm-12 foot-css">
        <p class="text-muted credit">
            版权所有　＠copy 江西朝腾教育科技有限公司
        </p>
    </div>
</div>

</body>
</html>

