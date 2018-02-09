<%@page import="java.util.*"%>


<DropDown> <jsp:useBean id="createEmplDom" scope="session" class="com.parinati.admin.CreateEmployeeDomain" /> 
<projectOption>
<% 
		List allProjectList = new ArrayList();
		String projectId = null;
		String projectName = null;
 				try {
 					allProjectList = createEmplDom.fetchProjectDetails();
 					}
 				catch (Exception t) {
 						allProjectList  = null;
 					}	
 		
		 		if (allProjectList != null && !allProjectList.isEmpty()) 
		 			{
		 			%> 	
				 			<% for (int size = 0; size < allProjectList.size(); size++)
				 			{
				 				ArrayList allProjectListTemp = (ArrayList) allProjectList.get(size);
				 				projectId = allProjectListTemp.get(0).toString();
				 				projectName = allProjectListTemp.get(1).toString();
				 		
				 			
								 %> 
								
									<option value="<%=projectId%>"><%=projectName%></option>
								 
					<%
							}
					}
 				
 				%></projectOption> </DropDown>