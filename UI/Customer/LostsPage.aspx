<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LostsPage.aspx.cs" Inherits="UI.Customer.LostsPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
     <link href="../CSS/Style4.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
    <style>
           table tbody tr:hover {
         color:blue;
        }
    </style>
    <script src="../DatePicker/WdatePicker.js"></script>
    <script src="../JS/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script type="text/javascript">
        //下来列表
        function aa() {
            cusid = $("#CusID").val();
            cusname = $("#CusName").val();
            cldate = $("#CLDate").val();
            clenddate = $("#CLEnterDate").val();
            clstate = $("#CLState option:selected").val();
            GetData();
        }
        var index = 1;
        var maxpage;
        var showtr = null;
        var rtstr = null;
        var cusid = "";//客户ID
        var cusname = "";//客户名称
        var cldate = "";//报警时间
        var clenddate = "";//流失时间
        var clstate = 0;//流失状态
        $(function () {
            //显示流失措施
            $("#dataLeft .dataTable tr:gt(0)").live("click", function () {
                $("#dataLeft .dataTable tr:gt(0)").css("background-color", "white");
                $(this).css("background-color", "red");
                $(".contentDiv div:first").slideDown(400);
                showtr = $(this);
                var clid = $(this).find("input")[0].value;
                if (showtr.children("th")[5].innerText=="已流失") {
                    $("input[value=添加]").hide();
                    $("#MeDesc").hide();
                } else {
                    $("#MeDesc").show();
                    $("input[value=添加]").slideDown(100);
                }
                $("input[value=添加]").attr("clid", clid);
                myAjax("/Service/CusServices.asmx/GetLosByCusID", JSON.stringify({ "clid": clid }), function (data) {
                    $("#tbs1 tr[i]").remove();
                    $(JSON.parse(data["d"])).each(function (k,v) {
                        var tr = $("<tr i></tr>");
                        var td1 = $("<th>" +ConvertTime( v["MeDate"] )+ "</th>");
                        var td2 = $("<th>" + v["MeDesc"] + "</th>");
                        tr.append(td1).append(td2);
                        $(tr).insertBefore("#sb");
                        $("img[key=" + clid + "]").attr("state",2);
                    });
                  
                });

            });
            //确认流失操作
            $("img[title]").live("click", function () {
                showtr = $(this).parent().parent();
                var state = $(this).attr("state");
                var clid = $(this).attr("key");
                var CLReason = showtr.find("input")[1].value;
                $.post("../Service/MyProcessRequst.ashx?&method=FGChanRoleAll&rightcode=R_0013", null, function (data) {
                    if (data < 1) {
                        alert("对不起，您当前没有拥有这个权限，如要继续进行，请联系系统管理员获取相应的权限！");
                    } else {
                        if (state < 2) {
                            alert("请先进行缓存操作！");
                            return;
                        }
                        var mea = { "CLID": clid, "CLReason": CLReason };
                        var rt = window.showModalDialog("LostEnter.aspx?data=" + Math.random(), mea, "dialogWidth:500px;dialogHeight:200px;help:no");
                        if (rt != null) {
                            showtr.find("input")[1].value = rt["CLReason"];
                            $("input[value=添加]").hide();
                            showtr.children("th")[4].innerText = getNowDate();
                            showtr.children("th")[5].innerText = "已流失";
                            showtr.children("th")[6].innerHTML = "<img src='../images/bt_confirm.gif' title='查看流失原因'  state='3'  key='" + clid + "' />";
                        }
                    }
                });
            });
            GetData();
            //翻页
            $("#rightPage input[method]").click(function () {
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
                    var number = $("#size").val();
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
            //添加流失措施
            $("input[value=添加]").click(function () {
                var clid = $(this).attr("clid");
                var MeDesc = $("#MeDesc").val();
                if (MeDesc.length == 0) {
                    alert("措施不能为空！");
                    return;
                }
                var mea = JSON.stringify({ "CLID": clid, "MeDesc": MeDesc });
                myAjax("/Service/CusServices.asmx/AddMea", JSON.stringify({ "json": mea }), function (data) {
                    if (data["d"] > 0) {
                        $("#MeDesc").val("");
                        var tr = $("<tr i></tr>");
                        var td1 = $("<th>" + getNowDate() + "</th>");
                        var td2 = $("<th>" + MeDesc + "</th>");
                        tr.append(td1).append(td2);
                        $(tr).insertBefore("#sb");
                        showtr.children("th")[5].innerText = "暂缓流失";
                        showtr.children("th")[6].innerHTML = "<img src='../images/bt_confirm.gif' title='确认流失'  state='2'  key='" + clid + "'  />";
                    }
                    else {
                        alert("添加失败");
                    }
                });
            });
            //查询
            $("input[type=button][value=查询]").click(function () {
                cusid = $("#CusID").val();
                cusname = $("#CusName").val();
                cldate = $("#CLDate").val();
                clenddate = $("#CLEnterDate").val();
                clstate = $("#CLState option:selected").val();
                GetData();
            });
            $("#CusID").keyup(function () {
                cusid = $("#CusID").val();
                cusname = $("#CusName").val();
                cldate = $("#CLDate").val();
                clenddate = $("#CLEnterDate").val();
                clstate = $("#CLState option:selected").val();
                GetData();
            });
            $("#CusName").keyup(function () {
                cusid = $("#CusID").val();
                cusname = $("#CusName").val();
                cldate = $("#CLDate").val();
                clenddate = $("#CLEnterDate").val();
                clstate = $("#CLState option:selected").val();
                GetData();
            });
            
            //$("#CLState").change(function () {
            //    alert("aa");
               
            //});
        });
        //查询方法
        function GetData() {
            var jsstr = JSON.stringify({ "CLID": index, "CusID": cusid, "CusName": cusname, "CLDate": cldate, "CLEnterDate": clenddate, "CLState": clstate });
            //alert(jsstr);
            myAjax("/Service/CusServices.asmx/GetCusLos", JSON.stringify({ "json": jsstr }), function (data) {
                maxpage = JSON.parse(data["d"])["page"];
                count = JSON.parse(data["d"])["count"];
                $("#leftPage").text("共有" + count + "条记录，当前第" + index + "/" + maxpage + "页");
                $("#tbs tbody tr").remove();
                $(JSON.parse(data["d"])["list"]).each(function (k, v) {
                    var tr = $("<tr></tr>");
                    var td1 = $("<th>" + v["CusID"] + "<input  type='hidden' value='" + v["CLID"] + "'/><input type='hidden' value='" + v["CLReason"] + "'/></th>");
                    var td2 = $("<th>" + v["CusName"] + "</th>");
                    var td3 = $("<th>" + ConvertTime(v["CLOrderDate"]) + "</th>");
                    var td4 = $("<th>" + ConvertTime(v["CLDate"]) + "</th>");
                    var enddate = "可挽回...";
                    if (v["CLEnterDate"]!=null) {
                        enddate =ConvertTime(v["CLEnterDate"]);
                    }
                    var td5 = $("<th>" +enddate + "</th>");
                    var statestr = "";
                    var statetitle="";
                    if (v["CLState"]==1) {
                        statestr = "流失报警";
                        statetitle = "暂缓流失"
                    } else if (v["CLState"] == 2) {
                        statestr = "暂缓流失";
                        statetitle = "确认流失"
                    } else if (v["CLState"] == 3) {
                        statestr = "已流失";
                        statetitle = "查看"
                    }
                    var td6 = $("<th>" + statestr + "</th>");
                    var td7 = $("<th><img src='../images/bt_confirm.gif' title=" + statetitle + "  state='" + v["CLState"] + "'  key='" + v["CLID"] + "'  /></th>");
                    $(tr).append(td1)
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

    
    </script>
</head>
<body>
 <div id="desDiv">
        <span>客户流失管理</span><br />
        显示即将流失的客户信息，并制定挽救措施
    </div>
    <div style="width: 1065px">
        <div id="dataLeft">
              <table class="tableEdit" style="width:550px">
        <tr>
            <th>
                客户编号：
            </th>
            <td>
                <input type="text" id="CusID" />
            </td>
          
            <th>
                客户名称：
            </th>
            <td>
                <input type="text" id="CusName" />
            </td>
              </tr>
             <tr>
            <th>
                开始报警时间：
            </th>
            <td>
                <input type="text" id="CLDate"  onclick="WdatePicker()"/>
            </td>
       
         <th>
               开始流失时间：
            </th>
            <td>
              <input type="text" id="CLEnterDate"onclick="WdatePicker()"  />
            </td>
        </tr>
        <tr>
            <th>
                状态：
            </th>
            <td colspan="3">
                <select id="CLState" onchange="aa()">
                   <option value="0">所有状态</option>
                   <option value="1">流失报警</option>
                   <option value="2">流失缓存</option>
                   <option value="3">已流失</option>
               </select>
            </td>
              </tr>
        <tfoot>
            <tr>
                <td colspan="8">
                    <input type="button" value="查询" />
                </td>
            </tr>
        </tfoot>
    </table>
            <table class="dataTable" id="tbs">
                <thead>
                    <tr>
                        <th>
                            客户编号
                        </th>
                        <th>
                            客户名称
                        </th>
                        <th>
                            上次下单时间
                        </th>
                        <th>
                            报警时间
                        </th>
                        <th>
                            流失时间
                        </th>
                        <th>
                            状态
                        </th>
                        <th>
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody></tbody>
               
            </table>
            <div id="pageDiv">
                <div id="leftPage">
                    共有120条记录，当前第1/10页</div>
                <div id="rightPage">
                    <input type="image" src="../images/first.gif" method="shou"/>&nbsp;&nbsp;
                    <input type="image" src="../images/back.gif" method="shang" />&nbsp;&nbsp;
                    <input type="image" src="../images/next.gif" method="xia" />&nbsp;&nbsp;
                    <input type="image" src="../images/last.gif" method="wei" />&nbsp;&nbsp; 转到第<input id="size" type="text"
                        size="1" />&nbsp;&nbsp;<input type="image" method="go" src="../images/go.gif" />
                </div>
            </div>
        </div>
        <div id="dataRight">
            <div class="menuDiv">
                <div  style="background-image:url(../images/bg.gif)">暂缓流失措施
                </div>
            </div>
            <div class="contentDiv">
                <div>
                    <table class="tableEdit">
                        <thead>
                            <tr>
                                <td colspan="2">添加暂缓措施</td>
                            </tr>
                        </thead>
                        <tr>
                        <th>暂缓措施细节：</th>
                            <td>
                                <textarea style="width:90%" id="MeDesc" placeholder="请输入暂缓措施..."></textarea>
                            </td>
                           </tr>
                           <tfoot>
            <tr>
                <td colspan="4">
                    <input type="button" value="添加" />&nbsp;&nbsp;
                </td>
            </tr>
        </tfoot>
                    </table>
                    <table class="dataTable" id="tbs1">
                        <thead>
                            <tr>
                                <th>时间</th>
                                <th>措施</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="sb"></tr>
                       </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
