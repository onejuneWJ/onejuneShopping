<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/24 0024
  Time: 09:58
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

    <script type="text/javascript">
        function cancelOrder(id) {
            if (confirm("确定取消订单？")) {
                deleteOrders(id);
            }
        }

        function deleteOrder(id) {
            if (confirm("确认删除？")) {
                deleteOrders(id);
            }
        }

        function deleteOrders(id) {
            $.ajax({
                url: "${pageContext.request.contextPath}/order/deleteOrder",
                type: "post",
                traditional: true,
                data: {"ids": id},
                success: function (data) {
                    if (data == "success") {
                        window.location.reload();
                    } else {
                        alert("操作失败");
                    }
                }
            });
        }

        function postComment() {
            var content = $("#content").val();
            if (content != "") {
                var commentData = new FormData($("#commentForm")[0]);
                $.ajax({
                    url: "${pageContext.request.contextPath}/member/addComment",
                    type: "post",
                    data: commentData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data == "success") {
                            window.location.reload();
                        } else {
                            alert("发布失败");
                        }
                    }
                });
            } else {
                alert("评论内容不能为空");
            }
        }

        function notifyCommentModal(goodsid) {
            $("#goodsid").val(goodsid);
        }
    </script>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-body">
        <b>我的订单</b>
    </div>
</div>

<div class="goods-content">
    <table class="table table-hover">
        <caption>
            <h4> &nbsp;&nbsp;订单列表</h4></caption>
        <thead>
        <tr>
            <th width="20%"> &nbsp;&nbsp;&nbsp;&nbsp;订单编号
            </th>
            <th width="12%" style="text-align: center;">商品</th>
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
                        ${order.number}
                </td>
                <td style="text-align: center;">
                        ${order.goods.name}
                </td>
                <td style="text-align: center;">
                        ${order.quantity}
                </td>
                <td style="text-align: center;">
                        ￥${order.amount}
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

                        <c:choose>
                            <c:when test="${order.delivered!=true}">
                                <button type="button" id="" onclick="cancelOrder('${order.number}')"
                                        class="btn btn-primary">取消订单
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" id="deleteOne" onclick="deleteOrder('${order.number}')"
                                        class="btn btn-default">删除订单
                                </button>
                                <button type="button" data-toggle="modal" data-target="#postComment"
                                        onclick="notifyCommentModal(${order.goodsid})"
                                        class="btn btn-default">评价
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <c:if test="${orderList==null||orderList.size()<0||empty orderList}">
        <p align="center">没有订单信息</p>
    </c:if>

</div>
<%--添加评价格模态框--%>
<div class="modal fade" id="postComment" tabindex="-1" role="dialog" aria-labelledby="postCommentTitle"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="postCommentTitle">商品评价</h4>
            </div>
            <div class="modal-body">
                <form id="commentForm" class="form-horizontal">
                    <div class="form-group">
                        <label for="content" class="col-sm-2 control-label">
                            评价内容
                        </label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="content" name="content"></textarea>
                        </div>
                    </div>
                    <input type="hidden" name="goodsid" id="goodsid">
                    <input type="hidden" name="memberid" value="${sessionScope.CurrentMember.id}">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="postComment()" class="btn btn-primary">发布</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
