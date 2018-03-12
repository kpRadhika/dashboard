<%@page import="com.parinati.util.GenericUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="addProjectDomain" scope="session" class="com.parinati.admin.AddProjectDomain" />
<%@include file="../commonInclude.jsp" %>
<%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type = "text/javascript" src = "scripts/modifyProject.js"></script>
<style >
.Button{
border-radius: 15px;
font-family: Trebuchet-MS;
font-size:Medium;
padding : 3px 20px 3px 20px;
background: linear-gradient(to top, darkgray, whitesmoke );
}
.error {
    color:#FF0000;  /* red */
}
</style>
</head>
<body>
<%
String submitClicked = GenericUtil.setValue(request.getParameter("subBtn"));
String projectName = GenericUtil.setValue(request.getParameter("pname"));
String projectTech = GenericUtil.setValue(request.getParameter("ptech"));
String projectLocation = GenericUtil.setValue(request.getParameter("ploc"));
String projectDropDownVal = GenericUtil.setValue(request.getParameter("projectDropDown"));
if(submitClicked.isEmpty()){
%>
<form action="modifyProject.jsp" id="modifyProject">
<table width="80%" align="center" style="background: radial-gradient(ellipse at top,lavender,white );">
<tbody>
<tr class="tableheader"><td colspan="4">Modify Project</td></tr><tr></tr>
<tr>
	<th>Project Name</th>
	<th>Project Technology</th>
	<th>Project Location</th>
	<th>Project Lead</th>
	</tr>
	<tr>
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
				    </select></td>

	<td><input type="text" id="ptech" name="ptech" disabled="disabled"></td>

	<td><input type="text" id="ploc" name="ploc" disabled="disabled"></td>

	<td><select id="plead" name="plead" disabled="disabled">
	<option value="">-Please select-</option>
	</select>
<tr></tr>
<tr>
	<td colspan="2" align="center"><input type="submit" id="subBtn" name="subBtn" value="Submit">
	<a href="modifyProject.jsp" style="text-decoration:none;"><input type="button" class="Button" id="resBtn" name="resBtn" value="Reset"></a></td>
</tr>
</tbody>
</table>
</form>
<%
}else{
int resultVal = 0;
	List<String> inputParam = new ArrayList();
	inputParam.add(projectName);
	inputParam.add(projectTech);
	inputParam.add(projectLocation);

	resultVal = addProjectDomain.insertProjectDtls(inputParam);

%>

<table width="80%"  cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%;border: none">
	<%
	if(1 == resultVal){
	%>
			<tr>
				<td  align="center"><b>Project Added Successfully.</b></td>
			</tr>

	<%
	}else{

	%>
			<tr>
				<td align="center"><b style="color:red;"> Error Occured. Please Try Again.</b></td>
			</tr>
	</table>
	<%}
	}%>
</body>
</html>