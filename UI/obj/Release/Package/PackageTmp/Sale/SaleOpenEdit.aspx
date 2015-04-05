<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaleOpenEdit.aspx.cs" Inherits="UI.Sale.SaleOpen" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <style>
        .hide {
            display:none;
        }
        .show {
            display:inline;
        }
    </style>
    <link href="../CSS/style3.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script>
        var pid=null;
        var chanid=null;
        $(function () {
          
            var paredata = window.dialogArguments;
            chanid = paredata["chid"];
            //执行操作
            $("a[aexec]").live("click", function () {
                var td = $(this).parent();
                var key = $(this).attr("aexec");
                var str = td.find("textarea").text();
                var jsstr = JSON.stringify({ "ChanID": chanid, "PlanResult": str, "PlanID": key });
                myAjax("/Service/ChanServices.asmx/AddPlanUpdate", JSON.stringify({ "json": jsstr }), function (data) {
                    if (data["d"] > 0) {
                        alert("保存成功！");
                        $("#tbs tbody tr td[name=" + key + "]")[0].innerText = "执行:" + getNowDate();
                        $("#tbs tbody tr td[name=" + key + "]")[1].innerText = str;
                        $("#PlanResult").text("");
                    } else {
                        alert("操作失败！");
                    }
                })
            });

            //显示执行计划操作
            $("input[type=image][exec=exec]").live("click", function () {
                var td = $(this).parent();
                var key = $(this).attr("key");
                var area = $("<textarea idid='"+key+"' ></textarea>");
                area.attr("clos", 30);
                area.attr("rows", 5);
                var aexec=$("<a href='#' aexec='"+key+"'>保存</a>")
                td.html("");
                td.append(area);
                td.append(aexec);
            });

         
            //新建
            $("a[key=3]").click(function () {
                var plancontent = $("#newcontent").text();
                var jsstr=JSON.stringify({"ChanID":chanid,"PlanContent":plancontent});
                myAjax("/Service/ChanServices.asmx/AddPlanUpdate", JSON.stringify({ "json": jsstr }), function (data) {
                    if (data["d"] > 0) {
                        alert("添加成功！");
                        $("#tr1").toggle();
                        $("#tr2").toggle();
                        $("a[key=2]").attr("pid", data["d"]);
                        var tr1 = $("<tr></tr>");
                        var tr2 = $("<tr></tr>");
                        var td1_2 = $("<td name='" + data["d"] + "'>未执行</td>");
                        var td2_2 = $("<td name='" + data["d"] + "'><input type='image' src='../images/bt_deal.gif' exec='exec' key='" + data["d"] + "' title='执行计划' /></td>");
                        var td1_1 = $("<td> 计划：" + getNowDate() + "</td>");
                        var td2_1 = $("<td >" + plancontent + "</td>");
                        tr1.append(td1_1).append(td1_2);
                        tr2.append(td2_1).append(td2_2);
                        $(tr2).insertAfter("#sb");
                        $(tr1).insertAfter("#sb");
                        $("#newcontent").text("");
                       
                    } else {
                        alert("添加失败！！！");
                    }
                });
            });
            //修改
            $("a[key=2]").click(function () {
                var PlanResult = $("#PlanResult").text();
                pid = $(this).attr("pid");
              
            });
            //开发终止
            $("a[key=1]").click(function () {
                if (!confirm("确认终止？")) {
                    return;
                }
                var error = $("#error").text();
                pid = $(this).attr("pid");
                var jsstr = JSON.stringify({ "ChanID": chanid, "ChanError": error,"ChanState":4});
                myAjax("/Service/ChanServices.asmx/SetError", JSON.stringify({ "json": jsstr }), function (data) {
                    if (data["d"] > 0) {
                        alert("操作成功！");
                        window.returnValue = { "ChanState": 4 };
                        window.close();
                    } else {
                        alert("操作失败！");
                    }
                })
            });

            $("#add").click(function () {//显示新建
                $("#tr1").toggle();
                $("#tr2").toggle();
                $("#tr3").toggle().toggle();
            });
            $("#no").click(function () {//显示失败
                $("#tr3").toggle();
                $("#tr1").toggle().toggle();
                $("#tr2").toggle().toggle();
            });
            //开发成功
            $("#ok").click(function () {
                if (!confirm("确认操作？")) {
                    return;
                }
                var jsstr = JSON.stringify({ "ChanID": chanid, "ChanState": 3 });
                myAjax("/Service/ChanServices.asmx/AddCustom", JSON.stringify({"json":jsstr}), function (data) {
                    if (data["d"] > 0) {
                        alert("操作已成功，该销售机会已成功添加为客户！");
                        window.returnValue = { "ChanState": 3 };
                        window.close();
                    }
                });
            });

            myAjax("/Service/ChanServices.asmx/GetPlanByID", JSON.stringify({ "id": chanid }), function (data) {
                $(JSON.parse(data["d"])["list"]).each(function (k,v) {
                    var tr3 = $("<tr></tr>");
                    var tr4 = $("<tr></tr>");
                    var dt1 = "";
                    var dt2 = "";
                    if (v["PlanDate"] != null) {
                        dt1 = ConvertTime(v["PlanDate"]);
                    }
                    var td1_1 = $("<td> 计划:" + dt1+ "</td>");
                    if (v["PlanResultDate"] != null) {
                        dt2 = ConvertTime(v["PlanResultDate"]);
                    } 
                    var td2_1 = $("<td>" + v["PlanContent"] + "</td>");
                    var td1_2 =null;
                    var td2_2=null;
                    if (v["PlanResult"] == null) {
                        $("a[key=2]").attr("pid", v["PlanID"]);
                        td1_2 = $("<td name='" + v["PlanID"] + "'> 未执行</td>");
                        td2_2 = $("<td name='" + v["PlanID"] + "'><input type='image' src='../images/bt_deal.gif' exec='exec' key='" + v["PlanID"] + "' title='执行计划' /></td>");
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
<base target="_self" />
<body>
<table class="tableEdit" id="tbs">
    <thead>
        <tr>
            <td>开发计划查看（<span style="color:blue">状态：开发中</span>）</td>
            <td style="text-align:right"><a href="#" id="add">新建</a>&nbsp;&nbsp;<a href="#" id="ok">开发成功</a>&nbsp;&nbsp;<a href="#" id="no">开发终止</a></td>
        </tr>

        <tr id="tr3" class="hide">
            <th>失败原因： <a href="#" key="1">保存</a><br /></th>
            <td><textarea placeholder="点击开发终止，出现该行，填写失败原因，点击保存，确定开发终止" id="error"></textarea></td>
        </tr>
        <tr id="tr1" class="hide">
            <th colspan="2">添加计划： </th>
           <%-- <th>执行：<a href="#" key="2">保存</a></th>--%>
        </tr>
        <tr id="tr2" class="hide">
            <td colspan="2"><textarea rows="5" cols="50" placeholder="点击新建，出现该行，点击保存，显示文本内容。注意：右边的文本框只有点击了右边的保存才会改变" id="newcontent"></textarea>&nbsp; &nbsp;&nbsp;<a href="#" key="3">保存计划</a></td>
          
            <%--  <td><textarea placeholder="请填写执行内容" id="PlanResult"></textarea></td>--%>
        </tr>
    </thead>
    <tbody>
      <tr id="sb"></tr>
    </tbody>
        <tfoot>
            <tr>
                <th colspan="2">
                    <input type="button" value="关闭" onclick="window.close()" />
                </th>
            </tr>
        </tfoot>
    </table>
</body>
</html>
