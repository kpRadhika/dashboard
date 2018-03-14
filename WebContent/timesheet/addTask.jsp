<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*"%>
    <%@include file="../commonInclude.jsp" %>
 <jsp:useBean id="createEmplDom" scope="session" class="com.parinati.admin.CreateEmployeeDomain" /> 
 <jsp:useBean id="timeDom" scope="session" class="com.parinati.timesheet.TimesSheetDomain" /> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type = "text/javascript" src = "scripts/addTask.js"></script>
<title>Insert title here</title>
<style>
.error {
    color:#FF0000;  /* red */
}
</style>
</head>
<body>
<%
String subButtonVal = request.getParameter("createTask") == null?"":request.getParameter("createTask");
String user = (String)session.getAttribute("userID");
if(subButtonVal.equals("Submit")){
	String clientId = request.getParameter("clientTaskId") == null?"":request.getParameter("clientTaskId");
	String taskDesc = request.getParameter("taskDesc") == null?"":request.getParameter("taskDesc");
	String remarks = request.getParameter("remarks") == null?"":request.getParameter("remarks");
	String projectId = request.getParameter("projectDropDown") == null?"":request.getParameter("projectDropDown");
	String resources = request.getParameter("selectedRes") == null?"":request.getParameter("selectedRes");
	 List<String> inputList = new ArrayList<>();
	 inputList.add(taskDesc);
	 inputList.add(clientId);
	 inputList.add(projectId);
	 inputList.add(resources);
	 inputList.add(remarks);
	 inputList.add(user);
	 int taskId = timeDom.createTask(inputList)	; 
	 if(taskId>0){		 
		 %>
		 <table align ="center" width="80%">
		 <tr style="font-weight: bold; text-align: center;">
		 <td>Task created successfully. Task Id:<%=taskId %></td>
		 </tr>
		 </table>
		 <%
	 }
	 else{
		 %>
		 <table align ="center" width="80%">
		 <tr style="font-weight: bold;text-align: center;">
		 <td>Error occurred while creating the task</td>
		 </tr>
		 </table>
		 <%
	 }
}
else{
%>
<form action="addTask.jsp" id="addTask" method = "Post">
<table width="80%" align="center" style="background: radial-gradient(ellipse at top,lavender,white );">
<tr class="tableheader"><td colspan="2">Add Task</td></tr><tr></tr>
<tr>
	<td><b>Project Name<span class="required"></span></b></td>
	<td>
<select name="projectDropDown" id="projectDropDown" style="padding-right: 14%;">
<option value="">Select</option>
				<%
List allProjectList = new ArrayList();
String projectId = null;
String projectName = null;
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
		 				projectId = allProjectListTemp.get(0).toString();
		 				projectName = allProjectListTemp.get(1).toString();
		 		
		 			
						 %> 
						
							<option value="<%=projectId%>"><%=projectName%></option>
						 
			<%
					}
			}
						%>
				    </select>
				    <div id="projectNameError" style="display: none; color: red;" ></div>
				    </td>

</tr>
<tr>
	<td><b>Client Task id<span class="required"></span></b></td>
	<td><input type="text" id="clientTaskId" name="clientTaskId" disabled="disabled"></td>
</tr>
<tr>
	<td><b>Task Description<span class="required"></span></b></td>
	<td><input type="text" id="taskDesc" name="taskDesc" disabled="disabled"></td>
</tr>
<tr>
	<td><b>Resources mapped<span class="required"></span></b></td>
<td>
<div id="resMapping" style="display: none"></div>
</td>
</tr>
<tr>
	<td><b>Remarks<span class="required"></span></b></td>
<td><input type="text" id="remarks" name="remarks" disabled="disabled"/></td>
</tr>
<tr>
<td></td>
<td><input type="submit" value="Submit" id="createTask" name="createTask"/></td>
</tr>
</table>
<input type="hidden" id="selectedRes" name="selectedRes" value="">
</form>
<%}

%>
</body>
</html>