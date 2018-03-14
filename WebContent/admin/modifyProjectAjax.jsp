<%@page import="com.parinati.util.GenericUtil"%>
<%@page import="java.util.*"%>


<jsp:useBean id="projDom" scope="session" class="com.parinati.admin.AddProjectDomain" /> 
<PROJOPTION>
<%
 	String projId = GenericUtil.setValue(request.getParameter("projectId"));			
 	if(projId!=null & !projId.isEmpty()){
	List<List<ArrayList>> emplList = projDom.fetchProjectDetails(projId);
	
	if(emplList!=null && !emplList.isEmpty()){
		List projDetails = (ArrayList)emplList.get(0);
		if(projDetails!=null && !projDetails.isEmpty()){
			Iterator<ArrayList> projIter = projDetails.listIterator();
			while(projIter.hasNext()){
				List projectRec = projIter.next();
				String projectLoc = (String)projectRec.get(0);
				String tech = (String)projectRec.get(1);
			
				%>
				<PROJLOC><%= projectLoc%></PROJLOC>
				<PROJTECH><%= tech%></PROJTECH>
				<%
			}
		}
		List proLeadDetails = (ArrayList)emplList.get(1);
		if(proLeadDetails!=null && !proLeadDetails.isEmpty()){
			String leadId = (String)proLeadDetails.get(0);
			String leadName = (String)proLeadDetails.get(1);
			
			%>
				
					<LEAD><%=(leadId + "|"+leadName) %></LEAD>	
				<%
		}else{%>
		<LEAD><%=("" + "|Select") %></LEAD>
		<%	
		}
		List leadDetails = (ArrayList)emplList.get(2);
		if(leadDetails!=null && !leadDetails.isEmpty()){
			Iterator<ArrayList> leadIter = leadDetails.listIterator();
			while(leadIter.hasNext()){
				List leadRec = leadIter.next();
				String otherLeadId = (String)leadRec.get(0);
				String otherLeadName = (String)leadRec.get(1);
				%>
				<LEAD><%=(otherLeadId + "|"+otherLeadName) %></LEAD>	
			<%
			}
		}
	}
 	}
	%>
</PROJOPTION> 
