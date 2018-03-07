<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="userDomain" scope="session" class="com.parinati.admin.CreateUserDomain" />
<jsp:useBean id="timesheetDomain" scope="session" class="com.parinati.timesheet.TimesSheetDomain" />
<%@include file="../commonInclude.jsp" %>
  <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Task Time</title>
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
 
String taskId=request.getParameter("taskId")==null?"":request.getParameter("taskId");
String taskName=request.getParameter("taskName")==null?"":request.getParameter("taskName");
String selectedStatus=request.getParameter("statusCode")==null?(request.getParameter("taskStatus")==null?"":request.getParameter("taskStatus")):request.getParameter("statusCode");
String empId=request.getParameter("empId")==null?"":request.getParameter("empId");
List<List<String>> statusList=(List<List<String>>)session.getAttribute("statusList");

String submitVal=request.getParameter("submit")==null?"":request.getParameter("submit");
if(submitVal.equals("submit"))
{
	String selStartDate=request.getParameter("startDateTime")==null?"":request.getParameter("startDateTime");
	String selEndDate=request.getParameter("endDateTime")==null?"":request.getParameter("endDateTime");
	String empIdHidden=request.getParameter("empIdHidden")==null?"":request.getParameter("empIdHidden");
	String taskIdHidden=request.getParameter("taskIdHidden")==null?"":request.getParameter("taskIdHidden");
	String hours=request.getParameter("hours")==null?"":request.getParameter("hours");
	List<String> inputList=new ArrayList<>();
	inputList.add(empIdHidden);
	inputList.add(taskIdHidden);
	inputList.add(selStartDate);
	inputList.add(selEndDate);
	inputList.add(selectedStatus);
	inputList.add(hours);
	int result=timesheetDomain.insertTaskDetails(inputList);
	 if(result>0){		 
%>
		 <table align ="center" width="80%">
		 <tr style="font-weight: bold; text-align: center;">
		 <td>Task details inserted successfully.</td>
		 </tr>
		 </table>
		 <%
	 }
	 else{
		 %>
		 <table align ="center" width="80%">
		 <tr style="font-weight: bold;text-align: center;">
		 <td>Error occurred while inserting the task details.</td>
		 </tr>
		 </table>
		 <%
	 }
}
else{
%>

	<form method="post" name="addTaskTime" id="addTaskTime" action="addTaskTime.jsp" onsubmit="return formSubmit();">
		<table width="50%" align="center">
			<tr>
				<th colspan="2">Add Task Time</th>
			</tr>
			<tr>
				<td>Task Name:</td><td><input type="text" readonly="readonly" name="taskName" id="taskName" value="<%=taskName%>"></input></td>
			</tr>
			<tr>
				<td>Task Description:</td>
				<td><textarea rows="5" cols="16" readonly="readonly" name="taskDesc" id="taskDesc"><%=taskName%></textarea></td>	
			
			</tr>
			<tr>
				<td>Start DateTime:</td><td><input type="text" id="startDateTime" name="startDateTime">
				<div id ="startDateTimeError" for="startDateTime" generated="true" class="error"></div>
				</td>
			</tr>
			<tr>
				<td>End DateTime:</td><td><input type="text" id="endDateTime" name="endDateTime">
				<div id="endDateTimeError" for="endDateTime" generated="true" class="error"></div>
				</td>
			</tr>
			
			<tr>
			    <td>Task Status:</td>
			    <td>
				<select id="taskStatus" name="taskStatus" onchange="setStatusOption(this.value)">
				<% 
				List<String> status=null; 
				String statusCode=null,statusDesc=null;
				for(int i=0;i<statusList.size();i++)
				{
					status=statusList.get(i);
					statusCode=status.get(0);
					statusDesc=status.get(1);
					
					if(selectedStatus.equals(statusCode))
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
			<input type="submit" id="submit" name="submit" value="submit">
	<input type="hidden" id="taskIdHidden" name="taskIdHidden" value="<%=taskId %>">
	<input type="hidden" id="empIdHidden" name="empIdHidden" value="<%=empId %>">
	<input type="hidden" id="hours" name="hours">
	
			</td>
			</tr>
		</table>
		<br />
	</form>
<%} %>

</body>
</html>