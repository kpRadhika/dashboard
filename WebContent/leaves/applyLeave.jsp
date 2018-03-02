<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <%@page import="java.util.*,java.sql.*"%>
 <%@include file="../commonInclude.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type = "text/javascript" src = "scripts/applyLeave.js"></script>
<jsp:useBean id="leaveDom" scope="session" class="com.parinati.leaves.LeaveApplicationDomain" />
<title>Insert title here</title>
</head>
<body>
<%
String subButtonVal = request.getParameter("subBtn") == null?"":request.getParameter("subBtn");
String from = request.getParameter("fromDate") == null?"":request.getParameter("fromDate");;
String to = request.getParameter("toDate") == null?"":request.getParameter("toDate");
int leaveId = request.getParameter("leaveDropDown") == null?0:Integer.parseInt(request.getParameter("leaveDropDown"));
int userId = (Integer)session.getAttribute("userID");
if("Submit".equals(subButtonVal)){
	List values = new ArrayList();
	values.add(userId);
	values.add(from);
	values.add(to);
	leaveDom.submitLeaveForApproval(values);
}

%>

<form action="taskViewReport.jsp" method = "Post">
<table width="80%" align="center">
<tr class="tableheader"><td colspan="4">Task View Report</td></tr><tr></tr>
<tr><th>Leave Type</th><th>From Date</th><th>To Date</th><th>Remarks</th></tr>
<tr><td><select name="leaveDropDown" id="leaveDropDown">
<option value="">Select</option>
<%
List<ArrayList> leaveList = null;
String leaveId = null;
String leaveType = null;
			try {
				leaveList = leaveDom.fetchLeaveTypes();
				}
			catch (Exception t) {
				leaveList  = null;
				}	
	
 		if (leaveList != null && !leaveList.isEmpty()) 
 			{
 			 for (int size = 0; size < leaveList.size(); size++)
		 			{
		 				ArrayList leaveRec = (ArrayList) leaveList.get(size);
		 				leaveId = leaveRec.get(0).toString();
		 				leaveType = leaveRec.get(1).toString();
		 		
		 			
						 %> 
						
							<option value="<%=leaveId%>"><%=leaveType%></option>
						 
			<%
					}
			}
						%>
				    </select>
				    <div id="projectNameError" style="display: none; color: red;" ></div></td>

<td>
<input type="text" id="fromDate" name="fromDate" value="">
</td>
<td>
<input type="text" id="toDate" name="toDate" value="">
</td>
<td><input type="text" id="remarks" name="remarks" value=""></td>
</tr>
<tr align="center">
<td colspan="4"><input type="submit" id="subBtn" name="subBtn" value="Submit"></td>
</tr>
</table>
</form>
</body>
</html>