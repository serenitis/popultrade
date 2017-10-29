<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="reader" scope="page" class="com.orange.fupload.MultiPartRequest" type="com.orange.fupload.MultiPartRequest" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}


boolean jeok=false;
String napaka="";


try {


%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {

//parent.frames[2].location="nic.jsp";
}
</script>
<body bgcolor="white" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onlload="remo()">
<table border=0 width="100%" cellpadding="2" style="border-collapse: collapse; font-family:Verdana; font-size:8pt" >
<tr><td bgcolor=#C3E1FC  colspan="2"	>
&nbsp;</td>
</tr>
<%
//System.out.println("XXXXXXXXXXXXCCCCCCCCCCCCCCCCCC");
////////////// upload parametri ///////////////////////


String lok_slik = control.lokacija_default_slik;

if (nul.jeNull(session.getAttribute("slik")+"").equals("splosne")) {
 lok_slik = control.lokacija_splosno_slik;
}
else if (nul.jeNull(session.getAttribute("slik")+"").equals("css")) {
lok_slik = control.lokacija_css_slik;
}
 

reader.setMaxLength(60000000);
reader.setBufferSize(100000);
/// filter
String[] fltr={"png","gif","jpg"};
reader.setFilterToUpload(fltr);
reader.prepareProcess(request);
String filenamee= "";
String pName;
int size;
boolean isHeader;
//ServletContext scon=pageContext.getServletContext();
System.out.println("SLIKKKKK "+session.getAttribute("slik"));
//String path = scon.getRealPath(lok_slik); ///// direktorij, kamor dam xls datoteke z mrnji
String path =request.getRealPath("")+"/"+ lok_slik;
reader.setTempDirectory(path);
//////////////////////////////////////////////////
String ext="";

Hashtable parameters = new Hashtable();
boolean pas = false;
while(reader.nextHeader()){
///// ce gre za file ga posnamem, ce ne preskocim in grem na naslednjega

//// password



if(reader.isFile()){
 // System.out.println("111");
filenamee=reader.getCurrentFileName();
ext= reader.getCurrentExtension();
//System.out.println("111222");
String em;
/////// kontrola , ce je prazen
if(reader.isCurrentEmpty()) {
em="Datoteka neuspesno prebrana";
}
else {
em="Datoteka uspesno prebrana";
}
//System.out.println("1113333");

if (ext.equals("gif") || ext.equals("png") || ext.equals("jpg") ) { ///// uporabim ce imam cer pogoj ext
//System.out.println("1115555");
//// posnamem
jeok=false;
if (ext.equals("gif")  || ext.equals("png") || ext.equals("jpg") ) {///// uporabim ce imam cer pogoj ext
// System.out.println("1116666");
//  reader.setCurrentFileName(control.user_sifra+".keystore");///// uporabim ce imam pfx
String nfile = nul.getDatumFormatFromDate((new Date()), "ddMMyyyyHHmmsss")+"."+ext;
if (nul.jeNull(session.getAttribute("slik")+"").equals("css")) {
nfile = filenamee+"."+ext;
}

  reader.setCurrentFileName(nfile);///// uporabim ce nimam pfx
  reader.saveNextPart();

// System.out.println("1116666 2");
  jeok= true;
  
}
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
//// zbrisem certifikat
//System.out.println("--------------------++++++++++++++++++++++11" );
reader.Clear();
//System.out.println("--------------------++++++++++++++++++++++22" );

//System.out.println("--------------------++++++++++++++++++++++33" );
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
System.out.println("--------------------++++++++++++++++++++++" );
///parameters.put("password",reader.getField("password"));
//System.out.println(reader.getCurrentFieldName());
reader.nextPart();

}
}

 %>
 
 </table></body></html>
 
 <%
}
catch (Exception ex) {
    
    System.out.println("NAPAKA UPLOAD DEFAULT SLIK : "+ex.toString());
    }
    %>
    
 

