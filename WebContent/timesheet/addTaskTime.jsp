<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="userDomain" scope="session" class="com.parinati.admin.CreateUserDomain" />
<%@include file="../commonInclude.jsp" %>
  <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Task Time</title>
<script type = "text/javascript" src = "scripts/viewModifyCandidate.js"></script>
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

<script>
$(document).ready(function(){
	
	$("#startDateTime").datetimepicker({
		dateFormat : "dd-mm-yy",
		changeMonth : true,
		changeYear : true,
		numberOfMonths : 1,
		showSecond:false,
		onSelect : function(selected) {
			$("#endDateTime").datepicker("option", "minDate", selected)
		}
	})
	
	$("#endDateTime").datetimepicker({
		dateFormat : "dd-mm-yy",
		changeMonth : true,
		changeYear : true,
		numberOfMonths : 1,
		onSelect : function(selected) {
			$("#startDateTime").datepicker("option", "minDate", selected)
		}
	})
})

function currentTime(dateTimePicker)
{
	var today=new Date();
	var date="0"+today.getDate();
	var month="0"+(today.getMonth()+1);
	var year=today.getFullYear();
	var hours="0"+today.getHours();
	var minuts="0"+today.getMinutes();
	//var currentDateTime=today.getDate()+"-"+("0"+(today.getMonth()+1)).slice(-2)+"-"+today.getFullYear()+" "+today.getHours()+":"+today.getMinutes();
	var currentDateTime=date.slice(-2)+"-"+month.slice(-2)+"-"+year+" "+hours.slice(-2)+":"+minuts.slice(-2);
	
	$("#"+dateTimePicker).val(currentDateTime);
	//$("#startDateTime").val(currentDateTime);
}
</script>
<%
 
String taskId=request.getParameter("taskId")==null?"":request.getParameter("taskId");
String taskStatus=request.getParameter("taskStatus")==null?"":request.getParameter("taskStatus");
String taskName=request.getParameter("taskName")==null?"":request.getParameter("taskName");
String statusCode=request.getParameter("statusCode")==null?"":request.getParameter("statusCode");

%>
</head>
<body>

	<form method="post" action="addTaskTime.jsp">
		<table width="50%" align="center">
			<tr>
				<th colspan="2">Add Task Time</th>
			</tr>
			<tr>
				<td>Task Name:</td><td><input type="text" readonly="readonly" name="taskName" id="taskName" value="<%=taskName%>"></input></td>
			</tr>
			<tr>
				<%-- <td>Task Description:</td><td><input type="" readonly="readonly" name="taskDesc" id="taskDesc" value="<%=taskName%>"></input></td> --%>
				<td>Task Description:</td>
				<td><textarea rows="5" cols="16" readonly="readonly" name="taskDesc" id="taskDesc"><%=taskName%></textarea></td>	
			
			</tr>
			<tr>
				<td>Start DateTime:</td><td><input type="text" id="startDateTime" name="startDateTime">
				<input type="button" value="now" id="startDateTime" onclick="currentTime(this.id)"/></td>
			</tr>
			<tr>
				<td>End DateTime:</td><td><input type="text" id="endDateTime" name="endDateTime">
				<input type="button" value="now" id="endDateTime" onclick="currentTime(this.id)"/></td></td>
			</tr>
			
			<tr>
			    <td>Task Status:</td>
			    <td>
				<select id="taskStatus" name="taskStatus">
				<option value="<%=statusCode %>"><%=taskStatus%></option>
				<%-- <% 
				List<String> status=null; 
				String statusCode=null,statusDesc=null;
				for(int i=0;i<statusList.size();i++)
				{
					status=statusList.get(i);
					statusCode=status.get(0);
					statusDesc=status.get(1);
					
					if(taskStatus.equals(statusCode))
					{
				%>
				<option  value="<%=statusCode %>" selected="selected"><%=statusDesc %></option>
				<%}else{
				%>
				<option  value="<%=statusCode %>"><%=statusDesc %></option>
				<%} }%> --%>
				</select>
				</td>
			</tr>
		</table>
		<br />
	</form>

</body>
</html>