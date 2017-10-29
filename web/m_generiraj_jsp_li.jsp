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


/// dobim loop za embeddable za zdaj le 3 stopnje, kasneje ce se rabi avtomatika na n moznosti

public String getEmbeddableLoop(com.popultrade.model.TemplateHead sif,int embo,String imefile2) {
	
	StringBuffer sbc = new StringBuffer();
	
	sbc.append("while (itox.hasNext()) {\r\n");
	sbc.append("com.popultrade.model."+sif.getHead_class_name_nosql() +" modix = (com.popultrade.model."+sif.getHead_class_name_nosql() +")itox.next();\r\n");
	if (nul.jeNull(sif.getHead_class_name_nosql2()).equals("")) {
	sbc.append("if (modix.getId().equals(request.getParameter(\"id\"))) {\r\n");
	}
	else {
		sbc.append("if (modix.getId().equals(request.getParameter(\"idem2\"))) {\r\n");
	}
//	sb.append("vseb = modix;\r\n");
	//sb.append("idnox = modix.getId();\r\n");
	
	if (!nul.jeNull(sif.getHead_class_name_nosql2()).equals("")) { //// loop stopnje 2
		
		
		sbc.append("List gumx2 = modix.get"+sif.getHead_class_name_nosql2()+"();\r\n");

		sbc.append("Iterator itox2=gumx2.iterator();\r\n");
		sbc.append("while (itox2.hasNext()) {\r\n");
		sbc.append("com.popultrade.model."+sif.getHead_class_name_nosql2() +" modix2 = (com.popultrade.model."+sif.getHead_class_name_nosql2() +")itox2.next();\r\n");
		
		if (nul.jeNull(sif.getHead_class_name_nosql3()).equals("")) {
			sbc.append("if (modix2.getId().equals(request.getParameter(\"id\"))) {\r\n");
			}
			else {
				sbc.append("if (modix2.getId().equals(request.getParameter(\"idem3\"))) {\r\n");
			}
		
		if (!nul.jeNull(sif.getHead_class_name_nosql3()).equals("")) { //// loop stopnje 3
			
			sbc.append("List gumx3 = modix2.get"+sif.getHead_class_name_nosql3()+"();\r\n");

			sbc.append("Iterator itox3=gumx2.iterator();\r\n");
			sbc.append("while (itox3.hasNext()) {\r\n");
			sbc.append("com.popultrade.model."+sif.getHead_class_name_nosql3() +" modix3 = (com.popultrade.model."+sif.getHead_class_name_nosql3() +")itox3.next();\r\n");
			
			sbc.append("if (modix3.getId().equals(request.getParameter(\"id\"))) {\r\n");
			
			sbc.append("gumx3.remove(modix3);\r\n");
			sbc.append("break;\r\n");
			sbc.append("}\r\n");
			sbc.append("}\r\n");
			
		}//// konec loop stopnje 3
		else {
			sbc.append("gumx2.remove(modix2);\r\n");
			sbc.append("break;\r\n");
			}
		
		
		sbc.append("}\r\n");
		sbc.append("}\r\n");
		
	}//// konec loop stopnje 2
	else {
	sbc.append("gumx.remove(modix);\r\n");
	sbc.append("break;\r\n");
	
	}
	sbc.append("}\r\n");
	//if (nul.jeNull(sif.getHead_class_name_nosql2()).equals("")) {
	//sbc.append("}\r\n");
	//}
	
	sbc.append("}\r\n");
	
	
	return sbc.toString();
	
}





public String getEmbeddableTree(com.popultrade.model.TemplateHead sif,int embo) {
	
	 String parametri="";
	 
	 
	 
	 if (!nul.jeN(sif.getHead_class_name_nosql()).equals("") || (nul.jeN(sif.getNosql()).equals("1") && embo==1)) {
		 
		 if ((nul.jeN(sif.getNosql()).equals("1") && embo==1)) {
			 parametri = parametri + "&idem=<////%=vseb.getId()%////>";
		 }
		 else {
		 parametri = parametri + "&idem=<////%=request.getParameter(\"idem\")%////>";
		 }
	 }
	if (!nul.jeN(sif.getHead_class_name_nosql2()).equals("")) {
		 
		 parametri = parametri + "&idem2=<////%=request.getParameter(\"idem2\")%////>";
		 
	 }
	if (!nul.jeN(sif.getHead_class_name_nosql3()).equals("")) {
		 
		 parametri = parametri + "&idem3=<////%=request.getParameter(\"idem3\")%////>";
		 
	 }
	
	return parametri;
	
}





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



private String genListExcel(String idpr,String order_by,String order_by_smer,String imefile,com.popultrade.model.TemplateHead sif,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext) {
	
	try {

	StringBuffer sbl = new StringBuffer();
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1");
	sbl.append("<////%@ page contentType=\"text/html; \" import=\"org.apache.poi.ss.usermodel.FontCharset,javax.mail.*,javax.mail.internet.*,javax.activation.*,org.apache.poi.ss.usermodel.Sheet,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.apache.poi.hssf.usermodel.HSSFWorkbook,org.apache.poi.hssf.usermodel.HSSFSheet,org.apache.poi.hssf.usermodel.HSSFRow,org.apache.poi.hssf.usermodel.HSSFCell,org.apache.poi.hssf.usermodel.HSSFCellStyle,org.apache.poi.hssf.usermodel.HSSFFont,org.apache.poi.hssf.usermodel.*,org.apache.poi.hssf.util.HSSFColor,java.util.Hashtable,java.util.Date,java.net.URLDecoder\"%////>\r\n");
	sbl.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
	sbl.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
	sbl.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
	sbl.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");

///// dodatni pogoji, v javi
com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();

com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",servletContext);

tuidd = daouid.getTemplateUiDodatnos(idpr);

	sbl.append("<////%\r\n");
	sbl.append("////request.setCharacterEncoding(control.encoding);\r\n");
	sbl.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
	sbl.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
	sbl.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
	sbl.append("////response.addDateHeader(\"Expires\", 0);\r\n");
	sbl.append("////if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
	sbl.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
	sbl.append("////}\r\n");
	sbl.append("%////>\r\n");
	sbl.append("<////%\r\n");

	sbl.append("// stevilo prikazov vrstic\r\n");

	sbl.append("int stpri = control.st_vrstic;\r\n");
	sbl.append("StringBuffer outt = new StringBuffer();\r\n");
	// get list from daoobject
	sbl.append("com.popultrade.dao."+imefile +"DAO dao = (com.popultrade.dao."+imefile +"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length()) +"DAO\",pageContext.getServletContext());\r\n");

	// steje stevilo vrstic
	sbl.append("int stej = 0;\r\n");

	// barve vrstic
	sbl.append("String[] colors = {\"plava1\",\"plava2\",\"silver\"};\r\n");


sbl.append("String izpis  = \"XSL_\" +control.getUser()+\"\"+(nul.getDatumFormat(\"HHmmsss\"))+\".xls\";\r\n");


	// stevilo vrstic
	sbl.append("int stvrstic=0;\r\n"); 

	
	



			sbl.append("try {\r\n");
	if (!nul.jeNull(tuidd.getDodatno_update()).equals("")) {
		sbl.append(nul.jeNull(tuidd.getDodatno_update())+"\r\n");
		}
	
	
	
	


			System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 2");

	sbl.append("String orderby = \""+order_by+"\";\r\n");
	sbl.append("String orderbysmer = \""+order_by_smer+"\";\r\n");

	sbl.append("String dodpog = \"\";\r\n");


	sbl.append("com.popultrade.model."+imefile +" sif = new com.popultrade.model."+imefile +"();\r\n");


	//// setam pogoje za sif
String	dodaten_sql_pogoj = "";

	if (sif.getTemplateClasss().size()>0) {
		
		
		Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,servletContext,imefile);
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
			//sbl.append("sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n");	
		}
		else {
			
		sbl.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
		//sbl.append("sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
		sbl.append(" }\r\n");
		
		}
		
		}
		else {
			
			if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
			sbl.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
			}
			if (!sem  ) {
				dodaten_sql_pogoj = nul.jeNull(tcc.getDodaten_hql_pogoj()) ;
				sem=true;
				}
				else {
					dodaten_sql_pogoj =  "  "+nul.jeNull(tcc.getDodaten_hql_pogoj());
				}
				sbl.append("dodpog += (!dodpog.equals(\"\")?\" and \":\"\")+ \""+dodaten_sql_pogoj+"\";\r\n");
				
			
			if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
			sbl.append(" }\r\n");
			}
		}
		
		}
		
		
	}

	
	
	
	
	
	
	

	sbl.append("String dodaten_sql_pogoj = dodpog;\r\n");
////dobim searche za like katere ne upostevam potem za navaden search
sbl.append("String sedodatno = \"\";\r\n");
sbl.append("String metodo = \"\";\r\n");

com.popultrade.dao.TemplateSearchDAO daose = (com.popultrade.dao.TemplateSearchDAO)contextUtil.getBeanDao("templateSearchDAO",servletContext);
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
		
	String uplow = "";
		
		if  (nul.jeNull(si.getSeupper()).equals("1")) {
		uplo=".toUpperCase()";
		uplow = "Upper(";
		}
		if  (nul.jeNull(si.getSelower()).equals("1")) {
		uplo=".toLowerCase()";
		uplow = "Lower(";
		}
		
		
		
		sbl.append("if (!nul.jeNull(request.getParameter(\""+metod+"\")).equals(\"\")) {\r\n");
		//sb.append("metodo=	\" "+uplow+metod+(uplow.equals("")?"":")")+"\""+URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+metod+"\"))"+(uplo)+")+\"\", \"UTF-8\")+\""+(desno)+"' and \";\r\n");
		sbl.append("metodo=	\" "+uplow+metod+(uplow.equals("")?"":")")+" like '"+(levo)+"\"+nul.jeNullEscapeSQL(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+metod+"\"))"+(uplo)+")+\"\", \"UTF-8\"))+\""+(desno)+"' and \";\r\n");
		
		
		
		sbl.append("sedodatno += metodo;\r\n");
		sbl.append("}\r\n");
		
	//	sedodatno += metod;
		
		
		}
		
		
	}
		
}

sbl.append("if (!sedodatno.equals(\"\")) {\r\n");

sbl.append("if (sedodatno.endsWith(\"and \")) {\r\n");

sbl.append("sedodatno= sedodatno.substring(0,sedodatno.lastIndexOf(\"and \"));\r\n");

sbl.append("}\r\n");

sbl.append("}\r\n");
	
	
	
	
	
	
	
	
	
	
	
	sbl.append(" dodaten_sql_pogoj +=  (!dodaten_sql_pogoj.equals(\"\")?(sedodatno.equals(\"\")?\"\":\" and \"):\"\")+sedodatno;\r\n");
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 3");

	///////// searchi

	sbl.append("if (nul.jeNull(request.getParameter(\"isk\")).equals(\"1\")) {\r\n");
	//sbl.append("iskanje = true;\r\n");
	sbl.append("sif = (com.popultrade.model."+imefile +")session.getAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");

	sbl.append("}\r\n");
	sbl.append("else {\r\n");

//	sbl.append("session.removeAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");
	sbl.append("}\r\n");















	sbl.append("List lis =null;\r\n");

com.popultrade.model.TemplateMailList tml = sif.getTemplatemaillist();


	sbl.append("lis = dao.get"+imefile +"s(sif,1,"+tml.getMax_st_izpisov()+",dodaten_sql_pogoj,orderby,orderbysmer);\r\n");







	//sbl.append("%////>\r\n");
	//sbl.append("<html><head><title></title></head>\r\n");
	
	//sbl.append("outt.append(\"<html><head><title>Report</title><meta http-equiv='content-type' content='text/html; charset=utf-8'/><meta http-equiv='X-UA-Compatible' content='IE=8;FF=3'/><style type='text/css'>* {font-family: verdana;}a,a:link,a:active,a:visited {text-decoration: none;cursor: pointer;color: #035;}body {margin: 1ex;padding: 0ex;}img {border: 0px;}table {border-collapse: collapse;border-spacing: 0px;}td,th {cursor: default;border: 1px solid #DDD;padding: 1pt 1ex;margin: 0px}th {text-align: left;font-weight: bold;background-color: #F0F0F0;}td.ROW_NUMBER {background-color: #F3F3F3;text-align: center;}td.EVENT_TYPE_I {color: #10109F;text-align: center;}td.EVENT_TYPE_W {color: #808010;text-align: center;}td.EVENT_TYPE_E {color: #9F1010;text-align: center;}</style></head>\");\r\n");
	
	
	
	
	//sbl.append("<style>\r\n");

	//sbl.append("A:hover{color:red}\r\n");
	//sbl.append("#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}\r\n");
	//sbl.append("DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;\r\n");
	//sbl.append("background-color:Silver; layer-background-color:2686D8}\r\n");
//	sbl.append("</style>\r\n");
//	sbl.append("<style type=text/css>\r\n");

	//sbl.append("@import \"barve.css\";\r\n");
	//sbl.append("@import \"tooltipcss.css\";\r\n");
	//sbl.append("@import \"js/jquery.contextmenu.css\";\r\n");
	//sbl.append("</style>\r\n");
	


   
    sbl.append("Hashtable sifhint=new Hashtable();\r\n");
	//// katere hinte dam v jsp
    sbl.append("Hashtable sifhintp=new Hashtable();\r\n");
  
    System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 4");
	     
	     com.popultrade.dao.TemplateListDAO daot = (com.popultrade.dao.TemplateListDAO)contextUtil.getBeanDao("templateListDAO",servletContext);

	     
	     
	     com.popultrade.model.TemplateList sifc = new com.popultrade.model.TemplateList();
	     sifc.setTemplatehead_id(new Long(idpr+""));
	 
	     List lin = daot.getTemplateLists(sifc);
	     Iterator itb = lin.iterator();
	     
	     
	     
	     while (itb.hasNext()) {
	    	
	    	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itb.next();
	    	 
	//sbl.append("p"+tli.getId()+"=\"< %=ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\";\r\n");


	/// kontrola hintov, ce ima dodam opcije
	if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null) {
		
		String clna = tli.getTemplateClassClass().getClass_name();
		//sbl.append("<////%\r\n");
		sbl.append("if (!ConPool.cache.containsKey(\"jsp"+sif.getId()+"\"+control.getJezik())) {");
		
		String dodaten = "";
		if (tli.getTemplateClassClass().getTemplateClasss().size()>0) {

			Iterator tre = tli.getTemplateClassClass().getTemplateClasss().iterator();
			while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
			if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
					
			
				dodaten = dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
				}
			}
			else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
			}
			}
			/// dodaten pogoj da sploh gleda po bazi
			
			
			
		}
		
		
		sbl.append("if (true "+dodaten+") {\r\n");
		sbl.append("com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n");

		sbl.append("com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n");

		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 5");
		//// vrednosti
		
		Iterator ikov = tli.getTemplateClassClass().getTemplateClasss().iterator();
		Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tli.getTemplateClassClass().getClass_name());
		
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
		
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
		
		
		sbl.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
		
		
		}
		
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 6");
		String sifra="";
		String vrednost="";
		/// dobim vrednosti za sifro in vrednost hinta
			 ikov = tli.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
		
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
		
		if (nul.jeNull(tcc.getTip()).equals("sifra")) {
			sifra = nul.jeNull(tcc.getVrednost());
		}
		if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
			vrednost = nul.jeNull(tcc.getVrednost());
		}
		}
		
		
		if (!sifra.equals("") && !vrednost.equals("")) {
		sbl.append("List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+");\r\n");
		
		sbl.append("Iterator i"+clna+"=li"+clna+".iterator();\r\n");
		

		
		sbl.append("while (i"+clna+".hasNext()) {\r\n");
		sbl.append("com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n");

		
		//sbl.append("%////>\r\n");

		//sbl.append("p"+tli.getId()+"<////%=nul.jeNull(modi"+clna+"."+sifra+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")%////>=\"<////%=nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\")%////>\";\r\n");
	///// opcija brez sifre v sifrantu, samo id
		
	//	sbl.append("sifhint.put(\"p"+tli.getId()+"\"+ nul.menjajSifrantZnake(nul.jeNull(modi"+clna+"."+sifra+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")),nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\"));\r\n");


		//sbl.append("p"+tli.getId()+"<////%=nul.menjajSifrantZnake(nul.jeNull(modi"+clna+"."+sifra+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>=\"<////%=nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\")%////>\";\r\n");

		//sbl.append("<////%\r\n\r\n");
		sbl.append("}\r\n\r\n");
		
		}
		
		sbl.append("}\r\n\r\n");
		
		
		sbl.append("}\r\n");
		
		
	}////////////////

	    	 
	    	 
	     }
	     System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 7");
	   //  sbl.append("<////%\r\n\r\n");    
	   /*  sbl.append("if (!ConPool.cache.containsKey(\"jsp"+sif.getId()+"\"+control.getJezik())) {");
	     sbl.append("ConPool.cache.put(\"jsp"+sif.getId()+"\"+control.getJezik(),sifhint);\r\n\r\n");
	     sbl.append("}\r\n\r\n");
	     sbl.append("else {\r\n");
	     sbl.append("sifhint=(Hashtable)ConPool.cache.get(\"jsp"+sif.getId()+"\"+control.getJezik());");
	     sbl.append("}\r\n");
	     sbl.append("\r\n\r\n");*/
	  
	
	
	/*
	
	LOGIKA ZA EXCEL SETUPI
	
	*/
	
	
	
   sbl.append("File xmlf=null;\r\n");

     sbl.append("String imetmpfile = \"\";\r\n");


//////////////// EXCEL FILE kreacija

     sbl.append("FileOutputStream outtt = new FileOutputStream(control.getlokacija_pdf_file()+izpis);\r\n");

     sbl.append("HSSFWorkbook wb = new HSSFWorkbook();\r\n");

     sbl.append("HSSFSheet s = wb.createSheet();\r\n");
   sbl.append("s.setMargin(Sheet.LeftMargin, 0.25); \r\n");  
   sbl.append("s.setMargin(Sheet.RightMargin, 0.25); \r\n");   
   sbl.append("s.setMargin(Sheet.TopMargin, 0.75); \r\n");   
   sbl.append("s.setMargin(Sheet.BottomMargin, 0.75);\r\n");      //Setup the Header and Footer Margins    sheet.setMargin(Sheet.HeaderMargin, 0.25);    sheet.setMargin(Sheet.FooterMargin, 0.25); 
     sbl.append("HSSFRow r = null;\r\n");

     sbl.append("HSSFCell c = null;\r\n");

     sbl.append("HSSFCellStyle cs = wb.createCellStyle();\r\n");
     sbl.append("HSSFDataFormat df = wb.createDataFormat();\r\n");
     sbl.append("HSSFFont f = wb.createFont();\r\n");
     sbl.append("f.setFontName(\"Arial\");\r\n");
     sbl.append("f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);\r\n");

     sbl.append("cs.setFont(f);\r\n");


     //// style - rob vse okoli cell
     sbl.append("HSSFCellStyle style = wb.createCellStyle();\r\n");
     sbl.append("style.setBorderBottom(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("style.setBottomBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("style.setBorderLeft(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("style.setLeftBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("style.setBorderRight(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("style.setRightBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("style.setBorderTop(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("style.setTopBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);\r\n");
     sbl.append("style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);\r\n");
     sbl.append("style.setFont(f);\r\n");
     sbl.append("style.setAlignment(HSSFCellStyle.ALIGN_CENTER);\r\n");
     //// style - zgoraj spodaj cell
     sbl.append("HSSFCellStyle styleud = wb.createCellStyle();\r\n");
     sbl.append("styleud.setBorderBottom(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleud.setBottomBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleud.setBorderTop(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleud.setTopBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleud.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);\r\n");
     sbl.append("styleud.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);\r\n");
     //// style - rob levo up in down cell
     sbl.append("HSSFCellStyle styleudl = wb.createCellStyle();\r\n");
     sbl.append("styleudl.setBorderBottom(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleudl.setBottomBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleudl.setBorderLeft(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleudl.setLeftBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleudl.setBorderTop(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleudl.setTopBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleudl.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);\r\n");
     sbl.append("styleudl.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);\r\n");
     //// style - rob desno up in down cell
     sbl.append("HSSFCellStyle styleudd = wb.createCellStyle();\r\n");
     sbl.append("styleudd.setBorderBottom(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleudd.setBottomBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleudd.setBorderRight(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleudd.setRightBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleudd.setBorderTop(HSSFCellStyle.BORDER_THIN);\r\n");
     sbl.append("styleudd.setTopBorderColor(HSSFColor.BLACK.index);\r\n");
     sbl.append("styleudd.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);\r\n");
     sbl.append("styleudd.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);\r\n");

     sbl.append("HSSFCellStyle stylenumber = wb.createCellStyle();\r\n");
     sbl.append("stylenumber.setDataFormat(df.getFormat(\"0.00\"));\r\n");
sbl.append("stylenumber.setAlignment(HSSFCellStyle.ALIGN_RIGHT);\r\n");

     sbl.append("HSSFCellStyle stylenumberb = wb.createCellStyle();\r\n");
     sbl.append("stylenumberb.setDataFormat(df.getFormat(\"0.00\"));\r\n");
sbl.append("stylenumberb.setAlignment(HSSFCellStyle.ALIGN_RIGHT);\r\n");
     sbl.append("HSSFFont ffd = wb.createFont();\r\n");
     sbl.append("ffd.setFontName(\"Arial\");\r\n");
     sbl.append("ffd.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);\r\n");
	 sbl.append("ffd.setFontHeight((short)213);\r\n");
     sbl.append("stylenumberb.setFont(ffd);\r\n");


     sbl.append("HSSFCellStyle stylecenter = wb.createCellStyle();\r\n");
     sbl.append("stylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);\r\n");

     sbl.append("HSSFCellStyle styleleft = wb.createCellStyle();\r\n");
     sbl.append("styleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);\r\n");
     sbl.append("HSSFFont ffe = wb.createFont();\r\n");
     sbl.append("ffe.setFontName(\"Arial\");\r\n");
     sbl.append("ffe.setCharSet(FontCharset.EASTEUROPE.getValue());\r\n");
     sbl.append("styleleft.setFont(ffe);\r\n");


     sbl.append("HSSFCellStyle styleveliko = wb.createCellStyle();\r\n");
     sbl.append("styleveliko.setAlignment(HSSFCellStyle.ALIGN_LEFT);\r\n");
     sbl.append("HSSFFont ff = wb.createFont();\r\n");
     sbl.append("ff.setFontName(\"Arial\");\r\n");
     sbl.append("ff.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);\r\n");
	 sbl.append("ff.setFontHeight((short)372);\r\n");
     sbl.append("styleveliko.setFont(ff);\r\n");
     
     

     sbl.append("wb.setSheetName(0, \""+imefile+"\");\r\n");
	
	
	     
	     
	     
//	sbl.append("</script>\r\n");


	//sbl.append("outt.append(\"<body>\");\r\n");



//	sbl.append("<div id=\"divBg\" style=\"width:100%\">\r\n");
///	sbl.append("outt.append(\"<table width='100%' border='0'  cellpadding='3' align='CENTER' valign='MIDDLE' style=' font-family:Verdana;font-weight: bold; font-size:"+tml.getFont_size_head()+"pt'>\");\r\n");
//	sbl.append("outt.append(\"<tr >\");\r\n");
//	sbl.append("outt.append(\"<td width='3%' align='center' bgcolor='#F0F0F0' >#</td>\");\r\n");
	  
	sbl.append("String stolpci =nul.jeNull(control.getColumnsUser(contextUtil,pageContext.getServletContext(),\""+imefile +""+sif.getId()+"\"));\r\n");


	
	 sbl.append("String stolpci_m = \"\";\r\n");

	 
String stolpci_or="";
	 
	 
	    int  stej=0;
	      int bar = 0;
	      String[] barv = new String[2];
	      barv[0]="ADD9FF";
	      barv[1]="D2EAFF";
	      
	      int htvsst=0;
	   
	      Iterator itbi = lin.iterator();
	      
	   //   sbl.append("int stz = 0;\r\n"); 
	      /// prvic stolpci sirina
	      while (itbi.hasNext()) {
	     	
	     	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbi.next();
	 
	          
	           //  if (bar==2) {
	           //  bar=0;
	          //   }
	             
	             String suti = "10000";
	             
	             if (tli.getStolpec_width()!=null && !tli.getStolpec_width().equals("")) {
	              suti = (tli.getStolpec_width().replace("%", "")+"000");
	             }
	             
	         	if (nul.jeNull(tli.getStolpec_primaren()).equals("1")) {
	         		stolpci_or = stolpci_or + ""+tli.getId()+":::"+tli.getStolpec_width()+"---";
	         	}
	             
	             
	         
	//sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"'  bgcolor='#F0F0F0'  title='\"+ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") +\"'>\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</td>\");\r\n");
	               
	        
	//bar++;

	              }
	              
	
	 
	 
	 
	 
	 
	 
		  	sbl.append("if (stolpci.equals(\"\")) {\r\n");
			  
			sbl.append("stolpci=\""+stolpci_or+"\";\r\n");

			sbl.append("}\r\n\r\n");
	 
	 
	 
			 sbl.append("String[] colss = stolpci.split(\"---\");\r\n");
			 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 sbl.append("for (int xc=0;xc<colss.length;xc++) {\r\n");
		
	 sbl.append("if (colss[xc]!=null && !colss[xc].equals(\"\")) {\r\n");
	 sbl.append("String[] spp = colss[xc].split(\":::\");\r\n");
 
	 
	      stej=0;
	       bar = 0;
	  
	      
	       htvsst=0;
	   
	       itbi = lin.iterator();
	      
	      sbl.append("int stz = 0;\r\n"); 
	      /// prvic stolpci sirina
	      while (itbi.hasNext()) {
	     	
	     	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbi.next();
	 
	          
	           //  if (bar==2) {
	           //  bar=0;
	          //   }
	             
	             String suti = "10000";
	             
	             if (tli.getStolpec_width()!=null && !tli.getStolpec_width().equals("")) {
	              suti = (tli.getStolpec_width().replace("%", "")+"000");
	             }
	             
	         	if (nul.jeNull(tli.getStolpec_primaren()).equals("1")) {
	         		stolpci_or = stolpci_or + ""+tli.getId()+":::"+tli.getStolpec_width()+"---";
	         	}
	             
	             
	             
	             sbl.append("if (spp[0].equals(\""+tli.getId()+"\")) {\r\n"); 
	             sbl.append("s.setColumnWidth( (short) stz, (short) "+suti+"); \r\n");
	             sbl.append("stz++;\r\n"); 

sbl.append("} else if (stolpci.indexOf(\""+tli.getId()+":::\")==-1){\r\n"); 
//sbh.append("stolpci_m = stolpci_m + \"'\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'"+tli.getId()+"XXX"+tli.getStolpec_width().replaceAll("%","")+"'); } ,icon:''},\";\r\n");


sbl.append("}\r\n"); 
	//sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"'  bgcolor='#F0F0F0'  title='\"+ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") +\"'>\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</td>\");\r\n");
	               
	        
	//bar++;

	              }
	              
	              
	      sbl.append("}\r\n\r\n");
	      sbl.append("}\r\n\r\n");
	      
	      

	      
	      
	      
	          /////// imena
	          
	    
	      itbi = lin.iterator();
	      sbl.append("int rowss = 0;\r\n");
	      sbl.append("int zapp = 0;\r\n");


      sbl.append("r = s.createRow(rowss);\r\n");
     sbl.append("rowss++;\r\n");
     sbl.append("for (int xc=0;xc<colss.length;xc++) {\r\n");

     sbl.append("if (colss[xc]!=null && !colss[xc].equals(\"\")) {\r\n");
     sbl.append("String[] spp = colss[xc].split(\":::\");\r\n");
     
	      while (itbi.hasNext()) {
	     	
	     	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbi.next();

     ////////// naslovi columov


sbl.append("if (spp[0].equals(\""+tli.getId()+"\")) {\r\n"); 	
     sbl.append("c = r.createCell((short)zapp);\r\n");
  //   c.setEncoding(HSSFWorkbook.ENCODING_UTF_16);
     sbl.append("c.setCellValue(ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") );\r\n");
     sbl.append("c.setCellStyle(style);\r\n");
	sbl.append("zapp++;\r\n");
	 sbl.append("}\r\n\r\n");
	          //sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"'  bgcolor='#F0F0F0'  title='\"+ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") +\"'>\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</td>\");\r\n");
	
	          }
	          
	    	 
	    	  sbl.append("}\r\n\r\n");
	    	  sbl.append("}\r\n\r\n");    
	          
	          
	          
	   sbl.append("zapp = 0;\r\n");           
	              

	//sbl.append("</div>\r\n");



//	sbl.append("outt.append(\"<table width=100% cellspacing=2  style=' font-family: Verdana; font-size: "+tml.getFont_size_list()+"pt'>\");\r\n");
	//sbl.append("<tr><td colspan=3>&nbsp</td></tr>\r\n");
	//sbl.append("<////%\r\n");

	/// menja barvo
//	sbl.append("int br = 0;\r\n");
//	sbl.append("String oe_kup_nap = \"\";\r\n");


	sbl.append("Iterator it = lis.iterator();\r\n\r\n");

	sbl.append("String rezu=\"\";\r\n\r\n");
	//sbl.append("int zap = 0;\r\n");
Hashtable metog = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),imefile);
	sbl.append("while (it.hasNext()){  // while start\r\n");

	sbl.append("com.popultrade.model."+imefile +" vseb = (com.popultrade.model."+imefile +")(it.next());\r\n");
	
	//// zacetek row
	sbl.append("r = s.createRow(rowss);\r\n");
	
	//sbl.append("stvrstic++;\r\n");

	//sbl.append("if (br==2){\r\n");
	// sbl.append(" br=0;\r\n");

	 

	Iterator itbv = lin.iterator();

	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 9");

	while (itbv.hasNext()) {
		
		 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();

		 
		 //// prikaz stolpca
		 /// numeric
		// sbl.append("<%\r\n");
		 sbl.append("rezu=\"\";\r\n");
		 
		// sbl.append("%////>\r\n");
		
		 ///////////////////
		 /// pogledam, ce ima pogoje,  za gumb PP
		 /////////////////
		 
		 if (tli.getTemplateClasses().size()>0) {
			  
			  
			  //////DODAJ FUNKCIJO ZA GUMB PP
			 sbl.append(createPP(tli,"templatelist")+"\r\n");
			 
		 }	 //////////////// konec pogoji preko pp gumba
		 else {
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1212");
			 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
				// sbl.append("<%\r\n");
				
				 sbl.append("rezu=nul.formatNumber(vseb."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
				// sbl.append("%////>\r\n");
				 //sbl.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
				 
			 }
			 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
				// sbl.append("<%\r\n");
				 sbl.append("rezu=nul.getDatumFormatFromDate(vseb."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
				// sbl.append("%////>\r\n");
			 }
			 else {
			//	 sbl.append("<%\r\n");
				 sbl.append("rezu=nul.jeNull(vseb."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
			//	 sbl.append("%////>\r\n");
			 }
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1213");
		 }
		 
		 
	
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 if (nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals("") ) {
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 122");
			// sbl.append("<%\r\n");
			 sbl.append("rezu=nul.cutString(rezu,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n");
			// sbl.append("%////>\r\n");
			 
			 
		 }
		 
		 String hinto = "";
		 /// ce ima hinte stolpec
		 if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
			
			// sbl.append("<%\r\n");
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 123");
			 //sbl.append("if (sifhint.containsKey(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")))) {\r\n");
			// hinto = " title='\"+nul.jeNull((String)sifhint.get(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))))+\"'";
			 
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1214");
			// sbl.append("sifhintp.put(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")),sifhint.get(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))));\r\n");
			// sbl.append("}\r\n\r\n");
			 
			// sbl.append("%////>\r\n");
			// hinto = " title=\"\"";
			 
			 
		 }
		// if (nul.jeNull(tli.getUporabi_onmouseover_prikaz()).equals("1")) {
			 
			// hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip('<////%=nul.menjajSifrantZnake(nul.jeNull(rezu).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>')\"";
				 
			 
			 
	//	 }
		 

		 

		 
		 
		 
		 if (nul.jeNull(tli.getStolpec_checkbox()).equals("1")) {
			// sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"' "+hinto+"><input type='checkbox' value='\"+rezu+\"' name='"+tli.getStolpec_metoda().toLowerCase().replaceAll("get","")+"____\"+rezu+\"'   ></td>\");\r\n");
			 
		 }
		 else {
		// sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"' "+hinto+">\");\r\n");
		 
		 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 124");
		 if (nul.jeNull(tli.getUporabi_onmouseover_prikaz()).equals("1")) {
		//	 sbl.append("<%\r\n");
			 sbl.append("rezu=nul.jeNull(vseb."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
			// sbl.append("%////>\r\n");
		 }
		 
	
				// sbl.append("outt.append(rezu);\r\n");
			 	
			 //	tli.getTemplatehead_id();
			 	String tipm = "styleleft";
			 	String konvv = "";
			 			if (metog.containsKey(tli.getStolpec_metoda().replaceAll("get", "set"))) {
			if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("String")!=-1) {
			}
			else if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("Long")!=-1) {
		tipm = "stylenumber";
		
				
			}
			else if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("Integer")!=-1 || ((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("int")!=-1) {
			tipm = "stylenumber";
			konvv="int";
				
			}
			else if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("Double")!=-1) {
			 	tipm = "stylenumber";
			 	konvv="dou";
			 }
			 }	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 			sbl.append("for (int xc=0;xc<colss.length;xc++) {\r\n");

			 			sbl.append("if (colss[xc]!=null && !colss[xc].equals(\"\")) {\r\n");
			 			sbl.append("String[] spp = colss[xc].split(\":::\");\r\n");

			 			sbl.append("if (spp[0].equals(\""+tli.getId()+"\")) {\r\n"); 	
			 	
			 	
			 	
	sbl.append("c = r.createCell((short)zapp);\r\n");
	sbl.append("if (rezu!=null && rezu.indexOf(\">\")==-1) {\r\n");
	sbl.append(" c.setCellStyle("+tipm+");\r\n");
	sbl.append("c.setCellType(HSSFCell.CELL_TYPE_NUMERIC);\r\n");
	sbl.append("}\r\n");
	sbl.append("else {\r\n");
	sbl.append(" c.setCellStyle(styleleft);\r\n");
	sbl.append("}\r\n");
	sbl.append("String ruxe = nul.jeNull(rezu.replaceAll(\"<br>\",\"\\r\\n\").replaceAll(\"&nbsp;\",\"\").replaceAll(\"\\\\<[^>]*>\",\"\"));\r\n");
	if (konvv.equals("dou")) {
		
		sbl.append("double free = (ruxe.equals(\"\")?0:Double.parseDouble(ruxe.replace(\",\",\".\")));\r\n");
		
		sbl.append("c.setCellValue(free);\r\n");
		//sbl.append("c.setCellValue((ruxe.equals(\"\")?\"\":Double.parseDouble(ruxe)));\r\n");
	}
	else if (konvv.equals("int")) {
		
		sbl.append("int free = (ruxe.equals(\"\")?0:Integer.parseInt(ruxe.replace(\",\",\".\")));\r\n");
	
		 sbl.append("c.setCellValue(free);\r\n");
	}
	else {
		
		sbl.append("c.setCellValue(rezu.replaceAll(\"<br>\",\"\\r\\n\").replaceAll(\"&nbsp;\",\"\").replaceAll(\"\\\\<[^>]*>\",\"\"));\r\n");
	}
 //  sbl.append(" c.setEncoding((short)HSSFCell.ENCODING_UTF_16);\r\n");
    
     sbl.append("zapp++;\r\n");
     
     
	  sbl.append("}\r\n\r\n");
	  sbl.append("}\r\n\r\n");
	  sbl.append("}\r\n\r\n");
     
     
     
     
		 
	    // sbl.append("< %=rezu%////>\r\n\r\n");
	     
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 125");

	   //  sbl.append("outt.append(\"</td>\");\r\n");
		 }
	       
	       
	}





	//sbl.append("<td  align=\"center\"><span id='res<////%=vseb.getId()%////>'>\r\n");



System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 13");




//	sbl.append("</span></td>\r\n");
	sbl.append("rowss++;\r\n");
	sbl.append("zapp=0;\r\n");
	
	///// update vsakega recorda
	if (nul.jeNull(tml.getUpdate_polje_uporabi()).equals("1")) {
	
		if (!nul.jeNull(tml.getUpload_pogoj()).equals("")) {
			sbl.append(tml.getUpload_pogoj().replaceAll("'","\"")+" { \r\n");
		}
		
		sbl.append("vseb.set"+tml.getUpdate_polje()+"("+tml.getUpdate_polje_vrednost()+");\r\n");
		sbl.append("dao.save"+imefile +"(vseb);\r\n");
	
		if (!nul.jeNull(tml.getUpload_pogoj()).equals("")) {
			sbl.append("}\r\n");
		}
	}
	//sbl.append("<////%\r\n");
	//sbl.append("br++;\r\n");

	
	
	
	
	sbl.append("}/////////////// while end\r\n");
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 14");

	// sbl.append("%////>\r\n");
	  
	//sbl.append("outt.append(\"</table>\");\r\n");

sbl.append("wb.write(outtt);\r\n");
sbl.append("outtt.close();\r\n");


	//sbl.append("outt.append(\"</body></html>\");\r\n");
	// sbl.append("<////%\r\n");

	sbl.append("}\r\n");
	sbl.append("catch (Exception ex){\r\n");
	sbl.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

	sbl.append("////log.error(ex.toString());\r\n");
	sbl.append("}\r\n");
	
	
	///////////////////////////////////////////////////
	///////// mail del
	
	
	


	//sbl.append("%////>\r\n");
	/*sbl.append("Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(control.getlokacija_pdf_file()+control.getUserName()+\"html_format.html\"), \"utf-8\"));\r\n");
	sbl.append("out3.write(outt.toString());\r\n");
	sbl.append("out3.close();\r\n");
	*/
	
sbl.append("	String napaka = \"\";\r\n");
		sbl.append("try {\r\n");
	sbl.append("Properties props = new Properties();\r\n");
	sbl.append("props.put(\"mail.smtp.host\", ConPool.getMailserver());\r\n");
	sbl.append("Session s = Session.getInstance(props,null);\r\n");

	sbl.append("MimeMessage message = new MimeMessage(s);\r\n");



	      /// from iz forme
	sbl.append("String from2 = ConPool.getDefaultmail();\r\n");

	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 15");

	  //InternetAddress from = new InternetAddress("tourist-portoroz@siol.net");
	sbl.append("InternetAddress from = new InternetAddress(from2);\r\n");

	sbl.append("message.setFrom(from);\r\n");

	/// to iz forme
	sbl.append("String to = control.getEmail();\r\n");


	sbl.append("message.addRecipients(Message.RecipientType.TO, to);\r\n");
	   // message.setRecipients(Message.RecipientType.BCC,multibcc);

	  /////////// subject iy forme
	sbl.append("String sub = ConPool.getPrevod(\""+sif.getId()+"L\"+control.getJezik()).replaceAll(\"_\",\" \");\r\n");




	sbl.append("message.setSubject(sub);\r\n");
	
	
	
	sbl.append("MimeBodyPart messageBodyPart =  new MimeBodyPart();\r\n");

	sbl.append("messageBodyPart.setContent(outt.toString(),\"text/html; charset=UTF-8\");\r\n");


	//sbl.append("message.setContent(outt.toString(),\"text/html\");\r\n");

	
sbl.append("Multipart multipart = new MimeMultipart();\r\n");
sbl.append("multipart.addBodyPart(messageBodyPart);\r\n");

    // Part two is attachment
sbl.append("messageBodyPart = new MimeBodyPart();\r\n");
sbl.append("DataSource source =  new FileDataSource(control.getlokacija_pdf_file()+izpis);\r\n");
sbl.append("messageBodyPart.setDataHandler( new DataHandler(source));\r\n");
sbl.append("messageBodyPart.setFileName(izpis);\r\n");
sbl.append("multipart.addBodyPart(messageBodyPart);\r\n");

    // Put parts in message
sbl.append("message.setContent(multipart);\r\n");

	
	
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 16");
	
	

	sbl.append("Transport.send(message);\r\n");
	
	
	
	sbl.append("File lio = new File(control.getlokacija_pdf_file()+izpis);\r\n");
	sbl.append("lio.delete();\r\n");


	sbl.append("}\r\n");
sbl.append("catch (Exception em) {\r\n");
	//sbl.append("System.out.println(\"Napaka posiljanje maila! \"+em.toString());\r\n");
	sbl.append("org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");
	sbl.append("log.error(em.toString());\r\n");
	sbl.append("napaka = em.toString();\r\n");
	sbl.append("}\r\n");



	
	
	
	sbl.append("%////>\r\n");
	
	sbl.append("<html><head><title>spreminjaj</title></head>\r\n");
	
	sbl.append("<style type=text/css>\r\n");
	sbl.append("@import \"barveold.css\";\r\n");
	sbl.append("@import \"tooltipcss.css\";\r\n");
	////grafika oz barve

	if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
	sbl.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
	}
	else {

	sbl.append("@import \"barveblue.css\";\r\n");	
	}
					sbl.append("</style>\r\n");
							sbl.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	
	
	sbl.append("<body   style=\"margin: 0\" onload=\"mom()\">\r\n");
	sbl.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
	sbl.append("<tr>\r\n");
	sbl.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
	sbl.append("</tr>\r\n");
	sbl.append("<tr>\r\n");
	sbl.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
	sbl.append("<p align=\"center\">< %=ConPool.getPrevod(\""+sif.getId()+"M\"+control.getJezik()).replaceAll(\"_\",\" \") %////> <%=napaka%////> --> <////%=control.getEmail()%////></td>\r\n");
	sbl.append("</tr>\r\n");
	sbl.append("<tr>\r\n");
	sbl.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
	sbl.append("</tr>\r\n");
	sbl.append("</table>\r\n");
	sbl.append("<script language=javascript>\r\n");
	sbl.append("function mom() {\r\n");
	
	if (!nul.jeNull(tml.getTarget_funkcija()).equals("") && !nul.jeNull(tml.getTarget_funkcija_url()+"").equals("")) {

		   com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",servletContext);
	com.popultrade.model.TemplateHead thed = daoth.getTemplateHead(tml.getTarget_funkcija_url());
		

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
	sbl.append(tml.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp<////%=(nul.jeNull(request.getQueryString()).equals(\"\")?\"\":\"?\"+nul.jeNull(request.getQueryString()))%////>';\r\n");

//	sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+"+'<////%=nul.jeNull(request.getParameter(\"nipost\")).equals(\"da\")?\"\":\"?\"+nul.jeNull(request.getQueryString())%////>';\r\n");

		
	}
	
	else if (!nul.jeNull(tml.getTarget_funkcija()).equals("") ) {
		
		sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+";\r\n");

		
	}
	
	sbl.append("resetLoadingOverlay();\r\n");

	
	//sbl.append("top.resetPageBlockAll();\r\n");
	sbl.append("}</script>\r\n");
	
	sbl.append("</body>\r\n");
	
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 17");

	
	sbl.append("%////>\r\n");
	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+sif.getId()+"_mle.jsp"), "latin1"));



	out3.write(sbl.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
			
	
			}
catch (Exception ec) {
	System.out.println("Napaka pri generaciji mail lista "+ec.toString());
}


	
	
	return "";
	
	
	
}











private String genListMail(String idpr,String order_by,String order_by_smer,String imefile,com.popultrade.model.TemplateHead sif,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext) {
	
	try {

	StringBuffer sbl = new StringBuffer();
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1");
	sbl.append("<////%@ page contentType=\"text/html; \" import=\"javax.mail.*,javax.mail.internet.*,javax.activation.*,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.util.Date,java.net.URLDecoder\"%////>\r\n");
	sbl.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
	sbl.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
	sbl.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
	sbl.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");

///// dodatni pogoji, v javi
com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();

com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",servletContext);

tuidd = daouid.getTemplateUiDodatnos(idpr);


	sbl.append("<////%\r\n");
	sbl.append("////request.setCharacterEncoding(control.encoding);\r\n");
	sbl.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
	sbl.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
	sbl.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
	sbl.append("////response.addDateHeader(\"Expires\", 0);\r\n");
	sbl.append("////if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
	sbl.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
	sbl.append("////}\r\n");
	sbl.append("%////>\r\n");
	sbl.append("<////%\r\n");

	sbl.append("// stevilo prikazov vrstic\r\n");

	sbl.append("int stpri = control.st_vrstic;\r\n");
	sbl.append("StringBuffer outt = new StringBuffer();\r\n");
	// get list from daoobject
	sbl.append("com.popultrade.dao."+imefile +"DAO dao = (com.popultrade.dao."+imefile +"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length()) +"DAO\",pageContext.getServletContext());\r\n");

	// steje stevilo vrstic
	sbl.append("int stej = 0;\r\n");

	// barve vrstic
	sbl.append("String[] colors = {\"plava1\",\"plava2\",\"silver\"};\r\n");





	// stevilo vrstic
	sbl.append("int stvrstic=0;\r\n");

	

			sbl.append("try {\r\n");
	if (!nul.jeNull(tuidd.getDodatno_update()).equals("")) {
		sbl.append(nul.jeNull(tuidd.getDodatno_update())+"\r\n");
		}
		

			System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 2");

	sbl.append("String orderby = \""+order_by+"\";\r\n");
	sbl.append("String orderbysmer = \""+order_by_smer+"\";\r\n");

	sbl.append("String dodpog = \"\";\r\n");


	sbl.append("com.popultrade.model."+imefile +" sif = new com.popultrade.model."+imefile +"();\r\n");


	//// setam pogoje za sif
String	dodaten_sql_pogoj = "";

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
			//sbl.append("sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n");	
		}
		else {
			
		sbl.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
		//sbl.append("sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
		sbl.append(" }\r\n");
		
		}
		
		}
		else {
			
			if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
			sbl.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
			}
			if (!sem  ) {
				dodaten_sql_pogoj = nul.jeNull(tcc.getDodaten_hql_pogoj()) ;
				sem=true;
				}
				else {
					dodaten_sql_pogoj =  "  "+nul.jeNull(tcc.getDodaten_hql_pogoj());
				}
				sbl.append("dodpog += (!dodpog.equals(\"\")?\" and \":\"\")+ \""+dodaten_sql_pogoj+"\";\r\n");
				
			
			if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
			sbl.append(" }\r\n");
			}
		}
		
		}
		
		
	}


	sbl.append("String dodaten_sql_pogoj = dodpog;\r\n");
////dobim searche za like katere ne upostevam potem za navaden search
sbl.append("String sedodatno = \"\";\r\n");
sbl.append("String metodo = \"\";\r\n");

com.popultrade.dao.TemplateSearchDAO daose = (com.popultrade.dao.TemplateSearchDAO)contextUtil.getBeanDao("templateSearchDAO",servletContext);
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
		
	String uplow = "";
		
		if  (nul.jeNull(si.getSeupper()).equals("1")) {
		uplo=".toUpperCase()";
		uplow = "Upper(";
		}
		if  (nul.jeNull(si.getSelower()).equals("1")) {
		uplo=".toLowerCase()";
		uplow = "Lower(";
		}
		
		
		
		sbl.append("if (!nul.jeNull(request.getParameter(\""+metod+"\")).equals(\"\")) {\r\n");
		//sb.append("metodo=	\" "+uplow+metod+(uplow.equals("")?"":")")+"\""+URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+metod+"\"))"+(uplo)+")+\"\", \"UTF-8\")+\""+(desno)+"' and \";\r\n");
		sbl.append("metodo=	\" "+uplow+metod+(uplow.equals("")?"":")")+" like '"+(levo)+"\"+nul.jeNullEscapeSQL(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+metod+"\"))"+(uplo)+")+\"\", \"UTF-8\"))+\""+(desno)+"' and \";\r\n");
		
		
		
		sbl.append("sedodatno += metodo;\r\n");
		sbl.append("}\r\n");
		
	//	sedodatno += metod;
		
		
		}
		
		
	}
		
}

sbl.append("if (!sedodatno.equals(\"\")) {\r\n");

sbl.append("if (sedodatno.endsWith(\"and \")) {\r\n");

sbl.append("sedodatno= sedodatno.substring(0,sedodatno.lastIndexOf(\"and \"));\r\n");

sbl.append("}\r\n");

sbl.append("}\r\n");
	
	
	
	
	
	
	
	
	
	
	
	sbl.append(" dodaten_sql_pogoj +=  (!dodaten_sql_pogoj.equals(\"\")?(sedodatno.equals(\"\")?\"\":\" and \"):\"\")+ +sedodatno;\r\n");
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 3");

	///////// searchi

	sbl.append("if (nul.jeNull(request.getParameter(\"isk\")).equals(\"1\")) {\r\n");
	//sbl.append("iskanje = true;\r\n");
	sbl.append("sif = (com.popultrade.model."+imefile +")session.getAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");

	sbl.append("}\r\n");
	sbl.append("else {\r\n");

//	sbl.append("session.removeAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");
	sbl.append("}\r\n");















	sbl.append("List lis =null;\r\n");
com.popultrade.model.TemplateMailList tml = sif.getTemplatemaillist();



	sbl.append("lis = dao.get"+imefile +"s(sif,1,"+tml.getMax_st_izpisov()+",dodaten_sql_pogoj,orderby,orderbysmer);\r\n");







	//sbl.append("%////>\r\n");
	//sbl.append("<html><head><title></title></head>\r\n");
	
	sbl.append("outt.append(\"<html><head><title>Report</title><meta http-equiv='content-type' content='text/html; charset=utf-8'/><meta http-equiv='X-UA-Compatible' content='IE=8;FF=3'/><style type='text/css'>* {font-family: verdana;}a,a:link,a:active,a:visited {text-decoration: none;cursor: pointer;color: #035;}body {margin: 1ex;padding: 0ex;}img {border: 0px;}table {border-collapse: collapse;border-spacing: 0px;}td,th {cursor: default;border: 1px solid #DDD;padding: 1pt 1ex;margin: 0px}th {text-align: left;font-weight: bold;background-color: #F0F0F0;}td.ROW_NUMBER {background-color: #F3F3F3;text-align: center;}td.EVENT_TYPE_I {color: #10109F;text-align: center;}td.EVENT_TYPE_W {color: #808010;text-align: center;}td.EVENT_TYPE_E {color: #9F1010;text-align: center;}</style></head>\");\r\n");
	
	
	
	
	//sbl.append("<style>\r\n");

	//sbl.append("A:hover{color:red}\r\n");
	//sbl.append("#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}\r\n");
	//sbl.append("DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;\r\n");
	//sbl.append("background-color:Silver; layer-background-color:2686D8}\r\n");
//	sbl.append("</style>\r\n");
//	sbl.append("<style type=text/css>\r\n");

	//sbl.append("@import \"barve.css\";\r\n");
	//sbl.append("@import \"tooltipcss.css\";\r\n");
	//sbl.append("@import \"js/jquery.contextmenu.css\";\r\n");
	//sbl.append("</style>\r\n");
	


   
    sbl.append("Hashtable sifhint=new Hashtable();\r\n");
	//// katere hinte dam v jsp
    sbl.append("Hashtable sifhintp=new Hashtable();\r\n");
  
    System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 4");
	     
	     com.popultrade.dao.TemplateListDAO daot = (com.popultrade.dao.TemplateListDAO)contextUtil.getBeanDao("templateListDAO",servletContext);

	     
	     
	     com.popultrade.model.TemplateList sifc = new com.popultrade.model.TemplateList();
	     sifc.setTemplatehead_id(new Long(idpr+""));
	 
	     List lin = daot.getTemplateLists(sifc);
	     Iterator itb = lin.iterator();
	     
	     
	     
	     while (itb.hasNext()) {
	    	
	    	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itb.next();
	    	 
	//sbl.append("p"+tli.getId()+"=\"< %=ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\";\r\n");


	/// kontrola hintov, ce ima dodam opcije
	if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null) {
		
		String clna = tli.getTemplateClassClass().getClass_name();
		//sbl.append("<////%\r\n");
		sbl.append("if (!ConPool.cache.containsKey(\"jsp"+sif.getId()+"\"+control.getJezik())) {");
		
		String dodaten = "";
		if (tli.getTemplateClassClass().getTemplateClasss().size()>0) {

			Iterator tre = tli.getTemplateClassClass().getTemplateClasss().iterator();
			while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
			if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
					
			
				dodaten = dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
				}
			}
			else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
			}
			}
			/// dodaten pogoj da sploh gleda po bazi
			
			
			
		}
		
		
		sbl.append("if (true "+dodaten+") {\r\n");
		sbl.append("com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n");

		sbl.append("com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n");

		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 5");
		//// vrednosti
		
		Iterator ikov = tli.getTemplateClassClass().getTemplateClasss().iterator();
		Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tli.getTemplateClassClass().getClass_name());
		
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
		
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
		
		
		sbl.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
		
		
		}
		
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 6");
		String sifra="";
		String vrednost="";
		/// dobim vrednosti za sifro in vrednost hinta
			 ikov = tli.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
		
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
		
		if (nul.jeNull(tcc.getTip()).equals("sifra")) {
			sifra = nul.jeNull(tcc.getVrednost());
		}
		if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
			vrednost = nul.jeNull(tcc.getVrednost());
		}
		}
		
		
		if (!sifra.equals("") && !vrednost.equals("")) {
		sbl.append("List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+");\r\n");
		
		sbl.append("Iterator i"+clna+"=li"+clna+".iterator();\r\n");
		

		
		sbl.append("while (i"+clna+".hasNext()) {\r\n");
		sbl.append("com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n");

		
		//sbl.append("%////>\r\n");

		//sbl.append("p"+tli.getId()+"<////%=nul.jeNull(modi"+clna+"."+sifra+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")%////>=\"<////%=nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\")%////>\";\r\n");
	///// opcija brez sifre v sifrantu, samo id
		
		sbl.append("sifhint.put(\"p"+tli.getId()+"\"+ nul.menjajSifrantZnake(nul.jeNull(modi"+clna+"."+sifra+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")),nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\"));\r\n");


		//sbl.append("p"+tli.getId()+"<////%=nul.menjajSifrantZnake(nul.jeNull(modi"+clna+"."+sifra+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>=\"<////%=nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\")%////>\";\r\n");

		//sbl.append("<////%\r\n\r\n");
		sbl.append("}\r\n\r\n");
		
		}
		
		sbl.append("}\r\n\r\n");
		
		
		sbl.append("}\r\n");
		
		
	}////////////////

	    	 
	    	 
	     }
	     System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 7");
	   //  sbl.append("<////%\r\n\r\n");    
	     sbl.append("if (!ConPool.cache.containsKey(\"jsp"+sif.getId()+"\"+control.getJezik())) {");
	     sbl.append("ConPool.cache.put(\"jsp"+sif.getId()+"\"+control.getJezik(),sifhint);\r\n\r\n");
	     sbl.append("}\r\n\r\n");
	     sbl.append("else {\r\n");
	     sbl.append("sifhint=(Hashtable)ConPool.cache.get(\"jsp"+sif.getId()+"\"+control.getJezik());");
	     sbl.append("}\r\n");
	     sbl.append("\r\n\r\n");
	  
	     
	     
	     
//	sbl.append("</script>\r\n");


	sbl.append("outt.append(\"<body "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+" >\");\r\n");



	//sbl.append("<div id=\"divBg\" style=\"width:100%\">\r\n");
	sbl.append("outt.append(\"<table width='100%' border='0'  cellpadding='3' align='CENTER' valign='MIDDLE' style=' font-family:Verdana;font-weight: bold; font-size:"+tml.getFont_size_head()+"pt'>\");\r\n");
	sbl.append("outt.append(\"<tr >\");\r\n");
	sbl.append("outt.append(\"<td width='3%' align='center' bgcolor='#F0F0F0' >#</td>\");\r\n");
	  

	    int  stej=0;
	      int bar = 0;
	      String[] barv = new String[2];
	      barv[0]="ADD9FF";
	      barv[1]="D2EAFF";
	      
	      int htvsst=0;
	   
	      Iterator itbi = lin.iterator();
	      
	      
	      
	      while (itbi.hasNext()) {
	     	
	     	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbi.next();
	 
	          
	             if (bar==2) {
	             bar=0;
	             }
	               

	sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"'  bgcolor='#F0F0F0'  title='\"+ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") +\"'>\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</td>\");\r\n");
	               
	        
	bar++;

	              }
	              
	              
	              
	              
	//sbl.append("<td  align=center ----REPLACEMENUUP---- ><span id='res009'>\r\n");
	             


	//sbl.append("&nbsp;</span></td>\r\n");
	      
	      
	      
	      
	      
	      System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX :::8");
	      
	sbl.append("outt.append(\"</tr>\");\r\n");
	 

	sbl.append("outt.append(\"</table>\");\r\n");
	//sbl.append("</div>\r\n");



	sbl.append("outt.append(\"<table width=100% cellspacing=2  style=' font-family: Verdana; font-size: "+tml.getFont_size_list()+"pt'>\");\r\n");
	//sbl.append("<tr><td colspan=3>&nbsp</td></tr>\r\n");
	//sbl.append("<////%\r\n");

	/// menja barvo
	sbl.append("int br = 0;\r\n");
	sbl.append("String oe_kup_nap = \"\";\r\n");


	sbl.append("Iterator it = lis.iterator();\r\n\r\n");

	sbl.append("String rezu=\"\";\r\n\r\n");
	sbl.append("int zap = 0;\r\n");

	sbl.append("while (it.hasNext()){  // while start\r\n");

	sbl.append("com.popultrade.model."+imefile +" vseb = (com.popultrade.model."+imefile +")(it.next());\r\n");
	sbl.append("stvrstic++;\r\n");

	sbl.append("if (br==2){\r\n");
	 sbl.append(" br=0;\r\n");
	sbl.append("}\r\n");

	sbl.append("if (vseb.getId().toString().equals(nul.jeNull(request.getParameter(\"idback\")))) {\r\n");
	//sbl.append("%////>\r\n");
	sbl.append("outt.append(\"<tr  id=sprememba >\");\r\n");
	//sbl.append("<////%\r\n");
	sbl.append("}\r\n");
	sbl.append("else {\r\n");
	//sbl.append("%////>\r\n");
	sbl.append("outt.append(\"<tr  >\");\r\n");
	//sbl.append("<////%\r\n");
	sbl.append("}\r\n");

	sbl.append("zap++;\r\n");
	//sbl.append("%////>\r\n");
	 sbl.append("outt.append(\"<td width='3%' align='center' bgcolor='#F0F0F0' >\"+zap+\"</td>\");\r\n");
	 

	Iterator itbv = lin.iterator();

	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 9");

	while (itbv.hasNext()) {
		
		 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();

		 
		 //// prikaz stolpca
		 /// numeric
		// sbl.append("<%\r\n");
		 sbl.append("rezu=\"\";\r\n");
		 
		// sbl.append("%////>\r\n");
		 
		 
		 /// pogledam, ce ima pogoje
		 
		 if (tli.getTemplateClasses().size()>0) {
		 
		 sbl.append(createPP(tli,"templatelist")+"\r\n");
			 
			 
			 
		 }
		 else {
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1212");
			 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
				// sbl.append("<%\r\n");
				
				 sbl.append("rezu=nul.formatNumber(vseb."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
				// sbl.append("%////>\r\n");
				 //sbl.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
				 
			 }
			 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
				// sbl.append("<%\r\n");
				 sbl.append("rezu=nul.getDatumFormatFromDate(vseb."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
				// sbl.append("%////>\r\n");
			 }
			 else {
			//	 sbl.append("<%\r\n");
				 sbl.append("rezu=nul.jeNull(vseb."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
			//	 sbl.append("%////>\r\n");
			 }
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1213");
		 }
		 
		 if (nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals("") ) {
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 122");
			// sbl.append("<%\r\n");
			 sbl.append("rezu=nul.cutString(rezu,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n");
			// sbl.append("%////>\r\n");
			 
			 
		 }
		 
		 String hinto = "";
		 /// ce ima hinte stolpec
		 if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
			
			// sbl.append("<%\r\n");
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 123");
			 //sbl.append("if (sifhint.containsKey(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")))) {\r\n");
			 hinto = " title='\"+nul.jeNull((String)sifhint.get(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))))+\"'";
			 
			 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 1214");
			// sbl.append("sifhintp.put(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")),sifhint.get(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))));\r\n");
			// sbl.append("}\r\n\r\n");
			 
			// sbl.append("%////>\r\n");
			// hinto = " title=\"\"";
			 
			 
		 }
		// if (nul.jeNull(tli.getUporabi_onmouseover_prikaz()).equals("1")) {
			 
			// hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip('<////%=nul.menjajSifrantZnake(nul.jeNull(rezu).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>')\"";
				 
			 
			 
	//	 }
		 

		 

		 
		 
		 
		 if (nul.jeNull(tli.getStolpec_checkbox()).equals("1")) {
			 sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"' "+hinto+"><input type='checkbox' value='\"+rezu+\"' name='"+tli.getStolpec_metoda().toLowerCase().replaceAll("get","")+"____\"+rezu+\"'   ></td>\");\r\n");
			 
		 }
		 else {
		 sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"' "+hinto+">\");\r\n");
		 
		 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 124");
		 if (nul.jeNull(tli.getUporabi_onmouseover_prikaz()).equals("1")) {
		//	 sbl.append("<%\r\n");
			 sbl.append("rezu=nul.jeNull(vseb."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
			// sbl.append("%////>\r\n");
		 }
		 
		 
		 if (nul.jeNull(tli.getJeslika()).equals("1")) {
			 String wi = "";
				 String he = "";
				 if (!nul.jeNull(tli.getSlika_width()+"").equals("") && tli.getSlika_width()>0) {
					 wi = "width='"+tli.getSlika_width()+"'";
				 }
				 if (!nul.jeNull(tli.getSlika_height()+"").equals("") && tli.getSlika_height()>0) {
					 he = "height='"+tli.getSlika_height()+"'";
				 }
			//	 sbl.append("<////%\r\n");
				sbl.append("if (vseb.getId()!=null && !nul.jeNull(rezu).equals(\"\")) {\r\n\r\n");
		//	 sbl.append("%////>\r\n");
		
			if (nul.jeNull(tli.getJeslikaizbaze()).equals("1")) {
		
				/// dobim templateclass
				
				com.popultrade.model.TemplateHead thead = new com.popultrade.model.TemplateHead();
				com.popultrade.dao.TemplateHeadDAO daothead = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",servletContext);
				
				thead = daothead.getTemplateHead(tli.getTemplateprikazslike());
				
				if (thead!=null) {
				
				 sbl.append("outt.append(\"<img "+wi+"  "+he+" src='"+thead.getHead_class_name().toLowerCase()+"_ob"+thead.getId()+".jsp?id=<////%=vseb.getId()%////>' border='0' >\");\r\n");
				
				}

			}
			else {
			 sbl.append("outt.append(\"<img "+wi+"  "+he+" src='\"+control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu+\"' border='0' >\");\r\n");
			 }
			//	 sbl.append("<////%\r\n");
				sbl.append("}\r\n\r\n");
			// sbl.append("%////>\r\n");
			 }
			 else {
				 sbl.append("outt.append(rezu);\r\n");
			 }	
		 
		 
	    // sbl.append("< %=rezu%////>\r\n\r\n");
	     
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 125");

	     sbl.append("outt.append(\"</td>\");\r\n");
		 }
	       
	       
	}





	//sbl.append("<td  align=\"center\"><span id='res<////%=vseb.getId()%////>'>\r\n");



System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 13");




//	sbl.append("</span></td>\r\n");
	sbl.append("outt.append(\"</tr>\");\r\n");
	
	///// update vsakega recorda
	if (nul.jeNull(tml.getUpdate_polje_uporabi()).equals("1")) {
	
		if (!nul.jeNull(tml.getUpload_pogoj()).equals("")) {
			sbl.append(tml.getUpload_pogoj().replaceAll("'","\"")+" { \r\n");
		}
		
		sbl.append("vseb.set"+tml.getUpdate_polje()+"("+tml.getUpdate_polje_vrednost()+");\r\n");
		sbl.append("dao.save"+imefile +"(vseb);\r\n");
	
		if (!nul.jeNull(tml.getUpload_pogoj()).equals("")) {
			sbl.append("}\r\n");
		}
	}
	//sbl.append("<////%\r\n");
	sbl.append("br++;\r\n");

	
	
	
	
	sbl.append("}/////////////// while end\r\n");
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 14");

	// sbl.append("%////>\r\n");
	  
	sbl.append("outt.append(\"</table>\");\r\n");




	sbl.append("outt.append(\"</body></html>\");\r\n");
	// sbl.append("<////%\r\n");

	sbl.append("}\r\n");
	sbl.append("catch (Exception ex){\r\n");
	sbl.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

	sbl.append("////log.error(ex.toString());\r\n");
	sbl.append("}\r\n");

	//sbl.append("%////>\r\n");
	sbl.append("Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(control.getlokacija_pdf_file()+control.getUserName()+\"html_format.html\"), \"utf-8\"));\r\n");
	sbl.append("out3.write(outt.toString());\r\n");
	sbl.append("out3.close();\r\n");
	
	
sbl.append("	String napaka = \"\";\r\n");
		sbl.append("try {\r\n");
	sbl.append("Properties props = new Properties();\r\n");
	sbl.append("props.put(\"mail.smtp.host\", ConPool.getMailserver());\r\n");
	sbl.append("Session s = Session.getInstance(props,null);\r\n");

	sbl.append("MimeMessage message = new MimeMessage(s);\r\n");



	      /// from iz forme
	sbl.append("String from2 = ConPool.getDefaultmail();\r\n");

	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 15");

	  //InternetAddress from = new InternetAddress("tourist-portoroz@siol.net");
	sbl.append("InternetAddress from = new InternetAddress(from2);\r\n");

	sbl.append("message.setFrom(from);\r\n");

	/// to iz forme
	sbl.append("String to = control.getEmail();\r\n");


	sbl.append("message.addRecipients(Message.RecipientType.TO, to);\r\n");
	   // message.setRecipients(Message.RecipientType.BCC,multibcc);

	  /////////// subject iy forme
	sbl.append("String sub = ConPool.getPrevod(\""+sif.getId()+"L\"+control.getJezik()).replaceAll(\"_\",\" \");\r\n");




	sbl.append("message.setSubject(sub);\r\n");
	
	
	
	sbl.append("MimeBodyPart messageBodyPart =  new MimeBodyPart();\r\n");

	sbl.append("messageBodyPart.setContent(outt.toString(),\"text/html; charset=UTF-8\");\r\n");


	//sbl.append("message.setContent(outt.toString(),\"text/html\");\r\n");

	
sbl.append("Multipart multipart = new MimeMultipart();\r\n");
sbl.append("multipart.addBodyPart(messageBodyPart);\r\n");

    // Part two is attachment
sbl.append("messageBodyPart = new MimeBodyPart();\r\n");
sbl.append("DataSource source =  new FileDataSource(control.getlokacija_pdf_file()+control.getUserName()+\"html_format.html\");\r\n");
sbl.append("messageBodyPart.setDataHandler( new DataHandler(source));\r\n");
sbl.append("messageBodyPart.setFileName(\"html_format.html\");\r\n");
sbl.append("multipart.addBodyPart(messageBodyPart);\r\n");

    // Put parts in message
sbl.append("message.setContent(multipart);\r\n");

	
	
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 16");
	
	

	sbl.append("Transport.send(message);\r\n");
	
	
	
	sbl.append("File lio = new File(control.getlokacija_pdf_file()+control.getUserName()+\"html_format.html\");\r\n");
	sbl.append("lio.delete();\r\n");


	sbl.append("}\r\n");
sbl.append("catch (Exception em) {\r\n");
	//sbl.append("System.out.println(\"Napaka posiljanje maila! \"+em.toString());\r\n");
	sbl.append("org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");
	sbl.append("log.error(em.toString());\r\n");
	sbl.append("napaka = em.toString();\r\n");
	sbl.append("}\r\n");



	
	
	
	sbl.append("%////>\r\n");
	
	sbl.append("<html><head><title>spreminjaj</title></head>\r\n");
	
	sbl.append("<style type=text/css>\r\n");
	sbl.append("@import \"barveold.css\";\r\n");
	sbl.append("@import \"ccss/custom.css\";\r\n");
	sbl.append("@import \"tooltipcss.css\";\r\n");
	sbl.append("@import \"js/uijs2/jquery-ui.css\";\r\n");
	////grafika oz barve

	if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
	sbl.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
	}
	else {

	sbl.append("@import \"barveblue.css\";\r\n");	
	}
					sbl.append("</style>\r\n");
							sbl.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	
	
	sbl.append("<body    "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"  onload=\"mom()\">\r\n");
	sbl.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
	sbl.append("<tr>\r\n");
	sbl.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
	sbl.append("</tr>\r\n");
	sbl.append("<tr>\r\n");
	sbl.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
	sbl.append("<p align=\"center\">< %=ConPool.getPrevod(\""+sif.getId()+"M\"+control.getJezik()).replaceAll(\"_\",\" \") %////> <%=napaka%////> --> <////%=control.getEmail()%////></td>\r\n");
	sbl.append("</tr>\r\n");
	sbl.append("<tr>\r\n");
	sbl.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
	sbl.append("</tr>\r\n");
	sbl.append("</table>\r\n");
	sbl.append("<script language=javascript>\r\n");
	sbl.append("function mom() {\r\n");
	
	if (!nul.jeNull(tml.getTarget_funkcija()).equals("") && !nul.jeNull(tml.getTarget_funkcija_url()+"").equals("")) {

		   com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",servletContext);
	com.popultrade.model.TemplateHead thed = daoth.getTemplateHead(tml.getTarget_funkcija_url());
		

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
	sbl.append(tml.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp<////%=(nul.jeNull(request.getQueryString()).equals(\"\")?\"\":\"?\"+nul.jeNull(request.getQueryString()))%////>';\r\n");

//	sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+"+'<////%=nul.jeNull(request.getParameter(\"nipost\")).equals(\"da\")?\"\":\"?\"+nul.jeNull(request.getQueryString())%////>';\r\n");

		
	}
	
	else if (!nul.jeNull(tml.getTarget_funkcija()).equals("") ) {
		
		sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+";\r\n");

		
	}
//	sbl.append("top.resetPageBlockAll();\r\n");
	
	sbl.append("resetLoadingOverlay();\r\n");

	
	sbl.append("}</script>\r\n");
	
	sbl.append("</body>\r\n");
	
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 17");
	
	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+sif.getId()+"_ml.jsp"), "latin1"));



	out3.write(sbl.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
			
	
			}
catch (Exception ec) {
	System.out.println("Napaka pri generaciji mail lista "+ec.toString());
}


	
	
	return "";
	
	
	
}














//// search








//// end search












////zapisem kontrole za opcijo dropdown po kliku na gumb potrdi
public StringBuffer sbaj = new StringBuffer();
















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



//////////////////
///////////////////
///// ajax za zaklepanje oz. updatanje in dodajanje recordov



public String getAjaxPrisotnost(String vsebina,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,com.popultrade.model.TemplateHead sif,String imefile,String stolpci_or,com.popultrade.model.TemplateUiDodatno tuidd) {

 /////// AJAX KONTROLA
			
			
String premos="";
			
String parametri2 = "";	
if (sif.getVeza_gumb()!=null) {
	
	com.popultrade.dao.TemplateGumbiDAO daodd = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",servletContext);
	com.popultrade.model.TemplateGumbi sifh = new com.popultrade.model.TemplateGumbi();
	
	sifh = daodd.getTemplateGumbi(sif.getVeza_gumb());
	
	List lik = sifh.getTemplateGumbiParametris();
	
	Iterator igy = lik.iterator();
	
	
	boolean prv = false;
	while (igy.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)igy.next();
		 String ehn = "&";
		 if (!prv) {
			 ehn = "?"; 
			 prv=true;
		 }
		 
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
			 parametri2 = parametri2 + ehn+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
				 
		 }
		 else {
		 parametri2 = parametri2 + ehn+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"=< %=request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\")%////>";
		 }


	}
	
}
 

 
			premos +=  "<////%@ page contentType=\"text/html\\;\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////><jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/><jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" /><jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" /><jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" /><jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" /><jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" /><////%\r\n";
		
			
			
			premos += "request.setCharacterEncoding(control.encoding);\r\n";
			premos  += "response.setContentType(\"text/html; charset=\"+control.encoding);\r\n";
			premos  += "response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n";
			premos  +=  "response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n";
			premos  +=  "response.addDateHeader(\"Expires\", 0);\r\n";
			
			
			
			if (!nul.jeNull(tuidd.getDodatno_java_updateinsert()).trim().equals("")) {
				premos +="%////>\r\n<////%!"+nul.jeNull(tuidd.getDodatno_java_updateinsert())+"%////>\r\n<////%";
			}
			
			//premos  +=  "boolean jetr = false;\r\n";
			premos  +=  "if ((control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\")))) {\r\n";
			premos  +=  "%////><jsp:forward page=\"logout.jsp\"/><////%}%////><////%\r\n";
			premos  +=  "try {\r\n";
			premos  +=  "boolean bok=false;\r\n";
			premos  +=  "int stvrstic=0;\r\n";
			 premos  +=  "Hashtable sifhint=new Hashtable();\r\n";
			 premos  +=  "Hashtable sifhintp=new Hashtable();\r\n";
		  premos  +=  "boolean napr=false;\r\n";
		  premos  +=  "boolean  naprjs=false;\r\n";
		 //	 premos  +=  "int br=0;\r\n";
			premos  +=  "if (true ) {\r\n";
			
			
			String dodajk = "";
			
			if (!nul.jeNull(sif.getPrisotnost_polje_kontrola()).trim().equals("")) {
				dodajk = " || !nul.jeNull("+(nul.jeNull(sif.getPrisotnost_polje_kontrola()).trim().equals("")?"\"\"":sif.getPrisotnost_polje_kontrola())+").equals(nul.unscramble(request.getParameter(\"pod\")))";			
				
			}	
			
			premos  +=  "if (request.getParameter(\"stdok\").equals(\"5\") && (!nul.jeNull(control.getUserName()).equals(nul.unscramble(request.getParameter(\"us\"))) "+dodajk+"  ) ) {\r\n";				
			
			premos  +="\r\n%////>NICCCC<////%\r\nreturn;\r\n}\r\n\r\n";	 
			
			
			if (!nul.jeNull(sif.getPrisotnost_polje_kontrola()).trim().equals("")) {
				dodajk = " || nul.jeNull("+(nul.jeNull(sif.getPrisotnost_polje_kontrola()).trim().equals("")?"\"\"":sif.getPrisotnost_polje_kontrola())+").equals(nul.unscramble(request.getParameter(\"pod\")))";			
				
			}
				
			
			premos  +=  "if (!request.getParameter(\"clasn\").equals(\""+imefile+"\")) {\r\n";				
			
			premos  +="\r\n%////>NICCCC<////%\r\nreturn;\r\n}\r\n\r\n";	 
			
				
			premos  +=  "if (!request.getParameter(\"clasn\").equals(\""+imefile+"\") && (nul.jeNull(control.getUserName()).equals(nul.unscramble(request.getParameter(\"us\"))) "+dodajk+"  ) ) {\r\n";				
							
			premos  +="\r\n%////>NICCCC<////%\r\nreturn;\r\n}\r\n\r\n";	 
						
			
			
			
			
			premos  +="String dodpog = \"\";\r\n";


			premos  +="com.popultrade.model."+imefile +" sif = new com.popultrade.model."+imefile +"();\r\n";


			//// setam pogoje za sif
			String dodaten_sql_pogoj = "";

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
					premos  +="sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n";	
				}
				else {
					
					premos  +=nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n";
					premos  +="sif."+tcc.getIme_pogoja()+"("+ rett+");\r\n";
					premos  +=" }\r\n";
				
				}
				
				}
				else {
					
					if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
						premos  +=nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n";
					}
					if (!sem) {
						dodaten_sql_pogoj = nul.jeNull(tcc.getDodaten_hql_pogoj()) ;
						sem=true;
						}
						else {
							dodaten_sql_pogoj =  "  "+nul.jeNull(tcc.getDodaten_hql_pogoj());
						}
					premos  +="dodpog += (!dodpog.equals(\"\")?\" and \":\"\")+ \""+dodaten_sql_pogoj+"\";\r\n";
						
					
					if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
						premos  +=" }\r\n";
					}
				}
				
				}
				
				
			}

			premos  +="String dodaten_sql_pogoj = dodpog;\r\n";
			
			
			
			
			
			
			if (!nul.jeNull(sif.getNosql()).equals("1")) {
				
				
				
			
			premos  +=  "com.popultrade.dao."+sif.getHead_class_name()+"DAO doax =(com.popultrade.dao."+ sif.getHead_class_name()+"DAO)contextUtil.getBeanDao(\""+sif.getHead_class_name().substring(0,1).toLowerCase() +sif.getHead_class_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";
				
			
			
			
				}
				else {
					
					premos  +=  "com.popultrade.dao."+sif.getHead_class_name()+"DAO doax = new com.popultrade.dao."+sif.getHead_class_name()+"DAO();\r\n";

				}
			
			
			premos  +=  "com.popultrade.model."+sif.getHead_class_name() +" vseb=null;\r\n";
			premos += "try {\r\n";
			
			
			
			
			if (!nul.jeNull(sif.getNosql()).equals("1")) {
			//premos  +=  " vseb  = doax.get"+sif.getHead_class_name()+"(new Long(nul.jeNullDefault(request.getParameter(\"iddok\"))));\r\n";
			premos  +=  "sif.setId(new Long(nul.jeNullDefault(request.getParameter(\"iddok\"))));\r\n";
			
			premos  +=  "List lis = doax.get"+imefile +"s(sif,1,1,dodaten_sql_pogoj,\"\",\"\");\r\n";

			premos  +=  "if (lis!=null && lis.size()==1) {\r\n";
			
				premos  +=  "vseb = (com.popultrade.model."+sif.getHead_class_name() +")lis.get(0);\r\n";
			premos  +=  "}\r\n";
			premos  +=  "else {\r\n";
				
				premos +="\r\n%////>DELETED<////% return;\r\n";
			premos  +=  "}\r\n";
			
			
			
			}
			else {
			//	premos  +=  " vseb  = doax.get"+sif.getHead_class_name()+"(nul.jeNullDefault(request.getParameter(\"iddok\")),ConPool.getEntman());\r\n";
		premos  +=  "sif.setId(nul.jeNullDefault(request.getParameter(\"iddok\")));\r\n";
			
			premos  +=  "List lis = doax.get"+imefile +"s(sif,ConPool.getEntman(),\"\",1,1);\r\n";

			premos  +=  "if (lis!=null && lis.size()==1) {\r\n";
			
				premos  +=  "vseb = (com.popultrade.model."+sif.getHead_class_name() +")lis.get(0);\r\n";
			premos  +=  "}\r\n";
			premos  +=  "else {\r\n";
				
				premos +="\r\n%////>DELETED<////% return;\r\n";
			premos  +=  "}\r\n";
			
			}
			
			
			premos +="}\r\ncatch (Exception ecv){\r\n%////>DELETED<////% return;\r\n}\r\n";


			
premos  +="String stolpci =nul.jeNull(control.getColumnsUser(contextUtil,pageContext.getServletContext(),\""+imefile +""+sif.getId()+"\"));\r\n";

	     premos  +="if (stolpci.equals(\"\")) {\r\n";
          
premos  +="stolpci=\""+stolpci_or+"\";\r\n";
     
     premos  +="}\r\n\r\n";
     
     
     vsebina = vsebina.substring(0,vsebina.indexOf("//---ZACETEKZAAJAX2x---"))+ vsebina.substring(vsebina.indexOf("//---ZACETEKZAAJAX3x---"));
     
     
     
			premos  +=  vsebina.substring(0,vsebina.indexOf("//---ZACETEKZAAJAX1---")+22)+"\r\n";
	
			
			
			premos  +="\r\n"+nul.jeNull(tuidd.getDodatno_java_rocno())+"\r\n";
			premos  +="\r\n"+nul.jeNull(tuidd.getDodatno_java_rocno2())+"\r\n";
			
			
		premos  += "if (true) {\r\n";
			
	//premos  += 
			//if (vsebina.indexOf("//---ZACETEKZAAJAX3---")!=-1) {
		//String delok=	vsebina.substring(vsebina.indexOf("//---ZACETEKZAAJAX2---")+22).replace("colors[br]", "\"plava1\"")+"\r\n";
	
//	premos += delok.substring(0,vsebina.indexOf("//---ZACETEKZAAJAX3---"))+"\r\n"+vsebina.substring(vsebina.indexOf("//---ZACETEKZAAJAX4---")+22);
		//	}
			//else {
				premos  += vsebina.substring(vsebina.indexOf("//---ZACETEKZAAJAX2---")+22).replace("colors[br]", "request.getParameter(\"barp\")")+"\r\n";
			//}

	 	
			premos  +=  "}\r\n";
			premos  +=  "}\r\n";
			premos  +=  "catch (Exception ex){\r\n";
			premos  +=  "org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n";
			
			premos  +=  "log.error(ex.toString());\r\n";
			premos  +=  "}%////>\r\n";
			
		
			try {
			/// shranim file za ajax
			
			Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+sif.getHead_class_name().toLowerCase()+sif.getId()+"_pri.jsp"), "latin1"));



			out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
			////zaprem writer3
			out3.close();
			//String velike_crke = nul.jeNull(tu.getSamo_velike_crke());

			
			//	return "  autocomplete=\"off\"  onfocus=\""+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"')\" onkeyup=\""+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"')\" ";
			
			}
			catch (Exception exx) {
				System.out.println("NAPAKA AJAX prisotnost::: "+exx.toString());
			
			}
			
			
			premos = "";
			
			
			//// za ajax dodatna funkcija



	premos = premos + "function prisotnostUID(idtr,stdok,clasn,us,pod,pagnn) {\r\n";
	 
	
	premos = premos + "prisotnostUID2(idtr,stdok,clasn,us,pod,pagnn,'"+imefile+"_list"+sif.getId()+"','"+sif.getHead_class_name().toLowerCase()+sif.getId()+"_pri.jsp"+"','<////%=ConPool.getQueryStringFromRequest(request)%////>');\r\n";
	
	
	//premos = premos + "alert(pagnn); \r\n";
/*	premos = premos + "if (pagnn!='"+imefile+"_list"+sif.getId()+"'  && stdok==6) {\r\n";
	
	premos = premos + "return; \r\n";
 	premos = premos + "} \r\n";
	
 	
 	premos = premos + "if (document.getElementById(\"spr\"+idtr)==null && stdok!=5) {\r\n";
 	premos = premos + "return; \r\n";
 	premos = premos + "} \r\n";
	premos = premos + "if (document.getElementById(\"spr\"+idtr)!=null && stdok==6) {\r\n";
	 premos = premos + "var row = document.getElementById('spr'+idtr);\r\n";
	premos = premos + "row.parentNode.removeChild(row);\r\n";
		premos = premos + "return; \r\n";
	 	premos = premos + "} \r\n";
	 
	 
	premos = premos + "xmlHttp=GetXmlHttpObject();\r\n";
	premos = premos + "if (xmlHttp==null) {\r\n";
	premos = premos + "alert (\"Browser does not support HTTP Request\");\r\n";
	premos = premos + "return false;\r\n";
	premos = premos + "} \r\n";
	 
	premos = premos + "var url=\""+sif.getHead_class_name().toLowerCase()+sif.getId()+"_pri.jsp"+"\";\r\n";
	
	if (!parametri2.equals("")) {
	premos = premos +"url=url+\""+ parametri2+"\";\r\n";
	}
	premos = premos + "var barvaprej = document.getElementById(\"spr\"+idtr).className;\r\n";
	premos = premos + "url=url+\""+(parametri2.equals("")?"?":"&")+"stdok=\"+stdok+\"&iddok=\"+idtr+\"&clasn=\"+clasn+\"<////%=ConPool.getQueryStringFromRequest(request)%////>\";\r\n";
	premos = premos + "url=url+\"&us=\"+us+\"&pod=\"+pod+\"&barp=\"+barvaprej;\r\n";
	
	premos = premos + "url=url+\"&sid=\"+Math.random();\r\n";
	 
	premos = premos + "xmlHttp.open(\"POST\",url,false);\r\n";
	premos = premos + "xmlHttp.send(null);\r\n";
premos = premos + "if (xmlHttp.responseText.indexOf(\"NICCCC\")!=-1) {\r\n";

		premos = premos + "}\r\n";
	premos = premos + "else if (xmlHttp.responseText.indexOf(\"DELETED\")!=-1) {\r\n";
	//premos = premos + "alert('deleted');\r\n";
	premos = premos + "}\r\n";
	premos = premos + "else {\r\n";
	premos = premos + "if (document.getElementById(\"spr\"+idtr)!=null && stdok!=5) {\r\n";
	
	
	premos = premos + "$(\"#spr\"+idtr+\"\").replaceWith(xmlHttp.responseText);\r\n";
//	premos = premos + "document.getElementById(\"spr\"+idtr).className=barvaprej;\r\n";
	premos = premos + "}\r\n";
	premos = premos + "else {\r\n";
	
//	premos = premos + "alert(xmlHttp.responseText);\r\n";
	premos = premos + "$(\"#table2 tr\").eq(1).before(xmlHttp.responseText);\r\n";
	
	premos = premos + "barvaprej=\"plava1\";\r\n";
	premos = premos + "var prevElem = document.getElementById(\"spr\"+idtr).nextElementSibling;\r\n";
	premos = premos + "if (prevElem!=null && prevElem.nodeName=='TR' && (prevElem.id+\"\").indexOf(\"spr\")!=-1) {\r\n";
	premos = premos + "barvaprej=prevElem.className+\"\";\r\n";
	premos = premos + "}\r\n";
	premos = premos + "if (barvaprej==\"plava1\") {\r\n";
	premos = premos + "barvaprej=\"plava2\";\r\n";
	premos = premos + "}\r\n";
	premos = premos + "else {\r\n";
	premos = premos + "barvaprej=\"plava1\";\r\n";
	premos = premos + "}\r\n";
	premos = premos + "document.getElementById(\"spr\"+idtr).className=barvaprej;\r\n";
	

	
	premos = premos + "}\r\n";
	premos = premos + "}\r\n";	*/
	premos = premos + "}\r\n";	
			
			return premos;
			

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
    sbu.append("<script type=\"text/javascript\" src=\"scripts/jquery-migrate.min.js\"></script>\r\n");
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
//// kreacija jsp za list
if (sif.getHead_tip().equals("LI")) {
	
	System.out.println("Izdelujem LIST jsp");
	if (true) {
	
	//// odstranim iz cache
	
	if (ConPool.cache.containsKey("jsp"+sif.getId()+control.getJezik())) {
		ConPool.cache.remove("jsp"+sif.getId()+control.getJezik());
	}

///// dodatni pogoji, v javi
com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();

com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());

tuidd = daouid.getTemplateUiDodatnos(idpr);




	 String parametriSE = ""; // parametri za search, parmetri ki setirajo stran ostevilcenje ker qurystring je kot post

sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.net.URLDecoder\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
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

sb.append("// stevilo prikazov vrstic\r\n");

sb.append("int stpri = control.st_vrstic;\r\n");


/////////// reset narocil v obdelavi od tega userja
///// brisem iz obdelave, ce je kakega obdeloval
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,\"\",new Date(),3,\""+imefile+"_list"+sif.getId()+"\");\r\n");

// steje stevilo vrstic
sb.append("int stej = 0;\r\n");

// barve vrstic


if (nul.jeNull(sif.getStruktura_tree_head()).equals("1")) {
sb.append("String[] colors = {\"svetlosiva\",\"svetlosiva2\",\"silver2\"};\r\n");
}
else {
sb.append("String[] colors = {\"plava1\",\"plava2\",\"silver\"};\r\n");
}




// stevilo vrstic
sb.append("int stvrstic=0;\r\n");

sb.append("boolean iskanje=false;\r\n");
sb.append("boolean lahkobrise=true;\r\n");








		sb.append("try {\r\n");   
		
		if (!nul.jeNull(tuidd.getDodatno_update()).equals("")) {
		sb.append(nul.jeNull(tuidd.getDodatno_update())+"\r\n");
		}
		
		
		
		
		

// get list from daoobject

if (!nul.jeNull(sif.getNosql()).equals("1")) {
sb.append("com.popultrade.dao."+imefile +"DAO dao = (com.popultrade.dao."+imefile +"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length()) +"DAO\",pageContext.getServletContext());\r\n");

}
else {
	
	sb.append("com.popultrade.dao."+imefile+"DAO dao = new com.popultrade.dao."+imefile+"DAO();\r\n");

}
sb.append("if (request.getParameter(\"akcijaXY\")!=null && request.getParameter(\"akcijaXY\").equals(\"DELETE\"))  {\r\n");



com.popultrade.dao.TemplateGumbiDAO daokum = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());
com.popultrade.model.TemplateGumbi sifk = new com.popultrade.model.TemplateGumbi();

sifk.setTemplatehead_id(sif.getId());

List likm = daokum.getTemplateGumbis(sifk);

String gumbid="";
if (likm.size()>0) {
	
	
	Iterator itm = likm.iterator();
	
	while (itm.hasNext()) {
		
		com.popultrade.model.TemplateGumbi si = (com.popultrade.model.TemplateGumbi)itm.next();
		
		if (si.getKlici_funkcijo()!=null && si.getKlici_funkcijo().equals("Brisi")) {
			
			gumbid = si.getId()+"";
			break;
		}
		
	}
	
}

if (!gumbid.equals("")) {
com.popultrade.model.TemplateClass dgum =new com.popultrade.model.TemplateClass();
com.popultrade.dao.TemplateClassDAO tgum = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

	
dgum = tgum.getTemplateClassDodatnos(gumbid+"");


if (dgum!=null && dgum.getDodaten_hql_pogoj()!=null && !dgum.getDodaten_hql_pogoj().trim().equals("")) {
	sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n\r\n");
sb.append("com.popultrade.model."+imefile+" vsebkont =new com.popultrade.model."+imefile+"();\r\n");

if (!nul.jeNull(sif.getNosql()).equals("1")) {
sb.append("com.popultrade.dao."+imefile+"DAO daokont = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");
sb.append("vsebkont = daokont.get"+imefile+"(new Long(request.getParameter(\"id\")));\r\n");

}
else {
	
	sb.append("com.popultrade.dao."+(nul.jeNull(sif.getHead_class_name_nosql()).equals("")?imefile:sif.getHead_class_name_nosql())+"DAO daokont = new com.popultrade.dao."+(nul.jeNull(sif.getHead_class_name_nosql()).equals("")?imefile:sif.getHead_class_name_nosql())+"DAO();\r\n");
	sb.append("vsebkont = daokont.get"+(nul.jeNull(sif.getHead_class_name_nosql()).equals("")?imefile:sif.getHead_class_name_nosql())+"(request.getParameter(\"id\"),ConPool.getEntman());\r\n");
	
}


sb.append("if (vsebkont!=null && vsebkont.getId()!=null) {\r\n");

//sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("control.geet", "control.get")+") {\r\n");
sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("getTime", "geetTime").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("control.users.get", "control.users.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("geetTime", "getTime").replaceAll("control.geet", "control.get").replaceAll("control.users.geet", "control.users.get")+") {\r\n");


sb.append("lahkobrise=true;\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("lahkobrise=false;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
}
}

sb.append("if (lahkobrise){\r\n");

sb.append("try {\r\n");





if (!nul.jeNull(sif.getNosql()).equals("1")) {

sb.append("dao.remove"+(nul.jeNull(sif.getHead_class_name_nosql()).equals("")?imefile:sif.getHead_class_name_nosql()) +"(new Long(request.getParameter(\"id\")));\r\n");
}
else {
	if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {
		sb.append("com.popultrade.model."+imefile+" vsebm = dao.get"+imefile+"(request.getParameter(\"idem\"),ConPool.getEntman());\r\n");

	sb.append("List gumx = vsebm.get"+sif.getHead_class_name_nosql()+"();\r\n");
	
	//sb.append("String idnox = nul.createID();\r\n");
	sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n");
	sb.append("Iterator itox=gumx.iterator();\r\n");

	
	/// dodaj loop embeddable
	
	sb.append(getEmbeddableLoop(sif,1,imefile));
	
	sb.append("}\r\n");
	//sb.append("vseb.setId(idnox);\r\n");
	//sb.append("gumx.add(vseb);\r\n");
	sb.append("vsebm.set"+sif.getHead_class_name_nosql()+"(gumx);\r\n");
	
	sb.append("dao.save"+imefile+"(vsebm,ConPool.getEntman());\r\n");	
	
	/// remove from embeddable
	sb.append("com.popultrade.dao."+nul.jeNull(sif.getHead_class_name_nosql()) +"DAO daodx = new com.popultrade.dao."+nul.jeNull(sif.getHead_class_name_nosql()) +"DAO();\r\n");
	sb.append("daodx.remove"+nul.jeNull(sif.getHead_class_name_nosql()) +"(request.getParameter(\"id\"),ConPool.getEntman());\r\n");	
	
	
	
	}
	
	else {

	sb.append("dao.remove"+(nul.jeNull(sif.getHead_class_name_nosql()).equals("")?imefile:sif.getHead_class_name_nosql()) +"(request.getParameter(\"id\"),ConPool.getEntman());\r\n");	
	
	}
	
	
}


sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,request.getParameter(\"id\")+\"\",new Date(),6,\""+imefile+"\",control.getUserName(),"+(nul.jeNull(sif.getPrisotnost_polje_kontrola()).equals("")?"\"\"":"sif.getPrisotnost_polje_kontrola()")+",\""+imefile+"_list"+sif.getId()+"\");\r\n");

sb.append("}catch (Exception ec){\r\n");
sb.append("}\r\n");
//sb.append("dao.remove"+imefile +"(new Long(request.getParameter(\"id\")));\r\n");




//// dodatno klicem update zaporednih stevilk


if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_delete()!=null && !sif.getTemplateUiDodatno().getDodatno_delete().equals("")) {
	if (!nul.jeNull(sif.getNosql()).equals("1")) {
	sb.append("dao.remove"+imefile+"resetZapst(\""+sif.getTemplateUiDodatno().getDodatno_delete()+"\",request.getParameter(\"zapst\"));\r\n");
	}
}
//////// dodatne funkcije pri delete 
if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_java()!=null && !sif.getTemplateUiDodatno().getDodatno_java().equals("")) {



		
		String vru  = sif.getTemplateUiDodatno().getDodatno_java().trim();
		
		if (vru.indexOf("\n")!=-1) {
			
			
			String[] splu = vru.split("\n");
			
			for (int i=0;i<splu.length;i++) {
				if (splu[i].indexOf("[F")!=-1) {
					
					
					sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),splu[i].substring(splu[i].indexOf("[F")+2,splu[i].indexOf("]"))));
					
					
					
					//sb.append("vseb."+splu[i].substring(0,splu[i].indexOf("'"))+getFormatReturn(imefile,splu[i].substring(0,splu[i].indexOf("(")),"rezu")+splu[i].substring(vru.lastIndexOf("'")+1,splu[i].length())+"\r\n");
					
					
				}
				}
			
			
			
		}
		else if (!vru.equals("")) {
			//sb.append("vseb."+vru+";\r\n");
		 if (vru.indexOf("[F")!=-1) {
					
					
					sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),vru.substring(vru.indexOf("[F")+2,vru.indexOf("]"))));
					//sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+getFormatReturn(imefile,vru.substring(0,vru.indexOf("(")),"rezu")+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
				}
		}
		
		
		
	
	
	
	
	
	
	
	
	
	
	
}

sb.append("}\r\n");

sb.append("}\r\n");





sb.append("int pagenum=1;\r\n");
sb.append("int stizpisov=stpri;\r\n");

sb.append("if (request.getParameter(\"pagenumber\")!=null && !request.getParameter(\"pagenumber\").equals(\"\")) {\r\n");

sb.append("pagenum = Integer.parseInt(request.getParameter(\"pagenumber\"));\r\n");
sb.append("session.setAttribute(\"pagenumber"+imefile +""+sif.getId()+"\",pagenum+\"\");\r\n");
sb.append("}\r\n");

sb.append("else {\r\n");
sb.append("session.setAttribute(\"pagenumber"+imefile +""+sif.getId()+"\",1+\"\");\r\n");
sb.append("}\r\n");


/*
sb.append("else {\r\n");
sb.append("if (session.getAttribute(\"pagenumber"+imefile +""+sif.getId()+"\")!=null) {\r\n");
sb.append("if (!nul.jeNull(request.getParameter(\"isci\")).equals(\"yes\")) {\r\n");
sb.append("pagenum = Integer.parseInt(session.getAttribute(\"pagenumber"+imefile +""+sif.getId()+"\")+\"\");\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("session.removeAttribute(\"pagenumber"+imefile +""+sif.getId()+"\");\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("}\r\n");*/




sb.append("if (control.removePageNum) {\r\n");
sb.append("pagenum=1;\r\n");
//sb.append("session.setAttribute(\"pagenumber"+imefile +""+sif.getId()+"\",pagenum+\"\");\r\n");
sb.append("control.removePageNum=false;\r\n");
sb.append("}\r\n");


//// zaporedje stolpcev
sb.append("String stolpci =nul.jeNull(control.getColumnsUser(contextUtil,pageContext.getServletContext(),\""+imefile +""+sif.getId()+"\"));\r\n");
//sb.append("String stolpci = \""+imefile +""+sif.getId()+"\",pagenum+\"\");\r\n");




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

if (nul.jeN(sif.getHead_class_name_nosql()).trim().equals("")) {


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
}
sb.append("String dodaten_sql_pogoj = dodpog;\r\n");
sb.append("String sedodatno = \"\";\r\n");
sb.append("String metodo = \"\";\r\n");
///////// searchi

sb.append("if (nul.jeNull(request.getParameter(\"isci\")).equals(\"yes\")) {\r\n");
sb.append("iskanje = true;\r\n");
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
		
	String uplow = "";
		
		if  (nul.jeNull(si.getSeupper()).equals("1")) {
		uplo=".toUpperCase()";
		uplow = "Upper(";
		}
		if  (nul.jeNull(si.getSelower()).equals("1")) {
		uplo=".toLowerCase()";
		uplow = "Lower(";
		}
		
		
		
		sb.append("if (!nul.jeNull(request.getParameter(\""+metod+"\")).equals(\"\")) {\r\n");
		//sb.append("metodo=	\" "+uplow+metod+(uplow.equals("")?"":")")+"+URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+metod+"\"))"+(uplo)+")+\"\", \"UTF-8\")+\""+(desno)+"' and \";\r\n");
		
		sb.append("metodo=	\" "+uplow+metod+(uplow.equals("")?"":")")+" like '"+(levo)+"\"+nul.jeNullEscapeSQL(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter(\""+metod+"\"))"+(uplo)+")+\"\", \"UTF-8\"))+\""+(desno)+"' and \";\r\n");
		
		
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


//sb.append("dodaten_sql_pogoj += (!dodaten_sql_pogoj.equals(\"\")?(sedodatno.equals(\"\")?\"\":\" and \"+sedodatno):\"\");\r\n");
sb.append("dodaten_sql_pogoj += (!dodaten_sql_pogoj.equals(\"\")?(sedodatno.equals(\"\")?\"\":\" and \"):\"\")+ sedodatno;\r\n");
	


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


sb.append("session.setAttribute(\""+imefile.toLowerCase() +"_search\",sif);\r\n");
if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql((Object)sif, ConPool, null, null, control, \"search list "+imefile+"\");");
}
sb.append("}\r\n");
sb.append("else if (nul.jeNull(request.getParameter(\"isk\")).equals(\"1\")) {\r\n");
sb.append("iskanje = true;\r\n");
sb.append("sif = (com.popultrade.model."+imefile +")session.getAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");
if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql((Object)sif, ConPool, null, null, control, \"search list "+imefile+"\");");
}
sb.append("}\r\n");
sb.append("else {\r\n");
if (nul.jeNull(sif.getLogall()).equals("1")) {	

sb.append("ConPool.addToNoSql((Object)sif, ConPool, null, null, control, \"list "+imefile+"\");");
}
sb.append("session.removeAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");
sb.append("}\r\n");















sb.append("List lis =null;\r\n");

if (!nul.jeNull(sif.getNosql()).equals("1")) {

if (nul.jeNull(sif.getUporabi_count()).equals("1")) {
	
	sb.append("int strec = dao.getSt"+imefile +"(sif,dodaten_sql_pogoj);\r\n");

} 
else if (nul.jeNull(sif.getUporabi_count_ld()).equals("1")) {

}
else {
	
	
	if (nul.jeNull(sif.getPosebna_funkcija()).equals("") ) {
	
		
		sb.append("lis = dao.get"+imefile +"s(sif,1,"+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+""):"200")+",dodaten_sql_pogoj,\"\",\"\");\r\n");
	
	}
	else {
		
	if (!nul.jeNull(sif.getPosebna_funkcija_pogoj()).equals("")) {
		sb.append(sif.getPosebna_funkcija_pogoj() + " {\n\r");
		
		
	}
		sb.append("lis = dao."+sif.getPosebna_funkcija() +"(sif,1,"+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+""):"200")+",dodaten_sql_pogoj,\"\",\"\");\r\n");
		if (!nul.jeNull(sif.getPosebna_funkcija_pogoj()).equals("")) {
			sb.append(" }\r\nelse {\n\r");
			sb.append("lis = dao.get"+imefile +"s(sif,1,"+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+""):"200")+",dodaten_sql_pogoj,\"\",\"\");\r\n");
			
			sb.append(" }\r\n\n\r");
		}
	}
	
	sb.append("int strec = lis.size();\r\n");
}

if (nul.jeNull(sif.getUporabi_count_ld()).equals("1")) {

	if (nul.jeNull(sif.getPosebna_funkcija()).equals("")) {
	sb.append("lis = dao.get"+imefile +"s(sif,pagenum,"+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+"")+"+1":"200+1")+",dodaten_sql_pogoj,orderby,orderbysmer);\r\n");
	}
	else {
		if (!nul.jeNull(sif.getPosebna_funkcija_pogoj()).equals("")) {
			sb.append(sif.getPosebna_funkcija_pogoj() + " {\n\r");
			
			
		}
		sb.append("lis = dao."+sif.getPosebna_funkcija() +"(sif,pagenum,"+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+"")+"+1":"200+1")+",dodaten_sql_pogoj,orderby,orderbysmer);\r\n");

		if (!nul.jeNull(sif.getPosebna_funkcija_pogoj()).equals("")) {
			sb.append(" }\r\nelse {\n\r");
			sb.append("lis = dao.get"+imefile +"s(sif,pagenum,"+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+"")+"+1":"200+1")+",dodaten_sql_pogoj,orderby,orderbysmer);\r\n");

			sb.append(" }\r\n\n\r");
			
			
		}
	}
	sb.append("int strec = "+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+""):"200")+";\r\n");
	}
	else {
		if (nul.jeNull(sif.getPosebna_funkcija()).equals("")) {
		sb.append("lis = dao.get"+imefile +"s(sif,pagenum,stizpisov,dodaten_sql_pogoj,orderby,orderbysmer);\r\n");
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
		
	}


}
else {
	
	
	/// v primeru da gre za embeddable
	
	if (!nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {
		
		
	///
	
//	sb.append("com.popultrade.model."+sif.getHead_class_name_nosql() +" sif2 = new com.popultrade.model."+sif.getHead_class_name_nosql() +"();\r\n");
	//sb.append("sif2.setId(request.getParameter(\"idem\"));\r\n");
	
		sb.append("com.popultrade.dao."+sif.getHead_class_name() +"DAO daom = new com.popultrade.dao."+sif.getHead_class_name() +"DAO();\r\n");
		//sb.append("List lisk = daom.get"+sif.getHead_class_name_nosql() +"s(sif2,ConPool.getEntman(),orderby+orderbysmer,pagenum,stizpisov);\r\n");
		
		sb.append("com.popultrade.model."+sif.getHead_class_name()+" vsebm = dao.get"+(nul.jeNull(sif.getHead_class_name()).equals("")?imefile:sif.getHead_class_name())+"(request.getParameter(\"idem\"),ConPool.getEntman());\r\n");

		
		
		sb.append("int strec = 0;\r\n");
		//sb.append("if (lisk.size()>0) {\r\n");
		
		if (!nul.jeNull(sif.getHead_class_name_nosql2()).equals("")) {
		
						
			sb.append("List gumx2 = vsebm.get"+sif.getHead_class_name_nosql2()+"();\r\n");

			sb.append("Iterator itox2=gumx2.iterator();\r\n");
			sb.append("while (itox2.hasNext()) {\r\n");
			sb.append("com.popultrade.model."+sif.getHead_class_name_nosql2() +" modix2 = (com.popultrade.model."+sif.getHead_class_name_nosql2() +")itox2.next();\r\n");
			
			
			sb.append("if (modix2.getId().equals(request.getParameter(\"idem2\"))) {\r\n");
			
			if (nul.jeNull(sif.getHead_class_name_nosql3()).equals("")) {
			sb.append("lis = modix2.get"+sif.getHead_class_name_nosql2()+"();\r\n");
			sb.append("break;\r\n");
			}
			else {
				
				
				sb.append("List gumx3 = modix2.get"+sif.getHead_class_name_nosql3()+"();\r\n");

				sb.append("Iterator itox3=gumx3.iterator();\r\n");
				sb.append("while (itox3.hasNext()) {\r\n");
				sb.append("com.popultrade.model."+sif.getHead_class_name_nosql3() +" modix3 = (com.popultrade.model."+sif.getHead_class_name_nosql3() +")itox3.next();\r\n");
				
				
				sb.append("if (modix3.getId().equals(request.getParameter(\"idem3\"))) {\r\n");
				sb.append("lis = modix3.get"+sif.getHead_class_name_nosql2()+"();\r\n");
				sb.append("break;\r\n");
				sb.append("}\r\n");
				sb.append("}\r\n");
				
				
			}
			
			
			sb.append("}\r\n");
			sb.append("}\r\n");
			
		}
		else {
			
		
		sb.append("lis = vsebm.get"+sif.getHead_class_name_nosql()+"();\r\n");
		
		
		
		}
		
		sb.append("strec = lis.size();\r\n");
		
		
		//sb.append("}\r\n");
		//sb.append("else {\r\n");
		//sb.append("return;\r\n");
		//sb.append("}\r\n");
		
		
		
		
	}
	
	else {
		sb.append("com.popultrade.dao."+imefile +"DAO daom = new com.popultrade.dao."+imefile +"DAO();\r\n");
	sb.append("lis = daom.get"+imefile +"s(sif,ConPool.getEntman(),orderby+orderbysmer,pagenum,stizpisov);\r\n");

	
	if (nul.jeNull(sif.getUporabi_count()).equals("1")) {
		sb.append("int strec = daom.getSt"+imefile +"(sif,ConPool.getEntman());\r\n");
	}
	else if (nul.jeNull(sif.getUporabi_count_ld()).equals("1")) {
		sb.append("int strec = "+((!nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("") && !nul.jeNull(sif.getMax_stevilo_recordov()+"").equals("0"))?nul.jeNull(sif.getMax_stevilo_recordov()+""):"200")+";\r\n");
		
	}
	else {
	sb.append("int strec = lis.size();\r\n");
	}
}
	
}













//// dodatno funkcije v !

if (!nul.jeNull(tuidd.getDodatno_java_updateinsert()).trim().equals("")) {
	sb.append("%////>\r\n<////%!"+nul.jeNull(tuidd.getDodatno_java_updateinsert())+"%////>\r\n<////%");
}


sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_java_rocno())+"\r\n");
sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_java_rocno2())+"\r\n");
sb.append("String dodo=\"\";\r\n");  

	sb.append("String dodo1=\"style='background-image:url(\\\"orderbydot.gif\\\"); background-position:right;background-repeat:no-repeat;width:XXX'\";\r\n");  

	sb.append("String dodo2=\"style='background-image:url(\\\"orderbydos.gif\\\"); background-position:right;background-repeat:no-repeat;width:XXX'\";\r\n"); 

	sb.append("String dodo3=\"style='background-image:url(\\\"orderbyupt.gif\\\"); background-position:right;background-repeat:no-repeat;width:XXX'\";\r\n");  

	sb.append("String dodo4=\"style='background-image:url(\\\"orderbyups.gif\\\"); background-position:right;background-repeat:no-repeat;width:XXX'\";\r\n"); 
	
	sb.append("String dodo5=\"style='background-image:url(\\\"orderbyt.gif\\\"); background-position:right;background-repeat:no-repeat;width:XXX'\";\r\n");  

	sb.append("String dodo6=\"style='background-image:url(\\\"orderbys.gif\\\"); background-position:right;background-repeat:no-repeat;width:XXX'\";\r\n"); 
	
	
	
sb.append("%////>\r\n");


sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");


sb.append("<html><head><title></title></head>\r\n");
sb.append("<style>\r\n");
sb.append("body {\r\n");
sb.append("overflow-x:hidden;\r\n");
sb.append("}\r\n");
sb.append("A:hover{color:red}\r\n");
sb.append("#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}\r\n");
sb.append("DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;\r\n");
sb.append("background-color:Silver; layer-background-color:2686D8}\r\n");
sb.append("</style>\r\n");
sb.append("<link type='text/css' href='styles/basic.css' rel='stylesheet' media='screen' />\r\n");
sb.append("<link type='text/css' href='styles/basic_ie.css' rel='stylesheet' media='screen' />\r\n");


sb.append("<style type=text/css>\r\n");

sb.append("@import \"barveold.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"ccss/custom.css\";\r\n");
sb.append("@import \"js/jquery.contextmenu.css\";\r\n");

if (sif.getTarget_search_rocno()!=null && !sif.getTarget_search_rocno().equals("")) {
sb.append("@import \"css_dat/"+sif.getTarget_search_rocno()+"\";\r\n");	
}
else {
	
sb.append("@import \"sbuttoni.css\";\r\n");	
}


//sb.append("@import \"sbuttoni.css\";\r\n");



//// grafika oz barve

if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
sb.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
}
else {
	
sb.append("@import \"barveblue.css\";\r\n");	
}





 //// NI VEC DANO V DODATEN CSS V ADMIN MODUL
if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {
	
	
/*
	sb.append("td.pado {\r\n");	
	sb.append("padding-left:4;\r\n");	
sb.append("align:center;\r\n");	

sb.append("}\r\n");	



sb.append("ul.tree, ul.tree ul {\r\n");	
	 sb.append(" list-style-type: none;\r\n");	
 sb.append(" background: url(vline.png) repeat-y;\r\n");	
 sb.append(" margin: 0;\r\n");	
 sb.append(" padding: 0;\r\n");	
 sb.append("}\r\n");	
   
 sb.append("ul.tree ul {\r\n");	
	   sb.append(" margin-left: 10px;\r\n");	
   sb.append("}\r\n");	

   sb.append("ul.tree li {\r\n");	
	   sb.append(" margin: 0;\r\n");	
   sb.append("padding: 0 12px;\r\n");	
   sb.append("line-height: 25px;\r\n");	
   sb.append("background: url(node.png) no-repeat;\r\n");	
    // color: #369;
   //  font-weight: bold;
   sb.append("font-family:verdana;\r\n");	
   sb.append("font-size:17px;\r\n");	
		   sb.append("}\r\n");	

   sb.append("ul.tree li.last {\r\n");	
	   sb.append(" background: #fff url(lastnode.png) no-repeat;\r\n");	
   sb.append("}\r\n");	
   
   sb.append("ul.tree li:last-child {\r\n");	
	   sb.append("background: #fff url(lastnode.png) no-repeat;\r\n");	
   sb.append("}\r\n");	
   
	*/
	
}


if (!nul.jeNull(tuidd.getDodatno_css()).equals("")) {
	
	sb.append(tuidd.getDodatno_css()+"\r\n");
	
}

sb.append("</style>\r\n");



sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");

sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"tooltip.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");

sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/jquery-migrate.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");


sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"js/jquery.contextmenu.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"js/jquery.blockUI.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
// loading overlay 
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"js/jquery.babypaunch.spinner.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"js/showOverlay.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");


sb.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script type='text/javascript' src='js/jquery.simplemodal.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
sb.append("<script type='text/javascript' src='js/basic.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
sb.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");




sb.append("<script language=javascript>\r\n");




////////// potrditev brisanja
sb.append("function vprasaj2(alerto,resett,iddd,sem) {\r\n");
sb.append("  var a = window.confirm(alerto);\r\n");
sb.append(" if (a==true) {\r\n");
sb.append(" if (resett=='1') {\r\n");
sb.append("   document.getElementById(\"res\"+iddd).innerHTML='';\r\n");

sb.append(" if (sem!='' && sem!=null && sem!=undefined) {\r\n");
	
sb.append(" document.location = sem;	\r\n");
sb.append("   return false;\r\n");
sb.append(" }\r\n");

sb.append("  }\r\n");
sb.append("setPageBlock();\r\n");
sb.append("   return true;\r\n");

sb.append("  }\r\n");
sb.append(" else {\r\n");
sb.append("   return false;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");

sb.append("function vprasaj(alerto,resett,iddd) {\r\n");
sb.append("  var a = window.confirm(alerto);\r\n");
sb.append(" if (a==true) {\r\n");
sb.append(" if (resett=='1') {\r\n");
sb.append("   document.getElementById(\"res\"+iddd).innerHTML='';\r\n");

sb.append("  }\r\n");
sb.append("setPageBlock();\r\n");
sb.append("   return true;\r\n");
sb.append("  }\r\n");
sb.append(" else {\r\n");
sb.append("   return false;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");

///// stolpec funkcija


sb.append("function stolpec(idsto) {\r\n");

sb.append("if (idsto=='save') {\r\n");

sb.append("var myTable2 = document.getElementById(\"table2\");  \r\n"); 
sb.append("var ths2 = myTable2.getElementsByTagName(\"th\"); \r\n");
sb.append("var widt = $(window).width();\r\n");
sb.append("var shrani=\"\";\r\n");
sb.append("for (var i=0;i<ths2.length;i++) {\r\n");

/// ce vrne px spremenim v %
sb.append("var kon = ths2[i].style.width;\r\n");

sb.append("if (kon.indexOf('px')!=-1) {\r\n");

sb.append("kon = (Number(kon.substring(0,kon.length-2))*100)/Number(widt);\r\n");


sb.append("kon = Math.round(kon) + \"%\";\r\n");


sb.append("}\r\n");

sb.append("if (ths2[i].id!='' && ths2[i].id!=null && ths2[i].id!='undefined') {\r\n");
sb.append("kon = kon.substring(0,kon.length-1)+'PROC';\r\n");
sb.append("shrani = shrani + ths2[i].id + \":::\"+kon+\"---\";\r\n");
sb.append("}\r\n");
//alert(kon);
//=ths2[i].style.width;
sb.append("}\r\n");
sb.append("stolpec_shrani(shrani);\r\n");
// alert(shrani);

sb.append("}\r\n");
sb.append("else if (idsto.indexOf('remove')!=-1) {\r\n");

sb.append("var myTable2 = document.getElementById(\"table2\");  \r\n"); 
sb.append("var ths2 = myTable2.getElementsByTagName(\"th\"); \r\n");
sb.append("var widt = $(window).width();\r\n");
sb.append("var shrani=\"\";\r\n");
sb.append("for (var i=0;i<ths2.length;i++) {\r\n");

/// ce vrne px spremenim v %
sb.append("var kon = ths2[i].style.width;\r\n");

sb.append("if (kon.indexOf('px')!=-1) {\r\n");

sb.append("kon = (Number(kon.substring(0,kon.length-2))*100)/Number(widt);\r\n");


sb.append("kon = Math.round(kon) + \"%\";\r\n");


sb.append("}\r\n");

sb.append("if (ths2[i].id!='' && ths2[i].id!=null && ths2[i].id!='undefined' && ths2[i].id!=idsto.substring(6,idsto.length)) {\r\n");
sb.append("kon = kon.substring(0,kon.length-1)+'PROC';\r\n");
sb.append("shrani = shrani + ths2[i].id + \":::\"+kon+\"---\";\r\n");
sb.append("}\r\n");
//alert(kon);
//=ths2[i].style.width;
sb.append("}\r\n");
sb.append("stolpec_shrani(shrani);\r\n");
// alert(shrani);
sb.append("document.location=document.location;\r\n");
sb.append("}\r\n");

sb.append("else if (idsto.indexOf('___')!=-1) {\r\n");

sb.append("var myTable2 = document.getElementById(\"table2\");  \r\n"); 
sb.append("var ths2 = myTable2.getElementsByTagName(\"th\"); \r\n");
sb.append("var widt = $(window).width();\r\n");
sb.append("var shrani=\"\";\r\n");
sb.append("for (var i=0;i<ths2.length;i++) {\r\n");

/// ce vrne px spremenim v %
sb.append("var kon = ths2[i].style.width;\r\n");

sb.append("if (kon.indexOf('px')!=-1) {\r\n");

sb.append("kon = (Number(kon.substring(0,kon.length-2))*100)/Number(widt);\r\n");


sb.append("kon = Math.round(kon) + \"%\";\r\n");


sb.append("}\r\n");

sb.append("if (ths2[i].id!='' && ths2[i].id!=null && ths2[i].id!='undefined' ) {\r\n");
sb.append("kon = kon.substring(0,kon.length-1)+'PROC';\r\n");
sb.append("shrani = shrani + ths2[i].id + \":::\"+kon+\"---\";\r\n");
sb.append("}\r\n");
sb.append("if (ths2[i].id==idsto.substring(0,idsto.indexOf('___'))) {\r\n");
sb.append("kon = idsto.substring(idsto.indexOf('XXX')+3,idsto.length)+'PROC';\r\n");
sb.append("shrani = shrani + idsto.substring(idsto.indexOf('___')+3,idsto.indexOf('XXX')) + \":::\"+kon+\"---\";\r\n");
sb.append("}\r\n");

//alert(kon);
//=ths2[i].style.width;
sb.append("}\r\n");
sb.append("stolpec_shrani(shrani);\r\n");
  // alert(shrani);
sb.append("document.location=document.location;\r\n");
sb.append("}\r\n");


sb.append("else if (idsto=='default') {\r\n");


sb.append("stolpec_shrani('default');\r\n");
  // alert(shrani);
sb.append("document.location=document.location;\r\n");
sb.append("}\r\n");



sb.append("}\r\n");


//// shranim stolpce

sb.append("function stolpec_shrani(stolpcii) {\r\n");
sb.append("xmlHttp=GetXmlHttpObject();\r\n");
sb.append("if (xmlHttp==null) {\r\n");
sb.append("alert (\"Browser does not support HTTP Request\");\r\n");
sb.append("return false;\r\n");
sb.append("} \r\n");
sb.append("var url=\"stolpec_shrani.jsp\";\r\n");
sb.append("url=url+\"?stolpci=\"+stolpcii+\"&pagee="+imefile +""+sif.getId()+"\";\r\n");
sb.append("url=url+\"&sid=\"+Math.random();\r\n");
sb.append("xmlHttp.open(\"GET\",url,false);\r\n");
sb.append("xmlHttp.send(null);\r\n");

sb.append("return true;\r\n");
sb.append("}\r\n");





//// menjava gumba

sb.append("function menjajGumb(idspan,urli) {\r\n");
sb.append("   document.getElementById(idspan).src=urli;\r\n");
sb.append("}\r\n");


//String v = (nul.jeNull(sif.getZakleni_record()).startsWith("get"))?"vseb."+sif.getZakleni_record()+"()":sif.getZakleni_record();

if (nul.jeNull(sif.getZakleni_vse()).equals("1")) {

sb.append("function blokPrisotnost(idpri,kaj) {\r\n");

sb.append("if (idpri=='<%="+((nul.jeNull(sif.getZakleni_record()).startsWith("get"))?"vseb."+sif.getZakleni_record()+"()":sif.getZakleni_record().replaceAll("'", "\""))+"%////>') {\r\n");
sb.append("if (kaj==1) {\r\n");
sb.append("$.blockUI({ message: '<h4>Drugi uporabnik trenutno obdeluje ta dokument!</h4>' }); \r\n");
sb.append("}\r\n");
sb.append("else if (kaj==2) {\r\n");
sb.append("$.unblockUI();\r\n");
sb.append("document.location=document.location;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");

sb.append("}\r\n");



}
//// funkcija 
else {
	sb.append("var barvaprejj = \"\";\r\n");
sb.append("function setPrisotnost(idpri,kaj) {\r\n");
//sb.append("alert(\"ODKLENI \"+idpri + \" \"+kaj);\r\n");
/// odkleni
sb.append("if (document.getElementById(\"spr\"+idpri)!=null) {\r\n");
sb.append("if (kaj==2) {\r\n");

sb.append("var prevElem = document.getElementById(\"spr\"+idpri).previousElementSibling;\r\n");

sb.append("barvaprej = \"plava1\";\r\n");
sb.append("if (prevElem!=null && prevElem.nodeName=='TR' && (prevElem.id+\"\").indexOf(\"spr\")!=-1) {\r\n");
sb.append("barvaprej=prevElem.className+\"\";\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("var prevElem = document.getElementById(\"spr\"+idpri).nextElementSibling;\r\n");
sb.append("if (prevElem!=null && prevElem.nodeName=='TR' && (prevElem.id+\"\").indexOf(\"spr\")!=-1) {\r\n");
sb.append("barvaprej=prevElem.className+\"\";\r\n");

sb.append("}\r\n");

sb.append("}\r\n");

sb.append("if (barvaprej==\"plava1\") {\r\n");
sb.append("barvaprej=\"plava2\";\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("barvaprej=\"plava1\";\r\n");
sb.append("}\r\n");



sb.append("document.getElementById(\"spr\"+idpri).className=barvaprejj;\r\n");
sb.append("document.getElementById(\"res\"+idpri).style.display='inline';\r\n");
sb.append("}\r\n");
sb.append("else if (kaj==1) {\r\n");
sb.append("barvaprejj=document.getElementById(\"spr\"+idpri).className;\r\n");
sb.append("document.getElementById(\"spr\"+idpri).className='green';\r\n");
sb.append("document.getElementById(\"res\"+idpri).style.display='none';\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("}\r\n");




	




}


sb.append("function chg() {\r\n");


sb.append("resetLoadingOverlay();\r\n");


sb.append(" <////%\r\n");
sb.append("if (request.getParameter(\"idback\")!=null && !request.getParameter(\"idback\").equals(\"null\") && !request.getParameter(\"idback\").equals(\"\")) {\r\n");
sb.append("%////>\r\n");

sb.append("if (document.getElementById(\"spr<////%=request.getParameter(\"idback\")%////>\")!==null) {\r\n");
sb.append("kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(document.getElementById(\"spr<////%=request.getParameter(\"idback\")%////>\"),document.getElementById(\"spr<////%=request.getParameter(\"idback\")%////>\").className);\r\n");
sb.append("window.scroll(1,document.getElementById(\"spr<////%=request.getParameter(\"idback\")%////>\").offsetTop-15);\r\n");
sb.append("}\r\n");

sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");




if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}


sb.append(" <////%\r\n");
sb.append("if (request.getParameter(\"idomko\")!=null && !request.getParameter(\"idomko\").equals(\"null\") && !request.getParameter(\"idomko\").equals(\"\")) {\r\n");

sb.append("if (session.getAttribute(\"idomko\")==null || !session.getAttribute(\"idomko\").toString().equals(request.getParameter(\"idomko\"))) {\r\n");
sb.append("session.setAttribute(\"idomko\",request.getParameter(\"idomko\"));\r\n");
sb.append("%////>\r\n");

sb.append("parent.frames[1].document.location='"+imefile.toLowerCase()+"_edit----REPLACEIDOMKO----.jsp?id=<////%=request.getParameter(\"idomko\")%////>';\r\n");

sb.append("<////%\r\n");






sb.append("}\r\n");

sb.append("}\r\n");

////set dimenzije frames


sb.append("String requri = nul.jeNull(request.getRequestURI());\r\n");

sb.append("if (requri.indexOf(\"/\")!=-1) {\r\n");
sb.append("requri = requri.substring(requri.lastIndexOf(\"/\")+1,requri.length());\r\n");
sb.append("}\r\n");


sb.append("if (control.getFrames().containsKey(requri)) {\r\n");

sb.append("com.popultrade.webapp.FrameSizeClass fss = (com.popultrade.webapp.FrameSizeClass)control.getFrames().get(requri);\r\n");

sb.append("%////>\r\n");

sb.append("top.setSize(<////%=fss.getFrame1()%////>,<////%=fss.getFrame2()%////>,<////%=fss.getFrame3()%////>);\r\n");

sb.append("<////%\r\n");
sb.append("}\r\n");




sb.append("%////>\r\n");
sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_javascript())+"\r\n");
//sb.append("top.window.hideFrame();\r\n");

sb.append("}\r\n");



sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_javascript2())+"\r\n");



if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {
sb.append("function loade() {\r\n");
//sb.append("var tree = document.getElementById(\"tree\");\r\n");
//sb.append("var lists = [ tree ];\r\n");

//sb.append("for (var i = 0; i < tree.getElementsByTagName(\"ul\").length; i++)\r\n");
//sb.append("lists[lists.length] = tree.getElementsByTagName(\"ul\")[i];\r\n");

//sb.append("for (var i = 0; i < lists.length; i++) {\r\n");
//sb.append("var item = lists[i].lastChild;\r\n");
	 
//sb.append("while (!item.tagName || item.tagName.toLowerCase() != \"li\")\r\n");
//sb.append("item = item.previousSibling;\r\n");

//sb.append("item.className += ((item.className+\"\").indexOf(\"last\")==-1)?\" last\":\"\";\r\n");
//sb.append("}\r\n");
sb.append("};\r\n");
}


sb.append("</script>\r\n");
sb.append("<////%}%////>\r\n");

sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");

sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"helpmaster3.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");

if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/colResizable-1.3.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
}

sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/menulist.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");


sb.append("<////%}%////>\r\n");

     /////// hinti opisi
     sb.append("<////%\r\n");
     sb.append("Hashtable sifhint=new Hashtable();\r\n");
	//// katere hinte dam v jsp
     sb.append("Hashtable sifhintp=new Hashtable();\r\n");
     sb.append("%////>\r\n");
     
     
     
     
     
     
     
//sb.append("<script language='javascript' src='js/ajax.js' ></script>\r\n"); //// za stolpce
sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");

sb.append("<script language=javascript>\r\n");


     
     
     if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {

     sb.append("$(function(){\r\n");
     sb.append("$(\"#table1\").colResizable();\r\n");
     sb.append("});\r\n");

     sb.append("$(function(){\r\n");
     sb.append("$(\"#table2\").colResizable({headerOnly:true});\r\n");
     sb.append("});\r\n");
       

     sb.append("$(document).ready(function(){ \r\n");
      

     sb.append("var el=$('#stable1'); \r\n");
     sb.append("var originalelpos=el.offset().top;\r\n");
      
     sb.append("$(window).scroll(function(){ \r\n");
     sb.append("var el = $('#stable1');  \r\n");
     sb.append("var elpos = el.offset().top;  \r\n");
     sb.append("var windowpos = $(window).scrollTop(); \r\n");
     sb.append("var finaldestination = windowpos+originalelpos; \r\n");
     sb.append("el.stop().animate({'top':finaldestination},1); \r\n");
     sb.append("}); \r\n");
      
     sb.append("}); \r\n");

     sb.append("function resHead() {\r\n");

     sb.append("var myTable = document.getElementById(\"table1\"); \r\n");  
       

     sb.append("var ths = myTable.getElementsByTagName(\"th\");  \r\n"); 
       

     sb.append("var myTable2 = document.getElementById(\"table2\");   \r\n");
       

     sb.append("var ths2 = myTable2.getElementsByTagName(\"th\"); \r\n");



     sb.append("for (var i=0;i<ths.length;i++) {\r\n");
     sb.append("//alert(ths[i].style.width + \"   \" + ths2[i].style.width );\r\n");
     sb.append("ths[i].style.width=ths2[i].style.width;\r\n");

     sb.append("}\r\n");


     sb.append("}\r\n");


     sb.append("$(window).resize(function() {\r\n");
     sb.append("resHead();\r\n");
     sb.append("}); \r\n");


     }
     else { /// funkcija tree barve
    	 
    	 sb.append("var prejobjekto;\r\n");
    	 sb.append(" var colorprej;\r\n");
    	 sb.append("function menjajbarvo(objekto) {\r\n");

    		 sb.append("if (prejobjekto!=objekto) {\r\n");
    		 sb.append("try {\r\n");
    		 sb.append("if (prejobjekto!=null && colorprej!=null) {\r\n");
    		 sb.append("document.getElementById(prejobjekto).style.backgroundColor=colorprej;\r\n");
    	 sb.append("}\r\n");
    	 sb.append("}\r\n");
    	 sb.append("catch(efr) {\r\n");
    		 sb.append("}\r\n");
    	 sb.append(" colorprej = document.getElementById(objekto).style.backgroundColor;\r\n");

    	 sb.append("document.getElementById(objekto).style.backgroundColor='#eaff00';\r\n");


    	 sb.append("prejobjekto=objekto;\r\n");

    	 sb.append("}\r\n");


    	 sb.append("} \r\n");
    	 
     }
     
     
     com.popultrade.dao.TemplateListDAO daot = (com.popultrade.dao.TemplateListDAO)contextUtil.getBeanDao("templateListDAO",pageContext.getServletContext());

     
     
     com.popultrade.model.TemplateList sifc = new com.popultrade.model.TemplateList();
     sifc.setTemplatehead_id(new Long(idpr+""));
 
     List lin = daot.getTemplateLists(sifc);
     Iterator itb = lin.iterator();
     
     
     
     while (itb.hasNext()) {
    	
    	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itb.next();
    	 
sb.append("p"+tli.getId()+"=\"< %=ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\";\r\n");


/// kontrola hintov, ce ima dodam opcije
if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null) {
	
	String clna = tli.getTemplateClassClass().getClass_name();
	sb.append("<////%\r\n");
	sb.append("if (!ConPool.cache.containsKey(\"jsp"+sif.getId()+"\"+control.getJezik())) {");
	
	String dodaten = "";
	if (tli.getTemplateClassClass().getTemplateClasss().size()>0) {

		Iterator tre = tli.getTemplateClassClass().getTemplateClasss().iterator();
		while (tre.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
		
		if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
			if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				
		
			dodaten = dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
			}
		}
		else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
			dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("'","\"").replaceAll("request.geetParameter","request.getParameter")+"+\"\").equals(\"\")";
		}
		}
		/// dodaten pogoj da sploh gleda po bazi
		
		
		
	}
	
	
	sb.append("if (true "+dodaten+") {\r\n");
	sb.append("com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n");

	sb.append("com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n");

	
	//// vrednosti
	
	Iterator ikov = tli.getTemplateClassClass().getTemplateClasss().iterator();
	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tli.getTemplateClassClass().getClass_name());
	
	while (ikov.hasNext()) {
	com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
	
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
	
	
	//sb.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
	if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class") || rett.indexOf("new Long(")!=-1) {
		sb.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
		
	}
	else {
		
	
	sb.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
	}
	
	}
	
	
	String sifra="";
	String vrednost="";
	/// dobim vrednosti za sifro in vrednost hinta
		 ikov = tli.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
	
	while (ikov.hasNext()) {
	com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
	
	if (nul.jeNull(tcc.getTip()).equals("sifra")) {
		sifra = nul.jeNull(tcc.getVrednost());
	}
	if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
		vrednost = nul.jeNull(tcc.getVrednost());
	}
	}
	
	
	if (!sifra.equals("") && !vrednost.equals("")) {
	sb.append("List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+");\r\n");
	
	sb.append("Iterator i"+clna+"=li"+clna+".iterator();\r\n");
	

	
	sb.append("while (i"+clna+".hasNext()) {\r\n");
	sb.append("com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n");

	
	//sb.append("%////>\r\n");

	//sb.append("p"+tli.getId()+"<////%=nul.jeNull(modi"+clna+"."+sifra+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")%////>=\"<////%=nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\")%////>\";\r\n");
///// opcija brez sifre v sifrantu, samo id
	
	sb.append("sifhint.put(\"p"+tli.getId()+"\"+ nul.menjajSifrantZnake(nul.jeNull(modi"+clna+"."+sifra+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")),nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\"));\r\n");


	//sb.append("p"+tli.getId()+"<////%=nul.menjajSifrantZnake(nul.jeNull(modi"+clna+"."+sifra+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>=\"<////%=nul.jeNull(modi"+clna+"."+vrednost+"()).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\")%////>\";\r\n");

	//sb.append("<////%\r\n\r\n");
	sb.append("}\r\n\r\n");
	
	}
	
	sb.append("}\r\n\r\n");
	
	
	sb.append("}\r\n%////>\r\n");
	
	
}////////////////

    	 
    	 
     }

     sb.append("<////%\r\n\r\n");    
     sb.append("if (!ConPool.cache.containsKey(\"jsp"+sif.getId()+"\"+control.getJezik())) {");
     sb.append("ConPool.cache.put(\"jsp"+sif.getId()+"\"+control.getJezik(),sifhint);\r\n\r\n");
     sb.append("}\r\n\r\n");
     sb.append("else {\r\n");
     sb.append("sifhint=(Hashtable)ConPool.cache.get(\"jsp"+sif.getId()+"\"+control.getJezik());");
     sb.append("}\r\n");
     sb.append("\r\n%////>\r\n");
  
     
  //  sb.append("$(function(){\r\n");
  //  sb.append("$(\".tableWithFloatingHeader\").colResizable({liveDrag:true,draggingClass:\"dragging\" }); \r\n");
 //   sb.append("});\r\n");
  
  
  
  
     
sb.append("</script>\r\n");
sb.append("<////%}%////>\r\n"); /// konec pogoj head
sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");

///sb.append("<body  style=\"margin: 0\"   background=\"podlaga.jpg\" bgproperties=\"fixed\"  onLoad=\"loade();chg();resHead()\" >\r\n");

 if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {
sb.append("<body   ondragover=\"top.allowDropTop(event)\" ondrop=\"top.dropTop(event,document)\"   "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"  background=\"podlaga.jpg\" bgproperties=\"fixed\" ":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"    onLoad=\"chg();resHead()\" >\r\n");
}
else {
sb.append("<body    ondragover=\"top.allowDropTop(event)\" ondrop=\"top.dropTop(event,document)\"  "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"  background=\"podlaga.jpg\" bgproperties=\"fixed\" ":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"   onLoad=\"loade();chg()\" >\r\n");
}

// loading overlay okno
sb.append("<div id=\"spin\" style=\"z-index:9999\"></div>\r\n");

sb.append("<div id=\"basic-modal-content\"><img src='loadingg.gif'></div>\r\n");
sb.append("<div id=\"stable1\" style=\"position:absolute;width:100%\">\r\n");


   sb.append("<////%}%////>\r\n"); 

//sb.append("<div id=\"divBg\" style=\"width:100%\">\r\n");
//sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\" align=\"CENTER\" valign=\"MIDDLE\" style=\" font-family:Verdana; font-size:7pt\">\r\n");


   sb.append("<////%\r\n"); 
   
   sb.append("String stolpci_m = \"\";\r\n");
   
sb.append("%////>\r\n");  
     sb.append("<%\r\nboolean napr=false;\r\n%////>");    
     sb.append("<%\r\nboolean naprjs=false;\r\n%////>");  

sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");

if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {
sb.append("<table id=\"table1\"   width=100% "+(nul.jeN(sif.getCellspacing()).equals("")?" cellspacing=1 ":"cellspacing='"+sif.getCellspacing()+"'")+"  class=\"fontilist\" >\r\n");
}
else {
	
	sb.append("<table id=\"table1\"   width=100% "+(nul.jeN(sif.getCellspacing()).equals("")?" cellspacing=1 ":"cellspacing='"+sif.getCellspacing()+"'")+"   class=\"fontilist\" style=\"position:fixed;top:0;left:0;z-index:9999\" >\r\n");
}

//sb.append("<thead>\r\n");
sb.append("<////%}%////>\r\n"); 



StringBuffer sbh = new StringBuffer();
sbh.append("<////%\r\n"); 
sbh.append("if (true){\r\n"); 
sbh.append("%////>\r\n");
sbh.append("<tr bgcolor=\"white\">\r\n");


sbh.append("<////%\r\n"); 
sbh.append("String[] colss = stolpci.split(\"---\");\r\n");

String[] colss = null;

sbh.append("for (int xc=0;xc<colss.length;xc++) {\r\n");
	
sbh.append("if (colss[xc]!=null && !colss[xc].equals(\"\")) {\r\n");
sbh.append("String[] spp = colss[xc].split(\":::\");\r\n");
		
		
		

  

sbh.append("%////>\r\n");


      stej=0;
      int bar = 0;
      String[] barv = new String[2];
      barv[0]="opiscell";
      barv[1]="valuecell";
      
      String[] barv2 = new String[2];
      barv2[0]=(nul.jeN(sif.getCustom_css_hint_1()).equals("")?"opiscell":sif.getCustom_css_hint_1());
      barv2[1]=(nul.jeN(sif.getCustom_css_hint_2()).equals("")?"valuecell":sif.getCustom_css_hint_2());
      
      
      int htvsst=0;
   
      Iterator itbi = lin.iterator();
      //// default stolpci s sirinami
      String stolpci_or="";
     // String stolpci_m=""; 
      while (itbi.hasNext()) {
     	
     	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbi.next();
     	if (!nul.jeNull(tli.getStolpec_prikazi_mail()).equals("1")) {
     		
     	if (nul.jeNull(tli.getStolpec_primaren()).equals("1")) {
     		stolpci_or = stolpci_or + ""+tli.getId()+":::"+tli.getStolpec_width()+"---";
     	}
     		 sbh.append("<////%\r\n"); 
            sbh.append("if (spp[0].equals(\""+tli.getId()+"\")) {\r\n"); 
            sbh.append("%////>\r\n");
     		
     		
            if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {
                

                if (bar==2) {
                bar=0;
                }
                
               }
               else {
               	bar=0;
               }
             sbh.append("<////%\r\n"); 
             sbh.append(" dodo=\"style='width:XXX'\";\r\n"); 
             sbh.append("%////>\r\n");
             if (nul.jeNull(tli.getStolpec_order()).equals("1")) {
             sbh.append("<////%\r\n"); 
       
sbh.append("if (nul.jeNull(request.getParameter(\"orderup\")).equals(\""+tli.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\")) {\r\n");        
sbh.append("if (nul.jeNull(request.getParameter(\"orderupsmer\")).equals(\"asc\") ) {\r\n");


if (bar==0 ) {
	sbh.append("dodo=dodo1;\r\n");  
	}
	else {
	sbh.append("dodo=dodo2;\r\n"); 
	}
sbh.append("}\r\n");
sbh.append("else {\r\n");

if (bar==0 ) {
	sbh.append("dodo=dodo3;\r\n");  
	}
	else {
	sbh.append("dodo=dodo4;\r\n"); 
	}

sbh.append("}\r\n");

sbh.append("}\r\n");

sbh.append("else {\r\n");
if (bar==0 ) {
	sbh.append("dodo=dodo5;\r\n");  
	}
	else {
	sbh.append("dodo=dodo6;\r\n"); 
	}

sbh.append("}\r\n");



sbh.append("%////>\r\n");
             }
    
             
             //// pogoj za prikaz
             
      if (!nul.jeNull(tli.getPogoj_prikaz_stolpec()).trim().equals("")) {
     	 sbh.append("<////%\r\n"); 
     	 sbh.append(nul.jeNull(tli.getPogoj_prikaz_stolpec()).replaceAll("\'","\"")+"\r\n"); 
     	 sbh.append("%////>\r\n");         	 
      }
             
          //// ce je stolpec fiksen ne pokazem  delete opcije   
sbh.append("<th class=\""+(nul.jeNull(tli.getStolpec_fiksen()).equals("1")?"cmenu4":"cmenu3")+" "+ barv2[bar]+"\" id=\"th"+tli.getId()+"\" align=\""+tli.getStolpec_align()+"\"  < %=dodo.replaceAll(\"XXX\",spp[1])%////> onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(p"+tli.getId()+")\">");
if (nul.jeNull(tli.getStolpec_order()).equals("1")) {
sbh.append("<a href=\"#\" onclick=\"setPageBlock();document.location='"+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?<////%=!iskanje?\"\":\"isk=1&\"%////>orderup="+tli.getStolpec_metoda().replaceAll("get","").toLowerCase()+"&orderupsmer=< %=(nul.jeNull(request.getParameter(\"orderupsmer\")).equals(\"asc\")?\"desc\":\"asc\")%////>&<////%=request.getQueryString()%////>';return false;\"  style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\">");
}
sbh.append("< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>");
if (nul.jeNull(tli.getStolpec_order()).equals("1")) {
sbh.append("</a>");
}
sbh.append("</th>\r\n");
if (!nul.jeNull(tli.getPogoj_prikaz_stolpec()).trim().equals("")) {
	 sbh.append("<////%\r\n"); 
	 sbh.append("}\r\n"); 
	 sbh.append("%////>\r\n");         	 
}   
        
bar++;

sbh.append("<////%\r\n"); 
sbh.append("}\r\n"); 
sbh.append("else if (stolpci.indexOf(\""+tli.getId()+":::\")==-1){\r\n"); 
sbh.append("stolpci_m = stolpci_m + \"'\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'"+tli.getId()+"XXX"+tli.getStolpec_width().replaceAll("%","")+"'); } ,icon:''},\";\r\n");


sbh.append("}\r\n"); 

sbh.append("%////>\r\n");


      }
              }
              
      sbh.append("<////%\r\n"); 
      sbh.append("}\r\n"); 
      sbh.append("}\r\n"); 

      sbh.append("%////>\r\n");     
              
   if (bar==2) {
	   bar=0;
   }
sbh.append("<th  class=\""+ barv2[bar]+"\" valign=middle align=center ----REPLACEMENUUP---- ><span id='res009'>\r\n");
             

/// gumbi
     com.popultrade.dao.TemplateGumbiDAO daotg = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());

     
     
     com.popultrade.model.TemplateGumbi sifcg = new com.popultrade.model.TemplateGumbi();
     sifcg.setTemplatehead_id(new Long(idpr+""));
 
     List ling = daotg.getTemplateGumbis(sifcg);
     Iterator itbg = ling.iterator();
     
     String menu_mouse="";
     String menu_mouse_hint="";
     String replaceidomko="";
     String je_check_box="";
     
     String upid="";
     String seid="";
     
     Hashtable seidi = new Hashtable();
     
     //// kontrola predpone za edit
        //  itbg = ling.iterator();
     boolean jepredpona = false;
     int a=0;
     int b=0;
     while (itbg.hasNext()) {
    	
    	 com.popultrade.model.TemplateGumbi tli = (com.popultrade.model.TemplateGumbi)itbg.next();
    	 
		 if (true) {
			 
			 com.popultrade.dao.TemplateHeadDAO daore = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
			 com.popultrade.model.TemplateHead sifre = new com.popultrade.model.TemplateHead();
			 System.out.println("------------------123---------");
			 
			 sifre.setVeza_gumb(tli.getId());
			// System.out.println("---------------------------");
			 List liko = daore.getTemplateHeads2(sifre);
			  
			 if (liko.size()>0) {
				 
				 com.popultrade.model.TemplateHead therd = (com.popultrade.model.TemplateHead) liko.get(0);
				 if (therd.getHead_tip().equals("UI")) {
					 upid = therd.getId()+"";
		
					 if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
						 a=1; 
					 }
					 
				 }
				 else if (therd.getHead_tip().equals("SE")) {
					 seid = therd.getId()+"";
					 if (nul.jeNull(therd.getTarget_search_rocno()).equals("")) {
					 seidi.put(therd.getHead_class_name().toLowerCase(), seid);
					 }
				 }
				 
				 
			 }
		 }
		 
		 
		 if (tli.getUrl_gumba()!=null && tli.getUrl_gumba().equals("vnos.gif") && tli.getLokacija_gumba().equals("H")) {
			 b=1;
		 }
		 
    	 
     }
     
     if (a==1 && b==1) {
    	 jepredpona=true;
     }
     
     
     itbg = ling.iterator();
     
     
     
     System.out.println("--------------223-------------");
     while (itbg.hasNext()) {
    	
    	 com.popultrade.model.TemplateGumbi tli = (com.popultrade.model.TemplateGumbi)itbg.next();
 		 String target = "'";
 		 /// dobim parametre , ki dodam gumbu
 		 
 		 Iterator igy = tli.getTemplateGumbiParametris().iterator();
 		 

 		 
		 String predpo = "";
		 String targetv = imefile;
		 
		 String predpage = ""; /// v primeru da ima predpage
		 
	
		 System.out.println("-------------222--------------");
		 if (true) {
			 
			 com.popultrade.dao.TemplateHeadDAO daore = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
			 com.popultrade.model.TemplateHead sifre = new com.popultrade.model.TemplateHead();
			 
			 
			 sifre.setVeza_gumb(tli.getId());
			// System.out.println("---------------------------");
			 List liko = daore.getTemplateHeads2(sifre);
			  
			 if (liko.size()>0) {
				 
				 com.popultrade.model.TemplateHead therd = (com.popultrade.model.TemplateHead) liko.get(0);
				 targetv = therd.getHead_class_name();	 
			 

				 
				
				 
				 
				 
				 if (therd.getHead_tip().equals("SE")) {
				 	predpo="_isci"+therd.getId();
				 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
				 	predpage="_p";
				 	}
				 	
				 }
				 else if (therd.getHead_tip().equals("UI")) {
				 	predpo="_edit"+therd.getId();
				 	replaceidomko = therd.getId()+"";
				 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
					 	predpage="_p";
					 	}
				 }
				 else if (therd.getHead_tip().equals("HT")) {
					 	predpo="_edit"+therd.getId();
					 	replaceidomko = therd.getId()+"";
					 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
						 	predpage="_p";
						 	}
					 }
				 else if (therd.getHead_tip().equals("HE")) {
				 	predpo="_view"+therd.getId();
				 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
					 	predpage="_p";
					 	}
				 }
				 else if (therd.getHead_tip().equals("FU")) {
						predpo="_funk"+therd.getId();
					 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
						 	predpage="_p";
						 	}
					}
				 else if (therd.getHead_tip().equals("PR")) {
						predpo="_proc"+therd.getId();
					 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
						 	predpage="_p";
						 	}
					}
				 else if (therd.getHead_tip().equals("PD")) {
						predpo="_pdf"+therd.getId();
					 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
						 	predpage="_p";
						 	}
					}
				 else if (therd.getHead_tip().equals("LI")) {
						predpo="_list"+therd.getId();
					 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
						 	predpage="_p";
						 	}
					}
				 else if (therd.getHead_tip().equals("LT")) {
						predpo="_list"+therd.getId();
					 	if (therd.getTemplatePPs()!=null && therd.getTemplatePPs().size()>0) {
						 	predpage="_p";
						 	}
					}
				 else if (therd.getHead_tip().equals("EX")) {
						predpo="_exp"+therd.getId();
					}
					 else if (therd.getHead_tip().equals("OB")) {
						predpo="_ob"+therd.getId();
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
				 
			 }
		 
		 }
		 /// dobim parametre , ki dodam gumbu
		 
		 Iterator igyo = tli.getTemplateGumbiParametris().iterator();
		
		 String parametri = "";
		
		 while (igyo.hasNext()) {
			 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)igyo.next();
			 
			 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
				 
			 if (nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("") && nul.jeNull(tgpp.getStolpec_metoda()).indexOf("'")!=-1) {
				 parametri = parametri + "&"+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 }
			 else if (nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("") && nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")!=-1) {
				 parametri = parametri + "&"+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\""))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 }
			 else {
				 parametri = parametri + "&"+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
					
			 }
			 }
			 else if (nul.jeNull(tgpp.getStolpec_metoda()).startsWith("'") || nul.jeNull(tgpp.getStolpec_metoda()).startsWith("\"")) {
				 parametri = parametri + "&"+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"="+nul.jeNull(tgpp.getStolpec_metoda())+"";
					
			 }
			 else { //// uporabim kot je vpisano v bazi
				 parametri = parametri + "&"+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"="+nul.jeNull(tgpp.getStolpec_metoda())+"";
					
				 
			 }
		
		 
		 }
		 System.out.println("------------111221---------------");
//////////// dodam id-je za vezo embeddable nosql

		 parametri = parametri + getEmbeddableTree(sif,0);
		 
		 
	if (nul.jeNull(tli.getTarget_rocni()).trim().equals("top.*")) {
		target = "top.";
	}
	else  {
		target="";
	}


 		 
		 if (tli.getTarget_gumba().equals("0")) {
			 target += "parent.frames[0].location='";
		 }
		 else  if (tli.getTarget_gumba().equals("1")) {
			 target += "parent.frames[1].location='";
		 }
		 else  if (tli.getTarget_gumba().equals("2")) {
			 target += "parent.frames[2].location='";
		 }
		 else  if (tli.getTarget_gumba().equals("3")) {
			 target += "parent.frames[0].location='frameinr_";
		 }
		 else  if (tli.getTarget_gumba().equals("4")) {
			 target += "parent.frames[1].location='frameinr_";
		 }
		 else  if (tli.getTarget_gumba().equals("5")) {
			 target += "parent.frames[2].location='frameinr_";
		 }	 
		 else  if (tli.getTarget_gumba().equals("6")) {
			 target += "parent.frames[0].location='frameinc_";
		 }
		 else  if (tli.getTarget_gumba().equals("7")) {
			 target += "parent.frames[1].location='frameinc_";
		 }
		 else  if (tli.getTarget_gumba().equals("8")) {
			 target += "parent.frames[2].location='frameinc_";
		 }
		 else  if ((tli.getTarget_gumba().equals("O"))) {
			 target = "top.clickove('";
		 }
		 else  if ((tli.getTarget_gumba().equals("F"))) {
			 target = "top.clickove2('";
		 }
		 else  if ((tli.getTarget_gumba().equals("G"))) {
			 target = "top.clickove3('";
		 }
		 else  if (tli.getTarget_gumba().equals("B")) {
			 target = "window.open('";
		 }
		 else  if (tli.getTarget_gumba().equals("9")) {
			 target = tli.getTarget_rocni()+ "='";
		 }
		 
		 String alert = "";
		 System.out.println("------------1144411---------------");
		 if (nul.jeNull(tli.getUporabi_alert()).equals("1")) {
			 
		if (!nul.jeN(tli.getUporabi_alert_fun()).equals("")) {
			// alert = tli.getUporabi_alert_fun()+"";
					
			 alert = nul.jeNull(tli.getUporabi_alert_fun()).replace("[ALERT]","'< %=ConPool.getPrevod(\""+tli.getId()+"J\"+control.getJezik())%////>'")+"?";
				
			 
			 
		}
		else {
			 alert = "vprasaj('< %=ConPool.getPrevod(\""+tli.getId()+"D\"+control.getJezik())%////>','"+(nul.jeNull(tli.getOnemogoci_gumbe()).equals("1")?"1":"0")+"','009')?";
		}
		 
		 }
		 else {
			 
			 target="setPageBlock();"+target;
			 
		 }
		 
		 
		 
		 
		 
		 
		 System.out.println("------------1111-------11--------");
		 if (tli.getTemplateClass()!=null && !tli.getLokacija_gumba().equals("V") && !tli.getLokacija_gumba().equals("Z") && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")  ) {
			 sbh.append("<%\r\n napr=false;\r\n"); 
			 sbh.append("if "+nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("request.getParameter","request.gedtParameter").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get").replaceAll("request.gedtParameter","request.getParameter")+" {\r\n"); 
			 sbh.append("napr=true;\r\n"); 
			 
			 sbh.append("}\r\n");

			 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
				 
				// sbh.append("napr=true;\r\n");
				 sbh.append("naprjs=true;\r\n");
			 }
			 else {
				 sbh.append("naprjs=false;\r\n");
			  
			 }
			 
			 
			 sbh.append("if (napr || naprjs) {\r\n");
			 sbh.append("\r\n %////>\r\n"); 
		 }
			 else {
				 
				 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1") && tli.getLokacija_gumba().equals("H")) {
				 sbh.append("<%napr=true;\r\n%////>\r\n");  
				 }
			 }
			 System.out.println("------------1111-------xxx-------");
			 
		 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1") && tli.getLokacija_gumba().equals("H")) {
			 
			 sbh.append("<span id='"+nul.jeNull(tli.getPrikazi_gumb_ime())+"' style='display:<////%=!napr?\"none\":\"inline\"%////>'>");
			 
		 }
			 
			 
			
		 System.out.println("------------1111------sss---------");
			if (nul.jeNull(sif.getUporabi_nove_gumbe()).equals("1") && tli.getLokacija_gumba().equals("H")) {
			
			
			 if (nul.jeNull(tli.getKlici_funkcijo()).trim().equals("Add")) {
			 	 if (jepredpona) {
				 predpage = "_p";
			 }
			 
    	 sbh.append("<a href=\"#\" class='btn"+tli.getStyle_gumb()+"'  onClick=\""+alert+""+target+targetv.toLowerCase() +"_edit"+upid+predpage+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" href=\"Javascript: PGAPP()\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+tli.getTekst_gumb()+"</a>\r\n");
    	
			 }
			
			
				  else  if (!nul.jeNull(tli.getRocni_url()).trim().equals("")) {
    		    	if (tli.getTarget_gumba().equals("B")) {
    		    		 sbh.append("<a  href=\"#\"  onclick=\""+target+nul.jeNull(tli.getRocni_url())+"?opcija=new"+parametri+"');return false;\"  class='btn"+tli.getStyle_gumb()+"' title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" >"+tli.getTekst_gumb()+"</a>\r\n");
    		    	    	
    		    	
    		    	 }
    				 else {
    		    	 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+nul.jeNull(tli.getRocni_url())+"?opcija=new"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" class='btn"+tli.getStyle_gumb()+"' href=\"Javascript: PGAPP()\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+tli.getTekst_gumb()+"</a>\r\n");
    				 }	
    		    }
    		    else {
    		 if (tli.getTarget_gumba().equals("B")) {
    		 sbh.append("<a  href=\"#\"  onclick=\""+target+targetv.toLowerCase() +predpo+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"');return false;\"    class='btn"+tli.getStyle_gumb()+"' title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" >"+tli.getTekst_gumb()+"</a>\r\n");
    		 }
    		 else {
    			 
    			 if (nul.jeNull(tli.getVrednosti_iz_checkbox()).equals("1")) {
        			 je_check_box = "<form name='dod' method='post' action='"+targetv.toLowerCase() +predpo+".jsp?jemulticheckbox=da"+parametri+"'>";
        			 sbh.append("<a href=\"#\" onClick=\""+alert+(nul.jeNull(tli.getDodaten_js_function()).equals("")?"":tli.getDodaten_js_function()+";")+"document.dod.submit()"+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"   class='btn"+tli.getStyle_gumb()+"' title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+tli.getTekst_gumb()+"</a>\r\n");
         			
        		 }
    			 else {
    			 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+targetv.toLowerCase() +predpo+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" href=\"Javascript: PGAPP()\"   class='btn"+tli.getStyle_gumb()+"' title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+tli.getTekst_gumb()+"</a>\r\n");
    			 }
    		 }
    		 
    	 }
			 
			 
			 
			 
			
			}
			 
			 
			 
    	 else if (tli.getUrl_gumba()!=null && tli.getUrl_gumba().equals("vnos.gif") && tli.getLokacija_gumba().equals("H")) {
    		 System.out.println("------------1111---------ssss------");
			 if (jepredpona) {
				 predpage = "_p";
			 }
			 
    	 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+targetv.toLowerCase() +"_edit"+upid+predpage+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\"vnos.gif\" /></a>\r\n");
    	
    	 
    	 }
    	 
    	 else if (tli.getUrl_gumba()!=null && tli.getUrl_gumba().equals("search.gif") && tli.getLokacija_gumba().equals("H")) {
    		 System.out.println("------------1111----------ssssaaa-----");
    	 parametriSE = parametri;
        	 sbh.append("<a href=\"#\"  onClick=\""+alert+""+target+targetv.toLowerCase() +"_isci"+seidi.get(targetv.toLowerCase())+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\"search.gif\" /></a>\r\n");
        	 
    	 
    	 
    	 }
    	 else if (tli.getLokacija_gumba().equals("H")){
    		 System.out.println("------------1111----------ffff-----");
    		    if (!nul.jeNull(tli.getRocni_url()).trim().equals("")) {
    		    	if (tli.getTarget_gumba().equals("B")) {
    		    		 sbh.append("<a  href=\"#\"  onclick=\""+target+nul.jeNull(tli.getRocni_url())+"?opcija=new"+parametri+"');return false;\" ><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
    		    	    	
    		    	
    		    	 }
    				 else {
    		    	 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+nul.jeNull(tli.getRocni_url())+"?opcija=new"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
    				 }	
    		    }
    		    else {
    		 if (tli.getTarget_gumba().equals("B")) {
    		 sbh.append("<a  href=\"#\"  onclick=\""+target+targetv.toLowerCase() +predpo+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"');return false;\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
    		 }
    		 else {
    			 
    			 if (nul.jeNull(tli.getVrednosti_iz_checkbox()).equals("1")) {
        			 je_check_box = "<form name='dod' method='post' action='"+targetv.toLowerCase() +predpo+".jsp?jemulticheckbox=da"+parametri+"'>";
        			// sbh.append("<a href=\"#\" onClick=\""+alert+"document.dod.submit()"+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
        			 sbh.append("<a href=\"#\" onClick=\""+alert+(nul.jeNull(tli.getDodaten_js_function()).equals("")?"":tli.getDodaten_js_function()+";")+"document.dod.submit()"+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"   class='btn"+tli.getStyle_gumb()+"' title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+tli.getTekst_gumb()+"</a>\r\n");
          			
        		 }
    			 else {
    			 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+targetv.toLowerCase() +predpo+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
    			 }
    		 }
    		 
    	 }
    	
    		 
    	 }
    		
    	 else if (tli.getLokacija_gumba().equals("M")) {
    		 
    		 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
    			 menu_mouse = menu_mouse + "<%"; 
    			 menu_mouse = menu_mouse + "if "+nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("request.getParameter","request.gedtParameter").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get").replaceAll("request.gedtParameter","request.getParameter")+" {"; 
    			 menu_mouse = menu_mouse + "%////>"; 
    		 }
    		 menu_mouse = menu_mouse + "\r\n'< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>':{onclick:function(menuItem,menu) {  "+alert+""+target+targetv.toLowerCase() +predpo+".jsp?idre=56'+ document.getElementById(\'M"+tli.getId()+"_\'+this.id).value"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+"; } ,icon:'"+nul.jeNull(tli.getUrl_gumba())+"'},";
    		 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
    			 menu_mouse = menu_mouse + "<%}%////>"; 
    		 }
    		 
    		 }
    	 
    	 else if (tli.getLokacija_gumba().equals("U")) {
    		 
    		 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
    			 menu_mouse_hint = menu_mouse_hint + "<%"; 
    			 menu_mouse_hint = menu_mouse_hint + "if "+nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("request.getParameter","request.gedtParameter").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get").replaceAll("request.gedtParameter","request.getParameter")+" {"; 
    			 menu_mouse_hint = menu_mouse_hint + "%////>"; 
    		 }
    		 menu_mouse_hint = menu_mouse_hint + "\r\n'< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>':{onclick:function(menuItem,menu) {  "+alert+""+target+targetv.toLowerCase() +predpo+".jsp?idre=56'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( (((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F")) || tli.getTarget_gumba().equals("G"))?")":""))+"; } ,icon:'"+nul.jeNull(tli.getUrl_gumba())+"'},";
    		 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
    			 menu_mouse_hint = menu_mouse_hint + "<%}%////>"; 
    		 }
    		 
    		 }
    	 
    	 
    	 
    	 
			 System.out.println("------------1111----------qqq-----");
    	 
    	 
    	 
    	 
    	 
    	 
	 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
			 
			 //sbh.append("</span>");
			 
		 }
    	 
    	 if (tli.getTemplateClass()!=null && !tli.getLokacija_gumba().equals("V")  && !tli.getLokacija_gumba().equals("Z") && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("") ) {
    				 sbh.append("<%\r\n"); 
			 sbh.append("}\r\n"); 
			 sbh.append("\r\n%////>\r\n"); 
		 }
    	 
     }

                

     System.out.println("------------1111--------tttt-------");

//deploy_kam+imefile.toLowerCase()+"_ml.jsp"

if (sif.getTemplatemaillist()!=null && sif.getTemplatemaillist().getUporabi()!=null && sif.getTemplatemaillist().getUporabi().equals("1")) {
	 sbh.append("<%\r\n"); 
	 sbh.append("if ((nul.jeNull(request.getParameter(\"isk\")).equals(\"1\") || nul.jeNull(request.getParameter(\"isci\")).equals(\"yes\")) && !nul.jeNull(control.getEmail()).equals(\"\")) {\r\n"); 
	 
	 sbh.append("String vrsticaa = \"\";\r\n");
	 sbh.append("if (!nul.jeNull(request.getQueryString()).equals(\"\")) {\r\n");
	 
	 sbh.append("String paramName = null;\r\n");
	 sbh.append("String paramValue = null;\r\n");
	 
			 sbh.append("for (java.util.Enumeration e = request.getParameterNames();e.hasMoreElements() ;) {\r\n");
			 sbh.append("paramName = (String)e.nextElement();\r\n");
			 sbh.append("paramValue = request.getParameter(paramName); \r\n");
					
					 sbh.append("if (!nul.jeNull(paramValue).equals(\"\")) {\r\n");
							 sbh.append("vrsticaa=vrsticaa+\"&\"+paramName+\"=\"+paramValue;\r\n");
							 sbh.append("}}\r\n");
									 sbh.append("vrsticaa.replaceAll(\"\\n\",\"\");\r\n");
									 sbh.append("}\r\n");
	 
										
									 sbh.append("String alert1=ConPool.getPrevod(\""+sif.getId()+"F\"+control.getJezik()).replaceAll(\"_\",\" \") ;\r\n"); 
									 sbh.append("String alert2=ConPool.getPrevod(\""+sif.getId()+"G\"+control.getJezik()).replaceAll(\"_\",\" \");\r\n"); 
									 
									 sbh.append("if (!alert1.equals(\"\")) {\r\n"); 
									 sbh.append("alert1= \"if (!confirm('\"+alert1+\"')) {return false;}\";\r\n"); 
									 sbh.append("}\r\n"); 		
									 sbh.append("if (!alert2.equals(\"\")) {\r\n"); 
									 sbh.append("alert2= \"if (!confirm('\"+alert2+\"')) {return false;};\";\r\n"); 
								 sbh.append("}\r\n"); 	
									 
	sbh.append("\r\n%////>\r\n"); 
	
	sbh.append("<script language='javascript'>\r\n"); 
	sbh.append("function gomes(naprej) {\r\n"); 
	sbh.append("<////%=alert1%////>\r\n"); 
	sbh.append("oknoShow();\r\n"); 
	sbh.append(sif.getTemplatemaillist().getTarget_frame()+"=naprej;\r\n"); 
	sbh.append("return false;\r\n"); 
	sbh.append("}\r\n"); 
	sbh.append("function gomes2(naprej) {\r\n"); 
	sbh.append("<////%=alert2%////>\r\n"); 
	sbh.append("oknoShow();\r\n"); 
	sbh.append(sif.getTemplatemaillist().getTarget_frame()+"=naprej;\r\n"); 
	sbh.append("return false;\r\n"); 
	sbh.append("}\r\n"); 
	
	sbh.append("</script>\r\n"); 

	 
	 
	/// novi gumbi
	if (nul.jeNull(sif.getUporabi_nove_gumbe()).equals("1")) {
	
		 sbh.append("<a href=\"#\"   onClick=\"return gomes('"+imefile.toLowerCase()+sif.getId()+"_ml.jsp"+"?opcija=new&siframm=new&sifrant=f&isk=1&novo=<////%=nul.jeNull(request.getParameter(\"novo\"))%////><%////=vrsticaa.equals(\"\")?\"&nipost=da\":vrsticaa%////>"+parametriSE+"')\" href=\"Javascript: PGAPP()\"   class='btn"+sif.getTemplatemaillist().getStyle_gumb()+"'  title=\"< %=ConPool.getPrevod(\""+sif.getId()+"K\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+sif.getTemplatemaillist().getTekst_gumb()+"</a>\r\n");
		
	if (sif.getTemplatemaillist().getUporabi_excel()!=null && sif.getTemplatemaillist().getUporabi_excel().equals("1")) {
			 sbh.append("<a href=\"#\"   onClick=\"return gomes2('"+imefile.toLowerCase()+sif.getId()+"_mle.jsp"+"?opcija=new&siframm=new&sifrant=f&isk=1&novo=<////%=nul.jeNull(request.getParameter(\"novo\"))%////><%////=vrsticaa.equals(\"\")?\"&nipost=da\":vrsticaa%////>"+parametriSE+"')\" href=\"Javascript: PGAPP()\"   class='btn"+sif.getTemplatemaillist().getStyle_gumb_p()+"' title=\"< %=ConPool.getPrevod(\""+sif.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+sif.getTemplatemaillist().getTekst_gumb_p()+"</a>\r\n");
		}
	
	
	}
	else {
	 sbh.append("<a href=\"#\" onClick=\"return gomes('"+imefile.toLowerCase()+sif.getId()+"_ml.jsp"+"?opcija=new&siframm=new&sifrant=f&isk=1&novo=<////%=nul.jeNull(request.getParameter(\"novo\"))%////><%////=vrsticaa.equals(\"\")?\"&nipost=da\":vrsticaa%////>"+parametriSE+"')\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+sif.getId()+"K\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+sif.getTemplatemaillist().getUrl_gumb()+"\" /></a>\r\n");
		
	if (sif.getTemplatemaillist().getUporabi_excel()!=null && sif.getTemplatemaillist().getUporabi_excel().equals("1")) {
			 sbh.append("<a href=\"#\"  onClick=\"return gomes2('"+imefile.toLowerCase()+sif.getId()+"_mle.jsp"+"?opcija=new&siframm=new&sifrant=f&isk=1&novo=<////%=nul.jeNull(request.getParameter(\"novo\"))%////><%////=vrsticaa.equals(\"\")?\"&nipost=da\":vrsticaa%////>"+parametriSE+"')\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+sif.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\"e.gif\" /></a>\r\n");
		}
		
		}
		
	 sbh.append("<%\r\n"); 
	 sbh.append("}\r\n"); 
	 sbh.append("\r\n%////>\r\n"); 
	
	
}


System.out.println("------------1111-----------999----");

sbh.append("&nbsp;</span></th>\r\n");
      
      
      
      
      
      
      
sbh.append("</tr>\r\n");









sbh.append("<////%\r\n"); 
sbh.append("}\r\n"); 
sbh.append("%////>\r\n");

/// stolpec default

     sb.append("<////%\r\n\r\n");    
     sb.append("if (stolpci.equals(\"\")) {\r\n");
          
sb.append("stolpci=\""+stolpci_or+"\";\r\n");
     
     sb.append("}\r\n%////>\r\n");

sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");

     sb.append(sbh.toString());

//sb.append("</table>\r\n");
//sb.append("</div>\r\n");
if (!menu_mouse_hint.equals("")) {

	sb.append("<script type=\"text/javascript\">\r\n");


	sb.append("var menu1 = [\r\n");
	
	if (menu_mouse_hint.substring(0,menu_mouse_hint.length()-1).equals(",")) {
		menu_mouse_hint = menu_mouse_hint.substring(0,menu_mouse_hint.length()-1);
	}
	else  {
		menu_mouse_hint = menu_mouse_hint.substring(0,menu_mouse_hint.lastIndexOf(",")) + menu_mouse_hint.substring(menu_mouse_hint.lastIndexOf(",")+1,menu_mouse_hint.length());
	}
	
	sb.append("{" + menu_mouse_hint +"}\r\n");
	
	sb.append("];\r\n");

	sb.append("$(function() {\r\n");
	sb.append("$('.cmenu1').contextMenu(menu1,{theme:'vista'});\r\n");
	sb.append("});  \r\n");


	sb.append("</script>\r\n");
	}

if (!menu_mouse.equals("")) {

sb.append("<script type=\"text/javascript\">\r\n");


sb.append("var menu2 = [\r\n");

if (menu_mouse.substring(0,menu_mouse.length()-1).equals(",")) {
	menu_mouse = menu_mouse.substring(0,menu_mouse.length()-1);
}
else  {
	menu_mouse = menu_mouse.substring(0,menu_mouse.lastIndexOf(",")) + menu_mouse.substring(menu_mouse.lastIndexOf(",")+1,menu_mouse.length());
}

sb.append("{" + menu_mouse +"}\r\n");
sb.append("];\r\n");

sb.append("$(function() {\r\n");
sb.append("$('.cmenu2').contextMenu(menu2,{theme:'vista'});\r\n");
sb.append("});  \r\n");

sb.append("</script>\r\n");
}
sb.append("<script type=\"text/javascript\">\r\n");
sb.append("var menu3 = [\r\n");
sb.append("<////%\r\n\r\n");  
sb.append("String stolpci_r=stolpci_m;\r\n");  
sb.append("stolpci_m = stolpci_m + \"'<i>Save</i>':{onclick:function(menuItem,menu) {  stolpec('save'); } ,icon:''},\";\r\n");
sb.append("stolpci_m = stolpci_m + \"'<i>Default</i>':{onclick:function(menuItem,menu) {  stolpec('default'); } ,icon:''},\";\r\n");
sb.append("stolpci_m = stolpci_m + \"'<i>Remove</i>':{onclick:function(menuItem,menu) {  stolpec('remove'+this.id); } ,icon:''}\";\r\n");
sb.append("%////>\r\n");  
sb.append("{"+ (!nul.jeNull(sif.getStruktura_tree()).equals("1")?"<////%=stolpci_m %////>":"")+"}\r\n");
sb.append("];\r\n");

sb.append("$(function() {\r\n");
sb.append("$('.cmenu3').contextMenu(menu3,{theme:'vista'});\r\n");
sb.append("});  \r\n");



sb.append("var menu4 = [\r\n");
sb.append("<////%\r\n\r\n");  
sb.append("stolpci_m = stolpci_r + \"'<i>Save</i>':{onclick:function(menuItem,menu) {  stolpec('save'); } ,icon:''},\";\r\n");
sb.append("stolpci_m = stolpci_m + \"'<i>Default</i>':{onclick:function(menuItem,menu) {  stolpec('default'); } ,icon:''}\";\r\n");
//sb.append("stolpci_m = stolpci_m + \"'<i>Remove</i>':{onclick:function(menuItem,menu) {  stolpec('remove'+this.id); } ,icon:''}\";\r\n");
sb.append("%////>\r\n");  
sb.append("{<////%=stolpci_m %////>}\r\n");
sb.append("];\r\n");

sb.append("$(function() {\r\n");
sb.append("$('.cmenu4').contextMenu(menu3,{theme:'vista'});\r\n");
sb.append("});  \r\n");











sb.append("</script>\r\n");



sb.append("</table>\r\n");
sb.append("</div>\r\n");
sb.append("<////%}\r\n%////>\r\n");

//sb.append("<////%}%////>\r\n"); /// konec jehead kontrole  ---------------------------------------------------------------

























//// druga tabela

if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {

sb.append("<table id=\"table2\"   width=100% "+(nul.jeN(sif.getCellspacing()).equals("")?" cellspacing=1 ":"cellspacing='"+sif.getCellspacing()+"'")+" class=\"fontilist\" >\r\n");
}


sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");

if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {
sb.append(sbh.toString());
}
else {
	sb.append("<table id=\"table2\"   width=100% "+(nul.jeN(sif.getCellspacing()).equals("")?" cellspacing=1 ":"cellspacing='"+sif.getCellspacing()+"'")+" class=\"fontilist\" ><tr><td>&nbsp;</td></tr></table>\r\n");
	
	
}
sb.append("<////%}%////>\r\n");

if (!menu_mouse_hint.equals("") || (!replaceidomko.equals("") || replaceidomko.equals("") )) {
	String uppo = sb.toString().replaceAll("----REPLACEIDOMKO----",replaceidomko).replaceAll("----REPLACEMENUUP----","class=\""+(!menu_mouse_hint.equals("")?"cmenu1":"")+"\"" );

	sb.delete(0,sb.toString().length());

	sb.append(uppo);
	}
//sb.append("<tr><td colspan=3>&nbsp</td></tr>\r\n");
//sb.append("</thead>\r\n");
//sb.append(sbh.toString());
if (je_check_box!=null && !je_check_box.equals("")) {
	sb.append(je_check_box+"\r\n");
	
}
sb.append("<////%\r\n");






/// menja barvo
sb.append("//---ZACETEKZAAJAX---\r\n");
sb.append("int br = 0;\r\n");
sb.append("String oe_kup_nap = \"\";\r\n");




sb.append("String rezu=\"\";\r\n\r\n");

sb.append("String[] colss = stolpci.split(\"---\");\r\n");

//// NE SPREMIJAT < CE NE NE DELA AJAX PRISOTNOST>
sb.append("//---ZACETEKZAAJAX1---\r\n");


sb.append("Iterator it = lis.iterator();\r\n\r\n");


sb.append("boolean norecords=true;\r\n");

sb.append("while (it.hasNext()){  // while start\r\n");
sb.append(" norecords=false;\r\n");

if (nul.jeNull(sif.getNosql()).equals("1") && !nul.jeNull(sif.getHead_class_name_nosql()).equals("")) {
	sb.append("com.popultrade.model."+sif.getHead_class_name_nosql() +" vseb = (com.popultrade.model."+sif.getHead_class_name_nosql() +")(it.next());\r\n");

}
else {

sb.append("com.popultrade.model."+imefile +" vseb = (com.popultrade.model."+imefile +")(it.next());\r\n");

}

sb.append("stvrstic++;\r\n");

sb.append("if (br==2){\r\n");
 sb.append(" br=0;\r\n");
sb.append("}\r\n");

/// dodatno tr za opcijo tree prikaza, prikaze gumbe z on mouseover
String dodatno_tr_mo = "";
String dodatno_tr_mx = "";

if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {
	
	
	//dodatno_tr_mo = ";document.getElementById('res<////%=vseb.getId()%////>').style.display='inline'";
	//dodatno_tr_mx = ";document.getElementById('res<////%=vseb.getId()%////>').style.display='none'";
	sb.append("if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\") && stvrstic==1) {\r\n");

	
	
	
	
	
	sb.append("%////>\r\n");
	
	sb.append("<////%\r\n");
	sb.append("if  (  vseb."+(sif.getHead_class_name_nosql3())+"() !=null &&  vseb."+(sif.getHead_class_name_nosql3())+"().size()>0) {\r\n");
	sb.append("%////><ol claxss=\"tree\" idx=\"tree\"  class=\"rectangle-listmi\"><li class=\"rectangle-listmi\" >\r\n");
	sb.append("<a href=\"#\"  onclick=\"return "+(nul.jeNull(sif.getJs_funkcija_tree()).equals("")?"odpriPodList":sif.getJs_funkcija_tree())+"('<////%=vseb.getId()%////>' )\" style=\"text-decoration:none\">\r\n");
	sb.append("<table class=plus id=\"pmli<////%=vseb.getId()%////>\">\r\n");
	sb.append("<////%\r\n");
	sb.append("}\r\n");
	sb.append("else {\r\n");
sb.append("%////><ol claxss=\"tree\" idx=\"tree\">\r\n");
sb.append("<li    class=\"rectangle-listu\">\r\n");
sb.append("<table id=\"pmli<////%=vseb.getId()%////>\">\r\n");
sb.append("<////%\r\n");
		sb.append("}\r\n");
sb.append("%////>\r\n");
	
	
	
	sb.append("<////%} else  {%////>\r\n");
	
	sb.append("<////%\r\n");
			sb.append("if  (  vseb."+(sif.getHead_class_name_nosql3())+"() !=null &&  vseb."+(sif.getHead_class_name_nosql3())+"().size()>0) {\r\n");
	sb.append("%////>\r\n");
	sb.append("<li    class=\"rectangle-listmi\">\r\n");
	sb.append("<a href=\"#\"  onclick=\"return "+(nul.jeNull(sif.getJs_funkcija_tree()).equals("")?"odpriPodList":sif.getJs_funkcija_tree())+"('<////%=vseb.getId()%////>')\" style=\"text-decoration:none\">\r\n");
	sb.append("<table class=plus id=\"pmli<////%=vseb.getId()%////>\">\r\n");
	sb.append("<////%\r\n");
			sb.append("}else {\r\n");
	sb.append("%////>\r\n");
	sb.append("<li    class=\"rectangle-listu\"><table id=\"pmli<////%=vseb.getId()%////>\">\r\n");
	sb.append("<////%\r\n");
			sb.append("}\r\n");
	sb.append("%////>\r\n");
	
	//sb.append("<li  clasxs=\"<////%=(lis.size()==stvrstic)?\"last\":\"\"%////>\">\r\n");
	/*
	sb.append("<////%\r\n");
	sb.append("if  (  vseb.getTemplatexmls() !=null &&  vseb.getTemplatexmls().size()>0) {\r\n");
	sb.append("%////>\r\n");
	sb.append("<a href=\"#\"  onclick=\"return odpriPodList('<////%=vseb.getId()%////>')\" style=\"text-decoration:none\">\r\n");
	
	sb.append("<////%\r\n");
	sb.append("}\r\n");
	sb.append("%////>\r\n");*/
	
	
	
	//sb.append("<table>\r\n");
	//sb.append("<li>\r\n");
	sb.append("<////%}\r\n");
	
}
sb.append("//---ZACETEKZAAJAX2---\r\n");
sb.append("if (!prisotnost.getUserZaklenil(nul.jeNull("+(nul.jeNull(sif.getZakleni_record()).equals("")?"vseb.getId()":(sif.getZakleni_record().indexOf("request.getParameter")!=-1?sif.getZakleni_record().replaceAll("'", "\""):"vseb."+sif.getZakleni_record()+"()"))+"+\"\")).equals(control.getIdUporabnikaLock()) && prisotnost.users.containsKey(nul.jeNull("+(nul.jeNull(sif.getZakleni_record()).equals("")?"vseb.getId()":(sif.getZakleni_record().indexOf("request.getParameter")!=-1?sif.getZakleni_record().replaceAll("'", "\""):"vseb."+sif.getZakleni_record()+"()"))+"+\"\"))) {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"green\"  id=\"spr<////%=vseb.getId()%////>\"  >\r\n");
sb.append("////<%\r\n");
sb.append("}\r\n");
sb.append("else if (vseb.getId().toString().equals(nul.jeNull(request.getParameter(\"idback\")))) {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"<////%=colors[br]%////>\" id=\"spr<////%=vseb.getId()%////>\" onMouseOver=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"rollOver2":"rollOver")+"')"+dodatno_tr_mo+"\" onMouseOut=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>')"+dodatno_tr_mx+"\">\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"<////%=colors[br]%////>"+(!menu_mouse.equals("")?" cmenu2":"")+"\"  id=\"spr<////%=vseb.getId()%////>\"   onMouseOver=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"rollOver2":"rollOver")+"')"+dodatno_tr_mo+"\" onMouseOut=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>')"+dodatno_tr_mx+"\">\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");

sb.append("for (int xc=0;xc<colss.length;xc++) {\r\n");

sb.append("if (colss[xc]!=null && !colss[xc].equals(\"\")) {\r\n");
sb.append("String[] spp = colss[xc].split(\":::\");\r\n");

sb.append("%////>\r\n");


Iterator itbv = lin.iterator();


int st_stolpcev=0;
while (itbv.hasNext()) {
	
	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();

	 
	 if (!nul.jeNull(tli.getStolpec_prikazi_mail()).equals("1")) {
		st_stolpcev++;
		 sb.append("<%\r\n");
		

		 sb.append("if (spp[0].equals(\""+tli.getId()+"\")) {\r\n"); 	
	 //// prikaz stolpca
	 /// numeric
	 
	 sb.append("rezu=\"\";\r\n");
	 
	 sb.append("%////>\r\n");
	 
	 
	 /// pogledam, ce ima pogoje
	 
	 if (tli.getTemplateClasses().size()>0) {
		 sb.append("<////%\r\n");
		 sb.append(this.createPP(tli, "templatelist")+"\r\n");
		 sb.append("%////>\r\n");
		 
	 }
	 else {
		 
		 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
			 sb.append("<%\r\n");
			 sb.append("rezu=nul.formatNumber(vseb."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
			 sb.append("%////>\r\n");
			 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
		 }
		 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
			 sb.append("<%\r\n");
			 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
			 sb.append("%////>\r\n");
		 }
		 else {
			 sb.append("<%\r\n");
			 sb.append("rezu=nul.jeNull(vseb."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
			 sb.append("%////>\r\n");
		 }
	 }
	 
	 if (nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals("") ) {
		 
		 sb.append("<%\r\n");
		 sb.append("rezu=nul.cutString(rezu,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n");
		 sb.append("%////>\r\n");
		 
		 
	 }
	 
	 String hinto = "";
	 /// ce ima hinte stolpec
	 if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
		
		 
		 
		
		 sb.append("<%\r\n");
		// sb.append("//---ZACETEKZAAJAX3---\r\n");
		 sb.append("if (sifhint.containsKey(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")))) {\r\n");
		 sb.append("sifhintp.put(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")),sifhint.get(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))));\r\n");
		 sb.append("}\r\n\r\n");
		// sb.append("//---ZACETEKZAAJAX4---\r\n");
		 sb.append("%////>\r\n");
		 
		 
		 
		 hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(typeof(p"+tli.getId()+"<////%=nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>)=='string'?p"+tli.getId()+"<////%=nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>:'')\"";
		 
		 
	 }
	 if (nul.jeNull(tli.getUporabi_onmouseover_prikaz()).equals("1")) {
		 
		 hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip('<////%=nul.menjajSifrantZnake(nul.jeNull(rezu).replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))%////>')\"";
			 
		 
		 
	 }
	 

	 ///// ce pokaze stolpec predpogoj
     if (!nul.jeNull(tli.getPogoj_prikaz_stolpec()).trim().equals("")) {
    	 sb.append("<////%\r\n"); 
    	 sb.append(nul.jeNull(tli.getPogoj_prikaz_stolpec()).replaceAll("\'","\"")+"\r\n"); 
    	 sb.append("%////>\r\n");         	 
     }
	 
	 
	 String doddiv = "";
	 
	 String dodcss = "";
	 
	 if (!nul.jeNull(tli.getCss_value()).equals("")) {
		 dodcss = "<div class='"+tli.getCss_value()+"'>";
	 }
	 
	if (nul.jeNull(tli.getUporabi_div_vrednost()).equals("1")) {
		doddiv = "<span id=\""+tli.getUporabi_div_ime()+"<////%=vseb.getId()%////>\">";
	}
	
	 if (nul.jeNull(tli.getStolpec_checkbox()).equals("1")) {
		 
		 if (tli.getTemplateClasses().size()>0) {
			 sb.append("<td width=\""+tli.getStolpec_width()+"\" align=\""+tli.getStolpec_align()+"\" "+hinto+">"+dodcss+doddiv+"<%////=rezu%////>"+(doddiv.equals("")?"":"</div>")+(dodcss.equals("")?"":"</span>")+"</td>\r\n");
			 
		 }
		 else {
		 sb.append("<td width=\""+tli.getStolpec_width()+"\" align=\""+tli.getStolpec_align()+"\" "+hinto+">"+dodcss+doddiv+"<input type='checkbox' value='< %=rezu%////>' name='"+tli.getStolpec_metoda().toLowerCase().replaceAll("get","")+"____< %=rezu%////>'  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" >"+(doddiv.equals("")?"":"</div>")+(dodcss.equals("")?"":"</span>")+"</td>\r\n");
		 }
	 }
	 else {
	
		 
		 
	 
	 sb.append("<td width=\""+tli.getStolpec_width()+"\" align=\""+tli.getStolpec_align()+"\" "+hinto+">"+dodcss+doddiv+"\r\n\r\n");
	 
	 
	 if (nul.jeNull(tli.getUporabi_onmouseover_prikaz()).equals("1")) {
		 sb.append("<%\r\n");
		 sb.append("rezu=nul.jeNull(vseb."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
		 sb.append("%////>\r\n");
	 }
	 
	 
	 if (nul.jeNull(tli.getJeslika()).equals("1")) {
		 String wi = "";
			 String he = "";
			 if (!nul.jeNull(tli.getSlika_width()+"").equals("") && tli.getSlika_width()>0) {
				 wi = "width='"+tli.getSlika_width()+"'";
			 }
			 if (!nul.jeNull(tli.getSlika_height()+"").equals("") && tli.getSlika_height()>0) {
				 he = "height='"+tli.getSlika_height()+"'";
			 }
			 sb.append("<////%\r\n");
			sb.append("if (vseb.getId()!=null && !nul.jeNull(rezu).equals(\"\")) {\r\n\r\n");
		 sb.append("%////>\r\n");
		 
		 if (nul.jeNull(tli.getJeslikaizbaze()).equals("1")) {
		
				/// dobim templateclass
				
				com.popultrade.model.TemplateHead thead = new com.popultrade.model.TemplateHead();
				com.popultrade.dao.TemplateHeadDAO daothead = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
				
				thead = daothead.getTemplateHead(tli.getTemplateprikazslike());
				
				if (thead!=null) {
				sb.append("<a href='#' onclick=\"return top.disImage('"+thead.getHead_class_name().toLowerCase()+"_ob"+thead.getId()+".jsp?id=<////%=vseb.getId()%////>&sid=<////%=Math.random()%////>')\" >");
				 sb.append("<img "+wi+"  "+he+" src=\""+thead.getHead_class_name().toLowerCase()+"_ob"+thead.getId()+".jsp?id=<////%=vseb.getId()%////>&sid=<////%=Math.random()%////>\" border='0' >\r\n");
				sb.append("</a>");
				}

			}
			else {
				
				sb.append("<a href='#' onclick=\"return top.disImage('<////%=control.lokacijaslika +rezu%////>')\" >");
				
		 sb.append("<img "+wi+"  "+he+"   src='<////%=control.lokacijaslika +rezu%////>' border='0' >\r\n");
			sb.append("</a>");
			}
		 
			 sb.append("<////%\r\n");
			sb.append("}\r\n\r\n");
		 sb.append("%////>\r\n");
		 }
		 else {
			 sb.append("<////%=rezu%////>\r\n");
		 }	
	 
	 
    // sb.append("< %=rezu%////>\r\n\r\n");
     doddiv = "";
		if (nul.jeNull(tli.getUporabi_div_vrednost()).equals("1")) {
			doddiv = "</span>";
		}

		if (!dodcss.equals(""))  {
			dodcss = "</div>";
		}
     sb.append(doddiv+dodcss+"</td>\r\n");
     
     
     
     
	 }
       
     if (!nul.jeNull(tli.getPogoj_prikaz_stolpec()).trim().equals("")) {
    	 sb.append("<////%\r\n"); 
    	 sb.append("}\r\n"); 
    	 sb.append("%////>\r\n");         	 
     }
	 
	 sb.append("<////%\r\n"); 
	 sb.append("}\r\n"); 
	  

	 sb.append("%////>\r\n");   
	 
	 
	 }  /// konec prikaza if
}

sb.append("<////%\r\n"); 
sb.append("}\r\n"); 
sb.append("}\r\n"); 

sb.append("%////>\r\n");   

sb.append("<////% \r\n  napr=false;\r\n naprjs=false;\r\n %////>\r\n");

////


if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {

sb.append("<td  align=\"center\" style=\"padding:2px;\"><span onclick='event.cancelBubble = true; if(event.stopPropagation) { event.stopPropagation(); }'  id='res<////%=vseb.getId()%////>' style='display:<////%=(prisotnost.getUserZaklenil(nul.jeNull("+(nul.jeNull(sif.getZakleni_record()).equals("")?"vseb.getId()":(sif.getZakleni_record().indexOf("request.getParameter")!=-1?sif.getZakleni_record().replaceAll("'", "\""):"vseb."+sif.getZakleni_record()+"()"))+"+\"\")).equals(control.getIdUporabnikaLock()) || !prisotnost.users.containsKey(nul.jeNull("+(nul.jeNull(sif.getZakleni_record()).equals("")?"vseb.getId()":(sif.getZakleni_record().indexOf("request.getParameter")!=-1?sif.getZakleni_record().replaceAll("'", "\""):"vseb."+sif.getZakleni_record()+"()"))+"+\"\")))?\"inline\":\"none\"%////>'>\r\n");



}
else { /// ni viden gumb le z onmouse over
	
	//sb.append("<td  align=\"center\" style=\"padding:2px;\"><span id='res<////%=vseb.getId()%////>' style=\"display:none\">\r\n");
	sb.append("<td  align=\"center\" style=\"padding:2px;\"><span onclick='event.cancelBubble = true; if(event.stopPropagation) { event.stopPropagation(); }'  id='res<////%=vseb.getId()%////>' style='float:right;display:<////%=(prisotnost.getUserZaklenil(nul.jeNull("+(nul.jeNull(sif.getZakleni_record()).equals("")?"vseb.getId()":(sif.getZakleni_record().indexOf("request.getParameter")!=-1?sif.getZakleni_record().replaceAll("'", "\""):"vseb."+sif.getZakleni_record()+"()"))+"+\"\")).equals(control.getIdUporabnikaLock()) || !prisotnost.users.containsKey(nul.jeNull("+(nul.jeNull(sif.getZakleni_record()).equals("")?"vseb.getId()":(sif.getZakleni_record().indexOf("request.getParameter")!=-1?sif.getZakleni_record().replaceAll("'", "\""):"vseb."+sif.getZakleni_record()+"()"))+"+\"\")))?\"inline\":\"none\"%////>'>\r\n");

	
}
sb.append("<////%\r\n");

//sb.append("if (!prisotnost.users.containsKey(nul.jeNull(vseb.getId()+\"\"))) {\r\n");
sb.append("%////>\r\n");



Iterator itbgd = ling.iterator();
boolean jestartvrstice = false;

int maxo = 0;
StringBuffer skupaj = new StringBuffer();
boolean jeskupajpogoj=false;
skupaj.append("<%\r\nnapr=false;\r\n");

while (itbgd.hasNext()) {
	maxo++;
	 com.popultrade.model.TemplateGumbi tli = (com.popultrade.model.TemplateGumbi)itbgd.next();
	 String target = "";
	 
	 
		if (nul.jeNull(tli.getTarget_rocni()).trim().equals("top.*")) {
			target = "top.";
		}
	 
	 
	 if (tli.getTarget_gumba().equals("0")) {
		 target += "parent.frames[0].location='";
	 }
	 else  if (tli.getTarget_gumba().equals("1")) {
		 target += "parent.frames[1].location='";
	 }
	 else  if (tli.getTarget_gumba().equals("2")) {
		 target += "parent.frames[2].location='";
	 }
	 else  if (tli.getTarget_gumba().equals("3")) {
		 target += "parent.frames[0].location='frameinr_";
	 }
	 else  if (tli.getTarget_gumba().equals("4")) {
		 target += "parent.frames[1].location='frameinr_";
	 }
	 else  if (tli.getTarget_gumba().equals("5")) {
		 target += "parent.frames[2].location='frameinr_";
	 }	 
	 else  if (tli.getTarget_gumba().equals("6")) {
		 target += "parent.frames[0].location='frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("7")) {
		 target += "parent.frames[1].location='frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("8")) {
		 target += "parent.frames[2].location='frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("B")) {
		 target = "window.open('";
	 }
	 else  if ((tli.getTarget_gumba().equals("O"))) {
		 target = "top.clickove('";
	 }
	 else  if ((tli.getTarget_gumba().equals("F"))) {
		 target = "top.clickove2('";
	 }
	 else  if ((tli.getTarget_gumba().equals("G"))) {
		 target = "top.clickove3('";
	 }
	 else  if (tli.getTarget_gumba().equals("9")) {
		 target = tli.getTarget_rocni()+ "='";
	 }
	 
	 /// dobim parametre , ki dodam gumbu
	  System.out.println("------------1111-------212312--------");
	 Iterator igy = tli.getTemplateGumbiParametris().iterator();
	 
	 String parametri = "";
	 
	 while (igy.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)igy.next();
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1 && nul.jeNull(tgpp.getStolpec_metoda()).indexOf("'")!=-1) {
			// parametri = parametri + "&"+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 parametri = parametri + "&"+(!nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("")?nul.jeNull(tgpp.getDugacno_ime_parametra()).trim():(nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
				
		 }
		 else  if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1 && nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")!=-1) {
			// parametri = parametri + "&"+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 parametri = parametri + "&"+(!nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("")?nul.jeNull(tgpp.getDugacno_ime_parametra()).trim():(nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\"")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\""))))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
				
		 }
		 else if (nul.jeNull(tgpp.getStolpec_metoda()).startsWith("'") || nul.jeNull(tgpp.getStolpec_metoda()).startsWith("\"")) {
			 parametri = parametri + "&"+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"="+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","").replaceAll("\"","")+"";
				
		 }
		 else if  (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("()")!=-1 ) {
			 parametri = parametri + "&"+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"=< %="+tgpp.getStolpec_metoda()+"%////>";
			 }
		 else {
		 parametri = parametri + "&"+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"=< %=vseb."+tgpp.getStolpec_metoda()+"()%////>";
		 }
	 
	 }
	 
	 
	 
	 
	 
	 
	 
	 System.out.println("------------1111-----e22e2e3----------");
	 if ( tli.getLokacija_gumba().equals("Z")&& !jestartvrstice ) {
		 jestartvrstice = true;
		 
		 if (nul.jeNull(sif.getUporabi_nove_gumbe()).equals("1")) {
		 
		 sb.append("<!--PLUSS--><br><span  id='vrst<////%=vseb.getId()%////>' style='display:none;padding-top:4px;padding-bottom:1px'>");
		 }
		 else {
		 sb.append("<!--PLUSS--><br><span  id='vrst<////%=vseb.getId()%////>' style='display:none;'>"); 
		 }
	 }
	 
	 
	 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
		
		 
		 sb.append("<%\r\nnapr=false;\r\n"); 
		 
		 sb.append("if "+nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("request.getParameter","request.gedtParameter").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get").replaceAll("request.gedtParameter","request.getParameter")+" {\r\n"); 
		
		 
		 sb.append("napr=true;\r\n"); 
		 
		 sb.append("}\r\n");
		 
		 
		 if (tli.getLokacija_gumba().equals("Z")) {
			 skupaj.append("if "+nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("request.getParameter","request.gedtParameter").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get").replaceAll("request.gedtParameter","request.getParameter")+" {\r\n");
			 skupaj.append("napr=true;\r\n"); 
			 skupaj.append("}\r\n");
			 jeskupajpogoj=true;
		 }
		 
		 
		 
		 
		 
		 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
			 
			// sbh.append("napr=true;\r\n");
			 sb.append("naprjs=true;\r\n");
		 }
		 else {
			 sb.append("naprjs=false;\r\n");
		  
		 }
		 
		 
		 sb.append("if (napr || naprjs) {\r\n");
		 sb.append("\r\n%////>\r\n"); 
	 
		 

		 
		 
	 }

		 else if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getFunkcija_formata3()).equals("")) {
		
		 sb.append("<%\r\nnapr=false;\r\n if (true) {\r\n"); 
		 sb.append(tli.getTemplateClass().getFunkcija_formata3()+"\r\n"); 
		 
		 
		
		 
		 sb.append("napr=true;\r\n"); 
		 
		 sb.append("}\r\n");
		 
		 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
			 
			// sbh.append("napr=true;\r\n");
			 sb.append("naprjs=true;\r\n");
		 }
		 else {
			 sb.append("naprjs=false;\r\n");
		  
		 }
		 
		 
		 sb.append("if (napr || naprjs) {\r\n");
		 sb.append("\r\n%////>\r\n"); 
	 
	 }
		 else {
			 
			 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
			 sb.append("<%napr=true;\r\n%////>\r\n"); 
			 }
		 }
		 

	 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
		 
		 sb.append("<span id='"+nul.jeNull(tli.getPrikazi_gumb_ime())+"<%=vseb.getId()%////>' style='display:<////%=!napr?\"none\":\"inline\"%////>'>");
		 
	 }
		 ///// target gumba
		 String predpo = "";
		 String targetv = imefile;
		 if (true) {
			 
			 com.popultrade.dao.TemplateHeadDAO daore = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
			 com.popultrade.model.TemplateHead sifre = new com.popultrade.model.TemplateHead();
			 
			 
			 sifre.setVeza_gumb(tli.getId());
			// System.out.println("---------------------------");
			 List liko = daore.getTemplateHeads2(sifre);
			  
			 if (liko.size()>0) {
				 com.popultrade.model.TemplateHead therd = (com.popultrade.model.TemplateHead) liko.get(0);
				 targetv = therd.getHead_class_name();
				 
				 
				 
				 if (therd.getHead_tip().equals("SE")) {
				 	predpo="_isci"+therd.getId();
				 }
				 else if (therd.getHead_tip().equals("UI")) {
				 	predpo="_edit"+therd.getId();
				 	replaceidomko = therd.getId()+"";
				 }
				 else if (therd.getHead_tip().equals("HT")) {
					 	predpo="_edit"+therd.getId();
					// 	replaceidomko = therd.getId()+"";
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
			 }
			// System.out.println("---------------------------");
			 
		 }
		 
		 String alert = "";
		 
		 if (nul.jeNull(tli.getUporabi_alert()).equals("1")) {
			// alert = "vprasaj('< %=ConPool.getPrevod(\""+tli.getId()+"D\"+control.getJezik())%////>')?";
			
			
			if (nul.jeNull(tli.getUporabi_alert_fun()).trim().equals("")) {
			alert = "vprasaj('< %=ConPool.getPrevod(\""+tli.getId()+"D\"+control.getJezik())%////>','"+(nul.jeNull(tli.getOnemogoci_gumbe()).equals("1")?"1":"0")+"','<////%=vseb.getId()%////>')?";
			}
			else {
				alert = nul.jeNull(tli.getUporabi_alert_fun()).replace("[ALERT]","'< %=ConPool.getPrevod(\""+tli.getId()+"J\"+control.getJezik())%////>'")+"?";
				
			}
		 }
		 
		 String del1="";
		 String urlg=tli.getUrl_gumba();
		 String deljs="";
		 
		 if (!nul.jeNull(tli.getZamenjaj_url_gumba()).equals("")) {
			 del1 = " id='G< %=vseb.getId()%////>U"+tli.getId()+"' ";
			
			 deljs = "menjajGumb('G< %=vseb.getId()%////>U"+tli.getId()+"','"+tli.getZamenjaj_url_gumba()+"');";
			 
			 
			 if (!nul.jeNull(tli.getZamenjaj_uporabi_pogoj()).equals("")) {
				 
				 urlg= "<////%"+tli.getZamenjaj_uporabi_pogoj().replaceAll("\'","\"").replaceAll("\\.get",".geet").replaceAll("get","vseb.get").replaceAll("\\.geet",".get")+" {%////>"+tli.getZamenjaj_url_gumba()+"<////%}else{%////>"+tli.getUrl_gumba()+"<////%}%////>";
				 
			 }
			 
			 
			 
		 }
		 
	
////////////dodam id-je za vezo embeddable nosql

	 parametri = parametri + getEmbeddableTree(sif,1);
	 
		 
		//  sbh.append("<a  href=\"#\"  onclick=\""+target+nul.jeNull(tli.getRocni_url())+"?opcija=new"+parametri+"');return false;\"  class='btn"+tli.getStyle_gumb()+"' title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" >"+tli.getTekst_gumb()+"</a>\r\n");
    		    	    
		 
		 if (nul.jeNull(sif.getUporabi_nove_gumbe()).equals("1") && (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {

if (nul.jeNull(tli.getKlici_funkcijo()).equals("Brisi")) {
	 sb.append("<a onClick=\"return vprasaj2('< %=ConPool.getPrevod(\""+tli.getId()+"D\"+control.getJezik())%////>','"+(nul.jeNull(tli.getOnemogoci_gumbe()).equals("1")?"1":"0")+"','<////%=vseb.getId()%////>','"+targetv.toLowerCase()+"_list"+sif.getId() +".jsp?akcijaXY=DELETE&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"')\"  class='btn"+tli.getStyle_gumb()+"'  href=\""+targetv.toLowerCase()+"_list"+sif.getId() +".jsp?akcijaXY=DELETE&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\">"+tli.getTekst_gumb()+"</a>\r\n");
		}

		 else if (tli.getTarget_gumba().equals("B")) { /// ce je blank
			 sb.append("<a target=\"_blank\" href=\"#\" onclick=\""+deljs+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"');"+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":"setPageBlock();")+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');return false;\"   class='btn"+tli.getStyle_gumb()+"'  title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  "+del1+" >"+tli.getTekst_gumb()+"</a>\r\n");
				 }
    		 else {
    			 if (!nul.jeNull(tli.getRocni_url()).trim().equals("") ) {
    			 sb.append("<a href=\"#\" onClick=\""+alert+""+target+nul.jeNull(tli.getRocni_url())+""+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";"+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":"")+"return false;\" href=\"Javascript: PGAPP()\"  class='btn"+tli.getStyle_gumb()+"'    title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  "+del1+"    >"+tli.getTekst_gumb()+"</a>\r\n");
    			 }
    			 else {
    			 
    			 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";"+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');"+deljs+"return false;\"  class='btn"+tli.getStyle_gumb()+"'   title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  "+del1+"   >"+tli.getTekst_gumb()+"</a>\r\n");
    			 }
    		 }
		
		 
	 }
		 
		 
		 
		 
		else if (!nul.jeNull(tli.getRocni_url()).trim().equals("") && (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {
			 if (tli.getTarget_gumba().equals("B")) {	 
		 sb.append("<a  href=\"#\"  onclick=\""+deljs+alert+""+target+nul.jeNull(tli.getRocni_url())+""+parametri+"');return false;\" ><img onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\"  title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+urlg+"\" "+del1+" /></a>\r\n");

	    	 }
			 else {
	    	 sb.append("<a href=\"#\" onClick=\""+alert+""+target+nul.jeNull(tli.getRocni_url())+""+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
			 }	
		 }
		 else	 if (tli.getUrl_gumba()!=null && tli.getUrl_gumba().equals("x.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z")) && nul.jeNull(tli.getKlici_funkcijo()).equals("Brisi")) {	 
		 
	
			 
		 sb.append("<a onClick=\"return vprasaj2('< %=ConPool.getPrevod(\""+tli.getId()+"D\"+control.getJezik())%////>','"+(nul.jeNull(tli.getOnemogoci_gumbe()).equals("1")?"1":"0")+"','<////%=vseb.getId()%////>','"+targetv.toLowerCase()+"_list"+sif.getId() +".jsp?akcijaXY=DELETE&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"')\" href=\""+targetv.toLowerCase()+"_list"+sif.getId() +".jsp?akcijaXY=DELETE&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"\"><img src=\"x.gif\" border=0 title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");
		
 
		 
	 }
	 
	 else if (tli.getUrl_gumba()!=null && tli.getUrl_gumba().equals("h.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z")) && nul.jeNull(tli.getKlici_funkcijo()).equals("Brisi")) {
		 
		 
		 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+"_view"+sif.getId() +".jsp?opcija=spremeni&siframm=new&idback=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";"+deljs+"return false;\"><img src=\""+urlg+"\" border=0 "+del1+" onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 else if (tli.getUrl_gumba()!=null && tli.getUrl_gumba().equals("u.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {
		 
		 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+(predpo.indexOf("_p")==-1?predpo:predpo.substring(0,predpo.indexOf("_p")))+".jsp?opcija=spremeni&siframm=new&idback=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";"+deljs+"return false;\"><img src=\""+urlg+"\" "+del1+" border=0 onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 else if (tli.getUrl_gumba()!=null && tli.getUrl_gumba().equals("i.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {
		 
		 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";"+deljs+"return false;\"><img src=\""+urlg+"\" "+del1+" onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\"  border=0 onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 
	 else if ( (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {

		 if (tli.getTarget_gumba().equals("B")) { /// ce je blank
			 sb.append("<a target=\"_blank\" href=\"#\" onclick=\""+deljs+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"');return false;\"><img src=\""+urlg+"\" "+del1+" border=0 onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":"setPageBlock();")+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");
				 }
    		 else {
    			 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+( ((tli.getTarget_gumba().equals("O") || tli.getTarget_gumba().equals("F") || tli.getTarget_gumba().equals("G"))?")":""))+";"+deljs+"return false;\"><img "+del1+" src=\""+urlg+"\" border=0 onClick=\""+(nul.jeNull(sif.getStruktura_tree()).equals("1")?"menjajbarvo('pmli<////%=vseb.getId()%////>');":(alert.equals("")?"setPageBlock();":""))+"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");
	
    		 }
		
		 
	 }
	 if (!menu_mouse.equals("") && tli.getLokacija_gumba().equals("M")) {
		 
		 
		 sb.append("<input type=\"hidden\" id=\"M"+tli.getId()+"_<////%=vseb.getId()%////>\" value=\""+parametri+"\">\r\n");
		 
	 }
	 
	 
	 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
		 
		 sb.append("</span>");
		 
	 }
	 
	 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getFunkcija_formata3()).equals("")) { 
		 
		 sb.append("<%"); 
		 sb.append("}\r\n"); 
		 sb.append("}\r\n"); 
		 sb.append("%////>");  
	 }
	 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
		 sb.append("<%"); 
		 sb.append("}\r\n"); 
		 sb.append("%////>"); 
	 }


	 ///////// to copy
	 //// dam vse mozne pogoje za gumbe v z vrstici, ce je eden ok pokaze +
	 
	 
	 if ( tli.getLokacija_gumba().equals("Z") && (ling.size()==maxo)) {
		 jestartvrstice = true;
		 if (jestartvrstice) {
				sb.append("</span>\r\n");	
				
			}
		 
		 
		 
	//	 sb.append("<%\r\nnapr=false;\r\n"); 
		 
		// sb.append(skupaj);
		if (!jeskupajpogoj) {
			skupaj.append("napr=true;\r\n\r\n");
		}
		
		
		 skupaj.append("if (napr) {\r\n%////>\r\n");
		 
		 
		 if (nul.jeNull(sif.getUporabi_nove_gumbe()).equals("1")) {
		 
		 skupaj.append("<a  href=\"#\"  onclick=\"return odpriVrstico2('<////%=vseb.getId()%////>')\" class=\"btnblueb\"><span id=\"vimg<////%=vseb.getId()%////>\">+</span></a>");
		 }
		 else {
		 	 skupaj.append("<a  href=\"#\"  onclick=\"return odpriVrstico('<////%=vseb.getId()%////>')\"><img src=\"od.gif\" border=\"0\" id=\"vimg<////%=vseb.getId()%////>\"></a>");
	
		 }
		 
		 
		 skupaj.append("<%"); 
		 skupaj.append("}\r\n"); 
		 skupaj.append("%////>"); 
		 
		 
	 }
	 ///////////




	 
}





//sb.append("<////%\r\n");

//sb.append("}\r\n");
//sb.append("%////>\r\n");





sb.append("</span></td>\r\n");
sb.append("</tr>\r\n");

/// opcija za tree prikaz

sb.append("<////%//---ZACETEKZAAJAX2x---\r\n%////>");
 if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {
	 
	 
	// sb.append("</table>\r\n");
	
	// sb.append("<table>\r\n");
	//sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");

	sb.append("</table>\r\n");
	//sb.append("</li>\r\n");
	//sb.append("<////%}%////>\r\n");
		sb.append("<////%\r\n");
	sb.append("if  (  vseb."+(sif.getHead_class_name_nosql3())+"() !=null &&  vseb."+(sif.getHead_class_name_nosql3())+"().size()>0) {\r\n");
	sb.append("%////>\r\n");
	sb.append("</a>\r\n");
	sb.append("<////%\r\n");
	sb.append("}\r\n");
	sb.append("%////>\r\n");
sb.append("<////%if  (  vseb."+(sif.getHead_class_name_nosql3())+"() !=null &&   vseb."+(sif.getHead_class_name_nosql3())+"().size()>0) {%////>\r\n");
sb.append("<ol id=\"pm<////%=vseb.getId()%////>\"></ol>\r\n");
sb.append("<////%}%////>\r\n");




sb.append("</li>\r\n");
	
	//sb.append("<ul id=\"pm<////%=vseb.getId()%////>\"></ul>\r\n");
	
	//sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");
	//sb.append("<li>\r\n");
	//sb.append("<////%}%////>\r\n");
/*	sb.append("<table>\r\n");
sb.append("<tr style='display:none;' id='tr<////%=vseb.getId()%////>'><td style='width:8px'>&nbsp;</td><td colspan='"+(st_stolpcev)+"'><span id=\"pm<////%=vseb.getId()%////>\">\r\n");
 sb.append("</span></td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
*/

//sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");
//sb.append("</li>\r\n");
//sb.append("<////%}%////>\r\n");
//sb.append("</ul>\r\n");




sb.append("<////%if (nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\") && (lis.size()==stvrstic)) {%////>\r\n");
sb.append("</ol>\r\n");

sb.append("<////%}%////>\r\n");

//if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {
	
	

	
//}

 }


 sb.append("<////%//---ZACETEKZAAJAX3x---\r\n%////>");


sb.append("<////%\r\n");
sb.append("br++;\r\n");

sb.append("}/////////////// while end\r\n");


//sb.append("//---KONECZAAJAX---");

StringBuffer zaajaxprisotnost = new StringBuffer();

String skup = sb.toString();
zaajaxprisotnost.append(skup.substring(skup.indexOf("//---ZACETEKZAAJAX---")));





 sb.append("%////>\r\n");
 if (je_check_box!=null && !je_check_box.equals("")) {
		sb.append("</form>\r\n");
		
	}

 
 
 
 
 
 
 if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {

 
sb.append("</table>\r\n");


////info no data found
sb.append("<////%\r\n");
sb.append("if (norecords) {");
sb.append("%////>\r\n");
sb.append("<font style='font-size:2px'>&nbsp;</font><br><table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  style='background:ebebeb'>&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"    style='background:f3f3f3' height='35px'>\r\n");
sb.append("<p align=\"center\"><////%=nul.jeNull(ConPool.getPrevod_admin(\"1000033\",\"Y\",control.getJezik()+\"\"))%////>&nbsp;<br></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"   style='background:ebebeb'>&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("<////%}\r\n");
sb.append("%////>\r\n");





sb.append("<div id=\"popup\" style=\"position:absolute; z-index:1; visibility: hidden\"></div>\r\n");
 }




if (!nul.jeNull(tuidd.getDodatno_insert()).equals("")) {
sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_insert())+"\r\n");
}

sb.append("<script language=javascript>\r\n");
/////////////////////
/////////////////////
/// NAREDIM AJAX ZA UPDATE PRISOTNOSTI
/////////////////////

if (sif.getNologinneeded()!=null && sif.getNologinneeded().equals("1")) {
	sb.append("/*");
}

sb.append(getAjaxPrisotnost(zaajaxprisotnost.toString().replaceAll("<!--PLUSS-->", skupaj.toString()),contextUtil,this.getServletContext(),sif,imefile,stolpci_or,tuidd));

if (sif.getNologinneeded()!=null && sif.getNologinneeded().equals("1")) {
	sb.append("*/");
}
//// opcija ajaxa za tree strukturo, klices iz javascripte z idjem


 if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {


sb.append("function odpriPodList(idpodm,preskoci) {\r\n");
sb.append("if (idpodm==null || idpodm=='' || idpodm=='null') {\r\n");
sb.append("document.location=document.location;\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
//sb.append("if ((document.getElementById(\"pmg\"+idpodm).src+\"\").indexOf(\""+sif.getStruktura_tree_gumbo()+"\")!=-1 || preskoci==1) {\r\n");
sb.append("if (document.getElementById(\"pmli\"+idpodm).className==\"plus\" || preskoci==1) {\r\n");
//sb.append("document.getElementById(\"tr\"+idpodm).style.display=\"\";\r\n");

sb.append("xmlHttp=GetXmlHttpObject();\r\n");
sb.append("if (xmlHttp==null) {\r\n");
sb.append("alert (\"Browser does not support HTTP Request\");\r\n");
sb.append("return false;\r\n");
sb.append("}\r\n");
sb.append("var url=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp\";\r\n");
sb.append("url=url+\"?jehead="+nul.jeNull(sif.getStruktura_tree_head())+"\";\r\n");
sb.append("url=url+\"&idpm=\"+idpodm+\"&sid=\"+Math.random();\r\n");
sb.append("xmlHttp.open(\"GET\",url,false);\r\n");
sb.append("xmlHttp.send(null);\r\n");

//sb.append("alert(xmlHttp.responseText);\r\n");
sb.append("document.getElementById(\"pm\"+idpodm).innerHTML=xmlHttp.responseText;\r\n");
sb.append("document.getElementById(\"pmli\"+idpodm).setAttribute('class', 'minus');\r\n");
//sb.append("document.getElementById(\"pmg\"+idpodm).src=\""+sif.getStruktura_tree_gumbz()+"\";\r\n");

sb.append("}\r\n");
//sb.append("else if ((document.getElementById(\"pmg\"+idpodm).src+\"\").indexOf(\"empty.gif\")==-1) {\r\n");
sb.append("else if (document.getElementById(\"pmli\"+idpodm).className==\"minus\") {\r\n");
sb.append("document.getElementById(\"pm\"+idpodm).innerHTML=\"\";\r\n");
//sb.append("document.getElementById(\"pmg\"+idpodm).src=\""+sif.getStruktura_tree_gumbo()+"\";\r\n");
sb.append("document.getElementById(\"pmli\"+idpodm).setAttribute('class', 'plus');\r\n");
//sb.append("document.getElementById(\"tr\"+idpodm).style.display=\"none\";\r\n");
sb.append("}\r\n");
sb.append("}\r\n");

sb.append("return false;\r\n");
sb.append("}\r\n");



}








/// izpisem ostale hinte

sb.append("<////%\r\n");


sb.append("Enumeration enn = sifhintp.keys();\r\n");

sb.append("while (enn.hasMoreElements()) {\r\n");
sb.append("String nexi = (String)enn.nextElement();\r\n");
sb.append("%////>\r\n");
sb.append("<////%=nexi%////> = \"<////%=(String)sifhintp.get(nexi)%////>\";\r\n");
	
sb.append("<////%\r\n");
sb.append("}\r\n");

sb.append("%////>\r\n");


		sb.append("function go(asd,vv){\r\n");
				sb.append("if (vv == 1){\r\n");
						sb.append(" aaa = \"m_"+imefile.toLowerCase() +"_edit"+sif.getId()+".jsp?id=\"+asd;\r\n");
  sb.append("  parent.frames[2].location = aaa;\r\n");
  sb.append("}\r\n");

sb.append("return false;\r\n");
sb.append("}\r\n");
sb.append("function godown(asd){\r\n");
sb.append("parent.frames[2].location = asd;\r\n");
sb.append("return false;\r\n");
sb.append("}\r\n");
sb.append("function PGAPP(){\r\n");
sb.append("}\r\n");



sb.append("function odpriVrstico(spat){\r\n");

sb.append("evi = document.getElementById(\"vrst\"+spat);\r\n");
sb.append("evis = document.getElementById(\"vimg\"+spat);\r\n");
sb.append("if(evi.style.display == \"block\") {\r\n");
sb.append("evi.style.display = \"none\";\r\n");
sb.append("evis.src = \"od.gif\";\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("evi.style.display = \"block\";\r\n");
sb.append("evis.src = \"dom.gif\";\r\n");
sb.append("}\r\n");

sb.append("return false;\r\n");


sb.append("}\r\n");



sb.append("function odpriVrstico2(spat){\r\n");

sb.append("evi = document.getElementById(\"vrst\"+spat);\r\n");
sb.append("evis = document.getElementById(\"vimg\"+spat);\r\n");
sb.append("if(evi.style.display == \"block\") {\r\n");
sb.append("evi.style.display = \"none\";\r\n");
sb.append("evis.innerHTML = \"+\";\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("evi.style.display = \"block\";\r\n");
sb.append("evis.innerHTML = \"--\";\r\n");
sb.append("}\r\n");

sb.append("return false;\r\n");


sb.append("}\r\n");




sb.append("</script>\r\n");


sb.append("<////%\r\n");
// st izpisov





if (nul.jeNull(sif.getUporabi_count_ld()).equals("1")) {
	sb.append("int prvii=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(\"\")?1:Integer.parseInt(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\");\r\n");


sb.append("if (lis.size()>strec || prvii>1) {\r\n");


sb.append("String iskk=\"\";\r\n");

sb.append("if (!nul.jeNull(request.getQueryString()).equals(\"\")) {\r\n");
sb.append("iskk=nul.jeNull(request.getQueryString()).replaceAll(\"akcijaXY=DELETE\",\"\").replaceAll(\"pagenumber\",\"XY\")+\"\";\r\n");
sb.append("}\r\n"); 
sb.append("else {\r\n"); 
sb.append("iskk=\""+parametriSE.replaceAll("%","").replaceAll("< =", "\"+").replaceAll(">", "+\"")+"\";\r\n");
sb.append("}\r\n"); 
sb.append("String orme = \"\";\r\n"); 
sb.append("if (!nul.jeNull(request.getParameter(\"orderup\")).equals(\"\")) {\r\n");
sb.append("orme = \"&orderup=\"+request.getParameter(\"orderup\")+\"&orderupsmer=\"+request.getParameter(\"orderupsmer\");\r\n"); 
sb.append("}\r\n"); 
sb.append("if (!iskk.equals(\"\")) {\r\n");

sb.append("iskk=\"&\"+iskk+orme;\r\n");

sb.append("}\r\n");  
sb.append("if (iskanje) {\r\n");

sb.append("iskk=iskk+\"&isk=1\"+orme;\r\n");

sb.append("}\r\n");
sb.append("%////><p align=center>\r\n");
sb.append("<table  id='pagebrowse'    class=\"fontilist\" >\r\n");
sb.append("<tr bgcolor=\"ededed\">\r\n");
sb.append("<td align=center >\r\n");
sb.append("Browse page: </td><td>\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=1<////%=iskk%////>\">first</a></td><td>|</td>\r\n");


sb.append("<////%\r\n");
sb.append("int vse=0;\r\n");
sb.append("int ststr=0;\r\n");


sb.append("if (prvii>1) {\r\n");
sb.append("int prej = prvii-1;\r\n");
sb.append("%////>\r\n");
sb.append("<td>\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">previous</a></td>\r\n");

sb.append("<td>|</td>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");



sb.append("%////>\r\n");
sb.append("<td align=center bgcolor=\"<////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(ststr+\"\")?\"white\":\"ededed\" %////>\"> <a hrefs=\"\" style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=prvii %////><////%=iskk%////>\"><////%=prvii %////></a> </td><td>|</td>\r\n");
sb.append("<////%\r\n");





sb.append("if (lis.size()>strec) {\r\n");
sb.append("int prej = prvii+1;\r\n");
sb.append("%////>\r\n");
sb.append("<td>\r\n");
sb.append(" <a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">next</a></td>\r\n");


sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");



sb.append("</tr>\r\n");
sb.append("</table></p>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");


}
else {

sb.append("if (strec>stizpisov) {\r\n");
sb.append("String iskk=\"\";\r\n");

sb.append("if (!nul.jeNull(request.getQueryString()).equals(\"\")) {\r\n");
sb.append("iskk=nul.jeNull(request.getQueryString()).replaceAll(\"akcijaXY=DELETE\",\"\").replaceAll(\"pagenumber\",\"XY\")+\"\";\r\n");
sb.append("}\r\n"); 
sb.append("else {\r\n"); 
sb.append("iskk=\""+parametriSE.replaceAll("%","").replaceAll("< =", "\"+").replaceAll(">", "+\"")+"\";\r\n");
sb.append("}\r\n"); 
sb.append("String orme = \"\";\r\n"); 
sb.append("if (!nul.jeNull(request.getParameter(\"orderup\")).equals(\"\")) {\r\n");
sb.append("orme = \"&orderup=\"+request.getParameter(\"orderup\")+\"&orderupsmer=\"+request.getParameter(\"orderupsmer\");\r\n"); 
sb.append("}\r\n"); 
sb.append("if (!iskk.equals(\"\")) {\r\n");

sb.append("iskk=\"&\"+iskk+orme;\r\n");

sb.append("}\r\n");  
sb.append("if (iskanje) {\r\n");

sb.append("iskk=iskk+\"&isk=1\"+orme;\r\n");

sb.append("}\r\n");
sb.append("%////><p align=center>\r\n");
sb.append("<table  id='pagebrowse'  class=\"pagenumerationtable\" >\r\n");
sb.append("<tr bgcolor=\"ededed\" >\r\n");
sb.append("<td align=center class=\"pagenumeration\" >\r\n");
sb.append("Browse page: </td><td class=\"pagenumeration\">\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=1<////%=iskk%////>\">first</a></td><td class=\"pagenumeration\">|</td>\r\n");


sb.append("<////%\r\n");
sb.append("int vse=0;\r\n");
sb.append("int ststr=0;\r\n");

sb.append("int prvii=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(\"\")?1:Integer.parseInt(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\");\r\n");

sb.append("if (prvii>1) {\r\n");
sb.append("int prej = prvii-1;\r\n");
sb.append("%////>\r\n");
sb.append("<td class=\"pagenumeration\">\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">previous</a></td>\r\n");

sb.append("<td class=\"pagenumeration\">|</td>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");


sb.append("for (int y=0;y<strec;y++) {\r\n");
sb.append("vse++;\r\n");
sb.append("if (vse==stizpisov) {\r\n");
sb.append("vse=0;\r\n");

sb.append("ststr++;\r\n");
sb.append("if ((prvii-5)<ststr && ststr<(prvii+5)) {\r\n");
sb.append("%////>\r\n");
sb.append("<td align=center class=\"pagenumeration\" style=\"background-color:<////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(ststr+\"\")?\"'white'\":\"'ededed'\" %////>\"> <a hrefs=\"\" style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=ststr %////><////%=iskk%////>\"><////%=ststr %////></a> </td><td class=\"pagenumeration\">|</td>\r\n");
sb.append("<////%\r\n");

sb.append("}\r\n");
sb.append("}\r\n");

sb.append("}\r\n");
sb.append("if (vse!=0) {\r\n");
sb.append("%////>\r\n");
sb.append("<td align=center class=\"pagenumeration\" style=\"background-color:<////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(ststr+1+\"\")?\"'white'\":\"'ededed'\" %////>\"> <a hrefs=\"\" style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=ststr+1 %////><////%=iskk%////>\"><////%=ststr+1 %////></a> </td><td class=\"pagenumeration\">|</td>\r\n");
sb.append("<////%\r\n");


sb.append("}\r\n");



sb.append("if (prvii<=ststr) {\r\n");
sb.append("int prej = prvii+1;\r\n");
sb.append("%////>\r\n");
sb.append("<td class=\"pagenumeration\">\r\n");
sb.append(" <a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">next</a></td>\r\n");

sb.append("<td class=\"pagenumeration\">|</td>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");



sb.append("<td class=\"pagenumeration\"><a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=ststr+1%////><////%=iskk%////>\">last</a></td>\r\n");
sb.append("<td class=\"pagenumeration\">|</td>\r\n");
sb.append("<td  class=\"pagenumeration\">\r\n");
sb.append("page: <////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(\"\")?\"1\":session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")%////> of <////%=ststr+1%////> </td>\r\n");
sb.append("<td class=\"pagenumeration\">|</td>\r\n");
sb.append("<td class=\"pagenumeration\">\r\n");
sb.append("records: <////%=strec%////></td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table></p>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
}
sb.append("%////>\r\n");

sb.append("</body></html>\r\n");
 sb.append("<////%\r\n");

sb.append("}\r\n");
sb.append("catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("////log.error(ex.toString());\r\n");
sb.append("}\r\n");

sb.append("%////>\r\n");


/// menjam vrednost 


StringBuffer sbum = new StringBuffer();

sbum.append(sb.toString().replaceAll("<!--PLUSS-->", skupaj.toString()));


sb.delete(0,sb.length());

sb.append(sbum);


sbum.delete(0,sbum.length());



		}

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
/////////////  LIST PREKO MAILA
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
	if (sif.getTemplatemaillist()!=null  && sif.getTemplatemaillist().getUporabi() !=null && sif.getTemplatemaillist().getUporabi().equals("1")) {
		
		this.genListMail(idpr,order_by,order_by_smer,imefile,sif,contextUtil,pageContext.getServletContext());
		
		
		///// EXCEL
		this.genListExcel(idpr,order_by,order_by_smer,imefile,sif,contextUtil,pageContext.getServletContext());
		
	}

///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
///////////////LIST PREKO MAILA END
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////















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
	Hashtable  meto = templateUtil.getClassMetodeImenaHTGet(imefile);
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
	pp.append("@import \"ccss/custom.css\";\r\n");
	pp.append("@import \"js/uijs2/jquery-ui.css\";\r\n");
	pp.append("@import \"tooltipcss.css\";\r\n");
	////grafika oz barve

	if (sif.getGrafika_css()!=null && !sif.getGrafika_css().equals("")) {
	pp.append("@import \"css_dat/"+sif.getGrafika_css()+"\";\r\n");	
	}
	else {

	pp.append("@import \"barveblue.css\";\r\n");	
	}
	pp.append("</style>\r\n");
	pp.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");


	if (jestr || jenum) {
		pp.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
		}
		if (jenum) {
		pp.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
		}
//	pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"scripts/epoch_styles.css\">\r\n");
//	pp.append("<script type=\"text/javascript\" src=\"scripts/epoch_classes.js\"></script>\r\n");
	
//	pp.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
//	pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
	
//	pp.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
	
pp.append("<link rel=\"stylesheet\" href=\"js/uijs/jquery-ui.css\">\r\n");
pp.append("<script src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown
pp.append("<script src=\"scripts/jquery-migrate.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown


pp.append("<script language='javascript'  src=\"js/uijs/jquery-ui.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");


pp.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<body    "+(nul.jeN(sif.getHead_class_name_nosql2()).equals("")?"style=\"margin: 0\"":"class='"+nul.jeN(sif.getHead_class_name_nosql2())+"'")+"    onload=\"mom()\">\r\n");
	
	
	
pp.append("<table  border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\"  bgcolor=#C3E1FC	>\r\n");
pp.append("<tr>\r\n");
pp.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("<table   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\" width=\"98%\" id=\"table2\" height=\"92%\" >\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#E3F1FE\" align=\"center\">\r\n");
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_funk"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#C3E1FC\" colspan=\"2\">\r\n");






pp.append("&nbsp;</td>\r\n");
pp.append("</tr>\r\n");





boolean jenekaj = false;
if (liko.size()>0) {
jenekaj = true;

Iterator ipp = liko.iterator();

while (ipp.hasNext()) {
	com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)ipp.next();
	
	
	
	
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#C3E1FC\" align=\"right\">\r\n");





pp.append("<p align=\"center\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td align=\"left\" bgcolor=\"#A8D3FB\">\r\n");



String max = nul.jeNull(tu.getStolpec_max_stevilo_znakov());
String dol = nul.jeNull(tu.getStolpec_sirina());
String tabi = nul.jeNull(tu.getTab_index());



if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {
	
	
	Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(sif.getHead_class_name());
	if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
		pp.append("<input type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"    onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  > <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"\" ><img src='call.gif' border='0'></a> \r\n");
		}
		else {	

pp.append("<input type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  >\r\n");
}
}
else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
	/// nujno dodati v insert pogoje
	pp.append("<input type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" >\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
	/// nujno dodati v insert pogoje
	String cols = nul.jeNull(tu.getCols());
	String rows = nul.jeNull(tu.getRows());
	
	pp.append("<textarea "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=rezu%////></textarea>\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
		
		
		
		pp.append("<select "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n");
		pp.append("<option></option>\r\n");
 
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
	
	
	
		
		
		pp.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n");
		
		
		}
		
		
		String sifra="";
		String vrednost="";
		/// dobim vrednosti za sifro in vrednost hinta
			 ikov = tu.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
		
		while (ikov.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcc = (com.popultrade.model.TemplateClassClass_vrednosti)ikov.next();	
		
		if (nul.jeNull(tcc.getTip()).equals("sifra")) {
			sifra = nul.jeNull(tcc.getVrednost());
		}
		if (nul.jeNull(tcc.getTip()).equals("vrednost")) {
			vrednost = vrednost + "<////%=nul.jeNull(modi"+clna+"."+nul.jeNull(tcc.getVrednost())+"())%////> ";
		}
		}
		
		
		if (!sifra.equals("") && !vrednost.equals("")) {
		
			String sorder = nul.jeNull(tu.getTemplateClassClass().getHead_select_dodatni_pogoji());
  			String sorders = nul.jeNull(tu.getTemplateClassClass().getOrder_by_smer());
  			
  		
  	//	premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n";
			
			
			
			pp.append("List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n");
		
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



pp.append("<tr>\r\n");
pp.append("<td colspan=\"2\" bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
pp.append("<input TYPE=\"submit\" VALUE=\"< %=ConPool.getPrevod(\""+sif.getId()+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  style=\"font-family: Verdana; font-size: 8pt\">&nbsp;</td>\r\n");
pp.append("</tr>\r\n");

/// dodam parametre iz gumba
//// dam parametre, ki posljem preko requesta
 if (tgumb.getTemplateGumbiParametris()!=null && tgumb.getTemplateGumbiParametris().size()>0) {
	 
	 
	 Iterator iko = tgumb.getTemplateGumbiParametris().iterator();
	 
	 
	 while (iko.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)iko.next();
		 
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("getParameter")!=-1) {
			 sb.append("<input type=hidden name=\""+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"\" value=\"<////%=nul.jeNull(\""+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>\">\r\n");
			 
		 }
		 
		 else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
		 sb.append("<input type=hidden name=\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\"))%////>\">\r\n");
		 }
		 
		 
		 
	 }
	 
	 
	 
 }



pp.append("</form></table>\r\n");
pp.append("<font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");
pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");
	
	
	
	
	
	
	
	
	
	
	
	pp.append("</body>\r\n");
	
	pp.append("<script language=javascript>\r\n");
	pp.append("function mom() {\r\n");
	pp.append("top.window.hideFrame();}\r\n");
	pp.append("</script>\r\n");
	pp.append("<////%\r\n");


	pp.append("////}\r\n");
	pp.append("////catch (Exception ex){\r\n");
	pp.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

	pp.append("////log.error(ex.toString());\r\n");
	pp.append("////}\r\n");
	pp.append("%////>\r\n");
	
	/// shranim

	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_p"+".jsp"), "latin1"));



	out3.write(pp.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
}






imefile = imefile+"_list"+sif.getId();



}
////konec kreacija jsp za list
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
