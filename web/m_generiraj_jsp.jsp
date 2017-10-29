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
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("max-age", 0); 
response.addDateHeader("Expires",0); 
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}



String deploy_kam =parametrii.getParametri().getProperty("deploy_kam");// "E:/Tomcat5.0/webapps/ics_test/";



this.contextUtil2 = contextUtil;

%>
 


<%!

public com.popultrade.webapp.ContextUtil contextUtil2 = null;


private com.popultrade.webapp.Parametri parametri = new com.popultrade.webapp.Parametri();
public String deploy_kam =parametri.getParametri().getProperty("deploy_kam");// "E:/Tomcat5.0/webapps/popultrade/";









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
// String remu = ""; ///////// format number , ce je double in ce ima vnesen format

// nul.getDatumFormatFromDate()
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
						
					 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
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
					 sbl.append("rezu=rezu+"+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
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
				 sbl.append("rezu=rezu+"+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
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
	dodvred = " "+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
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
				 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
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
				 sbl.append(""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+";\r\n\r\n");
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




















//// inicializacija koledarja z js
StringBuffer init_koledar = new StringBuffer();

StringBuffer init_scroller = new StringBuffer();

private void set_js_Koledar(String dodatno) {
	init_koledar.append(dodatno+"\r\n");
}
private void set_js_Scroller(String dodatno) {
	init_scroller.append(dodatno+"\r\n");
}
private String dodajKoledar(String dodatno,String ime) {
	
	this.set_js_Koledar("$('#"+ime+"').scroller();");
	
	return "<input type=\"text\"  "+dodatno+"> \r\n";
	
	
}



private com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();














//// search











////zapisem kontrole za opcijo dropdown po kliku na gumb potrdi
public StringBuffer sbaj = new StringBuffer();

public boolean jertf = false;//ce je ze direktiva za rich text format 

public String genField(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {
	//com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	try {
	String premo="";
	
        
        /// pogoji prikaza
        
        	 /// pogledam, ce ima pogoje
	 
	 if (tu.getTemplateClasses().size()>0) {
		 
		 
		 if (!nul.jeNull(tu.getTip_inserta()).equals("file") && !nul.jeNull(tu.getTip_inserta()).equals("dfile")) {
		 premo = premo + createPP(tu,"templateui");
		 }
		 
		 
	 }
	 else {
		  if (!nul.jeNull(tu.getTip_inserta()).equals("file") && !nul.jeNull(tu.getTip_inserta()).equals("dfile")) {
		 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
			 premo = premo + "<%\r\n";
			 premo = premo + "rezu=nul.formatNumber(vseb."+tu.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tu.getFormat_stolpca()+"\");\r\n";
			 premo = premo + "%////>\r\n";
			 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
		 }
		 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
			 premo = premo + "<%\r\n";
			 premo = premo + "rezu=nul.getDatumFormatFromDate(vseb."+tu.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tu.getFormat_stolpca()+"\");\r\n";
			 premo = premo + "%////>\r\n";
		 }
		 else {
			 premo = premo + "<%\r\n";
				if (!nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
			 premo = premo + "rezu=nul.jeNull(vseb."+tu.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n";
				}
			 premo = premo + "%////>\r\n";
		 }
		 }
	 }
        
      
        if (nul.jeNull(tu.getVnos_kdaj()).equals("BO") || nul.jeNull(tu.getVnos_kdaj()).equals("UP") || nul.jeNull(tu.getVnos_kdaj()).equals("AJ")  || nul.jeNull(tu.getVnos_kdaj()).equals("IN") ) {
        	
        	
        	if (!nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).equals("")) {
         		premo = premo + "<////%\r\n\r\n";
                  		
                		premo = premo + nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).replaceAll("\'","\"")+"\r\n";
                		
                  		premo = premo + "%////>\r\n";
                	}
        	/// kontrola in generacija AJAX/////
        		String ime_field="";
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        		
        		ime_field = nul.jeNull(tu.getParameter_drugo_ime()).trim();
        		
        	}
        	else {
        		
        		ime_field = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
        		
        	}
        	
           	
        
        	//String ajaxpolje = getAjax(tu,contextUtil,servletContext,ime_field);
  
          	String[] ajaxpoljea = getAjax(tu,contextUtil,servletContext,ime_field);
  			String ajaxpolje = ajaxpoljea[0];
  
        		boolean novajax=false;
  			if (ajaxpolje.indexOf(" ")!=-1) {
  			novajax=true;
  			
  			
  			}
        	
        	/// konec geracije ajaxa 
        	if (nul.jeNull(tu.getLoad_sifrant_konec()).equals("1")) {
        		
        		
        		String del = ajaxpolje;
        		
        		del = ajaxpolje.substring(ajaxpolje.indexOf("ajax_showOptionsID"),ajaxpolje.indexOf("}"));
        		
        		String[] dro = del.split(",");
        		
        		
        		//// prvi pogoj
        		
        		String suc = dro[3];
        		String vredd = "";
        		if (suc.indexOf("+")!=-1) {
        			
        			suc = suc.substring(suc.indexOf("+")+1);
        			
        			suc = suc.substring(0,suc.indexOf("+"));
        			
        			vredd = "if ("+suc+"!='') {\r\n";
        			
        			
        		}
        		
        			sbaj.append(vredd);
        			
        		del = "setLat("+dro[3] + ","+dro[5]+");\r\n";
        	
        	
        		sbaj.append(del+"\r\n");
        		
        		if (!vredd.equals("")) {
        			sbaj.append("}\r\n");
        		}
        		//ajaxpolje="<////%=(!nul.jeNull(control.getParameter09()).equals(\"1\")?(\""+ajaxpolje.replaceAll("\"", "\\\\\"")+"\"):\"\")%////>";
	String osnovee =   "  onclick=\"setAll();\"  autocomplete=\"off\" onfocus=\"change(this,'yellow');\" onkeyup=\"setAll()\"";

        		
        		ajaxpolje="<////%=(!nul.jeNull(control.getParameter09()).equals(\"1\")?(\""+ajaxpolje.replaceAll("\"", "\\\\\"")+"\"):\""+osnovee.replaceAll("\"", "\\\\\"")+"\")%////>";
        		
        	}
        	 
        	
        //	System.out.println("AJAX: ::: "+ajaxpolje);
        	
        	
        	if (nul.jeNull(tu.getVnos_kdaj()).equals("UP")) {
          		premo = premo + "<////%\r\n\r\n";
          		
        		premo = premo + "if (vseb.getId()!=null && !vseb.getId().equals(\"\")) {\r\n";
        		
          		premo = premo + "%////>\r\n";
        		
        	}
        		else if (nul.jeNull(tu.getVnos_kdaj()).equals("IN")) {
        			premo = premo + "<////%\r\n\r\n";
        			if (nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")) {
        			premo = premo + "if (vseb.getId()!=null && !vseb.getId().equals(\"\")) {\r\n";
        			premo = premo + "%////>\r\n";
        			premo = premo + "<////%=rezu%////>";
        			premo = premo + "<////%\r\n\r\n";
        			premo = premo + "}\r\n";
        			}
        			
        			premo = premo + "if (vseb.getId()!=null) {\r\n";
        			premo = premo + "%////>\r\n";
        			premo = premo + "<////%=rezu%////>";
        			premo = premo + "<////%\r\n\r\n";
        			premo = premo + "}\r\n";
        			premo = premo + "else if (vseb.getId()==null) {\r\n";
        			premo = premo + "%////>\r\n";
        		}
        	
        			
        			
        			
        			//// dodam prevod
        			
        			if (dodaj_prevod) {
        				
        				
        				premo =premo + " < %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ";
        				
        			}
        			
        			if (novajax) {
                		
                		premo = premo + ajaxpolje;
                		}
        	
        	String max = nul.jeNull(tu.getStolpec_max_stevilo_znakov());
        	String dol = nul.jeNull(tu.getStolpec_sirina());
        	String tabi = nul.jeNull(tu.getTab_index());
        	String velike_crke = nul.jeNull(tu.getSamo_velike_crke());
        	
        	
        	if (nul.jeNull(tu.getTip_inserta()).equals("hidden")) {
        		if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
    				premo = premo + "<input type=\"hidden\"  id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"    value=\"<////%=rezu%////>\">\r\n";
        				
    			}
    			else {
    			premo = premo + "<input type=\"hidden\" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"     value=\"<////%=rezu%////>\">\r\n";
    			}
        		
        	}
  else if (nul.jeNull(tu.getTip_inserta()).equals("file") || nul.jeNull(tu.getTip_inserta()).equals("dfile") ) {
        		
        		String inum = "file";
        		
        		
        		
        		String dodc = "";
        		
        	
        	
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		String imecb = "";
        			premo = premo + "<table cellpadding=0 cellspacing=0  style=\" font-family:Verdana; font-size:8pt\" ><tr><td>\r\n";
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\""+inum+"\"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"    "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"   "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"   class=\"valuecell\"  style=\"border: 0px solid ;\" >\r\n";
            				imecb = nul.jeNull(tu.getParameter_drugo_ime());
        			}
        			else {
        			premo = premo + "<input type=\""+inum+"\"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"    "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  class=\"valuecell\"  style=\"border: 0px solid ;\"   onblur=\"change(this,'white');\"  >";
        			imecb = nul.jeNull(nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase());
        			
        			}
        		premo = premo + "</td><td>\r\n";
        		
        		/// brisi checkbox, v primeru, da hoce sliko odstranit
        		
        		//if (!nul.jeN(tu.getDfilename()).equals("")) {
        		
        		premo = premo + "<////%\r\nif (vseb."+tu.getStolpec_metoda().replaceAll("\'","\"")+"()!=null) {\r\n%////>\r\n";
        		
        				premo = premo + "</td><td><img src='jeslika.gif'></td><td><input type=\"checkbox\"  tabindex='-1' id=\""+imecb+"cb\"  name=\""+imecb+"cb\"   class=\"inputIEx\" value='1'  ></td><td> <////%=nul.jeNull(ConPool.getPrevod_admin(\"1000011\",\"Y\",control.getJezik()+\"\"))%////>\r\n";
            	premo = premo + "<////%\r\n}\r\n%////>\r\n";
            	premo = premo + "</td></tr></table>\r\n";
            	
        		//}
        		
        		
        	
        	
        	//if (!ajaxpolje.equals("")) {
        		//premo = premo + "<span id='aj_"+tu.getId()+"'>"+getAjaxVrednostZaSpan(tu,contextUtil,pageContext.getServletContext(),nul.jeNull(tu.getStolpec_metoda()),"rezu")+"</span>\r\n";
        	//}
        	
        	
        
        	}      	
        else if (nul.jeNull(tu.getTip_inserta()).equals("button")) {
        		
        		String inum = "button";
        		
        		
       
        		String dodc = "";
        		
        		if (ajaxpolje.equals("") && velike_crke.equals("1")) {
        			//dodc = " onkeyup=\"javascript:this.value=this.value.toUpperCase();\" ";
        		}
        		
        
        		
        		
        		//Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        	
        			
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\""+inum+"\"  "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"    "+    (!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" "))+"  onblur=\"change(this,'white');\"   value=\"<////%=rezu%////>\">\r\n";
            				
        			}
        			else {
        			premo = premo + "<input type=\""+inum+"\" "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"   "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"")+"  onblur=\"change(this,'white');\" >\r\n";
        			}
        		
        	
        	
        	//if (!ajaxpolje.equals("")) {
        		//premo = premo + "<span id='aj_"+tu.getId()+"'>"+getAjaxVrednostZaSpan(tu,contextUtil,pageContext.getServletContext(),nul.jeNull(tu.getStolpec_metoda()),"rezu")+"</span>\r\n";
        	//}
        	
        	
        
        	}	
else if (nul.jeNull(tu.getTip_inserta()).equals("textbox") || nul.jeNull(tu.getTip_inserta()).equals("password")) {
        		
        		String inum = "text";
        		if (tu.getTip_inserta().equals("password")) {
        			inum = "password";
        		}
        		
        	if (!nul.jeNull(tu.getDatum_vnos_tip()).equals("1")) {
        		
        		String dodc = "";
        		
        		if (ajaxpolje.equals("") && velike_crke.equals("1")) {
        			//dodc = " onkeyup=\"javascript:this.value=this.value.toUpperCase();\" ";
        		}
        		
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("") && nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  readonly type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"    class=\"valuecell\"   style=\"border: 0px solid;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+(novajax?"":ajaxpolje)+">\r\n";
        	}
        	else {
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
        		premo = premo + "<input type=\""+inum+"\"  "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" "))+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  "+(novajax?"":ajaxpolje)+"> <a href=\"javascript: showCalendar('"+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"')\"><img src='call.gif' border='0'></a> \r\n";
        		}
        		else { 
        			
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\""+inum+"\"  "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"   "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" "))+" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\"  onblur=\"change(this,'white');\"  "+(novajax?"":ajaxpolje)+"  value=\"<////%=rezu%////>\">\r\n";
            				
        			}
        			else {
        			premo = premo + "<input type=\""+inum+"\"  "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required   oninput=\"showRequiredMsg(this)\" oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+" "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" "))+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\"  onblur=\"change(this,'white');\"  "+(novajax?"":ajaxpolje)+">\r\n";
        			}
        		} 
        	}
        	
        	//if (!ajaxpolje.equals("")) {
        		//premo = premo + "<span id='aj_"+tu.getId()+"'>"+getAjaxVrednostZaSpan(tu,contextUtil,pageContext.getServletContext(),nul.jeNull(tu.getStolpec_metoda()),"rezu")+"</span>\r\n";
        	//}
        	
        	}
        	else {
        		premo = premo + "<////%\r\n";
        		premo = premo + "String A"+tu.getId()+"=\"\";\r\n";
        		premo = premo + "String B"+tu.getId()+"=\"\";\r\n";
        		
        		premo = premo + "if (rezu!=null && rezu.indexOf(\" \")!=-1) {\r\n";
        			premo = premo + "A"+tu.getId()+"=rezu.substring(0,rezu.indexOf(\" \"));\r\n";
        			premo = premo + "B"+tu.getId()+"=rezu.substring(rezu.indexOf(\" \")+1,rezu.length());\r\n";
        			premo = premo + "} \r\n";
        			premo = premo + "%////>\r\n";
        	
        		premo = premo + "<input  "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  onchange=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=A"+tu.getId()+"%////>\" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"class=\"inputIEx\"")+"  "+(novajax?"":ajaxpolje)+"> <a href=\"javascript: showCalendar('"+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"')\"><img src='call.gif' border='0'></a> ";
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"_U\"  name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"_U\"   maxlength=\'5\' size=\'6\' value=\"<////%=B"+tu.getId()+"%////>\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  >";
	        	
        	}
        	}
        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
        		/// nujno dodati v insert pogoje
        		
        		
        		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
        			
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"    value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"class=\"inputIEx\"")+" >";
            			
        		}
        		else {
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"class=\"inputIEx\"")+" >";
        		}
        		}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
        		/// nujno dodati v insert pogoje
        		String cols = nul.jeNull(tu.getCols());
        		String rows = nul.jeNull(tu.getRows());
        		
        		premo = premo + "<textarea "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"class=\"inputIEta\"")+" ><////%=rezu%////></textarea>";
        	}
        	
         	else if (nul.jeNull(tu.getTip_inserta()).equals("etextarea")) {
         		
         		
         		/// dodam rtf stuff
         		
         		if (!jertf) {
         			jertf=true;
         			premo = premo + "<style type=text/css>\r\n";
         			premo = premo + "@import \"js/rtf/demo.css\";\r\n";
         			premo = premo + "@import \"js/rtf/jquery-te-1.4.0.css\";\r\n";
         			
         			premo = premo + "</style>\r\n";
         			premo = premo + "<script type=\"text/javascript\" src=\"js/rtf/jquery-te-1.4.0.min.js\" charset=\"utf-8\"></script>\r\n";
         		}
         		
         		
        		/// nujno dodati v insert pogoje
        		String cols = nul.jeNull(tu.getCols());
        		String rows = nul.jeNull(tu.getRows());
        		
        		int alox = 500;
        		if (!cols.equals("")) {
        			try {
        				alox = Integer.parseInt(cols)*5;
        			}
        			catch (Exception emo) {
        			}
        		}
        		
        		if (alox>0) {
        			
        			premo = premo + "<script type=\"text/javascript\">\r\n";
        			premo = premo + "var slok"+tu.getId()+";\r\n";
        			premo = premo + "</script>\r\n";
        		premo = premo + "<div style=\"width:"+alox+"px;float:left\">\r\n";
        		}
        	
        		
        		premo = premo + "<textarea "+(nul.jeN(tu.getKontrola_javascript()).equals("DA")?"required  oninput=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"class=\"inputIEta\"")+" ><////%=rezu%////></textarea>";
        		//if (alox>0) {
        		premo = premo + "</div>\r\n";
        	//	}
        		
        		//premo = premo + "<div style=\"background-color:#eeeeee;width:13px;margin-left:"+(alox+2)+"px;height:105px;margin-top:5px;border-radius:4px;padding:6px;text-align:center;border: 2px solid silver;\">M<br>A<br>X<br>I<br>M<br>I<br>Z<br>E</div>";
        		premo = premo + "<div style=\"background-color:#eeeeee;width:33px;margin-left:"+(alox+2)+"px;margin-top:5px;border-radius:4px;padding:1px;text-align:center;border: 1px solid silver;\"><a href=\"\" onclick=\"top.clickove4('rte.jsp?idro="+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"',document.getElementById('"+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"'),slok"+tu.getId()+");return false;\"><img title=\"Maximize\" src=\"maximize.png\"></a></div>";
        		 
        		
        		// init
        		premo = premo + "<script type=\"text/javascript\">\r\n";
        		premo = premo + "$( document ).ready(function() {\r\n";
        		premo = premo + "$('#"+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"').jqte();\r\n";
        		premo = premo + "slok"+tu.getId()+"=$('#"+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?nul.jeNull(tu.getParameter_drugo_ime()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"');\r\n";
        		premo = premo + "});\r\n";
        		premo = premo + "</script>\r\n";
         	
         	}
        	
        	
        	
        	
         	else if (nul.jeNull(tu.getTip_inserta()).equals("divtag")) {
        	
         		String idname = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
         		if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
         			idname = nul.jeNull(tu.getParameter_drugo_ime()).trim();
         		}
        		premo = premo + "<div "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  id=\""+idname+"\" name=\""+idname+"\"  "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"")+" ><////%=rezu%////></div>";
        	}
        	
        	
          	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
          		//System.out.println("XXXXXXXXXXXXXXXXXXXXXXX--------XXXXXXXXXXXXXXXXXXX");
          		
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<select "+((nul.jeN(tu.getKontrola_javascript()).equals("DA") && nul.jeNull(tu.getJavascript_event()).equals(""))?"required  onchange=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"class=\"inputIEx\"")+" >\r\n";
          		}
        		else {
        			premo = premo + "<select "+((nul.jeN(tu.getKontrola_javascript()).equals("DA") && nul.jeNull(tu.getJavascript_event()).equals("")) ?"required  onchange=\"showRequiredMsg(this)\"  oninvalid=\"showRequiredMsg(this,'< %=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \") %////>');\" ":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(!nul.jeN(tu.getDdivclasscus()).equals("")?tu.getDdivclasscus():"class=\"inputIEx\"")+" >\r\n";
                  		}
          		
          		
          		
          		premo = premo + "<option></option>";

          	/// kontrola hintov, ce ima dodam opcije
          	if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getClass_name()!=null) {
          		
          		String clna = tu.getTemplateClassClass().getClass_name();
          		
          		
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
          				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("'","\"")+"+\"\").equals(\"\")";
          			}
          			}
          			/// dodaten pogoj da sploh gleda po bazi
          			
          			
          			
          		}
          		
          		premo = premo + "<////%\r\n";
          		
          		premo = premo + "if (true "+dodaten+") {\r\n";
          		premo = premo + "com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n";

          		premo = premo + "com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n";

          		
          		//// vrednosti
          		
          		Iterator ikov = tu.getTemplateClassClass().getTemplateClasss().iterator();
          		Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),clna);
          		while (ikov.hasNext()) {
          		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
          		
          		if (tcc.getVrednost_pogoja()!=null) {
				String rett=tcc.getVrednost_pogoja().replaceAll("\'","\"")+"+\"\"";
				if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
					
					
					
					rett = "new Long("+rett+")";
					
					
					
				}
				else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("int")!=-1 || ((String)meto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1) {
					rett = "Integer.parseInt("+rett+")";
					
				}
				else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
				
					rett = "Double.parseDouble("+rett+")";
				}
				
				
				
          		
				if (!nul.jeNull(tcc.getDodaten_hql_pogoj()).equals("")) {
					premo = premo + nul.jeNull(tcc.getDodaten_hql_pogoj())+"\r\n";
				}
          		premo = premo + "mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n";
          		if (!nul.jeNull(tcc.getDodaten_hql_pogoj()).equals("")) {
          			premo = premo + "}\r\n";
        		}
          		}
          		}
          		
          		
          		String sifra="";
          		String vrednost="";
          
		/// dobim vrednosti za sifro in vrednost hinta
			 ikov = tu.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
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
          		
          		
          		if (!sifra.equals("") && !vrednost.equals("")) {
          			
          			
          			String sorder = nul.jeNull(tu.getTemplateClassClass().getHead_select_dodatni_pogoji());
          			String sorders = nul.jeNull(tu.getTemplateClassClass().getOrder_by_smer());
        			String dodpog = nul.jeNull(tu.getTemplateClassClass().getDodatni_hql_pogoji());
          			
        	  		
        		  	//	premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n";
        									premo = premo + "String dod_hql=\"\";\r\n";
        		          			
        									
        					          		if (!dodpog.trim().equals("")) {
        					          			premo = premo + " dod_hql=\""+dodpog+"\";\r\n";
        					          		}
          		premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s2(mod"+clna+",\""+sorder+"\",\""+sorders+"\",dod_hql);\r\n";	
          			
          		
          		//premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+");\r\n";
          		
          		premo = premo + "Iterator i"+clna+"=li"+clna+".iterator();\r\n";
          		

          		
          		premo = premo + "while (i"+clna+".hasNext()) {\r\n";
          		premo = premo + "com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n";

          		
          		premo = premo + "%////>\r\n";
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" >"+vrednost+"</option>;\r\n";
          		}
          		else {
          			premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" <////%=nul.jeNull(modi"+clna+"."+sifra+"()).equals(nul.jeNull(vseb."+tu.getStolpec_metoda()+"()))?\"selected\":\"\"%////>>"+vrednost+"</option>;\r\n";
              		
          		}
          		//premo = premo + "p"+tu.getId()+"<////%=modi"+clna+"."+sifra+"()%////>=\"<////%=modi"+clna+"."+vrednost+"()%////>\";\r\n";

          		premo = premo + "<////%\r\n\r\n";
          		premo = premo + "}\r\n\r\n";
          		
          		}
          		
          		premo = premo + "}\r\n";
          		premo = premo + "%////>\r\n";
          		
          		
          	}
          		
          		
          	
          		
          	premo = premo + "</select>\r\n";
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          	} /// end dropbox
        	
    		if (novajax) {
    		//class=\""+(nul.jeNull(tu.getDdivclasscusin()).equals("")?"inputIEx":tu.getDdivclasscusin())+"\"
    		//premo = premo + "</div>";
    	///// cosmico
    	
    	premo +=getAjaxNoviJS(tu,ajaxpoljea,"TemplateUi");
    	
    		}
          	
        	if (nul.jeNull(tu.getVnos_kdaj()).equals("UP") || nul.jeNull(tu.getVnos_kdaj()).equals("IN")) {
         		premo = premo + "<////%\r\n\r\n";
          		premo = premo + "}\r\n\r\n";
          		premo = premo + "%////>\r\n";
        	}
         	if (!nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).equals("")) {
         		premo = premo + "<////%\r\n\r\n";
          		premo = premo + "}\r\nelse {\r\n\r\n";
          		premo = premo + "%////>\r\n";
       	
       		 if (nul.jeNull(tu.getJeslika()).equals("1")) {
       		
       			 
       			 String wi = "";
       			 String he = "";
       			 if (!nul.jeNull(tu.getSlika_width()+"").equals("") && tu.getSlika_width()>0) {
       				 wi = "width='"+tu.getSlika_width()+"'";
       			 }
       			 if (!nul.jeNull(tu.getSlika_height()+"").equals("") && tu.getSlika_height()>0) {
       				 he = "height='"+tu.getSlika_height()+"'";
       			 }
       			premo = premo + "<////%\r\n";
   			 premo = premo + "if (vseb.getId()!=null) {\r\n\r\n";
   			 premo = premo + "%////>\r\n";
   			 
   			 
   			 	 if (nul.jeNull(tu.getJeslikaizbaze()).equals("1")) {
		
				/// dobim templateclass
				
				com.popultrade.model.TemplateHead thead = new com.popultrade.model.TemplateHead();
				com.popultrade.dao.TemplateHeadDAO daothead = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",servletContext);
				
				thead = daothead.getTemplateHead(tu.getTemplateprikazslike());
				
				if (thead!=null) {
				
				 premo = premo + "<img "+wi+"  "+he+" src='"+thead.getHead_class_name().toLowerCase()+"_ob"+thead.getId()+".jsp?id=<////%=vseb.getId()%////>' border='0' >\r\n";
				
				}

			}
			else {
   			 
       			 premo = premo + "<img "+wi+"  "+he+" src='<////%=control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu%////>' border='0' >\r\n";
       			 
       			 }
       			 
       			premo = premo + "<////%\r\n";
				 premo = premo + "}\r\n\r\n";
				 premo = premo + "%////>\r\n";
       		 }
       		 else {
       			if (nul.jeNull(tu.getDodaten_pogoj_prikaz_say()).equals("1")) {
       			 premo = premo + "<////%=rezu%////>\r\n";
       			}
       		 }	
          		premo = premo + "<////%\r\n}\r\n";
          		premo = premo + "%////>\r\n";
        	}
        	
        	}
        	else {
       		 
       		 if (nul.jeNull(tu.getJeslika()).equals("1")) {
       			 
       			 
       			 
       			 
       			 
       			 String wi = "";
       			 String he = "";
       			 if (!nul.jeNull(tu.getSlika_width()+"").equals("") && tu.getSlika_width()>0) {
       				 wi = "width='"+tu.getSlika_width()+"'";
       			 }
       			 if (!nul.jeNull(tu.getSlika_height()+"").equals("") && tu.getSlika_height()>0) {
       				 he = "height='"+tu.getSlika_height()+"'";
       			 }
       			premo = premo + "<////%\r\n";
   			 premo = premo + "if (vseb.getId()!=null) {\r\n\r\n";
   			 premo = premo + "%////>\r\n";
   			 
   			 		 if (nul.jeNull(tu.getJeslikaizbaze()).equals("1")) {
		
				/// dobim templateclass
				
				com.popultrade.model.TemplateHead thead = new com.popultrade.model.TemplateHead();
				com.popultrade.dao.TemplateHeadDAO daothead = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",servletContext);
				
				thead = daothead.getTemplateHead(tu.getTemplateprikazslike());
				
				if (thead!=null) {
				
				 premo = premo + "<img "+wi+"  "+he+" src='"+thead.getHead_class_name().toLowerCase()+"_ob"+thead.getId()+".jsp?id=<////%=vseb.getId()%////>' border='0' >\r\n";
				
				}

			}
			else {
   			 
       			 premo = premo + "<img "+wi+"  "+he+" src='<////%=control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu%////>' border='0' >\r\n";
       			 
       			 }
       			premo = premo + "<////%\r\n";
				 premo = premo + "}\r\n\r\n";
				 premo = premo + "%////>\r\n";
       		 }
       		 else {
       	        		premo = premo + "<////%=rezu%////>\r\n";
       		 }	
        		
        	}
	
	
	return premo;
	}
	
	catch (Exception ex) {
		System.out.println("Napaka pri gen field :" + ex.toString());
	}
	
	return "";
	
}




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
premo = premo + "}\r\n";
//premo = premo + "}\r\n";
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
		premos = premos + "if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n";
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













public String[] getAjax(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,String ime_field) {
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
	
	
	if (tu.getSo_templatedd()>0) {
		
		List lik = tu.getTemplatedds();
		
		Iterator ith = lik.iterator();
		
		if (ith.hasNext()) {
		
			com.popultrade.model.TemplateDD tmdd = (com.popultrade.model.TemplateDD)ith.next();
		if (!nul.jeNull(tmdd.getKontrola()).equals("A")) {

		
		premos = premos + "<////%@ page contentType=\"text/html\\;\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////><jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/><jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" /><jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" /><jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" /><jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" /><////%\r\n";
		premos = premos + "request.setCharacterEncoding(control.encoding);\r\n";
		premos = premos + "response.setContentType(\"text/html; charset=\"+control.encoding);\r\n";
		premos = premos + "response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n";
		premos = premos + "response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n";
		premos = premos + "response.addDateHeader(\"Expires\", 0);\r\n";
	//	premos = premos + "boolean jetr = false;\r\n";
		premos = premos + "if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n";
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
    					
    					/*String vredmet = tcc.getVrednost_metode();
    					if (vredmet.indexOf("request.getParameter")!=-1) {
    						if (vredmet.indexOf("\"")!=-1) {
    							vredmet = vredmet.substring(vredmet.indexOf("\"")+1,vredmet.lastIndexOf("\""));
    						}
    						else if (vredmet.indexOf("'")!=-1) {
    						vredmet = vredmet.substring(vredmet.indexOf("'")+1,vredmet.lastIndexOf("'"));
    						}
    					}*/
    				
    					//daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+vredmet+"=<////%="+tcc.getVrednost_metode().replaceAll("'","\"")+"%////>";
    					daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"=<////%="+tcc.getVrednost_metode().replaceAll("'","\"")+"%////>";
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
String tododaj = "%////><////%}";
		
		premos  = premos.replaceFirst("----DODAJ----", tododaj);
		
		
	
		try {
		/// shranim file za ajax
		if ((tmdd.getStatus()).equals("1")) {
		Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"), "latin1"));



		out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
		////zaprem writer3
		out3.close();
		String velike_crke = nul.jeNull(tu.getSamo_velike_crke());
		
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
		else { /////// AJAX KONTROLA
			
			

			
			

			premos = premos + "<////%@ page contentType=\"text/html\\;\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////><jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/><jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" /><jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" /><jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" /><jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" /><////%\r\n";
			premos = premos + "request.setCharacterEncoding(control.encoding);\r\n";
			premos = premos + "response.setContentType(\"text/html; charset=\"+control.encoding);\r\n";
			premos = premos + "response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n";
			premos = premos + "response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n";
			premos = premos + "response.addDateHeader(\"Expires\", 0);\r\n";
			premos = premos + "boolean jetr = false;\r\n";
			premos = premos + "if (jetr) { //(control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\")))) {\r\n";
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
				 rett="nul.menjajVSumnike(request.getParameter(\""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"\"),nul.jeNull(ConPool.getPrevod_admin(\"1000010\",\"Y\",\"SL\")))+\"\"";
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

premos = premos + "String rezu_format=\"\";\r\n";
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
				//	daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt.replaceAll(\"\\\"\",\"'\")%////><%}catch(Exception ex){}%////> ___ ";
				
				
				if (nul.jeNull(tcc.getUporabi_kontrola_vrednost()).equals("1"))  {
				
				daj_v_set_f = daj_v_set_f +"if (trim(document.dod."+ tcc.getIme_metode().replaceAll("get","").toLowerCase()+".value)==\"\") {\r\n";
				
				}
				
					daj_v_set_f = daj_v_set_f +"document.dod."+ tcc.getIme_metode().replaceAll("get","").toLowerCase()+".value=rezu["+zapo+"];\r\n\r\n";
					
						if (nul.jeNull(tcc.getUporabi_kontrola_vrednost()).equals("1"))  {
				
				daj_v_set_f = daj_v_set_f +"}\r\n\r\n";
				
				}
					
					/*
					if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
						
						daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
						}
						else {
							daj_v_id = daj_v_id+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
							
							daj_v_id = daj_v_id +"<%=rezu_format%////> ___ ";
							
						}*/
						
						if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
							
						daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
						}
						else {
							daj_v_vrednost = daj_v_vrednost+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
							
							daj_v_vrednost = daj_v_vrednost +"<%=rezu_format%////> ___ ";
							
						}
					
					
					
					
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
			
			
		//	premos = premos + "String rezu_format=\"\";\r\n";
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
	
	
	String[] retu = {retx,retx2,retx3,retx4,retx5,retx6,retx7,retx8}; 
	
	return retu;
	 
	
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

	

	
//	System.out.println(" ========dddddddddddd " +request.getParameter("id"));
	
	
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

sbu.append("if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
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


sbu.append("function resetPageBlockAll() {\r\n");


sbu.append("if (document.getElementById(\"ifr2\").contentWindow!=null && typeof document.getElementById(\"ifr2\").contentWindow.resetPageBlock === \"function\") { \r\n");
		sbu.append("document.getElementById(\"ifr2\").contentWindow.resetPageBlock();\r\n");
			sbu.append("}\r\n");
	sbu.append("if (document.getElementById(\"ifr3\").contentWindow!=null && typeof document.getElementById(\"ifr3\").contentWindow.resetPageBlock === \"function\") { \r\n");
		sbu.append("document.getElementById(\"ifr3\").contentWindow.resetPageBlock();\r\n");
	

			sbu.append("}\r\n");
	sbu.append("}\r\n");






sbu.append("<body  "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+" >\r\n");
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
//// kreacija jsp za update/insert
if (sif.getHead_tip().equals("UI")) {



    com.popultrade.dao.TemplateUiDAO daoui = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());


/// ce so file input type
boolean soFileInput=false;

    System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15666 ------------------------------------------------------- xxxxxxxxxxxxxxxxxxxxx");
sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.apache.commons.io.*\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");
sb.append("<////jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");

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

sb.append("<////%\r\n");
sb.append("////try {\r\n");
sb.append("boolean bok=false;\r\n");
sb.append("int akcij=0;\r\n");
sb.append("String nidd=\"\";\r\n");
sb.append("String napaka=\"\";\r\n");
sb.append("String dodpog=\"\";\r\n");




if (!nul.jeNull(sif.getUporabi_count()).equals("1")) {
sb.append("boolean mum=false;\r\n");


if (!nul.jeN(sif.getZakleni_record()).equals("")) {

sb.append("if (!nul.jeNull("+sif.getZakleni_record().replaceAll("\'","\"")+").equals(\"\")) {\r\n");
sb.append("if (!prisotnost.users.containsKey(nul.jeNull("+sif.getZakleni_record().replaceAll("\'","\"")+"))) {\r\n");

  ///// brisem iz obdelave, ce je kakega obdeloval
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,\"\",new Date(),3,\""+imefile+"_edit"+sif.getId()+"\");\r\n");
///// ce ni v obdelavi ga vpisem
//ConPool.narociloVObdelavi(request.getParameter("stevilka_narocila"),control.getUser2(),control.company);
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,"+sif.getZakleni_record().replaceAll("\'","\"")+",new Date(),1,\""+imefile+"_edit"+sif.getId()+"\");\r\n");
sb.append("mum=true;\r\n");
sb.append("}\r\n");
sb.append("else if (prisotnost.istiUserKontrola(control.idUporabnikaLock,"+sif.getZakleni_record().replaceAll("\'","\"")+")) {\r\n");
	sb.append("mum=true;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("mum=true;\r\n");
sb.append("}\r\n");

}
else {

sb.append("if (!nul.jeNull(request.getParameter(\"id\")).equals(\"\")) {\r\n");
sb.append("if (!prisotnost.users.containsKey(nul.jeNull(request.getParameter(\"id\")))) {\r\n");

  ///// brisem iz obdelave, ce je kakega obdeloval
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,\"\",new Date(),3,\""+imefile+"_edit"+sif.getId()+"\");\r\n");
///// ce ni v obdelavi ga vpisem
//ConPool.narociloVObdelavi(request.getParameter("stevilka_narocila"),control.getUser2(),control.company);
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,request.getParameter(\"id\"),new Date(),1,\""+imefile+"_edit"+sif.getId()+"\");\r\n");
sb.append("mum=true;\r\n");
sb.append("}\r\n");
sb.append("else if (prisotnost.istiUserKontrola(control.idUporabnikaLock,request.getParameter(\"id\"))) {\r\n");
	sb.append("mum=true;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("mum=true;\r\n");
sb.append("}\r\n");

}



}
else {
	sb.append("boolean mum=true;\r\n");
}


sb.append("if (mum) {\r\n");


/////// dobim dodatne opcije
com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());



com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();


tuidd = daouid.getTemplateUiDodatnos(idpr);


if (!nul.jeNull(tuidd.getDodatno_java()).trim().equals("")) {
	sb.append(nul.jeNull(tuidd.getDodatno_java()).trim()+"\r\n");
}

if (!nul.jeNull(sif.getNosql()).equals("1") || sif.getHead_class_name_nosql()==null || sif.getHead_class_name_nosql().equals("")) {
sb.append("com.popultrade.model."+imefile+" sif =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.model."+imefile+" vseb =new com.popultrade.model."+imefile+"();\r\n");
}
else if (sif.getHead_class_name_nosql()!=null && !sif.getHead_class_name_nosql().equals("")) {
	sb.append("com.popultrade.model."+sif.getHead_class_name_nosql()+" sif =new com.popultrade.model."+sif.getHead_class_name_nosql()+"();\r\n");
	sb.append("com.popultrade.model."+sif.getHead_class_name_nosql()+" vseb =new com.popultrade.model."+sif.getHead_class_name_nosql()+"();\r\n");
}

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15666 ------------------------------------------- 1");

if (!nul.jeNull(sif.getNosql()).equals("1")) {
sb.append("com.popultrade.dao."+imefile+"DAO dao = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");
}
else {
	
sb.append("com.popultrade.dao."+imefile+"DAO dao = new com.popultrade.dao."+imefile+"DAO();\r\n");
if (!nul.jeN(sif.getHead_class_name_nosql()).equals("")) {
sb.append("com.popultrade.model."+imefile+" vsebm = dao.get"+imefile+"(request.getParameter(\"idem\"),ConPool.getEntman());\r\n");
}

}
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15666 ------------------------------------------- 2");

if (nul.jeNull(sif.getZacetek_procedure()).trim().equals("")) {
	
	
	sb.append("if (  "+(nul.jeN(sif.getOverraid_update_default()).equals("1")?"":"!nul.jeN(request.getParameter(\"id\")).equals(\"\") &&")+"  request.getParameter(\"akcijaXY\")==null) {\r\n");
	
	
	
	
	

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

	
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15666 ------------------------------------------- 3");
	
	
//sb.append("if (sif.getId()==null) {\r\n");
	
//	sb.append("vseb = dao.get"+imefile+"(new Long(nul.jeNull(request.getParameter(\"id\"))));\r\n");

	//sb.append("}\r\n");
	//sb.append("else {\r\n");
	if (!nul.jeNull(sif.getNosql()).equals("1")) {
		
		if (!nul.jeN(sif.getOverraid_update_default()).equals("1")) {
	sb.append("sif.setId(new Long(request.getParameter(\"id\")));\r\n");
		}
	
	
	sb.append("List lis = dao.get"+imefile +"s(sif,1,1,dodpog,\"\",\"\");\r\n");
	}
	else {
		
		if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {
		sb.append("com.popultrade.model."+imefile+" sifk = new com.popultrade.model."+imefile+"();\r\n");

		sb.append("sifk.setId(request.getParameter(\"idem\"));\r\n");
		
		
		
		sb.append("List lis = dao.get"+imefile+"s(sifk,ConPool.getEntman(),\"\",1,1);\r\n");	
		}
		else {
			sb.append("List lis = dao.get"+imefile+"s(sif,ConPool.getEntman(),\"\",1,1);\r\n");	
			
		}
	
	
	}
	
	sb.append("if (lis.size()>0) {\r\n");
		
	
	if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) { /// nosql one to many
		
		//sb.append("com.popultrade.model."+imefile+" vsebmm = (com.popultrade.model."+imefile+")lis.get(0);\r\n");
		sb.append("List gumx = vsebm.get"+sif.getHead_class_name_nosql()+"();\r\n");
		
		
		sb.append("Iterator itox=gumx.iterator();\r\n");
		

		
		sb.append("while (itox.hasNext()) {\r\n");
		sb.append("com.popultrade.model."+sif.getHead_class_name_nosql() +" modix = (com.popultrade.model."+sif.getHead_class_name_nosql() +")itox.next();\r\n");
		
		sb.append("if (modix.getId().equals(request.getParameter(\"id\"))) {\r\n");
		sb.append("vseb = modix;\r\n");
		sb.append("break;\r\n");
		sb.append("}\r\n");
		
		sb.append("}\r\n");
		
		
		
		
		
		
	}
	else {
	
	sb.append("vseb = (com.popultrade.model."+imefile+")lis.get(0);\r\n");
	}
	
	
	
	
	//sb.append("}\r\n");
	
	
	sb.append("}\r\n");
	
	
	
	
	
	





}
else {
	
	sb.append("if ("+nul.jeNull(sif.getZacetek_procedure())+"!=null && request.getParameter(\"akcijaXY\")==null) {\r\n");

	
	sb.append("vseb = dao.get"+(nul.jeNull(sif.getHead_class_name_nosql()).equals("")?imefile:sif.getHead_class_name_nosql())+"("+nul.jeNull(sif.getZacetek_procedure())+");\r\n");	




}














sb.append("}\r\n");

sb.append("else if (request.getParameter(\"akcijaXY\")!=null)  {\r\n");


// kontrole java test iz dodatno

if (!nul.jeNull(tuidd.getDodatno_java_test()).trim().equals("")) {
	sb.append(nul.jeNull(tuidd.getDodatno_java_test()).trim()+"\r\n");
}


/// kontrola pred vnosom da ustreza pogojem da se lahko updata ali inserta
/*com.popultrade.dao.TemplateGumbiDAO dgum = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());
com.popultrade.model.TemplateGumbi tgum = new com.popultrade.model.TemplateGumbi();
tgum = dgum.getTemplateGumbi(sif.getVeza_gumb());
*/


com.popultrade.model.TemplateClass dgum =new com.popultrade.model.TemplateClass();
com.popultrade.dao.TemplateClassDAO tgum = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

	
dgum = tgum.getTemplateClassDodatnos(sif.getVeza_gumb()+"");


if (dgum!=null && dgum.getDodaten_hql_pogoj()!=null && !dgum.getDodaten_hql_pogoj().trim().equals("")) {
sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n\r\n");

//// ce je mebeddable ni kontrole, ker ze pase not
if (nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {

sb.append("com.popultrade.model."+imefile+" vsebkont =new com.popultrade.model."+imefile+"();\r\n");
//sb.append("com.popultrade.dao."+imefile+"DAO daokont = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");


if (!nul.jeNull(sif.getNosql()).equals("1")) {
sb.append("com.popultrade.dao."+imefile+"DAO daokont = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");
sb.append("vsebkont = daokont.get"+imefile+"(new Long(request.getParameter(\"id\")));\r\n");

}
else {
	sb.append("com.popultrade.dao."+imefile+"DAO daokont = new com.popultrade.dao."+imefile+"DAO();\r\n");
	sb.append("vsebkont = daokont.get"+imefile+"(request.getParameter(\"id\"),ConPool.getEntman());\r\n");
	
}

sb.append("if (vsebkont!=null && vsebkont.getId()!=null) {\r\n");

}
else {
	sb.append("if (true) {\r\n	\r\n");
}



//sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("control.geet", "control.get")+") {\r\n");
sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("getTime", "geetTime").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("geetTime", "getTime").replaceAll("control.geet", "control.get")+") {\r\n");

sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("bok=true;\r\n");
sb.append("napaka=\"Napaka: dokumenta ni vec mogoce spreminjati!\";\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
}





sb.append("if (!bok) {\r\n");
sb.append("String rabiinsert=\"\";\r\n");
sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n");
sb.append("akcij=4;\r\n");


sb.append("String rezu=\"\";\r\n");

if (!nul.jeNull(sif.getNosql()).equals("1")) {
sb.append("vseb = dao.get"+imefile+"(new Long(nul.jeNullDefault(request.getParameter(\"id\"))));\r\n");
sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request,1);\r\n");

}
else {

	/// embeddable
	if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {

	sb.append("List gumx = vsebm.get"+sif.getHead_class_name_nosql()+"();\r\n");
	
	
	sb.append("Iterator itox=gumx.iterator();\r\n");
	

	
	sb.append("while (itox.hasNext()) {\r\n");
	sb.append("com.popultrade.model."+sif.getHead_class_name_nosql() +" modix = (com.popultrade.model."+sif.getHead_class_name_nosql() +")itox.next();\r\n");
	
	sb.append("if (modix.getId().equals(request.getParameter(\"id\"))) {\r\n");
	sb.append("vseb = modix;\r\n");
	sb.append("break;\r\n");
	sb.append("}\r\n");
	
	sb.append("}\r\n");
	
	
	}
	else {
sb.append("vseb = dao.get"+imefile+"(request.getParameter(\"id\"),ConPool.getEntman());\r\n");
	}


}


sb.append("nidd=vseb.getId()+\"\";\r\n");
//sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request);\r\n");
if (!nul.jeNull(sif.getNosql()).equals("1")) {
//sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request);\r\n");
}
else {
	
	if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {
	sb.append("vseb = (com.popultrade.model."+sif.getHead_class_name_nosql()+")contextUtil.getPopulatedObject(vseb,request,1);\r\n");	
	}
	else {
		sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request,1);\r\n");	
	}
	
}
//sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request);\r\n");


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII12222");
com.popultrade.model.TemplateUi tui = new com.popultrade.model.TemplateUi();

tui.setTemplatehead_id(new Long(idpr));
List tempui = daoui.getTemplateUis(tui);


/// dobim metode return type
Hashtable meto = templateUtil.getClassMetodeImenaHTGet(imefile);
///// dobim inserte, za checkbox, ce ne ne dela avtomaticno in datume
Iterator itmee = tempui.iterator();
String dodaj_ins="";
String dodaj_upd="";
String dodaj_datum_ui = "";
String dodaj_datum="";

while (itmee.hasNext()) {
	
	com.popultrade.model.TemplateUi tuid = (com.popultrade.model.TemplateUi)itmee.next();
	
	 
	//System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII19999511");
	if (nul.jeNull(tuid.getTip_inserta()).equals("checkbox") && nul.jeN(tuid.getParameter_drugo_ime()).equals("")) {
		//System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII19999522");
		//tuid.get
		if (!nul.jeNull(tuid.getDodaten_pogoj_prikaza_edit()).equals("")) {
			
			dodaj_ins=dodaj_ins+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"\")) {\r\n";
			dodaj_upd=dodaj_ins+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"\")) {\r\n";
			
		}
		
		if (nul.jeNull(tuid.getVnos_kdaj()).equals("BO")) {
		dodaj_ins=dodaj_ins+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"1\")?\"1\":\"0\");\r\n";
		dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"1\")?\"1\":\"0\");\r\n";
		
		}
		else if (nul.jeNull(tuid.getVnos_kdaj()).equals("UP")) {
			dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"1\")?\"1\":\"0\");\r\n";
			
		}
		else if (nul.jeNull(tuid.getVnos_kdaj()).equals("IN")) {
			dodaj_ins=dodaj_ins+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"1\")?\"1\":\"0\");\r\n";
			
		}
		
	if (!nul.jeNull(tuid.getDodaten_pogoj_prikaza_edit()).equals("")) {
			
			dodaj_ins=dodaj_ins+"\r\n}\r\n";
			dodaj_upd=dodaj_ins+"\r\n}\r\n";
		}
		
	}
	 //// ce gre za file objekt
	else if (nul.jeNull(tuid.getTip_inserta()).equals("file")) {
	
	soFileInput=true;
//dodaj_ins=dodaj_ins+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"1\")) {\r\n";
dodaj_upd=dodaj_upd+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"cb\")).equals(\"1\")) {\r\n";
	//if (!nul.jeNull(request.getParameter("fileecb")).equals("1")) {
dodaj_upd=dodaj_upd+"Part filePart = request.getPart(\""+ (!nul.jeNull(tuid.getParameter_drugo_ime()).equals("")?tuid.getParameter_drugo_ime():nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")  ) +"\");\r\n";
/// file size, lahko rocno, ce ne 10mb 10000
dodaj_upd=dodaj_upd+"if (filePart!=null && !filePart.getSubmittedFileName().equals(\"\")) {\r\n";
dodaj_upd=dodaj_upd+"if ((filePart.getSize()/1024 )>"+(nul.jeNull(tuid.getDfilesize()+"")!=null?nul.jeNull(tuid.getDfilesize()+""):"10000")+") {\r\n";
dodaj_upd=dodaj_upd+"bok=true;\r\n";
dodaj_upd=dodaj_upd+"napaka=nul.jeNull(ConPool.getPrevod_admin(\"1000012\",\"Y\",control.getJezik()+\"\")) + \" "+(nul.jeNull(tuid.getDfilesize()+"")!=null?nul.jeNull(tuid.getDfilesize()+""):"10000")+" Kb ("+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+")\";\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"else {\r\n";
dodaj_upd=dodaj_upd+"String fileName = filePart.getSubmittedFileName();\r\n";
dodaj_upd=dodaj_upd+"InputStream fileContent = filePart.getInputStream();\r\n";
dodaj_upd=dodaj_upd+"String contentType = filePart.getContentType();\r\n";
 // System.out.println("fileName  ::: "+fileName  );
dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(IOUtils.toByteArray(fileContent));\r\n";
//dodaj_upd=dodaj_upd+"vseb.setBlobb(IOUtils.toByteArray(fileContent));\r\n";
    /// set filename, ce je kot opcija
    if (!nul.jeN(tuid.getDfilename()).equals("")) {
        dodaj_upd=dodaj_upd+"if (fileName.indexOf(\"/\")!=-1) {\r\n";
    dodaj_upd=dodaj_upd+"fileName = fileName.substring(fileName.lastIndexOf(\"/\")+1);\r\n";
    dodaj_upd=dodaj_upd+"}\r\n";
    dodaj_upd=dodaj_upd+"else if (fileName.indexOf(\"\\\\\")!=-1) {\r\n";
    dodaj_upd=dodaj_upd+"fileName = fileName.substring(fileName.lastIndexOf(\"\\\\\")+1);\r\n";
    dodaj_upd=dodaj_upd+"}\r\n";
     dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getDfilename()).replaceAll("get","set")+"(fileName);\r\n";
//dodaj_upd=dodaj_upd+"vseb.setNaslov_tekst(fileName);\r\n";
  }
      if (!nul.jeN(tuid.getDcontenttype()).equals("")) {
     dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getDcontenttype()).replaceAll("get","set")+"(contentType);\r\n";
//dodaj_upd=dodaj_upd+"vseb.setNaslov_tekst(fileName);\r\n";
  }
  
  
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"else {\r\n";
//dodaj_upd=dodaj_upd+"vseb.setBlobb(null);\r\n";
if(nul.jeNull(tuid.getParameter_drugo_ime()).equals(""))  {
dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(null);\r\n";
}



dodaj_upd=dodaj_upd+"}\r\n";
dodaj_ins = dodaj_ins + dodaj_upd;
}




//// ce gre za file objekt in dam na disk
else if (nul.jeNull(tuid.getTip_inserta()).equals("dfile")) {

soFileInput=true;
//dodaj_ins=dodaj_ins+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"1\")) {\r\n";
dodaj_upd=dodaj_upd+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"cb\")).equals(\"1\")) {\r\n";
//if (!nul.jeNull(request.getParameter("fileecb")).equals("1")) {
dodaj_upd=dodaj_upd+"Part filePart = request.getPart(\""+  (!nul.jeNull(tuid.getParameter_drugo_ime()).equals("")?tuid.getParameter_drugo_ime():nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")  )    +"\");\r\n";
/// file size, lahko rocno, ce ne 10mb 10000
dodaj_upd=dodaj_upd+"if (filePart!=null && !filePart.getSubmittedFileName().equals(\"\")) {\r\n";
dodaj_upd=dodaj_upd+"if ((filePart.getSize()/1024 )>"+(nul.jeNull(tuid.getDfilesize()+"")!=null?nul.jeNull(tuid.getDfilesize()+""):"10000")+") {\r\n";
dodaj_upd=dodaj_upd+"bok=true;\r\n";
dodaj_upd=dodaj_upd+"napaka=nul.jeNull(ConPool.getPrevod_admin(\"1000012\",\"Y\",control.getJezik()+\"\")) + \" "+(nul.jeNull(tuid.getDfilesize()+"")!=null?nul.jeNull(tuid.getDfilesize()+""):"10000")+" Kb ("+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+")\";\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"else {\r\n";
dodaj_upd=dodaj_upd+"String fileName = filePart.getSubmittedFileName();\r\n";



dodaj_upd=dodaj_upd+"InputStream fileContent = filePart.getInputStream();\r\n";
dodaj_upd=dodaj_upd+"String contentType = filePart.getContentType();\r\n";

dodaj_upd=dodaj_upd+"String fileName2=fileName.substring(fileName.lastIndexOf(\".\"));\r\n";

dodaj_upd=dodaj_upd+"String upkam = control.lokacijaupload+\"/s\"+control.idUporabnika+\"/s\"+nul.getDatumFormatFromDate(new Date(),\"yyyyMMddHHmmssS\")+fileName2;\r\n";
dodaj_upd=dodaj_upd+"String upkam1 = control.lokacijaupload+\"/s\"+control.idUporabnika+\"/\";\r\n";

dodaj_upd=dodaj_upd+"String upkam2 = \"/s\"+control.idUporabnika+\"/s\"+nul.getDatumFormatFromDate(new Date(),\"yyyyMMddHHmmssS\")+fileName2;\r\n";
dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getDdivname()).replaceAll("get","set")+"(upkam2);\r\n";
dodaj_upd=dodaj_upd+"File fiko = new File(upkam1);\r\n";
dodaj_upd=dodaj_upd+"if (!fiko.exists()) {\r\n";
	dodaj_upd=dodaj_upd+"fiko.mkdirs();\r\n";
	dodaj_upd=dodaj_upd+"}\r\n";
	dodaj_upd=dodaj_upd+"File fiko2 = new File(upkam);\r\n";
dodaj_upd=dodaj_upd+"nul.copyInputStreamToFile(fileContent, fiko2);\r\n";


//dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(IOUtils.toByteArray(fileContent));\r\n";

/// set filename, ce je kot opcija
if (!nul.jeN(tuid.getDfilename()).equals("")) {
   dodaj_upd=dodaj_upd+"if (fileName.indexOf(\"/\")!=-1) {\r\n";
dodaj_upd=dodaj_upd+"fileName = fileName.substring(fileName.lastIndexOf(\"/\")+1);\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"else if (fileName.indexOf(\"\\\\\")!=-1) {\r\n";
dodaj_upd=dodaj_upd+"fileName = fileName.substring(fileName.lastIndexOf(\"\\\\\")+1);\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getDfilename()).replaceAll("get","set")+"(fileName);\r\n";
//dodaj_upd=dodaj_upd+"vseb.setNaslov_tekst(fileName);\r\n";
}
 if (!nul.jeN(tuid.getDcontenttype()).equals("")) {
dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getDcontenttype()).replaceAll("get","set")+"(contentType);\r\n";
//dodaj_upd=dodaj_upd+"vseb.setNaslov_tekst(fileName);\r\n";
}


dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"else {\r\n";
//dodaj_upd=dodaj_upd+"vseb.setBlobb(null);\r\n";

if (nul.jeNull(tuid.getParameter_drugo_ime()).equals("") ) {
	

dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(null);\r\n";
}

/// remove from disk

if (tuid.getDdivname()!=null && !tuid.getDdivname().equals("")) {

	
dodaj_upd=dodaj_upd+"try {\r\n";
dodaj_upd=dodaj_upd+"File fixr = new File(\""+control.lokacijaupload+"\"+vseb."+nul.jeNull(tuid.getDdivname())+"());\r\n";
dodaj_upd=dodaj_upd+"fixr.delete();\r\n";
dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getDdivname()).replaceAll("get","set")+"(null);\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
dodaj_upd=dodaj_upd+"catch (Exception edo) {\r\n";
dodaj_upd=dodaj_upd+"	System.out.println(\"error removing file \"+edo.toString());\r\n";
dodaj_upd=dodaj_upd+"}\r\n";
//dodaj_upd=dodaj_upd+"}\r\n";


}



dodaj_upd=dodaj_upd+"}\r\n";
dodaj_ins = dodaj_ins + dodaj_upd;
}











	
	
	
//	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII199995"+tuid.getStolpec_metoda());
	
	if (meto.containsKey(nul.jeNull(tuid.getStolpec_metoda()))) {
	//	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII19999577");
		if (((String)meto.get(nul.jeNull(tuid.getStolpec_metoda()))).indexOf("Date")!=-1) {
		//	dodaj_datum = dodaj_datum + "dp_ca1 = new Epoch('epoch_popup','popup',document.dod."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+");\r\n";
				if (!nul.jeNull(tuid.getDodaten_pogoj_prikaza_edit()).equals("")) {
			
			dodaj_ins=dodaj_ins+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"\")) {\r\n";
			dodaj_upd=dodaj_ins+"\r\n if (!nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\")).equals(\"\")) {\r\n";
			
		}
			if (nul.jeNull(tuid.getDatum_vnos_tip()).equals("1")) {
			dodaj_datum_ui = " nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"))+\" \"+nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"))";
			
			}
			else {
				dodaj_datum_ui = " nul.jeNull(request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"))";
				
			}
			
		if (nul.jeNull(tuid.getVnos_kdaj()).equals("BO")) {
				
				//dodaj_ins=dodaj_ins+"dat=\"\";\r\n";
				
				
				dodaj_ins=dodaj_ins+"if (request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\")!=null) {\r\n";
				dodaj_ins=dodaj_ins+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
				dodaj_ins=dodaj_ins+"}";
				
				//dodaj_upd=dodaj_upd+"dat=\"\";\r\n";
				dodaj_upd=dodaj_upd+"if (request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\")!=null) {\r\n";
				
				dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
				dodaj_upd=dodaj_upd+"}";
				}
				else if (nul.jeNull(tuid.getVnos_kdaj()).equals("UP")) {
					//dodaj_upd=dodaj_upd+"dat=\"\";\r\n";
				dodaj_upd=dodaj_upd+"if (request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\")!=null) {\r\n";
				
					dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
					dodaj_upd=dodaj_upd+"}";
				}
				else if (nul.jeNull(tuid.getVnos_kdaj()).equals("IN")) {
					dodaj_ins=dodaj_ins+"if (request.getParameter(\""+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\")!=null) {\r\n";
					
					//dodaj_ins=dodaj_ins+"dat=\"\";\r\n";
					dodaj_ins=dodaj_ins+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
					dodaj_ins=dodaj_ins+"}";
				}
			if (!nul.jeNull(tuid.getDodaten_pogoj_prikaza_edit()).equals("")) {
				
				dodaj_ins=dodaj_ins+"\r\n}\r\n";
				dodaj_upd=dodaj_ins+"\r\n}\r\n";
			}
		}
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
}



System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII11235");











System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII122225");

sb.append(dodaj_upd);


if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_update()!=null && !tuidd.getDodatno_update().equals("")) {
	
	
	String vru  = tuidd.getDodatno_update().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			if (splu[i].indexOf("[F")==-1) {
		//	sb.append("vseb."+splu[i]+";\r\n");
			
			
			if (splu[i].trim().startsWith("set") ) {
				sb.append("vseb."+splu[i]+";\r\n");
			}
			else {
				sb.append(""+splu[i]+"\r\n");
			}
			}
			else if (splu[i].indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),splu[i].substring(splu[i].indexOf("[F")+2,splu[i].indexOf("]"))));
				
				
				
				sb.append("vseb."+splu[i].substring(0,splu[i].indexOf("'"))+getFormatReturn(imefile,splu[i].substring(0,splu[i].indexOf("(")),"rezu")+splu[i].substring(vru.lastIndexOf("'")+1,splu[i].length())+"\r\n");
				
				
			}
			}
		
		
		
	}
	else if (!vru.equals("")) {
		//sb.append("vseb."+vru+";\r\n");
		if (vru.indexOf("[F")==-1) {
			
			if (vru.trim().startsWith("set") ) {
			sb.append("vseb."+vru+";\r\n");
		}
		else {
			sb.append(""+vru+"\r\n");
		}
		}
			else if (vru.indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),vru.substring(vru.indexOf("[F")+2,vru.indexOf("]"))));
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+getFormatReturn(imefile,vru.substring(0,vru.indexOf("(")),"rezu")+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
			}
	}
	
	
	
}


/// dodatno update
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII133335");



sb.append("}\r\n");

sb.append("else {\r\n");
sb.append("akcij=5;\r\n");
if (!nul.jeNull(tuidd.getDodatno_delete()).equals("")) {
	sb.append(nul.jeNull(tuidd.getDodatno_delete()).replaceAll("\'","\"") + " {\r\n");

	sb.append("rabiinsert=\"X\";\r\n");
	sb.append("}\r\n");
	
}

sb.append("String rezu=\"\";\r\n");

if (!nul.jeNull(sif.getNosql()).equals("1")) {
sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request,1);\r\n");
}
else {
	
	if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {
	sb.append("vseb = (com.popultrade.model."+sif.getHead_class_name_nosql()+")contextUtil.getPopulatedObject(vseb,request,1);\r\n");	
	}
	else {
		sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request,1);\r\n");	
	}
	
}

/// dodatno insert


sb.append(dodaj_ins);


if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_insert()!=null && !tuidd.getDodatno_insert().equals("")) {
	
	
	String vru  = tuidd.getDodatno_insert().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			/*	if (splu[i].indexOf("[F")==-1) {
			sb.append("vseb."+splu[i]+";\r\n");
			}*/
			
			if (splu[i].indexOf("[F")==-1) {
				
				
				
				if (splu[i].trim().startsWith("set") ) {
					sb.append("vseb."+splu[i]+";\r\n");
				}
				else {
					sb.append(""+splu[i]+"\r\n");
				}/*
				if (splu[i].startsWith("if") || splu[i].startsWith("else") || splu[i].startsWith("}")) {
					sb.append(""+splu[i]+"\r\n");
				}
				else {
					sb.append("vseb."+splu[i]+";\r\n");
				} */
		}	
				
			
			else if (splu[i].indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),splu[i].substring(splu[i].indexOf("[F")+2,splu[i].indexOf("]"))));
			
				System.out.println("OOOOOOOOOOOOOOOOOOOOOOOO ::: "+splu[i]);
				sb.append("vseb."+splu[i].substring(0,splu[i].indexOf("'"))+getFormatReturn(imefile,splu[i].substring(0,splu[i].indexOf("(")),"rezu")+splu[i].substring(splu[i].lastIndexOf("'")+1,splu[i].length())+"\r\n");
			}
			}
		
		
		
	}
	else if (!vru.equals("")) {
		//sb.append("vseb."+vru+";\r\n");
		if (vru.indexOf("[F")==-1) {
			
			if (vru.trim().startsWith("set") ) {
				sb.append("vseb."+vru+";\r\n");
			}
			else {
				sb.append(""+vru+"\r\n");
			}
			
		/*	
		if (vru.startsWith("if") || vru.startsWith("else") || vru.startsWith("}")) {
			sb.append(""+vru+";\r\n");
		}
		else {
			sb.append("vseb."+vru+";\r\n");
		}*/
		
		}
			else if (vru.indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),vru.substring(vru.indexOf("[F")+2,vru.indexOf("]"))));
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+getFormatReturn(imefile,vru.substring(0,vru.indexOf("(")),"rezu")+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
			}
	}
	
	
	
}












com.popultrade.model.TemplateGumbi vseeb =new com.popultrade.model.TemplateGumbi();
com.popultrade.dao.TemplateGumbiDAO daogumbi = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());

if (sif.getVeza_gumb()!=null) {
vseeb = daogumbi.getTemplateGumbi(sif.getVeza_gumb());


/// reset kje si na strani, ne dela dam v control, da mora resetat page
//sb.append("\r\nsession.setAttribute(\"pagenumber"+imefile +""+vseeb.getTemplatehead_id()+"\",\"1\");\r\n");
sb.append("\r\ncontrol.removePageNum=true;\r\n");
}






sb.append("}\r\n");


sb.append("if (rabiinsert.equals(\"\") && !bok) {\r\n");


/// dam v log
sb.append("if (vseb.getId()!=null) {");
if (nul.jeNull(sif.getLogall()).equals("1")) {	

	

	
sb.append("ConPool.addToNoSql((Object)vseb, ConPool, null, null, control, \"update "+imefile+"\");");
}
sb.append("}\r\n");
sb.append("else {\r\n");
if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql((Object)vseb, ConPool, null, null, control, \"insert "+imefile+"\");");
}




sb.append("}\r\n");

if (!nul.jeNull(sif.getNosql()).equals("1")) {
	
	

sb.append("dao.save"+imefile+"(vseb);\r\n");


}
else {
	
	
	/// za embeddable najdem starega, ga zbrisem nato shranim
	if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {
	
	
	sb.append("List gumx = vsebm.get"+sif.getHead_class_name_nosql()+"();\r\n");
	
	/// za embeddable dam unique id 
	
	sb.append("String idnox = nul.createID();\r\n");
	
	sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n");
	sb.append("Iterator itox=gumx.iterator();\r\n");
	sb.append("while (itox.hasNext()) {\r\n");
	sb.append("com.popultrade.model."+sif.getHead_class_name_nosql() +" modix = (com.popultrade.model."+sif.getHead_class_name_nosql() +")itox.next();\r\n");
	sb.append("if (modix.getId().equals(request.getParameter(\"id\"))) {\r\n");
//	sb.append("vseb = modix;\r\n");
	sb.append("idnox = modix.getId();\r\n");
	sb.append("gumx.remove(modix);\r\n");
	sb.append("break;\r\n");
	sb.append("}\r\n");
	sb.append("}\r\n");
	sb.append("}\r\n");
	

	sb.append("vseb.setId(idnox);\r\n");
	
	
	
	sb.append("gumx.add(vseb);\r\n");
	sb.append("vsebm.set"+sif.getHead_class_name_nosql()+"(gumx);\r\n");
	
	
	sb.append("dao.save"+imefile+"(vsebm,ConPool.getEntman());\r\n");	
	
	}
	else {
	
		
	sb.append("dao.save"+(nul.jeNull(sif.getHead_class_name_nosql()).equals("")?imefile:sif.getHead_class_name_nosql())+"(vseb,ConPool.getEntman());\r\n");	
	}
	
	
}


sb.append("nidd=vseb.getId()+\"\";\r\n");
sb.append("}\r\n");

//// funkcije ce so




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
}


///// dodatno java po save, se prepise isto kot je v textarea v modulu

if (!nul.jeNull(tuidd.getDodatno_java_updateinsert()).trim().equals("")) {
	sb.append("\r\n\r\n"+tuidd.getDodatno_java_updateinsert()+"\r\n");
}



//if (!nul.jeNull(tuidd.getDodatno_java_test()).trim().equals("")) {
//	sb.append("}\r\n");
//}
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1eee33335");


sb.append("}\r\n");
sb.append("}\r\n");



//// javascript kontrole




sb.append("Hashtable ht =new Hashtable();\r\n");
//sb.append("//ht.put(\"id\",\"id\");\r\n");
sb.append("Hashtable htn =new Hashtable();\r\n");
sb.append("Hashtable htnn =new Hashtable();\r\n");
//sb.append("//htn.put(\"kolicina\",\"kol_kg\");\r\n");
sb.append("Hashtable htd =new Hashtable();\r\n");

String dodatno_custom_kontrole="";
String dodatno_custom_kontrole_function="";
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15323232423");
boolean jenum = false;
boolean jenumm = false;

boolean jestr = false;
boolean jedat = false;


boolean jekontrola=false;


if (tempui.size()>0) {
Iterator termo = tempui.iterator();


while (termo.hasNext()) {
	com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)termo.next();
//	System.out.println(nul.jeNull(tu.getKontrola_javascript()) + "xxxxxxxxxxxxxxxxxxxxxxxxx "+tu.getId()+ " xxxxxxxxxxxxxxxxxxxxxx1133 ::: "+tu.getStolpec_metoda());
	/// dodaj kontrolo
	if (nul.jeNull(tu.getKontrola_javascript()).equals("DA")) {
		jekontrola=true;
		/// vrsta kontrole, numeric ali string ali datum
	//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx1122 ::: "+tu.getStolpec_metoda());
		if (meto.containsKey(tu.getStolpec_metoda())) {
		//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx11 ::: "+tu.getStolpec_metoda());
			if (meto.get(tu.getStolpec_metoda()).toString().indexOf("int")!=-1 ||meto.get(tu.getStolpec_metoda()).toString().indexOf("Integer")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Long")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Double")!=-1) {
				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				
				sb.append("htn.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				jenum = true;
			}
			else if (meto.get(tu.getStolpec_metoda()).toString().indexOf("Date")!=-1 ) {
				if (nul.jeNull(tu.getKontrola_javascript_pravilnost()).equals("1")) {
			
				sb.append("htd.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				}
				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				
				jestr = true;
				jedat = true;
			}
			else {
				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				jestr = true;	
			}
			
			
		}
		else {
			
	//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ::: "+tu.getStolpec_metoda());
			sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
			jestr = true;
		}
		
		
	}
	else if (nul.jeNull(tu.getKontrola_javascript_pravilnost()).equals("1")) {
			
				sb.append("htd.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				}
 	else if (nul.jeNull(tu.getKontrola_numericno()).equals("1")) { /////// v primeru da je samo kontrola da je vrednost numericna
 	jekontrola=true;
		if (meto.containsKey(nul.jeNull(tu.getStolpec_metoda())) && nul.jeNull(tu.getParameter_drugo_ime()).equals("")) {
    		//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx11 ::: "+tu.getStolpec_metoda());
    			if (meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("int")!=-1 ||meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("Integer")!=-1 || meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("Long")!=-1 || meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("Double")!=-1) {
    				//sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    					
    				sb.append("htnn.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    				jenumm = true;
    			}
    			
		}
		else if (!nul.jeNull(tu.getParameter_drugo_ime()).equals("")) {
		//	sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getParameter_drugo_ime()+"\");\r\n");	
		if (meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("int")!=-1 ||meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("Integer")!=-1 || meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("Long")!=-1 || meto.get(nul.jeNull(tu.getStolpec_metoda())).toString().indexOf("Double")!=-1) {
			jenumm = true;
			sb.append("htnn.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getParameter_drugo_ime().toLowerCase()+"\");\r\n");	
		}
		}
		
	}
	
	
	
	 if (nul.jeNull(tu.getDodatna_js_kontrola_uporabi()).equals("1")) { //// rocno vnesena kontrola , v primeru da je prevod se [ALERT] spremeni v alert s prevodom
		
		if (nul.jeNull(tu.getDodatna_js_kontrola()).indexOf("function")!=-1) {
			dodatno_custom_kontrole_function = dodatno_custom_kontrole_function + nul.jeNull(tu.getDodatna_js_kontrola()).replaceAll("\\[ALERT\\]","alert(\"<////%=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \")%////>\");\r\n");
				
		}
		else {
		dodatno_custom_kontrole = dodatno_custom_kontrole + nul.jeNull(tu.getDodatna_js_kontrola()).replaceAll("\\[ALERT\\]","alert(\"<////%=ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \")%////>\");\r\n");
		}
		jekontrola=true;
	}
	
	
	
    /// kontrola, ce ima se enega, za logiko dodatnega prikaza
    
    if (true) {
    	
    	//// 
    //	com.popultrade.dao.TemplateUiDAO dauid = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
    	
    //	com.popultrade.model.TemplateUi tuim = dauid.getTemplateUi(tu.getTemplateui_id().getId());
    
    	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx112442 ::: ");
    Iterator nexc = tu.getTemplateuis().iterator();
    
    while (nexc.hasNext()) {
    	com.popultrade.model.TemplateUi tuinext = (com.popultrade.model.TemplateUi)nexc.next();
    	
    	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx112442 ::: "+tuinext.getStolpec_metoda());
    	if (nul.jeNull(tuinext.getKontrola_javascript()).equals("DA")) {
    		jekontrola=true;
    		/// vrsta kontrole, numeric ali string ali datum
    		System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx112442 ::: "+tuinext.getStolpec_metoda());
    		if (meto.containsKey(nul.jeNull(tuinext.getStolpec_metoda())) && nul.jeNull(tuinext.getParameter_drugo_ime()).equals("")) {
    		//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx11 ::: "+tu.getStolpec_metoda());
    			if (meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("int")!=-1 ||meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Integer")!=-1 || meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Long")!=-1 || meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Double")!=-1) {
    				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    					
    				sb.append("htn.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    				jenum = true;
    			}
    			else if (meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Date")!=-1 ) {
    				if (nul.jeNull(tuinext.getKontrola_javascript_pravilnost()).equals("1")) {
    			
    				sb.append("htd.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    				}
    				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    				
    				jestr = true;
    				jedat = true;
    			}
    			else {
    				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    				jestr = true;	
    			}
    			
    			
    		}
    		else {
    			
    	//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ::: "+tu.getStolpec_metoda());
    	if (!nul.jeNull(tuinext.getParameter_drugo_ime()).equals("")) {
    			sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getParameter_drugo_ime()+"\");\r\n");	
    	}
    	else {
			sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getParameter_drugo_ime()+"\");\r\n");	
		    
    	}
    			jestr = true;
    		}
    		
    		
    	}
    	else 	if (nul.jeNull(tuinext.getKontrola_javascript_pravilnost()).equals("1")) {
    			
    				sb.append("htd.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
    				}
    	else if (nul.jeNull(tuinext.getKontrola_numericno()).equals("1")) { /////// v primeru da je samo kontrola da je vrednost numericna
    		if (meto.containsKey(nul.jeNull(tuinext.getStolpec_metoda())) && nul.jeNull(tuinext.getParameter_drugo_ime()).equals("")) {
        		//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx11 ::: "+tu.getStolpec_metoda());
        			if (meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("int")!=-1 ||meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Integer")!=-1 || meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Long")!=-1 || meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Double")!=-1) {
        				//sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
        					
        				sb.append("htnn.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
        				jenumm = true;
        			}
        			
        			
    		}
    		else if (!nul.jeNull(tuinext.getParameter_drugo_ime()).equals("")) {
    		//	sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getParameter_drugo_ime()+"\");\r\n");	
    		if (meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("int")!=-1 ||meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Integer")!=-1 || meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Long")!=-1 || meto.get(nul.jeNull(tuinext.getStolpec_metoda())).toString().indexOf("Double")!=-1) {
    			jenumm = true;
    			sb.append("htnn.put(\"\"+ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tuinext.getParameter_drugo_ime().toLowerCase()+"\");\r\n");	
    		}
    		}
    		jekontrola=true;
    	}
    	
    	
    	
    	 if (nul.jeNull(tuinext.getDodatna_js_kontrola_uporabi()).equals("1")) { //// rocno vnesena kontrola , v primeru da je prevod se [ALERT] spremeni v alert s prevodom
    		
    			if (nul.jeNull(tuinext.getDodatna_js_kontrola()).indexOf("function")!=-1) {
    				dodatno_custom_kontrole_function = dodatno_custom_kontrole_function + nul.jeNull(tuinext.getDodatna_js_kontrola()).replaceAll("\\[ALERT\\]","alert(\"<////%=ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \")%////>\");\r\n");
    					
    			}
    			else {
    		dodatno_custom_kontrole = dodatno_custom_kontrole + nul.jeNull(tuinext.getDodatna_js_kontrola()).replaceAll("\\[ALERT\\]","alert(\"<////%=ConPool.getPrevod(\""+tuinext.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \")%////>\");\r\n");
    			}
    			jekontrola=true;
    		
    	}
    }
    
    
    	
    	
    }
	
	
	
	
	
	
	
	
	
	
	
}
}


sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_java_rocno())+"\r\n");
sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_java_rocno2())+"\r\n");
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15dddd");
sb.append("%////>\r\n");

sb.append("<html><head><title>spreminjaj</title></head>\r\n");

sb.append("<style type=text/css>\r\n");
sb.append("@import \"barveold.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"js/uijs2/jquery-ui.css\";\r\n");
sb.append("@import \"ccss/custom.css\";\r\n");

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





sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"tooltip.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");




sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1");

if (jestr || jenum) {
sb.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
}
if (jenum) {
sb.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
}
if (jenumm) {
sb.append("<////%=javaScript.getControlsNumericValuesHashtableZNulo(\"document.dod\",htnn) %////>\r\n");
}
if (jedat) {
	sb.append("<////%=javaScript.getControlsDateValuesHashtable(\"document.dod\",htd) %////>\r\n");
	}
//sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"scripts/epoch_styles.css\">\r\n");
//sb.append("<script type=\"text/javascript\" src=\"scripts/epoch_classes.js\"></script>\r\n");
//	sb.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
//	sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
//sb.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");

sb.append("<link rel=\"stylesheet\" href=\"js/uijs2/jquery-ui.css\">\r\n");



sb.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
//sb.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");

sb.append("<script src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown
sb.append("<script src=\"scripts/jquery-migrate-3.0.0.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown

sb.append("<script language='javascript'  src=\"js/uijs2/jquery-ui.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
//loading overlay 
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"js/jquery.babypaunch.spinner.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"js/showOverlay.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");


sb.append("<body   "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"  onload=\"mom()\">\r\n");
//loading overlay okno
sb.append("<div id=\"spin\" style=\"z-index:9999\"></div>\r\n");
sb.append("<////%\r\n");

sb.append("String rezu=\"\";\r\n");
sb.append("////if (request.getParameter(\"akcijaXY\")==null) {\r\n");




sb.append("%////>\r\n");

sb.append("<form name='dod' id='dod' action=\""+imefile.toLowerCase() +"_edit"+sif.getId()+".jsp\" method=\"post\" "+(soFileInput?" enctype=\"multipart/form-data\"":"")+"   onSubmit=\""+(jekontrola?"return check()":"")+"\">\r\n");

sb.append("<////%\r\n");
sb.append("////if (vseb.getId()!=null && !vseb.getId().equals(\"\")) {\r\n");
if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql((Object)vseb, ConPool, null, null, control, \"view update "+imefile+"\");");
}
sb.append("%////>\r\n");
sb.append("<input type=hidden name=\"akcijaXY\" value=\"UPDATE\">\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("////else {\r\n");
if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql((Object)vseb, ConPool, null, null, control, \"view add "+imefile+"\");");
}
sb.append("%////>\r\n");
sb.append("<input type=hidden name=\"akcijaXY\" value=\"NEW\">\r\n");

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1x");

sb.append("<////%\r\n");

if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_java_default()!=null && !tuidd.getDodatno_java_default().equals("")) {
	
	
	String vru  = tuidd.getDodatno_java_default().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			if (splu[i].indexOf("[F")==-1) {
			//sb.append("vseb."+splu[i]+";\r\n");
			
			
			if (splu[i].trim().startsWith("set") ) {
				sb.append("vseb."+splu[i]+";\r\n");
			}
			else {
				sb.append(""+splu[i]+"\r\n");
			}
			
			}
			else if (splu[i].indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),splu[i].substring(splu[i].indexOf("[F")+2,splu[i].indexOf("]"))));
				
				
				
				sb.append("vseb."+splu[i].substring(0,splu[i].indexOf("'"))+getFormatReturn(imefile,splu[i].substring(0,splu[i].indexOf("(")),"rezu")+splu[i].substring(vru.lastIndexOf("'")+1,splu[i].length())+"\r\n");
				
				
			}
			}
		
		
		
	}
	else if (!vru.equals("")) {
		//sb.append("vseb."+vru+";\r\n");
		if (vru.indexOf("[F")==-1) {
			//sb.append("vseb."+vru+";\r\n");
			
			
			if (vru.trim().startsWith("set") ) {
				sb.append("vseb."+vru+";\r\n");
			}
			else {
				sb.append(""+vru+"\r\n");
			}
			
			
			}
			else if (vru.indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),vru.substring(vru.indexOf("[F")+2,vru.indexOf("]"))));
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+getFormatReturn(imefile,vru.substring(0,vru.indexOf("(")),"rezu")+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
			}
	}
	
	
	
}

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1x1");
sb.append("////}\r\n");
sb.append("%////>\r\n");
boolean zeid=false;
//// dam parametre, ki posljem preko requesta
 if (tgumb.getTemplateGumbiParametris()!=null && tgumb.getTemplateGumbiParametris().size()>0) {
	 
	 
	 Iterator iko = tgumb.getTemplateGumbiParametris().iterator();
	 
	 
	 while (iko.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)iko.next();
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("getParameter")!=-1) {
		
			 
			 if (nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("")) {
				 String dodaj = "";
				 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")!=-1) {
					dodaj =  nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"));	 
				 
				 }
				 
				 else if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")!=-1) {
						dodaj =  nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\""));	 
						  
				 }
				 else {
					 dodaj =  nul.jeNull(tgpp.getStolpec_metoda());
				 }
				 
				 if (dodaj.equals("id")) {
					 zeid=true;
				 }
				 
				 sb.append("<input type=hidden name=\""+dodaj+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","\"")+")%////>\">\r\n");
					
			 
			 }
			 else {
				// parametri = parametri + "&"+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
				 sb.append("<input type=hidden name=\""+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\"))%////>\">\r\n");
						
				 if (nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("id")) {
					 zeid=true;
				 }
				 
			 }
			 
			 
			
		 }
		 
		 else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
		 sb.append("<input type=hidden name=\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\"))%////>\">\r\n");
		 }
	 }
	 
	 
	 
 }

 System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII1x2");
 if (sif.getTemplatePPs()!=null && sif.getTemplatePPs().size()>0) {
	 
	 
		Iterator itf = sif.getTemplatePPs().iterator();
		
		while (itf.hasNext()) {
			com.popultrade.model.TemplatePP tpp = (com.popultrade.model.TemplatePP)itf.next();
			if (tpp.getRazlicno_ime_inputa()!=null && !nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")) {
				
				sb.append("<////%\r\n");
				sb.append("////if (nul.jeNull(vseb.getId()+\"\").equals(\"\")) {\r\n");
				sb.append("%////>\r\n");
				if (tpp.getStolpec_metoda().indexOf("request.getParameter")!=-1) {
					 //sb.append("<input type=hidden name=\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>\">\r\n");
						
			
				}
				else {
			 sb.append("<input type=hidden name=\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\"))%////>\">\r\n");
				}
			 sb.append("<////%\r\n");
			 sb.append("////}\r\n");
			 sb.append("%////>\r\n");
			}
		
			
		}
	 
 }

 
 if (!zeid) {
sb.append("<input type=hidden name=\"id\" value=\"<////%=nul.jeNull(vseb.getId()+\"\")%////>\">\r\n");
 }



sb.append("<table border=\"0\" cellspacing=\"1\" class=\"fonti\"  width=\"100%\"  ><tr><td colspan=\"4\" class=\"opiscell\">&nbsp;</td></tr>\r\n");


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII12");
StringBuffer hintpomoc = new StringBuffer();
if (tempui.size()>0) {
	Iterator itmo = tempui.iterator();
	
	
	
	while (true) {
			
		boolean prikaz=false;
		String premo = "";
		String premoe = "";
		if (itmo.hasNext()) {
			
			com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)itmo.next();
			/// ce je polje prazno
			if (nul.jeNull(tu.getTip_polja()).equals("PR")) {
				
				if (!nul.jeNull(tu.getDpogojprikazg()).equals("")) {
					premo = premo + "<////%\r\n"+tu.getDpogojprikazg()+"\r\n%////>\r\n";
					prikaz=true;
					}
				premoe=premoe+"<tr>";
					  
		        premoe=premoe+"<td class=\""+(nul.jeNull(ConPool.getPrevod(tu.getId()+"P"+control.getJezik())).equals("")?"valuecell":"opiscell")+"\" COLLSPANN  >< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>&nbsp;</td>";
  		 
		        
				
			}
			else {
		
				if (!nul.jeNull(tu.getDpogojprikazg()).equals("")) {
					premo = premo + "<////%\r\n"+tu.getDpogojprikazg()+"\r\n%////>\r\n";
					prikaz=true;
					}
				premo = premo + "<tr>";
      		  	String hintp = "";
      		  	String dodcss = "";
      		  	String dodcssv = "";
      		  	
      		  	
      		  	
				 if (nul.jeNull(tu.getHint_pomoc()).equals("1")) {
				     	hintpomoc.append("<span id='Q"+tu.getId()+"' style='display:none;'>< %=ConPool.getPrevod(\""+tu.getId()+"Q\"+control.getJezik()).replaceAll(\"_\",\" \").replaceAll(\"\\n\",\"<br>\").replaceAll(\"\\\"\",\"'\") %////></span>\r\n");
					hintp = "<a href=\"\" tabindex=\"-1\" style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\"  onmouseout=\"hideddrivetip()\" onclick=\"ddrivetip(document.getElementById('Q"+tu.getId()+"').innerHTML);return false;\">";
						 }
				 
				 if (!nul.jeNull(tu.getCss_translation()).equals("")) {
				 dodcss = "<div class='"+tu.getCss_translation()+"'>";
				 }
				
				 if (!nul.jeNull(tu.getCss_value()).equals("")) {
					 dodcssv = "<div class='"+tu.getCss_value()+"'>";
					 }
			
				
		        premo = premo + "<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">"+dodcss+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+(dodcss.equals("")?"":"</div>")+"</td><td class=\"valuecell\" COLLSPANN>";
		            
		        premo = premo + dodcssv;
		        
		        if (nul.jeN(sif.getHead_class_name_nosql()).equals("") ) {
		        premo = premo + genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name());
		        }
		        else {
		        	  premo = premo + genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name_nosql());
				      
		        }
		        
		        	if (dodcssv.equals("")) {
		        		 premo = premo + "</div>";
		        	}
		        
		        /// kontrola, ce ima se enega, za logiko dodatnega prikaza
		        
		        if (true) {
		        	
		        	//// 
		        //	com.popultrade.dao.TemplateUiDAO dauid = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		        	
		        //	com.popultrade.model.TemplateUi tuim = dauid.getTemplateUi(tu.getTemplateui_id().getId());
		        
		        
		        Iterator nexc = tu.getTemplateuis().iterator();
		        
		        while (nexc.hasNext()) {
		        	com.popultrade.model.TemplateUi tuinext = (com.popultrade.model.TemplateUi)nexc.next();
		        	//premo = premo + " < %=ConPool.getPrevod(\""+tuinext.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ";
		        	///
		        //	premo = premo + genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name());
		        	dodcssv="";
		        		 if (!nul.jeNull(tuinext.getCss_value()).equals("")) {
					 dodcssv = "<div class='"+tuinext.getCss_value()+"'>";
					 }
		        	
		        	
		            if (nul.jeN(sif.getHead_class_name_nosql()).equals("") ) {
				        premo = premo + genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name());
				        }
				        else {
				        	  premo = premo + genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name_nosql());
						      
				        }
		        	
		         	if (dodcssv.equals("")) {
		        		 premo = premo + "</div>";
		        	}
		        	
		        	
		        }
		        
		        
		        	
		        	
		        }
		        
		        
		        
		        premo = premo + "</td>";
		        
		        
		      if (!nul.jeNull(tu.getDpogojprikazg()).equals("")) {
		        //    premo = premo + "<////%}\r\nelse {\r\n%////>\r\n<td class=\"opiscell\" colspan=2 ></td>\r\n<////%\r\n}\r\n%////>";
		        }
		       
            		  
        
		}
		}
		else {
			break;
		}
		if (itmo.hasNext()) {
			com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)itmo.next();
			String dodcss="";
			 if (!nul.jeNull(tu.getCss_translation()).equals("")) {
				 dodcss = "<div class='"+tu.getCss_translation()+"'>";
				 }
			/// ce je polje prazno
			if (nul.jeNull(tu.getTip_polja()).equals("PR")) {
				if (!premoe.equals("")) {
			
					
					if (!nul.jeNull(ConPool.getPrevod(tu.getId()+"P"+control.getJezik())).equals("")) {
						sb.append(premoe.replaceAll("COLLSPANN","colspan=\"2\"")+"<td class=\"opiscell\" colspan='2'  >"+dodcss+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(dodcss.equals("")?"":"</div>")+"&nbsp;</td></tr>\r\n");
					}
					else {
				sb.append(premoe.replaceAll("COLLSPANN","colspan=\"4\"")+"</tr>\r\n");
					}
				
				
				}
				else if (!premo.equals("")) {
					
					sb.append(premo.replaceAll("COLLSPANN"," colspan=\"3\"")+"</tr>\r\n");
						
				}
				
				
				if (prikaz) {
				
					sb.append("<%}\r\n%////>");
				}
				
				
			}
			else {
				if (!premoe.equals("")) {
					
					sb.append(premoe.replaceAll("COLLSPANN","colspan=\"2\"")+"\r\n");
					
					}
					else if (!premo.equals("")) {
						
						sb.append(premo.replaceAll("COLLSPANN"," width=\"30%\" ")+"\r\n");
							
					}
				
			  	String hintp = "";
				 if (nul.jeNull(tu.getHint_pomoc()).equals("1")) {
			        	hintpomoc.append("<span id='Q"+tu.getId()+"' style='display:none;'>< %=ConPool.getPrevod(\""+tu.getId()+"Q\"+control.getJezik()).replaceAll(\"_\",\" \").replaceAll(\"\\n\",\"<br>\").replaceAll(\"\\\"\",\"'\") %////></span>\r\n");
			        hintp = "<a href=\"\" tabindex=\"-1\" style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\"  onmouseout=\"hideddrivetip()\" onclick=\"ddrivetip(document.getElementById('Q"+tu.getId()+"').innerHTML);return false;\">";
				 }
				 
				 	if (!nul.jeNull(tu.getDpogojprikazg()).equals("")) {
				sb.append("<////%\r\n"+tu.getDpogojprikazg()+"\r\n%////>\r\n");
				}
				 
					 dodcss="";
					 if (!nul.jeNull(tu.getCss_translation()).equals("")) {
						 dodcss = "<div class='"+tu.getCss_translation()+"'>";
						 }
				 	
				 	
				sb.append("<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">"+dodcss+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+(dodcss.equals("")?"":"</div>")+"</td><td class=\"valuecell\" width=\"30%\">\r\n");
		
				
				//sb.append(genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));
		        	String dodcssv="";
		        		 if (!nul.jeNull(tu.getCss_value()).equals("")) {
					 dodcssv = "<div class='"+tu.getCss_value()+"'>";
					 }
				
		        		 sb.append(dodcssv);
	            if (nul.jeN(sif.getHead_class_name_nosql()).equals("") ) {
	            	sb.append(genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));
			        }
			        else {
			        	sb.append(genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name_nosql()));
					      
			        }
				if (!dodcssv.equals("")) {
		        sb.append("</div>");
				}
		        /// kontrola, ce ima se enega, za logiko dodatnega prikaza
		        
		        if (true) {
		        	
		        	//// 
		        //	com.popultrade.dao.TemplateUiDAO dauid = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		        	
		        //	com.popultrade.model.TemplateUi tuim = dauid.getTemplateUi(tu.getTemplateui_id().getId());
		        
		        
		        Iterator nexc = tu.getTemplateuis().iterator();
		        
		        while (nexc.hasNext()) {
		        	com.popultrade.model.TemplateUi tuinext = (com.popultrade.model.TemplateUi)nexc.next();
		        	dodcssv="";
	        		 if (!nul.jeNull(tuinext.getCss_value()).equals("")) {
				 dodcssv = "<div class='"+tuinext.getCss_value()+"'>";
				 }
	        		 
	        		 sb.append(dodcssv);
		        //	sb.append(" < %=ConPool.getPrevod(\""+tuinext.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ");
		        	//sb.append(genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name()));
		        	
		            if (nul.jeN(sif.getHead_class_name_nosql()).equals("") ) {
		            	sb.append(genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name()));
				        }
				        else {
				        	sb.append(genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name_nosql()));
						      
				        }
		        	
		        	if (!dodcssv.equals("")) {
				        sb.append("</div>");
						}
		        	
		        }
		        
		        
		        	
		        	
		        }
				
				
				
				
				
				
				
sb.append("</td>\r\n");


      if (!nul.jeNull(tu.getDpogojprikazg()).equals("")) {
		        //    sb.append("<////%}\r\nelse {\r\n%////>\r\n<td class=\"opiscell\" colspan=2 ></td>\r\n<////%}\r\n\r\n%////>\r\n");
		        }




sb.append("</tr>\r\n");
		

if (prikaz) {
	
	sb.append("<%}\r\n%////>");
	
	}


			}
	
		
		}
		else {
			break;
		}
	
	
	}
	
	
	
	
}

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII13");


if (!nul.jeN(tuidd.getDodatno_html()).equals("")) {
	
	sb.append(tuidd.getDodatno_html());
}
if (!nul.jeN(tuidd.getDodatno_html2()).equals("")) {
	
	sb.append(tuidd.getDodatno_html2());
}

	sb.append("<tr><td colspan=\"4\" class=\"opiscell\" align=\"center\"><input id=\"submitbutton\"  type=submit value=\"< %=ConPool.getPrevod(\""+idpr+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  class=\"fontisubmit\"> &nbsp;</td></tr></table></form>\r\n");
	sb.append(hintpomoc.toString());
	sb.append("<script language='javascript'>\r\n");


	/// append logiko klicanja dropdown po kliku na potrdi

	
	if (sbaj.toString().length()>0) {
	
		
		
		
		sb.append("function setLat(lokat,fnames) {\r\n");
			sb.append("xmlHttp=GetXmlHttpObject();\r\n");
			sb.append("if (xmlHttp==null) {\r\n");
			sb.append("alert (\"Browser does not support HTTP Request\");\r\n");
			sb.append("return false;\r\n");
			sb.append("} \r\n");
			sb.append("var url=lokat;\r\n");
			//sb.append("url=url+\"?vezamap=\"+encodeURIComponent(document.dod.veza_map.value)+\"&usp_oznnar=9999\";\r\n");
			sb.append("url=url+\"&sid=\"+Math.random();\r\n");
			sb.append("xmlHttp.open(\"GET\",url,false);\r\n");
			sb.append("xmlHttp.send(null);\r\n");
			sb.append("if (xmlHttp.responseText.indexOf(\"###\")!=-1) {\r\n");
			sb.append("if (xmlHttp.responseText.split(\"###\").length==2) {\r\n");
			sb.append("var kom=xmlHttp.responseText.substring(0,xmlHttp.responseText.lastIndexOf(\"###\"));\r\n");
			
			
			sb.append("var rezu = kom.split(\" ___ \");\r\n");
			
			sb.append("var fnam = fnames.split(\" ___ \");\r\n");
			
			sb.append("for (k=0;k<fnam.length;k++) {\r\n");
			
			
			sb.append("document.getElementById(fnam[k]).value=rezu[k];\r\n");

			sb.append("}\r\n");
			sb.append("}\r\n");
			
			sb.append("}\r\n");
			sb.append("else {\r\n");
				sb.append("return false;\r\n");
			sb.append("}\r\n");
			sb.append("return true;\r\n");
			sb.append("}\r\n");

		
		
		
		
		
	}
	
	
	sb.append("function setDD() {\r\n");
	
	
	
	
	
	sb.append(sbaj.toString()+"\r\n");
	sb.append("}\r\n\r\n");
	


sb.append(dodatno_custom_kontrole_function+"\r\n");
sb.append(this.getKontrolaAjaxJS()+ "\r\n");
sb.append("\r\nfunction custom() {\r\n");



sb.append(this.getKontrolaAjaxJSf()+ "\r\n");

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII13x");
this.kontrolaAjaxJS="";
this.kontrolaAjaxJSf="";

sb.append(dodatno_custom_kontrole+"\r\n");

if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_javascript()!=null && !tuidd.getDodatno_javascript().equals("")) {

	
	sb.append(tuidd.getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
	
	
}
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII13x2");

/// dam vse v velike crke

if (tempui.size()>0) {
	Iterator itmo = tempui.iterator();
	
	while (itmo.hasNext()) {
		
		com.popultrade.model.TemplateUi tuii = (com.popultrade.model.TemplateUi)itmo.next();
		
		if (nul.jeNull(tuii.getSamo_velike_crke()).equals("1")) {
			
			
		String pass = (nul.jeNull(tuii.getParameter_drugo_ime()).equals("")?tuii.getStolpec_metoda().toLowerCase().replaceAll("get",""):tuii.getParameter_drugo_ime().toLowerCase().replaceAll("get",""));	
		
			sb.append("document.dod."+pass+".value=document.dod."+pass+".value.toUpperCase();\r\n");	
			
		}
		
		
	}
	
	
}
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII13x3");
sb.append("document.dod.submitbutton.disabled=true;\r\n");


//sb.append("top.resetPageBlockAll();\r\n");

sb.append("setPageBlock();\r\n");

sb.append("return true;\r\n");
sb.append("}\r\n");



sb.append("function KeyCheck(event)");
sb.append("{\r\n");

sb.append("if ( typeof event == \"undefined\" ) event = window.event;\r\n");

sb.append("var KeyID = event.keyCode;\r\n");

sb.append("if (KeyID==9 )");
sb.append("{\r\n");
sb.append("if (window.setAll){\r\n");
sb.append("setAll();\r\n");

sb.append("}\r\n");
sb.append("}\r\n");
   
sb.append("}\r\n");

sb.append("function Focusie()");
sb.append("{\r\n");


//sb.append("alert(1);\r\n");
//sb.append("if (KeyID==9 )");
//sb.append("{\r\n");
sb.append("if (window.setAll){\r\n");
sb.append("setAll();\r\n");

sb.append("}\r\n");
//sb.append("}\r\n");
   
sb.append("}\r\n");


sb.append("function KeyCheckMouse(e)");
sb.append("{\r\n");


sb.append("var KeyID = e.keyCode;\r\n");
//sb.append("if (KeyID==9 )");
//sb.append("{\r\n");
sb.append("if (window.setAll){\r\n");
sb.append("setAll();\r\n");

sb.append("}\r\n");
//sb.append("}\r\n");
   
sb.append("}\r\n");

if (tuidd.getDodatno_javascript_funkcije()!=null) {
	
	sb.append(tuidd.getDodatno_javascript_funkcije().replaceAll("\n","\r\n")+"\r\n");
	sb.append(nul.jeNull(tuidd.getDodatno_javascript2()).replaceAll("\n","\r\n")+"\r\n");
	
}

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII13x4");

sb.append("function mom() {\r\n");

//sb.append("top.resetPageBlockAll();\r\n");

sb.append("resetLoadingOverlay();\r\n");


sb.append("<////%if (bok) {%////>\r\n");  
sb.append("alert('<////%=napaka%////>');\r\n");  
sb.append("<////%}%////>\r\n");  




//sb.append("document.addEventListener(\"keypress\",KeyCheck,true);\r\n"); 
//sb.append("document.addEventListener(\"onclick\",KeyCheckMouse,true);\r\n"); 
/*

sb.append("if (document.addEventListener){ ;\r\n");
sb.append("document.addEventListener('keypress', KeyCheck, false); ;\r\n");
sb.append("document.addEventListener('onclick',KeyCheckMouse,true);;\r\n");
sb.append("} else if (document.attachEvent){ ;\r\n");
sb.append("document.attachEvent('onkeypress', KeyCheck); ;\r\n");
sb.append("document.attachEvent('onclick', KeyCheckMouse); ;\r\n");

sb.append("} ;\r\n");
*/

//sb.append("document.onclick = KeyCheckMouse;\r\n");

if (tuidd.getDodatno_javascript_onload()!=null) {
	
	sb.append(tuidd.getDodatno_javascript_onload().replaceAll("\n","\r\n")+"\r\n");
	
}


sb.append(dodaj_datum+"\r\n");


if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}


sb.append("<////%\r\n");
sb.append("////if (request.getParameter(\"akcijaXY\")==null) {\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");
sb.append("top.window.hideFrame();\r\n");
sb.append("}\r\n");

sb.append("</script>\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");

sb.append("////else {\r\n");

//// opcija za update recordov z vrednostmi, ce insert ali update
if (nul.jeN(sif.getZakleni_record()).equals("")) {

sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,nidd+\"\",new Date(),akcij,\""+imefile+"\",control.getUserName(),"+(nul.jeNull(sif.getPrisotnost_polje_kontrola()).equals("")?"\"\"":"sif.getPrisotnost_polje_kontrola()")+",\""+imefile+"_edit"+sif.getId()+"\");\r\n");
}
else {
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,nidd+\"\",new Date(),akcij,\""+imefile+"\",control.getUserName(),"+(nul.jeNull(sif.getPrisotnost_polje_kontrola()).equals("")?"\"\"":"sif.getPrisotnost_polje_kontrola()")+",\""+imefile+"_edit"+sif.getId()+"\");\r\n");

}


sb.append("%////>\r\n");

sb.append("<table border=\"0\" cellspacing=\"1\"  class=\"fonti\"  width=\"100%\" >\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
sb.append("<p align=\"center\">< %=ConPool.getPrevod(\""+idpr+"X\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");

Iterator igy = tgumb.getTemplateGumbiParametris().iterator();

String parametri = "";
boolean prv = false;
while (igy.hasNext()) {
	 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)igy.next();
	 String ehn = "&";
	 if (!prv) {
		// ehn = "?"; 
		 prv=true;
	 }
	 
	 
	 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
		 
		 
		 String dodaj = "";
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")!=-1) {
			dodaj =  nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"));	 
		 
		 }
		 else if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")!=-1) {
				dodaj =  nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\""));	 
				  
		 }
		 else {
			 dodaj =  nul.jeNull(tgpp.getStolpec_metoda());
		 }
		 
		 
	 
		 parametri = parametri + ehn+dodaj+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 
	 }
	 else if (!nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")) {
	 
	 	parametri = parametri + ehn + tgpp.getDugacno_ime_parametra()+"="+nul.jeNull(tgpp.getStolpec_metoda());
	 
	 }
	 
}
sb.append("<script language=javascript>\r\n");


sb.append("function mom() {\r\n");

sb.append("resetLoadingOverlay();\r\n");

//sb.append("top.resetPageBlockAll();\r\n");


sb.append("<////%if (bok) {%////>\r\n");  
sb.append("alert('<////%=napaka%////>');\r\n");  
sb.append("<////%}%////>\r\n");  
sb.append("}\r\n");

if (!nul.jeNull(sif.getUporabi_count_ld()).equals("1")) { /// ce uporabim refresh pri update

sb.append("var mon = "+sif.getTarget_funkcija()+"+\"\";\r\n");

sb.append("<////%\r\n");
sb.append("////if (request.getParameter(\"akcijaXY\")!=null && !request.getParameter(\"akcijaXY\").equals(\"NEW\")) {\r\n");
sb.append("%////>\r\n");
sb.append("if (mon.indexOf(\"idback\")!=-1) {\r\n");
sb.append("if (mon.indexOf(\"?\")==-1) {\r\n");
sb.append(""+sif.getTarget_funkcija()+" = mon.substring(0,mon.indexOf(\"idback\")-1)+\"?idback=<////%=request.getParameter(\"id\")%////>"+parametri+"\";\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append(""+sif.getTarget_funkcija()+" = mon.substring(0,mon.indexOf(\"idback\"))+\"idback=<////%=request.getParameter(\"id\")%////>"+parametri+"\";\r\n");

sb.append("}\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("if (mon.indexOf(\"?\")!=-1) {\r\n");
sb.append("if (mon.indexOf(\"id=\")!=-1) {\r\n");
sb.append(""+sif.getTarget_funkcija()+" = mon.substring(0,mon.indexOf(\"?\")+1) + \"?idback=<////%=request.getParameter(\"id\")%////>"+parametri+"\";\r\n");
     
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append(""+sif.getTarget_funkcija()+" = "+sif.getTarget_funkcija()+" + \"&idback=<////%=request.getParameter(\"id\")%////>"+parametri+"\";\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append(""+sif.getTarget_funkcija()+" ="+sif.getTarget_funkcija()+" + \"?idback=<////%=request.getParameter(\"id\")%////>"+parametri+"\";\r\n");

sb.append("}\r\n");
sb.append("}\r\n"); 
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("////else {\r\n");
sb.append("%////>\r\n");
sb.append("if (mon.indexOf(\"DELETE\")!=-1) {\r\n");
    
sb.append(""+sif.getTarget_funkcija()+" = mon.replace(\"akcijaXY=DELETE\",\"\");\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
    
sb.append(""+sif.getTarget_funkcija()+" = "+sif.getTarget_funkcija()+";\r\n");
sb.append("}\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");

}

sb.append("</script>\r\n");

sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("////}\r\n");
sb.append("////else {\r\n");
sb.append("%////>\r\n");
sb.append("<html><head><title>spreminjaj</title></head>\r\n");

sb.append("<style type=text/css>\r\n");
sb.append("@import \"barveold.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"js/uijs2/jquery-ui.css\";\r\n");
////grafika oz barve
sb.append("@import \"ccss/custom.css\";\r\n");

if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
sb.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
}
else {

sb.append("@import \"barveblue.css\";\r\n");	
}
sb.append("</style>\r\n");
sb.append("<table border=\"0\" cellspacing=\"1\"  class=\"fonti\"   width=\"100%\" >\r\n");
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
	
	 jenum = false;
	 jestr = false;
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
	sb.append("</style>\r\n");
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
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" id='dod' name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_edit"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\">\r\n");
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
		
	/*	while (ikov.hasNext()) {
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
	pp.append("\r\nfunction custom() {\r\n");

//	if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_javascript()!=null) {
	//	pp.append(sif.getTemplateUiDodatno().getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
//	}

	pp.append("return true;\r\n");
	
	pp.append("}\r\n");
	
	
	if (!jekontrola) {
		pp.append("\r\nfunction check() {\r\n");
		pp.append("}\r\n");
		}
	
	pp.append("\r\nfunction mom() {\r\n");
	//pp.append("top.window.hideFrame();\r\n");
	pp.append("resetLoadingOverlay();\r\n");

	//pp.append("top.resetPageBlockAll();\r\n");

	if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		pp.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}
	
	
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

	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_edit"+sif.getId()+"_p"+".jsp"), "latin1"));



	out3.write(pp.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
}




// reset rich text format logic
this.jertf=false;


imefile = imefile+"_edit"+sif.getId();


}
////konec kreacije jsp za update/insert
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
