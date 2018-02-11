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
<table width="50%" class="zebra">
			</br>
			<tr>
			<th style="text-align: left;" colspan="3">Search Employee</th>
			</tr>
			
			<tr >
			<td>Search By &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;:&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
			<input type = "radio" id="name" name = "viewModify" style="padding-left : 15px" value="name" <% if("name".equals(radioButtonVal)) {%> checked = "checked" <%} %>>First Name
			&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;<input type = "radio" id="skills" name= "viewModify" style="padding-left : 15px" value="projectName" <% if("projectName".equals(radioButtonVal)) {%> checked = "checked" <%} %>>Project Name</td>
			</tr>
		</table>
		<br/>

		<table width="50%" id="searchOption" >
			<tr>
				<td><label>Search Name</label></td>
				<td><input type="text" name ="searchText" id="searchText" value="<%= searchText%>">
				<div id="searchErrorMsg" style="display: none; color: red;" ></div>
				<input type="submit" name="search" value="search" id="search" onclick="return formSubmit();" align="left">
				</td>

			</tr>

		</table>

		 <table width="50%" id="projectOption" >
			<tr>
				<td><label>Project Name<span class="required"></span></label></td>
				<td><select name="projectDropDown" id="projectDropDown">
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
					</td>
			  </tr>			  
		</table>
		<input type="hidden" name="projectDropDown" value="<%=projectDropDownVal.trim()%>"/>
		</form>
		<br><br><br><br>
		<form id = "viewModifyEmolyeeForm" action="viewModifyEmployee.jsp" >
<%if(!search.equalsIgnoreCase(""))
{
	%>
	<hr width="100%" id="hrLine" />
	<%
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

		<table align="center" width="100%">
		<tr align="center" bgcolor="#f2f2f2">
		<th>Select</th><th>Id</th><th>Name</th><th>Phone No.</th><th>PAN No.</th><th>Aadhar No.</th><th>Passport No.</th><th>Skills</th><th>Status</th>
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
		<td align="center" ><input type="radio" id="candSel<%=i %>" name="candSel" value="<%=employeeId%>" class="radioCheck" onclick="enableDisable(<%=i%>)"/></td>
		<td align="center" ><%=employeeId%></td>
		<td align="center" ><%=firstName %> <%=lastName %></td>
		<td align="center" ><input  class="labelstyle" type = "text" id = "phone<%=i %>" value="<%=phone %>"  disabled="disabled"/></td>
		<td align="center" ><input  class="labelstyle" type = "text" id = "panno<%=i %>" value="<%=panno %>"  disabled="disabled"/></td>
		<td align="center" ><input  class="labelstyle" type = "text" id = "aadharNo<%=i %>" value="<%=aadharNo %>"  disabled="disabled"/></td>
		<td align="center" ><input  class="labelstyle" type = "text" id = "passportNo<%=i %>" value="<%=passportNo %>" disabled="disabled"/></td>
		<td align="center" ><input  class="labelstyle" type = "text" id = "skills<%=i %>" value="<%=skills %>" disabled="disabled"/></td>
		<td align="center" ><select id = "isActive<%=i %>" disabled="disabled">
		<%if(isActive!=null && isActive.equalsIgnoreCase("Y")){ %>
		<option value="Y" selected="selected">Yes</option>
		<option value="N" >No</option>
		<%}else { %>
		<option value="Y" >Yes</option>
		<option value="N" selected="selected">No</option>
		<%} %>
		</select>
		<%-- 
		<input style="width: 5%" type = "text" id = "isActive<%=i %>" value="<%=isActive %>" disabled="disabled"/></td>
 --%>
	</tr>

<%}%>
</table>
<table  width="50%" border="0" cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%">
	<tr >
		<td align="center"><input type="submit" id="submit" name="submit" value="Submit" onclick = "validateFormData();" disabled="disabled"/></td>
		<!-- <td align="left"><input type="reset" id="reset" name="reset" value="Reset"/></td> -->
	</tr>
</table>

<input type="hidden" name="employeeId" value="<%=employeeId %>"/>
		<%}
	else{
		%>
		<table width="50%" border="0" cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%">
		<tr>
					<td align="center"><b>No Record Found</b></td>
				</tr>
				</table>
		<%
	}
}

}else{
	%>
	<table width="50%" border="0" cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%">
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
</body>
</html>