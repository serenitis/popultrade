<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.util.Date"%>
<jsp:useBean id="reader" scope="page" class="com.orange.fupload.MultiPartRequest" type="com.orange.fupload.MultiPartRequest" />
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />

<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 

<jsp:useBean id="certificate" scope="request" class="com.popultrade.webapp.keystoreUtility" />
<%
  request.setCharacterEncoding(control.encoding); 
response.setContentType("text/html; charset="+control.encoding);
  response.addHeader("Pragma" , "No-cache") ;
  response.addHeader("Cache-Control", "no-cache") ; 
response.addDateHeader("Expires", 0);  


if (!control.getPravica()) {
%><jsp:forward page="login.html"/><%
}

%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">
</head>
<%!
public String strConvert(String str, String enc)
	{String returnValue;
		if(str==null) return "";
		try{
		byte[] buff=str.getBytes();
		// TODO: Add your own implementation.
		 returnValue=new String(buff,enc);
		}catch(Exception e){return "error:"+e;};
		return returnValue;
	}
%>

<%

try {
%>
<script language="javascript">

function gum() {

}
</script>
<body bgcolor="white" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">
<table border=0 width="100%" cellpadding="2" style="border-collapse: collapse; font-family:Verdana; font-size:8pt" >
<tr><td bgcolor=#C3E1FC  colspan="2"	>
&nbsp;</td>
</tr>
<%
System.out.println("XXXXXXXXXXXXCCCCCCCCCCCCCCCCCC");
////////////// upload parametri ///////////////////////
reader.setMaxLength(60000000);
reader.setBufferSize(100000);
/// filter
String[] fltr={"pfx"};
reader.setFilterToUpload(fltr);
reader.prepareProcess(request);
String filenamee= "";
String pName;
int size;
boolean isHeader;
ServletContext scon=pageContext.getServletContext();
String path = scon.getRealPath("WEB-INF/certifikati"); ///// direktorij, z contextom je znotraj tomcata, ce ne le stringo path
reader.setTempDirectory(path);
//////////////////////////////////////////////////
String ext="";
boolean jeok=false;
Hashtable parameters = new Hashtable();
boolean pas = false;
while(reader.nextHeader()){
///// ce gre za file ga posnamem, ce ne preskocim in grem na naslednjega

//// password



if(reader.isFile()){
  System.out.println("111");
filenamee=reader.getCurrentFileName();
ext= reader.getCurrentExtension();
System.out.println("111222");
String em;
/////// kontrola , ce je prazen
if(reader.isCurrentEmpty()) {
em="Datoteka neuspesno prebrana";
}
else {
em="Datoteka uspesno prebrana";
}
System.out.println("1113333");

if (ext.equals("pfx") || ext.equals("cer") ) { ///// uporabim ce imam cer pogoj ext
System.out.println("1115555");
//// posnamem
jeok=false;
if (ext.equals("pfx") || ext.equals("cer") ) {///// uporabim ce imam cer pogoj ext
  System.out.println("1116666");
//  reader.setCurrentFileName(control.user_sifra+".keystore");///// uporabim ce imam pfx
  reader.setCurrentFileName(filenamee);///// uporabim ce nimam pfx
  reader.saveNextPart();
  System.out.println("1117777");
//  reader.Clear();
  //// dodam certifikat, ce je ok
  
  



  //// kopiram keystore prazen za dati not novi certifikat
  //// prej kontrola, ce obstaja
  File fi = new File(scon.getRealPath("WEB-INF/certifikaticer")+"/cer_"+control.user_sifra+".keystore"); ///// uporabim ce nimam pfx
  boolean jecp=true;///// uporabim ce nimam pfx
  if (!fi.exists()) {///// uporabim ce nimam pfx
jecp=  certificate.copyFile(scon.getRealPath("WEB-INF/defaultcer")+"/atbiznet.keystore",scon.getRealPath("WEB-INF/certifikaticer")+"/cer_"+control.user_sifra+".keystore");///// uporabim ce nimam pfx


  }///// uporabim ce nimam pfx


  if (jecp) {
 /// System.out.println("-----------------: "+scon.getRealPath("WEB-INF/certifikati")+"/"+filenamee);
jeok=  certificate.addCertificate(scon.getRealPath("WEB-INF/certifikaticer")+"/cer_"+control.user_sifra+".keystore","atbiznet",control.user_sifra,scon.getRealPath("WEB-INF/certifikati")+"/"+filenamee);///// uporabim ce nimam pfx
jeok=true;
}

///  presnamem certifikat in mu dam drugo ime
  File fior = new File(scon.getRealPath("WEB-INF/certifikati")+"/"+filenamee); ///// uporabim ce nimam pfx

  
  File fio2 = new File(scon.getRealPath("WEB-INF/certifikati_strank")+"/"+control.getUser()+"_"+filenamee); ///// uporabim ce nimam pfx

fior.renameTo(fio2);

}
if (jeok) {
  %>


  <tr><td bgcolor=#E3F1FE width="400"	>
    <table border="0" width="100%" style="font-family: Verdana; font-size: 8pt">
		<tr>
			<td width="186"><span style="font-size: 9pt">Ime datoteke:  &nbsp;</span></td>
			<td bgcolor="#C3E1FC" width=220><b><span style="font-size: 9pt"><%=filenamee%>&nbsp;</span></b></td>
		</tr>
		<tr>
			<td width="186"><span style="font-size: 9pt">Vrsta datoteke: &nbsp;</span></td>
			<td bgcolor="#C3E1FC"><b><span style="font-size: 9pt"><%=ext%>&nbsp;</span></b></td>
		</tr>
		<tr>
			<td width="186"><span style="font-size: 9pt">Status datoteke: &nbsp;</span></td>
			<td bgcolor="#C3E1FC"><b><span style="font-size: 9pt"><%=em%>&nbsp;</span></b></td>
		</tr>
		<tr>
			<td width="186"><span style="font-size: 9pt">Certifikat: &nbsp;</span></td>
			<td bgcolor="#C3E1FC"><b><span style="font-size: 9pt"><%=jeok?"Privaten kljuc uspesno shranjen":"Privaten kljuc neuspesno shranjen"%>&nbsp;</span></b></td>
		</tr>
	</table>

</td></tr>
<%
break;
}
else {
//// zbrisem certifikat
reader.Clear();
File fi = new File(scon.getRealPath("WEB-INF/certifikati")+"/"+control.user_sifra+filenamee);
fi.delete();
}
}
else {

  %>


  <tr><td bgcolor=#E3F1FE width="575"	>
    <b><font size="2" color="#CC0000">Napaka:</font></b><font size="2"> Certifikat ni pravilen!
	</font>  <br>


</td></tr>
<%
}
}
else {

pas=true;
//System.out.println("--------------------++++++++++++++++++++++" + reader.);
///parameters.put("password",reader.getField("password"));
//System.out.println(reader.getCurrentFieldName());
reader.nextPart();

}
}
%>

<%
//// ocistim reader
//reader.Clear();

//// zapisem certifikat v bazo
if ((ext.equals("pfx") || ext.equals("cer")) && jeok) {///// uporabim ce imam cer pogoj ext
	
	
	com.popultrade.dao.UsersDAO dao = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
	 
com.popultrade.model.Users us = dao.getUsers(control.idUporabnika);
	
	
//String zapb = "update user set privatekey='"+filenamee+"',certifikat='' where sifra_user='"+control.user_sifra+"'";

us.setCertifikat_file(control.getUser()+"_"+filenamee);

dao.saveUsers(us);

//dbConnect.queryString(zapb,con);
}
%>


<%
/////////////// klicem funkcijo, ki kontrolira txt file
if (!filenamee.equals("")) {



}
%>


<%
}
catch (Exception ex) {
    %>


  <tr><td bgcolor=#E3F1FE width="575"	>
    <b><font size="2" color="#CC0000">Napaka:</font></b><font size="2"> Certifikat ni pravilen!
	</font>  <br>


</td></tr>

<%
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());

log.error(ex.toString());
}

%>
<tr><td bgcolor=#C3E1FC  colspan="2" align="center"	>
<input type=button value="  OK  " onclick="parent.frames[0].location='nastavitve.jsp'" style="font-family: Verdana; font-size: 8pt"></td>
</tr>
</table>
</body>
</html>
