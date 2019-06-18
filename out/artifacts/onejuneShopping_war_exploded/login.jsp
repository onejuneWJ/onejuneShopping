<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/30 0030
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <base href="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/oneday.png"/>
    <title>用户登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css"/>

    <script type="text/javascript">

        $(document).keydown(function() {//回车键触发登录按钮点击事件
            if (event.keyCode == "13") {//keyCode=13是回车键
                $('#loginBtn').click();
            }
        });

        function login() {
            var loginName = $("#loginName").val();
            var password = $("#password").val();
            var errorMsg = document.getElementById("errorMsg");
            if (loginName == "" && password == "") {
                errorMsg.innerHTML = "<i style=\"color: red;\" class=\"fa fa-window-close\" aria-hidden=\"true\"></i>\n" +
                    "请输入用户名和密码";
                $("#inputTitle").hide();
                errorMsg.hidden = false;
            } else if (loginName == "" && password != "") {
                $("#inputTitle").hide();
                errorMsg.innerHTML = "<i style=\"color: red;\" class=\"fa fa-window-close\" aria-hidden=\"true\"></i>\n" +
                    "请输入用户名";
                errorMsg.hidden = false;
            } else if (loginName != "" && password == "") {
                $("#inputTitle").hide();
                errorMsg.innerHTML = "<i style=\"color: red;\" class=\"fa fa-window-close\" aria-hidden=\"true\"></i>\n" +
                    "请输入密码";
                errorMsg.hidden = false;
            } else {
                $.ajax({
                    url: "${pageContext.request.contextPath}/member/login",
                    type: "POST",
                    data: {"loginName": loginName, "password": password},
                    success: function (data) {
                        if (data == "success") {
                            location.href = "${pageContext.request.contextPath}/index.jsp";
                        } else {
                            $("#inputTitle").hide();
                            errorMsg.innerHTML = "<i style=\"color: red;\" " +
                                "class=\"fa fa-window-close\" aria-hidden=\"true\"></i>" +
                                "用户名或者密码错误";
                            errorMsg.hidden = false;
                        }
                    }
                });
            }
        }
    </script>

</head>
<body>
<div class="login-head">
    <div class="login-head-logo" style="margin-top: -5px">
        <a href="${pageContext.request.contextPath}/index.jsp">
            <img width="140px" height="85px" src="${pageContext.request.contextPath}/img/register.png"/>
        </a>
    </div>
    <div class="login-head-msg">
        <p>为确保您账户的安全及正常使用，请您尽快绑定手机号码，完善个人信息，以方便找回密码</p>
    </div>
</div>
<div class="login-body">
    <div class="login-body-content">
        <a href="${pageContext.request.contextPath}/index.jsp">
            <div class="login-toIndexLink"></div>
        </a>
        <div class="login-content">
            <div class="login-ontent-title">
                <b id="inputTitle">密码登录</b>
                <div id="errorMsg" class="error" hidden="hidden">

                </div>
            </div>
            <form class="bs-example bs-example-form" role="form">
                <div class="login-content-input">
                    <div class="input-group input-group-lg">
								<span class="input-group-addon">
									<i class="fa fa-user-o fa-fw"></i>
								</span>
                        <input class="form-control" id="loginName" type="text" placeholder="手机号/会员名">
                    </div>
                </div>
                <div class="login-content-input">
                    <div class="input-group input-group-lg">
								<span class="input-group-addon">
									<i class="fa fa-key fa-fw"></i>
								</span>
                        <input class="form-control" id="password" type="password" placeholder="请输入密码">
                    </div>
                </div>
                <div class="login-content-input">
                    <input id="loginBtn" onclick="login()" type="button" class="btn btn-info btn-lg btn-block"
                           value="登录">
                </div>
            </form>
            <div class="login-content-bottom">
                <a href="${pageContext.request.contextPath}/admin/login">管理员入口 <i class="fa fa-chevron-right" aria-hidden="true"></i></a>
                <a href="${pageContext.request.contextPath}/register.jsp">免费注册</a>
            </div>
        </div>
    </div>
</div>

<div class="footer ">
    <p align="center">© 2018-2019 onejune.com 版权所有</p>
    <p align="center">互联网违法和不良信息举报电话:0000-12345678 jubao@onejune.com</p>
</div>
</body>
</html>
