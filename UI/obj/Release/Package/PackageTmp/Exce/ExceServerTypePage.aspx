<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExceServerTypePage.aspx.cs" Inherits="UI.Exce.ExceServerTypePage" %>

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
        var y = "";
        $(function () {
            $("input[value=查询]").click(function () {
                GetData();
            });

            $("#sel").change(function () {
                y = $(this).val();
            });
            GetData();
        });

      
        function GetData() {
            $("#tbs").datagrid({
                url: "../Service/MyProcessRequst.ashx",
                queryParams: {
                    method: "GetServerTypeCount",
                    y:y
                },
                loadMsg: "数据正在加载中，请稍等...",
                striped: true,//是否显示斑马线
                rownumbers: true,//是否显示行号
                columns: [[
                    { title: "服务类型", field: "STName", align: "center", width: 580 },
                     { title: "服务个数", field: "Count", align: "center", width: 550 }
                ]]
            });
        }
    </script>
    <style type="text/css">
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
                <td style="width: 80px; background-color: #C1EBFF; font-size: 15px; text-align: center">年份：</td>
                <td align="center" style="width:160px">
                    <select id="sel">
                        <option value="">=所有年份=</option>
                        <option value="2014">2014年</option>
                        <option value="2013">2013年</option>
                        <option value="2012">2012年</option>
                        <option value="2011">2011年</option>
                        <option value="2010">2010年</option>
                        <option value="2009">2009年</option>
                        <option value="2008">2008年</option>
                        <option value="2007">2007年</option>
                        <option value="2006">2006年</option>
                        <option value="2005">2005年</option>
                    </select>
                </td>
                <td ><input type="button" value="查询" /></td>
            </tr>
        </table>
        <table  id="tbs" ></table>
    </div>
</body>
</html>
