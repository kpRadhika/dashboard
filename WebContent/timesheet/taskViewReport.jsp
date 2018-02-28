<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@page import="java.util.*"%>
 <%@include file="../commonInclude.jsp" %>
 <jsp:useBean id="createEmplDom" scope="session" class="com.parinati.admin.CreateEmployeeDomain" /> 
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
String to = request.getParameter("toDate") == null?"":request.getParameter("toDate");
String projectId = request.getParameter("projectId") == null?"":request.getParameter("projectId");
if(subButtonVal.equals("Submit")){
	List<List<String>> taskList = timeDom.getTaskList(from,to,projectId);
	if(taskList!=null && !taskList.isEmpty()){
		Iterator iterator = taskList.listIterator();
		while(iterator.hasNext()){
			%>
			<form action="">
			<table align="center" width="80%">
			<tr>
			<td> </td>
			</tr>
			</table>
			</form>
			<%
		}
	}
}
%>
<form action="taskViewReport.jsp" method = "Post">
<table width="80%" align="center">
<tr class="tableheader"><td colspan="4">Task View Report</td></tr><tr></tr>
<tr>
<td>
From Date</td><td><input type="text" id="fromDate" name="fromDate" value="<%=from%>">
</td>
<td>
To Date</td><td><input type="text" id="toDate" name="toDate" value="<%=to%>">
</td>
</tr>
<tr><td>Project</td><td><select name="projectDropDown" id="projectDropDown">
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
		 		
		 			
						 %> 
						
							<option value="<%=pId%>"><%=pName%></option>
						 
			<%
					}
			}
						%>
				    </select>
				    <div id="projectNameError" style="display: none; color: red;" ></div></td><td></td><td></td>
</tr>
<tr align="center">
<td colspan="2"><input type="submit" id="subBtn" name="subBtn" value="Submit"></td>
</tr>
</table>
</form>
</body>
</html>