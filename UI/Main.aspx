<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="UI.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
      <script src="JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="JS/json.js"></script>
    <script src="JS/MyJs.js"></script>
    <script>
        //客户流失监控方法
        function FilterCus() {
            myAjax("/Service/CusServices.asmx/FilterCus", {}, function (data) {});
        }
        //延时调用方法客户流失监控
        setInterval("FilterCus()", 360000);


    </script>
</head>
<frameset rows="97p,*,20px" frameborder="no"  border="0">
     <frame src="head.aspx" scrolling="No" noresize="noresize" ></frame>
    <frameset id="frame1" cols="170,10,*,6" frameborder="no"   border="0">
        <frame src="left.aspx" scrolling="Auto" noresize="noresize"></frame>
        <frame src="size.aspx" scrolling="No" noresize="noresize" ></frame>
        <frame name="main" src="default.aspx"  noresize="noresize"></frame>
        <frame src="rigth.aspx" scrolling="No" noresize="noresize"></frame>
    </frameset>
    <frame src="foot.aspx"></frame>
</frameset>
</html>
