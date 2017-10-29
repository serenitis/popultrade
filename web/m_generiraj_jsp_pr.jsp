<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<jsp:useBean id="parametrii" scope="session" class="com.popultrade.webapp.Parametri" />



<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}



String deploy_kam =parametrii.getParametri().getProperty("deploy_kam");// "E:/Tomcat5.0/webapps/ics_test/";

this.contextUtil2 = contextUtil;



%>
 


<%!









////creiram vsebino vezano na gumb pp

public String createPP(Object tlii,String tipobjekta) {

StringBuffer sbl = new StringBuffer();

Iterator iteb=null;

String format_stolpca=""; 
String iddd= "";
if (tipobjekta.equals("templateui")) {
format_stolpca = ((com.popultrade.model.TemplateUi)tlii).getFormat_stolpca();

iteb = ((com.popultrade.model.TemplateUi)tlii).getTemplateClasses().iterator();
iddd=((com.popultrade.model.TemplateUi)tlii).getId()+"";
}
else if (tipobjekta.equals("templatelist")) {
format_stolpca = ((com.popultrade.model.TemplateList)tlii).getFormat_stolpca();
iteb = ((com.popultrade.model.TemplateList)tlii).getTemplateClasses().iterator();
iddd=((com.popultrade.model.TemplateList)tlii).getId()+"";
}
else if (tipobjekta.equals("templatepp")) {
format_stolpca = ((com.popultrade.model.TemplatePP)tlii).getFormat_stolpca();
iteb = ((com.popultrade.model.TemplatePP)tlii).getTemplateClasses().iterator();
iddd=((com.popultrade.model.TemplatePP)tlii).getId()+"";
}
else if (tipobjekta.equals("templateview")) {
format_stolpca = ((com.popultrade.model.TemplateView)tlii).getFormat_stolpca();
iteb = ((com.popultrade.model.TemplateView)tlii).getTemplateClasses().iterator();
iddd=((com.popultrade.model.TemplateView)tlii).getId()+"";
}
if (!tipobjekta.equals("templatelist")) {
sbl.append("<%\r\n");
}


sbl.append("rezu=\"\";\r\n");
com.popultrade.model.TemplateClassPP vsebsm =new com.popultrade.model.TemplateClassPP();
com.popultrade.dao.TemplateClassPPDAO daosm = (com.popultrade.dao.TemplateClassPPDAO)contextUtil2.getBeanDao("templateClassPPDAO",this.getServletContext());

try {
 vsebsm.setTemplateclass_id(new Long(iddd));
 
List liko = daosm.getTemplateClassPPs(vsebsm);
if (liko.size()==1) {
 
 vsebsm =  (com.popultrade.model.TemplateClassPP)liko.get(0);
if (!nul.jeN(vsebsm.getContent()).equals("")) {
 sbl.append("\r\n" +vsebsm.getContent() +";\r\n");

 
 
}
}
}
catch (Exception exc) {
 
}
//String remu = ""; ///////// format number , ce je double in ce ima vnesen format

//nul.getDatumFormatFromDate()
while (iteb.hasNext()) {
 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
 
 
 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VARIABLE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
			 
	
	
	 /// pogoj
	 sbl.append("\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n");
	 
	 if (!nul.jeNull(format_stolpca).equals("") && nul.jeNull(format_stolpca).indexOf("#")!=-1) {
		 sbl.append("rezu=nul.formatNumber(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+format_stolpca+"\");\r\n");
		 //sbl.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
	 }
	 else if (!nul.jeNull(format_stolpca).equals("")) {
		 sbl.append("rezu=nul.getDatumFormatFromDate(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+format_stolpca+"\");\r\n");
	 }
	 else {
if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
			 
				 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
					 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
																						 }
				 else {
					 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2()+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
										
				 }   	 
			 
		 }
		 else {
		
				
			 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
					
				 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
											 }
				 else {
					 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja()+";\r\n\r\n");
									
				 }
			
		 
		 }
		 }
		 
	 
	 
	 sbl.append("}\r\n");
	 
 }
 
 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
	 
		
	 
	 
	 
	 /// vrednost iz clase
	 
	 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
/// pogoj
if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
//sbl.append("rezu=\"\";\r\n");
sbl.append( nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n");
}
String dodaten = "";
if (tc.getTemplateClassClass().getTemplateClasss().size()>0) {

Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();
while (tre.hasNext()) {
com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();

if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {

dodaten =  dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
}
}
else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
}
}
/// dodaten pogoj da sploh gleda po bazi



}
sbl.append("rezu=rezu+\"\";\r\n");	
sbl.append("if (true "+dodaten+") {\r\n");
//sbl.append("if (true) {\r\n");
//sbl.append("rezu=\"\";\r\n");	 		 
if (!nul.jeNull(tc.getNosql()).equals("1")) {

sbl.append("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n");
}
else {
sbl.append("com.popultrade.model.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa = new com.popultrade.model.dao."+tc.getTemplateClassClass().getClass_name()+"DAO();\r\n");	
}
sbl.append("com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n");


System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 10");

/// setam vrednosti

Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil2,this.getServletContext(),tc.getTemplateClassClass().getClass_name());

while (tre.hasNext()) {
com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();

///////// ///////// ///////////


String rett = tcc.getVrednost_pogoja().replaceAll("\'","\"");

//if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
//rett = tcc.getVrednost_pogoja().replaceAll("get","vseb.get")+"()";
//}



if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
if (((String)meto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {

rett = "nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceFirst("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()).replaceAll(\"_\",\"\\\\_\")";
}
}
else {
rett = tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceFirst("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()";
}
}

//System.out.println(((String)meto.get(tcc.getIme_pogoja()))+ " ::: IME POGOJA ::: "+tcc.getIme_pogoja());

if (meto.containsKey(tcc.getIme_pogoja())) {
if (((String)meto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {

//System.out.println("SOLEMMM : "+rett);

if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1 || nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
//rett = rett+"\"\"";
}

else	if (rett.indexOf("\"")==-1) {
	rett = "\""+rett+"\"";
}
}
else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
if (rett.indexOf("\"")==-1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	rett = "\""+rett+"\"";
}

rett = "new Long("+rett+")";

}
else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)meto.get(tcc.getIme_pogoja())).indexOf("int")!=-1) {
if (rett.indexOf("\"")==-1) {
	

rett = rett.replaceAll("\"", "").replaceAll("\'", "");
rett = "\""+rett+"\"";
}

rett = "Integer.parseInt("+rett+"+\"\")";

}
else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
if (rett.indexOf("\"")==-1) {
	//rett = rett.replaceAll("\"", "").replaceAll("\'", "");
	rett = rett.replaceAll("\"", "").replaceAll("\'", "");
	rett = "\""+rett+"\"";
}
if (rett.indexOf(",")!=-1) {
	rett = rett.replaceAll("\\,", "\\.");
}
rett = "Double.parseDouble("+rett+"+\"\")";

}

}


//sbl.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");


if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")   || ((String)meto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
sbl.append("mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n");

}
else {


sbl.append("mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
}







}


if (!nul.jeNull(tc.getNosql()).equals("1")) {
sbl.append("List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n");

}
else {
sbl.append("List remi = doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod,ConPool.getEntman(),\"\",1,1);\r\n");
}

System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 11");

sbl.append("if (remi.size()>0) {\r\n");

sbl.append("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n");




////pogoji vrednosti

Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();


while (vredno.hasNext()) {
com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();

if (tcv.getTemplateClasses().size()>0) {
/// dobim templateclass
Iterator item = tcv.getTemplateClasses().iterator();
int iml = 0;
 while (item.hasNext()) {
 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();

 
 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
	 
	 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF")) {
		 iml++;
	 if (iml==1) {
	 sbl.append("rezu=\"\";\r\n");
	 }
	 else {
		 sbl.append("rezu=rezu+\"\";\r\n"); 
	 }
	 }
	 /// pogoj
	 sbl.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","mod.get").replaceAll("\\.geet","\\.get")+" {\r\n");
	 
	 if (!nul.jeNull(format_stolpca).equals("") && nul.jeNull(format_stolpca).indexOf("#")!=-1) {
		 sbl.append("rezu=rezu+nul.formatNumber(mod."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+format_stolpca+"\");\r\n");
		 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
	 }
	 else if (!nul.jeNull(format_stolpca).equals("")) {
		 sbl.append("rezu=rezu+nul.getDatumFormatFromDate(mod."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+format_stolpca+"\");\r\n");
	 }
	 else {
if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
 if (nul.jeNull(txc.getFunkcija_formata2()).indexOf(".get")==-1) {
	 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
																					 }
 else {
	 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2()+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
						
 }   
				 
			 
		 }
		 else {
			 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
				 sbl.append("rezu=rezu+"+txc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
												 			 }
				 else {
					 sbl.append("rezu=rezu+"+txc.getVrednost_pogoja()+";\r\n\r\n");
									
				 }
			// sbl.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+"\";\r\n\r\n");
		
		 
		 
		 }
		 }
		 
	 
	 
	 sbl.append("}\r\n");
	 
 }
 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
	 
	 
if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
		 
		 if (nul.jeNull(txc.getFunkcija_formata2()).indexOf(".get")==-1) {
			 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
																									 }
		 else {
			 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2()+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
								
		 }  
		 
	 }
	 else {
	
		 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
			 sbl.append("rezu=rezu+"+txc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
													 			 }
			 else {
				 sbl.append("rezu=rezu+"+txc.getVrednost_pogoja()+";\r\n\r\n");
								
			 }
		
	 
	 }
 }
 }
}
else {
String dodvred = "";
if (!nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
dodvred = " "+tc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
}


sbl.append("rezu=rezu+"+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n");
}



}




sbl.append("}\r\n");

System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 12");

sbl.append("}\r\n");


if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
sbl.append("}\r\n");
}			 
		 
		 
	 }
	 
	 
	 
	 
	 
	 
	 
	 
	 
 }
 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
	 
if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
		 
		 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
			 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"").replaceAll("\'","\"")+");\r\n\r\n");
			 }
		 else {
			 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2()+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
								
		 }  
		 
	 }
	 else {
		 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 121");
		 if (tc.getVrednost_pogoja()!=null && nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
			 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
															 			 }
			 else if (tc.getVrednost_pogoja()!=null ) {
				 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja()+";\r\n\r\n");
								
			 }
		
		 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1211");
	 }
 }

 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("VARIABLE")) {
	 
if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
		 
		 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
			 sbl.append(""+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"").replaceAll("\'","\"")+");\r\n\r\n");
			 }
		 else {
			 sbl.append(""+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2()+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
								
		 }  
		 
	 }
	 else {
		 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 121");
		 if (tc.getVrednost_pogoja()!=null && nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
			 sbl.append(""+tc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
															 			 }
			 else if (tc.getVrednost_pogoja()!=null ) {
				 sbl.append(""+tc.getVrednost_pogoja()+";\r\n\r\n");
								
			 }
		
		 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1211");
	 }
 }
	 
	 
 
}
if (!tipobjekta.equals("templatelist")) {
sbl.append("%////>\r\n");
}


return sbl.toString();


}

///////////// konec createpp







private com.popultrade.webapp.Parametri parametri = new com.popultrade.webapp.Parametri();
public String deploy_kam =parametri.getParametri().getProperty("deploy_kam");// "E:/Tomcat5.0/webapps/popultrade/";
 public com.popultrade.webapp.ContextUtil contextUtil2 = null;






private com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();


public String getAjaxNoviJS(Object  tui,String[] ajaxpoljea,String tipp) {
	
	
	
	String idt = "";
	String drugiime="";
	String stolpecmetoda="";
	boolean rabijsdb=false;
	
	
	if (tipp.equals("TemplateUi")) {
		
		
		com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)tui;	
		idt = tu.getId()+"";
		drugiime = nul.jeNull(tu.getParameter_drugo_ime());
		stolpecmetoda = nul.jeNull(tu.getStolpec_metoda());
		
		com.popultrade.model.TemplateDD temdd = new com.popultrade.model.TemplateDD();
		if (tu.getTemplatedds().size()==1) {
			temdd = (com.popultrade.model.TemplateDD)tu.getTemplatedds().get(0);
		}
		
		
		if (temdd!=null && nul.jeNull(temdd.getUporabi_js_db()).equals("1")) {
			rabijsdb=true;
		}
	
	}
	else if (tipp.equals("TemplatePP")) {
		
		com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)tui;	
		idt = tu.getId()+"";
		//drugiime = nul.jeNull(tu.getParameter_drugo_ime());
		stolpecmetoda = nul.jeNull(tu.getStolpec_metoda());
		if (tu.getTemplateDD()!=null && nul.jeNull(tu.getTemplateDD().getUporabi_js_db()).equals("1")) {
			rabijsdb=true;
		}
	}
	
	
	String premo = "";
	
	premo = premo + "<script language='javascript'>\r\n";
	

	/*
	premo = premo + "var dropdown"+idt+" = new Bloodhound({\r\n";
	premo = premo + "datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),\r\n";
	premo = premo + " queryTokenizer: Bloodhound.tokenizers.whitespace,\r\n";
	premo = premo + "remote: {\r\n";
	premo = premo + "cache:false,\r\n";
    premo = premo + "url: '"+(ajaxpoljea[1].substring(0, ajaxpoljea[1].indexOf(".jsp")+4))+"?ime=%QUERY',\r\n";
    premo = premo + "replace: function () {\r\n";
    premo = premo + "var q = '"+ajaxpoljea[1]+"+'sid='+Math.random()+'&';\r\n";
    premo = premo + " return q;\r\n";
    premo = premo + "}\r\n";
    premo = premo + "}\r\n";
	premo = premo + "});\r\n";
	premo = premo + "dropdown"+idt+".initialize();\r\n";
	
	
	
	String inov = "";
	
	if (drugiime.equals("")) {
		inov = stolpecmetoda.toLowerCase().substring(3);
	}
	else {
		inov = drugiime;
	}
	
	
	premo = premo + "$('#"+inov+"').typeahead({\r\n";
	premo = premo + "minLength: "+ajaxpoljea[2]+",\r\n";
	premo = premo + "highlight:true,\r\n";
	premo = premo + "hint:false\r\n";
	premo = premo + "}, {\r\n";
	premo = premo + "name: 'nam"+idt+"',\r\n";
	premo = premo + "limit: 50,\r\n";
	premo = premo + "displayKey: 'value',\r\n";
	
	//String retc = ajaxpoljea[1];
	
	//retc = retc.substring(retc.indexOf(".jsp?")+5).replaceAll("'\\+document.dod", "document.dod").replaceAll("\\.value \\+'", "");
	
	
	
		premo = premo + "<////%\r\n";
	premo = premo + "if (nul.jeN(control.getParameter07()).equals(\"1\")) {\r\n";
	premo = premo + "%////>\r\n";
		
		
		if (rabijsdb) {
	premo = premo + "source:findMatch('"+ajaxpoljea[7]+"','"+ajaxpoljea[5]+"',"+ajaxpoljea[4]+",'"+ajaxpoljea[6]+"'),\r\n";
		}
		else {
			premo = premo + "source: dropdown"+idt+".ttAdapter(),\r\n";
		}
		premo = premo + "<////%\r\n";
		premo = premo + "}\r\n";
		premo = premo + "else {\r\n";
		premo = premo + "%////>\r\n";
	premo = premo + "source: dropdown"+idt+".ttAdapter(),\r\n";
	premo = premo + "<////%}%////>\r\n";
	
	
	premo = premo + "templates: {\r\n";
	premo = premo + "empty: [\"<div class='empty-message'>&nbsp;&nbsp;Not found!</div>\"]\r\n";
	premo = premo + "}\r\n";
	premo = premo + "}).on('typeahead:active',function (obj) {\r\n";

			premo = premo + "$('#"+inov+"').typeahead('val',document.getElementById('"+inov+"').value);\r\n";
premo = premo + "document.getElementById('"+inov+"').select();\r\n";
premo = premo + "}).on('typeahead:selected typeahead:autocompleted', function (obj,value) {\r\n";
	
	
	premo = premo + "if (value[\"set\"].indexOf(\" ___ \")!=-1) {\r\n";
	premo = premo + "var spl1 = value[\"set\"].split(\" ___ \");\r\n";
	premo = premo + "var idd1 = value[\"idd\"].split(\" ___ \");\r\n";
	premo = premo + "for (i=0;i<spl1.length;i++) {\r\n";
	premo = premo + "if (\""+inov+"\"!=spl1[i]) {\r\n";
	
	if (nul.jeN(ajaxpoljea[3]).equals("1")) {
		premo = premo + "if (document.getElementById(spl1[i]).value=='') {\r\n";
		premo = premo + "document.getElementById(spl1[i]).value=idd1[i];\r\n";
		premo = premo + "}\r\n";
	}
	else {
	
	premo = premo + "document.getElementById(spl1[i]).value=idd1[i];\r\n";
	}
	premo = premo + "}\r\n";
	premo = premo + "else {\r\n";
	
	if (nul.jeN(ajaxpoljea[3]).equals("1")) {
		premo = premo + "if (document.getElementById(spl1[i]).value=='') {\r\n";
		premo = premo + "$('#"+inov+"').typeahead('val',idd1[i]);\r\n";
		premo = premo + "}\r\n";
	}
	else {
	
	premo = premo + "$('#"+inov+"').typeahead('val',idd1[i]);\r\n";
	}
	
	premo = premo + "}\r\n";
	
	premo = premo + "}\r\n";
	premo = premo + "}\r\n";
	premo = premo + "else {\r\n";
	premo = premo + "var spl1 = value[\"set\"];\r\n";
	
	
	if (nul.jeN(ajaxpoljea[3]).equals("1")) {
		premo = premo + "if (document.getElementById(spl1).value=='') {\r\n";
		premo = premo + "document.getElementById(spl1).value=value[\"idd\"];\r\n";
		premo = premo + "$('#"+inov+"').typeahead('val', value[\"idd\"]);\r\n";
		premo = premo + "}\r\n";
	}
	else {
	premo = premo + "document.getElementById(spl1).value=value[\"idd\"];\r\n";
	premo = premo + "$('#"+inov+"').typeahead('val', value[\"idd\"]);\r\n";
	}
	
	
	premo = premo + "}\r\n";
	
	
	premo = premo + "return false;\r\n";
	
	//premo = premo + "alert(value[\"value\"]);\r\n";
	
	premo = premo + "});\r\n";*/
	
	
	
	String inov = "";
	
	if (drugiime.equals("")) {
		inov = stolpecmetoda.toLowerCase().substring(3);
	}
	else {
		inov = drugiime;
	}
   
	premo = premo + "$( function() {\r\n";



    premo = premo + "$('#"+inov+"' ).autocomplete({\r\n";
    	
		if (rabijsdb) {
	premo = premo + "source:findMatch('"+ajaxpoljea[7]+"','"+ajaxpoljea[5]+"',"+ajaxpoljea[4]+",'"+ajaxpoljea[6]+"'),\r\n";
		}
		else {
premo = premo + "source: \r\n";
premo = premo + "function(request, response) {\r\n";
premo = premo + "$.ajax({\r\n";
premo = premo + "url: '"+(ajaxpoljea[1].substring(0, ajaxpoljea[1].indexOf(".jsp")+4))+"',\r\n";
premo = premo + "dataType: \"json\",\r\n";
premo = premo + "data: {\r\n";
premo = premo + "term : request.term,\r\n";

if (ajaxpoljea[1].indexOf("?")!=-1) {
	
    
	String spx = ajaxpoljea[1].substring(ajaxpoljea[1].indexOf("?")+1);
	
	if (spx.indexOf("&")!=-1) {
		System.out.println("SPX 0: "+spx);
		String[] spxx = spx.split("&");
	
		for (int cx = 0;cx<spxx.length;cx++) {
		String vall = "";
		String spx1 = spxx[cx];
		System.out.println("SPX: "+spx1);
		if (spx1.length()>3) {
		if (spx1.indexOf("+")!=-1) {
			
		vall = spx1.substring(0,spx1.indexOf("=")) + ":"+spx1.substring(spx1.indexOf("+")+1,spx1.lastIndexOf("+"));
		}
		else if (spx1.indexOf("<%")!=-1) {
			
    		vall = spx1.substring(0,spx1.indexOf("=")) + ":'"+spx1.substring(spx1.indexOf("<"),spx1.lastIndexOf(">")+1)+"'";
    		}
		else {
			
    		vall = spx1.substring(0,spx1.indexOf("=")) + ":'"+spx1.substring(spx1.indexOf("=")+1)+"'";
    		}
		
		premo = premo + vall+",\r\n";
		}
		}
		
	}
	else {
	
		String vall = "";
		if (spx.length()>3) {
		if (spx.indexOf("+")!=-1) {
			
		vall = spx.substring(0,spx.indexOf("=")) + ":"+spx.substring(spx.indexOf("+")+1,spx.lastIndexOf("+"));
		}
		else if (spx.indexOf("<%")!=-1) {
			
    		vall = spx.substring(0,spx.indexOf("=")) + ":'"+spx.substring(spx.indexOf("<"),spx.lastIndexOf(">")+1)+"'";
    		}
		else if (spx.length()>3) {
			
    		vall = spx.substring(0,spx.indexOf("=")) + ":'"+spx.substring(spx.indexOf("=")+1)+"'";
    		}
		
		premo = premo + vall+",\r\n";
		//phone : document.dod.phone.value
		}
	}
	
}




premo = premo + "sid : Math.random()\r\n";
                
                
           
                
                
                
                
premo = premo + "},\r\n";
}
premo = premo + "success: function(data) {\r\n";
premo = premo + "$('#"+inov+"' ).css({'background-image':'url(\"js/uijs2/spinner.gif\")'});\r\n";
premo = premo + "$('#"+inov+"' ).css({'background-position':\"right center\"});\r\n";
premo = premo + "$('#"+inov+"' ).css({'background-repeat':\"no-repeat\"});\r\n";
premo = premo + "response(data);\r\n";
premo = premo + "}\r\n";
premo = premo + "}).done(function( data ) {\r\n";
premo = premo + "$('#"+inov+"' ).css({'background-image':''})});\r\n";
premo = premo + "},\r\n";
//premo = premo + "}\r\n";
    	
    	

    
    
    
    
premo = premo + " minLength: "+ajaxpoljea[2]+",\r\n";
premo = premo + "select: function( event, ui ) {\r\n";
//alert(ui.item.set);


/*
if (ui.item.set.indexOf(" ___ ")!=-1) {
var spl1 = ui.item.set.split(" ___ ");
var idd1 = ui.item.idd.split(" ___ ");

for (i=0;i<spl1.length;i++) {
if ("phone"!=spl1[i]) {
document.getElementById(spl1[i]).value=idd1[i];
}
}
}*/

premo = premo + "event.preventDefault();\r\n";
premo = premo + "if (ui.item.set.indexOf(\" ___ \")!=-1) {\r\n";
premo = premo + "var spl1 = ui.item.set.split(\" ___ \");\r\n";
premo = premo + "var idd1 = ui.item.idd.split(\" ___ \");\r\n";
premo = premo + "for (i=0;i<spl1.length;i++) {\r\n";
//premo = premo + "if (\""+inov+"\"!=spl1[i]) {\r\n";

if (nul.jeN(ajaxpoljea[3]).equals("1")) {
	premo = premo + "if (document.getElementById(spl1[i]).value=='') {\r\n";
	premo = premo + "document.getElementById(spl1[i]).value=idd1[i];\r\n";
	premo = premo + "}\r\n";
}
else {

premo = premo + "document.getElementById(spl1[i]).value=idd1[i];\r\n";
}
//premo = premo + "}\r\n";
premo = premo + "}\r\n";
premo = premo + "}\r\n";

premo = premo + "}\r\n";
premo = premo + "});\r\n";
premo = premo + "} );\r\n";
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	premo = premo + "</script>\r\n";
	
	return premo;
	
}










public String[] getAjaxPP(com.popultrade.model.TemplatePP tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,String ime_field) {
	com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();
	
	String premos="";
	String retx = "";
	String retx2="";
	String retx3="";
	String retx4="";
	String retx5="";
	String retx6="";
	String retx7="";
	String retx8="";
	
	String daj_v_id2="";
	String dodaj_v_par=""; /// dodam v parametre za JS db
	
	
	if (tu.getTemplateDD()!=null && tu.getTemplateDD().getId()!=null) {
		
		
			com.popultrade.model.TemplateDD tmdd = tu.getTemplateDD();
		if (!nul.jeNull(tmdd.getKontrola()).equals("A")) {

		
		premos = premos + "<////%@ page contentType=\"text/html\\;\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////><jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/><jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" /><jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" /><jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" /><jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" /><////%\r\n";
		premos = premos + "request.setCharacterEncoding(control.encoding);\r\n";
		premos = premos + "response.setContentType(\"text/html; charset=\"+control.encoding);\r\n";
		premos = premos + "response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n";
		premos = premos + "response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n";
		premos = premos + "response.addDateHeader(\"Expires\", 0);\r\n";
	//	premos = premos + "boolean jetr = false;\r\n";
		premos = premos + "if ((control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\")))) {\r\n";
		premos = premos + "%////><jsp:forward page=\"logout.jsp\"/><////%}%////><////%\r\n";
		premos = premos + "try {\r\n";
		premos = premos + "boolean bok=false;\r\n";
		
		
		String dodaten = "";
		if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getTemplateClasss()!=null && tu.getTemplateClassClass().getTemplateClasss().size()>0) {
			
			Iterator tre = tu.getTemplateClassClass().getTemplateClasss().iterator();
			while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
			if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
				}
			}
			else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
			}
			}
			/// dodaten pogoj da sploh gleda po bazi
			
			
			
		}
		
	 	 
		premos = premos + "if (true "+dodaten+") {\r\n";
							 
		premos = premos + "com.popultrade.dao."+tmdd.getClass_name()+"DAO doax =(com.popultrade.dao."+ tmdd.getClass_name()+"DAO)contextUtil.getBeanDao(\""+tmdd.getClass_name().substring(0,1).toLowerCase() +tmdd.getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

		premos = premos + "com.popultrade.model."+tmdd.getClass_name() +" modx = new com.popultrade.model."+tmdd.getClass_name() +"();\r\n";



		com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",servletContext);

		/// setam vrednosti

		com.popultrade.model.TemplateDDPogoji sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tmdd.getId());
		sifh.setTip("P");
		
	

		List lish =null;
		
		lish = daodd.getTemplateDDPogojis(sifh);
		Iterator tre = lish.iterator();
		String daj_v_parameter="";
		Hashtable metos = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tmdd.getClass_name());
		
		String dodvpogoj = ""; /// dodam v pogoj v primeru, da dropdow nima minimalne stevilke znakov tako da ne izbere ko gres z tabom cez

		
		while (tre.hasNext()) {
com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			//String rett="request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\")+\"\"";
			
			String rett="";
			
			if (tcc.getVrednost_metode().indexOf("request.getPara")!=-1) {
				//rett=""+tcc.getVrednost_metode().replaceAll("\'","\"")+"+\"\"";
				rett="nul.menjajVSumnike(request.getParameter(\""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"\"),nul.jeNull(ConPool.getPrevod_admin(\"1000010\",\"Y\",\"SL\")))+\"\"";
			}
			else {
						
				
				
				if (!nul.jeNull(tcc.getVrednost_fiksna()).equals("1")) {
					
					 rett="nul.menjajVSumnike(request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\"),nul.jeNull(ConPool.getPrevod_admin(\"1000010\",\"Y\",\"SL\")))+\"\"";
					 if (tcc.getVrednost_metode().indexOf("control.")==-1 && tcc.getVrednost_metode().indexOf("nul.")==-1) {
						 dodvpogoj = "request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\")";
						 }
				
				}
			else {
				 rett="nul.menjajVSumnike(\""+tcc.getVrednost_metode().replaceAll("\'","\"")+"\",nul.jeNull(ConPool.getPrevod_admin(\"1000010\",\"Y\",\"SL\")))+\"\"";
					
			}
				
				
					}	
			
			
			if (tcc.getVrednost_metode().indexOf("control.")!=-1 || tcc.getVrednost_metode().indexOf("nul.")!=-1) {
				 rett=tcc.getVrednost_metode().replaceAll("\'","\"");
			}
			if (metos.containsKey(tcc.getIme_metode())) {
			if (((String)metos.get(tcc.getIme_metode())).indexOf("Long")!=-1) {
				
				
				
				rett = "new Long("+rett+")";
				
				
				
			}
			else if (((String)metos.get(tcc.getIme_metode())).indexOf("int")!=-1 || ((String)metos.get(tcc.getIme_metode())).indexOf("Integer")!=-1) {
				rett = "Integer.parseInt("+rett+")";
				
			}
			else if (((String)metos.get(tcc.getIme_metode())).indexOf("Double")!=-1) {
			
				rett = "Double.parseDouble("+rett+")";
			}
			}
			
	
			
			if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
				premos = premos + tcc.getPogoj_uporabe().replaceAll("\'","\"") + " {\r\n";
			}
			if (!nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
			premos = premos + "modx."+tcc.getIme_metode()+"("+rett+");\r\n";
			
			if (rett.indexOf("request.getParameter")==-1) {
				dodaj_v_par += tcc.getIme_metode().substring(3).toLowerCase() + "=<////%="+rett+"%////>&";
			}
			else {
				dodaj_v_par += tcc.getIme_metode().substring(3).toLowerCase() + "=document.dod."+ tcc.getVrednost_metode().toLowerCase()+"&";
			}
			
			
			}
			if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
				premos = premos + " }\r\n";
			}
			
			
			String dodd = "&";
			String addi="";
			boolean preej = true;
			if (daj_v_parameter.equals("")) {
				dodd = "?";
			}
			if (tcc.getVrednost_metode().indexOf("control.")!=-1 || tcc.getVrednost_metode().indexOf("nul.")!=-1) {
			//	daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"=<////%="+tcc.getVrednost_metode()+"%////>";
			//	preej = false;
			
			}	
			else {
				
				if (!nul.jeNull(tcc.getVrednost_fiksna()).equals("1")) {
    			daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"='+document.dod."+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+".value +'";
    			}
		else {
    				
    				
    				if (nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
    					
    					String vredmet = tcc.getVrednost_metode();
    					if (vredmet.indexOf("request.getParameter")!=-1) {
    						vredmet = vredmet.substring(vredmet.indexOf("'")+1,vredmet.lastIndexOf("'"));
    					}
    				
    					daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+vredmet+"=<////%="+tcc.getVrednost_metode().replaceAll("'","\"")+"%////>";
        				
    				}
    				else {
    				daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"="+tcc.getVrednost_metode();
    				//daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"='+document.dod."+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+".value +'";
        			
    				
    				
    				}
    			}
			preej=true;
			}
		}

	
		String order_by = "";
		if (!nul.jeNull(tmdd.getHead_select_dodatni_pogoji()).equals("")) {
			order_by = nul.jeNull(tmdd.getHead_select_dodatni_pogoji());
		}
		
		String order_by_smer = "";
		
		if (!nul.jeNull(tmdd.getOrder_by_smer()).equals("")) {
			order_by_smer = nul.jeNull(tmdd.getOrder_by_smer());
		}
		String dodaten_HQL = "";
		
		premos = premos + "String dod_hql=\"\";\r\n";
		
		if (nul.jeNull(tmdd.getUporabi_dodaten_hql_pogoj()).equals("1")) {
			dodaten_HQL="sss";
			/// pogoj hql
			if (!nul.jeNull(tmdd.getPogoj_za_uporabo_hql()).equals("")) {
				premos = premos + nul.jeNull(tmdd.getPogoj_za_uporabo_hql())+" {\r\n";
			}
			premos = premos + " dod_hql=\""+nul.jeNull(tmdd.getDodaten_hql_pogoj())+"\";\r\n";
			if (!nul.jeNull(tmdd.getPogoj_za_uporabo_hql()).equals("")) {
				premos = premos + " }\r\n";
			}
			
			
		}
		
		if (order_by.equals("") && dodaten_HQL.equals("")) {
		premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s(modx,\"\",\"\");\r\n";
		}
		else if (!dodaten_HQL.equals("")) {
			premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s2(modx,\""+order_by+"\",\""+order_by_smer+"\",dod_hql);\r\n";
		}
		else {
			premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s(modx,\""+order_by+"\",\""+order_by_smer+"\");\r\n";
		}


		premos = premos + "String rezu_format=\"\";\r\n";
		
		
		
		premos = premos + "if (remix.size()>0) {\r\n";
		
		premos = premos + "%////>[<////%\r\n";
		
		
		premos = premos + "if (nul.jeNull("+dodvpogoj+").equals(\"\")) {\r\n";
		premos = premos + "----DODAJ----";
		
		
		
		premos = premos + "int vss = 0;\r\n";
		
		
 		sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tmdd.getId());
		sifh.setTip("V");
		
	
		
		lish = daodd.getTemplateDDPogojis(sifh);
		tre = lish.iterator();
		String daj_v_id="";
		
		
		
		String daj_v_set="";
		String daj_v_vrednost="";
		String daj_v_vrednost2="";
		//String daj_v_div="";
		/////// vrednosti pogoja
		while (tre.hasNext()) {
			com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			if (!nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
			
			if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("1")) {
				//// uporabim format vrednosti ali ne
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
				
				daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
				daj_v_id2 = daj_v_id2 +tcc.getRezultat_metode().toLowerCase()+" ___ ";
				
				}
				else {
					daj_v_id = daj_v_id+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
					
					daj_v_id = daj_v_id +"<%=rezu_format%////> ___ ";
					
				}
				
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
					
				daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
				daj_v_vrednost2 = daj_v_vrednost2 + tcc.getRezultat_metode().toLowerCase()+" ___ ";
				
				}
				else {
					daj_v_vrednost = daj_v_vrednost+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
					
					daj_v_vrednost = daj_v_vrednost +"<%=rezu_format%////> ";
					
				}
				
				
				
				daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
				
			}
			else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("2")) {
			
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
				daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
				daj_v_id2 = daj_v_id2 +tcc.getRezultat_metode().toLowerCase()+" ___ ";
				}
				else {
					daj_v_id = daj_v_id+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
					
					daj_v_id = daj_v_id +"<%=rezu_format%////> ___ ";
					
				}
				//daj_v_id = daj_v_id +"<%try{String yt =<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////><%}catch(Exception ex){}%////> ___ ";
			//	daj_v_vrednost = daj_v_vrednost + "<%="+tcc.getRezultat_metode()+"%////> ";
			
				daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
			}
			
			else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("3")) {
				//daj_v_id = daj_v_id +"<%="+tcc.getRezultat_metode()+"%////> ___ ";
			//	daj_v_vrednost = daj_v_vrednost + "<%try{String yt =<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////><%}catch(Exception ex){}%////> ";
				//daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
					
					daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
					//daj_v_vrednost2 = daj_v_vrednost2 +tcc.getRezultat_metode().toLowerCase();
					daj_v_vrednost2 = daj_v_vrednost2 + tcc.getRezultat_metode().toLowerCase()+" ___ ";
				
				}
					else {
						daj_v_vrednost = daj_v_vrednost+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
						
						daj_v_vrednost = daj_v_vrednost +"<%=rezu_format%////> ";
						
					}
				//daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
			}
			}
		
		}
		if (daj_v_id2.endsWith(" ___ ")) {
			daj_v_id2 = daj_v_id2.substring(0,daj_v_id2.lastIndexOf(" ___ "));
			
		}
		if (daj_v_vrednost2.endsWith(" ___ ")) {
			daj_v_vrednost2 = daj_v_vrednost2.substring(0,daj_v_vrednost2.lastIndexOf(" ___ "));
			
		}
		if (daj_v_id.endsWith(" ___ ")) {
			daj_v_id = daj_v_id.substring(0,daj_v_id.lastIndexOf(" ___ "));
			
		}
		if (daj_v_set.endsWith(" ___ ")) {
			daj_v_set = daj_v_set.substring(0,daj_v_set.lastIndexOf(" ___ "));
		}
		
		
		premos = premos + "Iterator itx = remix.iterator();\r\n";
		//System.out.println(request.getParameter("letters") + " ::: omi" );
		premos = premos + "while (itx.hasNext()) {\r\n";
		
		premos = premos + "com.popultrade.model."+tmdd.getClass_name()+" vsebx = (com.popultrade.model."+tmdd.getClass_name()+")itx.next();\r\n";
		premos = premos + "vss++;\r\n";
		
		premos = premos + "%////>{\"idd\":\""+daj_v_id+"\",\"value\":\""+daj_v_vrednost.trim()+"\",\"set\":\""+daj_v_set+"\"}\r\n";	
		premos = premos + "<////%if (remix.size()!=vss) {%////>,<////%}%////><////%\r\n";
		premos = premos + "}\r\n";
		premos = premos + "%////>]<////%";
		
		premos = premos + "}\r\n";
		premos = premos + "}\r\n";
		
		
		premos = premos + "}\r\n";
		premos = premos + "catch (Exception ex){\r\n";
		premos = premos + "org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n";
		
		premos = premos + "log.error(ex.toString());\r\n";
		premos = premos + "}%////>\r\n";
		String tododd= "";
		if (daj_v_set.indexOf(" ___ ")!=-1) {
			String[] sllo = daj_v_set.split(" ___ ");
		int vsecx = sllo.length;
		
		for (int lo=0;lo<vsecx-1;lo++) {
			tododd+=" ___ ";
		}
		
		}
String tododaj = "%////>{\"idd\":\""+tododd+"\",\"value\":\"\",\"set\":\""+daj_v_set+"\"},<////%}";
		
		premos  = premos.replaceFirst("----DODAJ----", tododaj);
	
		try {
		/// shranim file za ajax
		if ((tmdd.getStatus()).equals("1")) {
		Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"), "latin1"));



		out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
		////zaprem writer3
		out3.close();
		//String velike_crke = nul.jeNull(tu.getSamo_velike_crke());
		
		//retx= "  autocomplete=\"off\" onfocus=\"change(this,'yellow');"+"setKlici(this,1);\" onfsocus=\"change(this,'yellow');"+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"")+"','"+(nul.jeNull(tmdd.getUporabi_kontrolo_vrednosti()).equals("0")?"0":"1")+"')}\"  onclick=\"setKlici(this,2);\"  onkeyup=\""+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"")+"','"+(nul.jeNull(tmdd.getUporabi_kontrolo_vrednosti()).equals("0")?"0":"1")+"')};setKlici(this,2);\" ";
		
		retx = " ";//"<div id=\"remote"+tu.getId()+"\" >";
		retx2 = ""+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+"";
		retx3 = (nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"");
		retx4 = nul.jeN(tmdd.getUporabi_kontrolo_vrednosti());/// kopiraj vrednost le ce target nima vrednosti
		retx5 = "'"+daj_v_id2+"','"+daj_v_vrednost2+"','"+daj_v_set+"'";
		retx6 = tmdd.getClass_name().toLowerCase();
		retx7 = nul.jeN(tmdd.getHead_select_dodatni_pogoji()) +(nul.jeN(tmdd.getOrder_by_smer()).equals("")?"":" "+tmdd.getOrder_by_smer());
		retx8 = dodaj_v_par;
		}
		}
		catch (Exception exx) {
			System.out.println("NAPAKA AJAX::: "+exx.toString());
		}
		}
			
	
		
		
		
		
	}

	
	String[] retu = {retx,retx2,retx3,retx4,retx5,retx6,retx7,retx8}; 
	
	return retu;
	
	 
	
}




public String getAjax(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext) {
	com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();
	
	String premos="";
	String retx = "";

	
	if (tu.getSo_templatedd()>0) {
		
		List lik = tu.getTemplatedds();
		
		Iterator ith = lik.iterator();
		
		while (ith.hasNext()) {
		
			com.popultrade.model.TemplateDD tmdd = (com.popultrade.model.TemplateDD)ith.next();
		if (!nul.jeNull(tmdd.getKontrola()).equals("A")) {

		
		premos = premos + "<////%@ page contentType=\"text/html\\;\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////><jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/><jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" /><jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" /><jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" /><jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" /><////%\r\n";
		premos = premos + "request.setCharacterEncoding(control.encoding);\r\n";
		premos = premos + "response.setContentType(\"text/html; charset=\"+control.encoding);\r\n";
		premos = premos + "response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n";
		premos = premos + "response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n";
		premos = premos + "response.addDateHeader(\"Expires\", 0);\r\n";
		premos = premos + "boolean jetr = false;\r\n";
		premos = premos + "if (jetr) { //(control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n";
		premos = premos + "%////><jsp:forward page=\"logout.jsp\"/><////%}%////><////%\r\n";
		premos = premos + "try {\r\n";
		premos = premos + "boolean bok=false;\r\n";
		
		
		String dodaten = "";
		if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getTemplateClasss()!=null && tu.getTemplateClassClass().getTemplateClasss().size()>0) {
			
			Iterator tre = tu.getTemplateClassClass().getTemplateClasss().iterator();
			while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
			if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
				}
			}
			else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
			}
			}
			/// dodaten pogoj da sploh gleda po bazi
			
			
			
		}
		
	 	 
		premos = premos + "if (true "+dodaten+") {\r\n";
							 
		premos = premos + "com.popultrade.dao."+tmdd.getClass_name()+"DAO doax =(com.popultrade.dao."+ tmdd.getClass_name()+"DAO)contextUtil.getBeanDao(\""+tmdd.getClass_name().substring(0,1).toLowerCase() +tmdd.getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

		premos = premos + "com.popultrade.model."+tmdd.getClass_name() +" modx = new com.popultrade.model."+tmdd.getClass_name() +"();\r\n";



		com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",servletContext);

		/// setam vrednosti

		com.popultrade.model.TemplateDDPogoji sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tmdd.getId());
		sifh.setTip("P");
		
	

		List lish =null;
		
		lish = daodd.getTemplateDDPogojis(sifh);
		Iterator tre = lish.iterator();
		String daj_v_parameter="";
		Hashtable metos = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tmdd.getClass_name());
		while (tre.hasNext()) {
com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			//String rett="request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\")+\"\"";
			
			String rett="";
			
			if (tcc.getVrednost_metode().indexOf("request.getPara")!=-1) {
				//rett=""+tcc.getVrednost_metode().replaceAll("\'","\"")+"+\"\"";
				rett="request.getParameter(\""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"\")+\"\"";
			}
			else {
						
				
				
				
				if (!nul.jeNull(tcc.getVrednost_fiksna()).equals("1")) {
					
					rett="request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\")+\"\"";
					}
			else {
				rett="\""+tcc.getVrednost_metode().replaceAll("\'","\"")+"\"";
					
			}
				
				
				
					}	
			
			
			if (tcc.getVrednost_metode().indexOf("control.")!=-1 || tcc.getVrednost_metode().indexOf("nul.")!=-1) {
				 rett=tcc.getVrednost_metode().replaceAll("\'","\"");
			}
			if (metos.containsKey(tcc.getIme_metode())) {
			if (((String)metos.get(tcc.getIme_metode())).indexOf("Long")!=-1) {
				
				
				
				rett = "new Long("+rett+")";
				
				
				
			}
			else if (((String)metos.get(tcc.getIme_metode())).indexOf("int")!=-1 || ((String)metos.get(tcc.getIme_metode())).indexOf("Integer")!=-1) {
				rett = "Integer.parseInt("+rett+")";
				
			}
			else if (((String)metos.get(tcc.getIme_metode())).indexOf("Double")!=-1) {
			
				rett = "Double.parseDouble("+rett+")";
			}
			}
			
	
			
			if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
				premos = premos + tcc.getPogoj_uporabe().replaceAll("\'","\"") + " {\r\n";
			}
			if (!nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
			premos = premos + "modx."+tcc.getIme_metode()+"("+rett+");\r\n";
			}
			if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
				premos = premos + " }\r\n";
			}
			
			
			String dodd = "&";
			String addi="";
			boolean preej = true;
			if (daj_v_parameter.equals("")) {
				dodd = "?";
			}
			if (tcc.getVrednost_metode().indexOf("control.")!=-1 || tcc.getVrednost_metode().indexOf("nul.")!=-1) {
			//	daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"=<////%="+tcc.getVrednost_metode()+"%////>";
			//	preej = false;
			
			}	
			else {
				
				if (!nul.jeNull(tcc.getVrednost_fiksna()).equals("1")) {
    			daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"='+document.dod."+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+".value +'";
    			}
		else {
    				
    				
    				if (nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
    					
    					String vredmet = tcc.getVrednost_metode();
    					if (vredmet.indexOf("request.getParameter")!=-1) {
    						vredmet = vredmet.substring(vredmet.indexOf("'")+1,vredmet.lastIndexOf("'"));
    					}
    				
    					daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+vredmet+"=<////%="+tcc.getVrednost_metode().replaceAll("'","\"")+"%////>";
        				
    				}
    				else {
    				daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"="+tcc.getVrednost_metode();
    				}
    			}
			preej=true;
			}
		}

	
		String order_by = "";
		if (!nul.jeNull(tmdd.getHead_select_dodatni_pogoji()).equals("")) {
			order_by = nul.jeNull(tmdd.getHead_select_dodatni_pogoji());
		}
		
		String order_by_smer = "";
		
		if (!nul.jeNull(tmdd.getOrder_by_smer()).equals("")) {
			order_by_smer = nul.jeNull(tmdd.getOrder_by_smer());
		}
		String dodaten_HQL = "";
		
		premos = premos + "String dod_hql=\"\";\r\n";
		
		if (nul.jeNull(tmdd.getUporabi_dodaten_hql_pogoj()).equals("1")) {
			dodaten_HQL="sss";
			/// pogoj hql
			if (!nul.jeNull(tmdd.getPogoj_za_uporabo_hql()).equals("")) {
				premos = premos + nul.jeNull(tmdd.getPogoj_za_uporabo_hql())+" {\r\n";
			}
			premos = premos + " dod_hql=\""+nul.jeNull(tmdd.getDodaten_hql_pogoj())+"\";\r\n";
			if (!nul.jeNull(tmdd.getPogoj_za_uporabo_hql()).equals("")) {
				premos = premos + " }\r\n";
			}
			
			
		}
		
		if (order_by.equals("") && dodaten_HQL.equals("")) {
		premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s(modx,\"\",\"\");\r\n";
		}
		else if (!dodaten_HQL.equals("")) {
			premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s2(modx,\""+order_by+"\",\""+order_by_smer+"\",dod_hql);\r\n";
		}
		else {
			premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s(modx,\""+order_by+"\",\""+order_by_smer+"\");\r\n";
		}


		premos = premos + "String rezu_format=\"\";\r\n";
		premos = premos + "if (remix.size()>0) {\r\n";
		
		
		
 		sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tmdd.getId());
		sifh.setTip("V");
		
	
		
		lish = daodd.getTemplateDDPogojis(sifh);
		tre = lish.iterator();
		String daj_v_id="";
		String daj_v_set="";
		String daj_v_vrednost="";
		//String daj_v_div="";
		/////// vrednosti pogoja
		while (tre.hasNext()) {
			com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			if (!nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
			
			if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("1")) {
				//// uporabim format vrednosti ali ne
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
				
				daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
				}
				else {
					daj_v_id = daj_v_id+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
					
					daj_v_id = daj_v_id +"<%=rezu_format%////> ___ ";
					
				}
				
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
					
				daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
				}
				else {
					daj_v_vrednost = daj_v_vrednost+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
					
					daj_v_vrednost = daj_v_vrednost +"<%=rezu_format%////> ";
					
				}
				
				
				
				daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
				
			}
			else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("2")) {
			
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
				daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
				}
				else {
					daj_v_id = daj_v_id+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
					
					daj_v_id = daj_v_id +"<%=rezu_format%////> ___ ";
					
				}
				//daj_v_id = daj_v_id +"<%try{String yt =<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////><%}catch(Exception ex){}%////> ___ ";
			//	daj_v_vrednost = daj_v_vrednost + "<%="+tcc.getRezultat_metode()+"%////> ";
			
				daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
			}
			
			else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("3")) {
				//daj_v_id = daj_v_id +"<%="+tcc.getRezultat_metode()+"%////> ___ ";
			//	daj_v_vrednost = daj_v_vrednost + "<%try{String yt =<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////><%}catch(Exception ex){}%////> ";
				//daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
				if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
					
					daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
					}
					else {
						daj_v_vrednost = daj_v_vrednost+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
						
						daj_v_vrednost = daj_v_vrednost +"<%=rezu_format%////> ";
						
					}
				//daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
			}
			}
		
		}
		  
		if (daj_v_id.endsWith(" ___ ")) {
			daj_v_id = daj_v_id.substring(0,daj_v_id.lastIndexOf(" ___ "));
		}
		if (daj_v_set.endsWith(" ___ ")) {
			daj_v_set = daj_v_set.substring(0,daj_v_set.lastIndexOf(" ___ "));
		}
		
		
		premos = premos + "Iterator itx = remix.iterator();\r\n";
		//System.out.println(request.getParameter("letters") + " ::: omi" );
		premos = premos + "while (itx.hasNext()) {\r\n";
		premos = premos + "com.popultrade.model."+tmdd.getClass_name()+" vsebx = (com.popultrade.model."+tmdd.getClass_name()+")itx.next();\r\n";
		premos = premos + "%////>"+daj_v_id+"###"+daj_v_vrednost+"|<////%\r\n";	
		premos = premos + "}\r\n";

		
		premos = premos + "}\r\n";
		premos = premos + "}\r\n";
		
		
		premos = premos + "}\r\n";
		premos = premos + "catch (Exception ex){\r\n";
		premos = premos + "org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n";
		
		premos = premos + "log.error(ex.toString());\r\n";
		premos = premos + "}%////>\r\n";
		
	
		try {
		/// shranim file za ajax
		if ((tmdd.getStatus()).equals("1")) {
		Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"), "latin1"));



		out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
		////zaprem writer3
		out3.close();
		String velike_crke = nul.jeNull(tu.getSamo_velike_crke());
		
		retx= "  autocomplete=\"off\" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();"+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+"\" onfsocus=\"ajax_options_hide();change(this,'yellow');"+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"")+"')\" onkeyup=\""+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"")+"')\" ";
		}
		}
		catch (Exception exx) {
			System.out.println("NAPAKA AJAX::: "+exx.toString());
		}
		}
		else { /////// AJAX KONTROLA
			
			

			
			

			premos = premos + "<////%@ page contentType=\"text/html\\;\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////><jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/><jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" /><jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" /><jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" /><jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" /><////%\r\n";
			premos = premos + "request.setCharacterEncoding(control.encoding);\r\n";
			premos = premos + "response.setContentType(\"text/html; charset=\"+control.encoding);\r\n";
			premos = premos + "response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n";
			premos = premos + "response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n";
			premos = premos + "response.addDateHeader(\"Expires\", 0);\r\n";
			premos = premos + "boolean jetr = false;\r\n";
			premos = premos + "if (jetr) { //(control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n";
			premos = premos + "%////><jsp:forward page=\"logout.jsp\"/><////%}%////><////%\r\n";
			premos = premos + "try {\r\n";
			premos = premos + "boolean bok=false;\r\n";
			
			
			String dodaten = "";
			if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getTemplateClasss()!=null && tu.getTemplateClassClass().getTemplateClasss().size()>0) {
			
				Iterator tre = tu.getTemplateClassClass().getTemplateClasss().iterator();
				while (tre.hasNext()) {
				com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
				if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
					if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
					
					dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
					}
				}
				else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
					dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
				}
				}
				/// dodaten pogoj da sploh gleda po bazi
				
				
				
			}
		
		 	 
			premos = premos + "if (true "+dodaten+") {\r\n";
								 
			premos = premos + "com.popultrade.dao."+tmdd.getClass_name()+"DAO doax =(com.popultrade.dao."+ tmdd.getClass_name()+"DAO)contextUtil.getBeanDao(\""+tmdd.getClass_name().substring(0,1).toLowerCase() +tmdd.getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

			premos = premos + "com.popultrade.model."+tmdd.getClass_name() +" modx = new com.popultrade.model."+tmdd.getClass_name() +"();\r\n";



			com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",servletContext);

			/// setam vrednosti

			com.popultrade.model.TemplateDDPogoji sifh = new com.popultrade.model.TemplateDDPogoji();


			sifh.setTemplatedd_id(tmdd.getId());
			sifh.setTip("P");
			
		
			List lish =null;
			
			lish = daodd.getTemplateDDPogojis(sifh);
			Iterator tre = lish.iterator();
			String daj_v_parameter="";
			String daj_v_js_f="";
			
			Hashtable metos = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tmdd.getClass_name());
			while (tre.hasNext()) {
	com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
				
	String rett="";
	
	if (nul.jeNull(tcc.getVrednost_fiksna()).equals("1")) {
		//	daj_v_js = daj_v_js + " '"+tcc.getVrednost_metode().toLowerCase()+"',";
			daj_v_js_f = daj_v_js_f + ""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"=<////%="+tcc.getVrednost_metode().replaceAll("\'","\"")+"%////>&";
		}
		else {
			
			daj_v_js_f = daj_v_js_f + ""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"=\"+encodeURIComponent(document.dod."+tcc.getVrednost_metode().toLowerCase()+".value)+\"&";
			

			
			
			//daj_v_js = daj_v_js + " document.dod."+tcc.getVrednost_metode().toLowerCase()+".value,";
		}
	
	
	
	
	/*if (tcc.getVrednost_metode().indexOf("request.getPara")!=-1) {
		rett=""+tcc.getVrednost_metode().replaceAll("\'","\"")+"+\"\"";
	}
	else {*/
				 rett="request.getParameter(\""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"\")+\"\"";
		//	}	
				
				
				
				if (tcc.getVrednost_metode().indexOf("control.")!=-1 || tcc.getVrednost_metode().indexOf("nul.")!=-1) {
					 rett=tcc.getVrednost_metode().replaceAll("\'","\"");
				}
				if (metos.containsKey(tcc.getIme_metode())) {
				if (((String)metos.get(tcc.getIme_metode())).indexOf("Long")!=-1) {
					
					
					
					rett = "new Long("+rett+")";
					
					
					
				}
				else if (((String)metos.get(tcc.getIme_metode())).indexOf("int")!=-1 || ((String)metos.get(tcc.getIme_metode())).indexOf("Integer")!=-1) {
					rett = "Integer.parseInt("+rett+")";
					
				}
				else if (((String)metos.get(tcc.getIme_metode())).indexOf("Double")!=-1) {
				
					rett = "Double.parseDouble("+rett+")";
				}
				}
				
		
				
				if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
					premos = premos + tcc.getPogoj_uporabe().replaceAll("\'","\"") + " {\r\n";
				}
					
					if (!nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
				premos = premos + "modx."+tcc.getIme_metode()+"("+rett+");\r\n";
					}
				
				if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
					premos = premos + " }\r\n";
				}
				
				
				String dodd = "&";
				String addi="";
				boolean preej = true;
				if (daj_v_parameter.equals("")) {
					dodd = "?";
				}
				if (tcc.getVrednost_metode().indexOf("control.")!=-1 || tcc.getVrednost_metode().indexOf("nul.")!=-1) {
				//	daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"=<////%="+tcc.getVrednost_metode()+"%////>";
				//	preej = false;
				
				}	
				else {
					
					if (!nul.jeNull(tcc.getVrednost_fiksna()).equals("1")) {
	    			daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"='+document.dod."+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+".value +'";
	    			}
					else {
	    				
	    				
	    				if (nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
	    					
	    					String vredmet = tcc.getVrednost_metode();
	    					if (vredmet.indexOf("request.getParameter")!=-1) {
	    						vredmet = vredmet.substring(vredmet.indexOf("'")+1,vredmet.lastIndexOf("'"));
	    					}
	    				
	    					daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+vredmet+"=<////%="+tcc.getVrednost_metode().replaceAll("'","\"")+"%////>";
	        				
	    				}
	    				else {
	    				daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"="+tcc.getVrednost_metode();
	    				}
	    			}
				preej=true;
				}
				
				
			}

		
			String order_by = "";
			if (!nul.jeNull(tmdd.getHead_select_dodatni_pogoji()).equals("")) {
				order_by = nul.jeNull(tmdd.getHead_select_dodatni_pogoji());
			}
			
			String order_by_smer = "";
			
			if (!nul.jeNull(tmdd.getOrder_by_smer()).equals("")) {
				order_by_smer = nul.jeNull(tmdd.getOrder_by_smer());
			}
			String dodaten_HQL = "";
			
			premos = premos + "String dod_hql=\"\";\r\n";
			
			if (nul.jeNull(tmdd.getUporabi_dodaten_hql_pogoj()).equals("1")) {
				dodaten_HQL="sss";
				/// pogoj hql
				if (!nul.jeNull(tmdd.getPogoj_za_uporabo_hql()).equals("")) {
					premos = premos + nul.jeNull(tmdd.getPogoj_za_uporabo_hql())+" {\r\n";
				}
				premos = premos + " dod_hql=\""+nul.jeNull(tmdd.getDodaten_hql_pogoj())+"\";\r\n";
				if (!nul.jeNull(tmdd.getPogoj_za_uporabo_hql()).equals("")) {
					premos = premos + " }\r\n";
				}
				
				
			}
			
			//if (order_by.equals("") && dodaten_HQL.equals("")) {
			//premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s(modx,\"\",\"\");\r\n";
			//}
			//else if (!dodaten_HQL.equals("")) {
				premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s2(modx,\""+order_by+"\",\""+order_by_smer+"\",dod_hql);\r\n";
			//}
			//else {
			//	premos = premos + "List remix=doax.get"+tmdd.getClass_name()+"s(modx,\""+order_by+"\",\""+order_by_smer+"\");\r\n";
		//	}
//


			premos = premos + "if (remix.size()>0) {\r\n";
			
			
			
	 		sifh = new com.popultrade.model.TemplateDDPogoji();


			sifh.setTemplatedd_id(tmdd.getId());
			sifh.setTip("V");
			
		
	
			
			lish = daodd.getTemplateDDPogojis(sifh);
			tre = lish.iterator();
			String daj_v_id="";
			String daj_v_set_f="";
			String daj_v_vrednost="";
			String daj_v_js="";
			
			//String daj_v_div="";
			/////// vrednosti pogoja
			int zapo = 0;
			while (tre.hasNext()) {
				com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
				
	
						
						
						
						
				
				if (!nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
				
				if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("1")) {
					//daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
					daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt.replaceAll(\"\\\"\",\"'\")%////><%}catch(Exception ex){}%////> ___ ";
					daj_v_set_f = daj_v_set_f +"document.dod."+ tcc.getIme_metode().replaceAll("get","").toLowerCase()+".value=rezu["+zapo+"];\r\n\r\n";
					
				}
				/*else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("2")) {
					daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
					
					//daj_v_id = daj_v_id +"<%try{String yt =<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////><%}catch(Exception ex){}%////> ___ ";
				//	daj_v_vrednost = daj_v_vrednost + "<%="+tcc.getRezultat_metode()+"%////> ";
					daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
				}
				
				else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("3")) {
					//daj_v_id = daj_v_id +"<%="+tcc.getRezultat_metode()+"%////> ___ ";
				//	daj_v_vrednost = daj_v_vrednost + "<%try{String yt =<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////><%}catch(Exception ex){}%////> ";
					daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
					
					//daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
				}*/
				}
			zapo++;
			}
			  
			if (daj_v_id.endsWith(" ___ ")) {
				daj_v_id = daj_v_id.substring(0,daj_v_id.lastIndexOf(" ___ "));
			}
			if (daj_v_set_f.endsWith(" ___ ")) {
				daj_v_set_f = daj_v_set_f.substring(0,daj_v_set_f.lastIndexOf(" ___ "));
			}
			
			
		//	premos = premos + "Iterator itx = remix.iterator();\r\n";
			//System.out.println(request.getParameter("letters") + " ::: omi" );
			
			
			
			premos = premos + "if (remix.size()>0) {\r\n";
			
			if (daj_v_vrednost.equals("")) {
			premos = premos + "%////>OBSTAJA<////%\r\n";	
			}
			else {
				
				premos = premos + "com.popultrade.model."+tmdd.getClass_name()+" vsebx = (com.popultrade.model."+tmdd.getClass_name()+")remix.get(0);\r\n";
				premos = premos + "%////>|||"+daj_v_vrednost+"|||<////%\r\n";	
			}
			
			premos = premos + "}\r\n";
			
		/*	
			premos = premos + "while (itx.hasNext()) {\r\n";
			premos = premos + "com.popultrade.model."+tmdd.getClass_name()+" vsebx = (com.popultrade.model."+tmdd.getClass_name()+")itx.next();\r\n";
			premos = premos + "%////>"+daj_v_id+"###"+daj_v_vrednost+"|<////%\r\n";	
			premos = premos + "}\r\n";
*/
			
			
			
			
			premos = premos + "}\r\n";
			premos = premos + "}\r\n";
			
			
			premos = premos + "}\r\n";
			premos = premos + "catch (Exception ex){\r\n";
			premos = premos + "org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n";
			
			premos = premos + "log.error(ex.toString());\r\n";
			premos = premos + "}%////>\r\n";
			
		
			try {
			/// shranim file za ajax
			if ((tmdd.getStatus()).equals("1")) {
			Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+tmdd.getClass_name().toLowerCase()+tmdd.getId()+"_kon.jsp"), "latin1"));



			out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
			////zaprem writer3
			out3.close();
			//String velike_crke = nul.jeNull(tu.getSamo_velike_crke());
			
	premos = "";
			
			////// kontrole ajax js
			
			if (!daj_v_js_f.equals("")) {
				
		
			
	premos = premos + "function check"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+"() {\r\n";
	 
	premos = premos + "xmlHttp=GetXmlHttpObject();\r\n";
	premos = premos + "if (xmlHttp==null) {\r\n";
	premos = premos + "alert (\"Browser does not support HTTP Request\");\r\n";
	premos = premos + "return false;\r\n";
	premos = premos + "} \r\n";
	 
	premos = premos + "var url=\""+tmdd.getClass_name().toLowerCase()+tmdd.getId()+"_kon.jsp"+"\";\r\n";
	premos = premos + "url=url+\"?"+daj_v_js_f.substring(0,daj_v_js_f.length()-1)+"\";\r\n";
//	premos = premos + "url=url+\"&idc=\";\r\n";
	premos = premos + "url=url+\"&sid=\"+Math.random();\r\n";
	 
	premos = premos + "xmlHttp.open(\"GET\",url,false);\r\n";
	premos = premos + "xmlHttp.send(null);\r\n";
	if (daj_v_set_f.equals("")) {
	
	premos = premos + "if (xmlHttp.responseText.indexOf(\"OBSTAJA\")==-1) {\r\n";
	premos = premos + "return false;\r\n";
	premos = premos + "}\r\n";
	}
	else {
		premos = premos + "if (xmlHttp.responseText.indexOf(\"|||\")!=-1) {\r\n";
		premos = premos + "var kom=xmlHttp.responseText.substring(xmlHttp.responseText.indexOf(\"|||\")+3,xmlHttp.responseText.lastIndexOf(\"|||\"));\r\n";
		
		premos = premos + "var rezu = kom.split(\" ___ \");\r\n";
		premos = premos + daj_v_set_f;
		
		premos = premos + "}\r\n";
		premos = premos + "else {\r\n";
		premos = premos + "return false;\r\n";
		premos = premos + "}\r\n";
	}
	
	premos = premos + "return true;\r\n";
	
	premos = premos + "}\r\n";
	
	this.setKontrolaAjaxJS(premos);
	
	premos = "";
	premos = premos + "if (!check"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+"()) {\r\n";
	premos = premos + "alert('<////%=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \")%////>');\r\n";
	premos = premos + "return false;\r\n";
	premos = premos + "}\r\n";
	
	if (!nul.jeNull(tmdd.getUporabi_kontrolo_rocno()).equals("1")) {
	this.setKontrolaAjaxJSf(premos);
	}
	
	premos = "";
			}
			
			
			
			
			
			
			
			
			
			//	return "  autocomplete=\"off\"  onfocus=\""+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"')\" onkeyup=\""+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"')\" ";
			}
			}
			catch (Exception exx) {
				System.out.println("NAPAKA AJAX::: "+exx.toString());
			}
			}
			
			
	
		
		
		
		
	}
		
	}
	return retx;
	 
	
}

private String kontrolaAjaxJS=""; //// setam funkcije klicanje AJAXA preko JS
private String kontrolaAjaxJSf=""; //// setam klicanje AJAXA 

public void setKontrolaAjaxJS(String kontrola) {
kontrolaAjaxJS =kontrolaAjaxJS+kontrola;
}
	

public String getKontrolaAjaxJS() {
return kontrolaAjaxJS;
}


public void setKontrolaAjaxJSf(String kontrola) {
	kontrolaAjaxJSf =kontrolaAjaxJSf+kontrola;
	}
		

	public String getKontrolaAjaxJSf() {
	return kontrolaAjaxJSf;
	}








public String getFormatReturn(String classname,String parameter,String vrednostvmes) {
	
	
	
	
	com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();
	
	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil2,this.getServletContext(),classname);

	

	String rett = vrednostvmes;
	
	System.out.println(parameter+ " ::: IME POGOJA ::: "+vrednostvmes);
	
	if (meto.containsKey(parameter)) {
		if (((String)meto.get(parameter)).indexOf("String")!=-1) {
			
		//System.out.println("SOLEMMM : "+rett);
		
		if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1) {
			//rett = rett+"\"\"";
		}
		
		else	if (rett.indexOf("\"")==-1) {
				//rett = "\""+rett+"\"";
			}
		}
		else if (((String)meto.get(parameter)).indexOf("Long")!=-1) {
			if (rett.indexOf("\"")==-1) {
				//rett = "\""+rett+"\"";
			}
			
			rett = "new Long("+rett+")";
			
		}
		else if (((String)meto.get(parameter)).indexOf("Integer")!=-1 || ((String)meto.get(parameter)).indexOf("int")!=-1) {
			if (rett.indexOf("\"")==-1) {
				
			
			//rett = rett.replaceAll("\"", "").replaceAll("\'", "");
			//rett = "\""+rett+"\"";
			}
			
			rett = "Integer.parseInt("+rett+"+\"\")";
			
		}
		else if (((String)meto.get(parameter)).indexOf("Double")!=-1) {
			if (rett.indexOf("\"")==-1) {
				//rett = rett.replaceAll("\"", "").replaceAll("\'", "");
			//	rett = rett.replaceAll("\"", "").replaceAll("\'", "");
			//	rett = "\""+rett+"\"";
			}
			if (rett.indexOf(",")!=-1) {
			//	rett = rett.replaceAll("\\,", "\\.");
			}
			rett = "Double.parseDouble("+rett+"+\"\")";
			
		}
		
	}
	
	
	
	return rett;
	
	//sb.append("sif."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");

	
	
	
	
	//return "";
	
	
}

%>


<%

// stevilo prikazov vrstic

int stpri = control.st_vrstic;

String napaka = "";
// steje stevilo vrstic
int stej = 0;

// barve vrstic
String[] colors = {"plava1","plava2","silver"};


String imefile="";


// stevilo vrstic
int stvrstic=0;

boolean iskanje=false;

try {

	

	
	System.out.println(" ========dddddddddddd " +request.getParameter("id"));
	
	
// get list from daoobject
com.popultrade.dao.TemplateHeadDAO dao = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());



com.popultrade.model.TemplateHead sif = new com.popultrade.model.TemplateHead();


sif = dao.getTemplateHead(new Long(request.getParameter("id")));


imefile = sif.getHead_class_name();
StringBuffer sb =new StringBuffer();
String order_by = nul.jeNull(sif.getHead_select_dodatni_pogoji());
String order_by_smer = nul.jeNull(sif.getOrder_by_smer());
String class_name = sif.getHead_class_name();
String idpr = sif.getId()+"";
String dodaten_sql_pogoj =  "";///sif.getHead_select_dodatni_pogoji();

///// dodatni pogoji, v javi
com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();

com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());

tuidd = daouid.getTemplateUiDodatnos(idpr);



 /// ce ima vezo iz gumba
 String targett = "";
 com.popultrade.dao.TemplateGumbiDAO daotgi = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());

 
 com.popultrade.model.TemplateGumbi tgumb = new com.popultrade.model.TemplateGumbi() ;
 
 
 if (sif.getVeza_gumb()!=null && !sif.getVeza_gumb().toString().equals("")) {


tgumb = daotgi.getTemplateGumbi(sif.getVeza_gumb());

	

targett = nul.jeNull(tgumb.getTarget_gumba());




///// ce je target interni frame naredim dodaten file za interno
StringBuffer sbu = new StringBuffer();
if (targett.equals("3") || targett.equals("4") || targett.equals("5") || targett.equals("6") || targett.equals("7") || targett.equals("8")) {
	
	
sbu.append("<////%@ page contentType=\"text/html; charset=windows-1250\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*\"%////>\r\n");

sbu.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sbu.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");


sbu.append("<%\r\n");

sbu.append("if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
sbu.append("%////><jsp:forward page=\"m_loginu.html\"/><////%\r\n");
sbu.append("}\r\n");

sbu.append(" String userAgent = request.getHeader( \"User-Agent\" );\r\n");
sbu.append("boolean isFirefox = ( userAgent != null && userAgent.indexOf( \"Firefox/\" ) != -1 );\r\n");
sbu.append("String size=\"0\";\r\n");
sbu.append("String scrol = \"yes\";\r\n");
sbu.append("if (isFirefox) {\r\n");
sbu.append("size=\"1\";\r\n");
sbu.append("scrol=\"auto\";\r\n");
sbu.append("}\r\n");

sbu.append("%////>\r\n");

sbu.append("<html>\r\n");


String colss = "vertical";
String frum = "frameinc_";

if (targett.equals("3") || targett.equals("4") || targett.equals("5")) {
	colss ="horizontal";
	frum = "frameinr_";
}
String predpo = "";
if (sif.getHead_tip().equals("SE")) {
	predpo="_isci"+sif.getId();
}
else if (sif.getHead_tip().equals("UI")) {
	predpo="_edit"+sif.getId();
}
else if (sif.getHead_tip().equals("HT")) {
	predpo="_edit"+sif.getId();
}
else if (sif.getHead_tip().equals("HE")) {
	predpo="_view"+sif.getId();
}
else if (sif.getHead_tip().equals("FU")) {
	predpo="_funk"+sif.getId();
}
else if (sif.getHead_tip().equals("PR")) {
	predpo="_proc"+sif.getId();
}
else if (sif.getHead_tip().equals("PD")) {
	predpo="_pdf"+sif.getId();
}
else if (sif.getHead_tip().equals("LI")) {
	predpo="_list"+sif.getId();
}
else if (sif.getHead_tip().equals("LT")) {
	predpo="_list"+sif.getId();
}
else if (sif.getHead_tip().equals("OB")) {
	predpo="_ob"+sif.getId();
}
else if (sif.getHead_tip().equals("UP")) {
	predpo="_upload"+sif.getId()+"_1";
}
else if (sif.getHead_tip().equals("UR")) {
	predpo="_ur1"+sif.getId()+"";
}
else if (sif.getHead_tip().equals("EX")) {
	predpo="_exp"+sif.getId();
}
else if (sif.getHead_tip().equals("EE")) {
	predpo="_expe"+sif.getId();
}
Iterator igy = tgumb.getTemplateGumbiParametris().iterator();

String parametri = "";
boolean prv = false;
while (igy.hasNext()) {
	 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)igy.next();
	 String ehn = "&";
	 if (!prv) {
		 ehn = "?"; 
		 prv=true;
	 }
	 
	 
	 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
		 parametri = parametri + ehn+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 
	 }
	 else {
	 parametri = parametri + ehn+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"=< %=request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\")%////>";
	 }


}

/*
sbu.append("<frameset "+colss+"=\"50%,50%\" framespacing=\"0\" border=\"<////%=size%////>\" frameborder=\"<////%=size%////>\">\r\n");
sbu.append("<frame name=\""+imefile+"prvain\" target=\""+imefile+"drugain\"  marginheight=\"1\"  scrolling=\"<////%=scrol %////>\"   src=\""+imefile.toLowerCase()+predpo+".jsp"+parametri+"\"   style=\"border-style: solid; border-width: 1\">\r\n");

sbu.append("<frame name=\""+imefile+"drugain\" target=\""+imefile+"prvain\" src=\"nic.jsp\"  marginheight=\"1\"   scrolling=\"<////%=scrol %////>\"   style=\"border-style: solid; border-width: 1\">\r\n");
  sbu.append("<noframes>\r\n");
  sbu.append("<body>\r\n");

  sbu.append("<p>This page uses frames, but your browser doesn't support them.</p>\r\n");

  sbu.append("</body>\r\n");
  sbu.append("</noframes>\r\n");
sbu.append("</frameset>\r\n");

sbu.append("</html>\r\n");
		 */
	 
		 
		 

sbu.append("<link href='js/css/sm-core-css.css' rel='stylesheet' type='text/css' />\r\n");

sbu.append("<link href='js/css/sm-simple/sm-simple.css' rel='stylesheet' type='text/css' />\r\n");



sbu.append("<link rel=\"stylesheet\" href=\"js/styles/jqx.base.css\" type=\"text/css\" />\r\n");
  sbu.append("<link rel=\"stylesheet\" href=\"js/styles/jqx.classic.css\" type=\"text/css\" />\r\n");
    sbu.append("<script type=\"text/javascript\" src=\"scripts/jquery.min.js\"></script>\r\n");
    sbu.append("<script type=\"text/javascript\" src=\"scripts/jquery-migrate-3.0.0.min.js\"></script>\r\n");
    sbu.append("<script type=\"text/javascript\" src=\"js/jqxcore.js\"></script>\r\n");
    sbu.append("<script type=\"text/javascript\" src=\"js/jqxsplitter.js\"></script>\r\n");
    sbu.append("<link rel=\"stylesheet\" href=\"js/styles/jqx.base.css\" type=\"text/css\" />\r\n");

sbu.append("<script src=\"js/jquery.smartmenus.js\" type=\"text/javascript\"></script>\r\n");


sbu.append("<style type=\"text/css\">\r\n");
sbu.append("#main-menu {\r\n");
		sbu.append("position:relative;\r\n");
	sbu.append("z-index:9999;\r\n");
	sbu.append("width:auto;\r\n");
	sbu.append("}\r\n");
	sbu.append("#main-menu ul {\r\n");
		sbu.append("width:12em; \r\n");
	sbu.append("}\r\n");
	
	
	
	sbu.append("</style>\r\n");


    
sbu.append("<style type=\"text/css\">\r\n");

    sbu.append("html, body\r\n");
sbu.append("{\r\n");
	sbu.append("margin: 0;\r\n");
	sbu.append("padding: 0;\r\n");
sbu.append("overflow: hidden;\r\n");
sbu.append("}\r\n");

sbu.append("</style>\r\n");



sbu.append("<body "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+" >\r\n");
sbu.append("<table cellspacing=0 cellpadding=0 width=100% height=100% >\r\n");
sbu.append("<tr><td>\r\n");

sbu.append("<div id=\"mainSplitter\">\r\n");
sbu.append("<div id='topp' style=\"background-image:url('podlaga.jpg');\">\r\n");
     
sbu.append("<iframe noresize=\"noresize\"  id=\"ifr2\" name=\""+imefile+"prvain\" target=\""+imefile+"drugain\"  scrolling=\"yes\" frameborder=\"0\"   src=\""+imefile.toLowerCase()+predpo+".jsp"+parametri+"\"   style=\"width:100%;height:100%\"  >b</iframe>\r\n");
sbu.append("</div>\r\n");

sbu.append("<div  style=\"background-image:url('podlaga.jpg');\">\r\n");


sbu.append("<iframe noresize=\"noresize\" id=\"ifr3\" name=\""+imefile+"drugain\" target=\""+imefile+"prvain\" src=\"nic.jsp\" scrolling=\"yes\" frameborder=\"0\" style=\"width:100%;height:100%\"  onload=\"collapseL(this.contentWindow.location)\"  >b</iframe>\r\n");

sbu.append("</div>\r\n");
        

sbu.append("</div>\r\n");
sbu.append("</td></tr>\r\n");


sbu.append("</table>\r\n");
sbu.append("</body>\r\n");




sbu.append("<script language=\"javascript\">\r\n");

sbu.append("$(document).ready(function () {\r\n");
sbu.append("var theme = 'classic';\r\n");
  
//sbu.append("$('#mainSplitter').jqxSplitter({ theme: theme, width: '100%', height: '100%', orientation: '"+colss+"', panels: [{ size: '50%',collapsible:false }, { size: '50%',collapsible:true}] });\r\n");
sbu.append("$('#mainSplitter').jqxSplitter({ theme: theme, width: '100%', height: '100%', orientation: '"+colss+"', panels: [{ size: '"+(nul.jeNull(tgumb.getSize_left()).equals("")?"50%":tgumb.getSize_left())+"',collapsible:false }, { size: '"+(nul.jeNull(tgumb.getSize_right()).equals("")?"50%":tgumb.getSize_right())+"',collapsible:true}] });\r\n");

sbu.append("});\r\n");


sbu.append("var prej = \"\";\r\n");
sbu.append("function collapseL(kajj) {\r\n");
    	 

sbu.append("}\r\n");
     
     
sbu.append("function resetPageBlockAll() {\r\n");


sbu.append("if (document.getElementById(\"ifr2\").contentWindow!=null && typeof document.getElementById(\"ifr2\").contentWindow.resetPageBlock === \"function\") { \r\n");
		sbu.append("document.getElementById(\"ifr2\").contentWindow.resetPageBlock();\r\n");
			sbu.append("}\r\n");
	sbu.append("if (document.getElementById(\"ifr3\").contentWindow!=null && typeof document.getElementById(\"ifr3\").contentWindow.resetPageBlock === \"function\") { \r\n");
		sbu.append("document.getElementById(\"ifr3\").contentWindow.resetPageBlock();\r\n");
	

			sbu.append("}\r\n");
	sbu.append("}\r\n");

 
     
     
sbu.append("</script>\r\n");

	 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 

/// shranim

Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+frum+imefile.toLowerCase()+predpo+".jsp"), "latin1"));



out3.write(sbu.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();

		
	 }
	 
	 
	 
	 
	 
	 
 }




//System.out.println(sif.getHead_tip() + " ======== ");




/////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
////////////////
//// kreacija jsp za download
if (sif.getHead_tip().equals("OB")) {

	
	System.out.println("Izdelujem OB jsp");

	//// odstranim iz cache
	
	if (ConPool.cache.containsKey("jsp"+sif.getId()+control.getJezik())) {
		ConPool.cache.remove("jsp"+sif.getId()+control.getJezik());
	}

///// dodatni pogoji, v javi
com.popultrade.model.TemplateUiDodatno tuidd2 = new com.popultrade.model.TemplateUiDodatno();

com.popultrade.dao.TemplateUiDodatnoDAO daouid2 = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());

tuidd2 = daouid2.getTemplateUiDodatnos(idpr);




	 String parametriSE = ""; // parametri za search, parmetri ki setirajo stran ostevilcenje ker qurystring je kot post

sb.append("<////%@ page trimDirectiveWhitespaces=\"true\"  contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.net.URLDecoder\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<////jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");
sb.append("<////%!\r\n");

sb.append("com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();\r\n");
sb.append("public void displayObject(HttpServletResponse resp,HttpServletRequest request,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,com.popultrade.webapp.control control,com.popultrade.webapp.conPool ConPool) {\r\n");




sb.append("try {\r\n");   
		
	
		
		

// get list from daoobject
if (!nul.jeNull(sif.getNosql()).equals("1")) {

sb.append("com.popultrade.dao."+imefile +"DAO dao = (com.popultrade.dao."+imefile +"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length()) +"DAO\",servletContext);\r\n");

}
else {
	
	sb.append("com.popultrade.dao."+imefile+"DAO dao = new com.popultrade.dao."+imefile+"DAO();\r\n");
}

sb.append("String orderby = \""+order_by+"\";\r\n");
sb.append("if (!nul.jeNull(request.getParameter(\"orderup\")).equals(\"\")) {\r\n");
sb.append("orderby = request.getParameter(\"orderup\");\r\n");


sb.append("}\r\n");

sb.append("String orderbysmer = \""+order_by_smer+"\";\r\n");
sb.append("if (!nul.jeNull(request.getParameter(\"orderupsmer\")).equals(\"\")) {\r\n");
sb.append("orderbysmer =request.getParameter(\"orderupsmer\");\r\n");
sb.append("}\r\n");
sb.append("String dodpog = \"\";\r\n");


sb.append("com.popultrade.model."+imefile +" sif = new com.popultrade.model."+imefile +"();\r\n");


//// setam pogoje za sif
dodaten_sql_pogoj = "";

if (sif.getTemplateClasss().size()>0) {
	
	
	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),imefile);
	Iterator ikov = sif.getTemplateClasss().iterator();
	boolean sem=false;
	while (ikov.hasNext()) {
	com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
	if (!nul.jeNull(tcc.getUporabi_hql()).equals("1")) {
	String rett = tcc.getVrednost_pogoja().replaceAll("\'","\"");
	
	//System.out.println(((String)meto.get(tcc.getIme_pogoja()))+ " ::: IME POGOJA ::: "+tcc.getIme_pogoja());
	
	if (meto.containsKey(tcc.getIme_pogoja())) {
		if (((String)meto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
			
		//System.out.println("SOLEMMM : "+rett);
		
		if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1) {
			//rett = rett+"\"\"";
		}
		
		else	if (rett.indexOf("\"")==-1) {
				rett = "\""+rett+"\"";
			}
		}
		else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
			if (rett.indexOf("\"")==-1) {
				rett = "\""+rett+"\"";
			}
			
			rett = "new Long("+rett+"+\"\")";
			
		}
		else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)meto.get(tcc.getIme_pogoja())).indexOf("int")!=-1) {
			if (rett.indexOf("\"")==-1) {
				
			
			rett = rett.replaceAll("\"", "").replaceAll("\'", "");
			rett = "\""+rett+"\"";
			}
			
			rett = "Integer.parseInt("+rett+"+\"\")";
			
		}
		else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
			if (rett.indexOf("\"")==-1) {
				//rett = rett.replaceAll("\"", "").replaceAll("\'", "");
				rett = rett.replaceAll("\"", "").replaceAll("\'", "");
				rett = "\""+rett+"\"";
			}
			if (rett.indexOf(",")!=-1) {
				rett = rett.replaceAll("\\,", "\\.");
			}
			rett = "Double.parseDouble("+rett+"+\"\")";
			
		}
		
	}
	
	if (nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
		sb.append("sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n");	
	}
	else {
		
	sb.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
	sb.append("sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
	sb.append(" }\r\n");
	
	}
	
	}
	else {
		
		if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
		sb.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
		}
		if (!sem) {
			dodaten_sql_pogoj = nul.jeNull(tcc.getDodaten_hql_pogoj()) ;
			sem=true;
			}
			else {
				dodaten_sql_pogoj =  "  "+nul.jeNull(tcc.getDodaten_hql_pogoj());
			}
			sb.append("dodpog += (!dodpog.equals(\"\")?\" and \":\"\")+ \""+dodaten_sql_pogoj+"\";\r\n");
			
		
		if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
		sb.append(" }\r\n");
		}
	}
	
	}
	
	
}

sb.append("String dodaten_sql_pogoj = dodpog;\r\n");
sb.append("String sedodatno = \"\";\r\n");
sb.append("String metodo = \"\";\r\n");
///////// searchi

sb.append("if (nul.jeNull(request.getParameter(\"isci\")).equals(\"yes\")) {\r\n");
//sb.append("iskanje = true;\r\n");
//sif = (com.popultrade.model.Users)contextUtil.getPopulatedObject(sif,request);





//// dobim searche za like katere ne upostevam potem za navaden search


com.popultrade.dao.TemplateSearchDAO daose = (com.popultrade.dao.TemplateSearchDAO)contextUtil.getBeanDao("templateSearchDAO",pageContext.getServletContext());
com.popultrade.model.TemplateSearch tese = new com.popultrade.model.TemplateSearch();

tese.setTemplatelist_id(sif.getId());
//String sedodatno = "";
List lise = daose.getTemplateSearchs(tese);
Hashtable likese = new Hashtable();

if (lise.size()>0) {
	
	
	Iterator itm = lise.iterator();
	
	while (itm.hasNext()) {
		
		com.popultrade.model.TemplateSearch si = (com.popultrade.model.TemplateSearch)itm.next();
		
		
		if (nul.jeNull(si.getSelike()).equals("1")) {
		/*Hashtable nexs = new Hashtable();
		
		nexs.put("selikel", nul.jeNull(si.getSelikel()));
		nexs.put("seliked", nul.jeNull(si.getSeliked()));
		nexs.put("seupper", nul.jeNull(si.getSeupper()));
		nexs.put("selower", nul.jeNull(si.getSelower()));
		*/
		likese.put(si.getStolpec_metoda().replaceFirst("get",""), "");
		
		String metod = si.getStolpec_metoda().substring(3).toLowerCase();
		
		String levo="";
		if (nul.jeNull(si.getSelikel()).equals("1")) {
		levo="%";
		}
		String desno ="";
		if (nul.jeNull(si.getSeliked()).equals("1")) {
		desno="%";
		}
		
		
		String uplo = "";
		
		if  (nul.jeNull(si.getSeupper()).equals("1")) {
		uplo=".toUpperCase()";
		}
		if  (nul.jeNull(si.getSelower()).equals("1")) {
		uplo=".toLowerCase()";
		}
		
		
		
		sb.append("if (!nul.jeNull(request.getParameter(\""+metod+"\")).equals(\"\")) {\r\n");
		sb.append("metodo=	\" "+metod+" like '"+(levo)+"\"+URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+metod+"\"))"+(uplo)+")+\"\", \"UTF-8\")+\""+(desno)+"' and \";\r\n");
		sb.append("sedodatno += metodo;\r\n");
		sb.append("}\r\n");
		
	//	sedodatno += metod;
		
		
		}
		
		
	}
		
}

sb.append("if (!sedodatno.equals(\"\")) {\r\n");

sb.append("if (sedodatno.endsWith(\"and \")) {\r\n");

sb.append("sedodatno= sedodatno.substring(0,sedodatno.lastIndexOf(\"and \"));\r\n");

sb.append("}\r\n");

sb.append("}\r\n");


sb.append("dodaten_sql_pogoj += (!dodaten_sql_pogoj.equals(\"\")?\" and \":\"\")+ sedodatno;\r\n");
			


/// dobim vse pogoje iskanja iz clase

 List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
		
		Iterator itti = li.iterator();

		while (itti.hasNext()) {
		
			String nex =(String)itti.next();
			
				if (nex.indexOf(").")==-1) {
			
			String param = nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceFirst("get","");
				
				if (!likese.containsKey(param)) {
				
				
			if (nex.indexOf("String")!=-1) {
			sb.append("if (!nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")).equals(\"\")) {\r\n");
			sb.append("sif.set"+param+"(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")))+\"\", \"UTF-8\"));\r\n");
			sb.append("}\r\n");
			}
			else if (nex.indexOf("Integer")!=-1) {// || nex.indexOf("int")!=-1) {
				sb.append("if (!nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")).equals(\"\")) {\r\n");
				sb.append("sif.set"+param+"(Integer.parseInt(control.trimLeftRight(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")))+\"\"));\r\n");
				sb.append("}\r\n");	
			}
			else if (nex.indexOf("Long")!=-1) {
				sb.append("if (!nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")).equals(\"\")) {\r\n");
				sb.append("sif.set"+param+"(new Long(control.trimLeftRight(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")))));\r\n");
				sb.append("}\r\n");
			}
			else if (nex.indexOf("java.util.Date")!=-1) {
				
				if (param.endsWith("1")) {
					sb.append("if (!nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")).equals(\"\")) {\r\n");
					sb.append("sif.set"+param+"(nul.parseDatumUra(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")+\" \"+(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"_U\")).equals(\"\")?\"00:00\":request.getParameter(\""+param.toLowerCase()+"_U\"))  )));\r\n");
					
					//sb.append("sif.set"+param+"(nul.parseDatumUra(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")+\" 00:00\")));\r\n");
					sb.append("}\r\n");

				}
				if (param.endsWith("2")) {
					sb.append("if (!nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")).equals(\"\")) {\r\n");
					sb.append("sif.set"+param+"(nul.parseDatumUra(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")+\" \"+(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"_U\")).equals(\"\")?\"23:59\":request.getParameter(\""+param.toLowerCase()+"_U\"))  )));\r\n");
					
					//sb.append("sif.set"+param+"(nul.parseDatumUra(nul.jeNull(request.getParameter(\""+param.toLowerCase()+"\")+\" 23:59\")));\r\n");
					sb.append("}\r\n");
					
				}
				
			}
			
			
			
			
			}
			
			
			
			
				
				}
				
			}



sb.append("}\r\n");
sb.append("else if (nul.jeNull(request.getParameter(\"isk\")).equals(\"1\")) {\r\n");
//sb.append("iskanje = true;\r\n");
//sb.append("sif = (com.popultrade.model."+imefile +")session.getAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");

sb.append("}\r\n");
sb.append("else {\r\n");

sb.append("}\r\n");















sb.append("List lis =null;\r\n");


		if (nul.jeNull(sif.getPosebna_funkcija()).equals("")) {
			
			
			if (nul.jeN(sif.getNosql()).equals("1")) {
				sb.append("lis = dao.get"+imefile +"s(sif,ConPool.getEntman(),orderby+orderbysmer,1,1);\r\n");
			}
			else {
		sb.append("lis = dao.get"+imefile +"s(sif,1,1,dodaten_sql_pogoj,orderby,orderbysmer);\r\n");
			}
		
		
		}
		else {
			
			if (!nul.jeNull(sif.getPosebna_funkcija_pogoj()).equals("")) {
				sb.append(sif.getPosebna_funkcija_pogoj() + " {\n\r");
				
				
			}
			sb.append("lis = dao."+sif.getPosebna_funkcija() +"(sif,pagenum,stizpisov,dodaten_sql_pogoj,orderby,orderbysmer);\r\n");
			if (!nul.jeNull(sif.getPosebna_funkcija_pogoj()).equals("")) {
				sb.append(" }\r\nelse {\n\r");
				sb.append("lis = dao.get"+imefile +"s(sif,pagenum,stizpisov,dodaten_sql_pogoj,orderby,orderbysmer);\r\n");
				
				sb.append(" }\r\n\n\r");
				
				
			}
		}
		
		
		
		
		sb.append("if (lis.size()>0) {\r\n\r\n");
		
		sb.append("Iterator it = lis.iterator();\r\n\r\n");

sb.append("String rezu=\"\";\r\n\r\n");



sb.append("while (it.hasNext()){  // while start\r\n");

sb.append("com.popultrade.model."+imefile +" vseb = (com.popultrade.model."+imefile +")(it.next());\r\n");
		
	com.popultrade.dao.TemplateObjektiBazaDAO dam = (com.popultrade.dao.TemplateObjektiBazaDAO)contextUtil.getBeanDao("templateObjektiBazaDAO",pageContext.getServletContext());
com.popultrade.model.TemplateObjektiBaza tem = new com.popultrade.model.TemplateObjektiBaza();

tem = dam.getTemplateObjektiBazaByVezaId(sif.getId());
		String ct = "";
		if (!nul.jeNull(tem.getBaza_content_type()).equals("")) {
		sb.append("resp.setContentType(vseb."+tem.getBaza_content_type()+"());\r\n");
		
		}
		else if (!nul.jeNull(tem.getContent_type_rocno()).equals("")) {
		sb.append("resp.setContentType(\""+tem.getContent_type_rocno()+"\");\r\n");
		
		}
		
		
		
		sb.append("byte[] num = vseb."+tem.getBaza_polje_objekt()+"();\r\n");
		sb.append("if (num!=null) {\r\n");
	/*	sb.append("byte[] num = new byte[blobb.length];\r\n");
	    sb.append("for (int i = 0; i < blobb.length; i++)\r\n");
	    sb.append("{\r\n");
	    sb.append("    num[i] = blobb[i];\r\n");
	    sb.append("}\r\n");*/
		
		
		String filn = "file\"+vseb.getId()+\"."+tem.getContent_type_extension()+"";
		
		if (tem.getBaza_ime_file()!=null && !tem.getBaza_ime_file().equals("")) {
		
		filn = tem.getBaza_ime_file();
		
		
		sb.append("String finme = nul.jeNull(vseb."+filn+"());\r\n");
		}
		else {
			sb.append("String finme = \""+filn+"\";\r\n");
		}
		
		
		
		
		sb.append("resp.setHeader(\"Content-Disposition\",\"attachment;filename=\"+finme+\"\");\r\n");
		sb.append("resp.setContentLength(num.length);\r\n");
		
		if (tem.getBaza_polje_objekt()!=null) {
		//ByteArrayInputStream bis = new ByteArrayInputStream(source);
		
		sb.append("OutputStream output = resp.getOutputStream();\r\n");
		
	
		sb.append("try {\r\n");
		
		sb.append("output.write(num);\r\n");
		
		sb.append("}\r\n");
		sb.append("catch (Exception k) {\r\n");
		sb.append("}\r\n");
		sb.append("output.flush();\r\n");
sb.append("output.close();\r\n");
		//sb.append("}\r\n");
		
		}
		
		
sb.append("break;\r\n}\r\n");
		sb.append("}\r\n");
	sb.append("}\r\n");	



sb.append("}\r\n");
sb.append("catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("////log.error(ex.toString());\r\n");
sb.append("}\r\n");



sb.append("}\r\n");

sb.append("%////>\r\n");
 
 
sb.append("<////%\r\n");

sb.append("if ((nul.jeNull(request.getHeader(\"referer\"))).startsWith(\"http://\"+ConPool.getRemote_address()) || (nul.jeNull(request.getHeader(\"referer\"))).startsWith(\"https://\"+ConPool.getRemote_address())) {\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("%////><jsp////:forward page=\"logout.jsp\"/><////%");
sb.append("}\r\n");



sb.append("////request.setCharacterEncoding(control.encoding);\r\n");
sb.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("////response.addDateHeader(\"Expires\", 0);\r\n");
sb.append("////if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
sb.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");

	
sb.append("<////% displayObject(response,request,contextUtil,pageContext.getServletContext(),control,ConPool); %////>\r\n");



imefile = imefile+"_ob"+sif.getId();



}




/////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////  OB KONEC
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
////////////////






/////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
////////////////
//// kreacija jsp za proceduro
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE ");
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());
if (sif.getHead_tip().equals("PR")) {

	System.out.println(":::::::::::::dddddddddd::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PROCEDURE "+sif.getHead_tip());






sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
sb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");
sb.append("<jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");
 
 
sb.append("<////%\r\n");
sb.append("if ((nul.jeNull(request.getHeader(\"referer\"))).startsWith(\"http://\"+ConPool.getRemote_address()) || (nul.jeNull(request.getHeader(\"referer\"))).startsWith(\"https://\"+ConPool.getRemote_address())) {\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("%////><jsp////:forward page=\"logout.jsp\"/><////%");
sb.append("}\r\n");
sb.append("request.setCharacterEncoding(control.encoding);\r\n");
sb.append("response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("response.addDateHeader(\"Expires\", 0);\r\n");
sb.append("if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
sb.append("%////><jsp:forward page=\"logout.jsp\"/><////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");
 
sb.append("<////%\r\n");
sb.append("org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");
sb.append("//boolean jeok = true;\r\n");
sb.append("String err = \"\";\r\n");
sb.append("String rezu = \"\";\r\n");
sb.append("String odg_funkcija = \"\";\r\n");
sb.append("boolean delaa = false;\r\n");
sb.append("boolean sovrstice = false;\r\n");
sb.append("boolean mum=false;\r\n");
sb.append("try {\r\n");
	//sb.append("if (prisotnost.istiUserKontrola(control.idUporabnikaLock,nul.jeNull(request.getParameter(\"id\"))) ||  !prisotnost.users.containsKey(nul.jeNull(request.getParameter(\"id\")))) {\r\n");
	sb.append("if ( !prisotnost.users.containsKey(nul.jeNull(request.getParameter(\"id\"))) || prisotnost.istiUserKontrola(control.idUporabnikaLock,nul.jeNull(request.getParameter(\"id\")))) {\r\n");







com.popultrade.model.TemplateClass dgum =new com.popultrade.model.TemplateClass();
com.popultrade.dao.TemplateClassDAO tgum = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

	
dgum = tgum.getTemplateClassDodatnos(sif.getVeza_gumb()+"");


if (dgum!=null && dgum.getDodaten_hql_pogoj()!=null && !dgum.getDodaten_hql_pogoj().trim().equals("")) {
	sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n");
sb.append("\r\ncom.popultrade.model."+imefile+" vsebkont =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO daokont = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");

sb.append("vsebkont = daokont.get"+imefile+"(new Long(request.getParameter(\"id\")));\r\n");

sb.append("if (vsebkont!=null && vsebkont.getId()!=null) {\r\n");

sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("getTime", "geetTime").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("geetTime", "getTime").replaceAll("control.geet", "control.get")+") {\r\n");

sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("err=\"Napaka: dokument je bil ze poslan!\";\r\n");
sb.append("rezu=\"NIOK\";\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
}






////kreiram funkcije, ki se uporabi za kontrole

if (sif.getTemplateFunkcijaStarts()!=null && sif.getTemplateFunkcijaStarts().size()>0) {


Iterator itmn = sif.getTemplateFunkcijaStarts().iterator();

while (itmn.hasNext()) {
com.popultrade.model.TemplateFunkcijaStart tfs = (com.popultrade.model.TemplateFunkcijaStart)itmn.next();


if (!nul.jeNull(tfs.getPredpogoj()).equals("")) {
	sb.append(tfs.getPredpogoj().replaceAll("'","\"")+"\r\n");
}
		
		
sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),tfs.getId()+""));
if (!nul.jeNull(tfs.getPredpogoj()).equals("")) {
sb.append("}\r\n");
}

}

sb.append("err = odg_funkcija;\r\n");
}










sb.append("if (rezu!=null && !rezu.equals(\"NIOK\")) {\r\n");
	

if (nul.jeNull(sif.getProcedura_podatki_checkbox()).equals("1")) {


sb.append("Hashtable vseh = new Hashtable();\r\n");

sb.append("Enumeration<String> enm=request.getParameterNames();\r\n");
sb.append("while(enm.hasMoreElements())\r\n");
sb.append("{\r\n");
sb.append("String nek = (String)enm.nextElement();\r\n");
sb.append("if (nek.indexOf(\""+sif.getProcedura_zacetno_ime_cb()+"___\")!=-1) {\r\n");
sb.append("vseh.put(nek, \"\");\r\n");
sb.append("}\r\n"); 
        
sb.append("}\r\n");
    
    
sb.append("ArrayList alk = new ArrayList(vseh.keySet()); \r\n");
   
sb.append("Collections.sort(alk); \r\n");


sb.append("for (int m=0;m<alk.size();m++) {\r\n");

sb.append("String "+sif.getProcedura_ime_neznanke()+" = request.getParameter((String)alk.get(m));\r\n");
sb.append("if (true) {\r\n");
		


/*
sb.append("Enumeration enn = request.getParameterNames();\r\n");

sb.append("while (enn.hasMoreElements()) {\r\n");
	
sb.append("String nek = (String)enn.nextElement();\r\n");
	
sb.append("if (nek.indexOf(\""+sif.getProcedura_zacetno_ime_cb()+"___\")!=-1) {\r\n");
		
sb.append("String "+sif.getProcedura_ime_neznanke()+" = request.getParameter(nek);\r\n");
		*/
	
}


com.popultrade.dao.TemplateUiDodatnoDAO daouid2 = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());



com.popultrade.model.TemplateUiDodatno tuidd2 = new com.popultrade.model.TemplateUiDodatno();


tuidd2 = daouid2.getTemplateUiDodatnos(idpr);


if (!nul.jeNull(tuidd2.getDodatno_java_rocno()).equals("")) {

sb.append(tuidd2.getDodatno_java_rocno()+"\r\n");

}



sb.append("com.popultrade.model."+imefile+" vseb =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO dao = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length())+"DAO\",pageContext.getServletContext());\r\n");
	

/// 
//st vprasanj





String vpr = "";


for (int h=0;h<sif.getTemplateClasss().size();h++) {
	
	vpr = vpr + "?,";
}

if (vpr.endsWith(",")) {
	vpr = vpr.substring(0,vpr.length()-1);
}

	
//sb.append("org.hibernate.Query  cs = dao.getSessionProcedura().createSQLQuery( \""+sif.getZacetek_procedure()+vpr+sif.getKonec_procedure()+"\" );\r\n");
	


Iterator ito = sif.getTemplateClasss().iterator();
int zom = 1;

StringBuffer sbbb = new StringBuffer();
while (ito.hasNext()) {
	com.popultrade.model.TemplateClass tcl = (com.popultrade.model.TemplateClass)ito.next();
	
	String pred = "";
	if (tcl.getVrsta_pogoja().equals("Int")) {
		pred = "final int para"+zom+" =  Integer.parseInt(";
	}
	else if (tcl.getVrsta_pogoja().equals("Long")) {
		pred = "final Long para"+zom+" = new Long(";
	}
	else if (tcl.getVrsta_pogoja().equals("Double")) {
		pred = "final double para"+zom+" = Double.parseDouble(";
	}
	else  {
		pred = "final String para"+zom+" = new String(";
	}
	
	//sb.append("cs.setParameter(\"h"+zom+"\","+pred+tcl.getVrednost_pogoja().replaceAll("\'","\"")+(pred.equals("")?"":"+\"\")")+");\r\n");
	sb.append(pred+tcl.getVrednost_pogoja().replaceAll("\'","\"")+(pred.equals("")?"":"+\"\")")+";\r\n");
	sbbb.append(pred+tcl.getVrednost_pogoja().replaceAll("\'","\"")+(pred.equals("")?"":"+\"\")")+";\r\n");
	zom++;
}

if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql(null, ConPool, null, \""+sif.getZacetek_procedure()+vpr+sif.getKonec_procedure()+" :: "+sbbb.toString()+"\", control, \"SQL procedure "+imefile+"\");");
}

sb.append("dao.getSessionProcedura().doWork(new org.hibernate.jdbc.Work() {\r\n");
sb.append("public void execute(Connection connection) throws SQLException {\r\n");
sb.append("CallableStatement cs = connection.prepareCall(\""+sif.getZacetek_procedure()+vpr+sif.getKonec_procedure()+"\");\r\n");

 ito = sif.getTemplateClasss().iterator();
 zom = 1;
while (ito.hasNext()) {
	com.popultrade.model.TemplateClass tcl = (com.popultrade.model.TemplateClass)ito.next();
	
	String pred = "";
	if (tcl.getVrsta_pogoja().equals("Int")) {
		pred = "Integer.parseInt(";
	}
	else if (tcl.getVrsta_pogoja().equals("Long")) {
		pred = "new Long(";
	}
	else if (tcl.getVrsta_pogoja().equals("Double")) {
		pred = "Double.parseDouble(";
	}
	//sb.append("cs.setParameter(\"h"+zom+"\","+pred+tcl.getVrednost_pogoja().replaceAll("\'","\"")+(pred.equals("")?"":"+\"\")")+");\r\n");
	sb.append("cs.set"+tcl.getVrsta_pogoja()+"("+zom+",para"+zom+");\r\n");
	
	zom++;
}


sb.append("cs.execute();\r\n");
sb.append("cs.close();\r\n");


sb.append("}\r\n");
sb.append("});\r\n");


if (nul.jeNull(sif.getProcedura_podatki_checkbox()).equals("1")) {
sb.append("}\r\n");
sb.append("}\r\n");
}

	
sb.append("err=ConPool.getPrevod(\""+idpr+"Z\"+control.getJezik());\r\n");	
sb.append("}\r\n");
	sb.append("}\r\n");
	sb.append("////else {\r\n");
	sb.append("delaa=true;\r\n");
sb.append("%////>\r\n");
sb.append("<html><head><title>spreminjaj</title></head>\r\n");

sb.append("<style type=text/css>\r\n");
sb.append("@import \"barveold.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"ccss/custom.css\";\r\n");

////grafika oz barve
if (sif.getTarget_search_rocno()!=null && !sif.getTarget_search_rocno().equals("")) {
sb.append("@import \"css_dat/"+sif.getTarget_search_rocno()+"\";\r\n");	
}
else {
	
sb.append("@import \"sbuttoni.css\";\r\n");	
}

if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
sb.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
}
else {

sb.append("@import \"barveblue.css\";\r\n");	
}

sb.append("</style>\r\n");
sb.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
sb.append("<p align=\"center\">Sprememba podatkov ni dovoljena, drugi uporabnik trenutno spreminja te iste podatke.</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");


	
sb.append("}\r\n");
sb.append("catch (Exception ex){\r\n");
sb.append("//jeok=false;\r\n");
sb.append("log.error(ex.toString());\r\n");
sb.append("err = ConPool.getPrevod(\""+idpr+"Y\"+control.getJezik())+ \" \"+ex.toString();\r\n");
sb.append("}\r\n");

sb.append("if (!delaa) {\r\n");


sb.append("%////>\r\n");
sb.append("<html><head><title>spreminjaj</title></head>\r\n");
 
sb.append("<style type=text/css> \r\n");
sb.append("@import \"barveold.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"ccss/custom.css\";\r\n");
sb.append("@import \"js/uijs2/jquery-ui.css\";\r\n");
////grafika oz barve

if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
sb.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
}
else {

sb.append("@import \"barveblue.css\";\r\n");	
}

sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<body    "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"   >\r\n");
sb.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
sb.append("<p align=\"center\">\r\n");

sb.append("<////%=err%////>\r\n");

sb.append("</p>\r\n");

sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("</body>\r\n");
sb.append("<script language=\"javascript\">\r\n");

sb.append("function mom() {\r\n");



if (!nul.jeNull(sif.getTarget_funkcija()).equals("") && !nul.jeNull(sif.getTarget_funkcija_url()+"").equals("")) {

	   com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
com.popultrade.model.TemplateHead thed = daoth.getTemplateHead(sif.getTarget_funkcija_url());
	

String predpo = "";
if (thed.getHead_tip().equals("SE")) {
	predpo="_isci"+thed.getId();
}
else if (thed.getHead_tip().equals("UI")) {
	predpo="_edit"+thed.getId();
}
else if (thed.getHead_tip().equals("HT")) {
	predpo="_edit"+thed.getId();
}
else if (thed.getHead_tip().equals("HE")) {
	predpo="_view"+thed.getId();
}
else if (thed.getHead_tip().equals("FU")) {
		predpo="_funk"+thed.getId();
	}

else if (thed.getHead_tip().equals("PR")) {
	predpo="_proc"+thed.getId();
}
else if (thed.getHead_tip().equals("PD")) {
	predpo="_pdf"+thed.getId();
}
else if (thed.getHead_tip().equals("LI")) {
	predpo="_list"+thed.getId();
}
else if (thed.getHead_tip().equals("LT")) {
	predpo="_list"+thed.getId();
}
else if (thed.getHead_tip().equals("OB")) {
	predpo="_ob"+thed.getId();
}
else if (thed.getHead_tip().equals("EX")) {
	predpo="_exp"+thed.getId();
}
else if (thed.getHead_tip().equals("EE")) {
	predpo="_expe"+thed.getId();
}
else if (thed.getHead_tip().equals("UP")) {
	predpo="_upload"+thed.getId()+"_1";
}
else if (thed.getHead_tip().equals("UR")) {
	predpo="_ur1"+thed.getId()+"";
}
sb.append(sif.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp?<////%=nul.jeNull(request.getQueryString())%////>';\r\n");
}
else if (!nul.jeNull(sif.getTarget_funkcija()).equals("")) {
	sb.append(sif.getTarget_funkcija()+"="+sif.getTarget_funkcija()+";\r\n");
}
//sb.append("top.resetPageBlockAll();\r\n");

sb.append("resetLoadingOverlay();\r\n");


//sb.append("top.window.hideFrame();\r\n");
sb.append("}\r\n");



if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}

String refc = "500";
if (!nul.jeNull(sif.getUporabi_cas_refresh_n()).equals("")) {
	refc = sif.getUporabi_cas_refresh_n()+"000";
}


sb.append(" setTimeout('mom()', "+refc+"); \r\n");
sb.append("</script>\r\n");

sb.append("<%////\r\n");
sb.append("}\r\n");


sb.append("%////>\r\n");
/// dobim metode return type
Hashtable meto = templateUtil.getClassMetodeImenaHTGet(imefile);
////////// predhoden page


///// kreiram predhoden page, ce je
if (sif.getTemplatePPs()!=null && sif.getTemplatePPs().size()>0) {
	 
StringBuffer pp = new StringBuffer();
	
	pp.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
	pp.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
	pp.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
	pp.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
	pp.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
	pp.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");


	pp.append("<////%\r\n");
	pp.append("////request.setCharacterEncoding(control.encoding);\r\n");
	pp.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
	pp.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
	pp.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
	pp.append("////response.addDateHeader(\"Expires\", 0);\r\n");
	pp.append("////if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
	pp.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
	pp.append("////}\r\n");
	pp.append("%////>\r\n");

	pp.append("<////%\r\n");
	pp.append("////try {\r\n");
	pp.append("String rezu=\"\";\r\n");
	
	
	pp.append("Hashtable ht =new Hashtable();\r\n");
	//sb.append("//ht.put(\"id\",\"id\");\r\n");
	pp.append("Hashtable htn =new Hashtable();\r\n");
	com.popultrade.dao.TemplatePPDAO daopp = (com.popultrade.dao.TemplatePPDAO)contextUtil.getBeanDao("templatePPDAO",pageContext.getServletContext());


	com.popultrade.model.TemplatePP tpp = new com.popultrade.model.TemplatePP();

	tpp.setTemplatehead_id(sif.getId());


	List liko = daopp.getTemplatePPs(tpp);
	
	boolean jenum = false;
	boolean jestr = false;
		if (liko.size()>0) {
			Iterator termo = liko.iterator();

			
			while (termo.hasNext()) {
				com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)termo.next();
				
				/// dodaj kontrolo
				if (nul.jeNull(tu.getKontrola_javascript()).equals("DA")) {
					
					/// vrsta kontrole, numeric ali string ali datum
					
					if (meto.containsKey(tu.getStolpec_metoda())) {
						
						if (meto.get(tu.getStolpec_metoda()).toString().indexOf("int")!=-1 ||meto.get(tu.getStolpec_metoda()).toString().indexOf("Integer")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Long")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Double")!=-1) {
							pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
							
							pp.append("htn.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
							jenum = true;
						}
						else {
							pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
							jestr = true;	
						}
						
						
					}
					else {
						pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
						jestr = true;
					}
					
					
				}
				
				
			}
			}
	
	

	
	
	pp.append("%////>\r\n");

	pp.append("<html><head><title>spreminjaj</title></head>\r\n");

	pp.append("<style type=text/css>\r\n");
	pp.append("@import \"barveold.css\";\r\n");
	pp.append("@import \"tooltipcss.css\";\r\n");
	pp.append("@import \"ccss/custom.css\";\r\n");
	pp.append("@import \"js/uijs2/jquery-ui.css\";\r\n");

	if (sif.getTarget_search_rocno()!=null && !sif.getTarget_search_rocno().equals("")) {
	pp.append("@import \"css_dat/"+sif.getTarget_search_rocno()+"\";\r\n");	
	}
	else {
		
	pp.append("@import \"sbuttoni.css\";\r\n");	
	}
	////grafika oz barve

	if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
	pp.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
	}
	else {

	pp.append("@import \"barveblue.css\";\r\n");	
	}


	if (!nul.jeNull(tuidd.getDodatno_css()).equals("")) {
		
		pp.append(tuidd.getDodatno_css()+"\r\n");
		
	}
	pp.append("</style>\r\n");
	pp.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");


	if (jestr || jenum) {
		pp.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
		}
		if (jenum) {
		pp.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
		}
	//	pp.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
	//	pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
	
//	pp.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
	
pp.append("<link rel=\"stylesheet\" href=\"js/uijs2/jquery-ui.css\">\r\n");



pp.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	//pp.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown
	pp.append("<script src=\"scripts/jquery-migrate-3.0.0.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown

	pp.append("<script language='javascript'  src=\"js/uijs2/jquery-ui.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");


	
	pp.append("<body    "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"   onload=\"mom()\">\r\n");
	/*
	
pp.append("<table  width=\"100%\" id=\"table1\" height=\"100%\"   border=\"0\" cellspacing=\"1\"  class=\"fonti\"  bgcolor=#C3E1FC	>\r\n");
pp.append("<tr>\r\n");
pp.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");*/
pp.append("<table width=\"100%\" id=\"table2\" height=\"100%\"  border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td class=\"opiscell\" align=\"center\">\r\n");
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_proc"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td class=\"valuecell\" colspan=\"2\">\r\n");






pp.append("&nbsp;</td>\r\n");
pp.append("</tr>\r\n");



StringBuffer sbuu = new StringBuffer();
boolean jenekaj = false;
if (liko.size()>0) {
jenekaj = true;

Iterator ipp = liko.iterator();

while (ipp.hasNext()) {
	com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)ipp.next();
	
	
	//pp.append(genFieldPredhodenPage(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));
	
    pp.append(createPP(tu,"templatepp")+"\r\n");
	
	 if (nul.jeNull(tu.getTip_inserta()).equals("hidden")) {
		

		

		 pp.append("<input type=\"hidden\" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   value=\"<////%="+nul.jeNull(tu.getStolpec_metoda()).replaceAll("\'","\"")+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n");
		}
	
	 else {
	
pp.append("<tr>\r\n");
pp.append("<td class=\"valuecell\" align=\"right\">\r\n");


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII155");


pp.append("<p align=\"center\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td align=\"left\"  class=\"valuecell\" >\r\n");



String max = nul.jeNull(tu.getStolpec_max_stevilo_znakov());
String dol = nul.jeNull(tu.getStolpec_sirina());
String tabi = nul.jeNull(tu.getTab_index());



if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {
	
	/// kontrola in generacija AJAX
	   	String ime_field="";
        
        		
        		ime_field = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
        		
        	
	String[] ajaxpoljea = getAjaxPP(tu,contextUtil,pageContext.getServletContext(),ime_field);
	//String[] ajaxpoljea = getAjax(tu,contextUtil,servletContext,ime_field);
	  
	
	String ajaxpolje = ajaxpoljea[0];
	  
		boolean novajax=false;
		if (ajaxpolje.indexOf(" ")!=-1) {
		novajax=true;
		
		
		}
	
	Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(sif.getHead_class_name());
	if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
		pp.append("<input type=\"text\"    "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"    "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"     onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  > <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"\" ><img src='call.gif' border='0'></a> \r\n");
		}
		else {
pp.append("<input type=\"text\" "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"  "+(!ajaxpolje.equals("")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  "+(novajax?"":ajaxpolje)+">\r\n");
}
	
	
	/// cosmico2

	pp.append(getAjaxNoviJS(tu,ajaxpoljea,"TemplatePP"));

	
	
	
}
else if (nul.jeNull(tu.getTip_inserta()).equals("password")) {
	/// nujno dodati v insert pogoje

	pp.append("<input type=\"password\" "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\">\r\n");
}
else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
	/// nujno dodati v insert pogoje

	pp.append("<input type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" >\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
	/// nujno dodati v insert pogoje
	String cols = nul.jeNull(tu.getCols());
	String rows = nul.jeNull(tu.getRows());
	
	pp.append("<textarea "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=rezu%////></textarea>\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
		
		
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII156");
		pp.append("<select "+((nul.jeN(tu.getKontrola_javascript()).equals("DA") )?"required  onchange=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" class=\"inputIEx\" >\r\n");
		pp.append("<option></option>\r\n");
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII157");
	/// kontrola hintov, ce ima dodam opcije
	if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getClass_name()!=null) {
		
		String clna = tu.getTemplateClassClass().getClass_name();
		pp.append("<////%\r\n");
		String dodaten = "";
		if (tu.getTemplateClassClass().getTemplateClasss().size()>0) {

			Iterator tre = tu.getTemplateClassClass().getTemplateClasss().iterator();
			while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
			if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				
				dodaten =  dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
				}
			}
			else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
			}
			}
			/// dodaten pogoj da sploh gleda po bazi
			
			
			
		}
		pp.append("if (true "+dodaten+") {\r\n");
		pp.append("com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n");

		pp.append("com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n");

		
		//// vrednosti
		
		Iterator ikov = tu.getTemplateClassClass().getTemplateClasss().iterator();
		 meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),clna);
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII158 " + tcc.getVrednost_pogoja());
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1587 " + tcc.getIme_pogoja());
	String rett=tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("\'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\"";
	
	
	if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
		
		
		
		rett = "new Long("+rett+")";
		
		
		
	}
	else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("int")!=-1 || ((String)meto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1) {
		rett = "Integer.parseInt("+rett+")";
		
	}
	else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
	
		rett = "Double.parseDouble("+rett+")";
	}
	
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1589 " + tcc.getVrednost_pogoja());
		
		if (!nul.jeNull(tcc.getDodaten_hql_pogoj()).equals("")) {
			pp.append(nul.jeNull(tcc.getDodaten_hql_pogoj())+"\r\n");
		}
		pp.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n");
		if (!nul.jeNull(tcc.getDodaten_hql_pogoj()).equals("")) {
			pp.append("}\r\n");
		}
		
		}
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII159");
		
		String sifra="";
		String vrednost="";
		/// dobim vrednosti za sifro in vrednost hinta
			 ikov = tu.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
		
		/*while (ikov.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
		
		if (nul.jeNull(tcc.getTip()).equals("sifra")) {
			sifra = nul.jeNull(tcc.getVrednost());
		}
		if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
			vrednost = vrednost + "<////%=nul.jeNull(modi"+clna+"."+nul.jeNull(tcc.getVrednost())+"())%////> ";
			
		}
		}*/
		
		
		
		
		int prvxx = 0;
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
		
		if (nul.jeNull(tcc.getTip()).equals("sifra")) {
			sifra = nul.jeNull(tcc.getVrednost());
		}
		if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
			vrednost =  vrednost +(prvxx==1?" - ":"") + "<////%=nul.jeNull(modi"+clna+"."+nul.jeNull(tcc.getVrednost())+"())%////> ";
			prvxx++;
		}
		}
		
		
		
		
		
		
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII160");
		if (!sifra.equals("") && !vrednost.equals("")) {
		
			
			String sorder = nul.jeNull(tu.getTemplateClassClass().getHead_select_dodatni_pogoji());
  			String sorders = nul.jeNull(tu.getTemplateClassClass().getOrder_by_smer());
  			String dodpog = nul.jeNull(tu.getTemplateClassClass().getDodatni_hql_pogoji());
  			
  		
  	//	premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n";
							pp.append("String dod_hql=\"\";\r\n");
          			
							
			          		if (!dodpog.trim().equals("")) {
							pp.append(" dod_hql=\""+dodpog+"\";\r\n");
			          		}
          					
          					
          					
          		
          				pp.append("List li"+clna+" = dao"+clna+".get"+clna+"s2(mod"+clna+",\""+sorder+"\",\""+sorders+"\",dod_hql);\r\n");
        		
			
			
		//	pp.append("List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n");
		
		pp.append("Iterator i"+clna+"=li"+clna+".iterator();\r\n");
		

		
		pp.append("while (i"+clna+".hasNext()) {\r\n");
		pp.append("com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n");

		
		pp.append("%////>\r\n");
		
		pp.append("<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"()+\"\")%////>\" >"+vrednost+"</option>;\r\n");
		
		//pp.append("p"+tu.getId()+"<////%=modi"+clna+"."+sifra+"()%////>=\"<////%=modi"+clna+"."+vrednost+"()%////>\";\r\n";

		pp.append("<////%\r\n\r\n");
		pp.append("}\r\n\r\n");
		
		}
		
		pp.append("}\r\n");
		pp.append("%////>\r\n");
		
		
	}
		
		
	
		
	pp.append("</select>\r\n");
		
		
		
	}


pp.append("</td>\r\n");
pp.append("</tr>\r\n");
}
}


}



pp.append("<tr>\r\n");
pp.append("<td colspan=\"2\" class=\"valuecell\" align=\"center\">\r\n");

if (sbuu!=null && !sbuu.toString().equals("")) {
	pp.append(sbuu.toString());
}



pp.append("<input TYPE=\"submit\" VALUE=\"< %=ConPool.getPrevod(\""+sif.getId()+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"   class=\"fontisubmit\" >&nbsp;</td>\r\n");
pp.append("</tr>\r\n");

/// dodam parametre iz gumba
//// dam parametre, ki posljem preko requesta
 if (tgumb.getTemplateGumbiParametris()!=null && tgumb.getTemplateGumbiParametris().size()>0) {
	 
	 
	 Iterator iko = tgumb.getTemplateGumbiParametris().iterator();
	 
	 
	 while (iko.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)iko.next();
		 
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("getParameter")!=-1) {
			 pp.append("<input type=hidden name=\""+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","\"")+")%////>\">\r\n");
		 }
		 
		 else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
		 pp.append("<input type=hidden name=\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\"))%////>\">\r\n");
		 }
	 }
	 
	 
	 
 }



pp.append("</form></table>\r\n");
pp.append("<font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");
/*pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");*/
	
	
	
	
	
	
	
	
	
	
	
	pp.append("</body>\r\n");
	
	
	pp.append("<script language=\"javascript\">\r\n");
	
	
	pp.append("\r\nfunction mom() {\r\n");
	if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
		
		Iterator rese = sif.getTemplateHeadResets().iterator();
		
		while (rese.hasNext()) {
			com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
			
			
			pp.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
			
			
		}
		
		
		
	}
	
	
	pp.append("\r\n"+nul.jeNull(tuidd.getDodatno_javascript_onload())+"\r\n");
	
	//pp.append("top.resetPageBlockAll();\r\n");
	
	pp.append("resetLoadingOverlay();\r\n");

	
	pp.append("}\r\n");
	
	pp.append("\r\nfunction custom() {\r\n");

//	if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_javascript()!=null) {
	//	pp.append(sif.getTemplateUiDodatno().getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
//	}

	pp.append("return true;\r\n");
	pp.append("}\r\n");
	pp.append("</script>\r\n");
	
	pp.append("<////%\r\n");


	pp.append("////}\r\n");
	pp.append("////catch (Exception ex){\r\n");
	pp.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

	pp.append("////log.error(ex.toString());\r\n");
	pp.append("////}\r\n");
	pp.append("%////>\r\n");
	
	/// shranim

	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_proc"+sif.getId()+"_p"+".jsp"), "latin1"));



	out3.write(pp.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
}









imefile = imefile+"_proc"+sif.getId();





















}

////kreacija jsp za funkcijo
/////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
////////////////











/////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
////////////////
//// kreacija jsp za funkcijo

if (sif.getHead_tip().equals("FU")) {



com.popultrade.dao.TemplateFunkcijaStartDAO daoui = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",pageContext.getServletContext());

/////// dobim dodatne opcije
com.popultrade.dao.TemplateUiDodatnoDAO daouid2 = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());



com.popultrade.model.TemplateUiDodatno tuidd2 = new com.popultrade.model.TemplateUiDodatno();


tuidd2 = daouid2.getTemplateUiDodatnos(idpr);

sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");
sb.append("<////jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");
if (tuidd2!=null && tuidd2.getDodatno_html()!=null && !tuidd2.getDodatno_html().trim().equals("") ) {
	
	sb.append("<////%!\r\n");
	
	sb.append(tuidd2.getDodatno_html()+"\r\n");
	
	sb.append("%////>\r\n");
}

sb.append("<////%\r\n");
sb.append("if ((nul.jeNull(request.getHeader(\"referer\"))).startsWith(\"http://\"+ConPool.getRemote_address()) || (nul.jeNull(request.getHeader(\"referer\"))).startsWith(\"https://\"+ConPool.getRemote_address())) {\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("%////><jsp////:forward page=\"logout.jsp\"/><////%");
sb.append("}\r\n");
sb.append("////request.setCharacterEncoding(control.encoding);\r\n");
sb.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("////response.addDateHeader(\"Expires\", 0);\r\n");
sb.append("////if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
sb.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");
sb.append("////try {\r\n");
sb.append("String rezu=\"\";\r\n");
sb.append("String odg_funkcija=\"\";\r\n");
		sb.append("if ( !prisotnost.users.containsKey(nul.jeNull(request.getParameter(\"id\"))) || prisotnost.istiUserKontrola(control.idUporabnikaLock,nul.jeNull(request.getParameter(\"id\")))) {\r\n");

sb.append("%////>\r\n");

sb.append("<html><head><title>spreminjaj</title></head>\r\n");

sb.append("<style type=text/css>\r\n");
sb.append("@import \"barveold.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"ccss/custom.css\";\r\n");
sb.append("@import \"js/uijs2/jquery-ui.css\";\r\n");
if (sif.getTarget_search_rocno()!=null && !sif.getTarget_search_rocno().equals("")) {
sb.append("@import \"css_dat/"+sif.getTarget_search_rocno()+"\";\r\n");	
}
else {
	
sb.append("@import \"sbuttoni.css\";\r\n");	
}

////grafika oz barve

if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
sb.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
}
else {

sb.append("@import \"barveblue.css\";\r\n");	
}
if (!nul.jeNull(tuidd.getDodatno_css()).equals("")) {
	
	sb.append(tuidd.getDodatno_css()+"\r\n");
	
}
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");



//sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"scripts/epoch_styles.css\">\r\n");
//sb.append("<script type=\"text/javascript\" src=\"scripts/epoch_classes.js\"></script>\r\n");


//sb.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
//sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
//sb.append("<link rel=\"stylesheet\" href=\"js/uijs2/jquery-ui.css\">\r\n");

//sb.append("<script language='javascript'  src=\"js/uijs2/jquery-ui.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");

sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/jquery-migrate.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");

//sb.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
sb.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<body    "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"   onload=\"mom()\">\r\n");



if (tuidd2!=null && tuidd2.getDodatno_java()!=null && !tuidd2.getDodatno_java().trim().equals("") ) {
	
	sb.append("<////%\r\n");
	
	sb.append(tuidd2.getDodatno_java()+"\r\n");
	
	sb.append("%////>\r\n");
}



if (tuidd2!=null && tuidd2.getDodatno_java_rocno()!=null && !tuidd2.getDodatno_java_rocno().trim().equals("") ) {
	
	sb.append("<////%\r\n");
	
	sb.append(tuidd2.getDodatno_java_rocno()+"\r\n");
	
	if (tuidd2!=null && tuidd2.getDodatno_java_rocno2()!=null && !tuidd2.getDodatno_java_rocno2().trim().equals("") ) {
		
	
		sb.append(tuidd2.getDodatno_java_rocno2()+"\r\n");
		
		
	}
	sb.append("%////>\r\n");
}


sb.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
sb.append("<p align=\"center\">\r\n");


sb.append("<////%\r\n");
sb.append("boolean lahkoklice=true;\r\n");

com.popultrade.model.TemplateClass dgum =new com.popultrade.model.TemplateClass();
com.popultrade.dao.TemplateClassDAO tgum = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

	
dgum = tgum.getTemplateClassDodatnos(sif.getVeza_gumb()+"");


if (dgum!=null && dgum.getDodaten_hql_pogoj()!=null && !dgum.getDodaten_hql_pogoj().trim().equals("")) {
	sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n\r\n");
sb.append("com.popultrade.model."+imefile+" vsebkont =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO daokont = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");

sb.append("vsebkont = daokont.get"+imefile+"(new Long(request.getParameter(\"id\")));\r\n");

sb.append("if (vsebkont!=null && vsebkont.getId()!=null) {\r\n");

//sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("control.geet", "control.get")+") {\r\n");
sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("getTime", "geetTime").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("geetTime", "getTime").replaceAll("control.geet", "control.get")+") {\r\n");

sb.append("}\r\n");
sb.append("else {\r\n");
sb.append(" lahkoklice=false;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("}\r\n");

}

sb.append("if( lahkoklice) {\r\n");

com.popultrade.model.TemplateFunkcijaStart tui = new com.popultrade.model.TemplateFunkcijaStart();

List tempui = daoui.getTemplateFunkcijaStartByVezaId(idpr);


/// dobim metode return type
Hashtable meto = templateUtil.getClassMetodeImenaHTGet(imefile);
///// dobim inserte, za checkbox, ce ne ne dela avtomaticno in datume

String dodaj_ins="";
String dodaj_upd="";

String dodaj_datum="";




 /// funkcija start
 
 
if (tempui.size()>0) {
	
	
	Iterator enr = tempui.iterator();
	
	while (enr.hasNext()) {
	
tui = 	(com.popultrade.model.TemplateFunkcijaStart)enr.next();


				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),tui.getId()+""));
			//	sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+"rezu"+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
	}
}
 
 



if (!nul.jeNull(tuidd2.getDodatno_java_updateinsert()).trim().equals("")) {
	sb.append("\r\n\r\n"+tuidd2.getDodatno_java_updateinsert()+"\r\n");
}
if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql(null, ConPool, null, null, control, \"function "+imefile+"\");");
}
sb.append("}\r\n");
sb.append("%////>\r\n");
sb.append("<////%=odg_funkcija%////>");




if (!nul.jeNull(tuidd2.getDodatno_html2()).trim().equals("")) {
	sb.append("\r\n\r\n"+tuidd2.getDodatno_html2()+"\r\n");
}


sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");

sb.append("<script language=javascript>\r\n");
sb.append("function mom() {\r\n");

if (!nul.jeNull(sif.getTarget_funkcija()).equals("") && !nul.jeNull(sif.getTarget_funkcija_url()+"").equals("")) {

	   com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
com.popultrade.model.TemplateHead thed = daoth.getTemplateHead(sif.getTarget_funkcija_url());
	

String predpo = "";
if (thed.getHead_tip().equals("SE")) {
	predpo="_isci"+thed.getId();
}
else if (thed.getHead_tip().equals("UI")) {
	predpo="_edit"+thed.getId();
}
else if (thed.getHead_tip().equals("HT")) {
	predpo="_edit"+thed.getId();
}
else if (thed.getHead_tip().equals("HE")) {
	predpo="_view"+thed.getId();
}
else if (thed.getHead_tip().equals("FU")) {
		predpo="_funk"+thed.getId();
	}
else if (thed.getHead_tip().equals("PR")) {
	predpo="_proc"+thed.getId();
}
else if (thed.getHead_tip().equals("PD")) {
	predpo="_pdf"+thed.getId();
}
else if (thed.getHead_tip().equals("LI")) {
	predpo="_list"+thed.getId();
}
else if (thed.getHead_tip().equals("LT")) {
	predpo="_list"+thed.getId();
}
else if (thed.getHead_tip().equals("OB")) {
	predpo="_ob"+thed.getId();
}
else if (thed.getHead_tip().equals("EX")) {
	predpo="_exp"+thed.getId();
}
else if (thed.getHead_tip().equals("EE")) {
	predpo="_expe"+thed.getId();
}
else if (thed.getHead_tip().equals("UP")) {
	predpo="_upload"+thed.getId()+"_1";
}
else if (thed.getHead_tip().equals("UR")) {
	predpo="_ur1"+thed.getId()+"";
}
sb.append(sif.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp?idomko=<////%=nul.jeNull(rezu).trim()%////>&<////%=nul.jeNull(request.getQueryString())%////>';\r\n");

	
	
}
else {
	//sif.getVeza_gumb()
	
	 com.popultrade.model.TemplateGumbi tgumbb = new com.popultrade.model.TemplateGumbi() ;

 if (sif.getVeza_gumb()!=null && !sif.getVeza_gumb().toString().equals("")) {


tgumbb = daotgi.getTemplateGumbi(sif.getVeza_gumb());



///// target gumba
String predpo = "";
String targetv = imefile;
if (!nul.jeNull(sif.getTarget_funkcija()).equals("") && !nul.jeNull(sif.getTarget_funkcija_url()+"").equals("")) {
	 
	 com.popultrade.dao.TemplateHeadDAO daore = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
	 com.popultrade.model.TemplateHead sifre = new com.popultrade.model.TemplateHead();
	 
	 
	 com.popultrade.model.TemplateHead therd = daore.getTemplateHead(tgumbb.getTemplatehead_id());
	
		 targetv = therd.getHead_class_name();
		 
		 if (therd.getHead_tip().equals("SE")) {
		 	predpo="_isci"+therd.getId();
		 }
		 else if (therd.getHead_tip().equals("UI")) {
		 	predpo="_edit"+therd.getId();
		 }
		 else if (therd.getHead_tip().equals("HT")) {
			 	predpo="_edit"+therd.getId();
			 }
		 else if (therd.getHead_tip().equals("HE")) {
		 	predpo="_view"+therd.getId();
		 }
		 else if (therd.getHead_tip().equals("FU")) {
				predpo="_funk"+therd.getId();
			}
		 
		 else if (therd.getHead_tip().equals("PR")) {
				predpo="_proc"+therd.getId();
			}
		 else if (therd.getHead_tip().equals("PD")) {
				predpo="_pdf"+therd.getId();
			}
		 else if (therd.getHead_tip().equals("LI")) {
				predpo="_list"+therd.getId();
			}
		 else if (therd.getHead_tip().equals("LT")) {
				predpo="_list"+therd.getId();
			}
			else if (therd.getHead_tip().equals("OB")) {
				predpo="_ob"+therd.getId();
			}
		 else if (therd.getHead_tip().equals("EX")) {
				predpo="_exp"+therd.getId();
			}
		 else if (therd.getHead_tip().equals("EE")) {
				predpo="_expe"+therd.getId();
			}
		 else if (therd.getHead_tip().equals("UP")) {
				predpo="_upload"+therd.getId()+"_1";
			}
		 else if (therd.getHead_tip().equals("UR")) {
				predpo="_ur1"+therd.getId()+"";
			}
		 if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
			 predpo = predpo + "_p";
		 }
	 
	// System.out.println("---------------------------");
sb.append(sif.getTarget_funkcija()+"='"+nul.jeNull(therd.getHead_class_name()).toLowerCase()+predpo+".jsp?idomko=<////%=nul.jeNull(rezu).trim()%////>&<////%=nul.jeNull(request.getQueryString())%////>';\r\n");

}
 else if (!nul.jeNull(sif.getTarget_funkcija()).equals("")) {
	sb.append(sif.getTarget_funkcija()+"="+sif.getTarget_funkcija()+";\r\n");
}

 }
	
}
//sb.append("top.resetPageBlockAll();\r\n");

sb.append("resetLoadingOverlay();\r\n");



sb.append("}\r\n");

sb.append("</script>\r\n");
sb.append("</body>\r\n");
sb.append("<////%}\r\n");


	sb.append("////else {\r\n");
	//sb.append("delaa=true;\r\n");
sb.append("%////>\r\n");
sb.append("<html><head><title>spreminjaj</title></head>\r\n");

sb.append("<style type=text/css>\r\n");
sb.append("@import \"barveold.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"ccss/custom.css\";\r\n");
sb.append("@import \"js/uijs2/jquery-ui.css\";\r\n");
////grafika oz barve

if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
sb.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
}
else {

sb.append("@import \"barveblue.css\";\r\n");	
}

sb.append("</style>\r\n");
sb.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
sb.append("<p align=\"center\">Sprememba podatkov ni dovoljena, drugi uporabnik trenutno spreminja te iste podatke.</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");

sb.append("////}\r\n");
sb.append("////catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("////log.error(ex.toString());\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");




///// kreiram predhoden page, ce je
if (sif.getTemplatePPs()!=null && sif.getTemplatePPs().size()>0) {
	 
StringBuffer pp = new StringBuffer();
	
	pp.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
	pp.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
	pp.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
	pp.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
	pp.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
	pp.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");


	pp.append("<////%\r\n");
	pp.append("////request.setCharacterEncoding(control.encoding);\r\n");
	pp.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
	pp.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
	pp.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
	pp.append("////response.addDateHeader(\"Expires\", 0);\r\n");
	pp.append("////if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
	pp.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
	pp.append("////}\r\n");
	pp.append("%////>\r\n");

	pp.append("<////%\r\n");
	pp.append("////try {\r\n");
	pp.append("String rezu=\"\";\r\n");
	
	
	pp.append("Hashtable ht =new Hashtable();\r\n");
	//sb.append("//ht.put(\"id\",\"id\");\r\n");
	pp.append("Hashtable htn =new Hashtable();\r\n");
	com.popultrade.dao.TemplatePPDAO daopp = (com.popultrade.dao.TemplatePPDAO)contextUtil.getBeanDao("templatePPDAO",pageContext.getServletContext());


	com.popultrade.model.TemplatePP tpp = new com.popultrade.model.TemplatePP();

	tpp.setTemplatehead_id(sif.getId());


	List liko = daopp.getTemplatePPs(tpp);
	
	boolean jenum = false;
	boolean jestr = false;
		if (liko.size()>0) {
			Iterator termo = liko.iterator();

			
			while (termo.hasNext()) {
				com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)termo.next();
				
				/// dodaj kontrolo
				if (nul.jeNull(tu.getKontrola_javascript()).equals("DA")) {
					
					/// vrsta kontrole, numeric ali string ali datum
					
					if (meto.containsKey(tu.getStolpec_metoda())) {
						
						if (meto.get(tu.getStolpec_metoda()).toString().indexOf("int")!=-1 ||meto.get(tu.getStolpec_metoda()).toString().indexOf("Integer")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Long")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Double")!=-1) {
							pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
							
							pp.append("htn.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
							jenum = true;
						}
						else {
							pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
							jestr = true;	
						}
						
						
					}
					else {
						pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
						jestr = true;
					}
					
					
				}
				
				
			}
			}
	
	

	
	
	pp.append("%////>\r\n");

	pp.append("<html><head><title>spreminjaj</title></head>\r\n");

	pp.append("<style type=text/css>\r\n");
	pp.append("@import \"barveold.css\";\r\n");
	pp.append("@import \"tooltipcss.css\";\r\n");
	pp.append("@import \"ccss/custom.css\";\r\n");
	pp.append("@import \"js/uijs2/jquery-ui.css\";\r\n");

	if (sif.getTarget_search_rocno()!=null && !sif.getTarget_search_rocno().equals("")) {
	pp.append("@import \"css_dat/"+sif.getTarget_search_rocno()+"\";\r\n");	
	}
	else {
		
	pp.append("@import \"sbuttoni.css\";\r\n");	
	}
	////grafika oz barve

	if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
	pp.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
	}
	else {

	pp.append("@import \"barveblue.css\";\r\n");	
	}


	if (!nul.jeNull(tuidd.getDodatno_css()).equals("")) {
		
		pp.append(tuidd.getDodatno_css()+"\r\n");
		
	}
	pp.append("</style>\r\n");
	pp.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");


	if (jestr || jenum) {
		pp.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
		}
		if (jenum) {
		pp.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
		}
	//	pp.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
	//	pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
	
//	pp.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
	
pp.append("<link rel=\"stylesheet\" href=\"js/uijs2/jquery-ui.css\">\r\n");



pp.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	//pp.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown
	pp.append("<script src=\"scripts/jquery-migrate-3.0.0.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown

	pp.append("<script language='javascript'  src=\"js/uijs2/jquery-ui.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");


	
	pp.append("<body    "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"   onload=\"mom()\">\r\n");
	
	/*
pp.append("<table  width=\"100%\" id=\"table1\" height=\"100%\"   border=\"0\" cellspacing=\"1\"  class=\"fonti\"  bgcolor=#C3E1FC	>\r\n");
pp.append("<tr>\r\n");
pp.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");*/
pp.append("<table width=\"100%\" id=\"table2\" height=\"100%\"  border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td class=\"opiscell\" align=\"center\">\r\n");
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_funk"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td class=\"valuecell\" colspan=\"2\">\r\n");






pp.append("&nbsp;</td>\r\n");
pp.append("</tr>\r\n");



StringBuffer sbuu = new StringBuffer();
boolean jenekaj = false;
if (liko.size()>0) {
jenekaj = true;

Iterator ipp = liko.iterator();

while (ipp.hasNext()) {
	com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)ipp.next();
	
	
	//pp.append(genFieldPredhodenPage(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));
	
    pp.append(createPP(tu,"templatepp")+"\r\n");
	
	 if (nul.jeNull(tu.getTip_inserta()).equals("hidden")) {
		

		

		 pp.append("<input type=\"hidden\" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   value=\"<////%="+nul.jeNull(tu.getStolpec_metoda()).replaceAll("\'","\"")+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n");
		}
	
	 else {
	
pp.append("<tr>\r\n");
pp.append("<td class=\"valuecell\" align=\"right\">\r\n");


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII155");


pp.append("<p align=\"center\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td align=\"left\"  class=\"valuecell\" >\r\n");



String max = nul.jeNull(tu.getStolpec_max_stevilo_znakov());
String dol = nul.jeNull(tu.getStolpec_sirina());
String tabi = nul.jeNull(tu.getTab_index());



if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {
	
	/// kontrola in generacija AJAX
	   	String ime_field="";
        
        		
        		ime_field = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
        		
        	
	String[] ajaxpoljea = getAjaxPP(tu,contextUtil,pageContext.getServletContext(),ime_field);
	//String[] ajaxpoljea = getAjax(tu,contextUtil,servletContext,ime_field);
	  
	
	String ajaxpolje = ajaxpoljea[0];
	  
		boolean novajax=false;
		if (ajaxpolje.indexOf(" ")!=-1) {
		novajax=true;
		
		
		}
	
	Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(sif.getHead_class_name());
	if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
		pp.append("<input type=\"text\"    "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"    "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"     onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  > <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"\" ><img src='call.gif' border='0'></a> \r\n");
		}
		else {
pp.append("<input type=\"text\" "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"  "+(!ajaxpolje.equals("")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  "+(novajax?"":ajaxpolje)+">\r\n");
}
	
	
	/// cosmico2

	pp.append(getAjaxNoviJS(tu,ajaxpoljea,"TemplatePP"));

	
	
	
}
else if (nul.jeNull(tu.getTip_inserta()).equals("password")) {
	/// nujno dodati v insert pogoje

	pp.append("<input type=\"password\" "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\">\r\n");
}
else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
	/// nujno dodati v insert pogoje

	pp.append("<input type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" >\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
	/// nujno dodati v insert pogoje
	String cols = nul.jeNull(tu.getCols());
	String rows = nul.jeNull(tu.getRows());
	
	pp.append("<textarea "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=rezu%////></textarea>\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
		
		
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII156");
		pp.append("<select "+((nul.jeN(tu.getKontrola_javascript()).equals("DA") )?"required  onchange=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" class=\"inputIEx\" >\r\n");
		pp.append("<option></option>\r\n");
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII157");
	/// kontrola hintov, ce ima dodam opcije
	if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getClass_name()!=null) {
		
		String clna = tu.getTemplateClassClass().getClass_name();
		pp.append("<////%\r\n");
		String dodaten = "";
		if (tu.getTemplateClassClass().getTemplateClasss().size()>0) {

			Iterator tre = tu.getTemplateClassClass().getTemplateClasss().iterator();
			while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
			if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				
				dodaten =  dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
				}
			}
			else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
			}
			}
			/// dodaten pogoj da sploh gleda po bazi
			
			
			
		}
		pp.append("if (true "+dodaten+") {\r\n");
		pp.append("com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n");

		pp.append("com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n");

		
		//// vrednosti
		
		Iterator ikov = tu.getTemplateClassClass().getTemplateClasss().iterator();
		 meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),clna);
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII158 " + tcc.getVrednost_pogoja());
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1587 " + tcc.getIme_pogoja());
	String rett=tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("\'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\"";
	
	
	if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
		
		
		
		rett = "new Long("+rett+")";
		
		
		
	}
	else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("int")!=-1 || ((String)meto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1) {
		rett = "Integer.parseInt("+rett+")";
		
	}
	else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
	
		rett = "Double.parseDouble("+rett+")";
	}
	
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1589 " + tcc.getVrednost_pogoja());
		
		if (!nul.jeNull(tcc.getDodaten_hql_pogoj()).equals("")) {
			pp.append(nul.jeNull(tcc.getDodaten_hql_pogoj())+"\r\n");
		}
		pp.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n");
		if (!nul.jeNull(tcc.getDodaten_hql_pogoj()).equals("")) {
			pp.append("}\r\n");
		}
		
		}
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII159");
		
		String sifra="";
		String vrednost="";
		/// dobim vrednosti za sifro in vrednost hinta
			 ikov = tu.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
		
		/*while (ikov.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
		
		if (nul.jeNull(tcc.getTip()).equals("sifra")) {
			sifra = nul.jeNull(tcc.getVrednost());
		}
		if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
			vrednost = vrednost + "<////%=nul.jeNull(modi"+clna+"."+nul.jeNull(tcc.getVrednost())+"())%////> ";
			
		}
		}*/
		
		
		
		int prvxx = 0;
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
		
		if (nul.jeNull(tcc.getTip()).equals("sifra")) {
			sifra = nul.jeNull(tcc.getVrednost());
		}
		if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
			vrednost =  vrednost +(prvxx==1?" - ":"") + "<////%=nul.jeNull(modi"+clna+"."+nul.jeNull(tcc.getVrednost())+"())%////> ";
			prvxx++;
		}
		}
		
		
		
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII160");
		if (!sifra.equals("") && !vrednost.equals("")) {
		
			
			String sorder = nul.jeNull(tu.getTemplateClassClass().getHead_select_dodatni_pogoji());
  			String sorders = nul.jeNull(tu.getTemplateClassClass().getOrder_by_smer());
  			String dodpog = nul.jeNull(tu.getTemplateClassClass().getDodatni_hql_pogoji());
  			
  		
  	//	premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n";
							pp.append("String dod_hql=\"\";\r\n");
          			
							
			          		if (!dodpog.trim().equals("")) {
							pp.append(" dod_hql=\""+dodpog+"\";\r\n");
			          		}
          					
          					
          					
          		
          				pp.append("List li"+clna+" = dao"+clna+".get"+clna+"s2(mod"+clna+",\""+sorder+"\",\""+sorders+"\",dod_hql);\r\n");
        		
			
			
		//	pp.append("List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n");
		
		pp.append("Iterator i"+clna+"=li"+clna+".iterator();\r\n");
		

		
		pp.append("while (i"+clna+".hasNext()) {\r\n");
		pp.append("com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n");

		
		pp.append("%////>\r\n");
		
		pp.append("<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"()+\"\")%////>\" >"+vrednost+"</option>;\r\n");
		
		//pp.append("p"+tu.getId()+"<////%=modi"+clna+"."+sifra+"()%////>=\"<////%=modi"+clna+"."+vrednost+"()%////>\";\r\n";

		pp.append("<////%\r\n\r\n");
		pp.append("}\r\n\r\n");
		
		}
		
		pp.append("}\r\n");
		pp.append("%////>\r\n");
		
		
	}
		
		
	
		
	pp.append("</select>\r\n");
		
		
		
	}


pp.append("</td>\r\n");
pp.append("</tr>\r\n");
}
}


}



pp.append("<tr>\r\n");
pp.append("<td colspan=\"2\" class=\"valuecell\" align=\"center\">\r\n");

if (sbuu!=null && !sbuu.toString().equals("")) {
	pp.append(sbuu.toString());
}



pp.append("<input TYPE=\"submit\" VALUE=\"< %=ConPool.getPrevod(\""+sif.getId()+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"   class=\"fontisubmit\" >&nbsp;</td>\r\n");
pp.append("</tr>\r\n");

/// dodam parametre iz gumba
//// dam parametre, ki posljem preko requesta
 if (tgumb.getTemplateGumbiParametris()!=null && tgumb.getTemplateGumbiParametris().size()>0) {
	 
	 
	 Iterator iko = tgumb.getTemplateGumbiParametris().iterator();
	 
	 
	 while (iko.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)iko.next();
		 
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("getParameter")!=-1) {
			 pp.append("<input type=hidden name=\""+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","\"")+")%////>\">\r\n");
		 }
		 
		 else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
		 pp.append("<input type=hidden name=\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\"))%////>\">\r\n");
		 }
	 }
	 
	 
	 
 }



pp.append("</form></table>\r\n");
pp.append("<font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");
/*pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");*/
	
	
	
	
	
	
	
	
	
	
	
	pp.append("</body>\r\n");
	
	
	pp.append("<script language=\"javascript\">\r\n");
	
	
	if (!jenum && !jestr) {
		pp.append("\r\nfunction check() {\r\n");
		if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_javascript()!=null) {
			pp.append(sif.getTemplateUiDodatno().getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
		}
		
		pp.append("}\r\n");
		}
	
	pp.append("\r\nfunction custom() {\r\n");

	if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_javascript()!=null) {
		pp.append(sif.getTemplateUiDodatno().getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
	}

	pp.append("return true;\r\n");
	pp.append("}\r\n");
	
	
	pp.append("\r\nfunction mom() {\r\n");

	
	
	if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_javascript_onload()!=null) {
		pp.append(sif.getTemplateUiDodatno().getDodatno_javascript_onload().replaceAll("\n","\r\n")+"\r\n");
	}

	if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
		
		Iterator rese = sif.getTemplateHeadResets().iterator();
		
		while (rese.hasNext()) {
			com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
			
			
			pp.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
			
			
		}
		
		
		
	}
	
	//pp.append("top.resetPageBlockAll();\r\n");
	
	pp.append("resetLoadingOverlay();\r\n");

	
	pp.append("}\r\n");
	
	
	pp.append("</script>\r\n");
	
	
	pp.append("<////%\r\n");


	pp.append("////}\r\n");
	pp.append("////catch (Exception ex){\r\n");
	pp.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

	pp.append("////log.error(ex.toString());\r\n");
	pp.append("////}\r\n");
	pp.append("%////>\r\n");
	
	/// shranim

	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_funk"+sif.getId()+"_p"+".jsp"), "latin1"));



	out3.write(pp.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
}


















imefile = imefile+"_funk"+sif.getId();


}





////kreacija jsp za funkcijo
/////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
/////////////////////////////////
////////////////
////////////////







































Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();
imefile = deploy_kam+imefile.toLowerCase()+".jsp";

}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
napaka=ex.toString();
log.error(ex.toString());
}


%>
<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
<body   style="margin: 0" onload="mom()" >
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">

<%
if (napaka!=null && !napaka.equals("")) {
	
	%>

	<p align="center">Napaka: <%=napaka %> </p>

	<%
}
else {
%>

<p align="center">Datoteka <%=imefile %> je bila uspesno generirana! </p>

<%
}
%>

</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>





<script language='javascript'>
function mom() {
	top.parent.frames[3].location = "nic.jsp";
top.parent.frames[2].location = "nic.jsp";
}

</script>





</body>
</html>
