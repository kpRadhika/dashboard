<%@page import="java.util.*"%>
<%
try
{
		String xss_strQString = request.getQueryString() == null ? "" : request.getQueryString();
		xss_strQString = xss_strQString.toLowerCase();
		if(xss_strQString.indexOf("%60")  > -1 || xss_strQString.indexOf("%3f")  > -1 || xss_strQString.indexOf("%3e")  > -1 || xss_strQString.indexOf("%3d")  > -1 || xss_strQString.indexOf("%3c")  > -1 || xss_strQString.indexOf("%3b")  > -1 || xss_strQString.indexOf("%26")  > -1 || xss_strQString.indexOf("%22")  > -1 || xss_strQString.indexOf("&#40")  > -1 || xss_strQString.indexOf("&#41")  > -1 || xss_strQString.indexOf("%27")  > -1 || xss_strQString.indexOf("onerror")  > -1 || xss_strQString.indexOf("javascript")  > -1 || xss_strQString.indexOf("onclick")  > -1 ||  xss_strQString.indexOf("%53%43%52%49%50%54")  > -1 || xss_strQString.indexOf("&#97&#108&#101&#114&#116")  > -1 || xss_strQString.indexOf("onunload")  > -1 || xss_strQString.indexOf("onload")  > -1 || xss_strQString.indexOf("onabort")  > -1 || xss_strQString.indexOf("20%")  > -1 || xss_strQString.indexOf("21%")  > -1 || xss_strQString.indexOf("22%")  > -1 || xss_strQString.indexOf("23%")  > -1 || xss_strQString.indexOf("24%")  > -1 || xss_strQString.indexOf("25%")  > -1 || xss_strQString.indexOf("26%")  > -1 || xss_strQString.indexOf("27%")  > -1 || xss_strQString.indexOf("28%")  > -1 || xss_strQString.indexOf("29%")  > -1 || xss_strQString.indexOf("%2A")  > -1 || xss_strQString.indexOf("%2B")  > -1 || xss_strQString.indexOf("%2C")  > -1 ||  xss_strQString.indexOf("%3B")  > -1 || xss_strQString.indexOf("%3C")  > -1 || xss_strQString.indexOf("%3D")  > -1 || xss_strQString.indexOf("%3E")  > -1 || xss_strQString.indexOf("%3F")  > -1 || xss_strQString.indexOf("%5B")  > -1 || xss_strQString.indexOf("%5C")  > -1 || xss_strQString.indexOf("%5D")  > -1 || xss_strQString.indexOf("%5E")  > -1 || xss_strQString.indexOf("%5F")  > -1 || xss_strQString.indexOf("60%")  > -1 || xss_strQString.indexOf("%7B")  > -1 || xss_strQString.indexOf("%7C")  > -1 || xss_strQString.indexOf("%7D")  > -1 || xss_strQString.indexOf("%7E")  > -1 || xss_strQString.indexOf("80%")  > -1 )
		{
			response.sendRedirect("aggxssErrorPage.jsp?url=" + request.getRequestURI() + "&param=" + xss_strQString.replace('&','|'));
			return;
		}
	

		String xss_paramValues = "";
		String xss_paramNames = "";

		for(Enumeration xss_e = request.getParameterNames(); xss_e.hasMoreElements(); )
		{
			xss_paramNames = (String)xss_e.nextElement();
			xss_paramValues = request.getParameter(xss_paramNames);
			xss_paramValues = xss_paramValues.toLowerCase();

			if(xss_paramValues.indexOf("scriptor") < 0)
			{
				if(xss_paramValues.indexOf("%60")  > -1 || xss_paramValues.indexOf("%3f")  > -1 || xss_paramValues.indexOf("%3e")  > -1 || xss_paramValues.indexOf("%3d")  > -1 || xss_paramValues.indexOf("%3c")  > -1 || xss_paramValues.indexOf("%3b")  > -1 || xss_paramValues.indexOf("%26")  > -1 || xss_paramValues.indexOf("%22")  > -1 || xss_paramValues.indexOf("&#40")  > -1 || xss_paramValues.indexOf("&#41")  > -1 || xss_paramValues.indexOf("%27")  > -1 || xss_paramValues.indexOf("onerror")  > -1 || xss_paramValues.indexOf("javascript")  > -1 || xss_paramValues.indexOf("onclick")  > -1 ||  xss_paramValues.indexOf("%53%43%52%49%50%54")  > -1 || xss_paramValues.indexOf("&#97&#108&#101&#114&#116")  > -1 || xss_paramValues.indexOf("onunload")  > -1 || xss_paramValues.indexOf("onload") > -1 || xss_paramValues.indexOf("onabort")  > -1 || xss_paramValues.indexOf("onunload") > -1 || xss_paramValues.indexOf("javascript")  > -1 || xss_paramValues.indexOf("error")  > -1 || xss_paramValues.indexOf("onerror")  > -1 || xss_paramValues.indexOf("onabort")  > -1 || xss_paramValues.indexOf("onblur")  > -1 || xss_paramValues.indexOf("onchange")  > -1 || xss_paramValues.indexOf("onclick")  > -1 || xss_paramValues.indexOf("ondblclick")  > -1 || xss_paramValues.indexOf("onfocus")  > -1 || xss_paramValues.indexOf("onkeydown")  > -1 || xss_paramValues.indexOf("onkeypress")  > -1 || xss_paramValues.indexOf("onkeyup")  > -1 || xss_paramValues.indexOf("onload")  > -1 || xss_paramValues.indexOf("onmousedown")  > -1 || xss_paramValues.indexOf("onmousemove")  > -1 || xss_paramValues.indexOf("onmouseout")  > -1 || xss_paramValues.indexOf("onmouseover")  > -1 || xss_paramValues.indexOf("onmouseup")  > -1 || xss_paramValues.indexOf("onreset")  > -1 || xss_paramValues.indexOf("onresize")  > -1 || xss_paramValues.indexOf("onselect")  > -1 || xss_paramValues.indexOf("onsubmit")  > -1 || xss_paramValues.indexOf("onunload")  > -1 || xss_paramValues.indexOf("onselect")  > -1 || xss_paramValues.indexOf("onsubmit")  > -1  ||xss_paramValues.indexOf("%27")  > -1 ||xss_paramValues.indexOf("%3C")  > -1  ||xss_paramValues.indexOf("%3E")  > -1  ||xss_paramValues.indexOf("%28")  > -1 ||xss_paramValues.indexOf("%29")  > -1 ||xss_paramValues.indexOf("%92")  > -1  ||xss_paramValues.indexOf("%22")  > -1 ||xss_paramValues.indexOf("%5C")  > -1 ||xss_paramValues.indexOf("%2A")  > -1  ||xss_paramValues.indexOf("%3B")  > -1 ||xss_paramValues.indexOf("%3D")  > -1 ||xss_paramValues.indexOf("%7B")  > -1 ||xss_paramValues.indexOf("%7D")  > -1 ||xss_paramValues.indexOf("%60")  > -1 ||xss_paramValues.indexOf("%25")  > -1  ||xss_paramValues.indexOf("%2B")  > -1||xss_paramValues.indexOf("%5E")  > -1  ||xss_paramValues.indexOf("%21")  > -1 ||xss_paramValues.indexOf("%5Cx00-%5Cx20")  > -1)
				{
					response.sendRedirect("aggxssErrorPage.jsp?xss_paramNames="+xss_paramNames+"&xss_paramValues="+xss_paramValues+"&url="+request.getRequestURI()+"&param="+request.getQueryString());
					return;
				}
			}
			if(xss_paramValues.indexOf("scriptor") < 0)
			{
				
					if(xss_paramValues.indexOf("!")  > -1 || xss_paramValues.indexOf("\"")  > -1 || xss_paramValues.indexOf("#")  > -1 ||xss_paramValues.indexOf("$")  > -1 ||xss_paramValues.indexOf("%")  > -1 || xss_paramValues.indexOf("&")  > -1 || xss_paramValues.indexOf("'")  > -1 || xss_paramValues.indexOf("(")  > -1 || xss_paramValues.indexOf(")")  > -1 ||xss_paramValues.indexOf("*")  > -1 ||xss_paramValues.indexOf("+")  > -1 ||xss_paramValues.indexOf(";")  > -1 ||xss_paramValues.indexOf("<")  > -1 ||xss_paramValues.indexOf("=")  > -1 ||xss_paramValues.indexOf(">")  > -1 || xss_paramValues.indexOf("?")  > -1 ||xss_paramValues.indexOf("[")  > -1 ||xss_paramValues.indexOf("\\")  > -1 || xss_paramValues.indexOf("]")  > -1 || xss_paramValues.indexOf("^")  > -1 ||xss_paramValues.indexOf("`")  > -1 || xss_paramValues.indexOf("{")  > -1 || xss_paramValues.indexOf("|")  > -1 || xss_paramValues.indexOf("}")  > -1 || xss_paramValues.indexOf("~")  > -1 || xss_paramValues.indexOf("`")  > -1 || xss_paramValues.indexOf("20%")  > -1 || xss_paramValues.indexOf("21%")  > -1 || xss_paramValues.indexOf("22%")  > -1 || xss_paramValues.indexOf("23%")  > -1 || xss_paramValues.indexOf("24%")  > -1 || xss_paramValues.indexOf("25%")  > -1 || xss_paramValues.indexOf("26%")  > -1 || xss_paramValues.indexOf("27%")  > -1 || xss_paramValues.indexOf("28%")  > -1 || xss_paramValues.indexOf("29%")  > -1 || xss_paramValues.indexOf("%2A")  > -1 || xss_paramValues.indexOf("%2B")  > -1 || xss_paramValues.indexOf("%2C")  > -1 ||  xss_paramValues.indexOf("%3B")  > -1 || xss_paramValues.indexOf("%3C")  > -1 || xss_paramValues.indexOf("%3D")  > -1 || xss_paramValues.indexOf("%3E")  > -1 || xss_paramValues.indexOf("%3F")  > -1 || xss_paramValues.indexOf("%5B")  > -1 || xss_paramValues.indexOf("%5C")  > -1 || xss_paramValues.indexOf("%5D")  > -1 || xss_paramValues.indexOf("%5E")  > -1 || xss_paramValues.indexOf("%5F")  > -1 || xss_paramValues.indexOf("60%")  > -1 || xss_paramValues.indexOf("%7B")  > -1 || xss_paramValues.indexOf("%7C")  > -1 || xss_paramValues.indexOf("%7D")  > -1 || xss_paramValues.indexOf("%7E")  > -1  || xss_paramValues.indexOf("80%")  > -1  || xss_paramValues.indexOf("script")  > -1  || xss_paramValues.indexOf("alert")  > -1  || xss_paramValues.indexOf("href")  > -1)
				
				{
					
				response.sendRedirect("aggxssErrorPage.jsp?xss_paramNames="+xss_paramNames+"&xss_paramValues="+xss_paramValues+"&url="+request.getRequestURI()+"&param="+request.getQueryString());
				return;
				}
			}
			
			
			if(xss_paramValues.indexOf("scriptor") < 0)
			{
				if(xss_paramValues.indexOf("NUL") > -1  ||  xss_paramValues.indexOf("%00") > -1 ||  xss_paramValues.indexOf("SOH") > -1  || xss_paramValues.indexOf("%01") > -1  || xss_paramValues.indexOf("STX") > -1  || xss_paramValues.indexOf("%02") > -1  || xss_paramValues.indexOf("ETX") > -1  || xss_paramValues.indexOf("%03") > -1  || xss_paramValues.indexOf("EOT") > -1  || xss_paramValues.indexOf("%04") > -1  || xss_paramValues.indexOf("ENQ") > -1  || xss_paramValues.indexOf("%05") > -1  ||  xss_paramValues.indexOf("ACK") > -1  || xss_paramValues.indexOf("%06") > -1  ||  xss_paramValues.indexOf("BEL") > -1  || xss_paramValues.indexOf("%07")  > -1  ||  xss_paramValues.indexOf("BS") > -1   || xss_paramValues.indexOf("%08")  > -1  ||  xss_paramValues.indexOf("HT") > -1   || xss_paramValues.indexOf("%09")  > -1  ||   xss_paramValues.indexOf("LF") > -1   || xss_paramValues.indexOf("%0A") > -1  ||  xss_paramValues.indexOf("VT") > -1   || xss_paramValues.indexOf("%0B") > -1  ||   xss_paramValues.indexOf("FF") > -1   || xss_paramValues.indexOf("%0C") > -1  ||  xss_paramValues.indexOf("CR") > -1   || xss_paramValues.indexOf("%0D") > -1  ||   xss_paramValues.indexOf("SO") > -1   || xss_paramValues.indexOf("%0E") > -1  ||   xss_paramValues.indexOf("SI") > -1   || xss_paramValues.indexOf("%0F") > -1  ||   xss_paramValues.indexOf("DLE") > -1   || xss_paramValues.indexOf("%10") > -1  ||   xss_paramValues.indexOf("DC1") > -1   || xss_paramValues.indexOf("%11") > -1  ||   xss_paramValues.indexOf("DC2") > -1   || xss_paramValues.indexOf("%12") > -1  || xss_paramValues.indexOf("DC3") > -1   || xss_paramValues.indexOf("%13") > -1  ||   xss_paramValues.indexOf("DC4") > -1   || xss_paramValues.indexOf("%14") > -1  || xss_paramValues.indexOf("NAK") > -1   || xss_paramValues.indexOf("%15") > -1  ||  xss_paramValues.indexOf("SYN") > -1   || xss_paramValues.indexOf("%16") > -1  || xss_paramValues.indexOf("ETB") > -1   || xss_paramValues.indexOf("%17") > -1  || xss_paramValues.indexOf("CAN") > -1   || xss_paramValues.indexOf("%18") > -1  ||  xss_paramValues.indexOf("EM") > -1   || xss_paramValues.indexOf("%19") > -1  ||  xss_paramValues.indexOf("SUB") > -1   || xss_paramValues.indexOf("%1A") > -1  ||  xss_paramValues.indexOf("ESC") > -1   || xss_paramValues.indexOf("%1B") > -1  ||  xss_paramValues.indexOf("FS") > -1   || xss_paramValues.indexOf("%1C") > -1 ||  xss_paramValues.indexOf("GS") > -1   || xss_paramValues.indexOf("%1D")  > -1  ||  xss_paramValues.indexOf("RS") > -1   || xss_paramValues.indexOf("%1E") > -1  ||   xss_paramValues.indexOf("US") > -1   || xss_paramValues.indexOf("%1F") >-1  )	
				{
					
				response.sendRedirect("aggxssErrorPage.jsp?xss_paramNames="+xss_paramNames+"&xss_paramValues="+xss_paramValues+"&url="+request.getRequestURI()+"&param="+request.getQueryString());
				return;
				}
			}
			
			
	
		}// end of FOR
		
}
catch(Exception e)
{
}
%>