<%@page import="com.parinati.util.GenericUtil"%>
<%@page import="java.util.*"%>


<DROPDOWN> <jsp:useBean id="projDom" scope="session" class="com.parinati.admin.AddProjectDomain" /> 
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
				String leadId = (String)projectRec.get(2);
				String leadName = (String)projectRec.get(3);
				%>
				<PROJLOC><%= projectLoc%></PROJLOC>
				<PROJTECH><%= tech%></PROJTECH>
				<%
				if(leadId==null || leadId.isEmpty()){
				%>
				<LEAD><%=("" + "|Select") %></LEAD>
				<%	
				}else{%>
					<LEAD><%=(leadId + "|"+leadName) %></LEAD>	
				<%}
			}
		}
		List leadDetails = (ArrayList)emplList.get(1);
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
</DROPDOWN>