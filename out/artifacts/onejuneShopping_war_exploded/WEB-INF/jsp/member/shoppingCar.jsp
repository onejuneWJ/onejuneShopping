<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/30 0030
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/oneday.png"/>
    <title>购物车</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/main.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shoppingCar.css">

    <script>
        function logout() {
            if (confirm("确认退出？")) {
                location.href = "${pageContext.request.contextPath}/member/logout";
            }
        }

        $(function () {
            //给全选的复选框添加事件
            $("#all").click(function () {
                // this 全选的复选框
                var all = this.checked;
                //获取name=box的复选框 遍历输出复选框
                $("input[name=box]").each(function () {
                    this.checked = all;
                });

                var length = $("input[name=box]:checked").length;
                if (length > 0) {
                    $("#buy").attr("disabled", false);
                } else {
                    $("#buy").attr("disabled", true);
                }
                showAllAmount();

            });

            //给name=box的复选框绑定单击事件
            $("input[name=box]").click(function () {
                //获取选中复选框长度
                var length = $("input[name=box]:checked").length;

                //总长度
                var len = $("input[name=box]").length;
                $("#all").get(0).checked = length == len;
                if (length > 0) {
                    $("#buy").attr("disabled", false);
                } else {
                    $("#buy").attr("disabled", true);
                }
                showAllAmount();

            });
        });

        function add(i) {
            var input = $("#quantity" + i);
            var quantity = input.val();
            input.val(quantity - (-1));
            showAmount(i);
            showAllAmount();
        }

        function sub(i) {
            var input = $("#quantity" + i);
            var quantity = input.val();
            if (quantity > 0) {
                input.val(quantity - 1);
            } else {
                input.val(0);
            }
            showAmount(i);
            showAllAmount();
        }

        function showAmount(i) {
            var amount = document.getElementById("amount" + i);
            var price = document.getElementById("price" + i).innerHTML;
            var quantity = $("#quantity" + i).val();
            amount.innerHTML = (quantity * price).toFixed(1);
        }

        function showAllAmount() {
            //获取选中复选框长度
            var length = $("input[name=box]:checked").length;
            var amount = 0.0;
            for (var i = 0; i < length; i++) {
                amount += parseFloat(document.getElementById("amount" + i).innerHTML);
            }
            document.getElementById("amount").innerHTML = amount.toFixed(1);//总金额
        }

        function checkAddress() {
            var address = $("#address").val();
            var error = $("#new_error");
            if (address == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请填写收货地址");
                return false;
            } else {
                return true;
            }
        }

        function buy() {
            if (checkAddress()) {
                if (confirm("确认购买选中的商品？")) {
                    var checkboxes = $("input[name=box]:checked");
                    var length = checkboxes.length;
                    var amounts = []; //所有商品的金额集合
                    var quantities = [];//所有商品数量的集合
                    var ids = [];//购物车id集合 购买创建订单之后删除购物车
                    var goodsIds=[];//商品id集合
                    var address=$("#address").val();
                    for (var i = 0; i < length; i++) {
                        var x = checkboxes[i].id;
                        var amount = parseFloat(document.getElementById("amount" + x).innerHTML);
                        var quantity = parseInt($("#quantity" + x).val());
                        var id = parseInt(checkboxes[i].value);
                        var goodsId=parseInt($("#goodsId"+x).val());
                        amounts.push(amount);
                        quantities.push(quantity);
                        ids.push(id);
                        goodsIds.push(goodsId);
                    }
                    var data={"ids": ids, "amounts": amounts,"quantities":quantities,"goodsIds":goodsIds,"address":address};
                    $.ajax({
                        url: "${pageContext.request.contextPath}/shoppingCar/buy",
                        type: "post",
                        async: false,
                        contentType : "application/json",
                        data: JSON.stringify(data),
                        success: function (data) {
                            if (data == "success") {
                                alert("购买成功!");
                                window.location.reload();
                            } else {
                                alert("购买失败!");
                            }
                        },
                        error:function () {
                            alert("请求出错");
                        }
                    });

                }
            }
        }

        function deleteS(id) {
            if (confirm("确认删除？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/shoppingCar/delete",
                    data: {"id": id},
                    type: "get",
                    async: false,
                    success: function (data) {
                        if (data == "success") {
                            window.location.reload();
                        } else {
                            alert("删除失败");
                        }
                    },
                    error: function () {
                        alert("请求出错");
                    }
                });
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
<div class="content">
    <div class="head-items">
        <h2 class="head-text">我的购物车</h2>
        <div class="head-items-right">
            <div class="btn-group buyBtn">
                <button id="buy" disabled="disabled" type="button" class="btn btn-primary btn-block" data-toggle="modal"
                        data-target="#newOrderModal">购买
                </button>
            </div>
            <div class="amount">总金额：￥
                <b id="amount">0.0</b>
            </div>
        </div>
    </div>
    <hr/>

    <div class="">
        <div class="titles">
            <div class="titles-checkAll">
                <input title="全选" type="checkbox" id="all"
                       style="margin-top: 13px; margin-left: 10px;"/> 全选
            </div>
            <div class="titles-goods-name">
                <p>商品名称</p>
            </div>
            <div class="titles-goods-price">
                <p>单价</p>
            </div>
            <div class="titles-goods-quantity">
                <p>数量</p>
            </div>
            <div class="titles-goods-amount">
                <p>金额</p>
            </div>
            <div class="titles-goods-operate">
                <p>操作</p>
            </div>
        </div>
    </div>

    <c:forEach items="${shoppingCarList}" var="shoppingCar" varStatus="x">
        <div class="goods" id="goods${x.index}">
            <div class="goods-attribute">
                <input title="" type="checkbox" name="box" value="${shoppingCar.id}" id="${x.index}"
                       style="float: left;"/>
                <input type="hidden" id="goodsId${x.index}" value="${shoppingCar.goods.id}">
                <div class="goods-img">
                    <img style="width: 90px" src="${shoppingCar.goods.img}"/>
                </div>
                <div class="goods-name">
                    <a href="${pageContext.request.contextPath}/goods/toGoodsDetails?id=${shoppingCar.goods.id}">${shoppingCar.goods.name}</a>
                </div>
            </div>
            <div class="goods-price">
                <b>￥</b><b id="price${x.index}">${shoppingCar.goods.price}</b>
            </div>
            <div class="goods-quantity">
                <div class="num-input">
                    <div class="input-group">
                        <a href="javascript:sub('${x.index}')" class="input-group-addon">-</a>
                        <input title="" class="form-control" type="text" id="quantity${x.index}"
                               value="${shoppingCar.number}"
                               style="text-align: center;">
                        <a href="javascript:add('${x.index}')" class="input-group-addon">+</a>
                    </div>
                </div>
            </div>
            <div class="goods-amount">
                <b>￥</b><b id="amount${x.index}" style="color: red;">${shoppingCar.goods.price*shoppingCar.number}</b>
            </div>
            <div class="goods-operation">
                <p>
                    <a href="javascript:deleteS('${shoppingCar.id}')">删除</a>
                </p>
            </div>
        </div>

    </c:forEach>

    <c:if test="${shoppingCarList.size()<=0}">
        <p align="center">购物车空空如也</p>
    </c:if>
</div>
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
                        <label for="address" class="col-sm-2 control-label">
                            收货地址
                        </label>
                        <div class="col-sm-10">
                            <input id="address" type="text" name="address" class="form-control">
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
</body>
</html>
