<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../SessionManager.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login title</title>
<script type = "text/javascript" src = "scripts/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="scripts/jquery.jcryption-1.1.min.js" ></script>
<script type="text/javascript">
var keys;
$(document).ready(function(){
	getKeys();
	
})

function getKeys() {
	$.jCryption.getKeys("EncryptionServlet?generateKeypair=true", function(receivedKeys) {keys = receivedKeys;
	if(keys != undefined || keys != "")
	{
	$(".overlay").css('display','none');
	}
	});
}

	
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
		  $.jCryption.encrypt($("#userId").val(), keys, function(j) {
				$.jCryption.encrypt($("#userPassword").val(), keys, function(k){
					$("#userId").val(j);
					$("#userPassword").val(k);
					$("#login").submit();
				});
			});
	  
	  }
	}


	function setFocus()
	{
		document.getElementById("userId").focus();

	}
</script>

<style type="text/css">
.bgimage{
position:absolute;
background-size:cover;
background-image:url(images/Goa.jpg);
background-position:center;
z-index:-1;
width:100%;
height: 100%;
opacity: 0.5;
filter: alpha(opacity=50);
}

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
.login {
  display:grid;
  background: floralwhite;
  border: 1px solid #42464b;
  border-radius: 6px;
  height: 200px;
  margin: 20px auto 0;
  width: 325px;
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
  background: linear-gradient(to top, #2aab64, #ADFF2F );
}
input[type="submit"] {
  background-color: #4CAF50;
  box-shadow: inset 0px 1px 0px #0f6133, 0px 5px 0px 0px #37710c, 0px 10px 5px #999;
  margin-bottom: 8px;
}
input[type=submit]:hover {
    opacity: 0.8;
}
#loginform{
	text-align: center;

}
#signup{
	position: absolute;
    margin-top: -11px;
    z-index: 10;
}
#signupimg{
	z-index: -1;
    position: absolute;
    left: -22px;
    top: 6px;
    width: 51px;
    transform: rotate(-50deg);
}
#signupimg:hover{
width: 56px;
cursor: pointer;
}
#signupfooter{
z-index: 999px;
display:block;
position:fixed;
width:100%;
height:0px;
bottom:0px;
background-color: #2aab64;
color: #ffffff;
text-align: center;
border-top-left-radius: 10px;
  border-top-right-radius: 10px;
transition:             height 500ms ease;
        -moz-transition:    height 500ms ease;
        -ms-transition:     height 500ms ease;
        -o-transition:      height 500ms ease;
        -webkit-transition: height 500ms ease;
}

</style>



</head>
<body onload="setFocus()">
<%
response.setHeader( "Set-Cookie", "JSESSIONID="+session.getId()+"; HttpOnly; Path=/dashboard/");
%>
<div id="signupfooter">Sign Up Form For Candidates.</div>
<div class="bgimage"></div>
<div id="loginform">
	<form id="login" action="<%=request.getContextPath()%>/login" method="post" autocomplete="off">
			<img src="<%=request.getContextPath()%>/images/Parinati_white_logo.png" style="align: center;" />
				<div class="login">
					<div id="signup"><img id="signupimg" src="<%=request.getContextPath()%>/images/signup.png" /></div>
					<input type="text" name="userId" id="userId" placeholder="User ID"/>


					<input type="password" name="userPassword" id="userPassword" placeholder="Password" />



					<span id="errordiv" style="font-size: 15px; color: #FF0000" align="center">
							<%
					if(request.getParameter("result")!=null){
					%>

							Invalid UserName and PassWord
							<%	}
				%>
						</span>
						<input type="button" class="formbuttons" value="Login" onClick="return check()" />
						<div align="left" style="margin-left: 10%;"><a style="color:  blue;text-decoration: none" href="forgotPassword.jsp">Forgot Password?</a></div>
						<div align="left" style="margin-left: 10%;"><a style="color:  blue;text-decoration: none;" href="candidatesignup.jsp">Career explorer? Submit your resume</a></div>
						</div>



	</form>


		</div>

		<script>
		document.getElementById('signupimg').addEventListener( 'click', function() {
			window.location = "candidatesignup.jsp";
		}, false );

		document.getElementById('signupimg').addEventListener( 'mouseover', function() {
			document.getElementById('signupfooter').style.height = '30px';

			}, false );
		document.getElementById( 'signupimg' ).addEventListener( 'mouseout', function() {
			document.getElementById( 'signupfooter' ).style.height = '0px';
			}, false );
		</script>
</body>
</html>