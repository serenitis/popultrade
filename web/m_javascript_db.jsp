<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />


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
boolean defaultt = false;


 if (request.getParameter("akcija")!=null)  {





if (true) {
	
	
	
	com.popultrade.dao.TemplateJsDbDAO daop = (com.popultrade.dao.TemplateJsDbDAO)contextUtil.getBeanDao("templateJsDbDAO",pageContext.getServletContext());
	
	daop.deleteAll();
	
	Enumeration enn = request.getParameterNames();
	StringBuffer jsdb = new StringBuffer();
	
	
	jsdb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");	
	jsdb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");	
	jsdb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");	
	jsdb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");	
	jsdb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");	
	jsdb.append("<jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");	
	jsdb.append("<jsp:useBean id=\"templateUtil\" scope=\"session\" class=\"com.popultrade.webapp.TemplateUtils\" />\r\n");	
	
	jsdb.append("<////%\r\n");	
	jsdb.append("request.setCharacterEncoding(control.encoding);\r\n");	
	jsdb.append("response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");	
			jsdb.append("response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");	
			jsdb.append("response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");	
			jsdb.append("response.addDateHeader(\"Expires\", 0);\r\n");	
			jsdb.append("if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"A\")) {\r\n");	
	jsdb.append("%////><jsp:forward page=\"m_loginu.html\"/><////%\r\n");	
	jsdb.append("}\r\n");	
	jsdb.append("%////>\r\n");	
	 
	jsdb.append("<////% \r\n");	
	jsdb.append("try { \r\n");	
	
	
	
	
	//jsdb.append("StringBuffer zadbname = new StringBuffer();\r\n");	
	jsdb.append("StringBuffer zadb = new StringBuffer();\r\n");	
	
	while (enn.hasMoreElements()) {
		
		String str = (String)enn.nextElement();
		
		if (str!=null && str.startsWith("T_")) {
			
			com.popultrade.dao.TemplateJsDbDAO daopp = (com.popultrade.dao.TemplateJsDbDAO)contextUtil.getBeanDao("templateJsDbDAO",pageContext.getServletContext());
			
			com.popultrade.model.TemplateJsDb prevo = new com.popultrade.model.TemplateJsDb();
			
			prevo.setTable_name(str.substring(2));
			
			daopp.saveTemplateJsDb(prevo);
			
jsdb.append("if (true) {\r\n");		

jsdb.append("zadb.append(\"var "+str.substring(2).toLowerCase()+"=new TAFFY([\\r\\n\");\r\n");


jsdb.append("com.popultrade.dao."+str.substring(2)+"DAO daop = (com.popultrade.dao."+str.substring(2)+"DAO)contextUtil.getBeanDao(\""+(str.substring(2).substring(0,1).toLowerCase()+str.substring(3))+"DAO\",pageContext.getServletContext());\r\n");
jsdb.append("com.popultrade.model."+str.substring(2)+" prevo = new com.popultrade.model."+str.substring(2)+"();\r\n");
jsdb.append("List limo = daop.get"+str.substring(2)+"s(null);\r\n");
jsdb.append("Iterator ito = limo.iterator();\r\n");
jsdb.append("boolean gtu = false;\r\n");
jsdb.append("while (ito.hasNext()) {\r\n");
jsdb.append("com.popultrade.model."+str.substring(2)+" prev = (com.popultrade.model."+str.substring(2)+")ito.next();\r\n");


jsdb.append("if (!gtu) {\r\n");
jsdb.append("gtu = true;\r\n");
jsdb.append("}\r\n");
jsdb.append("else {\r\n");
jsdb.append("zadb.append(\",\\r\\n\");\r\n");
jsdb.append("}\r\n");

			//// dam v file
			
			List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+str.substring(2));
			
			Iterator itti = li.iterator();
			String vene = "";
			while (itti.hasNext()) {
			
				String nex =(String)itti.next();
			String prik = nex.substring(nex.indexOf(" ----XXX---- ")+13);
				if (nex.substring(0,nex.indexOf(" ----XXX---- ")).indexOf("().get")==-1 && (prik.indexOf("String")!=-1 ||
						prik.indexOf("Long")!=-1 ||
								prik.indexOf("Integer")!=-1 ||
								prik.indexOf("Double")!=-1 ||
								prik.indexOf("Date")!=-1)
						) {
			//	System.out.print(nex.substring(0,nex.indexOf(" ----XXX---- ")).substring(3)+" | ");
			if (prik.indexOf("Date")!=-1) {
				vene += ""+nex.substring(0,nex.indexOf(" ----XXX---- ")).substring(3).toLowerCase()+":\\\"\"+nul.getDatumFormatFromDate(prev."+nex.substring(0,nex.indexOf(" ----XXX---- "))+"(),\"dd-MM-yyyy HH:mm\").replaceAll(\"\\\"\",\"'\")+\"\\\",";
					
			}
			else {
			vene += ""+nex.substring(0,nex.indexOf(" ----XXX---- ")).substring(3).toLowerCase()+":\\\"\"+nul.jeNull(prev."+nex.substring(0,nex.indexOf(" ----XXX---- "))+"()+\"\").replaceAll(\"\\\"\",\"'\")+\"\\\",";
			}
				
				//	jsdb.append("zadb.append("+vene+"\");\r\n");
				}
			
			}
			
			if (vene.length()>2) {
			
				jsdb.append("zadb.append(\"{"+vene.substring(0,vene.length()-1)+"}\");\r\n");
				//jsdb.append("zadb.append("+str.substring(2).toLowerCase()+".insert["+vene.substring(0,vene.length()-1)+"])\\r\\n;\r\n");
			
			}
		
		

		
jsdb.append("}\r\n");			
			
jsdb.append("zadb.append(\"]);\\r\\n\");\r\n");
jsdb.append("}\r\n");			
			}
			
			
			
			
			
			
		}
		
	
	
	jsdb.append("String patho =request.getRealPath(\"\")+\"/js/jsDB.js\";\r\n");
	
	
	jsdb.append("PrintWriter outt = new PrintWriter(patho);\r\n");
	
	jsdb.append("outt.write(zadb.toString());\r\n");
	
	jsdb.append("outt.close();\r\n");
	
	

		jsdb.append("%////>\r\n");

jsdb.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
jsdb.append("<tr>\r\n");
jsdb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
jsdb.append("</tr>\r\n");
jsdb.append("<tr>\r\n");
jsdb.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
jsdb.append("<p align=\"center\">JAVASCRIPT DB CREATED</td>\r\n");
jsdb.append("</tr>\r\n");
jsdb.append("<tr>\r\n");
jsdb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
jsdb.append("</tr>\r\n");
jsdb.append("</table>\r\n");

jsdb.append("<script language=javascript>\r\n");

		jsdb.append("</script>\r\n");

jsdb.append("<////%\r\n");
		jsdb.append("}\r\n");
		jsdb.append("catch (Exception ex){\r\n");
			jsdb.append("org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");
			
			jsdb.append("log.error(ex.toString());\r\n");
			jsdb.append("}\r\n");
		jsdb.append("%////>\r\n");
		
		
		
		
		
		
		//// write to disk
		
		
		
		
		
		String patho =request.getRealPath("")+"/jspcopy/jsDB.jsp";
		
		
		PrintWriter outt = new PrintWriter(patho);
		
		outt.write(jsdb.toString().replaceAll("////", ""));
		
		outt.close();
		
		
		///// shranim novo verzijo
		
		
			com.popultrade.dao.PrevodiDAO daopr = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
			com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
			
			
			prevo.setPrevod_id(new Long("1000018"));
			prevo.setSifra_jez("SL");
			prevo.setVrsta("Y");
			
			prevo = daopr.getPrevodiCopy(prevo);
			
			if (prevo==null) {
				prevo = new com.popultrade.model.Prevodi();
				prevo.setPrevod(nul.getDatumFormatFromDate(new Date(), "yyyymmddHHss"));
				prevo.setPrevod_id(new Long("1000018"));
				prevo.setSifra_jez("SL");
				prevo.setVrsta("Y");
				
			}
			prevo.setPrevod(nul.getDatumFormatFromDate(new Date(), "yyyymmddHHss"));
			
			daopr.savePrevodi(prevo);
		
		
		
		
		
		
		
	//System.out.println(jsdb.toString());

}


}
 else {
	 session.setAttribute("jezikp",request.getParameter("jezikp"));
	 session.setAttribute("jezikv",request.getParameter("jezikv"));
 }

Hashtable ht =new Hashtable();


if (request.getParameter("akcija")!=null)  {
	%>
	<script language=javascript>
	document.location="jspcopy/jsDB.jsp";
	</script>
	<%
	
}
else {
%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  onload="parent.frames[2].location='nic.jsp';parent.frames[3].location='nic.jsp'"  >
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_javascript_db.jsp" method="post" >


	<input type=hidden name="akcija" value="NEW">
	<%	


/// prevod stran
Hashtable prejv = new Hashtable();
Hashtable prejh = new Hashtable();

/*
com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();

List limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","S");
Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","S");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


Hashtable prejvd = new Hashtable();
Hashtable prejhd = new Hashtable();
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","D");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejvd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","D");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejhd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}



Hashtable prejvo = new Hashtable();
Hashtable prejho = new Hashtable();
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","O");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejvo.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","O");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejho.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}











*/


Hashtable table = new Hashtable();

com.popultrade.dao.TemplateJsDbDAO daop = (com.popultrade.dao.TemplateJsDbDAO)contextUtil.getBeanDao("templateJsDbDAO",pageContext.getServletContext());
com.popultrade.model.TemplateJsDb prevo = new com.popultrade.model.TemplateJsDb();

List limo = daop.getTemplateJsDbs(prevo, 1, 300, "", "", "");

Iterator ito = limo.iterator();


while (ito.hasNext()) {
	
	com.popultrade.model.TemplateJsDb prev = (com.popultrade.model.TemplateJsDb)ito.next();
	
	table.put(prev.getTable_name(), "1");
	
	
}


%>


<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="5" class="opiscell">&nbsp;</td></tr>

<tr><td colspan="5" class="valuecell">Izberi tabele , ki se kopirajo v Javascript DB </td></tr>


       
<%

List li = templateUtil.getClasseNamesInPackage(contextUtil,this.getServletContext(),"","");

Iterator itti = li.iterator();
int zx = 0;
boolean prvo = false;

while (itti.hasNext()) {

	String nex =(String)itti.next();
	if (nex!=null ) {
		
		
		if (!prvo) {
			prvo=true;
			
			%>
			<tr>
			<%
		}
		
		if (zx==5) {
			zx=0;
			%>
			</tr><tr>
			<%
		}
%>


<td class="valuecell" >
<input type="checkbox" size="35" <%=(table.containsKey(nex)?"checked":"") %>  name="T_<%=nex %>" value="1" style="font-family: Verdana; font-size: 8pt">
<%=nex %>
</td>


<%
zx++;
	}

	
	
	
}


for (int z=zx;z<=4;z++) {
	
	%>
	<td></td>
	<%
	if (z==4) {
		%>
		</tr>
		<%
	}
}






%>
            		  
      		  
            		  
            		  
            	
            		  		  


<tr><td colspan="5" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {


return true;
}
function mom() {


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

</script>

<%
}
}
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>