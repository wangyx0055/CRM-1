<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LostEnter.aspx.cs" Inherits="UI.Customer.LostEnter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script>
        $(function () {
            var pdata = window.dialogArguments;
            if (pdata["CLReason"]!="null") {
                $("input[value=确定]").hide();
                $("#CLReason").text(pdata["CLReason"]);
                $("#CLReason").attr("disabled", true);
            }

            $("input[value=确定]").click(function () {
                var CLReason = $("#CLReason").text();
                if (CLReason.trim().length==0) {
                    alert("流失错误不能为空！");
                    return;
                }
                var mea = { "CLID": pdata["CLID"], "CLReason": CLReason, "CLState": 3 };
                myAjax("/Service/CusServices.asmx/UpdateMea", JSON.stringify({ "json": JSON.stringify(mea) }), function (data) {
                    if (data["d"] > 0) {
                        window.returnValue = mea;
                        window.close();
                    } else {
                        alert("未知错误，操作失败！");
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
                                <td colspan="2" >客户流失确认</td>
                            </tr>
                        </thead>
                        <tr>
                        <th>流失原因：</th>
                            <td>
                                <textarea style="width:90%" id="CLReason" placeholder="请输入流失原因..."  ></textarea>
                            </td>
                           </tr>
                           <tfoot>
            <tr>
                <td colspan="4">
                    <input type="button" value="确定" />&nbsp;&nbsp;
                    <input type="button" value="取消" />
                </td>
            </tr>
        </tfoot>
                    </table>
</body>
</html>
