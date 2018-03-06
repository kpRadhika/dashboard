<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="loginsDomain" scope="session" class="com.parinati.userLogin.LoginDomain" />

<%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">

	function check()
	{
		document.getElementById("errorUserdiv").innerHTML='';
		document.getElementById("errorNewdiv").innerHTML='';
		document.getElementById("errorConfirmdiv").innerHTML='';
	  if(document.getElementById("userId").value=="")
	   {
		 	document.getElementById("errorUserdiv").innerHTML='Enter User ID';
		 	document.getElementById("userId").focus();
	  		return false;
	   }
	   else if (document.getElementById("newPassword").value=="")
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

.footer {
	background-color: #1C81DF;
	font-size: 15px;
	color: #FFFFFF;
	clear: both;
	overflow: auto;
	bottom: 0;
	position: absolute;
	width: 100%;
}

.login {
	display:grid;
  background: #eceeee;
  border: 1px solid #42464b;
  border-radius: 6px;
  height: 200px;
  margin: 20px auto 0;
  width: 340px;
   box-shadow: inset 0px 1px 0px #272928, 0px 5px 0px 0px #504f54, 12px 15px 10px #999;
}
.formbuttons{
	width:80%;
  height:35px;
  display:block;
  font-family:Arial, "Helvetica", sans-serif;
  font-size:16px;
  font-weight:bold;
  color:#fff;
  text-decoration:none;
  text-transform:uppercase;
  text-align:center;
  text-shadow:1px 1px 0px #37a69b;
  padding-top:6px;
  margin: 0px 0px 0px 30px;
  cursor:pointer;
  border: none;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  border-bottom-right-radius: 5px;
  border-bottom-left-radius:5px;
}
input[type="submit"] {
  background-color: #4CAF50;
  box-shadow: inset 0px 1px 0px #0f6133, 0px 5px 0px 0px #37710c, 0px 10px 5px #999;
}
input[type=text], input[type=password] {
	height:70%;
    width: 80%;
    padding-left: 5px;
    margin: 10px 0px 0px 30px;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
    border-radius:10px 10px 10px 10px;
}
input[type="submit"] {
  background-color: #4CAF50;
  box-shadow: inset 0px 1px 0px #0f6133, 0px 5px 0px 0px #37710c, 0px 10px 5px #999;
}

input[type=submit]:hover {
    opacity: 0.8;
}
#loginform{
	text-align: center;
}
.bgimage{
top:0;
position:absolute;
background-size:cover;
background-image:url(images/Goa.jpg);
background-position:center;
z-index:-1;
width:100%;
height: 150%;
opacity: 0.2;
filter: alpha(opacity=20);

}
</style>
</head>
<body onload="setFocus()">
<div class="bgimage"></div>
<div><center><img src="<%=request.getContextPath()%>/images/Parinati_white_logo.png" /></center></div>
<%
String submitClicked = request.getParameter("subBtn")==null?"":(String)request.getParameter("subBtn");
String newPassword = request.getParameter("newPassword")==null?"":(String)request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword")==null?"":(String)request.getParameter("confirmPassword");
String userId = request.getParameter("userId")==null?"":(String)request.getParameter("userId");

if(submitClicked.isEmpty()){
%>

	<form action="forgotPassword.jsp" id="forgotPassword" autocomplete="off">
				<div class="login">
					<input type="text" name="userId" id="userId" placeholder="User ID"/>
					<span id="errorUserdiv" style="font-size: 15px; color: #FF0000" align="center"></span>
					<input type="password" name="newPassword" id="newPassword" placeholder="New Password" />
					<span id="errorNewdiv" style="font-size: 15px; color: #FF0000" align="center"></span>
					<input type="password" name="confirmPassword" id="confirmPassword" placeholder="confirm Password" />
					<span id="errorConfirmdiv" style="font-size: 15px; color: #FF0000" align="center"></span>
					<br>
					<input type="submit" name="subBtn" class="formbuttons" value="Reset" onclick="return check()"/>
				</div>
	</form>
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
</body>
</html>