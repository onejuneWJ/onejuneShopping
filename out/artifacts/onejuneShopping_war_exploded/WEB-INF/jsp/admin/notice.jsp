<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/13 0013
  Time: 10:18
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/notice.css"/>

    <script type="text/javascript">
        function clearNew() {
            $("#new_title").val("");
            $("#new_content").val("");
        }

        function newNotice() {
            var title = $("#new_title").val();
            var content = $("#new_content").val();
            var error = $("#new_error");
            if (title == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 标题不能为空");
            } else if (content == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 内容不能为空");
            } else {
                $.ajax({
                    url: "${pageContext.request.contextPath}/notice/newNotice",
                    type: "post",
                    data: {"title": title, "content": content},
                    success: function (data) {
                        if (data == "success") {
                            window.location.reload();
                        } else {
                            alert("发布失败");
                        }
                    }
                });
            }
        }

        function editUpdate(id) {
            $.ajax({
                url: "${pageContext.request.contextPath}/notice/findById/" + id,
                type: "get",
                success: function (data) {
                    if (data != null) {
                        $("#update_id").val(data.id)
                        $("#update_title").val(data.title);
                        $("#update_content").val(data.content);
                    }
                }
            });
        }

        function updateNotice() {
            var title = $("#update_title").val();
            var id = $("#update_id").val();
            var content = $("#update_content").val();
            var error = $("#update_error");
            if (title == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 标题不能为空");
            }
            if (content == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 内容不能为空");
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/notice/updateNotice",
                type: "post",
                data: {"id": id, "title": title, "content": content},
                success: function (data) {
                    if (data == "success") {
                        window.location.reload();
                    } else {
                        alert("发布失败");
                    }
                }
            });
        }

        function deleteNotice(id) {
            if (confirm("确认删除？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/notice/deleteNotice",
                    type: "post",
                    traditional: true,
                    data: {"ids": id},
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

        function deleteManyNotice() {
            if (confirm("确认删除？")) {
                //所有选中复选框
                var checkboxes = $("input[name=box]:checked");
                //创建一个数组储存所有选中复选框的值
                var values = new Array();
                //遍历所有复选框
                var getSelectedValueElements = checkboxes.each(function (i) {
                    if (i > -1) {
                        values.push($(this).val());
                    }
                });
                $.ajax({
                    url: "${pageContext.request.contextPath}/notice/deleteNotice",
                    type: "post",
                    traditional: true,
                    data: {"ids": values},
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
                    $("#delete").attr("disabled", false);
                } else {
                    $("#delete").attr("disabled", true);
                }
            });

            //给name=box的复选框绑定单击事件
            $("input[name=box]").click(function () {
                //获取选中复选框长度
                var length = $("input[name=box]:checked").length;
                if (length > 0) {
                    $("#delete").attr("disabled", false);
                } else {
                    $("#delete").attr("disabled", true);
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
    </script>


</head>
<body>
<div class="panel panel-default">
    <div class="panel-body">
        <b>公告管理</b>
    </div>
</div>
<div class="notice-options">
    <div class="btn-group">
        <button type="button" class="btn btn-default" onclick="clearNew()" data-toggle="modal"
                data-target="#newNoticeModal">新建
        </button>
    </div>
    <div class="btn-group">
        <button type="button" id="delete" class="btn btn-default" onclick="deleteManyNotice()" disabled="disabled">删除
        </button>
    </div>
</div>
<div class="notice-content">
    <table class="table table-hover">
        <caption><h4> &nbsp;&nbsp;公告列表</h4></caption>
        <thead>
        <tr>
            <th width="10%">
                <input id="all" type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;编号
            </th>
            <th width="20%" style="text-align: center;">标题</th>
            <th width="40%" style="text-align: center;">内容</th>
            <th width="15%" style="text-align: center;">发布时间</th>
            <th width="15%" style="text-align: center;">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="notice" items="${noticeList}" varStatus="x">
            <tr>
                <td><input value="${notice.id}" type="checkbox" name="box"/> &nbsp;&nbsp;&nbsp;&nbsp;${x.index+1}</td>
                <td style="text-align: center;">${notice.title}</td>
                <td style="text-align: center;">${notice.content}</td>
                <td style="text-align: center;">${notice.issuetime}</td>
                <td style="text-align: center;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" onclick="editUpdate(${notice.id})"
                                data-toggle="modal"
                                data-target="#updateNoticeModal">修改
                        </button>

                        <button type="button" class="btn btn-default" onclick="deleteNotice(${notice.id})">删除</button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <c:if test="${noticeList==null||noticeList.size()<0||empty noticeList}">
        <p align="center">没有公共信息</p>
    </c:if>

    <%--新建公告modal--%>
    <div class="modal fade" id="newNoticeModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">新建公告&nbsp;&nbsp;&nbsp;&nbsp;
                        <small id="new_error" style="color: red" hidden>

                        </small>
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="newNoticeForm">
                        <div class="form-group">
                            <label for="new_title" class="col-sm-2 control-label">
                                公告标题
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="new_title" name="title"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="new_content" class="col-sm-2 control-label">
                                公告内容
                            </label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="4" id="new_content" name="content">

                                </textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="newNotice()" class="btn btn-primary">发布</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <%--修改公告modal--%>
    <div class="modal fade" id="updateNoticeModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">修改公告&nbsp;&nbsp;&nbsp;&nbsp;
                        <small id="update_error" style="color: red" hidden>

                        </small>
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="updateNoticeForm">
                        <div class="form-group">
                            <label for="update_title" class="col-sm-2 control-label">
                                公告标题
                            </label>
                            <div class="col-sm-10">
                                <input type="hidden" id="update_id" name="id"/>
                                <input type="text" class="form-control" id="update_title" name="title"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="update_content" class="col-sm-2 control-label">
                                公告内容
                            </label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="4" id="update_content" name="content"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="updateNotice()" class="btn btn-primary">发布</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>


    <%--返回顶部--%>
    <div id="rightButton">
        <div id="backToTop">
            <a href="javascript:" onfocus="this.blur();" class="backToTop_a png">
                <i class="fa fa-arrow-up" aria-hidden="true"></i>返回顶部</a>
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
</div>

</body>
</html>
