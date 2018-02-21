<%@page import="java.util.*"%>


<DropDown> <jsp:useBean id="timeDom" scope="session" class="com.parinati.timesheet.TimesSheetDomain" /> 
<resOption>

		<%-- List allProjectList = new ArrayList();
		String projectId = null;
		String projectName = null;
 				try {
 					allProjectList = timeDom.fetchProjectDetails();
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
					} --%>
 				<%
 	String projId = request.getParameter("projectId") == null?"":request.getParameter("projectId");			
 	if(projId!=null & !projId.isEmpty()){
	List<ArrayList> emplList = timeDom.fetchEmployeeByProject(projId);
	Iterator<ArrayList> empIter = emplList.listIterator();
	%>
	<table>
	<%
	while(empIter.hasNext()){
		String resName = (String)empIter.next().get(0);
		%>
		<tr>
	<td>
	<input type="checkbox" class="resourceVal" value="<%=resName%>"><%=resName%>
	</td>
	</tr>
		<%
	}
	
	%>
	</table>
	<%
 	}
	%>
 				</resOption> </DropDown>