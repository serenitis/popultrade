<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="genXML" scope="request" class="com.popultrade.webapp.ParseXML" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A"))) {
%><jsp:forward page="logout.jsp"/><%
}


boolean jenew = false;
try {
	
 if (nul.jeNull(request.getParameter("akcijaXY")).equals("NEW")) {
	 
	 
	 
	 Part filePart = request.getPart("blobb");
	 if (filePart!=null) {
	 String fileName = filePart.getSubmittedFileName();
	 
	 
	 if (fileName!=null && fileName.toLowerCase().indexOf("xml")!=-1) {
		 InputStream fileContent = filePart.getInputStream();
	genXML.getXMLStructure(fileContent, contextUtil, pageContext.getServletContext(),new Long(request.getParameter("idconv")));
	
	jenew = true;
	 }
	 
	 }
	 
	 
	 }
 
	//System.out.println(genXML.getPathFromIdTag(new Long(443), contextUtil, pageContext.getServletContext()));
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
//enctype="multipart/form-data" 
if (jenew) {
	String co=request.getParameter("idconv");
%>
 <script language="javascript">
 document.location = 'm_templatexml_list.jsp?idg=<%=co %>';
 </script>
<%
}
else {
%>


<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barveold.css";
@import "tooltipcss.css";
@import "barveblue.css";
</style>



<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type="text/javascript" src="ezcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<link rel="stylesheet" type="text/css" href="ezcalendar.css" />
<script language='javascript' src='popcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<body   style="margin: 0"  onload="mom()">







<form name=dod action="m_templatexml.jsp" method="post"  enctype="multipart/form-data"   onSubmit="">

<input type=hidden name="akcijaXY" value="NEW">
<input type=hidden name="idconv" value="<%=request.getParameter("idconv")%>">
<table border="0" cellspacing="1" class="fonti"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Upload XML:</td><td class="valuecell"  colspan="3">
<input type="file"  tabindex='66' id="blobb"  name="blobb"      style="border: 0px solid #D2EAFF;font-family: Verdana; font-size: 8pt;"    >

</td></tr>
<tr><td colspan="4" class="opiscell" align="center"><input id="submitbutton"  type=submit value="Upload"  class="fontisubmit"> &nbsp;</td></tr></table></form>



</body></html>
<%
}
%>
