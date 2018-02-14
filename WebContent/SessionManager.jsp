<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
// It allows the caching
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 This specifies that the page contains information //intended for a single user only and must not be cached by a shared cache (e.g. a proxy server).
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
//This specifies that a cache must NOT store any part of the response or the request that elicited it
response.setHeader("Cache-Control", "max-stale=0"); // HTTP 1.1
//This tells the cache that the maximum acceptable staleness of a page is 0 seconds.
//Integer back = (Integer) session.getAttribute("BACK");
//int b = back.intValue();
//--b;
//session.setAttribute("BACK",new Integer(b));
/* response.addHeader("x-content-type-options", "nosniff");
response.addHeader("X-Frame-Options", "SAMEORIGIN");
response.addHeader("x-xss-protection", "1; mode=block"); */
%>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="x-content-type-options" content="nosniff">
<meta http-equiv="X-Frame-Options" content="SAMEORIGIN">
<meta http-equiv="x-xss-protection" content="1; mode=block">
<meta http-equiv="X-UA-Compatible" content="IE=10;IE=9; IE=8; IE=7" />