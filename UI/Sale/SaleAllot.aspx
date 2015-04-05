﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaleAllot.aspx.cs" Inherits="UI.Sale.SaleAllot" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/Style1.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script type="text/javascript">
        var index = 1;
        var maxpage;
        var channame = "";
        var linkman = "";
        var createman = "";
        var dueman = "";
        var chandate=0;
        $(function () {
            //条件查询
            $("input[value=查询]").click(function () {
                index = 1;
                  channame = $("#ChanName").val();
                 linkman = $("#ChanLinkMan").val();
                 createman = $("#ChanCreateMan").val();
                 dueman = $("#ChanDueMan").val();
                 chandate = $("#ChanState option:selected").val();
                getpage();
            });
            //输入查询
            $("#ChanName").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                linkman = $("#ChanLinkMan").val();
                createman = $("#ChanCreateMan").val();
                dueman = $("#ChanDueMan").val();
                chandate = $("#ChanState option:selected").val();
                getpage();
            });
            $("#ChanLinkMan").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                linkman = $("#ChanLinkMan").val();
                createman = $("#ChanCreateMan").val();
                dueman = $("#ChanDueMan").val();
                chandate = $("#ChanState option:selected").val();
                getpage();
            });
            $("#ChanCreateMan").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                linkman = $("#ChanLinkMan").val();
                createman = $("#ChanCreateMan").val();
                dueman = $("#ChanDueMan").val();
                chandate = $("#ChanState option:selected").val();
                getpage();
            });
            $("#ChanDueMan").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                linkman = $("#ChanLinkMan").val();
                createman = $("#ChanCreateMan").val();
                dueman = $("#ChanDueMan").val();
                chandate = $("#ChanState option:selected").val();
                getpage();
            });

            //分配销售人员
            $("input[name=username]").live("dblclick", function () {
                var chid = $(this).attr("key");
                var ip = $(this);
                $.post("../Service/MyProcessRequst.ashx?&method=FGRoleAllot", null, function (data) {
                    if (data < 1) {
                        alert("对不起，您当前没有拥有这个权限，如要继续进行，请联系系统管理员获取相应的权限！");
                    } else {
                        var rt = window.showModalDialog("../publicPage/SelectEmpEdit.aspx?data=" + Math.random(), { "roleid": 2 }, "dialogWidth:200px;dialogHeight:220px;help:no");
                        if (rt != null) {
                            var rtjs = JSON.stringify({ "ChanID": chid, "ChanDueMan": rt["id"] });
                            myAjax("/Service/ChanServices.asmx/UpdataChanDueName", JSON.stringify({ "json": rtjs }), function (data) {
                                if (data["d"] > 0) {
                                    ip.val(rt["name"]);
                                }
                            });
                        }
                    }
                });
              
             
            });
            //查询
            getpage();
            //翻页
            $("input[type=image][method]").click(function () {
                var method = $(this).attr("method");
                if (method == "shou") {
                    index = 1;
                } else if (method == "shang") {
                    index = index > 1 ? index - 1 : index;
                } else if (method == "xia") {
                    index = index < maxpage ? index + 1 : index;
                } else if (method == "wei") {
                    index = maxpage;
                } else if (method == "go") {

                    var number = $("#number").val();
                    try {
                        if (parseInt(number) <= parseInt(maxpage)) {
                            index = parseInt(number);
                        }
                    } catch (e) {
                        alert("输入有误！");
                    }
                }
                getpage();
            });
        });
        //分页查询
        function getpage() {
            var rtjs = JSON.stringify({
                "ChanID": index,
                "ChanName": channame,
                "ChanLinkMan": linkman,
                "UserName": createman,
                "UserName2": dueman,
                "ChanState":chandate
            });
            myAjax("/Service/ChanServices.asmx/GetChanNameViewAll", JSON.stringify({ "rtjs": rtjs }), function (data) {
                maxpage = JSON.parse(data["d"])["page"];
                var count = JSON.parse(data["d"])["count"];
                $("#leftPage").text("共有" + count + "条记录，当前第" + index + "/" + maxpage + "页");
                $("#tbs tbody tr").remove();
                var list = JSON.parse(data["d"])["list"];
                $(list).each(function (k,v) {
                    var tr = $("<tr></tr>");
                    var td1 = $("<th>" + v["ChanName"] + "</th>")
                    var td2 = $("<th>" + v["ChanTitle"] + "</th>")
                    var td3 = $("<th>" + v["ChanLinkMan"] + "</th>")
                    var td4 = $("<th>" + v["ChanLinkTel"] + "</th>")
                    var td5 = $("<th>" + v["UserName"] + "</th>")
                    var td6 = $("<th>" + ConvertTime(v["ChanCreateDate"]) + "</th>")
                    var username = v["UserName2"];
                    username = username == null ? "" : username;
                    var td7 = $("<th><input type='text' name='username' ukey='" + v["ChanDueMan"] + "'  key='" + v["ChanID"] + "' readonly='readonly' value='" + username + "'></th>");
                    tr.append(td1)
                        .append(td2)
                        .append(td3)
                        .append(td4)
                        .append(td5)
                        .append(td6)
                        .append(td7);
                    $("#tbs tbody").append(tr);
                });

            });
        }
        function change() {
            index = 1;
            channame = $("#ChanName").val();
            linkman = $("#ChanLinkMan").val();
            createman = $("#ChanCreateMan").val();
            dueman = $("#ChanDueMan").val();
            chandate = $("#ChanState option:selected").val();
            getpage();
        }
    </script>
</head>
<body>
<div id="desDiv">
    <span>销售机会分配</span><br />
    销售主管查看销售机会，并将销售机会分配给合适的销售人员
</div>
<table class="tableEdit" >
        <tr>
            <th>客户名称：</th>
            <td><input type="text" id="ChanName" /></td>
            <th>联系人：</th>
            <td><input type="text" id="ChanLinkMan" /></td>
            <th>创建人：</th>
            <td><input type="text" id="ChanCreateMan" /></td>
            <th>分配人：</th>
            <td><input type="text" id="ChanDueMan" /></td>
            <th>分配状态：</th>
            <td><select id="ChanState" onchange="change()">
                <option value="0">全部状态</option>
                  <option value="2">已分配</option>
                 <option value="1">未分配</option>
                </select></td>
        </tr>
    <tfoot>
        <tr>
            <td colspan="10"><input type="button" value="查询" /></td>
        </tr>
    </tfoot>
</table>
<br />
<div id="dataDiv">
    <table class="dataTable" id="tbs">
        <thead>
            <tr>
                <th>客户名称</th>
                <th>概要</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th>创建人</th>
                <th>创建时间</th>
                <th>分配人</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="pageDiv">
        <div id="leftPage"></div>
        <div id="rightPage">
            <input type="image" method="shou" src="../images/first.gif" />&nbsp;&nbsp;
            <input type="image" method="shang" src="../images/back.gif" />&nbsp;&nbsp;
            <input type="image" method="xia"  src="../images/next.gif" />&nbsp;&nbsp;
            <input type="image" method="wei" src="../images/last.gif" />&nbsp;&nbsp;
            转到第<input type="text" size="1" id="size" />&nbsp;&nbsp;<input type="image" mthod="go" src="../images/go.gif" />
        </div>
    </div>
</div>
</body>
</html>
