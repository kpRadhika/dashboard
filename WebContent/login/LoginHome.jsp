<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*,com.parinati.userLogin.*" %>
<jsp:useBean id="loginDomain" scope="session" class="com.parinati.userLogin.LoginDomain" />

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
.navbar {
  overflow: hidden;
  background-color: #FFC30B;
  font-family: Trebuchet-MS;
}

.logout{
 	float: right;
  	overflow: hidden;
}
.logout a{
	display:table-cell;
	padding: 12px 16px;
	}

.logout a:hover {
  background-color: #ddd;
  cursor:pointer;
}

/* The dropdown container */
.dropdown {
  float: left;
  overflow: hidden;
}

.dropdown a{
display:table-cell;
padding: 12px 16px;
}

/* Dropdown content (hidden by default) */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
  float: none;
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

/* Add a grey background color to dropdown links on hover */
.dropdown a:hover {
  background-color: #ddd;
  cursor:pointer;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
  display: block;
}
</style>
<script type="text/javascript">
function logout()
{
	window.document.location = "login/Logout.jsp";
}
</script>
</head>
<body>
<%String user = (String)session.getAttribute("userID");
if(user!=null) 
{ %>
<table width="100%">
<tr>
<td><img alt="" src="images/Parinati_white_logo.jpg"></td>
<td align="right"><h4>Welcome&nbsp;<%= user%></h4></td>
</tr>
</table>
<%
int roleId = Integer.parseInt((String)session.getAttribute("role"));
List<ArrayList> catList = loginDomain.findCategories(roleId);
Iterator catIter = catList.listIterator();
%>
<div class="navbar">

<%
while(catIter.hasNext()){
	String catName = (String)((ArrayList)catIter.next()).get(0);
	%>
	<div class="dropdown">
	<a><%=catName%></a>
	<%
	List<ArrayList> toolList = loginDomain.findToolsByRole(roleId,catName);
	%>
	<div class = "dropdown-content">
	<%
	Iterator toolIter = toolList.listIterator();
	while(toolIter.hasNext()){
		ArrayList toolDetails = (ArrayList)toolIter.next();
		String functionName = (String)toolDetails.get(0);
		String functionUrl = (String)toolDetails.get(1);
		%>
		<a href="<%=functionUrl%>" target="down"><%=functionName%></a>
		<%
	}
	%>
	</div></div>
	<%
}

%>
<div class="logout">
<a onclick="logout()">LOGOUT</a>
</div>
</div>

	<iframe name="down" width="100%" height="800" scrolling="auto"
		style="border: none;" align="left">

	</iframe>
<%} %>
</body>
</html>