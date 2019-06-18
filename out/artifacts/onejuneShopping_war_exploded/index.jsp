<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/30 0030
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <base href="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/oneday.png"/>
    <title>主页</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <script type="text/javascript">
        $(document).ready(function () {
            //显示公告栏内容
            $.ajax({
                url: "${pageContext.request.contextPath}/notice/showNotice",
                type: "post",
                async: false,
                dataType: "json",
                success: function (data) {
                    var htmls = "<div class='panel-group' id='accordion'>";
                    for (var i = 0; i < data.length; i++) {
                        var notice = data[i];
                        var id = "collapse" + i;
                        htmls += "<div class='panel panel-success'>" +
                            "<div class='panel-heading'>" +
                            "<h4 class='panel-title'>" +
                            "<a data-toggle='collapse' data-parent='#accordion' href='#" + id + "'>" +
                            notice.title +
                            "</a>" +
                            "</h4>" +
                            "</div>" +
                            "<div id='" + id + "' class='panel-collapse collapse'>" +
                            "<div class='panel-body'>" + notice.content +
                            "<p></p><p align='right'>发布时间：" + notice.issuetime +
                            "</p>" +
                            "</div>" +
                            "</div>" +
                            "</div>";
                    }
                    htmls += "</div>";
                    $("#notices").html(htmls);
                }
            });
            //显示搜索框中的大类别
            $.ajax({
                url: "${pageContext.request.contextPath}/goods/findAllBigType",
                type: "get",
                async: false,
                dataType: "json",
                success: function (data) {
                    var bigTypeHtml = "<option value=\"\">--请选择--</option>";
                    for (var i = 0; i < data.length; i++) {
                        var bigType = data[i];
                        bigTypeHtml += "<option value=\"" + bigType.id + "\">" + bigType.bigname + "</option>";
                    }
                    $("#bigType").html(bigTypeHtml);
                }
            });
            //网页加载时商品列表默认显示第一个
            findGoodsBySmallId(296127158, 'womenDiv');
            $("#womenLi").addClass("active");
            $("#womenDiv").addClass("in active");
        });

        /**
         *
         * @param bigTypeid 大类别id
         * @param bigtye 大类别下拉框的id
         * @param bigTypeDiv 显示商品的DIV
         */
        function findSmallType(bigTypeid, bigtye, bigTypeDiv) {
            $.ajax({
                url: "${pageContext.request.contextPath}/goods/findAllSmallType/" + bigTypeid,
                type: "GET",
                async: false,
                dataType: "json",
                success: function (data) {
                    var smallTypeHtml = "";
                    for (var i = 0; i < data.length; i++) {
                        var smallType = data[i];
                        smallTypeHtml += "<li>\n" +
                            "<a href=\"#" + bigTypeDiv + "\" data-toggle=\"tab\" " +
                            "onclick=\"findGoodsBySmallId(" + smallType.id + ",'" + bigTypeDiv +
                            "')\">" + smallType.smallname +
                            "</a>" +
                            "</li>";
                    }
                    $("#" + bigtye).html(smallTypeHtml);
                }
            });
        }


        function findSmallTypeByBig(bigid) {
            $.ajax({
                url: "${pageContext.request.contextPath}/goods/findAllSmallType/" + bigid,
                type: "GET",
                async: false,
                dataType: "json",
                success: function (data) {
                    var smallTypeHtml = "<option value=\"\">--请选择--</option>";
                    for (var i = 0; i < data.length; i++) {
                        var smallType = data[i];
                        smallTypeHtml += "<option value=\"" + smallType.id + "\">" + smallType.smallname + "</option>";
                    }
                    $("#smallType").html(smallTypeHtml);
                }
            });
        }

        function findGoodsBySmallId(smallId, bigTypeDiv) {
            var div = document.getElementById(bigTypeDiv);
            div.innerHTML = "";
            $.ajax({
                url: "${pageContext.request.contextPath}/goods/findGoodsBySmallId/" + smallId,
                type: "POST",
                async: false,
                dataType: "json",
                success: function (data) {
                    var goodsHtml = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var goods = data[i];
                            goodsHtml += "<div class=\"goods-item\">\n" +
                                "<a href=\"${pageContext.request.contextPath}/goods/toGoodsDetails?id=" + goods.id +
                                "\">" +
                                "<div class=\"goods-item-img\">";
                            if (goods.img != null) {
                                goodsHtml += "<img width=\"280px\" height=\"280px\" src=\"" + goods.img + "\"/>";
                            } else {
                                goodsHtml += "<img width=\"280px\" height=\"280px\" src=\"${pageContext.request.contextPath}/img/goods.png\"/>";
                            }
                            goodsHtml += "</div>\n" +
                                "</a>\n" +
                                "<div class=\"goods-item-discription\">\n" +
                                "<a href=\"${pageContext.request.contextPath}/goods/toGoodsDetails?id=" + goods.id +
                                "\">" + goods.name +
                                "</a>\n" +
                                "</div>\n" +
                                "<div class=\"goods-item-price\">￥" +
                                "<b>" + goods.price +
                                "</b>" +
                                "</div>\n" +
                                "<div class=\"goods-item-from\">" + goods.goodfrom +
                                "</div>\n" +
                                "</div>";
                        }
                        div.innerHTML = goodsHtml;
                    } else {
                        div.innerHTML = "<p align=\"center\">暂无商品</p>";
                        div.addClass("active");
                    }
                }
            });
        }

        function logout() {
            if (confirm("确认退出？")) {
                location.href = "${pageContext.request.contextPath}/member/logout";
            }
        }

        function searchGoods() {
            var goodsName = $("#goodsName");
            var bigType = $("#bigType").val();
            var smallType = $("#smallType").val();
            var sortOrder = $("#sortOrder").val();
            var name = goodsName.val();
            $.ajax({
                url: "${pageContext.request.contextPath}/goods/findByConditionsIndex", type: "GET",
                data: {"name": name, "bigType": bigType, "smallType": smallType, "sortOrder": sortOrder},
                async: false,
                dataType: "json",
                success: function (data) {
                    $("#womenLi").removeClass("active");
                    $("#menLi").removeClass("active");
                    $("#digitalLi").removeClass("active");
                    $("#furnitureLi").removeClass("active");
                    $("#luggageLi").removeClass("active");

                    var div = document.getElementById("otherGoods");
                    var goodsHtml = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var goods = data[i];
                            goodsHtml += "<div class=\"goods-item\">\n" +
                                "<a href=\"${pageContext.request.contextPath}/goods/toGoodsDetails?id=" + goods.id +
                                "\">" +
                                "<div class=\"goods-item-img\">";
                            if (goods.img != null) {
                                goodsHtml += "<img width=\"280px\" height=\"280px\" src=\"" + goods.img + "\"/>";
                            } else {
                                goodsHtml += "<img width=\"280px\" height=\"280px\" src=\"${pageContext.request.contextPath}/img/goods.png\"/>";
                            }
                            goodsHtml += "</div>\n" +
                                "</a>\n" +
                                "<div class=\"goods-item-discription\">\n" +
                                "<a href=\"${pageContext.request.contextPath}/goods/toGoodsDetails?id=" + goods.id +
                                "\">" + goods.name +
                                "</a>\n" +
                                "</div>\n" +
                                "<div class=\"goods-item-price\">￥" +
                                "<b>" + goods.price +
                                "</b>" +
                                "</div>\n" +
                                "<div class=\"goods-item-from\">" + goods.goodfrom +
                                "</div>\n" +
                                "</div>";
                        }
                        div.innerHTML = goodsHtml;
                        div.addClass("active");
                    } else {
                        div.innerHTML = "<p align=\"center\">暂无商品</p>";
                        div.addClass("active");
                    }
                }

            });

        }
    </script>
</head>

<body style="background: rgb(250,250,250);">
<div class="heads navbar-inverse">
    <div class="head-nav">
        <nav class="navbar navbar-inverse" role="navigation" style="border: hidden;">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">ONEJUNE购物商城</a>
                </div>
                <ul class="nav navbar-nav navbar-left">
                    <c:choose>
                        <c:when test="${empty sessionScope.CurrentMember}">
                            <li>
                                <a style="color: #ff1c21"
                                   href="${pageContext.request.contextPath}/member/login">亲，请登录</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/register.jsp">注册</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="${pageContext.request.contextPath}/member/toMain">欢迎您 ${sessionScope.CurrentMember.name}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="${pageContext.request.contextPath}/member/toMain">
                            <i class="fa fa-user-circle-o" aria-hidden="true"></i> &nbsp;个人中心
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/member/toShoppingCar">
                            <i class="fa fa-shopping-cart" aria-hidden="true"></i> &nbsp;购物车
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-star" aria-hidden="true"></i> &nbsp;收藏夹
                        </a>
                    </li>
                    <c:if test="${not empty sessionScope.CurrentMember}">
                        <li>
                            <a href="javascript:logout()">
                                <i class="fa fa-sign-out" aria-hidden="true"></i> &nbsp;退出登录
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </nav>
    </div>
</div>

<div class="body-content">
    <div class="body-left">
        <div class="affiche">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">公告栏</h3>
                </div>
                <div class="panel-body">
                    <div data-spy="scroll " style="height:400px;overflow:auto; position: relative; " id="notices">

                    </div>
                    <!--滑动-->
                </div>
            </div>
        </div>
        <!--公告-->
        <div class="link">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">友情链接</h3>
                </div>
                <div class="panel-body" style="height:330px; width: 330px;">
                    <div class="link-item">
                        <a href="https://www.jd.com/">
                            <img src="${pageContext.request.contextPath}/img/jd.png"/>
                        </a>

                    </div>
                    <div class="link-item">
                        <a href="https://www.suning.com/">
                            <img src="${pageContext.request.contextPath}/img/suning.png"/>
                        </a>
                    </div>
                    <div class="link-item">
                        <a href="https://www.taobao.com/">
                            <img src="${pageContext.request.contextPath}/img/taobao.png"/>
                        </a>
                    </div>
                    <div class="link-item">
                        <a href="https://www.vip.com/">
                            <img src="${pageContext.request.contextPath}/img/weipinghui.png"/>
                        </a>
                    </div>
                    <div class="link-item">
                        <a href="https://www.tmall.com/">
                            <img src="${pageContext.request.contextPath}/img/tmall.png"/>
                        </a>

                    </div>
                    <div class="link-item">
                        <a href="http://www.yhd.com/">
                            <img src="${pageContext.request.contextPath}/img/yihaodian.png"/>
                        </a>

                    </div>
                </div>
            </div>
        </div>
        <!--友情链接-->
    </div>
    <div class="body-right" style="">

        <div class="panel panel-default goods-search">
            <div class="panel-body">
                <form id="searchGoods" class="form-inline">
                    <div class="form-group">
                        <label for="goodsName">商品名称</label>
                        <input type="text" class="form-control" id="goodsName" name="name"/>
                    </div>&nbsp;&nbsp;
                    <div class="form-group">
                        <label for="bigType">大类别</label>
                        <select class="form-control" id="bigType" name="bigType"
                                onchange="findSmallTypeByBig(this.value)">
                            <option value="">--请选择--</option>

                        </select>
                    </div>&nbsp;&nbsp;
                    <div class="form-group">
                        <label for="smallType">小类别</label>
                        <select class="form-control" id="smallType" name="smallType">
                            <option value="">--请选择--</option>

                        </select>
                    </div>&nbsp;&nbsp;
                    <div class="form-group">
                        <label for="sortOrder">排序方式</label>
                        <select id="sortOrder" name="sortOrder" class="form-control">
                            <option value="">--请选择--</option>
                            <option value="1">上架时间</option>
                            <option value="2">价格升序</option>
                            <option value="-2">价格降序</option>
                            <option value="3">购买次数</option>
                        </select>
                    </div>&nbsp;&nbsp;
                    <a href="#otherGoods" type="button" data-toggle="tab" onclick="searchGoods()"
                       class="btn btn-primary">查询</a>
                    <button type="reset" class="btn btn-default">重置</button>
                </form>
            </div>
        </div>
        <%--商品搜索--%>

        <div class="goods-category">
            <ul class="nav nav-tabs nav-justified">
                <li id="womenLi" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"
                       onclick="findSmallType(1,'women','womenDiv')">
                        <i class="fa fa-female" aria-hidden="true"></i> &nbsp;女人
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" id="women"></ul>
                </li>
                <li id="menLi" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"
                       onclick="findSmallType(2,'men','menDiv')">
                        <i class="fa fa-male" aria-hidden="true"></i> &nbsp;男人
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" id="men"></ul>
                </li>
                <li id="digitalLi" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"
                       onclick="findSmallType(3,'digital','digitalDiv')">
                        <i class="fa fa-camera" aria-hidden="true"></i> &nbsp;数码
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" id="digital"></ul>
                </li>
                <li id="furnitureLi" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"
                       onclick="findSmallType(4,'furniture','furnitureDiv')">
                        <i class="fa fa-television" aria-hidden="true"></i> &nbsp;家居
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" id="furniture"></ul>
                </li>
                <li id="luggageLi" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"
                       onclick="findSmallType(5,'luggage','luggageDiv')">
                        <i class="fa fa-shopping-bag" aria-hidden="true"></i> &nbsp;箱包
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" id="luggage"></ul>
                </li>
            </ul>
        </div>
        <!--商品分类导航-->
        <div class="goods-list">
            <div data-spy="scroll" style="width: 1180px;height: 700px; overflow:auto; position: relative;">
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade" id="womenDiv">

                    </div>
                    <div class="tab-pane fade" id="menDiv">
                    </div>
                    <div class="tab-pane fade" id="digitalDiv">
                    </div>
                    <div class="tab-pane fade" id="furnitureDiv">
                    </div>
                    <div class="tab-pane fade" id="luggageDiv">
                    </div>

                    <div class="tab-pane fade" id="otherGoods">

                    </div>
                </div>
                <!--tab-content-->
            </div>
            <!--滑动-->
        </div>
        <!--商品列表-->
    </div>
</div>
<div class="footer ">
    <p align="center">© 2018-2019 onejune.com 版权所有</p>
    <p align="center">互联网违法和不良信息举报电话:0000-12345678 jubao@onejune.com</p>
</div>
</body>
</html>
