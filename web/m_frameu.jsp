<%@ page contentType="text/html; charset=utf-8" %>
<%
String userAgent = request.getHeader( "User-Agent" );
boolean isFirefox = ( userAgent != null && userAgent.indexOf( "Firefox/" ) != -1 );
String size="0";
String scrol = "yes";
if (isFirefox) {
size="1";
scrol="yes";
}


//response.setHeader( "Vary", "User-Agent" );
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>popultrade Admin</title>
</head>
<SCRIPT LANGUAGE=JavaScript>


</SCRIPT>


<frameset framespacing="0" border="<%=size%>" frameborder="<%=size%>" rows="67,23%,23%,*">
  <frame name="top" scrolling="no" noresize target=prva src="m_glavau.jsp" style="border-style: solid; border-width: 1">
  <frame name="prva" src="nic.jsp"  marginheight="1"    scrolling="<%=scrol %>"    style="border-style: solid; border-width: 1">
  <frame name="druga" src="nic.jsp"  marginheight="1"    scrolling="<%=scrol %>"   style="border-style: solid; border-width: 1">
<frame name="tretja" src="nic.jsp"  marginheight="1"    scrolling="<%=scrol %>"    style="border-style: solid; border-width: 1">

  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
