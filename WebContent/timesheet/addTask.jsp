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
</head>
<body>
<%
String projId = request.getParameter("projectDropDown") == null?"":request.getParameter("projectDropDown");

%>
<form action="addProject.jsp">
<table width="80%" align="center">
<tr class="tableheader"><td colspan="2">Add Task</td></tr><tr></tr>
<tr>
<td>

				<label>Project Name<span class="required"></span>&nbsp;&nbsp;:</label>
				<select name="projectDropDown" id="projectDropDown">
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
<td>Client Task id</td><td><input type="text" id="clientTaskId" name="clientTaskId" disabled="disabled"></td>
</tr>
<tr>
<td>Task Description</td><td><input type="text" id="taskDesc" name="taskDesc" disabled="disabled"></td>
</tr>
<tr>


<td>Resources mapped</td><td>
<table id="resMapping" name="resMapping" style="display: none">

<%if(projId!=null & !projId.isEmpty()){
	List<ArrayList> emplList = timeDom.fetchEmployeeByProject(projId);
	Iterator<ArrayList> empIter = emplList.listIterator();
	while(empIter.hasNext()){
		String resName = (String)empIter.next().get(0);
	%>
	<tr>
	<td>
	<input type="checkbox" class="resourceVal" value="<%=resName%>"><%=resName%>
	</td>
	</tr>
	<%	
	}
}
	%>
	
	</table>
</td>
</tr>
<tr>
<td></td>
<td><table>
<% %>
<tr></tr>
</table></td>
</tr>
</table>
</form>
</body>
</html>