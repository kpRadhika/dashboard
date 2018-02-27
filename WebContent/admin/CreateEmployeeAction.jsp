<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="adminEmplDomain" scope="session" class="com.parinati.admin.CreateEmployeeDomain" />
<jsp:useBean id="mailUtil" scope="session" class="com.parinati.util.MailerUtil" />
<%@include file="../commonInclude.jsp" %>
  <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Employee</title>
<style type="text/css">
label.error{
font-family:    verdana,times new roman;
font-size:      13px;
color:          red;
}


button {
     background:none!important;
     color:inherit;
     border:none; 
     padding:0!important;
     font: inherit;
     border-bottom:1px solid #0147FA; 
     cursor: pointer;
}
.labelstyle {
    background:rgba(0,0,0,0);
    border:none;
}
</style>

</head>

<body>
<%
String selectedValue = request.getParameter("candSel")== null ? "": request.getParameter("candSel");
List result =null;
String dateOfJoin = request.getParameter("doj")== null ? "": request.getParameter("doj");
String roleId = request.getParameter("role")== null ? "": request.getParameter("role");
result = adminEmplDomain.generateEmployeeLogin(selectedValue,dateOfJoin,roleId);

%>

<form method="post" action="" >
	<%if(result!=null && !result.isEmpty()){ %>
	<!-- mailUtil.postMailWithTLSAuth() -->
	<table align="center">
	<tr>
		<td><b>Employee ID Created Successfully.Employee Id is <%=result.get(0).toString()%>.</b></td>
	</tr>
	
	<%}else{ %>
	
	<tr>
	<td><b> Error Occured While Creating Employee ID.</b></td>
	</tr>
	</table>
	<%} %>

</form>
</body>
</html>