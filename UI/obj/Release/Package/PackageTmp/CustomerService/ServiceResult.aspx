<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceResult.aspx.cs" Inherits="UI.CustomerService.ServiceResult" %>

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
        var UserName2 = "";
        var CSDueID = 0;
        $(function () {

            //只看出自己的
            $("#showme").click(function () {
                var fg = $(this).attr("checked");
                CSDueID = fg ? 1 : 0;
                GetData();
            });
            //查询
            $("input[value=查询]").click(function () {
                index = 1;
                cusname = $("#CusName").val();
                createman = $("#ChanCreateMan").val();
                UserName2 = $("#UserName2").val();
                rttype = $("#sertype option:selected").val();
                GetData();
            });
            $("#CusName").keyup(function () {
                index = 1;
                cusname = $("#CusName").val();
                createman = $("#ChanCreateMan").val();
                UserName2 = $("#UserName2").val();
                rttype = $("#sertype option:selected").val();
                GetData();
            });
            $("#ChanCreateMan").keyup(function () {
                index = 1;
                cusname = $("#CusName").val();
                createman = $("#ChanCreateMan").val();
                UserName2 = $("#UserName2").val();
                rttype = $("#sertype option:selected").val();
                GetData();
            });
            $("#UserName2").keyup(function () {
                index = 1;
                cusname = $("#CusName").val();
                createman = $("#ChanCreateMan").val();
                UserName2 = $("#UserName2").val();
                rttype = $("#sertype option:selected").val();
                GetData();
            });
            //服务类型
            myAjax("/Service/CTSerServices.asmx/GetServices", null, function (data) {
                $(JSON.parse(data["d"])).each(function (k, v) {
                    $("<option value='" + v["STID"] + "'>" + v["STName"] + "</option>").appendTo("#sertype");
                });
            });
            //服务反馈
            $("input[type=image][name1]").live("click", function () {
                var tr = $(this).parent().parent();
                var tds = tr.children("th");
                var CusID=$(this).attr("cusid");
                var name1=$(this).attr("name1");
                var name2=$(this).attr("name2");
                var CSID=$(this).attr("key");
                var CSDesc=$(this).attr("desc");
                var CSDeal = $(this).attr("deal");
                var CSDealDate = $(this).attr("CSDealDate");
                var cs = {
                    "CusID": CusID,
                    "UserName": name1,
                    "UserName2": name2,
                    "CSID": CSID,
                    "CSDesc": CSDesc,
                    "CSDeal": CSDeal,
                    "CSCreateDate": tds[3].innerText,
                    "CSDealDate":ConvertTime( CSDealDate),
                    "STName": tds[2].innerText,
                    "CSTitle": tds[1].innerText
                };
                $.post("../Service/MyProcessRequst.ashx?rolecode=R_0018&method=FGCusServiceRole&CSID=" + cs["CSID"], null, function (data) {
                    if (data < 1) {
                        alert("对不起，您没有权限进行该操作，若要继续操作，请联系系统管理员！");
                    } else {
                        var rt = window.showModalDialog("ServiceResultDialog.aspx?data=" + Math.random(), cs, "dialogWidth:550px;dialogHeight:400px;help:no");
                        if (rt != null) {
                            if (rt["state"] == 4) {
                                GetData();
                            }
                        }
                    }
                });
            });

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
            GetData();
        });
        //查询方法
        function GetData() {
            var jsstr = JSON.stringify({ "CusName": cusname, "UserName": createman, "CSDueID": CSDueID, "STID": rttype, "UserName2": UserName2, "CSID": index });
            myAjax("/Service/CTSerServices.asmx/GetServicesAll3", JSON.stringify({ "json": jsstr }), function (data) {
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
                    var td5 = $("<th>" + ConvertTime(v["CSCreateDate"]) + "</th>");
                    var td6 = $("<th>" + v["UserName2"] + "</th>");
                    var td7 = $("<th>" + ConvertTime(v["CSDueDate"]) + "</th>");
                    var td8 = $("<th><input type='image' src='../images/bt_feedback.gif'  name1='" + v["UserName"] + "'  name2='" + v["UserName2"] + "' key='" + v["CSID"] + "'  cusid='" + v["CusID"] + "'  desc='" + v["CSDesc"] + "'  deal='" + v["CSDeal"] + "'   CSDealDate='" + v["CSDealDate"] + "'/></th>");
                    $(tr).append(td1)
                    .append(td2)
                    .append(td3)
                    .append(td4)
                    .append(td5)
                     .append(td6)
                      .append(td7)
                    .append(td8);
                    $("#tbs tbody").append(tr);
                });

            });
        }
        function change() {
            index = 1;
            cusname = $("#CusName").val();
            createman = $("#ChanCreateMan").val();
            UserName2 = $("#UserName2").val();
            rttype = $("#sertype option:selected").val();
            GetData();
        }
 </script>
</head>
<body>
<div id="desDiv">
    <span>服务反馈</span><br />
    对于客户提出的咨询、建议、投诉等服务进行处理完毕后，记录客户对服务的结果的满意度等
</div>
    <table class="tableEdit" >
        <tr>
            <th>客户名称：</th>
            <td><input type="text" id="CusName" /></td>
            <th>创建人：</th>
            <td><input type="text" id="ChanCreateMan" /></td>
            
            <th>指派人：</th>
            <td><input type="text" id="UserName2" /></td>
            <th>服务类型：</th>
            <td><select id="sertype" onchange="change()">
                <option value="0">所有类型</option>
                </select>
                  &nbsp; &nbsp; &nbsp;
                    只看指派给自己的<input  type="checkbox" id="showme"/>

            </td>
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
                <th>分配人</th>
                <th>分配时间</th>
                <th>处理</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div id="pageDiv">
        <div id="leftPage"></div>
        <div id="rightPage">
            <input type="image" src="../images/first.gif" method="shou" />&nbsp;&nbsp;
            <input type="image" src="../images/back.gif" method="shang" />&nbsp;&nbsp;
            <input type="image" src="../images/next.gif" method="xia" />&nbsp;&nbsp;
            <input type="image" src="../images/last.gif" method="wei" />&nbsp;&nbsp;
            转到第<input type="text" size="1" id="size" />&nbsp;&nbsp;<input method="go" type="image" src="../images/go.gif" />
        </div>
    </div>
</div>
</body>
</html>
