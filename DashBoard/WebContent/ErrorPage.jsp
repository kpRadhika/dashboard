<%@page import="com.parinati.util.CustomLogger"%>
<%@page import = "java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
.fontcss{
font-family: Arial,Helvetica,sans-serif;
font-size: 13px;
 }
</style>
</head>

<%
	String errMsg = "Dear user due to certain unavoidable circumstances you are not permitted to access the further information.";

	session = request.getSession(false);
	if(session != null)
	{
		session.removeAttribute("userID");
		session.invalidate();
	}

%>

<body>
	<table width="511" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td class="fontcss"><b><%=errMsg%></b></td>
		</tr>
	</table>
</body>
</html>