<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<jsp:useBean id="userDomain" scope="session" class="com.parinati.admin.CreateUserDomain" />
<%@include file="../commonInclude.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type = "text/javascript" src = "scripts/modifyCandidate.js"></script>
</head>
<body onload="zebraTR()">
<form action="modifyCandidate.jsp" method="post">
<%
String count = request.getParameter("count")==null?"":(String)request.getParameter("count");
String candId = request.getParameter("link"+count)==null?"":(String)request.getParameter("link"+count);
String save = request.getParameter("saveBtn")==null?"":(String)request.getParameter("saveBtn");
if(!save.isEmpty()){
	String cId = request.getParameter("cid")==null?"":(String)request.getParameter("cid");
	String saveSkill = request.getParameter("skills")==null?"":(String)request.getParameter("skills");
	String saveInterviewDate = request.getParameter("interviewDate")==null?"":(String)request.getParameter("interviewDate");
	String saveSelectStatus = request.getParameter("selection")==null?"":(String)request.getParameter("selection");
	List inputs = new ArrayList();
	inputs.add(saveSkill);
	inputs.add(saveInterviewDate);
	inputs.add(saveSelectStatus);
	inputs.add(cId);
	int updateCount = userDomain.modifyCandidate(inputs);
	if(updateCount>0){
		%>
		<div align="center" style="font-size: small;"><br><br><br><br><br><br><b> Candidate id <%=cId %> updated successfully</b></div>
		<%
	}
}
if(!candId.isEmpty()){
List viewDetails = userDomain.fetchRecords(candId,"candidateId");
if(viewDetails != null && !viewDetails.isEmpty())
{
	%>
	<table align="center" width="50%">
	<tr><td colspan="2" align="center" style="font-weight: bold; font-size: medium;">Modify Candidate</td></tr>
	<tr></tr><tr></tr><tr></tr>
	<%
	for(int i=0; i<viewDetails.size(); i++)
	{
		ArrayList details=(ArrayList)viewDetails.get(i);
		String candidateId = details.get(0).toString().trim();
		String firstName = details.get(1).toString().trim();
		String skills = details.get(2).toString().trim();
		String interviewDate = details.get(3).toString().trim();
		String selectStatus = details.get(4).toString().trim();
		String secStatus = selectStatus.equalsIgnoreCase("N")?"Y":"N";
		%>
		<tr><td style="font-weight: bold;">Candidate Id</td><td><input type="text" id="cid" name="cid" value="<%=candidateId %>"></td></tr>
		<tr><td style="font-weight: bold;">First Name</td><td><%=firstName %></td></tr>
		<tr><td style="font-weight: bold;">Skills</td><td><input id="skills" name="skills" value="<%=skills%>"/></td></tr>
		<tr><td style="font-weight: bold;">Interview Date</td><td><input id="interviewDate" name="interviewDate" type="text" value="<%=interviewDate%>"/></td></tr>
		<tr><td style="font-weight: bold;">Selection Status</td>
		<td>
			<select id="selection" name="selection">
				<option value="<%=selectStatus%>"><%=selectStatus.equalsIgnoreCase("N")?"NO":"YES"%></option>
				<option value="<%=secStatus %>"><%=secStatus.equalsIgnoreCase("N")?"NO":"YES"%></option>
			</select>
		</td>
		</tr>
		<%
	}
	%>
	<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="Save" id="saveBtn" name="saveBtn"></td></tr>
	</table>
<%
}
}
%>

</form>
</body>
</html>