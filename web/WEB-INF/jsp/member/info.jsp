<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/24 0024
  Time: 12:43
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/info.css">


    <script type="text/javascript">
        function uploadAvatar() {
            var fromData = new FormData($("#avatarForm")[0]);
            $.ajax({
                url: "${pageContext.request.contextPath}/member/uploadAvatar",
                type: 'POST',
                data: fromData,
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

        $(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

        function showEditBtn(editBtnId) {
            $("#" + editBtnId).removeClass('hidden');
        }

        function hideEditBtn(editBtnId) {
            $("#" + editBtnId).addClass('hidden');
        }

        function edit(valueId, inputId, operateId) {
            $("#" + valueId).hide();
            $("#" + inputId).show();
            $("#" + operateId).show();
        }

        function cancel(inputId, operateId, valueId) {
            $("#" + inputId).hide();
            $("#" + operateId).hide();
            $("#" + valueId).show();
        }

        function updateInfo() {
            var formData = new FormData($("#infoForm")[0]);
            $.ajax({
                url: "${pageContext.request.contextPath}/member/updateInfo",
                type: "post",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data == "success") {
                        window.location.reload();
                    } else {
                        alert("更新失败");
                    }
                }
            });
        }

        function showPasswordEdits() {
            $("#passwordEdit").show();
        }

        function hidePasswordEdits() {
            $("#passwordEdit").hide();

        }

        function checkPriPsw() {
            var password = $("#priPsw").val();
            var b = false;
            $.ajax({
                url: "${pageContext.request.contextPath}/member/checkPassword",
                type: "post",
                async: false,
                data: {"password": password, "id":${sessionScope.CurrentMember.id}},
                success: function (data) {
                    if (data == "success") {
                        $("#priPswError").hide();
                        b = true;
                    } else {
                        $("#priPswError").show();
                        b = false;
                    }
                }
            });
            return b;
        }

        function checkNewPsw() {
            var newPsw = $("#newPsw").val();
            if (newPsw.length > 5 && newPsw.length < 20) {
                $("#newPswError").html("<i class=\"fa fa-check-circle-o\" aria-hidden=\"true\"></i>");
                return true;
            } else {
                $("#newPswError").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                    "</i> 密码设置不符合规范");
                return false;
            }
        }

        function checkConfirmPsw() {
            var newPsw = $("#newPsw").val();
            var confirmPsw = $("#confirmPsw").val();
            if (newPsw == confirmPsw) {
                $("#confirmPswError").html("<i class=\"fa fa-check-circle-o\" aria-hidden=\"true\"></i>");
                return true;
            } else {
                $("#confirmPswError").html("<i class=\"fa fa-times-circle\" aria-hidden=\"true\">" +
                    "</i> 两次密码输入不匹配");
                return false;
            }
        }

        function changePsw() {
            if (checkPriPsw() && checkNewPsw() && checkConfirmPsw()) {
                updateInfo();
            }
        }
    </script>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-body">
        <b>用户信息</b>
    </div>
</div>
<div class="info-content">
    <h4 style="margin-left: 20px;">用户信息</h4>
    <div class="avatar">
        <a href="#uploadAvatar" data-toggle="modal">
            <img class="img-thumbnail" style="width: 140px; height: 140px"
                 src=
                 <c:choose>
                 <c:when test="${sessionScope.CurrentMember.avatar!=null}">
                         "${sessionScope.CurrentMember.avatar}"
            </c:when>
            <c:otherwise>
                "${pageContext.request.contextPath}/img/img_avatar.png"
            </c:otherwise>
            </c:choose>/>
        </a>
    </div>
    <div class="member-info">
        <div class="member-info-title">
            <div class="member-info-title-item">
                <p>会员名:</p>
            </div>
            <div class="member-info-title-item">
                <p>会员ID:</p>
            </div>
            <div class="member-info-title-item">
                <p>手机号码:</p>
            </div>
            <div class="member-info-title-item">
                <p>年龄:</p>
            </div>
            <div class="member-info-title-item">
                <p>性别:</p>
            </div>
            <div class="member-info-title-item">
                <p>邮箱:</p>
            </div>
            <div class="member-info-title-item">
                <p>密码:</p>
            </div>
        </div>
        <div class="member-info-values">
            <div class="member-info-values-item">
                <p>${sessionScope.CurrentMember.name}</p>
            </div>
            <div class="member-info-values-item">
                <p>${sessionScope.CurrentMember.id} &nbsp;
                    <i class="fa fa-exclamation-circle" data-toggle="tooltip" title="会员唯一标识符" aria-hidden="true"></i>
                </p>
            </div>
            <div class="member-info-values-item">
                <p>${sessionScope.CurrentMember.tel}
                </p>
            </div>
            <div class="member-info-values-item">
                <p id="ageInput" hidden="hidden">
                    <input form="infoForm" type="number" name="age" min="0" max="200"
                           title="年龄" value="${sessionScope.CurrentMember.age}" class="form-control"
                           style="width: 170px;">
                </p>
                <p id="ageValue" onmouseover="showEditBtn('ageEditBtn')"
                   onmouseleave="hideEditBtn('ageEditBtn')">
                    ${sessionScope.CurrentMember.age} &nbsp;
                    <a hidden="hidden" href="javascript:edit('ageValue','ageInput','ageOperate')"
                       id="ageEditBtn" class="hidden fa fa-pencil">
                    </a>
                </p>
            </div>
            <div class="member-info-values-item">
                <p id="genderInput" hidden="hidden">
                    <label class="radio-inline">
                        <input form="infoForm" type="radio" name="gender" value="男"
                               <c:if test="${sessionScope.CurrentMember.gender==null
                               ||sessionScope.CurrentMember.gender=='男'}">checked
                        </c:if>> 男
                    </label>
                    <label class="radio-inline">
                        <input form="infoForm" type="radio" name="gender" value="女"
                               <c:if test="${sessionScope.CurrentMember.gender=='女'}">checked
                        </c:if>> 女
                    </label>
                </p>
                <p id="genderValue" onmouseover="showEditBtn('genderEditBtn')"
                   onmouseleave="hideEditBtn('genderEditBtn')">
                    ${sessionScope.CurrentMember.gender} &nbsp;
                    <a hidden="hidden" href="javascript:edit('genderValue','genderInput','genderOperate')"
                       id="genderEditBtn" class="hidden fa fa-pencil">
                    </a>
                </p>
            </div>
            <div class="member-info-values-item">
                <p id="emailInput" hidden="hidden">
                    <input form="infoForm" title="邮箱" name="email" type="email"
                           class="form-control" value="${sessionScope.CurrentMember.email}" style="width: 170px;"/>
                </p>
                <p id="emailValue" onmouseover="showEditBtn('emailEditBtn')" onmouseleave="hideEditBtn('emailEditBtn')">
                    ${sessionScope.CurrentMember.email} &nbsp;
                    <a hidden="hidden" href="javascript:edit('emailValue','emailInput','emailOperate')"
                       id="emailEditBtn" class="hidden fa fa-pencil">
                    </a>
                </p>
            </div>
            <div class="member-info-values-item">
                <p onmouseover="showEditBtn('passwordEditBtn')" onmouseleave="hideEditBtn('passwordEditBtn')">
                    ************ &nbsp;
                    <a hidden="hidden" href="javascript:showPasswordEdits()"
                       id="passwordEditBtn" class="hidden fa fa-pencil">
                    </a>
                </p>
            </div>
        </div>
        <div class="member-info-operate">
            <div class="member-info-operate-item">

            </div>
            <div class="member-info-operate-item">

            </div>
            <div class="member-info-operate-item">

            </div>
            <div class="member-info-operate-item">
                <div id="ageOperate" hidden="hidden" class="btn-group-sm">
                    <button class="btn btn-primary" onclick="updateInfo()">保存</button>
                    <button class="btn btn-default" onclick="cancel('ageInput','ageOperate','ageValue')">取消
                    </button>
                </div>

            </div>
            <div class="member-info-operate-item">
                <div id="genderOperate" hidden="hidden" class="btn-group-sm">
                    <button class="btn btn-primary" onclick="updateInfo()">保存</button>
                    <button class="btn btn-default" onclick="cancel('genderInput','genderOperate','genderValue')">取消
                    </button>
                </div>
            </div>
            <div class="member-info-operate-item">
                <div id="emailOperate" hidden="hidden" class="btn-group-sm">
                    <button class="btn btn-primary" onclick="updateInfo()">保存</button>
                    <button class="btn btn-default" onclick="cancel('emailInput','emailOperate','emailValue')">取消
                    </button>
                </div>
            </div>

        </div>
    </div>

</div>
<div class="password-content" hidden="hidden" id="passwordEdit">
    <h4 style="margin-left: 20px;">修改密码</h4>
    <form class="form-horizontal" id="infoForm" style="margin-top: 20px; margin-left: 10px;">
        <div class="Error" id="priPswError" hidden="hidden">
            <i class="fa fa-times-circle">密码不正确</i>
        </div>
        <div class="form-group">
            <label for="priPsw" class="col-sm-2 control-label">
                原密码
            </label>
            <div class="col-sm-6">
                <input type="password" id="priPsw" class="form-control" onblur="checkPriPsw()"/>
            </div>
        </div>
        <div class="Error" id="newPswError">
        </div>
        <div class="form-group">
            <label for="newPsw" class="col-sm-2 control-label">
                新密码
            </label>
            <div class="col-sm-6">
                <input type="password" id="newPsw" class="form-control" onblur="checkNewPsw()" name="password"/>
            </div>
        </div>
        <div class="Error" id="confirmPswError">
        </div>
        <div class="form-group">
            <label for="confirmPsw" class="col-sm-2 control-label">
                确认密码
            </label>
            <div class="col-sm-6">
                <input type="password" class="form-control" onblur="checkConfirmPsw()" id="confirmPsw"/>
            </div>
        </div>
        <div class="col-sm-2 control-label"></div>

        &nbsp;
        <div class="btn-group">
            <button class="btn btn-primary" type="button" onclick="changePsw()">确认修改</button>
        </div>&nbsp;
        <div class="btn-group">
            <button class="btn btn-default" type="button" onclick="hidePasswordEdits()">取消</button>
        </div>
        <input type="hidden" value="${sessionScope.CurrentMember.id}" name="id">
    </form>
</div>
<%--添加头像模态框--%>
<div class="modal fade" id="uploadAvatar" tabindex="-1" role="dialog" aria-labelledby="uploadAvatarTitle"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="uploadAvatarTitle">头像上传</h4>
            </div>
            <div class="modal-body">
                <form id="avatarForm">
                    <input class="form-control" type="file" name="avatar">
                    <input type="hidden" name="memberId" value="${sessionScope.CurrentMember.id}">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="uploadAvatar()" class="btn btn-primary">上传</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
