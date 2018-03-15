<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="timesheetDomain" scope="session" class="com.parinati.timesheet.TimesSheetDomain" />
<%@include file="../commonInclude.jsp" %>
  <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>view/Modify Candidate</title>
<style type="text/css">
label.error{
font-family:    verdana,times new roman;
font-size:      13px;
color:          red;
}

html, body, form {
	margin: 0px;
	padding: 0px;
	font-family: Trebuchet MS;
	font-size: 13px;
	color: #2f4f4f;
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

<script type = "text/javascript" src = "scripts/addTaskTime.js"></script>

</head>

<body>
<%
String taskStatusCode = request.getParameter("taskStatus")== null ? "": request.getParameter("taskStatus");
String user = (String)session.getAttribute("userID");

List<List<String>> taskDescription=timesheetDomain.getTaskDetails(taskStatusCode,user);
List<List<String>> statusList=timesheetDomain.getTaskStatus();

session.setAttribute("statusList",statusList);


%>

<form  method="post" action="viewModifyTask.jsp" >
<table width="80%" align="center" >
			<tr>
			<td  style="text-align: center;" colspan="7" class="tableheader">View/Modify mapped tasks</td>
			</tr>
			<tr >
			<td>Task Status</td>
				<td>
				<select id="taskStatus" name="taskStatus">
				<option value="">select Task Status</option>
				<%
				List<String> status=null;
				String statusCode=null,statusDesc=null;
				for(int i=0;i<statusList.size();i++)
				{
					status=statusList.get(i);
					statusCode=status.get(0);
					statusDesc=status.get(1);

					if(taskStatusCode.equals(statusCode))
					{
				%>
				<option  value="<%=statusCode %>" selected="selected"><%=statusDesc %></option>
				<%}else{
				%>
				<option  value="<%=statusCode %>"><%=statusDesc %></option>
				<%} }%>
				</select>
				</td>
			</tr>
			<tr>
			<td align="center" colspan="4">
			<input type="submit" id="submit" name="submit" value="Get Details">
			<input type="reset" id="reset" name="reset" value="Reset" onclick="resetVal()">
			</td>
			</tr>
		</table>
		<br/>
</form>
<form id="viewTask" action="addTaskTime.jsp">
<%request.setAttribute("statusList",statusList); %>
<table width="80%"  align="center" class="zebra">
			<tr>
			<td colspan="3" align="center" class="tableheader">Task Listing Report</td>
			</tr>
			<tr>
				<th>Task Id</th>
				<th>Task </th>
				<th>Task Status</th>
			</tr>
			<%if(!taskDescription.isEmpty()){
				List<String> taskDetails=null;
				for(int i=0;i<taskDescription.size();i++)
				{
					taskDetails=taskDescription.get(i);
			%>
			<tr>
				<td align="center"><a href="addTaskTime.jsp?taskId=<%=taskDetails.get(0)%>&taskName=<%=taskDetails.get(1)%>&taskStatus=<%=taskDetails.get(2)%>&statusCode=<%=taskDetails.get(4) %>&empId=<%=taskDetails.get(3) %>"><%=taskDetails.get(0)%></a></td>
				<td align="center"><%=taskDetails.get(1) %></td>
				<td align="center"><%=taskDetails.get(2) %></td>
			</tr>
			<%}
				} else{%>
			<tr>
			<td colspan="3" align="center">No Records Found</td>
			</tr>
<%} %>
</table>
<form>
</body>
</html>