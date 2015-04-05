<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectEmpEdit.aspx.cs" Inherits="UI.PublicPage.SelectEmp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script>
        $(function () {
            var paredata = window.dialogArguments;
            var roleid = null;
            if (paredata) {
                roleid = paredata["roleid"];
            }
            $("select").live("dblclick", function () {
                var dueid = $(this).val();
                var dueman = $("select option[value="+dueid+"]").text();
                var rtjs = { "id": dueid, "name": dueman };
                window.returnValue = rtjs;
                window.close();
            });

            myAjax("/Service/ChanServices.asmx/GetUserNameAll", JSON.stringify({"roleid":roleid}), function (data) {
                $(JSON.parse( data["d"])).each(function (k,v) {
                    var item = $("<option value='" + v["UserID"] + "'>" + v["UserName"] + "</option>");
                    item.addClass("c1");
                    $("#sel").append(item);
                });
            });
            
        });
    </script>
    <style>
        .c1 {
            background-color:#0094ff;
            color:white;
            font-size:14px;
            font-weight:bold;
            margin:5px;
            text-align:center;
        }
    </style>
</head>
<body>
    <table class="tableEdit">
        <thead>
            <tr>
                <td>
                    员工选择<span style="color:Red;font-weight:normal">(选择双击确定)</span>
                </td>
            </tr>
        </thead>
        <tr>
            <td>
                <select size="10" style="width: 200px;" id="sel">
                   
                </select>
            </td>
        </tr>
    </table>
</body>
</html>
