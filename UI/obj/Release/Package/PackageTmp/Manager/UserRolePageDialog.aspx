﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserRolePageDialog.aspx.cs" Inherits="UI.Manager.UserRolePageDialog" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../CSS/style3.css" rel="stylesheet" type="text/css" />
       <link href="../themes/default/easyui.css" rel="stylesheet" />
    <link href="../themes/icon.css" rel="stylesheet" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
     <script src="../JS/jquery.easyui.min.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script>
        $(function () {
            //EasyUI验证表单
            $.extend($.fn.validatebox.defaults.rules, {
                //验证电话号码或者手机号码
                IsTel: {
                    validator: function (value) {
                        reg = null;
                        if (value.length > 11) {
                            reg = /^\d{4}-\d{8}$/;
                        } else {
                            reg = /^(1|1)\d{10}$/;
                        }
                        return reg.test(value);
                    },
                    message: '请输入正确的联系电话:xxxx-xxxxxx/11位手机号码！'
                },
                //验证输入字符长度必须在多少个字符以内
                MaxMinLength: {
                    validator: function (value, param) {
                        return value.length <= param[0];
                    },
                    message: '输入的字符必须在{0}个字以内！'
                },
                //是不是数字
                IsNumber: {
                    validator: function (value) {
                        return !isNaN(value);
                    },
                    message: '请输入数字！'
                }
            });
            var pdata = window.dialogArguments;
            var id = null;
            //显示所有角色
            myAjax("/Service/RoleServices.asmx/GetRoleAll", null, function (data) {
                $(JSON.parse(data["d"])).each(function (k, v) {
                    var rd = $("<input type='radio' name='RoleID' value='" + v["Role_id"] + "' />")
                    var rdstr = $("<font>" + v["Role_name"] + "</font>")
                    $("#roled").append(rd).append(rdstr);
                });
                //如果有传值过来
                if (pdata != null) {
                    id = pdata["UserID"];
                    $("#UserName").val(pdata["UserName"]);
                    $("#UserLName").val(pdata["UserLName"]);
                    $("#UserLName").attr("disabled", true);
                    $("#UserName").attr("disabled", true);
                    $("#UserLPWD").val(pdata["UserLPWD"]);
                    $("input[name=RoleID][value=" + pdata["RoleID"] + "]").attr("checked", true);
                   pdata["UserFlag"] == '1'?$("#UserFlag").attr("checked",true):"";
                }
            });
            $("input[value=确定]").click(function () {
                var flag = 0;
                flag = $("#UserFlag").attr("checked") == true ? 1 : flag;
                var jsstr = {
                    "UserID": id,
                    "UserLPWD": $("#UserLPWD").val(),
                    "UserName": $("#UserName").val(),
                    "UserLName": $("#UserLName").val(),
                    "RoleID": $("input[type=radio]:checked").val(),
                    "UserFlag":flag
                };
                if (IsNULL(jsstr["UserName"])) {
                    alert("名字不能为空！");
                    return;
                }
                if (IsNULL(jsstr["UserLPWD"])) {
                    alert("登录密码不能为空！");
                    return;
                }
                if (IsNULL(jsstr["UserLName"])) {
                    alert("登录名不能为空！");
                    return;
                }
                if (IsNULL(jsstr["RoleID"])) {
                    alert("请选择角色！");
                    return;
                }
              
                myAjax("/Service/RoleServices.asmx/UpdateUser", JSON.stringify({ "json": JSON.stringify(jsstr) }), function (data) {
                    if (data["d"] > 0) {
                        window.returnValue = jsstr;
                        window.close();
                    } else {
                        alert("操作失败！");
                    }
                });
            });
           
        });
    </script>
</head>

<body>
    
    <table class="tableEdit" style="width:500px;">
        <thead>
            <tr>
                <td colspan="2">用户信息</td>
            </tr>
        </thead>
        <tr>
            <th>用户名：</th>
            <td ><input type="text" id="UserName" class="easyui-validatebox" data-options="validType:'MaxMinLength[10]'"   />

            </td>
        </tr>
        <tr>
            <th>登录名：</th>
            <td><input type="text" id="UserLName" class="easyui-validatebox" data-options="validType:'MaxMinLength[10]'"  /></td>
        </tr>
        <tr>
            <th>登录密码：</th>
            <td><input id="UserLPWD" type="password"  size="40" class="easyui-validatebox" data-options="validType:'MaxMinLength[16]'" /></td>
        </tr>
        <tr>
            <th>指配角色：</th>
            <td><div id="roled"></div></td>
        </tr>
        <tr>
            <th>是否可用：</th>
            <td><input type="checkbox" id="UserFlag"  value="1"/>可用</td>
        </tr>
        <tfoot>
            <tr>
                <td colspan="4">
                    <input type="button" value="确定" />&nbsp;&nbsp;
                    <input type="button" value="关闭" onclick="window.close()" />
                </td>
            </tr>
        </tfoot>
    </table>
</body>
</html>
