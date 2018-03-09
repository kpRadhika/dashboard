<%@ page language="java"  contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="userDomain" scope="session" class="com.parinati.admin.CreateUserDomain" />
<%@include file="../commonInclude.jsp" %>
  <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>view/Modify Candidate</title>
<script type = "text/javascript" src = "scripts/viewModifyCandidate.js"></script>
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
    border:none;
}
</style>

</head>

<body>
<%
response.setHeader( "Set-Cookie", "name=value; HttpOnly");

         response.addHeader("Pragma", "No-cache");
         response.setHeader("Cache-Control", "no-cache");
	  response.setHeader("Cache-Control", "no-store");
         response.setDateHeader("Expires",0);
String search = request.getParameter("search")== null ? "": request.getParameter("search");
String searchValue = request.getParameter("searchText")== null ? "": request.getParameter("searchText");
String interDate = request.getParameter("interdate")== null ? "": request.getParameter("interdate");
if(searchValue.isEmpty())
 searchValue = request.getParameter("interdate")== null ? "": request.getParameter("interdate");
String radioButtonVal = request.getParameter("viewModify")== null ? "": request.getParameter("viewModify");
%>
<table width="100%" align="center">
<tr class="tableheader"><td>Search Candidate</td></tr>
<tr>
<td>
<form method="post" action="viewModifyCandidate.jsp" >
<table width="80%" border="0" align="center" style="background: radial-gradient(ellipse at top,lavender,white );">

			<tr >
			<td>Search Candidate By:</td>
				<td><input type = "radio" id="name" name = "viewModify" value="name" <%if("name".equals(radioButtonVal)) {%>checked<%} %>>Name</td>
				<td><input type = "radio" id ="candidateId" name = "viewModify" value="candidateId" <%if("candidateId".equals(radioButtonVal)) {%>checked<%} %>>Candidate ID</td>
				<td><input type = "radio" id="skills" name= "viewModify" value="skills" <%if("skills".equals(radioButtonVal)) {%>checked<%} %>>Skills</td>
				<td><input type = "radio" id="interviewDate" name= "viewModify" value="InterviewDate" <%if("InterviewDate".equals(radioButtonVal)) {%>checked<%} %>>Interview Date</td>
			</tr>
			<tr>
			<td colspan="5">
			<table width="80%"  align="left" style="border: 0" id="searchOption" >
			<tr>
				<td>Search Value</td>
				<td><input type="text" name ="searchText" id="searchText" value="<%= searchValue%>" ><div id="searchErrorMsg" style = "display: none; color: red;"></div>
				<input type="submit" name="search" value="search" id="search" align="left" onclick="return TextValidation()">
				</td>
			</tr>
		</table>
		<table width="80%" align="left" style="border:0" id="dateSelection" >
			<tr>
				<td>Search Date</td>
				<td><input type="text" name ="interdate" id="interdate" value = "<%=interDate %>"><div id="dateErrorMsg" style = "display: none; color: red;"></div>
				<input type="submit" name="search" value="search" id="search" align="left" onclick="return TextValidation()">
				</td>
			</tr>
		</table>
			</td>
			</tr>
		</table>

</form>
<br>
<form name="viewModifys" method = "post" id ="viewModifys" action="modifyCandidate.jsp">
<%if(!search.equalsIgnoreCase(""))
{
	 List viewDetails = userDomain.fetchRecords(searchValue,radioButtonVal);

	if(viewDetails != null && !viewDetails.isEmpty())
	{
	%>

		<table id = "candidateTbl" class="zebra" align="center" width="80%">
		<tr bgcolor="#ffC30B" style="font-weight: bold">
		<th>Candidate Id</th><th>First name</th><th>Skills</th><th>InterviewDate</th><th>Selection Status</th>
		</tr>
		<%
		for(int i=0; i<viewDetails.size(); i++)
		{
			 ArrayList details=(ArrayList)viewDetails.get(i);
			String candidateId = details.get(0).toString().trim();
			String firstName = details.get(1).toString().trim();
			String Skills = details.get(2).toString().trim();
			String interviewDate =details.get(3) == null ? "": details.get(3).toString().trim();
			String selectStatus = details.get(4).toString().trim();
	%>
	<tr>
		<td><button id ="link<%=i%>" name="link<%=i%>" onclick="modifyCandidate(<%=i %>)" value="<%=candidateId%>"><%=candidateId%></button></td>
		<td><%=firstName %></td><td><%=Skills %></td><td><%=interviewDate %></td><td><%=selectStatus.equalsIgnoreCase("N")?"NO":"YES" %></td>
	</tr>

<%}%>
</table>
<input type="hidden" id="count" name="count"/>

		<%}else{
			%>
			<table id = "candidateTbl" width="50%" border="0" cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%">
			<tr>
						<td align="center"><b>No Record Found</b></td>
					</tr>
					</table>
			<%
		}
}%>
</form>
</td>
</tr>
</table>
</body>
</html>