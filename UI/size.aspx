﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="size.aspx.cs" Inherits="UI.size" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
        <style type="text/css">
body {
	margin:-5px;
	padding:-5px;
}
table
{
	padding:0px;	
	margin-top:-5px;
	margin-bottom:-10px;
	border:solid 0px red;
}
table tr,td
{
	padding:0px;	
	margin:0px;
	border:solid 0px red;
}
img
{
    cursor:pointer;	
    width:11px;
    height:38px;
}
</style>
<script type="text/javascript">
    var isShow = true;
    function showLeft(img) {
        if (isShow) {
            window.top.document.getElementById("frame1").cols = "0,10,*,6";
            img.src = "images/main_55_1.gif";
            
        }
        else {
            window.top.document.getElementById("frame1").cols = "170,10,*,6";
            img.src = "images/main_55.gif";
         }
        isShow = !isShow;
    }
</script>
</head>
<body>
    <table style="height:105%;width:6px;"  cellspacing="0" cellpadding="0">
        <tr>
            <td style="vertical-align:middle;background-image:url('images/main_45.gif');"><img src="images/main_55.gif" onclick="showLeft(this)" /></td>
        </tr>
    </table>
</body>
</html>
