<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/14 0014
  Time: 11:15
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/goods.css"/>
    <script>
        $(function () {
            $(".tooltip-options a").tooltip({
                html: true
            });
        });

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
                    $("#deleteMany").attr("disabled", false);
                } else {
                    $("#deleteMany").attr("disabled", true);
                }
            });

            //给name=box的复选框绑定单击事件
            $("input[name=box]").click(function () {
                //获取选中复选框长度
                var length = $("input[name=box]:checked").length;
                if (length > 0) {
                    $("#deleteMany").attr("disabled", false);
                } else {
                    $("#deleteMany").attr("disabled", true);
                }
                //未选中的长度
                var len = $("input[name=box]").length;
                if (length == len) {
                    $("#all").get(0).checked = true;
                } else {
                    $("#all").get(0).checked = false;
                }
            });
        });


        function deleteOrder(id, btnid) {
            if (confirm("确认删除？")) {
                //所有选中复选框
                var checkboxes = $("input[name=box]:checked");
                //创建一个数组储存所有选中复选框的值
                var values = new Array();

                if (id != "") {//删除一个
                    values.push(id);
                } else {//删除多个
                    //遍历所有复选框
                    var getSelectedValueElements = checkboxes.each(function (i) {
                        if (i > -1) {
                            values.push($(this).val());
                        }
                    });
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/deleteOrder",
                    type: "post",
                    traditional: true,
                    data: {"ids": values},
                    success: function (data) {
                        if (data == "success") {
                            window.location.reload();
                        } else {
                            alert("删除失败");
                        }
                    }
                });
            }
        }

        function deliver(number) {
            $.ajax({
                url: "${pageContext.request.contextPath}/order/deliver/" + number,
                type: "get",
                success: function (data) {
                    if (data == "success") {
                        alert("发货成功");
                        window.location.reload();
                    } else {
                        alert("发货成功");
                    }
                }
            });
        }
    </script>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-body">
        <b>订单管理</b>
    </div>
</div>
<div id="info" hidden="hidden" class="alert alert-success alert-dismissable goods-search">
    <button type="button" class="close" data-dismiss="alert"
            aria-hidden="true">
        &times;
    </button>
    成功！很好地完成了提交。
</div>
<div class="panel panel-default goods-search">
    <div class="panel-body">
        <form id="searchOrderForm" class="form-inline"
              action="${pageContext.request.contextPath}/order/findByCondition"
              method="get">
            <div class="form-group">
                <label for="condition">搜索订单</label>&nbsp;&nbsp;
                <input type="text" class="form-control" id="condition"
                       name="condition" value="${condition}" placeholder="输入关键字搜索订单"/>
            </div>&nbsp;&nbsp;
            <div class="form-group">
                <label for="bigType">大类别</label>
                <select class="form-control" id="bigType" name="bigType" onchange="findSmallTypeByBig(this.value)">
                    <option value="">--请选择--</option>
                    <c:forEach var="bigtype" items="${bigtypeList}">
                        <option value="${bigtype.id}"
                                <c:if test="${bigtypeid==bigtype.id}"> selected</c:if>>
                                ${bigtype.bigname}
                        </option>
                    </c:forEach>
                </select>
            </div>&nbsp;&nbsp;
            <div class="form-group">
                <label for="smallType">小类别</label>
                <select class="form-control" id="smallType" name="smallType">
                    <option value="">--请选择--</option>
                    <c:forEach var="smallType" items="${smalltypeList}">
                        <option value="${smallType.id}"
                                <c:if test="${smalltypeid==smallType.id}"> selected</c:if>>
                                ${smallType.smallname}
                        </option>
                    </c:forEach>
                </select>
            </div>&nbsp;
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
    </div>
</div>
<div class="goods-options">
    <div class="btn-group">
        <button type="button" id="deleteMany" onclick="deleteOrder('',this)" class="btn btn-default"
                disabled="disabled">删除
        </button>
    </div>
</div>

<div class="goods-content">
    <table class="table table-hover">
        <caption>
            <h4> &nbsp;&nbsp;订单列表</h4></caption>
        <thead>
        <tr>
            <th width="20%">
                <input id="all" type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;订单编号
            </th>
            <th width="12%" style="text-align: center;">商品</th>
            <th width="10%" style="text-align: center;">收货人</th>
            <th width="5%" style="text-align: center;">商品数量</th>
            <th width="8%" style="text-align: center;">订单金额</th>
            <th width="10%" style="text-align: center;">收货地址</th>
            <th width="10%" style="text-align: center;">收货人电话</th>
            <th width="5%" style="text-align: center;">是否发货</th>
            <th width="8%" style="text-align: center;">备注</th>
            <th width="18%" style="text-align: center;">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" varStatus="x" items="${orderList}">
            <tr>
                <td>
                    <input name="box" type="checkbox" value="${order.number}"/>&nbsp;${order.number}
                </td>
                <td style="text-align: center;">
                        ${order.goods.name}
                </td>
                <td style="text-align: center;">
                        ${order.member.name}
                </td>
                <td style="text-align: center;">
                        ${order.quantity}
                </td>
                <td style="text-align: center;">
                        ${order.amount}
                </td>
                <td style="text-align: center;">
                        ${order.address}
                </td>
                <td style="text-align: center;">
                        ${order.tel}
                </td>
                <td style="text-align: center;">
                    <c:choose>
                        <c:when test="${order.delivered!=true}">
                            否
                        </c:when>
                        <c:otherwise>
                            是
                        </c:otherwise>
                    </c:choose>

                </td>
                <td style="text-align: center;">
                        ${order.bz}
                </td>
                <td style="text-align: center;">
                    <div class="btn-group">
                        <c:if test="${order.delivered!=true}">
                            <button type="button" id="" onclick="deliver('${order.number}')"
                                    class="btn btn-default">发货
                            </button>
                        </c:if>
                        <button type="button" id="deleteOne" onclick="deleteOrder('${order.number}',this)"
                                class="btn btn-default">删除
                        </button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <c:if test="${orderList==null||orderList.size()<0||empty orderList}">
        <p align="center">没有订单信息</p>
    </c:if>
    <ul class="pagination">
        <li><a href="${pageContext.request.contextPath}/order/findByPage?page=${currentPage-1}&offset=5">&laquo;</a>
        </li>
        <li><a href="${pageContext.request.contextPath}/order/findByPage?page=0&offset=5">1</a></li>
        <li><a href="${pageContext.request.contextPath}/order/findByPage?page=1&offset=5">2</a></li>
        <li><a href="${pageContext.request.contextPath}/order/findByPage?page=2&offset=5">3</a></li>
        <li><a href="${pageContext.request.contextPath}/order/findByPage?page=3&offset=5">4</a></li>
        <li><a href="${pageContext.request.contextPath}/order/findByPage?page=4&offset=5">5</a></li>
        <li><a href="${pageContext.request.contextPath}/order/findByPage?page=${currentPage+1}&offset=5">&raquo;</a>
        </li>
    </ul>
</div>

<!--返回顶部按钮-->
<div id="rightButton">
    <div id="backToTop">
        <a href="javascript:" onfocus="this.blur();" class="backToTop_a png"><i class="fa fa-arrow-up"
                                                                                aria-hidden="true"></i> 返回顶部</a>
    </div>
</div>
<script type="text/javascript">
    $("#backToTop").on("click", function () {
        var _this = $(this);
        $('html,body').animate({
            scrollTop: 0
        }, 500, function () {
            _this.hide();
        });
    });

    $(window).scroll(function () {
        var htmlTop = $(document).scrollTop();
        if (htmlTop > 0) {
            $("#backToTop").fadeIn();
        } else {
            $("#backToTop").fadeOut();
        }
    });

</script>

</body>
</html>
