<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="saleManager.aspx.cs" Inherits="UI.Sale.saleManager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/Style1.css" rel="stylesheet" type="text/css" />
<script src="../JS/jquery-1.4.1-vsdoc.js"></script>
<script src="../JS/json.js"></script>
<script src="../JS/MyJs.js"></script>
    <script type="text/javascript">
        //当前页数
        var index = 1;
        //最大页数
        var maxpage;
        //客户名字
        var channame = "";
       //联系人名字
        var chanlinkman = "";
        //指派人名字
        var chanduename = "";
        //指派人ID
        var chandueman = 0;
        //开发状态
        var chanstate = 0;
        //加载事件
        $(function () {
            //只看出自己的
            $("#showme").click(function () {
                var fg = $(this).attr("checked");
                chandueman = fg ? 1 : 0;
                getdata();
            });
            //查看
            $("img[title=查询]").live("click", function () {
                var chanid = $(this).attr("key");
                var state = $(this).attr("state");
               
                if (state == 3) {
                   
                    var returnValue = window.showModalDialog("SaleOkEdit.aspx?data=" + Math.random(), { "chid": chanid }, "dialogWidth:600px;dialogHeight:300px;help:no");
                }
                if (state==4) {
                    var returnValue = window.showModalDialog("SaleNoEdit.aspx?data=" + Math.random(), { "chid": chanid }, "dialogWidth:600px;dialogHeight:300px;help:no");
                }
            });
            //修改
            $("img[title=修改]").live("click", function () {
                var statetd1 = $(this).parent().parent().children("th")[6];
                var statetd2 = $(this).parent().parent().children("th")[7];
                var chanid = $(this).attr("key");
             
                $.post("../Service/MyProcessRequst.ashx?method=FGChanRole&ChanID=" + chanid, null, function (data) {
                    alert(data);
                    if (data <1) {
                        alert("对不起，您没有权限进行该操作，若要继续操作，请联系系统管理员！");
                    } else {
                        var returnValue = window.showModalDialog("SaleOpenEdit.aspx?data=" + Math.random(), { "chid": chanid }, "dialogWidth:600px;dialogHeight:300px;help:no");
                        if (returnValue != null) {
                            returnValue["ChanState"] == 3 ? statetd1.innerText = "开发成功" : "";
                            returnValue["ChanState"] == 3 ? statetd2.innerHTML = "<img title='查询' state='3'  key='" + chanid + "'   src='../images/bt_detail.gif' />" : "";
                            returnValue["ChanState"] == 4 ? statetd1.innerText = "开发失败" : "";
                            returnValue["ChanState"] == 4 ? statetd2.innerHTML = "<img title='查询' state='4'  key='" + chanid + "'   src='../images/bt_detail.gif' />" : "";
                        }
                    }
                });
              

            });
            //翻页
            $("input[type=image][method]").click(function () {
                var method = $(this).attr("method");
                if (method=="shou") {
                    index = 1;
                } else if (method == "shang") {
                    index = index > 1 ? index - 1 : index;
                } else if (method == "xia") {
                    index = index <maxpage ? index +1 : index;
                } else if (method == "wei") {
                    index = maxpage;
                } else if (method == "go") {
                    var size = $("#size").val();
                    index = size > maxpage ? index : parseInt(size);
                }
                getdata();
            });
            //查询
            $("input[type=button][value=查询]").click(function () {
                index = 1;
                channame = $("#ChanName").val();
                chanduename = $("#ChanDueMan").val();
                chanlinkman = $("#ChanLinkMan").val();
                chanstate = $("#ChanState option:selected").val();
                getdata();
            });
            //输入查询
            $("#ChanName").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                chanduename = $("#ChanDueMan").val();
                chanlinkman = $("#ChanLinkMan").val();
                chanstate = $("#ChanState option:selected").val();
                getdata();
            });
            $("#ChanDueMan").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                chanduename = $("#ChanDueMan").val();
                chanlinkman = $("#ChanLinkMan").val();
                chanstate = $("#ChanState option:selected").val();
                getdata();
            });
            $("#ChanLinkMan").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                chanduename = $("#ChanDueMan").val();
                chanlinkman = $("#ChanLinkMan").val();
                chanstate = $("#ChanState option:selected").val();
                getdata();
            });
           
             getdata();
        });
        //查询方法
        function getdata() {
            var jsstr = JSON.stringify({"ChanID":index,"ChanName":channame,"ChanLinkMan":chanlinkman,"UserName2":chanduename,"ChanDueMan":chandueman,"ChanState":chanstate});
            myAjax("/Service/ChanServices.asmx/GetChancesAllRe", JSON.stringify({ "json": jsstr }), function (data) {
                maxpage = JSON.parse(data["d"])["page"];
                var count = JSON.parse(data["d"])["count"];
                $("#leftPage").text("共有" + count + "条记录，当前第" + index + "/" + maxpage + "页");
                $("#tbs tbody tr").remove();
                $(JSON.parse(data["d"])["list"]).each(function (k, v) {
                    var tr = $("<tr></tr>");
                    var td1 = $("<th>" + v["ChanName"] + "</th>");
                    var td2 = $("<th>" + v["ChanTitle"] + "</th>");
                    var td3 = $("<th>" + v["ChanLinkMan"] + "</th>");
                    var td4 = $("<th>" + v["ChanLinkTel"] + "</th>");
                    var td5 = $("<th>" + ConvertTime(v["ChanCreateDate"]) + "</th>");
                    var td6 = $("<th>" + v["UserName2"] + "</th>");
                    var statestr = "";
                    if (v["ChanState"]==2) {
                        statestr = "开发中";
                    } else if (v["ChanState"] == 3) {
                        statestr = "开发成功";
                    } else if (v["ChanState"] == 4) {
                        statestr = "开始失败";
                    }
                    var td7 = $("<th>" + statestr + "</th>");
                    var imgname = "bt_feedback";
                    var statestr = "修改";
                    if (v["ChanState"]>2) {
                        imgname = "bt_detail";
                        statestr = "查询";
                    }
                    var td8 = $("<th><img title='"+statestr+"' state='"+v["ChanState"]+"'  key='"+v["ChanID"]+"'   src='../images/"+imgname+".gif' /></th>"); 
                    tr.append(td1)
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
            channame = $("#ChanName").val();
            chanduename = $("#ChanDueMan").val();
            chanlinkman = $("#ChanLinkMan").val();
            chanstate = $("#ChanState option:selected").val();
            getdata();
        }
    </script>
</head>
<body>
<div id="desDiv">
    <span>客户开发计划</span><br />
    制定客户开发计划和记录开发进度
</div>
<div id="dataDiv">
    <div id="headDiv">
    </div>
     <table class="tableEdit" style="width:100%">
        <tr>
            <th>
                客户名称：
            </th>
            <td>
                <input type="text" id="ChanName" />
            </td>
            <th>
                联系人：
            </th>
            <td>
                <input type="text" id="ChanLinkMan" />
            </td>
            <th>
                指派人：
            </th>
            <td>
                <input type="text" id="ChanDueMan" />
            </td>
       
         <th>
                开发状态：
            </th>
            <td>
               <select id="ChanState" onchange="change()">
                   <option value="0">所有状态</option>
                   <option value="2">开发中</option>
                   <option value="3">开发成功</option>
                   <option value="4">开发失败</option>
               </select>
                &nbsp; &nbsp; &nbsp;
                    只看指派给自己的<input  type="checkbox" id="showme"/>
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
                <th>客户名称</th>
                <th>概要</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th>创建时间</th>
                 <th>指派人</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="pageDiv">
        <div id="leftPage">共有120条记录，当前第1/10页</div>
        <div id="rightPage">
            <input type="image" src="../images/first.gif" method="shou" />&nbsp;&nbsp;
            <input type="image" src="../images/back.gif"  method="shang"/>&nbsp;&nbsp;
            <input type="image" src="../images/next.gif"method="xia" />&nbsp;&nbsp;
            <input type="image" src="../images/last.gif" method="wei" />&nbsp;&nbsp;
            转到第<input type="text" size="1" id="size"  />&nbsp;&nbsp;<input type="image"  method="go" src="../images/go.gif" />
        </div>
    </div>
</div>
</body>
</html>
