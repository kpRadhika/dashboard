<%@ page language="java" contentType="text/html; charset=ISO-8859-1"    pageEncoding="ISO-8859-1"%>
<!-- Admin Page -->
<html>

<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">

<%
String user = (String)session.getAttribute("userID");
if(user!=null) 
{
%>
<title>LoginHome</title>
 <frameset rows="10%,90%" frameborder="no" >
	<frame src="login/topPanel.jsp"  noresize="noresize"> 
		<frameset cols="20%,80%" border="0">
			<frame src="login/LeftPanel.jsp" noresize="noresize">
			<frame src="login/MidPanel.jsp" name="showfrm"  noresize="noresize">
		</frameset>	
<!-- </frameset> -->
<%}%>

</head>
<!-- <body onload="validate()">
</body> -->
</html>