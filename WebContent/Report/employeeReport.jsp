<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../commonInclude.jsp" %>
  <%@page import="java.util.*,com.parinati.admin.*,java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>view/Modify Candidate</title>
<script type="text/javascript" src="scripts/MonthPicker.min.js"></script>
<script type = "text/javascript" src = "scripts/employeeReport.js"></script>
<style type="text/css">

.tableProps{
width:80%;
table-layout: fixed;
align:center;
}

.tableProps td{
width:10%;
}
.tableProps input[type=text]{
width:90%;
}

label.error{
font-family:    verdana,times new roman;
font-size:      13px;
color:          red;
}


button {
     background:none!important;
     color:inherit;
     border:none;
     padding:0!important;
     font: inherit;
     border-bottom:1px solid #0147FA;
     cursor: pointer;
}
.labelstyle {
    background:rgba(0,0,0,0); 
    /* border:2px; */
}
.ui-button-text-only .ui-button-text {
	font-size: .7em;
}

.ui-widget-content {
	color: #FFFFFF;
}

.ui-widget-header {
	background: url("images/ui-bg_highlight-soft_75_cccccc_1x100.png")
		repeat-x scroll 50% 50% #0199cd;
	border: 1px solid #aaaaaa;
	color: #222222;
	font-weight: bold;
}

.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current {
	float: left;
	background: #900;
}

.month-picker {
	display: inline-block;
	position: absolute;
	z-index: 9999;
	/* top: 153px !important;
	left: 402px !important; */
}

.month-picker table {
	border-collapse: separate;
	border-spacing: 2px 2px
}

.month-picker td {
	padding: 0
}

.month-picker .ui-button-text {
	padding: .4em 0
}

.month-picker-header {
	margin: 3px 3px 0
}

.month-picker-year-table, .month-picker-month-table {
	width: 100%;
	-ms-user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
	user-select: none
}

.month-picker-year-table a {
	border: 1px solid transparent
}

.month-picker-year-table .ui-button {
	font-size: 1.1em;
	cursor: default;
	margin: 0
}

.month-picker-year-table .month-picker-title {
	text-align: center
}

.month-picker-year-table .month-picker-title .ui-button {
	font-size: 1em;
	padding: .1em 0;
	width: 100%;
	font-weight: 700
}

.month-picker-year-table .ui-button-text {
	padding: 0
}

.month-picker-month-table td {
	height: 35px;
	text-align: center
}

.month-picker-open-button {
	height: 20px;
	width: 20px;
	vertical-align: bottom
}

.month-picker-invalid-message {
	display: none;
	background-color: #ff0
}

.month-picker-disabled {
	background-color: #e1e1e1
}

.month-picker-open-button, .month-picker-open-button:hover  {
	background: url("../images/calendar.gif");
}
/*new changes for jquery3.3.1*/
.ui-widget-header, .month-picker-previous .ui-button, .month-picker-next .ui-button,
	.month-picker-title  .ui-button, .ui-state-active {
	background: #0199cd !important;
}

  .month-picker-open-button .ui-icon,.month-picker-open-button .ui-icon:hover {
 opacity: 0 ;
 }

.month-picker-month-table  .ui-button {
	width: 100%;
	padding: 5px 0px 5px 0px;
}

.month-picker-title a:hover, .month-picker-previous a:hover,
	.month-picker-next a:hover {
	background: #f6f6f6 !important;
}

</style>

</head>

<body>
<table width="100%" align="center">
<tr class="tableheader">
			<td colspan="3">Leave Report</td>
</tr>
<tr>
<td>
<%
int result = 0;
String msg = request.getParameter("msg")== null ? "": request.getParameter("msg");
String submitVal = request.getParameter("submit")== null ? "": request.getParameter("submit");
	String projectDropDownVal = request.getParameter("projectDropDown")== null ? "": request.getParameter("projectDropDown");
	String monthYear = request.getParameter("monthYear")== null ? "": request.getParameter("monthYear");

%>

<form method="post" name = "report" id="report" action="<%=request.getContextPath()%>/DownloadReportServlet" >
<table width="80%" align="center">			
			<tr><td >
			<label>Project Name<span class="required"></span>&nbsp;&nbsp;:</label>
			</td>
			<td>
		 <div width="80%" id="projectOption" style="display: none">
				
				<select name="projectDropDown" id="projectDropDown">
						<option value="">Select</option>
						<%
							 if(projectDropDownVal!=null && !"".equalsIgnoreCase(projectDropDownVal))
							 {

						%>

						<option value="<%=projectDropDownVal.trim()%>" selected="selected"></option>

						<%
							}
						%>
				    </select>
							  
			</div>
			</td></tr>
			<tr id="monthPicker" >
				<td >Select Month<span class="required"></span>&nbsp;&nbsp;:</td>
				<td><input id="monthYear" type="text" name="monthYear" value="<%=monthYear %>" readonly="readonly" /> 
			</tr>
			<tr id="monthPicker">
				<td><input type="submit" name="submit" value="submit" id="submit"></td>
			</tr>
		</table>
		<br/>

		
		<input type="hidden" name="projectDropDown" value="<%=projectDropDownVal.trim()%>"/>
		</form>
		<table align="center">
		<%if(!"".equals(msg)) {%>
		<tr>
				<td><b>No Record Found</b></td>
			</tr>
		<%} %>
		</table>
		
</td>
</tr>
</table>
</body>
</html>