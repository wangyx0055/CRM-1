<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaleOkEdit.aspx.cs" Inherits="UI.Sale.SaleOk" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/style3.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script>
        $(function () {
            var paredata = window.dialogArguments;
            var  chanid = paredata["chid"];
            myAjax("/Service/ChanServices.asmx/GetPlanByID", JSON.stringify({ "id": chanid }), function (data) {
                $(JSON.parse(data["d"])["list"]).each(function (k, v) {
                    var tr3 = $("<tr></tr>");
                    var tr4 = $("<tr></tr>");
                    var dt1 = "";
                    var dt2 = "";
                    if (v["PlanDate"] != null) {
                        dt1 = ConvertTime(v["PlanDate"]);
                    }
                    var td1_1 = $("<td> 计划:" + dt1 + "</td>");
                    if (v["PlanResultDate"] != null) {
                        dt2 = ConvertTime(v["PlanResultDate"]);
                    }
                    var td2_1 = $("<td>" + v["PlanContent"] + "</td>");
                    var td1_2 = null;
                    var td2_2 = null;
                    if (v["PlanResult"] == null) {
                        td1_2 = $("<td name='" + v["PlanID"] + "'> 未执行</td>");
                        td2_2 = $("<td name='" + v["PlanID"] + "'></td>");
                    } else {
                        td1_2 = $("<td> 执行：" + dt2 + "</td>");
                        td2_2 = $("<td>" + v["PlanResult"] + "</td>");
                    }
                    tr3.append(td1_1).append(td1_2);
                    tr4.append(td2_1).append(td2_2);
                    $(tr4).insertAfter("#sb");
                    $(tr3).insertAfter("#sb");

                });
            });
        });
    </script>
</head>
<body>
<table class="tableEdit">
        <thead>
            <tr>
                <td colspan="2">开发计划查看（<span style="color:Green">状态：开发成功</span>）</td>
            </tr>
        </thead>
       <tbody><tr id="sb"></tr></tbody>
        <tfoot>
            <tr>
                <td colspan="2">
                    <input type="button" value="关闭" onclick="window.close()" />
                </td>
            </tr>
        </tfoot>
    </table>
</body>
</html>
