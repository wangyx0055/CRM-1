<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceAllot.aspx.cs" Inherits="UI.CustomerService.ServiceAllot" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/Style1.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script type="text/javascript">
        var index = 1;
        var maxpage;
        var cusname = "";
        var createman = "";
        var rttype = 0;
        var CSState = 0;
        $(function () {
            //查询
            $("input[value=查询]").click(function () {
                index = 1;
                cusname = $("#CusName").val();
                createman = $("#ChanCreateMan").val();
                CSState = $("#CSState option:selected").val();
                rttype = $("#sertype option:selected").val();
                GetData();
            });
            $("#ChanCreateMan").keyup(function () {
                index = 1;
                cusname = $("#CusName").val();
                createman = $("#ChanCreateMan").val();
                CSState = $("#CSState option:selected").val();
                rttype = $("#sertype option:selected").val();
                GetData();
            });
            $("#CusName").keyup(function () {
                index = 1;
                cusname = $("#CusName").val();
                createman = $("#ChanCreateMan").val();
                CSState = $("#CSState option:selected").val();
                rttype = $("#sertype option:selected").val();
                GetData();
            });
            //服务类型
            myAjax("/Service/CTSerServices.asmx/GetServices", null, function (data) {
                $(JSON.parse(data["d"])).each(function (k, v) {
                    $("<option value='" + v["STID"] + "'>" + v["STName"] + "</option>").appendTo("#sertype");
                });
            });
            //指派服务
            $("input[type=text][readonly=readonly]").live("dblclick", function () {
                var ip = $(this);
                var csid = $(this).attr("key");
                $.post("../Service/MyProcessRequst.ashx?&method=FGRoleAllot", null, function (data) {
                    if (data < 1) {
                        alert("对不起，您当前没有拥有这个权限，如要继续进行，请联系系统管理员获取相应的权限！");
                    } else {
                        var rt = window.showModalDialog("../publicPage/SelectEmpEdit.aspx?data=" + Math.random(), { "roleid": 4 }, "dialogWidth:200px;dialogHeight:220px;help:no");
                        if (rt != null) {
                            var rtjs = JSON.stringify({ "CSID": csid, "CSDueID": rt["id"] });
                            myAjax("/Service/CTSerServices.asmx/UpdataCSDueName", JSON.stringify({ "json": rtjs }), function (data) {
                                if (data["d"] > 0) {
                                    ip.val(rt["name"]);
                                } else {
                                    alert("未知错误，操作失败！");
                                }
                            });
                        }
                    }
                });
            });
            GetData();
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
                GetData();
            });
        });
        ////查询方法
        function GetData() {
            var jsstr = JSON.stringify({ "CusName": cusname, "UserName": createman, "STID": rttype, "CSState": CSState, "CSID": index });
          //alert(jsstr);
          myAjax("/Service/CTSerServices.asmx/GetServicesAll", JSON.stringify({ "json": jsstr }), function (data) {
              
                var rel = JSON.parse(data["d"]);
                maxpage = JSON.parse(data["d"])["page"];
                var count = JSON.parse(data["d"])["count"];
                $("#leftPage").text("共有" + count + "条记录，当前第" + index + "/" + maxpage + "页");
                $("#tbs tbody tr").remove();
                $(rel["list"]).each(function (k, v) {
                    var tr = $("<tr></tr>");
                    var td1 = $("<th>" + v["CusName"] + "</th>");
                    var td2 = $("<th>" + v["CSTitle"] + "</th>");
                    var td3 = $("<th>" + v["STName"] + "</th>");
                    var td4 = $("<th>" + v["UserName"] + "</th>");
                    var td5=null;
                    if (v["CSCreateDate"]!=null) {
                        td5= $("<th>" + ConvertTime(v["CSCreateDate"]) + "</th>");
                    }
                    var namestr="";
                    if (v["UserName2"]!=null) {
                        namestr=v["UserName2"];
                    }
                    var td6 = $("<th><input type='text' value='"+namestr+"' readonly='readonly' key='"+v["CSID"]+"'/></th>");
                    tr.append(td1)
                    .append(td2)
                    .append(td3)
                    .append(td4)
                    .append(td5)
                     .append(td6);
                     $("#tbs tbody").append(tr);
                });
            });
        }
        $(function () {
            GetData();
        });
        function change() {
            index = 1;
            cusname = $("#CusName").val();
            createman = $("#ChanCreateMan").val();
            CSState = $("#CSState option:selected").val();
            rttype = $("#sertype option:selected").val();
            GetData();
        }
    </script>
</head>
<body>

<div id="desDiv">
    <span>服务分配</span><br />
    对于客户提出的咨询、建议、投诉等服务分配专人进行处理
</div>
    <table class="tableEdit" >
        <tr>
            <th>客户名称：</th>
            <td><input type="text" id="CusName" /></td>
            <th>创建人：</th>
            <td><input type="text" id="ChanCreateMan" /></td>
            
            <th>分配状态：</th>
            <td><select id="CSState" onchange="change()">
                <option value="0">全部状态</option>
                  <option value="2">已分配</option>
                 <option value="1">未分配</option>
                </select></td>
            <th>服务类型：</th>
            <td><select id="sertype" onchange="change()">
                <option value="0">所有类型</option>
                </select></td>
        </tr>
    <tfoot>
        <tr>
            <td colspan="10"><input type="button" value="查询" /></td>
        </tr>
    </tfoot>
</table>
<div id="dataDiv">
    <div id="headDiv">
    </div>
    <table class="dataTable" id="tbs">
        <thead>
            <tr>
                <th>客户名称</th>
                <th>概要</th>
                <th>服务类型</th>
                <th>创建人</th>
                <th>创建时间</th>
                <th>服务分配</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div id="pageDiv">
        <div id="leftPage">共有120条记录，当前第1/10页</div>
        <div id="rightPage">
            <input type="image" src="../images/first.gif" method="shou"/>&nbsp;&nbsp;
            <input type="image" src="../images/back.gif" method="shang" />&nbsp;&nbsp;
            <input type="image" src="../images/next.gif" method="xia" />&nbsp;&nbsp;
            <input type="image" src="../images/last.gif" method="wei" />&nbsp;&nbsp;
            转到第<input type="text" size="1" id="size" />&nbsp;&nbsp;<input method="go" type="image" src="../images/go.gif" />
        </div>
    </div>
</div>
</body>
</html>
