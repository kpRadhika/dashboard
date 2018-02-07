<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*,com.parinati.userLogin.*" %>
<jsp:useBean id="loginDomain" scope="session" class="com.parinati.userLogin.LoginDomain" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
a:link{
font-family:    verdana,times new roman;
font-size:      13px;
color:          #FFFF;
text-decoration: none;
}
a:visited {
font-family:    verdana,times new roman;
font-size:      13px;
color:         #FFFF;
text-decoration: none;
}
a:hover {
font-family:    verdana,times new roman;
font-size:      13px;
color:         #000000;
text-decoration:none;
}
u.style
{
color:#BDBDBD;
}
span.style2
{
color:#FFFFFF;
}
</style>
<title>ADMINISTRATION</title>
</head>
<body bgcolor="#ffC30B" style="margin: 0;padding: 0;">
<%

int roleId = Integer.parseInt((String)session.getAttribute("role"));
List<ArrayList> functionList = loginDomain.findToolsByRole(roleId,"ADMIN");
%>
<div name="vmenu" id="vmenu">
<table border="0" align="left" cellpadding="2"  style="width: 100%" >
<%
if(functionList!=null && !functionList.isEmpty()){
	Iterator iter = functionList.listIterator();
	int count = 0;
	while(iter.hasNext()){
		ArrayList record = (ArrayList)iter.next();
		
		String functionName = (String)record.get(0);
		String functionUrl = (String)record.get(1);
		%>
		<tr>		        
		        <td height="30" valign="top" align="right"><a class="a:link" href="../<%=functionUrl%>" id="function<%=count%>" target="showfrm"><%= functionName%></a></td>
		    </tr>
		    
		<%
		count++;
	}
}
%>
</table>
</div>
</body>
</html>