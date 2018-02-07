<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
h1 {
	font-family: font-family: Segoe UI, Frutiger, Frutiger Linotype, Dejavu Sans, Helvetica Neue, Arial, sans-serif; 
	color: white;
	font-weight: bold;
	font-size: x-large;
}
</style>
<script type="text/javascript">
function logout()
{
	top.document.location = "Logout.jsp";
}
</script>
</head>
<body bgcolor="#FFC30B">
<%
	String userName = (String)session.getAttribute("userID");
%><table width="100%">
<tr>
<td colspan="2">
<h1>PARINATI</h1>
</td>
<td>
<table align="right" bgcolor="#FFC30B" >
<tr><td>Welcome <%= userName%></td></tr>
<tr><td><a href="" onclick="logout()">Logout</a></td></tr>
</table>
</td>
</tr>
</table>
</body>
</html>