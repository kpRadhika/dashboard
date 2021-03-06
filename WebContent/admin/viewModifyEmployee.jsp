<%@page import="com.parinati.util.GenericUtil"%>
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
			<td colspan="3">Update Employee Details</td>
</tr>
<tr>
<td>
<%
int result = 0;
String search = GenericUtil.setValue(request.getParameter("search"));
String searchValue = GenericUtil.setValue(request.getParameter("searchText"));
String radioButtonVal = GenericUtil.setValue(request.getParameter("viewModify"));
String projectDropDownVal = GenericUtil.setValue(request.getParameter("projectDropDown"));
String searchText = GenericUtil.setValue(request.getParameter("searchText"));
String submitVal = GenericUtil.setValue(request.getParameter("submit"));
if(!"".equalsIgnoreCase(submitVal)){
	String phoneNo = GenericUtil.setValue(request.getParameter("phone"));
	String panNo = GenericUtil.setValue(request.getParameter("panno"));
	String aadharNumber = GenericUtil.setValue(request.getParameter("aadharNo"));
	String passportNumber = GenericUtil.setValue(request.getParameter("passportNo"));
	String newSkills = GenericUtil.setValue(request.getParameter("skills"));
	String newIsActive = GenericUtil.setValue(request.getParameter("isActive"));
	String employeeId = GenericUtil.setValue(request.getParameter("candSel"));
	String role = GenericUtil.setValue(request.getParameter("role"));
	String projectId = GenericUtil.setValue(request.getParameter("projectName"));

	List inputParam = new ArrayList();
	inputParam.add(phoneNo);
	inputParam.add(panNo);
	inputParam.add(aadharNumber);
	inputParam.add(passportNumber);
	inputParam.add(newSkills);
	inputParam.add(newIsActive);
	inputParam.add(Integer.parseInt(employeeId));
	inputParam.add(Integer.parseInt(role));
	inputParam.add(Integer.parseInt(projectId));
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
		List roleDetails = employeeDomain.fetchEmplRoles();
		List projectDetails = employeeDomain.fetchProjectDetails();
	%>

<div id="empltable" style="border: 1px solid silver; margin: auto; width: 80%; height: 260px; vertical: 20px; overflow-y: scroll; overflow-x: scroll;">
		<table style= "width: 100%;border: none;" id="empltable" class="tableProps">
		<tr align="center">
		<th>Select</th>
		<th>Id</th>
		<th>Name</th>
		<th>Phone No.</th>
		<th>PAN No.</th><th>Aadhar No.</th>
		<th>Passport No.</th><th>Skills</th>
		<th>Status</th>
		<th>Role</th>
		<th>Project Name</th>
		</tr>
		<%
		String employeeId = null;
		for(int i=0; i<viewDetails.size(); i++)
		{
			 ArrayList details=(ArrayList)viewDetails.get(i);
			employeeId = GenericUtil.setValue((String)details.get(0));
			String firstName = GenericUtil.setValue((String)details.get(1));
			String lastName = GenericUtil.setValue((String)details.get(2));
			String phone = GenericUtil.setValue((String)details.get(3));
			String panno = GenericUtil.setValue((String)details.get(4));
			String aadharNo = GenericUtil.setValue((String)details.get(5));
			String passportNo = GenericUtil.setValue((String)details.get(6));
			String skills = GenericUtil.setValue((String)details.get(7));
			String isActive = GenericUtil.setValue((String)details.get(8));
			String role = GenericUtil.setValue((String)details.get(9));
			String projectID = GenericUtil.setValue((String)details.get(10));
	%>
	<tr>
		<td ><input type="radio" id="candSel<%=i %>" name="candSel" value="<%=employeeId%>" class="radioCheck" onclick="enableDisable(<%=i%>)"/></td>
		<td ><%=employeeId%></td>
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
		</select></td>
		<td><select style="width: 100%;" id = "role<%=i %>" disabled="disabled"/>
		<%for(int k=0;k<roleDetails.size();k++){
			List recordsSelect =new ArrayList();
			recordsSelect=(ArrayList)roleDetails.get(k);
			String roleId = recordsSelect.get(0) == null ? "" :recordsSelect.get(0).toString();
			String roleDesc = recordsSelect.get(1) == null ? "" :recordsSelect.get(1).toString();
			if(role.equals(roleId)){

		%>
		<option value="<%=roleId%>" selected="selected"><%=roleDesc %></option>

		<%}else{ %>
		<option value="<%=roleId%>" ><%= roleDesc%></option>
		<%}
			}%>
		</select>
		</td>
		<td><select style="width: 100%;" id = "projectName<%=i %>" disabled="disabled"/>
		<%
		if(projectID.isEmpty()){
			%>
			<option value="" selected="selected">Please Select</option>
			<%
		}
		for(int k=0;k<projectDetails.size();k++){
			List recordsSelect =new ArrayList();
			recordsSelect=(ArrayList)projectDetails.get(k);
			String projectId = recordsSelect.get(0) == null ? "" :recordsSelect.get(0).toString();
			String projectDesc = recordsSelect.get(1) == null ? "" :recordsSelect.get(1).toString();

			if(projectID.equals(projectId)){

		%>
		<option value="<%=projectId%>" selected="selected"><%=projectDesc %></option>

		<%}else{ %>
		<option value="<%=projectId%>" ><%= projectDesc%></option>
		<%}
			}%>
		</select>
		</td>
	</tr>
	</div>
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
	<table width="80%"  cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%;border: 1px solid #ccc">
	<%
	if(1 == result){
	%>
			<tr>
				<td align="center"><b>Employee modified Successfully.</b></td>
			</tr>

	<%
	}else{

	%>
			<tr>
				<td align="center"><b style="color:red;"> Error Occured. Please Try Again.</b></td>
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