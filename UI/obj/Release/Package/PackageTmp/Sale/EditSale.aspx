<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditSale.aspx.cs" Inherits="UI.Sale.EditSale" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>

    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
    <link href="../themes/default/easyui.css" rel="stylesheet" />
    <link href="../themes/icon.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.8.2.js"></script>
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
                        return value.length < param[0];
                },
                message: '输入的字符必须在{0}个字以内！'
            }
            });

            var parentdata = window.dialogArguments;
            var id = null;
            if (parentdata != null) {
                $("#tbs thead tr td").text("销售机会修改");
                id = parentdata["ChanID"];
                $("#channame").val(parentdata["ChanName"]);
                $("#chanrate option[value=" + parentdata["ChanRate"] + "]").attr("selected", true);
                $("#chanlinkman").val(parentdata["ChanLinkMan"]);
                $("#chanlinktel").val(parentdata["ChanLinkTel"]);
                $("#chantitle").val(parentdata["ChanTitle"]);
                $("#chandesc").text(parentdata["ChanDesc"]);
            }
            $("input[value=确定]").click(function () {
                var channame = $("#channame").val();
                if (IsNULL(channame)) {
                    alert("客户名称不能为空！");
                    return;
                } 
                var chanrate = $("#chanrate option:selected").val();
                var chanlinkman = $("#chanlinkman").val();
                if (IsNULL(chanlinkman)) {
                    alert("联系人不能为空！");
                    return;
                }
                var chanlinktel = $("#chanlinktel").val();
                if (IsNULL(chanlinktel)) {
                    alert("联系电话不能为空！");
                    return;
                }
                if (isNaN(chanlinktel)) {
                    alert("联系电话格式不正确！");
                    $("#chanlinktel").focus();
                    return;
                }
                var chantitle = $("#chantitle").val();
                if (IsNULL(chantitle)) {
                    alert("概要不能为空！");
                    return;
                }
                var chandesc = $("#chandesc").text();
                if (IsNULL(chandesc)) {
                    alert("描述不能为空！");
                    return;
                }
                $.ajax({
                    type:"POST",
                    url: "/Service/ChanServices.asmx/AddChances",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify({
                        "json": JSON.stringify({"ChanID":id,
                            "ChanName": channame,
                            "ChanRate": chanrate,
                            "ChanLinkMan": chanlinkman,
                            "ChanLinkTel": chanlinktel,
                            "ChanTitle": chantitle,
                            "ChanDesc":chandesc})
                    }), success: function (data) {
                        if (data["d"]>0) {
                          window. returnValue= {
                                "ChanID": data["d"],
                                "ChanName": channame,
                                "ChanRate": chanrate,
                                "ChanLinkMan": chanlinkman,
                                "ChanLinkTel": chanlinktel,
                                "ChanTitle": chanlinktel,
                                "ChanDesc": chandesc
                            };
                            window.close();
                        } else {
                            alert("操作失败！");
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
    <table class="tableEdit" id="tbs">
        <thead>
            <tr>
                <td colspan="4">销售机会添加</td>
            </tr>
        </thead>
        <tr>
            <th>客户名称：</th>
            <td>
                <input type="text"  id="channame" class="easyui-validatebox" data-options="validType:'MaxMinLength[30]'"/></td>
            <th>成功几率：</th>
            <td>
                <select id="chanrate">
                    <option value="10">100%</option>
                    <option value="9">90%</option>
                    <option value="8">80%</option>
                    <option value="7">70%</option>
                    <option value="6">60%</option>
                    <option value="5">50%</option>
                    <option value="4">40%</option>
                    <option value="3">30%</option>
                    <option value="2">20%</option>
                    <option value="1">10%</option>
                    <option value="0">0%</option>
                </select></td>
        </tr>
        <tr>
            <th>联系人：</th>
            <td><input type="text" id="chanlinkman" class="easyui-validatebox" data-options="validType:'MaxMinLength[30]'" /></td>
            <th>联系电话：</th>
            <td><input type="text"  id="chanlinktel" class="easyui-validatebox" data-options="validType:'IsTel'"/></td>
        </tr>
        <tr>
            <th>概要：</th>
            <td colspan="3"><input type="text" style="width:300px" id="chantitle" class="easyui-validatebox" data-options="validType:'MaxMinLength[30]'" /></td>
        </tr>
        <tr>
            <th>机会描述：</th>
            <td colspan="3"><textarea id="chandesc"></textarea></td>
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
