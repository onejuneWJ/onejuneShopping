<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/10 0010
  Time: 17:13
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goods.css"/>
    <title>商品详情</title>
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
        });

        function sub() {
            var num = $("#number");
            var n = num.val();
            var price = '${goods.price}';
            if (n > 1) {
                num.val(n - 1);
            } else {
                num.val(1);
            }
            $("#orderNumber").val(num.val());
            $("#amount").html(price * num.val());
        }

        function add() {
            var num = $("#number");
            var n = num.val();
            var price = '${goods.price}';
            num.val(n - (-1));
            $("#orderNumber").val(num.val());
            $("#amount").html(price * num.val());
        }

        function clearBuy() {
            var memberName = "${sessionScope.CurrentMember.name}";
            var price = '${goods.price}';
            var num = $("#number");
            if (memberName == "") {
                if (confirm("您还没有登录，是否登录")) {
                    location.href = "${pageContext.request.contextPath}/login.jsp";
                }
            }
            $("#orderNumber").val(num.val());
            $("#amount").html(price * num.val());
        }


        function buy() {
            var memberName = "${sessionScope.CurrentMember.name}";
            if (memberName == "") {
                if (confirm("您还没有登录，请登录后购买登录")) {
                    location.href = "${pageContext.request.contextPath}/login.jsp";
                }
            } else {

                var num = $("#orderNumber").val();//购买数量
                var goodsid = "${goods.id}";//商品id
                var memberid = "${sessionScope.CurrentMember.id}";
                var address = $("#address").val();
                var tel = $("#tel").val();
                var amount = document.getElementById("amount").innerHTML;
                var error = $("#new_error");

                if (address == "") {
                    error.show();
                    error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请填写收货地址");
                } else if (tel == "") {
                    error.show();
                    error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请填写联系方式");
                } else {
                    //增加订单
                    $.ajax({
                        url: "${pageContext.request.contextPath}/order/addOrder",
                        type: "get",
                        async: false,
                        data: {
                            "goodsid": goodsid,
                            "memberid": memberid,
                            "amount": amount,
                            "quantity": num,
                            "address": address,
                            "tel": tel
                        },
                        success: function (data) {
                            if (data == "success") {
                                alert("购买成功");
                                window.location.reload();
                            } else {
                                alert("购买失败");
                            }
                        },
                        error: function () {
                            alert("请求错误");
                        }
                    });
                }

            }
        }

        function addToShoppingCar() {
            var memberName = "${sessionScope.CurrentMember.name}";
            if (memberName == "") {
                if (confirm("您还没有登录，请登录！")) {
                    location.href = "${pageContext.request.contextPath}/login.jsp";
                }
            } else {
                var goodsid ='${goods.id}';
                var memberid='${sessionScope.CurrentMember.id}';
                var num = $("#number").val();

                $.ajax({
                    url:"${pageContext.request.contextPath}/shoppingCar/addShoppingCar",
                    data:{"goodsid":goodsid,"memberid":memberid,"number":num},
                    type:"get",
                    async:false,
                    success:function (data) {
                        if(data=="success"){
                            alert("添加购物车成功");
                            window.location.reload();
                        }else {
                            alert("添加失败");
                        }
                    }
                });
            }
        }

        function logout() {
            if (confirm("确认退出？")) {
                location.href = "${pageContext.request.contextPath}/member/logout";
            }
        }
    </script>
</head>
<body>
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
                                <a href="${pageContext.request.contextPath}/index.jsp">欢迎您 ${sessionScope.CurrentMember.name}</a>
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
                        <a href="">
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
                            <img
                                    src="${pageContext.request.contextPath}/img/weipinghui.png"/>
                        </a>
                    </div>
                    <div class="link-item">
                        <a href="https://www.tmall.com/">
                            <img src="${pageContext.request.contextPath}/img/tmall.png"/>
                        </a>

                    </div>
                    <div class="link-item">
                        <a href="http://www.yhd.com/">
                            <img
                                    src="${pageContext.request.contextPath}/img/yihaodian.png"/>
                        </a>

                    </div>
                </div>
            </div>
        </div>
        <!--友情链接-->
    </div>
    <div class="body-right ">
        <div data-spy="scroll" style="width: 1200px;height: 850px; overflow:auto; position: relative;">
            <div class="goods-details">
                <div class="goods-img">
                    <c:choose>
                        <c:when test="${goods.img==null}">
                            <img style="width: 400px;height: 400px"
                                 src="${pageContext.request.contextPath}/img/goods.png"/>
                        </c:when>
                        <c:otherwise>
                            <img width="400px" height="400px" src="${goods.img}"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="goods-detail">
                    <div class="goods-detail-descripiton">
                        <b>${goods.name}</b>
                    </div>
                    <div class="goods-detail-price">
                        价格 <b style="margin-left: 20px;color: red; font-size: 30px;">￥${goods.price}</b>
                    </div>
                    <div class="goods-detail-number">
                        <div style="float: left; padding-top: 3px;">
                            数量
                        </div>
                        <div class="goods-detail-number-input">
                            <div class="input-group">
                                <a href="javascript:sub()" class="input-group-addon">-</a>
                                <input title="" class="form-control" type="text" id="number" value="1"
                                       style="text-align: center;">
                                <a href="javascript:add()" class="input-group-addon">+</a>
                            </div>
                        </div>
                    </div>
                    <div class="goods-detail-btn">
                        <a href="#newOrderModal" onclick="clearBuy()" data-toggle="modal" class="goods-detail-btn-buy">
                            现在购买
                        </a>
                        <a href="javascript:addToShoppingCar()" class="goods-detail-btn-addToShoopingCar">
                            加入购物车
                        </a>
                    </div>

                </div>
            </div>

            <div class="goods-comment">
                <p><b style="font-size: 20px;">商品评价 (<c:choose>
                    <c:when test="${!empty comments||comments.size()>0}">
                        ${comments.size()}
                    </c:when>
                    <c:otherwise>
                        0
                    </c:otherwise>
                </c:choose>)</b></p>

                <c:forEach var="comment" items="${comments}">
                    <hr/>
                    <div class="media">
                        <div class="media-left">
                            <c:choose>
                                <c:when test="${comment.member.avatar==null}">
                                    <%--用户头像为空时使用默认头像--%>
                                    <img src="${pageContext.request.contextPath}/img/img_avatar.png"
                                         class="media-object"
                                         style="width:60px">
                                </c:when>
                                <c:otherwise>
                                    <img src="${comment.member.avatar}" class="media-object"
                                         style="width:60px;height: 60px">
                                </c:otherwise>
                            </c:choose>
                            <p align="center">${comment.member.name}</p>
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">${comment.content}</h4>
                            <div class="goods-comment-bottom">
                                <p style="color: #6C6C6C;">${comment.createtime}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
    </div>
</div>
<%--购买商品确认modal--%>
<div class="modal fade" id="newOrderModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">订单确认&nbsp;&nbsp;&nbsp;&nbsp;
                    <small id="new_error" style="color: red" hidden>

                    </small>
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="newOrderForm">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                            商品名称
                        </label>
                        <div class="col-sm-10">
                            <p style="margin-top: 7px">${goods.name}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="orderNumber" class="col-sm-2 control-label">
                            购买数量
                        </label>
                        <div class="col-sm-10">
                            <div class="goods-detail-number-input">
                                <div class="input-group">
                                    <a href="javascript:sub()" class="input-group-addon">-</a>
                                    <input title="" class="form-control" type="text"
                                           id="orderNumber" value="1"
                                           style="text-align: center;">
                                    <a href="javascript:add()" class="input-group-addon">+</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address" class="col-sm-2 control-label">
                            收货地址
                        </label>
                        <div class="col-sm-10">
                            <input id="address" placeholder="请务必填写正确收货地址" type="text" name="address"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="tel" class="col-sm-2 control-label">
                            联系电话
                        </label>
                        <div class="col-sm-10">
                            <input type="text"
                                    <c:if test="${sessionScope.CurrentMember.tel!=null}">
                                        value="${sessionScope.CurrentMember.tel}"
                                    </c:if>
                                   id="tel" name="tel" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                            总金额
                        </label>
                        <div class="col-sm-10">
                            <p><b id="amount" style="color: red; font-size: 23px">0.00</b> 元</p>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="buy()" class="btn btn-primary">购买</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
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
