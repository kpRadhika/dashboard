<%@page import="java.util.*"%>


<DROPDOWN> <jsp:useBean id="timeDom" scope="session" class="com.parinati.timesheet.TimesSheetDomain" /> 
<RESOPTION>
<%
 	String projId = request.getParameter("projectId") == null?"":request.getParameter("projectId");			
 	if(projId!=null & !projId.isEmpty()){
	List<ArrayList> emplList = timeDom.fetchEmployeeByProject(projId);
	Iterator<ArrayList> empIter = emplList.listIterator();
	
	while(empIter.hasNext()){
		List resDetails = empIter.next();
		String resId = (String)resDetails.get(0);
		String resName = (String)resDetails.get(1)+" "+(String)resDetails.get(2);
%>
		
	<RESNAME><%=resId+"|"+resName%></RESNAME>
	
	<%
	}
 	}
	%>
</RESOPTION> 
</DROPDOWN>