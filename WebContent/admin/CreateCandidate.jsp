<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
    <%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@include file="../commonInclude.jsp" %>
<jsp:useBean id="userDoamin" scope="session" class="com.parinati.admin.CreateUserDomain" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Candidate</title>
<script type = "text/javascript" src = "scripts/CreateCandidate.js"></script>

<style type="text/css">
label.error{
font-family:    verdana,times new roman;
font-size:      13px;
color:          red;
}

</style>
</head>
<body>
<%

String contentType = request.getContentType();
String result = null;
if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
	String sessionId = session.getId();
	DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	String firstName = null;
	String middName = null;
	String lastName = null;
	String DOB = null;
	String phone  = null;
	String email  = null;
	String qualification  = null;
	double exp  = 0.0;
	String skills  = null;
	String address  = null;
	String currentemployer  = null;
	String achievements  = null;
	String interViewDate  = null;
	boolean flag = false;
	String uploadPath = null;
	try {
		List fileItems1 = null;
		List fileItems = upload.parseRequest(request);
		fileItems1 = fileItems;
		// Process the uploaded file items
		Iterator i = fileItems.iterator();
		while (i.hasNext()) {

			FileItem fi = (FileItem) i.next();

			if (fi.isFormField()) {
				if (fi.getFieldName().equals("firstName")) {
					firstName = fi.getString();
				}if (fi.getFieldName().equals("middName")) {
					middName = fi.getString();
				}if (fi.getFieldName().equals("lastName")) {
					lastName = fi.getString();
				}if (fi.getFieldName().equals("DOB")) {
					DOB = fi.getString();
				}if (fi.getFieldName().equals("phone")) {
					phone = fi.getString();
				}if (fi.getFieldName().equals("email")) {
					email = fi.getString();
				}if (fi.getFieldName().equals("qualification")) {
					qualification = fi.getString();
				}if (fi.getFieldName().equals("exp")) {
					exp = Double.parseDouble(fi.getString());
				}if (fi.getFieldName().equals("skills")) {
					skills = fi.getString();
				}if (fi.getFieldName().equals("address")) {
					address = fi.getString();
				}if (fi.getFieldName().equals("currentemployer")) {
					currentemployer = fi.getString();
				}if (fi.getFieldName().equals("achievements")) {
					achievements = fi.getString();
				}if (fi.getFieldName().equals("interViewDate")) {
					interViewDate = fi.getString();
				}
			}
		}
		final int MEMORY_THRESHOLD = 1024 * 1024 * 3; // 3MB
		final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
		final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

		// configures upload settings
		//DiskFileItemFactory factory = new DiskFileItemFactory();
		// sets memory threshold - beyond which files are stored in disk
		factory.setSizeThreshold(MEMORY_THRESHOLD);
		// sets temporary location to store files
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

		//ServletFileUpload upload = new ServletFileUpload(factory);

		// sets maximum size of upload file
		upload.setFileSizeMax(MAX_FILE_SIZE);

		// sets maximum size of request (include file + form data)
		upload.setSizeMax(MAX_REQUEST_SIZE);

		// constructs the directory path to store upload file
		// this path is relative to application's directory
		/* String path1 = new File("").getAbsolutePath();
		String path = new File(path1).getParent();*/

		 uploadPath = "/DashBoard/Resume";

		// creates the directory if it does not exist
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		try {
			// parses the request's content to extract file data
			@SuppressWarnings("unchecked")
			List<FileItem> formItems = upload.parseRequest(request);
			formItems = fileItems1;
			if (formItems != null && !formItems.isEmpty()) {
				// iterates over form's fields
				for (FileItem item : formItems) {
					String fileName = "";
					// processes only fields that are not form fields
					if (!item.isFormField()) {
						if (item.getFieldName().equals("uploadFile")) {
							fileName = new File(item.getName()).getName();
							String filePath = uploadPath + File.separator + fileName;
							File storeFile = new File(filePath);

							// saves the file on disk
							item.write(storeFile);
							flag = true;
						}
					}
				}
			}
		} catch (Exception ex) {
			System.out.print(ex);
			flag = false;
		}
	} catch (Exception e) {
		flag = false;
	}
	if(flag){
		List inputParam = new ArrayList();
		inputParam.add(firstName);
		inputParam.add(middName);
		inputParam.add(lastName);
		inputParam.add(DOB);
		inputParam.add(phone);
		inputParam.add(email);
		inputParam.add(qualification);
		inputParam.add(exp);
		inputParam.add(skills);
		inputParam.add(address);
		inputParam.add(currentemployer);
		inputParam.add(achievements);
		inputParam.add(interViewDate);
		inputParam.add(uploadPath);
		result = userDoamin.insertCandidateDtls( inputParam);
	}
}
if(result == null){
%>
<form  name  ="createCandidate" id ="createCandidate" action="CreateCandidate.jsp" enctype="multipart/form-data" method="post">

<br>
<table width="100%" align="center"><tr align="center" class="tableheader" ><td>Create Candidate</td></tr>
<tr><td>
	<table width="80%" align="center">
	<col width="20%">
	<col width="20%">
	<col width="20%">
	<col width="20%">
	<tr>
	<th colspan="4"> Personal Details</th>
	</tr>
		<tr>
			<td>First Name<label style="color:red">*</label></td>
			<td><input type="text" name="firstName" align="left"/></td>

			<td>Middle Name</td>
			<td><input type="text" name = "middName" align="left"></td>
	</tr>
	<tr>
			<td>Last Name<label style="color:red">*</label></td>
			<td><input type="text" name = "lastName" align="left"></td>

		</tr>
		<tr>
			<td>Date Of Birth<label style="color:red">*</label></td>
			<td><input type="text" name="DOB" id="DOB" align="left" readonly/></td>

			<td>Phone Number<label style="color:red">*</label></td>
			<td><input type="text" name = "phone" id = "phone" align="left" maxlength="10">
			</td>
		</tr>

		<tr>
			<td>Email ID<label style="color:red">*</label></td>
			<td><input type="text" name = "email" id="email" align="left"></td>

			<td>Address<label style="color:red">*</label></td>
			<td><input type="text" name = "address" align="left"></td>
		</tr>

		</table>
<br><br>
	<table width="80%" align="center">
	<col width="20%">
	<col width="20%">
	<col width="20%">
	<col width="20%">
	<tr>
	<th colspan="4">Skill Details</th>
	</tr>
		<tr>
			<td>Qualification<label style="color:red">*</label></td>
			<td><input type="text" name = "qualification" align="left"></td>

			<td>Experience<label style="color:red">*</label></td>
			<td><input type="text" name = "exp" align="left"></td>
		</tr>

		<tr>
			<td>Skills<label style="color:red">*</label></td>
			<td><input type="text" name = "skills" align="left"></td>
			<td>Upload Resume(.pdf)<label style="color:red">*</label></td>
			<td><input type="file" name = "uploadFile" id = "uploadFile" accept=".pdf" align="left" ></td>
		</tr>

	</table>
	<br><br>
	<table width="80%" align="center">
	<col width="20%">
	<col width="20%">
	<col width="20%">
	<col width="20%">
	<tr><th colspan="4">Employment details</th></tr>

		<tr>
			<td>Current Employer</td>
			<td><input type="text" name = "currentemployer" align="left"></td>

			<td>Achievements</td>
			<td><input type="text" name = "achievements" align="left"></td>
		</tr>
		</table>
<br><br>
<table width="80%" align="center">
<col width="20%">
	<col width="20%">
	<col width="20%">
	<col width="20%">
<tr><th colspan="4"> Interview details</th></tr>
		<tr>
			<td><label>Date Of Interview</label></td>
			<td><input type="text" name = "interViewDate" id="interViewDate" align="left"></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<br><br>
	<div align="center"><input type="submit" value="Submit"/>
			<input type="reset" value="Reset" /></div>
			<br><br>
			</td></tr></table>
<input type="hidden" name="formValue" value="formValue"/>
</form>
<%
	}else{
	%><br> <br> <br> <br> <br>

		<table align="center">
	<%
	if(!result.equals("ERROR")){
	%>
			<tr>
				<td><b>Candidate created Successfully.</b></td>
			</tr>
			<tr>
				<td><b>Candidate Id : <%=result%></b></td>
			</tr>
	<%
	}else{

	%>
			<tr>
				<td><b> Error Occured While Creating Candidate.</b></td>
			</tr>
	<%
	}
	%>
	</table>
<%
	}
%>
</body>
</html>
