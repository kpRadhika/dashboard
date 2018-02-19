<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="../commonInclude.jsp" %>
<jsp:useBean id="createUser" class="com.parinati.admin.CreateUserDomain" scope="page"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type = "text/javascript" src = "scripts/createEmployee.js"></script>
<style>
.Button{
border-radius: 15px; 
/* border:none; */
font-family: Trebuchet-MS;
font-size:Medium;
padding : 3px 20px 3px 20px;
background: linear-gradient(to top, darkgray, whitesmoke ); 
}

</style>
</head>
<body>
<table width="100%" align="center">
<tr class="tableheader">
			<td colspan="3">Create Employee</td>
</tr>
<tr>
<td>
<%
String submitClicked = request.getParameter("subBtn")==null?"":(String)request.getParameter("subBtn");
String fromDate = request.getParameter("fromDate")==null?"":(String)request.getParameter("fromDate");
String toDate = request.getParameter("toDate")==null?"":(String)request.getParameter("toDate");
%>
<form id = "createEmployee" action="createEmployee.jsp" method="post">
<table width="80%" align="center">
<tr>
<td>From Date<span class="required"></span></td>
<td><input type="text" id="fromDate" name="fromDate" value="<%=fromDate %>"/></td>
<td>To Date<span class="required"></span></td>
<td><input type="text" id="toDate" name="toDate" value="<%=toDate %>"/></td>
</tr>
<tr>
<td></td>
<td align="right" ><input type="submit" id="subBtn" name="subBtn" value="Submit"/></td>
<td align="left" ><a href="createEmployee.jsp" style="text-decoration:none;"><input type="button" class="Button" id="resetBtn" name="resetBtn" value="Reset"/></a></td>
</tr>
</table>
<br>
</form>
<br>
<%
if(!submitClicked.isEmpty()){
List candidateDetails = createUser.getCandidateDetails(fromDate,toDate);
if(candidateDetails !=null && !candidateDetails.isEmpty()){
%>
<form action="CreateEmployeeAction.jsp" id="createEmpl" method="post">
<table id = "tbl" class="zebra" align="center" width="80%">
<tr class="tableheader" >
<td>Modify</td>
<td>Candidate/Emp Id</td>
<td>First Name</td>
<td>Experience</td>
<td>Skills</td>
<td>Interview Date</td>

</tr>
<%
String emplId = null;
		for(int i=0; i<candidateDetails.size(); i++)
		{
			 ArrayList details=(ArrayList)candidateDetails.get(i);
			String candidateId = details.get(0).toString().trim();
			String firstName = details.get(1).toString().trim();
			String exp = details.get(2).toString().trim();
			String Skills = details.get(3).toString().trim();
			String interviewDate = details.get(4).toString().trim();
			/* String stepCompleted = details.get(5).toString().trim();
			String nextStepDesc = details.get(6).toString().trim(); */
			/* if(details.size() > 6){
				emplId = details.get(7).toString().trim();
			} */
	%>
	<tr>
		<td><input type="radio" id="candSel" name="candSel" value="<%=candidateId%>" /></td>
		<td><%=candidateId%></td>
		<td><%=firstName %></td>
		<td><%=exp %></td>
		<td><%=Skills %></td>
		<td><%=interviewDate %></td>
	</tr>

<%}%>
<tr align="center"><td colspan="6"><button type="button" id ="subbutton" name="subbutton" disabled="disabled" onclick="performNextStep()" value="">Onboard</button></td></tr>
</table>
<div id="modal" align="center" class="overlay" style="border: 1px solid #0199CD; text-align: center; display: none; ">
<table class="overlay-content" style="background-color: #ffC30B;" width="50%">
<tr>
<th>Date of joining</th><td><input type="text" id="doj" name="doj" value=""/></td></tr>
<tr style="font-size: 50%; font-weight: bold;">
<th>Employee Role</th><td><Select id="role" name="role">
<option value="">Select</option>
<option value="7">TRAINEE</option>
<option value="6">JUNIOR DEVELOPER</option>
<option value="5">DEVELOPER</option>
<option value="4">SENIOR DEVELOPER</option>
<option value="3">TEAM LEAD</option>
<option value="3">TEAM LEAD</option>
<option value="2">PROJECT MANAGER</option>
<option value="1">HR</option>
</Select>
</td>
</tr>
<tr>
<td colspan="2"><input type="submit" id="popUpSub" name="popUpSub" value="Submit" onclick="popUpSubmit()"/></td>
</tr>
</table>
</div>
</form>
<% 
}else{
	%>
	<table width="50%" border="0" cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%">
	<tr>
				<td align="center"><b>No Record Found</b></td>
			</tr>
			</table>
	<%
}
}
%>
</td>
</tr>
</table>
</body>
</html>