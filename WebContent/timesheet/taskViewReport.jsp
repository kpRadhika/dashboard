<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@page import="java.util.*,java.sql.*"%>
 <%@include file="../commonInclude.jsp" %>
 <jsp:useBean id="createEmplDom" scope="session" class="com.parinati.admin.CreateEmployeeDomain" /> 
 <jsp:useBean id="timeDom" scope="session" class="com.parinati.timesheet.TimesSheetDomain" /> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type = "text/javascript" src = "scripts/taskViewReport.js"></script>
<title>Insert title here</title>
<style >
.error {
    color:#FF0000;  /* red */
}
</style>
</head>
<body>
<%
String subButtonVal = request.getParameter("subBtn") == null?"":request.getParameter("subBtn");
String from = request.getParameter("fromDate") == null?"":request.getParameter("fromDate");;
String to = request.getParameter("toDate") == null?"":request.getParameter("toDate");
int projectId = request.getParameter("projectDropDown") == null?0:Integer.parseInt(request.getParameter("projectDropDown"));
%>
<form action="taskViewReport.jsp"  id="viewTaskTbl" method = "Post">
<table width="80%" align="center">
<tr class="tableheader"><td colspan="4">Task View Report</td></tr><tr></tr>
<tr>
	<td>From Date<span class="required"></span></td>
	<td><input type="text" id="fromDate" name="fromDate" value="<%=from%>"></td>
	<td>To Date<span class="required"></span></td>
	<td><input type="text" id="toDate" name="toDate" value="<%=to%>"></td>
</tr>
<tr><td>Project<span class="required"></span></td><td><select name="projectDropDown" id="projectDropDown">
<option value="">Select</option>
				<%
List allProjectList = new ArrayList();
String pId = null;
String pName = null;
			try {
				allProjectList = createEmplDom.fetchProjectDetails();
				}
			catch (Exception t) {
					allProjectList  = null;
				}	
	
 		if (allProjectList != null && !allProjectList.isEmpty()) 
 			{
 			 for (int size = 0; size < allProjectList.size(); size++)
		 			{
		 				ArrayList allProjectListTemp = (ArrayList) allProjectList.get(size);
		 				pId = allProjectListTemp.get(0).toString();
		 				pName = allProjectListTemp.get(1).toString();
		 			
		 				if(pId.equalsIgnoreCase(String.valueOf(projectId)) ){
						 %> 
							<option selected= "selected" value="<%=pId%>"><%=pName%></option>
						<%
		 				}else{
		 					 %> 
								<option value="<%=pId%>"><%=pName%></option>
							<%
		 				}
					}
			}
						%>
				    </select>
				    <div id="projectNameError" style="display: none; color: red;" ></div></td><td></td><td></td>
</tr>
<tr align="center">
<td colspan="4"><input type="submit" id="subBtn" name="subBtn" value="Submit"></td>
</tr>
</table>
</form>
<%
if(subButtonVal.equals("Submit")){
	List<ArrayList> taskList = timeDom.getTaskList(from,to,projectId);
	if(taskList!=null && !taskList.isEmpty()){
		Iterator iterator = taskList.listIterator();
			%>
			<form action="">
			<div id="empltable" style="border: 1px solid silver; margin: auto; width: 100%;margin-top: 1%; height: 350px; vertical: 20px; overflow-y: scroll; overflow-x: scroll;">
			<table align="center" class="zebra" width="100%" style="border: none">
			<tr>
			<th>TaskId</th>
			<th>TaskDescription</th>
			<th>ClientTaskId</th>
			<th>TaskStatusId</th>
			<th>Employees</th>
			<th>CreatedBy</th>
			<th>CreationDate</th>
			</tr>
			<%
			while(iterator.hasNext()){
				ArrayList taskDtls = (ArrayList)iterator.next();
				String taskId = (String)taskDtls.get(0);
				String clientTaskId = (String)taskDtls.get(1);
				String taskStatusId = (String)taskDtls.get(2);
				String createdBy = (String)taskDtls.get(3);
				String creationDate = (String)taskDtls.get(4);
				Array employees = (Array)taskDtls.get(5);
				String[] empList = null;
				if(employees!=null){
				 empList = (String[])employees.getArray();
				}
				String taskDesc = (String)taskDtls.get(6);			
			%>
			<tr>
			<td><%=taskId%></td>
			<td><%=taskDesc %></td>
			<td><%=clientTaskId %></td>
			<td><%=taskStatusId %></td>
			<td>
			<%for(String s:empList) {%>
			<%=s + ","%>
			<%} %>
			</td>
			<td><%=createdBy %></td>
			<td><%=creationDate %></td>
			</tr>
			<%} %>
			</table>
			</div>
			</form>
			<%
		}
	}
%>
</body>
</html>