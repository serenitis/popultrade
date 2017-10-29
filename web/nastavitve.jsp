<%@ page contentType="text/html;charset=utf-8" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
 <jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="logout.jsp"/><%
}
%>
 
<%
try {
boolean bok=false;



///// 
prisotnost.addUserNarocilo(control.idUporabnikaLock+"","",new Date(),3);




if (nul.jeNull(request.getParameter("resetekranov")).equals("yes")) {
	
	com.popultrade.dao.FrameSizeDAO daofs = (com.popultrade.dao.FrameSizeDAO)contextUtil.getBeanDao("frameSizeDAO",pageContext.getServletContext());
	
	
	daofs.removeFrameSizeByUser(control.getUser());
	
}



com.popultrade.model.Users vseb =new com.popultrade.model.Users();
com.popultrade.dao.UsersDAO dao = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
if (control.idUporabnika!=null && request.getParameter("akcija")==null) {
vseb = dao.getUsers(new Long(nul.jeNullDefault(control.idUporabnika+"")));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {

		vseb = dao.getUsers(new Long(nul.jeNullDefault(control.idUporabnika+"")));
	
 
vseb = (com.popultrade.model.Users)contextUtil.getPopulatedObject(vseb,request);


dao.saveUsers(vseb);


 
}
}
 
Hashtable ht =new Hashtable();


ht.put("uporabnisko ime","username");

ht.put("geslo","passwordn");


//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");





%>
 
<html><head><title>spreminjaj</title></head>
 
<style type=text/css> 
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
 
<script language='javascript'>

function getSize() {

document.dod.frame1.value=top.document.getElementById('ifr2').style.height.replace("px","");
document.dod.frame2.value=top.document.getElementById('ifr3').style.height.replace("px","");
document.dod.frame3.value=top.document.getElementById('ifr4').style.height.replace("px","");
}

</script> 
 
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  onload="mom();getSize()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="nastavitve.jsp" method="post" onSubmit="return check()">
 

<input type=hidden name="akcija" value="UPDATE">

 
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">
	&nbsp;</td></tr>

 
      		  
            		              		  <tr>

            		 <td class="opiscell">Ime: </td><td class="valuecell">
            		 
            		 <input type="text" name="ime"  value="<%=nul.jeNull(vseb.getIme()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		  
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Priimek: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="priimek"  value="<%=nul.jeNull(vseb.getPriimek()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
        		  </tr>
            	  
 
          <tr>
            		  
            		 <td class="opiscell">Jezik: </td><td class="valuecell">
            		 
            			<select name="jezik" style="font-family: Verdana; font-size: 8pt" >
            			<option value=""></option>
            			<%
            				com.popultrade.dao.JezikiDAO daosi = (com.popultrade.dao.JezikiDAO)contextUtil.getBeanDao("jezikiDAO",pageContext.getServletContext());
					List lil = daosi.getJezikis(new com.popultrade.model.Jeziki());

					Iterator itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Jeziki sifr = (com.popultrade.model.Jeziki)itti.next();
						if (nul.jeNull(vseb.getJezik()).equals(nul.jeNull(sifr.getSIFRA_JEZ()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getSIFRA_JEZ())%>"><%=nul.jeNull(sifr.getOPIS_JEZ())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getSIFRA_JEZ())%>"><%=nul.jeNull(sifr.getOPIS_JEZ())%></option>
							<%
						}
					}
					%>
					
					
					</select>
            		 
            		 </td>
            		 
            		 <td class="opiscell">Geslo:</td><td class="valuecell">
            		  <input type="password" name="geslo" maxlength='12' value="<%=nul.jeNull(vseb.getGeslo()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            		  &nbsp;</td>
            		 
            		  </tr>
            		  
            
            		  
            		  
            		  <tr>
            		  
            		  
            		  
            		  
            		 <td class="opiscell">Uporabnisko ime: </td><td class="valuecell">
            		 
            		 <%=nul.jeNull(vseb.getUsername()+"")%>
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Potrditveno geslo: </td><td class="valuecell" width="30%">
            		 
            		 <input type="password" name="geslo1" maxlength='12' value="<%=nul.jeNull(vseb.getGeslo()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
        		  </tr>

        		  
        		  		  <tr>
            		  
            		  
            		  
            		  
            		 <td class="opiscell">&nbsp;</td><td class="valuecell" colspan=3>
            		  &nbsp;</td>
            		 
            		
            		 
        		  </tr>
        		  
        		  <tr><td colspan="4" class="opiscell" align="center">&nbsp;</td></tr>
        		           		  <tr>
            		  
            		  
            		  
            		  
            		 <td class="opiscell">Izgled ekranov: </td><td class="valuecell" colspan="3">
            		 
            		 
            		 <input type="button" name="akmo" value="Reset izgled ekranov na prenastavljene vrednosti" onclick="document.location='nastavitve.jsp?resetekranov=yes'" style="font-family: Verdana; font-size: 8pt">
            		
            		
            		 
            		 </td>
            		 
        		  </tr>



 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 
function custom() {


              if (document.dod.geslo1.value == "" || document.dod.geslo1.value == " ") {
              alert("Napaka: Potrditveno geslo ni vneseno!");
              return false;
              }

               if (document.dod.geslo.value == "" || document.dod.geslo.value == " ") {
              alert("Napaka: Geslo ni vneseno!");
              return false;
              }


   if (document.dod.geslo.value !=  document.dod.geslo1.value) {
              alert("Napaka: Geslo in potrditveno geslo se ne ujemata!");
              return false;
              }

 
              if (document.dod.certifikat_geslo.value == "" || document.dod.certifikat_geslo.value == " ") {
              alert("Napaka: Potrditveno geslo za certifikat ni vneseno!");
              return false;
              }

               if (document.dod.certifikat_geslo2.value == "" || document.dod.certifikat_geslo2.value == " ") {
              alert("Napaka: Geslo certifikata ni vneseno!");
              return false;
              }


   if (document.dod.certifikat_geslo2.value !=  document.dod.certifikat_geslo.value) {
              alert("Napaka: Geslo in potrditveno geslo certifikata se ne ujemata!");
              return false;
              }
              
              /// set trenutnih dimenzij
              getSize();
 
 return true;
}


function godown(gooo) {
parent.frames[1].document.location=gooo;
return false;

}

function mom() {
parent.frames[1].location = "nic.jsp";
parent.frames[2].location = "nic.jsp";



//// set dimenzij framov

<%

if (control.getFrames().containsKey("nastavitve.jsp")) {
	
	com.popultrade.webapp.FrameSizeClass fss = (com.popultrade.webapp.FrameSizeClass)control.getFrames().get("nastavitve.jsp");
	
	%>
	
	top.setSize(<%=fss.getFrame1()%>,<%=fss.getFrame2()%>,<%=fss.getFrame3()%>);
	
	<%
}

%>


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
var mon = parent.frames[1].document.location+"";
<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
 
  parent.frames[1].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
 
 
}
  else {
     if (mon.indexOf("?")!=-1) {
parent.frames[1].document.location = parent.frames[1].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     else {
     parent.frames[1].document.location = parent.frames[1].document.location + "?idback=<%=request.getParameter("id")%>";
 
     }
}
<%
}
else {
%>
parent.frames[1].document.location = parent.frames[1].document.location;
<%
}
%>
</script>
 
<%
}
 
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>