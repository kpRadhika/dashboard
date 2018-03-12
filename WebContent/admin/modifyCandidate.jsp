<%@page import="com.parinati.util.GenericUtil"%>
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
<style >
.error {
    color:#FF0000;  /* red */
}
</style>
</head>
<body >
<form action="modifyCandidate.jsp" id = "modifyCandidateForm" method="post">
<%
String userId = GenericUtil.setValue((String)session.getAttribute("userID"));
String count = GenericUtil.setValue(request.getParameter("count"));
String candId = GenericUtil.setValue(request.getParameter("link"+count));
String save = GenericUtil.setValue(request.getParameter("saveBtn"));
if(!save.isEmpty()){
	String cId = GenericUtil.setValue(request.getParameter("cid"));
	String saveSkill = GenericUtil.setValue(request.getParameter("skills"));
	String saveInterviewDate = GenericUtil.setValue(request.getParameter("interviewDate"));
	String saveSelectStatus = GenericUtil.setValue(request.getParameter("selection"));
	List inputs = new ArrayList();
	inputs.add(saveSkill);
	inputs.add(saveSelectStatus);
	inputs.add(saveInterviewDate);
	inputs.add(userId);
	inputs.add(cId);
	int updateCount = userDomain.modifyCandidate(inputs);
	if(updateCount>0){
		%>
		<table width="80%"  cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%;border: none">
	
			<tr>
				<td  align="center"><b>Candidate id <%=cId %> updated successfully.</b></td>
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
if(!candId.isEmpty()){
List viewDetails = userDomain.fetchRecords(candId,"candidateId");
if(viewDetails != null && !viewDetails.isEmpty())
{
	%>
	<table align="center" width="50%">
	<tr><th colspan="2">Modify Candidate</th></tr>
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
		<tr><td><b>Candidate Id</b></td><td><input type="text" id="cid" name="cid" value="<%=candidateId %>"></td></tr>
		<tr><td><b>First Name</b></td><td><%=firstName %></td></tr>
		<tr><td><b>Skills</b></td><td><input id="skills" name="skills" value="<%=skills%>"/></td></tr>
		<tr><td><b>Interview Date</b></td><td><input id="interviewDate" name="interviewDate" type="text" value="<%=interviewDate%>"/></td></tr>
		<tr><td><b>Selection Status</b></td>
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
	<tr></tr><tr></tr><tr></tr><tr></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="Save" id="saveBtn" name="saveBtn"></td></tr>
	</table>
<%
}
}
%>

</form>
</body>
</html>