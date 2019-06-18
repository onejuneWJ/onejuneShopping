<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/5 0005
  Time: 12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="img/oneday.png"/>
    <title>用户注册</title>
    <link rel="stylesheet" type="text/css" href="css/register.css"/>

    <script type="text/javascript">
        $(document).keydown(function () {//回车键触发注册按钮点击事件
            if (event.keyCode == "13") {//keyCode=13是回车键
                $('#registerBtn').click();
            }
        });

        function showFpHint() {
            $("#fpHint").html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\">" +
                "</i> 请长度至少为6的密码");
        }

        function showSpHint() {
            $("#spHint").html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\">" +
                "</i> 请再次输入您的密码");
        }

        function showNameHint() {
            $("#nameHint").html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\">" +
                "</i> 会员名长度为3至10");
        }

        function showPhoneHint() {
            $("#phoneHint").html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\">" +
                "</i> 请输入您的手机号");
        }

        function checkFp() {
            var firstPassword = $("#firstPassword").val();
            if (firstPassword.length > 5 && firstPassword.length < 20) {
                $("#fpHint").html("<i class=\"fa fa-check-circle-o\" aria-hidden=\"true\"></i>");
                return true;
            } else {
                $("#fpHint").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                    "</i> 密码设置不符合规范");
                return false;
            }
        }

        function checkSp() {
            var firstPassword = $("#firstPassword").val();
            var secondPassword = $("#secondPassword").val();
            if (firstPassword == secondPassword) {
                $("#spHint").html("<i class=\"fa fa-check-circle-o\" aria-hidden=\"true\"></i>");
                return true;
            } else {
                $("#spHint").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                    "</i> 两次密码输入不匹配");
                return false;
            }
        }

        function checkName() {
            var name = $("#name").val();
            var b = false;
            if (name.length > 2 && name.length < 10) {
                //    查询数据库是否存在重名
                $.ajax({
                    url: "${pageContext.request.contextPath}/member/checkName/" + name,
                    async: false,
                    type: "GET",
                    success: function (data) {
                        if (data == "repeat") {//用户名重复
                            $("#nameHint").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                                "</i> 用户名已存在");
                            b = false;
                        } else if (data == "illegal") {
                            $("#nameHint").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                                "</i> 用户名格式错误");
                            b = false;
                        } else {
                            $("#nameHint").html("<i class=\"fa fa-check-circle-o\" aria-hidden=\"true\"></i>");
                            b = true;
                        }
                    }
                });
            } else {
                $("#nameHint").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                    "</i> 用户名格式错误");
                b = false;
            }
            return b;
        }

        function checkPhone() {
            var phone = $("#phone").val();
            var myreg = /^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/;

            var b = false;
            if (myreg.test(phone)) {
                //查询电话号码是否重复
                $.ajax({
                    url: "${pageContext.request.contextPath}/member/checkPhone/" + phone,
                    async: false,
                    type: "get",
                    success: function (data) {
                        if (data == "repeat") {
                            $("#phoneHint").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                                "</i> 手机号已存在");
                            b = false;
                        } else {
                            $("#phoneHint").html("<i class=\"fa fa-check-circle-o\" aria-hidden=\"true\"></i>");
                            b = true;
                        }
                    }
                });
            } else {
                $("#phoneHint").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                    "</i> 请输入有效电话号码");
                b = false;
            }
            return b;
        }

        function register() {
            if (checkFp() && checkSp() && checkName() && checkPhone()) {
                $.post("${pageContext.request.contextPath}/member/register",
                    $("#registerForm").serialize(), function (data) {
                        if(data=="success"){
                            alert("注册成功");
                            location.href="${pageContext.request.contextPath}/login.jsp";
                        }else {
                            alert("注册失败");
                        }
                    }
                );
            }
        }
    </script>

</head>

<body>
<div class="register-head">
    <a href="index.jsp">
        <div class="register-head-img">
            <img width="140px" height="85px" src="img/register.png"/>
        </div>
    </a>
    <div class="register-head-text">
        <b>用户注册</b>
    </div>
</div>
<hr style="border-bottom: solid 1px;margin-top: 10px;"/>
<div class="register-body">
    <div class="register-body-input-left">
        <div class="register-body-input-left-text">
            <p align="right"><b>请设置登录密码</b></p>
        </div>
        <div class="register-body-input-left-text">
            <p align="right">登录密码</p>
        </div>
        <div class="register-body-input-left-text">
            <p align="right">确认密码</p>
        </div>
        <div class="register-body-input-left-text">
            <p align="right"><b>基本信息</b></p>
        </div>
        <div class="register-body-input-left-text">
            <p align="right">会员名</p>
        </div>
        <div class="register-body-input-left-text">
            <p align="right">手机号码</p>
        </div>
    </div>
    <div class="register-body-input-right">
        <form id="registerForm" action="${pageContext.request.contextPath}/member/register" method="post">
            <div class="register-body-input-right-inputs"></div>
            <div class="register-body-input-right-inputs form-group-lg">
                <input name="password" onfocus="showFpHint()" onblur="checkFp()" class="form-control" type="password"
                       id="firstPassword"
                       placeholder="请设置你的登录密码"/>
            </div>
            <div class="register-body-input-right-error" id="fpHint">

            </div>
            <div class="register-body-input-right-inputs form-group-lg">
                <input onfocus="showSpHint()" onblur="checkSp()" class="form-control" type="password"
                       id="secondPassword"
                       placeholder="请再次输入你的密码"/>
            </div>
            <div class="register-body-input-right-error" id="spHint">

            </div>
            <div class="register-body-input-right-inputs "></div>
            <div class="register-body-input-right-inputs form-group-lg">
                <input name="name" onfocus="showNameHint()" onblur="checkName()" class="form-control" type="text"
                       id="name"
                       placeholder="设置会员名"/>
            </div>
            <div class="register-body-input-right-error" id="nameHint">
            </div>
            <div class="register-body-input-right-inputs form-group-lg">
                <input name="tel" onfocus="showPhoneHint()" onblur="checkPhone()" class="form-control" type="tel"
                       id="phone"
                       placeholder="请输入手机号码"/>
            </div>
            <div class="register-body-input-right-error" id="phoneHint">

            </div>
            <div class="register-body-input-right-inputs form-group-lg">
                <input onclick="register()" type="button" id="registerBtn" value="注册"
                       class="btn btn-primary btn-lg btn-block"/>
            </div>
        </form>
    </div>
</div>
<div class="footer ">
    <p align="center">© 2018-2019 onejune.com 版权所有</p>
    <p align="center">互联网违法和不良信息举报电话:0000-12345678 jubao@onejune.com</p>
</div>
</body>
</html>
