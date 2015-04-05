<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceCreate.aspx.cs" Inherits="UI.CustomerService.ServiceCreate" %>

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
    <script type="text/javascript">
        function showCustomer() {
            var rt = window.showModalDialog("../publicPage/SelectCustomerEdit.aspx?data=" + Math.random(), "参数", "dialogWidth:400px;dialogHeight:220px;help:no");
            if (rt!=null) {
                $("#CusID").val(rt["CusID"]);
            }
           
        }
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
            myAjax("/Service/CTSerServices.asmx/GetServices", null, function (data) {
                $(JSON.parse(data["d"])).each(function (k,v) {
                    $("<option value='" + v["STID"] + "'>" + v["STName"] + "</option>").appendTo("select");
                });
            });


            $("input[value=确定]").click(function () {
                var CusID = $("#CusID").val();
                var STID = $("#STID option:selected").val();
                var CSTitle = $("#CSTitle").val();
                var CSDesc = $("#CSDesc").text();
                if (CusID.length == 0) {
                    alert("请选择客户！");
                    $("#CusID").focus();
                    return;
                }
                if (CSTitle.length == 0) {
                    alert("请输入服务概要！");
                    $("#CSTitle").focus();
                    return;
                }
                if (CSDesc == "请输入服务详情") {
                    alert("请输入服务详情！");
                    $("#CSDesc").focus();
                    return;
                }
                var cs=JSON.stringify({"CusID":CusID,"STID":STID,"CSTitle":CSTitle,"CSDesc":CSDesc});
                myAjax("/Service/CTSerServices.asmx/AddService", JSON.stringify({ "json": cs }), function (data) {
                    if (data["d"]) {
                        alert("添加成功！");
                      
                    } else {
                        alert("添加失败！");
                    }
                });
            });
        });
    </script>
</head>
<body>
     <form id="f1">
<table class="tableEdit" style="width:600px;">
   
        <thead>
            <tr>
                <td colspan="4">创建服务</td>
            </tr>
        </thead>
   
        <tr>
            <th>客户编号：</th>
            <td>
                <input type="text" ondblclick="showCustomer()"  id="CusID" placeholder="双击打开选择客户" readonly="readonly"/></td>
            <th>服务类型：</th>
            <td>
                <select style="width:100px" id="STID"  ></select>
            </td>
        </tr>
        <tr>
            <th>服务概要：</th>
            <td colspan="3">
                <input type="text" id="CSTitle" placeholder="请输入服务概要" class="easyui-validatebox" data-options="validType:'MaxMinLength[25]'" />
             </td>
        </tr>
        <tr>
            <th>详细信息：</th>
            <td colspan="3">
                <textarea id="CSDesc" placeholder="请输入服务详情"></textarea>
             </td>
        </tr>
        
    
            <tr>
                <td colspan="4">
                    <input type="button" value="确定" />&nbsp;&nbsp;
                        <input type="reset" value="清空" />&nbsp;&nbsp;
                </td>
            </tr>
        
    </table>
   </form>
</body>
</html>
