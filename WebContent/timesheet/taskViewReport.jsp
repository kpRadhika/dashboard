<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@page import="java.util.*"%>
 <%@include file="../commonInclude.jsp" %>
 <jsp:useBean id="timeDom" scope="session" class="com.parinati.timesheet.TimesSheetDomain" /> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type = "text/javascript" src = "scripts/taskViewReport.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
String subButtonVal = request.getParameter("subBtn") == null?"":request.getParameter("subBtn");
String from = request.getParameter("fromDate") == null?"":request.getParameter("fromDate");;
String to =request.getParameter("toDate") == null?"":request.getParameter("toDate");
if(subButtonVal.equals("Submit")){
	List<List<String>> taskList = timeDom.getTaskList(from,to);
}
%>
<form action="taskViewReport.jsp" method = "Post">
<table width="80%" align="center">
<tr class="tableheader"><td colspan="2">Task View Report</td></tr><tr></tr>
<tr>
<td>
From Date&nbsp;<input type="text" id="fromDate" name="fromDate" value="<%=from%>">
</td>
<td>
To Date&nbsp;<input type="text" id="toDate" name="toDate" value="<%=to%>">
</td>
</tr>
<tr align="center">
<td colspan="2"><input type="submit" id="subBtn" name="subBtn" value="Submit"></td>
</tr>
</table>
</form>
</body>
</html>