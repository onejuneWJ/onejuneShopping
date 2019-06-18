<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/13 0013
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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

        function deleteMember(id) {
            if (confirm("确认删除？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/member/deleteMember/" + id,
                    type: "GET",
                    traditional: true,
                    success: function (data) {
                        if (data == "success") {
                            window.location.reload();
                        } else {
                            alert("删除出错");
                        }
                    }
                });
            }
        }
    </script>
</head>

<body>
<div class="panel panel-default">
    <div class="panel-body">
        <b>会员管理</b>
    </div>
</div>

<div class="panel panel-default goods-search">
    <div class="panel-body">
        <form class="form-inline"
              action="${pageContext.request.contextPath}/member/findByCondition" method="get">
            <div class="form-group">
                <label for="memberName">搜索</label>&nbsp;&nbsp;
                <input type="text" value="${condition}" class="form-control" id="memberName" name="condition"
                       placeholder="输入关键字"/>
            </div>&nbsp;&nbsp;
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
    </div>
</div>

<div class="goods-content">
    <table class="table table-hover">
        <caption>
            <h4> &nbsp;&nbsp;会员列表</h4></caption>
        <thead>
        <tr>
            <th width="10%" style="text-align: center;">会员id</th>
            <th width="25%" style="text-align: center;">会员名</th>
            <th width="10%" style="text-align: center;">年龄</th>
            <th width="15%" style="text-align: center;">性别</th>
            <th width="15%" style="text-align: center;">电话</th>
            <th width="15%" style="text-align: center;">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="member" items="${memberList}">
            <tr>
                <td style="text-align: center;">
                            ${member.id}
                </td>
                <td style="text-align: center;">
                            ${member.name}
                </td>
                <td style="text-align: center;">
                        <c:choose>
                            <c:when test="${member.age!=null&&member.age!=''}">
                                ${member.age}
                            </c:when>
                            <c:otherwise>
                                未填写
                            </c:otherwise>
                        </c:choose>
                </td>
                <td style="text-align: center;"><c:choose>
                        <c:when test="${member.gender!=null&&member.gender!=''}">
                            ${member.gender}
                        </c:when>
                        <c:otherwise>
                            未填写
                        </c:otherwise>
                    </c:choose>
                </td>
                <td style="text-align: center;">
                        <c:choose>
                            <c:when test="${member.tel!=null&&member.tel!=''}">
                                ${member.tel}
                            </c:when>
                            <c:otherwise>
                                未填写
                            </c:otherwise>
                        </c:choose>
                </td>
                <td style="text-align: center;">
                    <div class="btn-group">
                        <button type="button" onclick="deleteMember('${member.id}')" class="btn btn-default">删除</button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <c:if test="${memberList==null||memberList.size()<0||empty memberList}">
        <p align="center">没有记录</p>
    </c:if>
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
