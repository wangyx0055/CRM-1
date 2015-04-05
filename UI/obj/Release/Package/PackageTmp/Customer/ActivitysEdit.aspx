<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActivitysEdit.aspx.cs" Inherits="UI.Customer.ActivitysEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>编辑交往记录</title>
    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
       <link href="../themes/default/easyui.css" rel="stylesheet" />
    <link href="../themes/icon.css" rel="stylesheet" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script type="text/javascript" src="../DatePicker/WdatePicker.js"></script>
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
            var CusID = null;
            var ActID = null;
            if (pdata) {
                CusID = pdata["CusID"];
                if (pdata["ActID"]) {
                    ActID = pdata["ActID"];
                    $("#ActDate").val(ConvertToDT(pdata["ActDate"]));
                    $("#ActAdd").val(pdata["ActAdd"]);
                    $("#ActTitle").val(pdata["ActTitle"]);
                    $("#ActMemo").val(pdata["ActMemo"]);
                    $("#ActDesc").val(pdata["ActDesc"]);
                }
            }
            $("input[value=确定]").click(function () {
                var act = {
                    "ActID": ActID,
                    "CusID": CusID,
                    "ActDate": $("#ActDate").val(),
                    "ActAdd": $("#ActAdd").val(),
                    "ActTitle": $("#ActTitle").val(),
                    "ActMemo": $("#ActMemo").val(),
                    "ActDesc": $("#ActDesc").val()
                };

                if (IsNULL(act["ActDate"])) {
                    alert("时间不能为空！");
                    return;
                }
                if (IsNULL(act["ActAdd"])) {
                    alert("地点不能为空！");
                    return;
                }
                if (IsNULL(act["ActTitle"])) {
                    alert("概要不能为空！");
                    return;
                }
                if (IsNULL(act["ActMemo"])) {
                    alert("备注不能为空！");
                    return;
                }
                if (IsNULL(act["ActDesc"])) {
                    alert("详细描述不能为空！");
                    return;
                }

                myAjax("/Service/CusServices.asmx/UpAddAct", JSON.stringify({ "json": JSON.stringify(act) }), function (data) {
                    if (data["d"] > 0) {
                        act["ActID"] = data["d"];
                        window.returnValue = act;
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
<table class="tableEdit" width="300px;">
        <thead>
            <tr>
                <td colspan="4">编辑客户来往记录</td>
            </tr>
        </thead>
        <tr>
            <th>交往时间：</th>
            <td>
                <input type="text" onclick="WdatePicker()" id="ActDate" /></td>
            <th>交往地点：</th>
            <td>
                <input type="text" id="ActAdd" class="easyui-validatebox" data-options="validType:'MaxMinLength[40]'" />
            </td>
        </tr>
        <tr>
            <th>概要：</th>
            <td><input type="text" id="ActTitle" class="easyui-validatebox" data-options="validType:'MaxMinLength[20]'" /></td>
            <th>备注：</th>
            <td><input type="text" id="ActMemo" class="easyui-validatebox" data-options="validType:'MaxMinLength[30]'" /></td>
        </tr>
        <tr>
            <th>详细描述：</th>
            <td colspan="3"><textarea id="ActDesc"></textarea></td>
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
