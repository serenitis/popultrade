<%@ page contentType="text/html; charset=windows-1250" import="jxl.*,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.util.Date,org.w3c.dom.*,javax.xml.xpath.*"%>
<jsp:useBean id="reader" scope="page" class="com.orange.fupload.MultiPartRequest" type="com.orange.fupload.MultiPartRequest" />
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<%
request.setCharacterEncoding(control.encoding); 
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ; 
response.addDateHeader("Expires", 0);  
if (!control.getPravica()) {
%><jsp:forward page="logout.jsp"/><%
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">
</head>
<%
boolean jeok=false;
String napaka="";
try {
%>
<body bgcolor="white" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="remo()">
<table border=0 width="100%" cellpadding="2" style="border-collapse: collapse; font-family:Verdana; font-size:8pt" >
<tr><td bgcolor=#C3E1FC  colspan="2"	>
&nbsp;</td>
</tr>
<%
reader.setMaxLength(2000*1024);
reader.setBufferSize(100000);
String[] fltr={"txt","xml","pdf","xsl","xls"};
reader.setFilterToUpload(fltr);
reader.prepareProcess(request);
String filenamee= "";
String pName;
int size;
boolean isHeader;
ServletContext scon=pageContext.getServletContext();
String path = scon.getRealPath("d:/"); // direktorij, kamor dam xls datoteke z mrnji
reader.setTempDirectory(path);
String ext="";
Hashtable parameters = new Hashtable();
boolean pas = false;
while(reader.nextHeader()){
if(reader.isFile()){
filenamee=reader.getCurrentFileName();
ext= reader.getCurrentExtension();
String em;
if(reader.isCurrentEmpty()) {
em="Datoteka neuspesno prebrana";
}
else {
em="Datoteka uspesno prebrana";
}
if (true) {// uporabim ce imam cer pogoj ext
jeok=false;
if (true) {// uporabim ce imam cer pogoj ext
reader.setCurrentFileName(filenamee);// uporabim ce nimam pfx
reader.saveNextPart();





File fior = new File(scon.getRealPath("UserFiles/")+""+filenamee); // 

com.popultrade.dao.ObvestilaDAO daof = (com.popultrade.dao.ObvestilaDAO)contextUtil.getBeanDao("obvestilaDAO",pageContext.getServletContext());


PreparedStatement sta = daof.




if (jeok) {
%>
<tr><td bgcolor=#E3F1FE width="800"	>
<table border="0" width="100%" style="font-family: Verdana; font-size: 8pt">
<tr>
<td ><span style="font-size: 9pt">Ime datoteke:  &nbsp;</span></td>
<td bgcolor="#C3E1FC" width=220><b><span style="font-size: 9pt"><%=filenamee%>&nbsp;</span></b></td>
</tr>
<tr>
<td ><span style="font-size: 9pt">Vrsta datoteke: &nbsp;</span></td>
<td bgcolor="#C3E1FC"><b><span style="font-size: 9pt"><%=ext%>&nbsp;</span></b></td>
</tr>
<tr>
<td ><span style="font-size: 9pt">Status datoteke: &nbsp;</span></td>
<td bgcolor="#C3E1FC"><b><span style="font-size: 9pt"><%=em%>&nbsp;</span></b></td>
</tr>
</table>
</td></tr>
<%
break;
}
else {
reader.Clear();
File fi = new File(scon.getRealPath("d:/")+"/"+filenamee);
fi.delete();
}
}
else {
%>
<tr><td bgcolor=#E3F1FE width="575"	>
<b><font size="2" color="#CC0000">Napaka:</font></b><font size="2"> Datoteka ni pravilna!
</font>  <br>
</td></tr>
<%
}
}
else {
pas=true;
reader.nextPart();
}
}
%>
<%
if (!filenamee.equals("")) {
session.setAttribute("upload_file",control.getUser()+"_"+filenamee);
session.setAttribute("upload_file_path",scon.getRealPath("d://arhiv")+"/"+control.getUser()+"_"+filenamee);
}
%>
<%
}
catch (Exception ex) {
%>
<tr><td bgcolor=#E3F1FE width="575"	>
<b><font size="2" color="#CC0000">Napaka:</font></b><font size="2">  datoteka ni v pravilnem formatu!
</font>  <br>
</td></tr>
<%
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
if (!napaka.equals("")) {
jeok=false;
%>
<tr><td bgcolor=#E3F1FE width="575"	>
<b><font size="2" color="#CC0000">Napaka:</font></b><font size="2"> <%=napaka %>
</font>  <br>
</td></tr>
<%	
}
%>
<tr><td bgcolor=#C3E1FC  colspan="2" align="center"	>&nbsp;
<inpudt type=button value="  Nazaj na upload  " onclick="esd10_upload2.jsp" style="font-family: Verdana; font-size: 8pt"></td>
</tr>
</table>
<script language=javascript> 
function remo() {
<%
if (jeok) {
%>
document.location="stevci_ur3244.jsp";
<%
}
%>
}
</script>
</body>
</html>
