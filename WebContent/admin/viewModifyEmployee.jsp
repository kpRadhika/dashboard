<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="employeeDomain" scope="session" class="com.parinati.admin.CreateEmployeeDomain" />
<%@include file="../commonInclude.jsp" %>
  <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>view/Modify Candidate</title>
<script type = "text/javascript" src = "scripts/viewModifyEmployee.js"></script>
<style type="text/css">

.tableProps{
width:80%;
table-layout: fixed;
align:center;
}

.tableProps td{
width:10%;
}
.tableProps input[type=text]{
width:90%;
}

label.error{
font-family:    verdana,times new roman;
font-size:      13px;
color:          red;
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
    /* border:2px; */
}

</style>

</head>

<body>
<table width="100%" align="center">
<tr class="tableheader">
			<td colspan="3">Search Employee</td>
</tr>
<tr>
<td>
<%
int result = 0;
String search = request.getParameter("search")== null ? "": request.getParameter("search");
String searchValue = request.getParameter("searchText")== null ? "": request.getParameter("searchText");
String radioButtonVal = request.getParameter("viewModify")== null ? "": request.getParameter("viewModify");
String projectDropDownVal = request.getParameter("projectDropDown")== null ? "": request.getParameter("projectDropDown");
String searchText = request.getParameter("searchText")== null ? "": request.getParameter("searchText");
String submitVal = request.getParameter("submit")== null ? "": request.getParameter("submit");
if(!"".equalsIgnoreCase(submitVal)){
	String phoneNo = request.getParameter("phone")== null ? "": request.getParameter("phone");
	String panNo = request.getParameter("panno")== null ? "": request.getParameter("panno");
	String aadharNumber = request.getParameter("aadharNo")== null ? "": request.getParameter("aadharNo");
	String passportNumber = request.getParameter("passportNo")== null ? "": request.getParameter("passportNo");
	String newSkills = request.getParameter("skills")== null ? "": request.getParameter("skills");
	String newIsActive = request.getParameter("isActive")== null ? "": request.getParameter("isActive");
	String employeeId = request.getParameter("candSel")== null ? "": request.getParameter("candSel");

	List inputParam = new ArrayList();
	inputParam.add(phoneNo);
	inputParam.add(panNo);
	inputParam.add(aadharNumber);
	inputParam.add(passportNumber);
	inputParam.add(newSkills);
	inputParam.add(newIsActive);
	//inputParam.add(projectDropDownVal);
	inputParam.add(Integer.parseInt(employeeId));
	 result = employeeDomain.updateEmployeeDetails(inputParam);

}
if(result != 1 && "".equalsIgnoreCase(submitVal)){
%>

<form method="post" name = "viewModifys" id="viewModifys" action="viewModifyEmployee.jsp" >
<table width="80%" align="center">			
			<tr >
			<td>Search By &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;:&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
			<input type = "radio" id="name" name = "viewModify" style="padding-left : 15px" value="name" <% if("name".equals(radioButtonVal)) {%> checked = "checked" <%} %>>First Name
			&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;<input type = "radio" id="skills" name= "viewModify" style="padding-left : 15px" value="projectName" <% if("projectName".equals(radioButtonVal)) {%> checked = "checked" <%} %>>Project Name
			</td>
			</tr>
			<tr>
			<td>
			<div width="80%" id="searchOption" style="display: none">
			<label>Search Name<span class="required"></span>&nbsp;&nbsp;:</label>
			<input type="text" name ="searchText" id="searchText" value="<%= searchText%>">
			<div id="searchErrorMsg" style="display: none; color: red;" ></div>
			<input type="submit" name="search" value="search" id="search" onclick="return formSubmit();" align="left">
			</div>
				</td>

			</tr>

			<tr><td>
		 <div width="80%" id="projectOption" style="display: none">
				<label>Project Name<span class="required"></span>&nbsp;&nbsp;:</label>
				<select name="projectDropDown" id="projectDropDown">
						<option value="">Select</option>
						<%
							 if(projectDropDownVal!=null && !"".equalsIgnoreCase(projectDropDownVal))
							 {

						%>

						<option value="<%=projectDropDownVal.trim()%>" selected="selected"></option>

						<%
							}
						%>
				    </select>
				    <div id="projectNameError" style="display: none; color: red;" ></div>
				    <input type="submit" name="search" value="search" id="search" onclick="return formSubmit();" align="left">
							  
		</div>
			</td></tr>
		</table>
		<br/>

		
		<input type="hidden" name="projectDropDown" value="<%=projectDropDownVal.trim()%>"/>
		</form>
		<br>
		<form id = "viewModifyEmolyeeForm" action="viewModifyEmployee.jsp" >
<%if(!search.equalsIgnoreCase(""))
{
	ArrayList inputParam = new ArrayList();
	if(!"".equals(searchValue))
		inputParam.add(searchValue);
	if(!"".equals(projectDropDownVal))
		inputParam.add(projectDropDownVal);

	inputParam.add(radioButtonVal);

	 List viewDetails = employeeDomain.fetchEmployeeRecords(inputParam);

	if(viewDetails != null && !viewDetails.isEmpty())
	{
	%>

		<table align="center" id="empltable" class="tableProps">
		<tr align="center" class="tableheader">
		<td style="width:5%">Select</td>
		<td style="width:5%">Id</td>
		<td>Name</td>
		<td>Phone No.</td>
		<td>PAN No.</td><td>Aadhar No.</td>
		<td>Passport No.</td><td>Skills</td>
		<td>Status</td>
		</tr>
		<%
		String employeeId = null;
		for(int i=0; i<viewDetails.size(); i++)
		{
			 ArrayList details=(ArrayList)viewDetails.get(i);
			employeeId = details.get(0).toString().trim();
			String firstName = details.get(1).toString().trim();
			String lastName = details.get(2).toString().trim();
			String phone = details.get(3).toString().trim();
			String panno = details.get(4) == null ? "" : details.get(4).toString().trim();
			String aadharNo = details.get(5) == null ? "" : details.get(5).toString().trim();
			String passportNo = details.get(6) == null ? "" : details.get(6).toString().trim();
			String skills = details.get(7).toString().trim();
			String isActive = details.get(8).toString().trim();
	%>
	<tr>
		<td style="width:5%"><input type="radio" id="candSel<%=i %>" name="candSel" value="<%=employeeId%>" class="radioCheck" onclick="enableDisable(<%=i%>)"/></td>
		<td style="width:5%"><%=employeeId%></td>
		<td><label><%=firstName+" "+lastName %></label></td>
		<td><input  type = "text" id = "phone<%=i %>" value="<%=phone %>"  disabled="disabled"/></td>
		<td><input  type = "text" id = "panno<%=i %>" value="<%=panno %>"  disabled="disabled"/></td>
		<td><input  type = "text" id = "aadharNo<%=i %>" value="<%=aadharNo %>"  disabled="disabled"/></td>
		<td><input  type = "text" id = "passportNo<%=i %>" value="<%=passportNo %>" disabled="disabled"/></td>
		<td><input  type = "text" id = "skills<%=i %>" value="<%=skills %>" disabled="disabled"/></td>
		<td><select id = "isActive<%=i %>" disabled="disabled">
		<%if(isActive!=null && isActive.equalsIgnoreCase("Y")){ %>
		<option value="Y" selected="selected">Yes</option>
		<option value="N" >No</option>
		<%}else { %>
		<option value="Y" >Yes</option>
		<option value="N" selected="selected">No</option>
		<%} %>
		</select>
	</tr>
<%}%>
<tr align="center">
		<td colspan="9"><input type="submit" id="submit" name="submit" value="Submit" onclick = "validateFormData();" disabled="disabled"/></td>
	</tr>
</table>
<input type="hidden" name="employeeId" value="<%=employeeId %>"/>
		<%}
	else{
		%>
		<table width="80%" border="0" cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%">
		<tr>
					<td align="center"><b>No Record Found</b></td>
				</tr>
				</table>
		<%
	}
}

}else{
	%>
	<table width="80%"  cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%;border: none">
	<%
	if(1 == result){
	%>
			<tr>
				<td><b>Employee modified Successfully.</b></td>
			</tr>

	<%
	}else{

	%>
			<tr>
				<td ><b style="color:red;"> Error Occured. Please Try Again.</b></td>
			</tr>
	</table>
	<%
	}

}
%>
</form>
</td>
</tr>
</table>
</body>
</html>