<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../SessionManager.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login title</title>


<script type="text/javascript">

	function check()
	{
	  if(document.getElementById("userId").value=="")
	   {
		 document.getElementById("lbl").innerHTML='Enter User ID';
		 document.getElementById("userId").focus();
	  return false;
	   }
	   else if (document.getElementById("userPassword").value=="")
	   {
		 document.getElementById("lbl").innerHTML='Enter Password';
	     document.getElementById("userPassword").focus();
	   return false;
	   }

	  else{
	  return true;
	  }
	}


	function setFocus()
	{
		document.getElementById("userId").focus();

	}


</script>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
	background-color: #FFF;
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
<body onload="setFocus()">
<%
response.setHeader( "Set-Cookie", "JSESSIONID="+session.getId()+"; HttpOnly; Path=/dashboard/");
%>


	<form action="<%=request.getContextPath()%>/login" method="post"
		autocomplete="off">
		<div>


			<table cellpadding="1" cellspacing="1" width="100%" align="center">

				<tr>
					<th><img src="<%=request.getContextPath()%>/images/Parinati_white_logo.jpg"
						style="width: 25% align: center;" /></th>

				</tr>
			</table>



			<br> <br> <br> <br> <br> <br> <br>
			<br>


			<table cellpadding="3" cellspacing="3" width="30%" align="center">



				<tr bgcolor="#ffC30B">
					<td align="center" style="font-size: 20px; color: white;">
						Login</td>

				</tr>

				<tr>

					<td align="center" style="font-size: 15px;">User ID
						&nbsp;&nbsp; <input type="text" name="userId" id="userId" value="" />
					</td>
				</tr>

				<tr>

					<td align="center" style="font-size: 15px;">Password <input
						type="password" name="userPassword" id="userPassword" value=""
						style="margin-left: 3px;" />
					</td>
				</tr>

				<tr>
					<td align="center"><input type="submit" value="Login"
						onClick="return check()" />&emsp; <input type="reset"
						value="Reset" /></td>
				</tr>

				<tr>

					<td colspan="2"><div id="lbl1" style="font-size: 15px; color: #FF0000"
							align="center">
							<%
					if(request.getParameter("result")!=null){
					%>

							Invalid UserName and PassWord
							<%	}
				%>

						</div>
						<div id="lbl" style="font-size: 15px; color: #FF0000"
							align="center"></div>
					</td>
				</tr>

			</table>

		</div>
	</form>
</body>
</html>