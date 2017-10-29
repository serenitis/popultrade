<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}
%>
 
<%
try {
boolean bok=false;
com.popultrade.model.Users vseb =new com.popultrade.model.Users();
com.popultrade.dao.UsersDAO dao = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getUsers(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getUsers(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	
	
 
//vseb = (com.popultrade.model.Users)contextUtil.getPopulatedObject(vseb,request);








//// naredim certifikat na disku 
/*if (nul.jeNull(request.getParameter("revokecy")).equals("yes")) {
	
	
	
}
else {*/
     try {  
          File directory1 = new File(control.getLocation_certificate());
            System.out.println(directory1.toString());
            String commandArray = control.getLocation_openssl()+ "openssl genrsa -out "+request.getParameter("imec")+".key 2048";
          Process p2 = Runtime.getRuntime().exec(commandArray, null, directory1);
int returnCode = p2.waitFor();


System.out.println(directory1.toString());
	String commandArray2 = control.getLocation_openssl()+ "openssl req -new -key "+request.getParameter("imec")+".key  -out "+request.getParameter("imec")+".csr -subj \"/C="+request.getParameter("cc")+"/ST="+request.getParameter("cst")+"/L="+request.getParameter("cl")+"/O="+request.getParameter("co")+"/OU="+request.getParameter("cou")+"/CN="+request.getParameter("ccn")+"\" ";
Process p3 = Runtime.getRuntime().exec(commandArray2, null, directory1);
returnCode = p3.waitFor();


	String commandArray3 = control.getLocation_openssl()+ "openssl ca -batch -keyfile "+control.getLocation_cer_CA()+".key -days "+(nul.jeNull(request.getParameter("daysc")).equals("")?"365":request.getParameter("daysc"))+" -cert "+control.getLocation_cer_CA()+".crt -out "+request.getParameter("imec")+".crt -policy policy_anything -infiles "+request.getParameter("imec")+".csr";
Process p4 = Runtime.getRuntime().exec(commandArray3, null, directory1);

BufferedReader br = new BufferedReader(new InputStreamReader(p4.getInputStream()));
p4.waitFor();


p4.destroy();

String commandArray4 = control.getLocation_openssl()+ "openssl pkcs12 -export -in "+request.getParameter("imec")+".crt  -inkey "+request.getParameter("imec")+".key -out "+request.getParameter("imec")+".p12 -name "+request.getParameter("imec")+" -password pass:"+request.getParameter("gesloc")+"";
Process p5 = Runtime.getRuntime().exec(commandArray4, null, directory1);

returnCode = p5.waitFor();


/// kopiram certifikat za download

File fit = new File(control.getLocation_certificate()+request.getParameter("imec")+".p12");

String path =request.getRealPath("")+"/certifikati/"+request.getParameter("imec")+".p12";

File fit2 = new File(path);


fit.renameTo(fit2);



    } catch (IOException e) {  
    	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
    	
    	log.error(e.toString());
    } 







vseb.setCcert(""+request.getParameter("imec")+".p12");


vseb.setCgeslo(""+request.getParameter("gesloc"));



dao.saveUsers(vseb);

//}






 
}
}
 
Hashtable ht =new Hashtable();


ht.put("ime certifikata","imec");
ht.put("drzava","cc");
ht.put("pokrajina/state","cst");

ht.put("mesto","cl");

ht.put("canonical name","ccn");
ht.put("firma/organizacija","co");
ht.put("organizacijska enota","cou");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%>
 
<html><head><title>spreminjaj</title></head>
 
<style type=text/css> 
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
 
 
 
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="m_users_cert.jsp" method="post" onSubmit="return check()">
 
<%
if (vseb.getId()!=null && !vseb.getId().equals("")) {
%>
<input type=hidden name="akcija" value="UPDATE">
<%
}
else {
	%>
	<input type=hidden name="akcija" value="NEW">
	<%	
}


if (nul.jeNull(request.getParameter("isk")).equals("1")) {
	%>
	<input type=hidden name="isk" value="1">
	<%
}


//C=GB/ST=Longdon/L=Logndon/O=Global Securgity/OU=IT Depagrtment/CN=ihuta.cgom
//CN=examdple.comf, OU=IT Department, O=Global Security, L=London, ST=London, C=GB
String c="";
String st="";
String l="";
String o="";
String ou="";
String cn="";
String geslo=nul.jeN(vseb.getCgeslo());

if (vseb.getCinfo()!=null && !vseb.getCinfo().equals("") ) {
	
	String re = vseb.getCinfo();
	
	if (re.indexOf("C=")!=-1) {
		String rx = re.substring(re.indexOf("C=")+2);
		if (rx.indexOf(",")!=-1) {
			c = rx.substring(0,rx.indexOf(","));
		}
		else {
			c=rx;
		}
	}
	if (re.indexOf("ST=")!=-1) {
		String rx = re.substring(re.indexOf("ST=")+3);
		if (rx.indexOf(",")!=-1) {
			st = rx.substring(0,rx.indexOf(","));
		}
		else {
			st=rx;
		}
	}
	if (re.indexOf("L=")!=-1) {
		String rx = re.substring(re.indexOf("L=")+2);
		if (rx.indexOf(",")!=-1) {
			l = rx.substring(0,rx.indexOf(","));
		}
		else {
			l=rx;
		}
	}
	if (re.indexOf("O=")!=-1) {
		String rx = re.substring(re.indexOf("O=")+2);
		if (rx.indexOf(",")!=-1) {
			o = rx.substring(0,rx.indexOf(","));
		}
		else {
			o=rx;
		}
	}
	if (re.indexOf("OU=")!=-1) {
		String rx = re.substring(re.indexOf("OU=")+3);
		if (rx.indexOf(",")!=-1) {
			ou = rx.substring(0,rx.indexOf(","));
		}
		else {
			ou=rx;
		}
	}
	if (re.indexOf("CN=")!=-1) {
		String rx = re.substring(re.indexOf("CN=")+3);
		if (rx.indexOf(",")!=-1) {
			cn = rx.substring(0,rx.indexOf(","));
		}
		else {
			cn=rx;
		}
	}
}






%>
 
 
 
 
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
 <input type=hidden name="idback" value="<%=nul.jeNull(vseb.getId()+"")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
     	  <tr>
            		  
            		 <td class="valuecell" colspan="4" height="30"><strong>Kreacija certifikata </strong><Br>
            		 	 (za pravilno delovanje je treba postimat pathe za openssl in definirat OPENSSL_CONF v envirnment variable)
            		 
            		 </td></tr>
            		 
            		   	  <tr>
            		   	  
            		   	  
            	<tr>	  
            		 <td class="opiscell" width="20%">Ime certifikata: </td><td class="valuecell" width="30%">
            		 
            		  <input type="text" name="imec" value="cer_<%=vseb.getUsername() %>" readonly=readonly size="31" maxlength="30" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Password/Geslo za certifikat: </td><td class="valuecell" width="30%">
            		  <input type="text" name="gesloc" value="<%=geslo %>" size="31" maxlength="30" style="font-family: Verdana; font-size: 8pt">
            		</td>
            		 
            		  </tr>
            		   	  
            		  	  <tr>
            		  
            		 <td class="valuecell" colspan="4" height="30">Podatki za certifikat
            		 
            		 
            		 </td></tr> 	  
            		   	       	<tr>	  
            		 <td class="opiscell" width="20%">Drzava (C): </td><td class="valuecell" width="30%">
            		 
            		  <input type="text" name="cc" value="<%=c %>" size="3" maxlength="2" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Regija (ST): </td><td class="valuecell" width="30%">
            		 <input type="text" name="cst" value="<%=st %>" size="36" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
            		
            		 
            		  </tr> 
            		   	  
            		   	  
            		   	  
            		   	    	<tr>	  
            		 <td class="opiscell" width="20%">Mesto (L): </td><td class="valuecell" width="30%">
            		 
            		  <input type="text" name="cl" value="<%=l %>" size="36" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Firma/organizacija (O): </td><td class="valuecell" width="30%">
            		 <input type="text" name="co" value="<%=o %>" size="36" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
            		
            		 
            		  </tr> 
            		   	  
            		   	  
            		   	  
             	  
            		   	    	<tr>	  
            		
            		 <td class="opiscell" width="20%">Organizacijska enota: </td><td class="valuecell" width="30%">
            		 
            		   <input type="text" name="cou" value="<%=ou %>" size="36" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
            		
            		 <td class="opiscell" width="20%">Canonical name (ime stranke ali ime www) (CN): </td><td class="valuecell" width="30%">
            		 
            		  <input type="text" name="ccn" value="<%=!cn.equals("")?cn:(vseb.getIme() +" "+vseb.getPriimek()) %>" size="41" maxlength="40" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 
            		  </tr>   		   	  
            		   	  

    	    	<tr>	  
            		
            		 <td class="opiscell" width="20%">Trajanje certifikata: </td><td class="valuecell" width="30%">
            		 
            		   <input type="text" name="daysc" value="" size="5" maxlength="4" style="font-family: Verdana; font-size: 8pt"> dni</td>
            		
            		 <td class="opiscell" width="20%"> </td><td class="valuecell" width="30%">
            		 
            	</td>
            		 
            		 
            		  </tr>   
            		  
            	<%
            	if (vseb.getCcert()!=null && !vseb.getCcert().equals("") && 2==1) {
            	
            	%>	  
            		  
 	    	<tr>	  
            		
            		 <td class="opiscell" width="20%"> </td><td class="valuecell" width="30%">
            		 
            		 </td>
            		
            		 <td class="opiscell" width="20%">Revoke certificate: </td><td class="valuecell" width="30%">
            		<input type=button value="Revoke certificate"   style="font-family: Verdana; font-size: 8pt" onclick="revoke()">
            		<input type="hidden" name="revokec" value="<%=vseb.getCcert().substring(0,vseb.getCcert().indexOf("."))%>">
            		<input type="hidden" name="revokecy" value="">
            	</td>
            		 
            		 
            		  </tr>   
            		  <%
            		  ///            		  
            		///  C:\OpenSSL-Win32\gencer>openssl ca -keyfile ca.key -cert ca.crt -revoke cer_a11.
            		///  crt
            		   
            	}
            		  %>
            		  

<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 


function revoke() {
	
	var okk = confirm("Kaj zelis preklicat certifikat?");
	
	if (okk) {
		
		document.dod.revokecy.value="yes";
		
		document.dod.submit();
		
	}
	
}

function custom() {
 
 
 return true;
}
function mom() {
parent.frames[3].location = "nic.jsp";
<%
if (request.getParameter("akcija")==null) {
%>
 
 
 
<%
}
%>
}
</script>
<%
}
 
else {
%>
 
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">PODATKI VNESENI/SPREMENJENI</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
 
<script language=javascript> 
function mom() {
}


parent.frames[1].document.location = parent.frames[1].document.location;

</script>
 
<%
}
 
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>