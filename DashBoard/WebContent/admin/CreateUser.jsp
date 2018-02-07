
<%
	if(session.getAttribute("userID")!=null){		
	%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.parinati.admin.CreateUserDomain"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create User</title>

<%-- 
<script type="text/javascript">


			 function focus(){				
				document.getElementById("userId").focus();	
			} 
			
			function val(){
				
				document.getElementById("lbluserId").innerHTML="";				
				document.getElementById("lblpanNo").innerHTML="";			
				document.getElementById("lbluName").innerHTML="";				
				document.getElementById("lbldesignation").innerHTML="";			
				document.getElementById("lbluserType").innerHTML="";
		
			
					if(document.getElementById("userId").value=="" ){
						
						document.getElementById("lbluserId").innerHTML="Enter UserId";
					//	document.getElementById("userId").focus();
						return false;
						}				
				
					else if(document.getElementById("panNo").value=="" ){
						document.getElementById("lblpanNo").innerHTML="Enter Pan Number";
					//	document.getElementById("panNo").focus();
						return false;
						}
					
					else if(document.getElementById("uName").value=="" ){
						document.getElementById("lbluName").innerHTML="Enter User ID ";
					//	document.getElementById("uName").focus();
						return false;
						}
					/* else if(document.getElementById("cpwd").value=="" ){
						document.getElementById("lblcpwd").innerHTML="Enter Confirmation PassWord";
					//	document.getElementById("cpwd").focus();
						return false;
						} */
					
					
					
						
					else if(document.getElementById("designation").value=="" ){
						document.getElementById("lbldesignation").innerHTML="Enter Designation";
						//document.getElementById("designation").focus();
						return false;
						}
					else if(document.getElementById("userType").value=="select" ){
						document.getElementById("lbluserType").innerHTML="Select User Type";
					//	document.getElementById("userType").focus();
						return false;
						}	
					else if(document.getElementById("userType").value=="zo"){
							
						if(document.getElementById("zone").value=="select"){
							document.getElementById("lblzone").innerHTML="Select Zone";
						//	document.getElementById("lblzone").focus();
							return false;
						}
																		
					}	
					else if(document.getElementById("userType").value=="ro"){
							
						if(document.getElementById("region").value=="select"){
							document.getElementById("lblregion").innerHTML="Select Region";
							//document.getElementById("lblregion").focus();
							return false;
						}	
				
					}		
					else{
						return true;
					}	
				}
		
			function hzr(val){			
		
			var table=document.getElementById("datatable");	
			var rowcount=table.rows.length;
			
			if(rowcount==8){
				var tb=document.getElementById("datatable");
				var row=tb.rows.length-2;					
					tb.deleteRow(6);
				
			}
			var table1=document.getElementById("datatable");
			var rowcount1=table.rows.length;
			
				
				if(rowcount1<8)
				{
				var row=table.insertRow(6);									
			
				if(val=="zo"){	

				var cell0=row.insertCell(0);					
					var spanTag = document.createElement("span");
						spanTag.innerHTML = "Zone";	
						
						cell0.appendChild(spanTag);					

				var cell1=row.insertCell(1);					
						var element=document.createElement("select");
							element.name="zone";							
						    element.id="zone";	
				            						
				 
						var opt=document.createElement("option");								
							opt.text="Select Zone";
							opt.value="select";								
							element.appendChild(opt);
		
							var opt1;
					
							<%					
							Iterator it=new ZoneDao().findByAll().iterator();	
							while(it.hasNext()){							
									Zone b=(Zone)it.next();	
									
								%>														
							opt1=document.createElement("option");						
							opt1.text=" <%=b.getZoneName()%>";		
							opt1.value="<%=b.getZoneID() %>";							
							element.appendChild(opt1);
		
							<%
								}
							%>
					cell1.appendChild(element);


					var cell2=row.insertCell(2);					


					 	var dynDiv = document.createElement("div");
				        dynDiv.id = "lblzone";
				        dynDiv.innerHTML = "";
				        dynDiv.style.height = "10px";
				        dynDiv.style.width = "100px";   
				        
				        dynDiv.style.color = 'red';
				        dynDiv.width="50%";				        
				        document.body.appendChild(dynDiv);
				        cell1.appendChild(dynDiv);	 
				}

				else if(val=="ro"){

					var cell0=row.insertCell(0);
						var spanTag = document.createElement("span");
							spanTag.innerHTML = "Region";											
							cell0.appendChild(spanTag);
							
					var cell1=row.insertCell(1);		
					
					var element=document.createElement("select");
						element.name="region";							
					    element.id="region";
					    element.align="center";								
			 
					var opt=document.createElement("option");								
						opt.text="Select Region";
						opt.value="select";
						element.appendChild(opt);
	
						var opt1;
				
						<%					
						Iterator it1=new RegionDao().findByAll().iterator();	
						while(it1.hasNext()){							
								Region b=(Region)it1.next();	
								
							%>														
						opt1=document.createElement("option");						
						opt1.text=" <%=b.getRegionName()%>";		
						opt1.value="<%=b.getRegionID() %>";						
						element.appendChild(opt1);
	
						<%
							}
						%>
				cell1.appendChild(element);

				var cell2=row.insertCell(2);					
						 var dynDiv = document.createElement("div");
					        dynDiv.id = "lblregion";
					        dynDiv.innerHTML = "";
					        dynDiv.style.height = "10px";					      
					        dynDiv.style.width = "100px";     
					        dynDiv.style.color = 'red';
					        dynDiv.width="50%";
					        document.body.appendChild(dynDiv);
		        	cell1.appendChild(dynDiv); 	

				}	
			}
						
			}		
				

				function cpwd111(){

							
					if(document.getElementById("userPass").value==document.getElementById("cpwd").value){
						return true;						
				}
				else{
					
					document.getElementById("lblcpwd").innerHTML="new password and confirmation passWord not matching";		
					document.getElementById("userPass").value="";
					document.getElementById("cpwd").value="";
						
				}
					

				}
			
				
		</script>
 --%>

</head>



<!-- <body onload="focus()" bgcolor="#D4DBF5"> -->
<body>
	<br></br>
	<br></br>



	<form action="CreateUserServlet" method="post" name="form1"
		autocomplete="off">

		<table  id="datatable" width="75%" align="center" cellspacing="10" cellpadding="0">

			<tr>
				<td><label>First Name</label></td>
				<td colspan="3"><input type="text" name="fname" id="fname" align="left"/></td>
			</tr>

			<tr>
				<td><label>Middle Name</label></td>
				<td><input type="text" name="panNo" id="panNo" />
					<div id="lblpanNo" style="font-size: 15px; color: #FF0000"
						align="left"></div></td>
			</tr>

			<tr>
				<td><label>User Name</label></td>
				<td><input type="text" name="uName" id="uName" />
					<div id="lbluName" style="font-size: 15px; color: #FF0000"
						align="left"></div></td>
			</tr>

			<tr>
				<td><label>Designation</label></td>
				<td><input type="text" name="designation" id="designation" />
					<div id="lbldesignation" style="font-size: 15px; color: #FF0000;"
						align="left"></div></td>
			</tr>

			<tr>
				<td><label>Type of User</label></td>
				<td><select name="userType" id="userType"
					onchange="hzr(this.value)">
						<option value="select">Select User Type</option>
						<option value="ho">HO</option>
						<option value="zo">ZO</option>
						<option value="ro">RO</option>
				</select> <br />
					<div id="lbluserType" style="font-size: 15px; color: #FF0000;"
						align="left"></div></td>
			</tr>




			<tr>

				<th colspan="2"><input type="submit" value="Submit"
					onclick="return val(); " /> <input type="reset" value="Reset" />
				</th>
			</tr>



		</table>

		<table align="center">

			<%
							if(request.getAttribute("result")!=null){	
								if(request.getAttribute("result")=="fail"){
									%>
			<tr>
				<td><font color="#FF0000"><b> User Id already  in use</b></font></td>
			</tr>
			<% 
								}
								else
								if(request.getAttribute("result")=="success"){
					%>

			<tr>
				<td><font color="#6694E3"><b> User Created
							Successfully</b></font></td>
			</tr>


			<%
							}
							
					
							else
							{
						%>
			<tr>
				<td><font color="#FF0000"><b>User Creation Failure </b></font></td>
			</tr>
			<%			
							}
								
							}
					%>


		</table>


	</form>


</body>
</html>


<%
	}
	else{
		
	%>


<jsp:forward page="Login.jsp"></jsp:forward>

<%		
		
	}
%>
