<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@page import="java.util.*,java.sql.*"%>
 <%@include file="../commonInclude.jsp" %>
<script type = "text/javascript" src = "scripts/approveLeave.js"></script>
<jsp:useBean id="leaveDomain" scope="session" class="com.parinati.leaves.LeaveApplicationDomain" />
<title>Insert title here</title>
</head>
<body>
<%
String loginId = session.getAttribute("userID") == null ?"" : session.getAttribute("userID").toString();
String submitVal = request.getParameter("submit") == null ? "" : request.getParameter("submit");
String emlAppId = request.getParameter("emlSel") == null ? "" : request.getParameter("emlSel");
String emlId = request.getParameter("emlId") == null ? "" : request.getParameter("emlId");
String isApproved = request.getParameter("isApproved") == null ? "" : request.getParameter("isApproved");
int result = 0;
if("".equals(submitVal)){
List<ArrayList> emplList = leaveDomain.fetchEmployeeLeave(loginId);
if(!emplList.isEmpty()){
%>
<form action="approveLeave.jsp" method = "Post">
<table width="80%" align="center">
<tr class="tableheader">
			<td colspan="3">Approve Leave</td>
</tr>
<tr>
<td>
<table style= "width: 80%;border: none;" align="center" id="empltable" >
	<tr align="center" class="tableheader">
		<td>Select</td>
		<td>Employee Id</td>
		<td>Employee Name</td>
		<td>Leave From</td>
		<td>Leave To</td>
		<td>Leave Type</td>
		<td>Remark</td>
	</tr>
<% for (int i = 0; i < emplList.size(); i++)
	{
		ArrayList emplRec = (ArrayList) emplList.get(i);
		String empId = emplRec.get(0)== null ? "" : emplRec.get(0).toString();
		String empFirstName = emplRec.get(1)== null ? "" : emplRec.get(1).toString();
		String empLastName = emplRec.get(2)== null ? "" : emplRec.get(2).toString();
		String empLeaveFrom = emplRec.get(3)== null ? "" : emplRec.get(3).toString();
		String empLeaveTo = emplRec.get(4)== null ? "" : emplRec.get(4).toString();
		String empLeaveType = emplRec.get(5)== null ? "" : emplRec.get(5).toString();
		String empAppId = emplRec.get(6)== null ? "" : emplRec.get(6).toString();
	
		%>
		<tr>
			<td><input type="radio" id="emlSel<%=i %>" value="<%=empAppId%>" class="radioCheck" onclick="enableDisable(<%=i%>)"/></td>
			<td><input id = "emlId<%=i %>" value="<%=empId %>" disabled="disabled" readonly="readonly"/></td>
			<td><input id = "empName<%=i %>" value="<%=empFirstName %><%= empLastName %>" disabled="disabled" readonly="readonly"/></td>
			<td><input id = "emplLeaveFrom<%=i %>" value="<%=empLeaveFrom %>" disabled="disabled" readonly="readonly"/></td>
			<td><input id = "emplLeaveTo<%=i %>" value="<%=empLeaveTo %>" disabled="disabled" readonly="readonly"/></td>
			<td><input id = "emplType<%=i %>" value="<%=empLeaveType %>" disabled="disabled" readonly="readonly"/></td>
			<td><select id = "isApproved<%=i %>" disabled="disabled">
				<option value="A" selected="selected">Approve</option>
				<option value="R" >Reject</option>
				</select>
			</td>
		</tr>
		
	<%} %>
	<tr align="center">
		<td colspan="9"><input type="submit" id="submit" name="submit" value="Submit" disabled="disabled"/></td>
	</tr>
	<%}else{
		%>
		<table width="80%"  cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%;border: 1px solid black;">
		<tr><td align="center"><b>No Pending Records.</b></td></tr>
		</table>
		
	<%}
	}else{
	
		List<String> inputParam = new ArrayList();
		inputParam.add(emlAppId);
		inputParam.add(isApproved);
		inputParam.add(loginId);
		inputParam.add(emlId);
		
		result = leaveDomain.updateEmpLeaveDetail(inputParam);
		%>
		<table width="80%"  cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%;border: 1px solid black;">
		<%
		if(1 == result){
		%>
				<tr>
					<td align="center"><b>Approved Successfully.</b></td>
				</tr>

		<%
		}else{

		%>
				<tr>
					<td align="center"><b style="color:red;"> Error Occured. Please Try Again.</b></td>
				</tr>
				<%} %>
		</table>
	<%}%>
	
</table>
</td>
</tr>
</table>
</form>



</form>

</body>
</html>