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
                    "请输入账号和密码";
                $("#inputTitle").hide();
                errorMsg.hidden = false;
            } else if (loginName == "" && password != "") {
                $("#inputTitle").hide();
                errorMsg.innerHTML = "<i style=\"color: red;\" class=\"fa fa-window-close\" aria-hidden=\"true\"></i>\n" +
                    "请输入账号";
                errorMsg.hidden = false;
            } else if (loginName != "" && password == "") {
                $("#inputTitle").hide();
                errorMsg.innerHTML = "<i style=\"color: red;\" class=\"fa fa-window-close\" aria-hidden=\"true\"></i>\n" +
                    "请输入密码";
                errorMsg.hidden = false;
            } else {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/login",
                    type: "POST",
                    data: {"loginName": loginName, "password": password},
                    success: function (data) {
                        if (data == "success") {
                            location.href = "${pageContext.request.contextPath}/admin/toMain";
                        } else {
                            $("#inputTitle").hide();
                            errorMsg.innerHTML = "<i style=\"color: red;\" " +
                                "class=\"fa fa-window-close\" aria-hidden=\"true\"></i>" +
                                "账号或者密码错误";
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
    <div class="login-head-logo">
        <b style="font-size: 36px; color: #f40;;">管理员登录</b>
    </div>
</div>
<div class="login-body">
    <div class="login-body-content">
        <a href="${pageContext.request.contextPath}/index.jsp">
            <div class="login-toIndexLink"></div>
        </a>
        <div class="login-content">
            <div class="login-ontent-title">
                <b id="inputTitle">管理员登录</b>
                <div id="errorMsg" class="error" hidden="hidden">

                </div>
            </div>
            <form class="bs-example bs-example-form" role="form">
                <div class="login-content-input">
                    <div class="input-group input-group-lg">
								<span class="input-group-addon">
									<i class="fa fa-user-o fa-fw"></i>
								</span>
                        <input class="form-control" id="loginName" type="text" placeholder="账号">
                    </div>
                </div>
                <div class="login-content-input">
                    <div class="input-group input-group-lg">
								<span class="input-group-addon">
									<i class="fa fa-key fa-fw"></i>
								</span>
                        <input class="form-control" id="password" type="password" placeholder="密码">
                    </div>
                </div>
                <div class="login-content-input">
                    <input id="loginBtn" onclick="login()" type="button" class="btn btn-info btn-lg btn-block"
                           value="登录">
                </div>
            </form>
            <div class="login-content-bottom">
                <a href="${pageContext.request.contextPath}/member/login">会员登录 <i class="fa fa-chevron-right" aria-hidden="true"></i></a>
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
