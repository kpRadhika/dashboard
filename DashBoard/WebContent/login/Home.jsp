
<%
	if(session.getAttribute("userID")!=null){		
	%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CBI DASH BOARD ADMIN MODULE</title>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
	background-color: #D4DBF5;
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
</style>
</head>
<body>


	<div>
		<table cellpadding="1" cellspacing="1" width="100%" align="center">

			<tr>
				<th><img src="Images/logo.png" style="width: 100%;" /></th>

			</tr>
		</table>


		<div id="lbl" style="font-size: 15px; color: #FFFFFF" align="center">

			<table align="center" bgcolor="#1C81DF" width="100%">
				<tr>
					<td><a href="CreateUser.jsp" target="down"
						style="text-decoration: none; color: #FFFFFF"> Create User </a></td>
					<td><a href="pages/users.jsp" target="down"
						style="text-decoration: none; color: #FFFFFF"> Amend User </a></td>
					<td><a href="pages/resetpasswordusers.jsp" target="down"
						style="text-decoration: none; color: #FFFFFF"> Reset Password
					</a></td>
					<td align="right"><a href="pages/changepassword.jsp"
						target="down" style="text-decoration: none; color: #FFFFFF">
							Change Password </a></td>
					<td align="right"><a href="Logout.jsp"
						style="text-decoration: none; color: #FF0000"> Log Out </a></td>
				</tr>
			</table>

		</div>

	</div>

	<iframe name="down" width="100%" height="800" scrolling="auto"
		style="border: none;">

		<table align="center" bgcolor="#1C81DF" width="100%">
			<tr>
				<th>
					<div id="lbl" style="font-size: 15px; color: #FFFFFF"
						align="center" b>© All rights reserved to Central Bank of
						India , Powered By Parinati Solutions... copy rights 2013 reserved
						to Central Bank of India</div>
				</th>
			</tr>
		</table>
	</iframe>

</body>
</html>



<%
	}
	else{
		
	%>


<jsp:forward page="/Login.jsp"></jsp:forward>

<%		
		
	}
%>







