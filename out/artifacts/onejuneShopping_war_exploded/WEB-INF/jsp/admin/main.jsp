<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/12 0012
  Time: 20:28
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
    <title>管理员主页</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/main.css"/>

    <script type="text/javascript">
        function beActive(id) {
            var l = $("#" + id);
            var notice = $("#notice");
            var goods = $("#goods");
            var member = $("#member");
            var order = $("#order");
            if (!l.is('active') && id == "notice") {
                l.addClass('active');
                goods.removeClass('active');
                member.removeClass('active');
                order.removeClass('active')
            }
            if (!l.is('active') && id == "goods") {
                l.addClass('active');
                notice.removeClass('active');
                member.removeClass('active');
                order.removeClass('active')
            }
            if (!l.is('active') && id == "member") {
                l.addClass('active');
                goods.removeClass('active');
                notice.removeClass('active');
                order.removeClass('active')
            }
            if (!l.is('active') && id == "order") {
                l.addClass('active');
                goods.removeClass('active');
                notice.removeClass('active');
                member.removeClass('active')
            }
        }

        $('#myTab a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });

        function logout() {
            if (confirm("确认退出？")) {
                location.href = "${pageContext.request.contextPath}/admin/logout";
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
                    <a class="navbar-brand" href="#">ONEJUNE购物商城</a>
                </div>
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a href="#">当前操作者:${sessionScope.CurrentManager.name}</a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
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
            <li id="notice" class="active">
                <a onclick="beActive('notice')"
                   href="${pageContext.request.contextPath}/admin/toNotice" target="main">
                    <i class="fa fa-flag" aria-hidden="true"></i> &nbsp;&nbsp;公告管理
                </a>
            </li>
            <li id="goods">
                <a onclick="beActive('goods')"
                   href="${pageContext.request.contextPath}/admin/toGoods" target="main">
                    <i class="fa fa-shopping-bag" aria-hidden="true"></i> &nbsp;&nbsp;商品管理
                </a>
            </li>
            <li id="member">
                <a onclick="beActive('member')"
                   href="${pageContext.request.contextPath}/admin/toMember" target="main">
                    <i class="fa fa-user-circle" aria-hidden="true"></i> &nbsp;&nbsp;会员管理
                </a>
            </li>
            <li id="order">
                <a onclick="beActive('order')"
                   href="${pageContext.request.contextPath}/admin/toOrder" target="main">
                    <i class="fa fa-object-group" aria-hidden="true"></i> &nbsp;&nbsp;订单管理
                </a>
            </li>
        </ul>
    </div>
    <div class="right-content">
        <iframe src="${pageContext.request.contextPath}/admin/toNotice" name="main" width="1248px" height="900px"
                frameborder="0">
        </iframe>
    </div>
</div>
</body>
</html>
