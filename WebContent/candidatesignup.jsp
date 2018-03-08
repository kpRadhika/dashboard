<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<title>Login title</title>
<link rel="stylesheet" href="./styles/jquery-ui.min.css" type="text/css"/>
<script type = "text/javascript" src = "./scripts/jquery-3.3.1.min.js"></script>
<script type = "text/javascript" src = "./scripts/jquery-ui.min.js"></script>
<script src="./scripts/jquery.validate.js"></script>
<style type="text/css">
html{
    overflow-x: hidden;
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
#signupform{
	box-shadow: 0px 0px 5px #272928, 0px 0px 0px 0px #504f54, 0px 23px 50px #999;
	background-color: lavender;
	height: 60%;
}
#formcontent{
	margin-left: 25%;
	width: 50%;
	height: 100%;
}
table{
    width: 100%;
    height:100%
}
.formstyle{
    width: 80%;
    margin-left: 10%;
    padding: 7px !important;
    margin-top: 1% !important;
}
tr label{
	margin-left: 36%;
}

#uploadfilediv{
width: 80% !important;
text-align: center;
/* border-style: solid; */
border-width: 2px;
background: linear-gradient(to top, #ffc30b, #fffc70 );
}
#register{
background-color: #2aab64;
width: 84% !important;
border: 0;
background: linear-gradient(to top, #2aab64, #ADFF2F );
}
#clear{
background-color: #dbd8cd;
width: 84% !important;
border: 0;
}
#clear:hover, #register:hover, #uploadfilediv:hover {
cursor:pointer;
opacity:0.9;
padding: 5px;
}
/* .important{
	border-color:red;
} */
.error{
	color:red;
	margin-left: 10% !important;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#candidateregisterform").validate({
		rules: {
			firstname: "required",
			candidateemail: {
		      required: true,
		      email: true
		    },
		    candidateno: {
		    	required: true,
		    	digits: true
			    },
		    address: "required",
		    qualification: "required",
		    skills: "required",
		    experience: "required",
		    uploadcv: "required",
		  },
		  messages: {
			  firstname: {required:"Please specify your First Name"},
			  candidateemail: {
		      required: "We need your email address to contact you",
		      email: "Your email address must be in the format of name@domain.com"
		    },
		    candidateno: {
		   		required : "Please specify your Mobile No.",
		   		digits: "Enter digits only"
		    },
		    address:{required: "Please specify your Address"},
		    qualification:{required: "Please specify your Qualification"},
		    skills:{required: "Please specify your Skills"},
		    experience: {
				required :"Please specify your Experience",
		    	digits: "Enter digits only"
		    },
		    uploadcv:{required: "Your CV is required"}
		  }
		});
	jQuery.validator.addMethod("email", function(value, element) {
		  return this.optional( element ) && /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@(?:\S{1,63})$/.test( value );
		}, 'Please enter a valid email address.');
});
</script>
</head>
<body>
<%
response.setHeader( "Set-Cookie", "JSESSIONID="+session.getId()+"; HttpOnly; Path=/dashboard/");
%>
<div class="bgimage"></div>
<div id="formcontent">
<div><center><img src="<%=request.getContextPath()%>/images/Parinati_white_logo.png" /></center></div>
<div id="signupform">
<form name="candidateregisterform" id="candidateregisterform">
<div>
<table>
<caption style="background-color: #2aab64;height:20px;text-align:center;padding: 10px;background: linear-gradient(to top, #2aab64, #ADFF2F );font-weight: bold">Candidate Registration</caption>
<tr>
<td>
<input type="text" name="firstname" id="firstname" class="formstyle valid" style="width:37%" placeholder="Firstname*"/><input type="text" name="lastname" class="formstyle" style="width:37%;margin-left:2%" placeholder="Lastname"/>
<label for="firstname" generated="true" class="error" style="display: none;">This field is required.</label>
</td>
</tr>
<tr>
<td><input type="text" name="candidateemail" class="formstyle valid" placeholder="EmailId*"/></td>
</tr>
<tr>
<td><input type="text" name="candidateno" class="formstyle valid" placeholder="Phone No.*"/></td>
</tr>
<tr>
<td><textarea name="address" class="formstyle valid" placeholder="Current Address*" style="border-width: 2px;resize: none;"></textarea></td>
</tr>
<tr>
<td><input type="text" name="qualification" class="formstyle valid" placeholder="Qualification*"/></td>
</tr>
<tr>
<td><input type="text" name="skills" class="formstyle valid" placeholder="Skills*"/></td>
</tr>
<tr>
<td><input type="text" name="experience" class="formstyle valid" placeholder="Experience (in Years)*"/></td>
</tr>
<tr>
<td><label class="formstyle" style="color: grey">* mandatory fields</label></td>
</tr>
<tr>
<td>
<input type="file" name="uploadcv" id="uploadfile" class="valid" accept=".pdf" style="display: none;"/>
<label for="uploadfile"><div class="formstyle" id="uploadfilediv">
<svg width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"></path></svg> <span id="cvlabel">Click to Upload CV</span>
</div>
</label>
</td>
</tr>
<tr>
<td><input type="submit" id="register" class="formstyle" value="Register"/></td>
</tr>
<!-- <tr>
<td><input type="reset" id="clear" class="formstyle" value="Reset" style=" margin-bottom: 3%;"/></td>
</tr> -->
<tr><td><br></td></tr>
</table>
</div>
</form>
</div>
</div>
<script>
document.getElementById("uploadfile").addEventListener( 'change', function( e )
		{
			var fileName = e.target.value.split( '\\' ).pop();

			if( fileName )
				document.getElementById( 'cvlabel' ).innerHTML = fileName;
		});


</script>

</body>
</html>