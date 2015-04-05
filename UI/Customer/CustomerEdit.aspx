<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerEdit.aspx.cs" Inherits="UI.Customer.CustomerEdit" %>

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
                IsNumber: {
                    validator: function (value) {
                        return !isNaN(value);
                    },
                    message: '请输入数字！'
                }
            });

            var parentdata = window.dialogArguments;
            //查询绑定数据
            myAjax("/Service/CusServices.asmx/GetCusByID", JSON.stringify({ "id": parentdata["CusID"] }), function (data) {
                var cus = JSON.parse(data["d"]);
                $("#cusid").text(parentdata["CusID"]);//客户id
                $("#username").text(cus["UserName"]);//客户经理
                $("#CusName").val(cus["CusName"]);//客户名字
                $("#CusZip").val(cus["CusZip"]);//客户邮编
                $("#CusAddress").val(cus["CusAddress"]);//地址
                $("#CusFax").val(cus["CusFax"]);//传真
                $("#CusWebsite").val(cus["CusWebsite"]);//网址
                $("#CusLicenceNo").val(cus["CusLicenceNo"]);//营业执照注册号
                $("#CusChieftain").val(cus["CusChieftain"]);//法人
                $("#CusBankroll").val(cus["CusBankroll"]);//注册资金
                $("#CusTurnover").val(cus["CusTurnover"]);//年营业额
                $("#CusBank").val(cus["CusBank"]);//开户银行
                $("#CusBankNo").val(cus["CusBankNo"]);//银行账户
                $("#CusLocalTaxNo").val(cus["CusLocalTaxNo"]);//地税登记号
                $("#CusNationalTaxNo").val(cus["CusNationalTaxNo"]);//国税登记号
                $("#CusDate").text(ConvertTime(cus["CusDate"]));//创建时间
            });
            $("input[value=确定]").click(function () {
                var zip = $("#CusZip").val();
                if (isNaN(zip)) {
                    alert("邮编格式不正确！");
                    $("#CusZip").focus();
                    return;
                }
                if (isNaN($("#CusBankroll").val())) {
                    alert("注册资金格式不正确！");
                    $("#CusBankroll").focus();
                    return;
                }
                if (isNaN($("#CusTurnover").val())) {
                    alert("年营业额格式不正确！");
                    $("#CusTurnover").focus();
                    return;
                }
                if (isNaN($("#CusBankNo").val())) {
                    alert("银行账户格式不正确！");
                    $("#CusBankNo").focus();
                    return;
                }
                var jscus = JSON.stringify({
                    "CusID": parentdata["CusID"],//客户编号
                    "CusName": $("#CusName").val(),//客户名字
                    "CusZip": $("#CusZip").val(),//客户邮编
                    "CusAddress": $("#CusAddress").val(),//地址
                    "CusFax": $("#CusFax").val(),//传真
                    "CusWebsite": $("#CusWebsite").val(),//网址
                    "CusLicenceNo": $("#CusLicenceNo").val(),//营业执照注册号
                    "CusChieftain": $("#CusChieftain").val(),//法人
                    "CusBankroll": $("#CusBankroll").val(),//注册资金
                    "CusTurnover": $("#CusTurnover").val(),//年营业额
                    "CusBank": $("#CusBank").val(),//开户银行
                    "CusBankNo": $("#CusBankNo").val(),//银行账户
                    "CusLocalTaxNo": $("#CusLocalTaxNo").val(),//地税登记号
                    "CusNationalTaxNo": $("#CusNationalTaxNo").val()//国税登记号
                });
                myAjax("/Service/CusServices.asmx/UpdateCusInfo", JSON.stringify({ "json": jscus }), function (data) {
                    if (data["d"] > 0) {
                        alert("操作成功");
                        window.returnValue = { "CusName": $("#CusName").val() };
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
                <td colspan="4">客户信息编辑</td>
            </tr>
        </thead>
        <tr>
            <th>客户编号：</th>
            <td style="width:200px;"><span id="cusid"></span></td>
            <th>客户经理：</th>
            <td ><span id="username"></span></td>
        </tr>
        <tr>
            <th>客户名称：</th>
            <td>
                <input  type="text" id="CusName" class="easyui-validatebox" data-options="validType:'MaxMinLength[20]'"/>
             </td>
            <th>邮政编码：</th>
            <td><input type="text" id="CusZip" style="width:200px;" class="easyui-validatebox" data-options="validType:'MaxMinLength[6]'" />
            </td>
        </tr>
        <tr>
            <th>地址：</th>
            <td colspan="3">
                <input type="text" style="width:70%" id="CusAddress"  class="easyui-validatebox" data-options="validType:'MaxMinLength[50]'" />
             </td>
        </tr>
        <tr>
            <th>传真：</th>
            <td>
                <input type="text" id="CusFax" class="easyui-validatebox"style="width:200px;" data-options="validType:'MaxMinLength[30]'" />
             </td>
            <th>网址：</th>
            <td><input type="text" id="CusWebsite"  style="width:200px;" class="easyui-validatebox" data-options="validType:'MaxMinLength[30]'" />
            </td>
        </tr>
         <tr>
            <th>营业执照注册号：</th>
            <td>
                <input type="text" id="CusLicenceNo" class="easyui-validatebox" style="width:200px;" data-options="validType:'MaxMinLength[30]'" />
             </td>
            <th>法人：</th>
            <td><input type="text" id="CusChieftain" class="easyui-validatebox" style="width:200px;" data-options="validType:'MaxMinLength[20]'" />
            </td>
        </tr>
        <tr>
            <th>注册资金：</th>IsNumber
            <td>
                <input type="text" id="CusBankroll" class="easyui-validatebox"  style="width:200px;"data-options="validType:'IsNumber'" />
             </td>
            <th>年营业额：</th>
            <td><input type="text" id="CusTurnover"class="easyui-validatebox" style="width:200px;" data-options="validType:'IsNumber'" />
            </td>
        </tr>
        <tr>
            <th>开户银行：</th>
            <td>
                <input type="text" id="CusBank" class="easyui-validatebox" style="width:200px;" data-options="validType:'MaxMinLength[30]'"/>
             </td>
            <th>银行账号：</th>
            <td><input type="text" id="CusBankNo" class="easyui-validatebox" style="width:200px;" data-options="validType:'MaxMinLength[18]'"/>
            </td>
        </tr>
        <tr>
            <th>地税登记号：</th>
            <td>
                <input type="text" id="CusLocalTaxNo" class="easyui-validatebox" style="width:200px;" data-options="validType:'MaxMinLength[30]'" />
             </td>
            <th>国税登记号：</th>
            <td><input type="text" id="CusNationalTaxNo" class="easyui-validatebox" style="width:200px;" data-options="validType:'MaxMinLength[30]'" />
            </td>
        </tr>
        <tr>
            <th>创建时间：</th>
            <td>
                <span id="CusDate"></span>
             </td>
            <th></th>
            <td>
            </td>
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
