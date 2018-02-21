<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="employeeDomain" scope="session" class="com.parinati.admin.CreateEmployeeDomain" />
<%@include file="../commonInclude.jsp" %>
<%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="addProject.jsp">
<table width="80%" align="center">
<tbody>
<tr class="tableheader"><td colspan="2">add project</td></tr><tr></tr>
<tr>
<td>
Project Name
</td>
<td>
<input type="text" id="pname" name="pname">
</td>
</tr>
<tr>
<td>
Project Technology
</td>
<td>
<input type="text" id="ptech" name="ptech">
</td>
</tr>
<tr>
<td>
Project Location
</td>
<td>
<select id="ploc" name="ploc">
<option value="">-Please select-</option>
<option value="Goa">Goa</option>
<option value="Mumbai">Mumbai</option>
<option value="Bangalore">Bangalore</option>
</select>
</td>
</tr>
<tr></tr>
<tr>
<td colspan="2" align="center">
<input type="submit" id="subBtn" name="subBtn" value="Submit">
<input type="reset" id="resBtn" name="resBtn">
</td>
</tr>
</tbody>
</table>
</form>
</body>
</html>