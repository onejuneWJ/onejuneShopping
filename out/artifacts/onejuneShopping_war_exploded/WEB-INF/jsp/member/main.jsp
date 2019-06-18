<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/24 0024
  Time: 12:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/oneday.png"/>
    <title>个人中心</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/main.css"/>

    <script type="text/javascript">
        function beActive(id) {
            var l = $("#" + id);
            var info = $("#info");
            var order = $("#order");
            if (!l.is('active') && id == "info") {
                l.addClass('active');
                order.removeClass('active')
            }
            if (!l.is('active') && id == "order") {
                l.addClass('active');
                info.removeClass('active')
            }
        }

        $('#myTab a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });

        function logout() {
            if (confirm("确认退出？")) {
                location.href = "${pageContext.request.contextPath}/member/logout";
            }
        }

    </script>
</head>
<body style="background: rgb(150,150,150);">
<div class="heads navbar-inverse">
    <div class="head-nav">
        <nav class="navbar navbar-inverse" role="navigation" style="border: hidden;">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">ONEJUNE购物商城</a>
                </div>
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a href="${pageContext.request.contextPath}/member/toMain">欢迎您，${sessionScope.CurrentMember.name}</a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="${pageContext.request.contextPath}/member/toShoppingCar">
                            <i class="fa fa-shopping-cart" aria-hidden="true"></i> &nbsp;购物车
                        </a>
                    </li>
                    <li>
                        <a href="javascript:logout()">
                            <i class="fa fa-sign-out" aria-hidden="true"></i> &nbsp;退出登录
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</div>
<div class="main-content">
    <div class="left-nav">
        <ul id="myTab" class="nav nav-pills nav-stacked">
            <li class="divider"></li>
            <li id="info" class="active">
                <a onclick="beActive('info')"
                   href="${pageContext.request.contextPath}/member/toInfo" target="main">
                    <i class="fa fa-user-circle" aria-hidden="true"></i> &nbsp;&nbsp;我的信息
                </a>
            </li>
            <li id="order">
                <a onclick="beActive('order')"
                   href="${pageContext.request.contextPath}/member/toOrder" target="main">
                    <i class="fa fa-object-group" aria-hidden="true"></i> &nbsp;&nbsp;我的订单
                </a>
            </li>
        </ul>
    </div>
    <div class="right-content">
        <iframe src="${pageContext.request.contextPath}/member/toInfo" name="main" width="1248px" height="900px"
                frameborder="0">
        </iframe>
    </div>
</div>
</body>
</html>
