<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectCustomerEdit.aspx.cs" Inherits="UI.PublicPage.SelectCustomer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/style5.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <style>
        .x {
            background-color:red;
        }

    </style>
    <script>
        $(function () {
            $("table tbody tr").live("mouseover", function () {
                $(this).addClass("x");
            }).live("mouseout", function () {
                $(this).removeClass("x");
            }).live("dblclick", function () {
                var cusid = $(this).children("th")[0].innerText;
                window.returnValue = { "CusID": cusid };
                window.close();
            });;
            myAjax("/Service/CTSerServices.asmx/GetCusInfo", null, function (data) {
                $(JSON.parse(data["d"])).each(function (k,v) {
                    var tr = $("<tr></tr>");
                    var td1 = $("<th>"+v["CusID"]+"</th>");
                    var td2 = $("<th>" + v["CusName"] + "</th>");
                    $(tr).append(td1).append(td2);
                    $("table tbody").append(tr);
                });
            });
        });
    </script>
</head>
<body>
<table class="tableEdit">
    <thead>
        <tr>
            <td colspan="2">
                客户选择<span style="color:Red;font-weight:normal">(选择双击确定)</span>
            </td>
        </tr>

        <tr>
            <th>客户编号</th>
            <th>客户名称</th>
        </tr>
    </thead>
       <tbody>

       </tbody>
    </table>
</body>
</html>
