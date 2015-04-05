<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LinkManEdit.aspx.cs" Inherits="UI.Customer.LinkManEdit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
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
            var cusid = null;
            if (pdata) {
                if (pdata["cusid"] == null) {
                    id = pdata["LMID"];
                    $("#LMName").val(pdata["LMName"]);
                    $("#LMDuty").val(pdata["LMDuty"]);
                    $("#LMMobileNo").val(pdata["LMMobileNo"]);
                    $("#LMOfficeNo").val(pdata["LMOfficeNo"]);
                    $("#LMMemo").text(pdata["LMMemo"]);
                    $(":radio[name=sex][value=" + pdata["LMSex"] + "]").attr("checked", true);
                } else {
                    cusid = pdata["cusid"];
                }
            }
            $("input[value=确定]").click(function () {
                var jsstr = {
                    "LMID": id,
                    "LMName": $("#LMName").val(),
                    "LMDuty": $("#LMDuty").val(),
                    "LMMobileNo": $("#LMMobileNo").val(),
                    "LMOfficeNo": $("#LMOfficeNo").val(),
                    "LMSex": $(":radio[name=sex]:checked").val(),
                    "LMMemo": $("#LMMemo").text(),
                    "CusID":cusid
                };
                if (IsNULL(jsstr["LMName"])) {
                    alert("姓名不能为空！");
                    return;
                }
                if (IsNULL(jsstr["LMDuty"])) {
                    alert("职位不能为空！");
                    return;
                }
                if (IsNULL(jsstr["LMOfficeNo"])) {
                    alert("固定电话不能为空！");
                    return;
                }

                if (IsNULL(jsstr["LMMobileNo"])) {
                    alert("手机号码不能为空！");
                    $("#LMMobileNo").focus();
                    return;
                }
                if (isNaN(jsstr["LMMobileNo"])) {
                    alert("手机号码格式不正确！");
                    $("#LMMobileNo").focus();
                    return;
                }

                if (IsNULL(jsstr["LMMemo"])) {
                    alert("备注不能为空！");
                    return;
                }
                myAjax("/Service/CusServices.asmx/Add_UpdateLinkMan", JSON.stringify({ "json": JSON.stringify(jsstr) }), function (data) {
                    if (data["d"] > 0) {
                        jsstr["LMID"] = data["d"];
                        window.returnValue = jsstr;
                        window.close();
                    }
                });
            });
        });
    </script>
</head>
<body>
<table class="tableEdit">
        <thead>
            <tr>
                <td colspan="4">编辑联系人</td>
            </tr>
        </thead>
        <tr>
            <th>姓名：</th>
            <td style="width:230px;">
                <input type="text" id="LMName"  class="easyui-validatebox" data-options="validType:'MaxMinLength[20]'" /></td>
            <th style="width:60px;">性别：</th>
            <td>
                <input type="radio" value="男"  name="sex"  checked="checked"/>男&nbsp;&nbsp;<input type="radio" value="女"  name="sex"/>女
            </td>
        </tr>
        <tr>
            <th>职位：</th>
            <td style="width:230px;"><input type="text" id="LMDuty"  class="easyui-validatebox" data-options="validType:'MaxMinLength[20]'" /></td>
            <th style="width:60px;">固定电话：</th>
            <td><input type="text" id="LMOfficeNo" style="width:130px;"  class="easyui-validatebox" data-options="validType:'IsTel'" /></td>
        </tr>
         <tr>
            <th>手机号码：</th>
            <td style="width:230px;"><input type="text" id="LMMobileNo"   class="easyui-validatebox" data-options="validType:'IsTel'"  /></td>
            <th style="width:60px;"></th>
            <td></td>
        </tr>
        <tr>
            <th>备注：</th>
            <td colspan="3" style="width:230px;"><textarea id="LMMemo"></textarea></td>
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
