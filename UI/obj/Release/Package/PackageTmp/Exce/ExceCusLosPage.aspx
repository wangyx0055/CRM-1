﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExceCusLosPage.aspx.cs" Inherits="UI.Exce.ExceCusLosPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>

    <link href="../themes/icon.css" rel="stylesheet" />
    <link href="../themes/default/easyui.css" rel="stylesheet" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/jquery.easyui.min.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script type="text/javascript">
        var cusname = "";
        var username = "";
        $(function () {
            //输入查询
            $("input[value=查询]").click(function () {
                cusname = $("#CusName").val();
                username = $("#UserName").val();
                GetData();
            });
            $("#CusName").keyup(function () {
                cusname = $("#CusName").val();
                username = $("#UserName").val();
                GetData();
            });
            $("#UserName").keyup(function () {
                cusname = $("#CusName").val();
                username = $("#UserName").val();
                GetData();
            });
            GetData();
        });


        function GetData() {
            $("#tbs").datagrid({
                url: "../Service/MyProcessRequst.ashx",
                queryParams: {
                    method: "GetCusLosAll",
                    cusname:cusname,
                    username:username
                },
                loadMsg: "数据正在加载中，请稍等...",
                striped: true,//是否显示斑马线
                rownumbers: true,//是否显示行号
                pagination: true,//是否使用分页
                pageSize:10,
                pageList: [ 4, 5, 6, 7, 8,9,10,11,12,13,14,15],
                columns: [[
                    { title: "编号", field: "CLID", align: "center",width:200 },
                     {
                         title: "时间", field: "CLEnterDate", align: "center", width: 200, formatter: function (value, row, index) {
                             return ConvertTime(value);
                         }
                     },
                      { title: "客户名称", field: "CusName", align: "center", width: 230 },
                       { title: "客户经理", field: "UserName", align: "center", width: 200 },
                        { title: "流失原因", field: "CLReason", align: "center", width:300 },
                ]]
            });
        }
    </script>
    <style>
        .tableEdit {
            border: solid 1px #B5D6E6;
            border-collapse: collapse;
            width: 99%;
            margin: 5px;
        }

        .headDiv {
            border: solid 1px #B5D6E6;
            background-color: #C1EBFF;
            padding: 5px;
            font-size: 12px;
        }

        .sp {
            font-weight: bold;
            font-size: 14px;
        }
    </style>
</head>


<body>
    <div>
        <div class="headDiv">
            <span class="sp">客户服务分析</span><br />
            查询客户服务类型
        </div>
        <table class="tableEdit">
            <tr>
                <td  style="background-color: #C1EBFF; text-align: center;">客户名称：</td>
                <td align="center" ><input id="CusName" type="text" /></td>
                <td style="background-color: #C1EBFF; text-align: center">客户经理：</td>
                <td align="center"><input id="UserName" type="text" /></td>
                <td><input type="button" value="查询" /></td>
            </tr>
        </table>
        <table class="dataTable" id="tbs"></table>
    </div>
</body>
</html>
