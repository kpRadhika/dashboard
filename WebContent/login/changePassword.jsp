<%@page import="com.parinati.util.GenericUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="loginsDomain" scope="session" class="com.parinati.userLogin.LoginDomain" />

<%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<%@include file="../commonInclude.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">

	function check()
	{
		document.getElementById("errorNewdiv").innerHTML='';
		document.getElementById("errorConfirmdiv").innerHTML='';
	 if (document.getElementById("newPassword").value=="")
	   {
		 	document.getElementById("errorNewdiv").innerHTML='Enter new Password';
	     	document.getElementById("newPassword").focus();
	   		return false;
	   } else if (document.getElementById("confirmPassword").value=="")
	   {
			document.getElementById("errorConfirmdiv").innerHTML='Enter confirm Password';
		   	document.getElementById("confirmPassword").focus();
		   	return false;
		}else if(document.getElementById("confirmPassword").value != document.getElementById("newPassword").value){
			document.getElementById("errorConfirmdiv").innerHTML='Password MissMatch Please enter again ';
			document.getElementById("newPassword").focus();
			return false;
		}
		else
		{
	  		return true;
	  	}
	}


	function setFocus()
	{
		document.getElementById("userId").focus();

	}


</script>
<style >
 

.error {
    color:#FF0000;  /* red */
}

body {
	margin: 0;
	padding: 0;
	width:100%;
	height:100%;
	background-colorF: #FFF;
}


#loginform{
	text-align: center;
}

</style>
</head>
<body onload="setFocus()">

<table width="80%" align="center" style="background: radial-gradient(ellipse at top,lavender,white );">
<tr><td class="tableheader">Change Password</td></tr>
<%
String submitClicked = GenericUtil.setValue(request.getParameter("subBtn"));
String newPassword = GenericUtil.setValue(request.getParameter("newPassword"));
String confirmPassword = GenericUtil.setValue(request.getParameter("confirmPassword"));
String userId = (String)session.getAttribute("userID");

if(submitClicked.isEmpty()){
%>
<tr><td>
	<form action="changePassword.jsp" id="forgotPassword" autocomplete="off">
				<table align="center" width="50%" style="background-color: white">
				<tr align="center"><td>New Password<span class="required"></span></td>
				<td>
					<input type="password" name="newPassword" id="newPassword"/>
					<span id="errorNewdiv" style="font-size: 15px; color: #FF0000" align="center"></span>
				</td>
				</tr>
				<tr align="center"><td>Confirm Password<span class="required"></span></td>
				<td>
					<input type="password" name="confirmPassword" id="confirmPassword"/>
					<span id="errorConfirmdiv" style="font-size: 15px; color: #FF0000" align="center"></span>
					<br>
				</td>
				</tr>
				<tr align="center"><td colspan="2">
					<input type="submit" name="subBtn" value="Update" onclick="return check()"/>
				</td></tr>
				</table>
	</form>
	</td></tr>
<%
}else{

int resultVal = 0;
	List<String> inputParam = new ArrayList();
	inputParam.add(userId);
	inputParam.add(newPassword);
	resultVal = loginsDomain.updatePasswordDetails(inputParam);
	
%>

<table width="80%"  cellspacing="1" cellpadding="2" align="center" style="margin-top: 1%;border: 1px solid #ccc">
	<%
	if(1 == resultVal){
	%>
			<tr>
				<td  align="center"><b>Password Updated Successfully. Go to Home page<a href="login/Logout.jsp">Click Here</a></b></td>
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
	</table>
</body>
</html>