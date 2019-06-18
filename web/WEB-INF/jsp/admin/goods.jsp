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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/goods.css"/>
    <script>
        $(function () {
            $(".tooltip-options a").tooltip({
                html: true
            });
        });

        function newSmalltype(smallValue) {
            var bigType = $("#newBigType").val();
            if (smallValue == "-1") {
                $("#newSmallDiv").show();
                $("#newSmallBigid").val(bigType);
            }
        }

        function clearSearch() {
            $("#searchGoodsForm")[0].reset();
        }

        function findSmallTypeByBig(bigid) {
            $.ajax({
                url: "${pageContext.request.contextPath}/goods/findAllSmallType/" + bigid,
                type: "get",
                async: false,
                success: function (data) {
                    var htm = "<option value=\"\">--请选择--</option>";
                    for (var i = 0; i < data.length; i++) {
                        var smallType = data[i];
                        htm += "<option value=\"" + smallType.id + "\">" + smallType.smallname + "</option>";
                    }
                    $("#smallType").html(htm);
                }
            });
        }

        function findSmallTypeByBigNew(bigid) {
            $.ajax({
                url: "${pageContext.request.contextPath}/goods/findAllSmallType/" + bigid,
                type: "get",
                async: false,
                success: function (data) {
                    var htm = "<option value=\"\">--请选择--</option>";
                    for (var i = 0; i < data.length; i++) {
                        var smallType = data[i];
                        htm += "<option value=\"" + smallType.id + "\">" + smallType.smallname + "</option>";
                    }
                    htm += "<option value=\"-1\">--新建小分类--</option>";
                    $("#newSmallType").html(htm);
                }
            });
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

        function clearNew() {
            $("#new_error").hide();
            $("#newGoodsForm")[0].reset();
            $("#newSmallDiv").hide();
        }

        function newGoods() {
            var error = $("#new_error");
            var formData = new FormData($("#newGoodsForm")[0]);
            var newBigType = $("#newBigType").val();
            var newSmallType = $("#newSmallType").val();
            var newSmall = $("#newSmall");
            var newGoodsName = $("#newGoodsName").val();
            var newGoodsFrom = $("#newGoodsFrom").val();
            var newGoodsPrice = $("#newGoodsPrice").val();
            if (newBigType == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请选择大类别");
            } else if (newSmallType == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请选择小类别");
            } else if (newSmall.is(":visible") == true && newSmall.val() == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请填写新建的小分类的名称");
            } else if (newGoodsName == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请填写商品名称");
            } else if (newGoodsFrom == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请填写产地");
            } else if (newGoodsPrice == "") {
                error.show();
                error.html("<i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> 请填写商品价格");
            } else {
                $.ajax({
                    url: "${pageContext.request.contextPath}/goods/newGoods",
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        window.location.reload();
                    },
                    error: function (data) {
                        alert("请求错误");
                    }
                });
            }
        }

        function searchGoodsFormSubmit() {
            $("#searchGoodsForm").submit();
        }

        function deleteGoods(id, bid) {
            if (confirm("确认下架？")) {
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
                    url: "${pageContext.request.contextPath}/goods/deleteGoods",
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
    </script>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-body">
        <b>商品管理</b>
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
        <form id="searchGoodsForm" class="form-inline"
              action="${pageContext.request.contextPath}/goods/findByConditions" method="get">
            <div class="form-group">
                <label for="goodsName">商品名称</label>
                <input type="text" class="form-control" id="goodsName" name="name" value="${goodsName}"/>
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
            <button type="button" class="btn btn-default" onclick="clearSearch()">重置</button>
        </form>
    </div>
</div>
<div class="goods-options">

    <div class="btn-group">
        <button type="button" onclick="clearNew()" class="btn btn-default" data-toggle="modal"
                data-target="#newGoodsModal">新建
        </button>
    </div>
    <div class="btn-group">
        <button type="button" id="deleteMany" onclick="deleteGoods('',this)" class="btn btn-default"
                disabled="disabled">下架
        </button>
    </div>
    <div class="btn-group">
        <select form="searchGoodsForm" id="sortOrder" onchange="searchGoodsFormSubmit()" name="sortOrder"
                class="form-control">
            <option value="">排序方式</option>
            <option value="1" <c:if test="${sortOrder==1}">selected</c:if>>上架时间</option>
            <option value="2" <c:if test="${sortOrder==2}">selected</c:if>>价格升序</option>
            <option value="-2" <c:if test="${sortOrder==-2}">selected</c:if>>价格降序</option>
            <option value="3" <c:if test="${sortOrder==3}">selected</c:if>>购买次数</option>
        </select>
    </div>
</div>

<div class="goods-content">
    <table class="table table-hover">
        <caption>
            <h4> &nbsp;&nbsp;商品列表</h4></caption>
        <thead>
        <tr>
            <th width="8%">
                <input id="all" type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;编号
            </th>
            <th width="25%" style="text-align: center;">商品描述</th>
            <th width="10%" style="text-align: center;">价格</th>
            <th width="15%" style="text-align: center;">图片</th>
            <th width="15%" style="text-align: center;">上架时间</th>
            <th width="8%" style="text-align: center;">购买次数</th>
            <th width="15%" style="text-align: center;">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="goods" varStatus="x" items="${goodsList}">

            <tr>
                <td><input name="box" type="checkbox" value="${goods.id}"/> &nbsp;&nbsp;&nbsp;&nbsp;${x.index+1}</td>
                <td style="text-align: center;">${goods.name}</td>
                <td style="text-align: center;">￥${goods.price}</td>
                <td style="text-align: center;">
                    <p class="tooltip-options">
                        <c:choose>
                            <c:when test="${goods.img==null}">
                                <a href="#" data-toggle="tooltip"
                                   title="<img style='width: 200px;' src='${pageContext.request.contextPath}/img/goods.png'></img>">
                                    <img style="width: 100px;" src="${pageContext.request.contextPath}/img/goods.png"/>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" data-toggle="tooltip"
                                   title="<img style='width: 200px;' src='${goods.img}'></img>">
                                    <img style="width: 100px;" src="${goods.img}"/>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </p>
                </td>
                <td style="text-align: center;">${goods.createtime}</td>
                <td style="text-align: center;">${goods.buytimes} 次</td>
                <td style="text-align: center;">
                    <div class="btn-group">
                        <button type="button" id="deleteOne" onclick="deleteGoods('${goods.id}',this)"
                                class="btn btn-default">下架
                        </button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <c:if test="${goodsList==null||goodsList.size()<0||empty goodsList}">
        <p align="center">没有商品</p>
    </c:if>



    <%--添加商品的模态框--%>
    <div class="modal fade" id="newGoodsModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">添加商品&nbsp;&nbsp;&nbsp;&nbsp;
                        <small id="new_error" style="color: red" hidden>

                        </small>
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="newGoodsForm">
                        <div class="form-group">
                            <label for="newBigType" class="col-sm-2 control-label">
                                大类别
                            </label>
                            <div class="col-sm-10">
                                <select class="form-control" id="newBigType" name="bigtype"
                                        onchange="findSmallTypeByBigNew(this.value)">
                                    <option value="">--请选择--</option>
                                    <c:forEach var="bigtype" items="${bigtypeList}">
                                        <option value="${bigtype.id}">
                                                ${bigtype.bigname}
                                        </option>
                                    </c:forEach>
                                </select></div>
                        </div>
                        <div class="form-group">
                            <label for="newSmallType" class="col-sm-2 control-label">
                                小类别
                            </label>
                            <div class="col-sm-10">
                                <select class="form-control" id="newSmallType" name="smalltype"
                                        onchange="newSmalltype(this.value)">
                                    <option value="">--请选择--</option>
                                </select>
                            </div>
                        </div>
                        <div id="newSmallDiv" class="form-group" hidden="hidden">
                            <label for="newSmall" class="col-sm-2 control-label">
                                新建小分类
                            </label>
                            <div class="col-sm-10">
                                <input type="hidden" class="form-control" id="newSmallBigid" name="newSmallBigid"/>
                                <input type="text" class="form-control" id="newSmall" name="newSmallType"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newGoodsName" class="col-sm-2 control-label">
                                商品名称
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="newGoodsName" name="name"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newGoodsFrom" class="col-sm-2 control-label">
                                商品产地
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="newGoodsFrom" name="goodfrom"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newGoodsPrice" class="col-sm-2 control-label">
                                商品价格
                            </label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="newGoodsPrice" name="price"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newGoodsImg" class="col-sm-2 control-label">
                                商品图片
                            </label>
                            <div class="col-sm-10">
                                <input type="file" id="newGoodsImg" name="file"/>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="newGoods()" class="btn btn-primary">提交</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
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
