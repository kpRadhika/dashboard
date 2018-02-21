<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../SessionManager.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login title</title>


<script type="text/javascript">

	function check()
	{
		document.getElementById("errordiv").innerHTML='';
	  if(document.getElementById("userId").value=="")
	   {
		 document.getElementById("errordiv").innerHTML='Enter User ID';
		 document.getElementById("userId").focus();
	  return false;
	   }
	   else if (document.getElementById("userPassword").value=="")
	   {
		 document.getElementById("errordiv").innerHTML='Enter Password';
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
  height: 155px;
  margin: 20px auto 0;
  width: 298px;
   box-shadow: inset 0px 1px 0px #272928, 0px 5px 0px 0px #504f54, 12px 15px 10px #999;
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


input[type=submit]:hover {
    opacity: 0.8;
}
#loginform{
	text-align: center;
}

</style>



</head>
<body onload="setFocus()">
<%
response.setHeader( "Set-Cookie", "JSESSIONID="+session.getId()+"; HttpOnly; Path=/dashboard/");
%>

<div id="loginform">
	<form action="<%=request.getContextPath()%>/login" method="post"
		autocomplete="off">


			
			<img src="<%=request.getContextPath()%>/images/Parinati_white_logo.png"
						style="align: center;" />
						<div class="login">
					
					<input type="text" name="userId" id="userId" placeholder="User ID"/>
				
					<input type="password" name="userPassword" id="userPassword" placeholder="Password" />
					<span id="errordiv" style="font-size: 15px; color: #FF0000"
							align="center">
							<%
					if(request.getParameter("result")!=null){
					%>

							Invalid UserName and PassWord
							<%	}
				%>

						</span>
						<input type="submit" class="formbuttons" value="Login" onClick="return check()" />
						
					</div>

		

	</form>
	</div>
</body>
</html>