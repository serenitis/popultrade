<%@ page contentType="text/html; " import="jxl.*,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
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

this.contextUtil2 = contextUtil;


//// lokacija kam deployat jspje
String deploy_kam = parametrii.getParametri().getProperty("deploy_kam");//"E:/Tomcat5.0/webapps/ics/";
// String deploy_kam = "C:/Tomcat5.0/webapps/ics/";

//// lokacija fo datotek
//String deploy_kam_fo = "C:/Tomcat5.0/webapps/ics/fofiles/";
String deploy_kam_fo = parametrii.getParametri().getProperty("deploy_kam_fo");//"e:/Tomcat5.0/webapps/ics/fofiles/";
%>



<%!
 public com.popultrade.webapp.ContextUtil contextUtil2 = null;
 
private com.popultrade.webapp.Parametri parametri = new com.popultrade.webapp.Parametri();
public String deploy_kam = parametri.getParametri().getProperty("deploy_kam");//"E:/Tomcat5.0/webapps/ics/";
//public String deploy_kam = "C:/Tomcat5.0/webapps/ics/";

private com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();



//// creiram vsebino vezano na gumb pp

public String createPP(Object tlii,String tipobjekta) {

StringBuffer sbl = new StringBuffer();

Iterator iteb=null;

			String format_stolpca=""; 
			 
			 if (tipobjekta.equals("templateui")) {
			 format_stolpca = ((com.popultrade.model.TemplateUi)tlii).getFormat_stolpca();
			 
			  iteb = ((com.popultrade.model.TemplateUi)tlii).getTemplateClasses().iterator();
			}
			else if (tipobjekta.equals("templatelist")) {
			format_stolpca = ((com.popultrade.model.TemplateList)tlii).getFormat_stolpca();
			 iteb = ((com.popultrade.model.TemplateList)tlii).getTemplateClasses().iterator();
			
			}
				else if (tipobjekta.equals("templatepp")) {
			format_stolpca = ((com.popultrade.model.TemplatePP)tlii).getFormat_stolpca();
			 iteb = ((com.popultrade.model.TemplatePP)tlii).getTemplateClasses().iterator();
			
			}
			
			if (!tipobjekta.equals("templatelist")) {
			 sbl.append("<%\r\n");
			}
			
			
			 sbl.append("rezu=\"\";\r\n");
			 
			// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
		
			// nul.getDatumFormatFromDate()
			 while (iteb.hasNext()) {
				 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
				 
				 
				 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
							 
					
					
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
									 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
																										 }
								 else {
									 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2()+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
														
								 }   	 
							 
						 }
						 else {
						
								
							 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
									
								 sbl.append("rezu=rezu+\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
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
	sbl.append("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n");

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
			
				rett = "nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()).replaceAll(\"_\",\"\\\\_\")";
				}
				}
			else {
				rett = tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()";
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
		
		
		if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			sbl.append("mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
			
		}
		else {
			
		
		sbl.append("mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
		}
		
		
		
		
		
		
		
	}


	sbl.append("List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n");


	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 11");

	sbl.append("if (remi.size()>0) {\r\n");

	sbl.append("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n");




	//// pogoji vrednosti

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
					 sbl.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n");
					 
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
					 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
																									 }
				 else {
					 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2()+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
										
				 }   
								 
							 
						 }
						 else {
							 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
								 sbl.append("rezu=rezu+\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
																 			 }
								 else {
									 sbl.append("rezu=rezu+"+txc.getVrednost_pogoja()+";\r\n\r\n");
													
								 }
							// sbl.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
						
						 
						 
						 }
						 }
						 
					 
					 
					 sbl.append("}\r\n");
					 
				 }
				 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
					 
					 
		 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
						 
						 if (nul.jeNull(txc.getFunkcija_formata2()).indexOf(".get")==-1) {
							 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
																													 }
						 else {
							 sbl.append("rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2()+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
												
						 }  
						 
					 }
					 else {
					
						 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
							 sbl.append("rezu=rezu+\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
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
							 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"").replaceAll("\'","\"")+");\r\n\r\n");
							 }
						 else {
							 sbl.append("rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2()+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
												
						 }  
						 
					 }
					 else {
						 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 121");
						 if (tc.getVrednost_pogoja()!=null && nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
							 sbl.append("rezu=rezu+\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("nul.je","\"+nul.je").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
																			 			 }
							 else if (tc.getVrednost_pogoja()!=null ) {
								 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja()+";\r\n\r\n");
												
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









public String getAjaxPP(com.popultrade.model.TemplatePP tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,String ime_field) {
	com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();
	
	String premos="";
	
 
	
	if (tu.getTemplateDD()!=null && tu.getTemplateDD().getId()!=null) {
		
		
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		System.out.println("-------------------AJAXXXXXXXXXX----------");
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		System.out.println("-----------------------------");
		//System.out.println("-----------------------------"+tu.getTemplateClassClass().getTemplateClasss().size());
		
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
		
		System.out.println("-----------------------------77777");
		String dodaten = "";
		if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getTemplateClasss()!=null && tu.getTemplateClassClass().getTemplateClasss().size()>0) {
			System.out.println("-----------------------------666666");
			Iterator tre = tu.getTemplateClassClass().getTemplateClasss().iterator();
			while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			System.out.println("-----------------------------9999999");
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
		System.out.println("-----------------------------");
		System.out.println("-----------------------------123");
		System.out.println("-----------------------------");
	 	 
		premos = premos + "if (true "+dodaten+") {\r\n";
							 
		premos = premos + "com.popultrade.dao."+tu.getTemplateDD().getClass_name()+"DAO doax =(com.popultrade.dao."+ tu.getTemplateDD().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tu.getTemplateDD().getClass_name().substring(0,1).toLowerCase() +tu.getTemplateDD().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

		premos = premos + "com.popultrade.model."+tu.getTemplateDD().getClass_name() +" modx = new com.popultrade.model."+tu.getTemplateDD().getClass_name() +"();\r\n";



		com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",servletContext);

		/// setam vrednosti

		com.popultrade.model.TemplateDDPogoji sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tu.getTemplateDD().getId());
		sifh.setTip("P");
		
	
		System.out.println("-----------------------------");
		System.out.println("-----------------------------234");
		System.out.println("-----------------------------");
		List lish =null;
		
		lish = daodd.getTemplateDDPogojis(sifh);
		Iterator tre = lish.iterator();
		String daj_v_parameter="";
		Hashtable metos = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tu.getTemplateDD().getClass_name());
		while (tre.hasNext()) {
com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			String rett="nul.menjajVSumnike(request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\"),nul.jeNull(ConPool.getPrevod_admin(\"1000010\",\"Y\",\"SL\")))+\"\"";
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
			
			System.out.println("-----------------------------");
			System.out.println("-----------------------------567");
			System.out.println("-----------------------------");
			
			
			
			if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
				premos = premos + tcc.getPogoj_uporabe().replaceAll("\'","\"") + " {\r\n";
			}
			premos = premos + "modx."+tcc.getIme_metode()+"("+rett+");\r\n";
			if (!nul.jeNull(tcc.getPogoj_uporabe()).equals("")) {
				premos = premos +  " }\r\n";
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
    			daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"='+encodeURIComponent(document.dod."+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+".value) +'";
    			}
		else {
    				
    				
    				if (nul.jeNull(tcc.getPosreduj_vrednost()).equals("1")) {
    					
    					String vredmet = tcc.getVrednost_metode();
    					if (vredmet.indexOf("request.getParameter")!=-1) {
    						vredmet = vredmet.substring(vredmet.indexOf("'")+1,vredmet.lastIndexOf("'"));
    					}
    				
    					daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+vredmet+"=encodeURIComponent(<////%="+tcc.getVrednost_metode().replaceAll("'","\"")+"%////>)";
        				
    				}
    				else {
    				daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"=encodeURIComponent("+tcc.getVrednost_metode()+")";
    				}
    			}
			preej=true;
			}
		}

		System.out.println("-----------------------------");
		System.out.println("-----------------------------789");
		System.out.println("-----------------------------");
		String order_by = "";
		if (!nul.jeNull(tu.getTemplateDD().getHead_select_dodatni_pogoji()).equals("")) {
			order_by = nul.jeNull(tu.getTemplateDD().getHead_select_dodatni_pogoji());
		}
		
		String dodaten_HQL = "";
		
		premos = premos + "String dod_hql=\"\";\r\n";
		
		if (nul.jeNull(tu.getTemplateDD().getUporabi_dodaten_hql_pogoj()).equals("1")) {
			dodaten_HQL="sss";
			/// pogoj hql
			if (!nul.jeNull(tu.getTemplateDD().getPogoj_za_uporabo_hql()).equals("")) {
				premos = premos + nul.jeNull(tu.getTemplateDD().getPogoj_za_uporabo_hql())+" {\r\n";
			}
			premos = premos + " dod_hql=\""+nul.jeNull(tu.getTemplateDD().getDodaten_hql_pogoj())+"\";\r\n";
			if (!nul.jeNull(tu.getTemplateDD().getPogoj_za_uporabo_hql()).equals("")) {
				premos = premos + " }\r\n";
			}
			
			
		}
		
		
		String order_by_smer = "";
		
		if (!nul.jeNull(tu.getTemplateDD().getOrder_by_smer()).equals("")) {
			order_by_smer = nul.jeNull(tu.getTemplateDD().getOrder_by_smer());
		}
		
		if (order_by.equals("") && dodaten_HQL.equals("")) {
		premos = premos + "List remix=doax.get"+tu.getTemplateDD().getClass_name()+"s(modx,\"\",\"\");\r\n";
		}
		else if (!dodaten_HQL.equals("")) {
			premos = premos + "List remix=doax.get"+tu.getTemplateDD().getClass_name()+"s2(modx,\""+order_by+"\",\""+order_by_smer+"\",dod_hql);\r\n";
		}
		else {
			premos = premos + "List remix=doax.get"+tu.getTemplateDD().getClass_name()+"s(modx,\""+order_by+"\",\""+order_by_smer+"\");\r\n";
		}



		premos = premos + "if (remix.size()>0) {\r\n";
		
		
		
 		sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tu.getTemplateDD().getId());
		sifh.setTip("V");
		
	
		
		System.out.println("-----------------------------");
		System.out.println("-----------------------------1011112");
		System.out.println("-----------------------------");
		
		lish = daodd.getTemplateDDPogojis(sifh);
		tre = lish.iterator();
		String daj_v_id="";
		String daj_v_set="";
		String daj_v_vrednost="";
		//String daj_v_div="";
		/////// vrednosti pogoja
		while (tre.hasNext()) {
			com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			if (!nul.jeNull(tcc.getPosreduj_vrednost()).equals("1"))  {
			
			if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("1")) {
				//daj_v_id = daj_v_id +"<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ___ ";
				//daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
				
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
				
			
						if (!nul.jeNull(tcc.getUporabi_format_vrednost()).equals("1")) {
					
				daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
				}
				else {
					daj_v_vrednost = daj_v_vrednost+"<%"+nul.jeNull(tcc.getFormat_vrednost())+"%////>";
					
					daj_v_vrednost = daj_v_vrednost +"<%=rezu_format%////> ";
					
				}
			//daj_v_vrednost = daj_v_vrednost + "<%try{String yt =nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\");%////><%=yt%////><%}catch(Exception ex){}%////> ";
				
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
		premos = premos + "com.popultrade.model."+tu.getTemplateDD().getClass_name()+" vsebx = (com.popultrade.model."+tu.getTemplateDD().getClass_name()+")itx.next();\r\n";
		premos = premos + "%////>"+daj_v_id+"###"+daj_v_vrednost+"|<////%\r\n";	
		premos = premos + "}\r\n";

		
		premos = premos + "}\r\n";
		premos = premos + "}\r\n";
		
		
		premos = premos + "}\r\n";
		premos = premos + "catch (Exception ex){\r\n";
		premos = premos + "org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n";
		
		premos = premos + "log.error(ex.toString());\r\n";
		premos = premos + "}%////>\r\n";
		
		System.out.println("-----------------------------");
		System.out.println("-----------------------------34436634");
		System.out.println("-----------------------------");
		try {
		/// shranim file za ajax
		if ((tu.getTemplateDD().getStatus()).equals("1")) {
		Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"), "latin1"));



		out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
		////zaprem writer3
		out3.close();
		String velike_crke = "";//nul.jeNull(tu.getSamo_velike_crke());
		
		return "  autocomplete=\"off\"  onfocus=\"ajax_options_hide();change(this,'yellow');"+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"')}\" onkeyup=\""+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"')}\" ";
		}
		}
		catch (Exception exx) {
			System.out.println("NAPAKA AJAX::: "+exx.toString());
		}
		
	}
	return "";
	 
	
}

//// search





public String genFieldSEE(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {
	//com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	try {
	String premo="";
	
        
        /// pogoji prikaza
        
        	 /// pogledam, ce ima pogoje
	 
	 if (tu.getTemplateClasses().size()>0) {
	 
	 
	 premo = premo + createPP(tu,"templateui");
		 
		 
	 }
	 else {
		 
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
	
        
        /// pogoji prikaza
        


        
      
        if (nul.jeNull(tu.getVnos_kdaj()).equals("BO") || nul.jeNull(tu.getVnos_kdaj()).equals("UP") || nul.jeNull(tu.getVnos_kdaj()).equals("AJ")  || nul.jeNull(tu.getVnos_kdaj()).equals("IN") ) {
        	
        	
        	if (!nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).equals("")) {
 		premo = premo + "<////%\r\n\r\n";
          		
        		premo = premo + nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).replaceAll("\'","\"")+"\r\n";
        		
          		premo = premo + "%////>\r\n";
        	}
        	/// kontrola in generacija AJAX
        	 	/// kontrola in generacija AJAX
        	
        	String ime_field="";
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        		
        		ime_field = nul.jeNull(tu.getParameter_drugo_ime()).trim();
        		
        	}
        	else {
        		
        		ime_field = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
        		
        	}
        	String[] ajaxpoljea = getAjax(tu,contextUtil,servletContext,ime_field);
  
        	String ajaxpolje = ajaxpoljea[0];
  
  			boolean novajax=false;
  			if (ajaxpolje.indexOf("<div")!=-1) {
  			novajax=true;
  			}
        	
        	/// konec geracije ajaxa
        	
        	 
        	
        //	System.out.println("AJAX: ::: "+ajaxpolje);
        	
        	
        	if (nul.jeNull(tu.getVnos_kdaj()).equals("UP")) {
          		premo = premo + "<////%\r\n\r\n";
          		
        		premo = premo + "if (vseb.getId()!=null && !vseb.getId().equals(\"\")) {\r\n";
        		
          		premo = premo + "%////>\r\n";
        		
        	}
        		else if (nul.jeNull(tu.getVnos_kdaj()).equals("IN")) {
        			premo = premo + "<////%\r\n\r\n";
        		
        			premo = premo + "if (vseb.getId()==null) {\r\n";
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
        	
        	
        	else if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {
        		
        	if (!nul.jeNull(tu.getDatum_vnos_tip()).equals("1")) {
        		
        		String dodc = "";
        		
        		if (ajaxpolje.equals("") && velike_crke.equals("1")) {
        			dodc = " onkeyup=\"javascript:this.value=this.value.toUpperCase();\" ";
        		}
        		
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("") && nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  readonly type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  style=\"border: 0px solid #D2EAFF;background-color:#D2EAFF;font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+">\r\n";
        	
        	
        	}
        	else {
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
        		//premo = premo + "<input type=\"text\" value=\"<////%=rezu%////>\"   "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  style=\"font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" ><img src='call.gif' border='0'></a> \r\n";
        		
        		if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        		premo = premo + "<input type=\"text\"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIExVC\" ":" class=\"inputIEx\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getParameter_drugo_ime())+"')\"><img src='call.gif' border='0'></a> \r\n";
        		}
        		else {
        		premo = premo + "<input type=\"text\"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIExVC\" ":" class=\"inputIEx\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\"><img src='call.gif' border='0'></a> \r\n";
        		
        		}
        		
        		}
        		else {
        			
        		
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\"text\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+"  value=\"<////%=rezu%////>\">\r\n";
            				
        			}
        			else {
        			premo = premo + "<input type=\"text\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"   "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+"  value=\"<////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")%////>\">\r\n";
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
        	
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=A"+tu.getId()+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\"><img src='call.gif' border='0'></a> ";
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"   maxlength=\'5\' size=\'6\' value=\"<////%=B"+tu.getId()+"%////>\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\" >";
	        	
        	}
        	}
        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
        		/// nujno dodati v insert pogoje
        		
        		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
        		
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"  >";
                	
        		}
        		else {
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\").equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"   >";
                		
        		}
        		}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
        		/// nujno dodati v insert pogoje
        		String cols = nul.jeNull(tu.getCols());
        		String rows = nul.jeNull(tu.getRows());
        		
        		premo = premo + "<textarea "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")%////></textarea>";
        	}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
          		
          		
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
        		}
        		else {
        			premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
                			
        		}
          		
          		
          		premo = premo + "<option></option>";

          	/// kontrola hintov, ce ima dodam opcije
          	if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getClass_name()!=null) {
          		
          		String dodaten = "";
          		if (tu.getTemplateClassClass().getTemplateClasss().size()>0) {

          			Iterator tre = tu.getTemplateClassClass().getTemplateClasss().iterator();
          			while (tre.hasNext()) {
          			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
          			
          			if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
          			
          				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
          			
          				dodaten =  dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("get","vseb.get")+"()+\"\").equals(\"\")";
          				}
          			
          			}
          			else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
          				dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("'","\"")+"+\"\").equals(\"\")";
          			}
          			}
          			/// dodaten pogoj da sploh gleda po bazi
          			
          			
          			
          		}
          		
          		
          		
          		
          		
          		String clna = tu.getTemplateClassClass().getClass_name();
          		premo = premo + "<////%\r\n";
          		
          		premo = premo + "if (true "+dodaten+") {\r\n";
          		premo = premo + "com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n";

          		premo = premo + "com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n";

          		
          		//// vrednosti
          		
          		Iterator ikov = tu.getTemplateClassClass().getTemplateClasss().iterator();
          		Hashtable meto = templateUtil.getClassMetodeImenaHTGet(clna);
          		while (ikov.hasNext()) {
          		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
          		
          		
				String rett=tcc.getVrednost_pogoja().replaceAll("\'","\"")+"+\"\"";
				
				if (tcc.getIme_pogoja()!=null && meto.containsKey((tcc.getIme_pogoja()))) {
				if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
					
					
					
					rett = "new Long("+rett+")";
					
					
					
				}
				else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("int")!=-1 || ((String)meto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1) {
					rett = "Integer.parseInt("+rett+")";
					
				}
				else if (((String)meto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
				
					rett = "Double.parseDouble("+rett+")";
				}
				
				}
				
          		
          		
          		premo = premo + "mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n";
          		
          		
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
          			vrednost = nul.jeNull(tcc.getVrednost());
          		}
          		}
          		
          		
          		if (!sifra.equals("") && !vrednost.equals("")) {
          			
          			String sorder = nul.jeNull(tu.getTemplateClassClass().getHead_select_dodatni_pogoji());
          			String sorders = nul.jeNull(tu.getTemplateClassClass().getOrder_by_smer());
          			
          		
          		premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n";
          		
          		
          		
          		
          		premo = premo + "Iterator i"+clna+"=li"+clna+".iterator();\r\n";
          		

          		
          		premo = premo + "while (i"+clna+".hasNext()) {\r\n";
          		premo = premo + "com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n";

          		
          		premo = premo + "%////>\r\n";
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" ><////%=nul.jeNull(modi"+clna+"."+vrednost+"())%////></option>;\r\n";
          		}
          		else {
          			premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" <////%=nul.jeNull(modi"+clna+"."+sifra+"()).equals(nul.jeNull(nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")))?\"selected\":\"\"%////>><////%=nul.jeNull(modi"+clna+"."+vrednost+"())%////></option>;\r\n";
                  	
          		}
          		//premo = premo + "p"+tu.getId()+"<////%=modi"+clna+"."+sifra+"()%////>=\"<////%=modi"+clna+"."+vrednost+"()%////>\";\r\n";

          		premo = premo + "<////%\r\n\r\n";
          		premo = premo + "}\r\n\r\n";
          		
          		}
          		
          		premo = premo + "}\r\n";
          		premo = premo + "%////>\r\n";
          		
          		
          	}
          		
          		
          	
          		
          	premo = premo + "</select>\r\n";
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          	}
        	
        	
        	
        	 	if (novajax) {
        	
        	premo = premo + "</div>";
        	
        	
        	        		premo = premo + "<script language='javascript'>\r\n";
        		premo = premo + "var dropdown"+tu.getId()+" = new Bloodhound({\r\n";
				premo = premo + "datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),\r\n";
				premo = premo + " queryTokenizer: Bloodhound.tokenizers.whitespace,\r\n";
			//	premo = premo + "remote: '"+(ajaxpoljea[1].substring(0, ajaxpoljea[1].indexOf(".jsp")+4))+"=%QUERY'\r\n";
				
				premo = premo + "remote: {\r\n";
                premo = premo + "url: '"+(ajaxpoljea[1].substring(0, ajaxpoljea[1].indexOf(".jsp")+4))+"?ime=%QUERY',\r\n";
                premo = premo + "replace: function () {\r\n";
                premo = premo + "var q = '"+ajaxpoljea[1]+";\r\n";

               // premo = premo + "q += document.dod.akcijaXY.value; // %QUERY

                        //alert(q);

               premo = premo + " return q;\r\n";
               premo = premo + "}\r\n";
                premo = premo + "}\r\n";
				
				premo = premo + "});\r\n";
				 
				premo = premo + "dropdown"+tu.getId()+".initialize();\r\n";
				 
				premo = premo + "$('#remote"+tu.getId()+" ."+(nul.jeNull(tu.getDdivclasscusin()).equals("")?"inputIExa":tu.getDdivclasscusin())+"').typeahead({\r\n";
				premo = premo + "minLength: "+ajaxpoljea[2]+",\r\n";
				premo = premo + "highlight:true,\r\n";
				premo = premo + "hint:false\r\n";
				premo = premo + "}, {\r\n";
				premo = premo + "name: 'nam"+tu.getId()+"',\r\n";
				premo = premo + "displayKey: 'value',\r\n";
				premo = premo + "source: dropdown"+tu.getId()+".ttAdapter()\r\n";
				  
				premo = premo + "}).on('typeahead:selected', function (obj,value) {\r\n";
				
				
				premo = premo + "if (value[\"set\"].indexOf(\" ___ \")!=-1) {\r\n";
				premo = premo + "var spl1 = value[\"set\"].split(\" ___ \");\r\n";
				premo = premo + "var idd1 = value[\"idd\"].split(\" ___ \");\r\n";
				premo = premo + "for (i=0;i<spl1.length;i++) {\r\n";
				premo = premo + "document.getElementById(spl1[i]).value=idd1[i];\r\n";
				premo = premo + "}\r\n";
				premo = premo + "}\r\n";
				premo = premo + "else {\r\n";
				premo = premo + "var spl1 = value[\"set\"];\r\n";
				premo = premo + "document.getElementById(spl1).value=value[\"idd\"];\r\n";
				premo = premo + "}\r\n";
				
				
				
				
				//premo = premo + "alert(value[\"value\"]);\r\n";
				
				premo = premo + "});\r\n";
        		premo = premo + "</script>\r\n";
        	
        	
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
       			 premo = premo + "<img "+wi+"  "+he+" src='<////%=control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu%////>' border='0' >\r\n";
       			premo = premo + "<////%\r\n";
				 premo = premo + "}\r\n\r\n";
				 premo = premo + "%////>\r\n";
       		 }
       		 else {
       			 
       		 if (nul.jeNull(tu.getDodaten_pogoj_prikaz_say()).equals("1")) {
       	        		premo = premo + "<////%=rezu%////>\r\n";
       		 }
       		 
       		 }	
          		
          		//premo = premo + "<////%=rezu%////>\r\n";
          		
          		
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
       			 premo = premo + "<img "+wi+"  "+he+" src='<////%=control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu%////>' border='0' >\r\n";
       			premo = premo + "<////%\r\n";
				 premo = premo + "}\r\n\r\n";
				 premo = premo + "%////>\r\n";
       		 }
       		 else {
       	        		premo = premo + "<////%=rezu%////>\r\n";
       		 }	
        		
        	//	premo = premo + "<////%=rezu%////>\r\n";
        		
        	}
	
	
	return premo;
	}
	
	catch (Exception ex) {
		System.out.println("Napaka pri gen field :" + ex.toString());
	}
	
	return "";
	
}








//// end search







private String kontrolaAjaxJS=""; //// setam funkcije klicanje AJAXA preko JS
private String kontrolaAjaxJSf=""; //// setam klicanje AJAXA 
public void setKontrolaAjaxJSf(String kontrola) {
	kontrolaAjaxJSf =kontrolaAjaxJSf+kontrola;
	}
		

	public String getKontrolaAjaxJSf() {
	return kontrolaAjaxJSf;
	}


public void setKontrolaAjaxJS(String kontrola) {
kontrolaAjaxJS =kontrolaAjaxJS+kontrola;
}
	

public String getKontrolaAjaxJS() {
return kontrolaAjaxJS;
}




public String genFieldSE(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {
	//com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	try {
	String premo="";
	
        
        /// pogoji prikaza
        


        
      
        if (nul.jeNull(tu.getVnos_kdaj()).equals("BO") || nul.jeNull(tu.getVnos_kdaj()).equals("UP") || nul.jeNull(tu.getVnos_kdaj()).equals("AJ")  || nul.jeNull(tu.getVnos_kdaj()).equals("IN") ) {
        	
        	
        	
        	/// kontrola in generacija AJAX
        	       	String ime_field="";
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        		
        		ime_field = nul.jeNull(tu.getParameter_drugo_ime()).trim();
        		
        	}
        	else {
        		
        		ime_field = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
        		
        	}
        	String[] ajaxpoljea = getAjax(tu,contextUtil,servletContext,ime_field);
  
        	 	String ajaxpolje = ajaxpoljea[0];
  
  			boolean novajax=false;
  			if (ajaxpolje.indexOf("<div")!=-1) {
  			novajax=true;
  			}
        	
        	/// konec geracije ajaxa
        	
        	 
        	
        //	System.out.println("AJAX: ::: "+ajaxpolje);
        	
        	
        	if (nul.jeNull(tu.getVnos_kdaj()).equals("UP")) {
          		premo = premo + "<////%\r\n\r\n";
          		
        		premo = premo + "if (vseb.getId()!=null && !vseb.getId().equals(\"\")) {\r\n";
        		
          		premo = premo + "%////>\r\n";
        		
        	}
        		else if (nul.jeNull(tu.getVnos_kdaj()).equals("IN")) {
        			premo = premo + "<////%\r\n\r\n";
        		
        			premo = premo + "if (vseb.getId()==null) {\r\n";
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
        	if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {
        		
        	if (!nul.jeNull(tu.getDatum_vnos_tip()).equals("1")) {
        		
        		String dodc = "";
        		
        		if (ajaxpolje.equals("") && velike_crke.equals("1")) {
        			dodc = " onkeyup=\"javascript:this.value=this.value.toUpperCase();\" ";
        		}
        		
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("") && nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  readonly type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  style=\"border: 0px solid #D2EAFF;background-color:#D2EAFF;font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+">\r\n";
        	}
        	else {
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
        		premo = premo + "<input type=\"text\"    "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  style=\"font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"<////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")%////>\" ><img src='call.gif' border='0'></a> \r\n";
        		}
        		else {
        			premo = premo + "<input type=\"text\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  style=\"font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+"  value=\"<////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")%////>\">\r\n";
            		
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
        	
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=A"+tu.getId()+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\"><img src='call.gif' border='0'></a> ";
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"   maxlength=\'5\' size=\'6\' value=\"<////%=B"+tu.getId()+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" >";
	        	
        	}
        	}
        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
        		/// nujno dodati v insert pogoje
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\").equals(\"1\")?\"checked\":\"\"%////>  value=\"1\" style=\"font-family: Verdana; font-size: 8pt\"  >";
        	}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
        		/// nujno dodati v insert pogoje
        		String cols = nul.jeNull(tu.getCols());
        		String rows = nul.jeNull(tu.getRows());
        		
        		premo = premo + "<textarea "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+" style=\"font-family: Verdana; font-size: 8pt\"><////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")%////></textarea>";
        	}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
          		
          		
          		
          		premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
          		premo = premo + "<option></option>";

          	/// kontrola hintov, ce ima dodam opcije
          	if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getClass_name()!=null) {
          		
          		String clna = tu.getTemplateClassClass().getClass_name();
          		premo = premo + "<////%\r\n";
          		
          		premo = premo + "if (true) {\r\n";
          		premo = premo + "com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n";

          		premo = premo + "com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n";

          		
          		//// vrednosti
          		
          		Iterator ikov = tu.getTemplateClassClass().getTemplateClasss().iterator();
          		Hashtable meto = templateUtil.getClassMetodeImenaHTGet(clna);
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
				
				
				
          		
          		
          		premo = premo + "mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n";
          		
          		
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
          			vrednost = nul.jeNull(tcc.getVrednost());
          		}
          		}
          		
          		
          		if (!sifra.equals("") && !vrednost.equals("")) {
          		
          			
        			String sorder = nul.jeNull(tu.getTemplateClassClass().getHead_select_dodatni_pogoji());
          			String sorders = nul.jeNull(tu.getTemplateClassClass().getOrder_by_smer());
          			
          		
          		premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+",\""+sorder+"\",\""+sorders+"\");\r\n";
        		
          			
          			
          			
          			
          			
          			//premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+");\r\n";
          		
          		premo = premo + "Iterator i"+clna+"=li"+clna+".iterator();\r\n";
          		

          		
          		premo = premo + "while (i"+clna+".hasNext()) {\r\n";
          		premo = premo + "com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n";

          		
          		premo = premo + "%////>\r\n";
          		
          		premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" <////%=nul.jeNull(modi"+clna+"."+sifra+"()).equals(nul.jeNull(nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")))?\"selected\":\"\"%////>><////%=nul.jeNull(modi"+clna+"."+vrednost+"())%////></option>;\r\n";
          		
          		//premo = premo + "p"+tu.getId()+"<////%=modi"+clna+"."+sifra+"()%////>=\"<////%=modi"+clna+"."+vrednost+"()%////>\";\r\n";

          		premo = premo + "<////%\r\n\r\n";
          		premo = premo + "}\r\n\r\n";
          		
          		}
          		
          		premo = premo + "}\r\n";
          		premo = premo + "%////>\r\n";
          		
          		
          	}
          		
          		
          	
          		
          	premo = premo + "</select>\r\n";
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          		
          	}
        	
        	
        	
        	
        	   	if (novajax) {
        	
        	premo = premo + "</div>";
        	
        	
        	        		premo = premo + "<script language='javascript'>\r\n";
        		premo = premo + "var dropdown"+tu.getId()+" = new Bloodhound({\r\n";
				premo = premo + "datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),\r\n";
				premo = premo + " queryTokenizer: Bloodhound.tokenizers.whitespace,\r\n";
			//	premo = premo + "remote: '"+(ajaxpoljea[1].substring(0, ajaxpoljea[1].indexOf(".jsp")+4))+"=%QUERY'\r\n";
				
				premo = premo + "remote: {\r\n";
                premo = premo + "url: '"+(ajaxpoljea[1].substring(0, ajaxpoljea[1].indexOf(".jsp")+4))+"?ime=%QUERY',\r\n";
                premo = premo + "replace: function () {\r\n";
                premo = premo + "var q = '"+ajaxpoljea[1]+";\r\n";

               // premo = premo + "q += document.dod.akcijaXY.value; // %QUERY

                        //alert(q);

               premo = premo + " return q;\r\n";
               premo = premo + "}\r\n";
                premo = premo + "}\r\n";
				
				premo = premo + "});\r\n";
				 
				premo = premo + "dropdown"+tu.getId()+".initialize();\r\n";
				 
				premo = premo + "$('#remote"+tu.getId()+" ."+(nul.jeNull(tu.getDdivclasscusin()).equals("")?"inputIExa":tu.getDdivclasscusin())+"').typeahead({\r\n";
				premo = premo + "minLength: "+ajaxpoljea[2]+",\r\n";
				premo = premo + "highlight:true,\r\n";
				premo = premo + "hint:false\r\n";
				premo = premo + "}, {\r\n";
				premo = premo + "name: 'nam"+tu.getId()+"',\r\n";
				premo = premo + "displayKey: 'value',\r\n";
				premo = premo + "source: dropdown"+tu.getId()+".ttAdapter()\r\n";
				  
				premo = premo + "}).on('typeahead:selected', function (obj,value) {\r\n";
				
				
				premo = premo + "if (value[\"set\"].indexOf(\" ___ \")!=-1) {\r\n";
				premo = premo + "var spl1 = value[\"set\"].split(\" ___ \");\r\n";
				premo = premo + "var idd1 = value[\"idd\"].split(\" ___ \");\r\n";
				premo = premo + "for (i=0;i<spl1.length;i++) {\r\n";
				premo = premo + "document.getElementById(spl1[i]).value=idd1[i];\r\n";
				premo = premo + "}\r\n";
				premo = premo + "}\r\n";
				premo = premo + "else {\r\n";
				premo = premo + "var spl1 = value[\"set\"];\r\n";
				premo = premo + "document.getElementById(spl1).value=value[\"idd\"];\r\n";
				premo = premo + "}\r\n";
				
				
				
				
				//premo = premo + "alert(value[\"value\"]);\r\n";
				
				premo = premo + "});\r\n";
        		premo = premo + "</script>\r\n";
        	
        	
        	}
        	
        	
        	
        	
        	
        	
        	
        	
        	
        	if (nul.jeNull(tu.getVnos_kdaj()).equals("UP") || nul.jeNull(tu.getVnos_kdaj()).equals("IN")) {
         		premo = premo + "<////%\r\n\r\n";
          		premo = premo + "}\r\n\r\n";
          		premo = premo + "%////>\r\n";
        	}
        	
        	
        	}
        	else {
        		premo = premo + "<////%=rezu%////>\r\n";
        		
        	}
	
	
	return premo;
	}
	
	catch (Exception ex) {
		System.out.println("Napaka pri gen field :" + ex.toString());
	}
	
	return "";
	
}








//// end search





































public String genField(com.popultrade.model.TemplatePP tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {
	//com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	try {
	String premo="";
	premo = premo + "<////%\r\nrezu=\"\";\r\n%////>\r\n";
        
        /// pogoji prikaza
        
        	 /// pogledam, ce ima pogoje
	 
	 if (tu.getTemplateClasses().size()>0) {
	 
	 premo = premo + createPP(tu,"templatepp");
		 
		 
	 }
	 else {
		 
		/* if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
			 premo = premo + "<%\r\n";
			 premo = premo + "rezu=nul.formatNumber(vseb."+tu.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tu.getFormat_stolpca()+"\");\r\n";
			 premo = premo + "%////>\r\n";
			 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
		 }
		 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
			 premo = premo + "<%\r\n";
			 premo = premo + "rezu=nul.getDatumFormatFromDate(vseb."+tu.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tu.getFormat_stolpca()+"\");\r\n";
			 premo = premo + "%////>\r\n";
		 }*/

	 }
        
      
       	        //		premo = premo + "<////%=rezu%////>\r\n";
       		 
        		
        	
        
	
	
	return premo;
	}
	
	catch (Exception ex) {
		System.out.println("Napaka pri gen field :" + ex.toString());
	}
	
	return "";
	
}


/*
public String getAjaxVrednostZaSpan(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,String set_value,String vrednost) {
	com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();
	
	String premos="";
	if (tu.getTemplateDD()!=null && tu.getTemplateDD().getId()!=null) {
		set_value=set_value.replaceAll("get","set");
	 	 
		premos = premos + "<%\r\nif (true) {\r\n";
							 
		premos = premos + "com.popultrade.dao."+tu.getTemplateDD().getClass_name()+"DAO doax =(com.popultrade.dao."+ tu.getTemplateDD().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tu.getTemplateDD().getClass_name().substring(0,1).toLowerCase() +tu.getTemplateDD().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

		premos = premos + "com.popultrade.model."+tu.getTemplateDD().getClass_name() +" modx = new com.popultrade.model."+tu.getTemplateDD().getClass_name() +"();\r\n";



		com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",servletContext);

		/// setam vrednosti

		com.popultrade.model.TemplateDDPogoji sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tu.getTemplateDD().getId());
		sifh.setTip("P");
		
	
		
		List lish =null;
		
		lish = daodd.getTemplateDDPogojis(sifh);
		Iterator tre = lish.iterator();
		String daj_v_parameter="";
		Hashtable metos = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tu.getTemplateDD().getClass_name());
		while (tre.hasNext()) {
com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			String rett="request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\")+\"\"";
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
			
			
			
			premos = premos + "modx."+tcc.getIme_metode()+"("+rett+");\r\n";
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
    				daj_v_parameter = daj_v_parameter+(preej?addi:"") +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"="+tcc.getVrednost_metode();
        				
    			}
			preej=true;
			}
		}

		
		
		if (metos.containsKey(set_value)) {
			if (((String)metos.get(set_value)).indexOf("Long")!=-1) {
				
				
				
				vrednost = "new Long("+vrednost+"+\"\")";
				
				
				
			}
			else if (((String)metos.get(set_value)).indexOf("int")!=-1 || ((String)metos.get(set_value)).indexOf("Integer")!=-1) {
				vrednost = "Integer.parseInt("+vrednost+"+\"\")";
				
			}
			else if (((String)metos.get(set_value)).indexOf("Double")!=-1) {
			
				vrednost = "Double.parseDouble("+vrednost+"+\"\")";
			}
			}
		
		
		
		premos = premos + "modx."+set_value+"("+vrednost+");\r\n";
		
		
		
		
		
		String order_by = "";
		if (!nul.jeNull(tu.getTemplateDD().getHead_select_dodatni_pogoji()).equals("")) {
			order_by = nul.jeNull(tu.getTemplateDD().getHead_select_dodatni_pogoji());
		}
		
		String order_by_smer = "";
		
		if (!nul.jeNull(tu.getTemplateDD().getOrder_by_smer()).equals("")) {
			order_by_smer = nul.jeNull(tu.getTemplateDD().getOrder_by_smer());
		}
		
		if (order_by.equals("")) {
		premos = premos + "List remix=doax.get"+tu.getTemplateDD().getClass_name()+"s(modx);\r\n";
		}
		else {
			premos = premos + "List remix=doax.get"+tu.getTemplateDD().getClass_name()+"s(modx,\""+order_by+"\",\""+order_by_smer+"\");\r\n";
		}



		premos = premos + "if (remix.size()>0) {\r\n";
		
		
		premos = premos + "com.popultrade.model."+tu.getTemplateDD().getClass_name() +" modxc =(com.popultrade.model."+tu.getTemplateDD().getClass_name() +")remix.get(0);\r\n";
		set_value=set_value.replaceAll("set","get");
		premos = premos + "%////><////%=nul.jeNull(modxc."+set_value+"())%////><////%\r\n";
		
		premos = premos + "}\r\n";
		premos = premos + "}\r\n";
	
		premos = premos + "%////>\r\n";
		
		
		try {
		/// shranim file za ajax
		if ((tu.getTemplateDD().getStatus()).equals("1")) {
	
		
		return premos;
		
		}
		}
		catch (Exception exx) {
			System.out.println("NAPAKA AJAX::: "+exx.toString());
		}
		
	}
	return "";
	 
	
}


*/


























public String[] getAjax(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,String ime_field) {
	com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();
	
	String premos="";
	String retx = "";
	String retx2="";
	String retx3="";
	
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
		Hashtable metos = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tmdd.getClass_name());
		while (tre.hasNext()) {
com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
			
			
			//String rett="request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\")+\"\"";
			
			String rett="";
			
			if (tcc.getVrednost_metode().indexOf("request.getPara")!=-1) {
				//rett=""+tcc.getVrednost_metode().replaceAll("\'","\"")+"+\"\"";
				rett="nul.menjajVSumnike(request.getParameter(\""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"\"),nul.jeNull(ConPool.getPrevod_admin(\"1000010\",\"Y\",\"SL\")))+\"\"";
			}
			else {
						 rett="nul.menjajVSumnike(request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\"),nul.jeNull(ConPool.getPrevod_admin(\"1000010\",\"Y\",\"SL\")))+\"\"";
			 
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
		
		premos = premos + "%////>[<////%\r\n";
		premos = premos + "int vss = 0;\r\n";
		
		
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
		
	
		try {
		/// shranim file za ajax
		if ((tmdd.getStatus()).equals("1")) {
		Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"), "latin1"));



		out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
		////zaprem writer3
		out3.close();
		String velike_crke = nul.jeNull(tu.getSamo_velike_crke());
		
		//retx= "  autocomplete=\"off\" onfocus=\"change(this,'yellow');"+"setKlici(this,1);\" onfsocus=\"change(this,'yellow');"+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"")+"','"+(nul.jeNull(tmdd.getUporabi_kontrolo_vrednosti()).equals("0")?"0":"1")+"')}\"  onclick=\"setKlici(this,2);\"  onkeyup=\""+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"")+"','"+(nul.jeNull(tmdd.getUporabi_kontrolo_vrednosti()).equals("0")?"0":"1")+"')};setKlici(this,2);\" ";
		
		retx = "<div id=\"remote"+tu.getId()+"\" >";
		retx2 = ""+tmdd.getClass_name().toLowerCase()+tmdd.getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+"";
		retx3 = (nul.jeNull(tmdd.getMin_st_znakov()+"").equals("")?"0":tmdd.getMin_st_znakov()+"");
		
		
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
	
	
	String[] retu = {retx,retx2,retx3}; 
	
	return retu;
	 
	
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
String imefile_fo="";

// stevilo vrstic
int stvrstic=0;

boolean iskanje=false;

try {

	

	
//	System.out.println(" ========dddddddddddd " +request.getParameter("id"));
	
	
// get list from daoobject
com.popultrade.dao.TemplateHeadDAO dao = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());



com.popultrade.model.TemplateHead sif = new com.popultrade.model.TemplateHead();


sif = dao.getTemplateHead(new Long(request.getParameter("id")));
imefile_fo = sif.getHead_class_name();

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


String colss = "cols";
String frum = "frameinc_";

if (targett.equals("3") || targett.equals("4") || targett.equals("5")) {
	colss ="rows";
	frum = "frameinr_";
}
String predpo = "";
if (sif.getHead_tip().equals("SE")) {
	predpo="_isci"+sif.getId();
}
else if (sif.getHead_tip().equals("UI")) {
	predpo="_edit"+sif.getId();
}
else if (sif.getHead_tip().equals("HE")) {
	predpo="_view";
}
else if (sif.getHead_tip().equals("FU")) {
	predpo="_funk"+sif.getId();
}
else if (sif.getHead_tip().equals("PR")) {
	predpo="_proc"+sif.getId();
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
	 else if (nul.jeNull(tgpp.getStolpec_metoda()).startsWith("'") || nul.jeNull(tgpp.getStolpec_metoda()).startsWith("\"")) {
		 parametri = parametri + ehn+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"="+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","").replaceAll("\"","")+"";
			
	 }
	 else {
	 parametri = parametri + ehn+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"=< %=request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\")%////>";
	 }


}


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
//// kreacija jsp za upload

////konec kreacija jsp za upload
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
//// kreacija jsp za update/insert

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
/////////////////////////////////
////////////////
////////////////
//// kreacija jsp za upload
if (sif.getHead_tip().equals("UP")) {

	
	
	
	
	
	
	
	

//StringBuffer sb = new StringBuffer();
    com.popultrade.dao.TemplateUploadDAO daoui = (com.popultrade.dao.TemplateUploadDAO)contextUtil.getBeanDao("templateUploadDAO",pageContext.getServletContext());

    com.popultrade.model.TemplateUpload tup = daoui.getTemplateUploadByHeadId(sif.getId()+"");





sb.append("<////%@ page language=\"java\" import=\"java.util.*,java.text.*,java.sql.*,java.io.*,java.util.Date\"  contentType=\"text/html; charset=utf-8\"%////>\r\n");
sb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<jsp:useBean id=\"generator\" scope=\"request\" class=\"com.popultrade.webapp.generator\" />\r\n");

sb.append("<////%\r\n");
sb.append("request.setCharacterEncoding(control.encoding);\r\n");
sb.append("response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("response.addDateHeader(\"Expires\", 0);\r\n");
sb.append("if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
sb.append("%////><jsp:forward page=\"login.jsp\"/><////%\r\n");
sb.append("} \r\n");




sb.append("String prikazi = \"\";\r\n");

sb.append("if (!nul.jeNull(request.getParameter(\"id\")).equals(\"\")) {\r\n");
//// parametri iz templatehead oz gumbi veza

   com.popultrade.dao.TemplateGumbiDAO daotg = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());



	
	com.popultrade.model.TemplateGumbi tg = daotg.getTemplateGumbi(sif.getVeza_gumb());
	
	
	if ( tg.getTemplateGumbiParametris().size()>0) {
	Iterator itt = tg.getTemplateGumbiParametris().iterator();
	
	while (itt.hasNext()) {
	com.popultrade.model.TemplateGumbiParametri tgumm = (com.popultrade.model.TemplateGumbiParametri)itt.next();
	System.out.println("---------------------------------- ::::::::::: "+nul.jeNull(tgumm.getStolpec_metoda()));
	
	
	if (nul.jeNull(tgumm.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
	sb.append("session.setAttribute(\""+nul.jeNull(tgumm.getStolpec_metoda()).substring(nul.jeNull(tgumm.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgumm.getStolpec_metoda()).lastIndexOf("\'"))+"\",nul.jeNull(request.getParameter(\""+nul.jeNull(tgumm.getStolpec_metoda()).replaceAll("\'","\"")+"\")));\r\n");
	}
	else {
		sb.append("session.setAttribute(\""+(nul.jeNull(tgumm.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgumm.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgumm.getDugacno_ime_parametra()))+"\",nul.jeNull(request.getParameter(\""+(nul.jeNull(tgumm.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgumm.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgumm.getDugacno_ime_parametra()))+"\")));\r\n");
		
	}
	
	}	



	}
	sb.append("}\r\n");

	

	sb.append("com.popultrade.dao.UploadsDAO dao = (com.popultrade.dao.UploadsDAO)contextUtil.getBeanDao(\"uploadsDAO\",pageContext.getServletContext());\r\n");

	sb.append("if (request.getParameter(\"opcijax\")!=null) {\r\n");
			sb.append("Object[] obj = dao.getUploadZaBrisat(session.getAttribute(\"id\")+\"\",request.getParameter(\"sifras\"),request.getParameter(\"sifrap\"));\r\n");



			sb.append("if (obj!=null) {\r\n");

			sb.append("String slika1 = obj[0]+\"\";\r\n");
			sb.append("String slika2 = obj[1]+\"\";\r\n");

			sb.append("try {\r\n");
			sb.append("File ff = new File(control.lokacijaupload + session.getAttribute(\"id\") + \"/\" +obj[0]+\"\");\r\n");
			sb.append("ff.delete();\r\n");
			sb.append("ff = new File(control.lokacijaupload + session.getAttribute(\"id\") + \"/\" +obj[1]+\"\");\r\n");
			sb.append("ff.delete();\r\n");

			// sele = \"update uploads setslika\"+request.getParameter(\"sifras\")+\"='',slika\"+request.getParameter(\"sifrap\")+\"='' where sifra='\"+control.okolica+\"'\";

			sb.append("dao.setUploadZaUpdate(session.getAttribute(\"id\")+\"\",request.getParameter(\"sifras\"),request.getParameter(\"sifrap\"));\r\n");

			sb.append("}\r\n");
			sb.append("catch (Exception ex) {\r\n");
			sb.append("System.out.println(ex.toString());\r\n");
			sb.append("}\r\n");

			sb.append("}\r\n");

			sb.append("}\r\n");
	
	
	
	
	sb.append("com.popultrade.model.Uploads upl =new com.popultrade.model.Uploads();\r\n");

	
	
	
	
	
	
	
	

	sb.append("upl = dao.getUpload(\"\"+session.getAttribute(\"id\"));\r\n");

	sb.append("if (upl==null) {\r\n");
	sb.append("upl =new com.popultrade.model.Uploads();\r\n");
	
	sb.append("}\r\n");

sb.append("%////>\r\n");

sb.append("<html>\r\n");

sb.append("<head>\r\n");
sb.append("<meta http-equiv=\"Content-Language\" content=\"en-us\">\r\n");
sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1252\">\r\n");

sb.append("</head>\r\n");
sb.append("<script language=\"javascript\">\r\n");


sb.append("function gum() {\r\n");
if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}
sb.append("}\r\n");

sb.append("</script>\r\n");


sb.append("<script language=javascript>\r\n");
sb.append("function op(lok) {\r\n");

sb.append("lok = \"\"+lok;\r\n");

sb.append("window.open(\"slike.htm?\"+lok,\"SLIKE\",\"toolbar=no,menubar=no,directories=no,scrollbars=no,resizable=yes,width=440,height=560,left=15,top=15\");\r\n");
sb.append("}\r\n");
sb.append("</script>\r\n");



sb.append("<body  style=\"background-repeat: repeat-x;\"  topmargin=\"0\" leftmargin=\"0\" rightmargin=\"0\" bottommargin=\"0\" marginwidth=\"0\" marginheight=\"0\" onload=\"gum()\">\r\n");

sb.append("<table   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\" width=\"100%\" id=\"table1\" height=\"100%\"  bgcolor=#C3E1FC>\r\n");
sb.append("<tr>\r\n");
sb.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
sb.append("</font>\r\n");
sb.append("<table  width=\"98%\" id=\"table2\" height=\"92%\"   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\">\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#E3F1FE\" align=\"center\">\r\n");
sb.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"98%\" cellspacing=\"1\">\r\n");
sb.append("<form ENCTYPE=\"multipart/form-data\" name=\"dod\" onsubmit=\"return mom()\" METHOD=\"POST\" ACTION=\""+imefile.toLowerCase()+"_upload"+sif.getId()+"_12"+".jsp\">\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" colspan=\"3\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<////%\r\n");

sb.append(" %////>\r\n");


int inu = Integer.parseInt(tup.getUpload_stevilo_polj());

int umo = 1;
int zaps = 2;

int sl1=1;
int sl2=2;

for (int i=1;i<=inu;i++) {

sb.append("<tr>\r\n");

sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\" width=\"100\">\r\n");
sb.append("<////%\r\n");

sb.append("if (!nul.jeNull(upl.getSlika"+umo+"()).equals(\"\")) {\r\n");

sb.append(" %////>\r\n");

sb.append("<a href=\"Javascript: op('<////%=control.lokacijaslika + session.getAttribute(\"id\") + \"/\" +upl.getSlika"+zaps+"() %////>')\">\r\n");
sb.append("<img width=\"95\" alt=\"\" border=\"0\" src=\"<////%=control.lokacijaslika + session.getAttribute(\"id\") + \"/\" +upl.getSlika"+umo+"() %////>\"/></a>\r\n");
sb.append("<br />\r\n");
sb.append("<input type=\"button\" style=\"font-family: Verdana; font-size: 9px\" value=\"<////%=nul.jeNull(ConPool.getPrevod(\""+tup.getId()+"B\"+control.getJezik()))%////>\" onclick=\"document.location='"+imefile.toLowerCase()+"_upload"+sif.getId()+"_1"+".jsp?opcijax=brisi&sifras="+sl1+"&sifrap="+sl2+"'\"/>\r\n");
sb.append("<////%\r\n");

sb.append("}\r\n");
sb.append(" %////>\r\n");
sb.append("</td>\r\n");

sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<p align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("<////%=nul.jeNull(ConPool.getPrevod(\""+tup.getId()+"P\"+control.getJezik()))%////> "+i+":</font><font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"-1\">\r\n");
sb.append("</font></td>\r\n");

sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\"><input TYPE=\"FILE\" NAME=\"file"+umo+"\"  style=\"font-family: Verdana; font-size: 10px\"></td>\r\n");
sb.append("</tr>\r\n");
sl1=sl1+2;
sl2=sl2+2;
umo = umo +2;
zaps=zaps+2;
}


/*
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 1:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file3\" <////%=(Integer.parseInt(nul.jeNull(prikazi))>=2)?\"\":\"disabled\" %////> style=\"font-family: Verdana; font-size:  10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 2:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file5\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=3)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size:  10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 3:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file7\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=4)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size:  10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 4:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file9\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=5)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size:  10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 5:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file11\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=6)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size:  10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 6:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file13\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=7)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size:  10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 7:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file15\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=8)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size: 10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 8:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file17\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=9)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size: 10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\">\r\n");
sb.append("Galerija 9:</font></td>\r\n");
sb.append("<td align=\"center\" bgcolor=\"#A8D3FB\">\r\n");
sb.append("<input TYPE=\"FILE\" NAME=\"file19\"  <////%=(Integer.parseInt(nul.jeNull(prikazi))>=10)?\"\":\"disabled\" %////>  style=\"font-family: Verdana; font-size: 10px\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
*/



sb.append("<td colspan=\"3\" bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<input TYPE=\"submit\" VALUE=\"<////%=nul.jeNull(ConPool.getPrevod(\""+tup.getId()+"C\"+control.getJezik()))%////>\"  style=\"font-family: Verdana; font-size: 10px\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<input type=\"hidden\" name=\"sifra\" value=\"<////%=request.getParameter(\"sifra\")%////>\"/>\r\n");
sb.append("<////%\r\n");


//sb.append("control.okolica = request.getParameter(\"sifra\");\r\n");
sb.append("%////>\r\n");
sb.append("<input type=\"hidden\" name=\"id2\" value=\"<////%=request.getParameter(\"id2\")%////>\"/>\r\n");
sb.append("</form></table>\r\n");
sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");

sb.append("<script language='javascript'>\r\n");

sb.append("function mom() {\r\n");
sb.append("if (document.dod.file"+umo+".value=='') {\r\n");
sb.append("alert('Error: no file selected!');\r\n");
sb.append("return false;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");

sb.append("</script>\r\n");


sb.append("</body>\r\n");

sb.append("</html>\r\n");







/// shranim

Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_upload"+sif.getId()+"_1"+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////","").replaceAll("DDDCOSMMDDD","\\\\\\\\"));
////zaprem writer3
out3.close();



sb.delete(0,sb.length());








sb.append("<////%@ page language=\"java\" import=\"java.sql.*,java.util.List,java.awt.Image,java.awt.image.*,java.awt.*,org.apache.commons.fileupload.FileItem,java.util.*,org.apache.commons.fileupload.disk.DiskFileItemFactory,java.util.Date,org.apache.commons.fileupload.servlet.*,java.io.*\"  contentType=\"text/html; charset=utf-8\"%////>\r\n");
sb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<jsp:useBean id=\"generator\" scope=\"session\" class=\"com.popultrade.webapp.generator\" />\r\n");
sb.append("<jsp:useBean id=\"ImageUtil\" scope=\"request\" class=\"com.popultrade.webapp.ImageResize\" />\r\n");
sb.append("<////%\r\n");
sb.append("request.setCharacterEncoding(control.encoding);\r\n");
sb.append("response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("response.addDateHeader(\"Expires\", 0);\r\n");
sb.append("if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
sb.append("%////><jsp:forward page=\"login.jsp\"/><////%\r\n");
sb.append("} \r\n");





sb.append("String uploaddir=control.lokacijaupload;\r\n");
sb.append("String delo  = \"\";\r\n");
sb.append("com.popultrade.dao.UploadsDAO dao = (com.popultrade.dao.UploadsDAO)contextUtil.getBeanDao(\"uploadsDAO\",pageContext.getServletContext());\r\n");

sb.append("try {\r\n");
sb.append("String napaka=\"\";\r\n");
sb.append("Hashtable htslike = new Hashtable();\r\n");
sb.append("boolean jeok = false;\r\n");
//sb.append("System.out.println(\"JE MULTIPART: \"+ServletFileUpload.isMultipartContent(request));\r\n");
sb.append("if (ServletFileUpload.isMultipartContent(request)){\r\n");
sb.append("/*if (nul.jeNull(request.getParameter(\"um\")).equals(\"Slike\")) {\r\n");
sb.append("com.fidelia.model.Users vseb =new com.fidelia.model.Users();\r\n");
sb.append("com.fidelia.dao.UsersDAO dao = (com.fidelia.dao.UsersDAO)contextUtil.getBeanDao(\"usersDAO\",pageContext.getServletContext());\r\n");
sb.append("vseb = dao.getUsers(control.idUporabnika);\r\n");
sb.append("vseb = (com.fidelia.model.Users)contextUtil.getPopulatedObject(vseb,request);\r\n");
sb.append("vseb.setId(control.idUporabnika);\r\n");
sb.append("dao.saveUsers(vseb);\r\n");
sb.append("jeok=true;\r\n");
sb.append("}*/\r\n");
sb.append("try {\r\n");
sb.append("//ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());\r\n");
sb.append("DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();\r\n");
sb.append("diskFileItemFactory.setSizeThreshold(440960); /* the unit is bytes */\r\n");


sb.append("/*\r\n");
sb.append("File repositoryPath = new File(\"/WEB-INF/slike\");\r\n");
sb.append("diskFileItemFactory.setRepository(repositoryPath);*/\r\n");


//sb.append("System.out.println(\"aasss \"+request.getContextPath());\r\n");
sb.append("ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);\r\n");
//sb.append("System.out.println(\"aasss2\");\r\n");
sb.append("servletFileUpload.setSizeMax(11581920); /* the unit is bytes */\r\n");
//sb.append("System.out.println(\"aasss3\");\r\n");

sb.append("  List fileItemsList = servletFileUpload.parseRequest(request);\r\n");
//sb.append("System.out.println(fileItemsList.size() + \"  :: sie\");\r\n");
sb.append("Iterator it = fileItemsList.iterator();\r\n");
sb.append("while (it.hasNext()){\r\n");
//sb.append("System.out.println(\"aasss3wwww\");\r\n");
sb.append("  FileItem fileItem = (FileItem)it.next();\r\n");
sb.append("  if (fileItem.isFormField()){\r\n");
sb.append("/* The file item contains a simple name-value pair of a form field */\r\n");
//sb.append("System.out.println(fileItem.getFieldName() + \" ::Field name \");\r\n");
sb.append("  }\r\n");
sb.append("  else{\r\n");
sb.append("/* The file item contains an uploaded file */\r\n");

sb.append("/// filename\r\n");
sb.append("String filename=fileItem.getName();\r\n");


sb.append("if (filename!=null && !filename.equals(\"\")) {\r\n");
sb.append("if (filename.indexOf(\"/\")!=-1) {\r\n");
sb.append("  filename =filename.substring(filename.lastIndexOf(\"/\")+1,filename.length());\r\n");
sb.append("}\r\n");
sb.append("else if (filename.indexOf(\"DDDCOSMMDDD\")!=-1) {\r\n");
sb.append("  filename =filename.substring(filename.lastIndexOf(\"DDDCOSMMDDD\")+1,filename.length());\r\n");
sb.append("}\r\n");

sb.append("String extt = \".jpg\";\r\n");

sb.append("if (filename.indexOf(\"/\")!=-1) {\r\n");
sb.append("extt = filename.substring(filename.indexOf(\"\\\\.\"),filename.length());\r\n");

sb.append("}\r\n");

sb.append("filename=generator.getKodo()+extt;\r\n");

sb.append("htslike.put(fileItem.getFieldName(),filename);\r\n");

sb.append("// kreiram dir na podlagi userja\r\n");
sb.append("//ServletContext context = session.getServletContext();\r\n");
sb.append("//String realContextPath = context.getRealPath(request.getContextPath());\r\n");



sb.append("//  realContextPath = realContextPath.substring(0,realContextPath.length()-nul.jeNull(request.getContextPath()).length());\r\n");

sb.append("//   System.out.println(request.getContextPath()+ \" realContextPath: :::\"+realContextPath);\r\n");

sb.append("/// kontrola, ce obstaja dir za userja\r\n");



sb.append("File fim = new File(control.lokacijaupload + session.getAttribute(\"id\") + \"/\");\r\n");
sb.append("if (!fim.exists()) {\r\n");
sb.append("  fim.mkdir();\r\n");
sb.append("}\r\n");

sb.append("String diruserja=control.lokacijaupload + session.getAttribute(\"id\") + \"/\";\r\n");


sb.append("fileItem.write(new File(diruserja+filename));\r\n");
 

/// resize majhno
//sb.append("ImageUtil.resize(diruserja+filename,diruserja+\"resized_\"+filename,150);\r\n");


/// resize malo
if (nul.jeNull(tup.getUpload_slika_resize()).equals("1")) {
	if (!nul.jeNull(tup.getUpload_slika_width()+"").equals("") && tup.getUpload_slika_width()>0 && (nul.jeNull(tup.getUpload_slika_height()+"").equals("") || tup.getUpload_slika_height()==0)) {
	sb.append(" ImageUtil.resize(diruserja+filename,diruserja+\"resized_\"+filename,"+tup.getUpload_slika_width()+");\r\n");
	}
	
	if (!nul.jeNull(tup.getUpload_slika_width()+"").equals("") && tup.getUpload_slika_width()>0 && !nul.jeNull(tup.getUpload_slika_height()+"").equals("") && tup.getUpload_slika_height()>0) {
		sb.append(" ImageUtil.resize(diruserja+filename,diruserja+\"resized_\"+filename,"+tup.getUpload_slika_width()+","+tup.getUpload_slika_height()+");\r\n");
		}
	
	
}



/// resize veliko
if (nul.jeNull(tup.getUpload_slika_v_resize()).equals("1")) {
	if (!nul.jeNull(tup.getUpload_slika_v_width()+"").equals("") && tup.getUpload_slika_v_width()>0 && (nul.jeNull(tup.getUpload_slika_v_height()+"").equals("") || tup.getUpload_slika_v_height()==0)) {
	sb.append(" ImageUtil.resize(diruserja+filename,diruserja+filename,"+tup.getUpload_slika_v_width()+");\r\n");
	}
	
	if (!nul.jeNull(tup.getUpload_slika_v_width()+"").equals("") && tup.getUpload_slika_v_width()>0 && !nul.jeNull(tup.getUpload_slika_v_height()+"").equals("") && tup.getUpload_slika_v_height()>0) {
		sb.append(" ImageUtil.resize(diruserja+filename,diruserja+filename,"+tup.getUpload_slika_v_width()+","+tup.getUpload_slika_v_height()+");\r\n");
		}
	
	
}

sb.append("  ServletContext context = session.getServletContext();\r\n");
sb.append("String realContextPath = context.getRealPath(request.getContextPath());\r\n");
sb.append("realContextPath = realContextPath.substring(0,realContextPath.length()-nul.jeNull(request.getContextPath()).length());\r\n");


if (nul.jeNull(tup.getUporabi_watermark()).equals("1")) {
sb.append("//// dodam watermark\r\n");

sb.append("ImageUtil.addWatermark(diruserja+filename,\"/"+tup.getLokacija_watermark()+"\");\r\n");
sb.append("ImageUtil.addWatermark(diruserja+\"resized_\"+filename,realContextPath+\"/"+tup.getLokacija_watermark()+"\");\r\n");
}


//sb.append("// ImageUtil.cropImage(diruserja+filename,50,50,50,50,\"jpg\",diruserja+\"croped_\"+filename);\r\n");


sb.append("System.out.println(\"File name: \" +fileItem.getName());\r\n");



 




sb.append("}\r\n");
sb.append("}\r\n");
sb.append("}\r\n");


sb.append("System.out.println(\"rsssssssssssssssssss\");\r\n");


sb.append("com.popultrade.model.Uploads upl = dao.getUpload(\"\"+session.getAttribute(\"id\"));\r\n");

sb.append("if (upl==null || upl.getId()==null) {\r\n");

sb.append("upl = new com.popultrade.model.Uploads();\r\n");
sb.append("System.out.println(\"AB1 \"+session.getAttribute(\"id\"));\r\n");

sb.append("//sta.setString(1,session.getAttribute(\"id\"));\r\n");

sb.append("upl.setSifra(new Long(\"\"+session.getAttribute(\"id\")));\r\n");
sb.append("System.out.println(\"AB2\");\r\n");



inu = Integer.parseInt(tup.getUpload_stevilo_polj());

umo = 1;
int umi = 1;
for (int m=1;m<=inu;m++) {

sb.append("if (htslike.containsKey(\"file"+umi+"\")) {\r\n");
sb.append("upl.setSlika"+umo+"(\"resized_\"+htslike.get(\"file"+umi+"\").toString());\r\n");
//sb.append("System.out.println(\"AB3\");\r\n");

sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("//upl.setSlika"+umo+"(\"\");\r\n");
umo++;
sb.append("}\r\n");
sb.append("if (htslike.containsKey(\"file"+umi+"\")) {\r\n");
sb.append("upl.setSlika"+umo+"(htslike.get(\"file"+umi+"\").toString());\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("upl.setSlika"+umo+"(\"\");\r\n");
sb.append("}\r\n");
umo++;
umi = umi +2;

}


sb.append("dao.saveUploads(upl);\r\n");

sb.append("}\r\n");

sb.append("else {\r\n");

sb.append("System.out.println(\"A1\");\r\n");

sb.append("Hashtable brisi = new Hashtable();\r\n");


sb.append("//sta.setString(1,session.getAttribute(\"id\"));\r\n");

sb.append("//upl.setSifra(session.getAttribute(\"id\"));\r\n");

inu = Integer.parseInt(tup.getUpload_stevilo_polj());

umo = 1;
umi = 1;
for (int mi=1;mi<=inu;mi++) {
	

sb.append("if (htslike.containsKey(\"file"+umo+"\")) {\r\n");

sb.append("if (!nul.jeNull(upl.getSlika"+umi+"()).equals(\"\")) {\r\n");
sb.append("brisi.put(\""+umi+"\",upl.getSlika"+umi+"());\r\n");

sb.append("}\r\n");

sb.append("upl.setSlika"+umi+"(\"resized_\"+htslike.get(\"file"+umo+"\").toString());\r\n");
sb.append("}\r\n");
umi++;
sb.append("if (htslike.containsKey(\"file"+umo+"\")) {\r\n");
sb.append("if (!nul.jeNull(upl.getSlika"+umi+"()).equals(\"\")) {\r\n");
sb.append("brisi.put(\""+umi+"\",upl.getSlika"+umi+"());\r\n");
sb.append("}\r\n");
sb.append("upl.setSlika"+umi+"(htslike.get(\"file"+umo+"\").toString());\r\n");
sb.append("}\r\n");
umi++;
umo = umo +2;
}




//sb.append("System.out.println(\"A4\");\r\n");
//sb.append("upl.setSlika21(\"\");\r\n");
//sb.append("upl.setSlika22(\"\");\r\n");


//sb.append("System.out.println(\"A5\");\r\n");

sb.append("dao.saveUploads(upl);\r\n");
//sb.append("System.out.println(\"A6\");\r\n");

sb.append("if (brisi.size()>0) {\r\n");
sb.append("Enumeration en =brisi.keys();\r\n");

sb.append("while (en.hasMoreElements()) {\r\n");

sb.append("String nex = (String)en.nextElement();\r\n");


sb.append("try {\r\n");


sb.append("  File ff = new File(control.lokacijaupload + session.getAttribute(\"id\") + \"/\" +brisi.get(nex));\r\n");
sb.append("  ff.delete();\r\n");
sb.append("  ff = new File(control.lokacijaupload + session.getAttribute(\"id\") + \"/\" +brisi.get(nex));\r\n");
sb.append("  ff.delete();\r\n");
  
  
sb.append("System.out.println(\"brisem stari file: \" + brisi.get(nex));\r\n");
sb.append("}\r\n");
sb.append("catch (Exception exx) {\r\n");
sb.append("System.out.println(\"Napaka pri brisanju stare sike: \"+exx.toString());\r\n");
sb.append("}\r\n");

sb.append("}\r\n");
sb.append("}\r\n");


sb.append("}\r\n");

sb.append("}\r\n");
sb.append("catch (Exception emo) {\r\n");
sb.append("System.out.println(\"Exception upload: \"+emo.toString());\r\n");
sb.append("}\r\n");


sb.append("}\r\n");



sb.append("%////>\r\n");
sb.append("<script language=\"javascript\">\r\n");

sb.append("function populatePageI() {\r\n");
sb.append("document.location = \""+imefile.toLowerCase()+"_upload"+sif.getId()+"_1"+".jsp\";\r\n");
sb.append("return false;\r\n");
sb.append("}\r\n");
sb.append("</script>\r\n");
sb.append("<body onload=\"populatePageI()\">\r\n");

sb.append("</body>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("catch (Exception ex) {\r\n");
sb.append("System.out.println(ex.toString() + \" napaka upload slike\");\r\n");

sb.append("}\r\n");

sb.append(" %////>\r\n");







/// shranim

out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_upload"+sif.getId()+"_12"+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////","").replaceAll("DDDCOSMMDDD","\\\\\\\\"));
////zaprem writer3
out3.close();



















}
////konec kreacija jsp za upload
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
//// kreacija jsp za search

////konec kreacije jsp za search
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
StringBuffer sbfo = new StringBuffer();
if (sif.getHead_tip().equals("PD")) {



    com.popultrade.dao.TemplateFunkcijaStartDAO daoui = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",pageContext.getServletContext());

    
    
    //// dobim parametre za format strani


sb.append("<////%@ page contentType=\"text/xml; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />");
sb.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />");
sb.append("<////jsp:useBean id=\"convertPDF\" scope=\"request\" class=\"com.popultrade.webapp.Convert_PDF\" />");

sb.append("<////%!\r\n");
sb.append("com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();\r\n");
sb.append("//KODA---REPLACE\r\n");
sb.append("%////>\r\n");

sb.append("<////%");
sb.append("////request.setCharacterEncoding(control.encoding);");
sb.append("////response.setContentType(\"text/html; charset=\"+control.encoding);");
sb.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;");
sb.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;");
sb.append("////response.addDateHeader(\"Expires\", 0);");
sb.append("////if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {");
sb.append("%////><jsp////:forward page=\"m_loginu.html\"/><////%");
sb.append("////}");
sb.append("%////>");

sb.append("<////%\r\n");
sb.append("boolean flex=false;\r\n");

sb.append("String r=\"\";\r\n");
sb.append("String rezu=\"\";\r\n");


sb.append("com.popultrade.webapp.conPool cx=ConPool;\r\n");
sb.append("com.popultrade.webapp.control cy=control;\r\n");
sb.append("String sw=cy.getJezik();\r\n");


sb.append("if (!control.izpisujePDF) {\r\n");
sb.append("control.izpisujePDF=true;\r\n");


sb.append("////try {\r\n");

sb.append("String jz=control.getJezik();\r\n");



sb.append( "cy.a(\"<?xml version=\\\"1.0\\\" encoding=\\\"utf-8\\\"?><dataa><!-- podatki za naslov -->\");\r\n");



sb.append("if (cy.getPdf_head()!=null && !cy.getPdf_head().equals(\"\")) {\r\n");

sb.append("cy.a(\"<uptekst>\");\r\n");

// Vector ve = spp.split(rs2.getString(1),"\n");
sb.append( "String[] amo = nul.jeNull(cy.getPdf_head()).split(\"\\n\");\r\n");
sb.append( "for (int y =0;y<amo.length;y++) {\r\n");
// System.out.println(amo[y].toString() + " ---------------------------------" + y);
sb.append( "cy.a(\"<opis>\"+nul.replaceXMLchar(amo[y])+\"</opis>\");\r\n");

sb.append( "}\r\n");

sb.append( "cy.a(\"</uptekst>\");\r\n");
    
sb.append("}\r\n");
		

com.popultrade.dao.TemplatePdfParametriDAO dap = (com.popultrade.dao.TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO",pageContext.getServletContext());
com.popultrade.model.TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(sif.getId());



if (tp!=null) {
sb.append( "cy.a(\"<strann><opis>\"+nul.jeNull(cx.getPrevod(\""+sif.getId()+"S\"+sw))+\" </opis><verzija>"+nul.jeNull(tp.getF_verzija())+"</verzija></strann>\");\r\n");


sb.append( "cy.a(\"<datumiz><opis>\"+nul.jeNull(cx.getPrevod(\""+sif.getId()+"D\"+sw))+\" &#160; </opis><vrednost>\"+nul.viaUraizDatuma(nul.obrniDat(nul.getDatumDanesMin()))+\"</vrednost></datumiz>\");\r\n");
sb.append( "cy.a(\"<datumura><opis> &#160;\"+nul.jeNull(cx.getPrevod(\""+sif.getId()+"O\"+sw))+\"&#160; </opis><vrednost>\"+nul.uraizDatuma(nul.getDatumDanesMin())+\" &#160;&#160;&#160;   </vrednost></datumura>\");\r\n");
}
 

//sb.append("<////%\r\n");


com.popultrade.model.TemplateFunkcijaStart tui = new com.popultrade.model.TemplateFunkcijaStart();

List tempui = daoui.getTemplateFunkcijaStartByVezaId(idpr);


/// dobim metode return type
Hashtable meto = templateUtil.getClassMetodeImenaHTGet(imefile);
///// dobim inserte, za checkbox, ce ne ne dela avtomaticno in datume

String dodaj_ins="";
String dodaj_upd="";

String dodaj_datum="";

StringBuffer rex2 = new StringBuffer();
StringBuffer rex3 = new StringBuffer();

 /// funkcija start
 
 Iterator itmo = tempui.iterator();
 int zaporm = 0;
while (itmo.hasNext()) {
	
	
tui = 	(com.popultrade.model.TemplateFunkcijaStart)itmo.next();



				
			//	sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),tui.getId()+""));
			//	sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+"r"+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");

			
	///// kontrola, ce ima izpis logiko za list ali head
//	boolean vrti = true;
//	while (vrti) {
		
		System.out.println("saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		
		String[] rex = templateUtil.generirajFunkcijo_PDF(contextUtil,pageContext.getServletContext(),tui.getId()+"",control,zaporm);
		zaporm++;
		if (rex!=null) {
		sb.append(rex[0]);
		//String idfunkcije = tui.getId()+"";
		
		System.out.println("saaaaaaaaaaaaaaas22222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		
		
		rex2.append(rex[2]);
		rex3.append(rex[3]);
		
		
		//// gre za list ali view, ce gre
		
		if (tui.getTemplateviews()!=null && tui.getTemplateviews().size()>0) {
			

			
			
		}
		else if (tui.getTemplatelists()!=null && tui.getTemplatelists().size()>0) { ////// izpis tabele stolpcev
			

		}
		
		
		
		}
	//	else {
		//	break;
		//}
		
		
		
		//break;
		
//	}
	
	
	
	
			
			
			
			
			
			
			
			
			
			
			
			
			
			
}





sbfo.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n");
sbfo.append("<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" xmlns:fo=\"http://www.w3.org/1999/XSL/Format\">\r\n");
sbfo.append("<xsl:template match=\"/\">\r\n");
sbfo.append("<fo:root xmlns:fo=\"http://www.w3.org/1999/XSL/Format\">\r\n");
sbfo.append("<fo:layout-master-set>\r\n");
sbfo.append("<fo:simple-page-master master-name=\"only\" page-height=\"29.7cm\" page-width=\"21cm\" margin-top=\"5mm\" margin-bottom=\"1cm\" margin-left=\"1cm\" margin-right=\"1cm\">\r\n");
sbfo.append("<fo:region-body margin-top=\"2.5cm\" margin-bottom=\"2.5cm\"/>\r\n");
sbfo.append("<fo:region-before extent=\"3cm\"/>\r\n");
sbfo.append("<fo:region-after extent=\"1.9cm\"/>\r\n");
sbfo.append("</fo:simple-page-master>\r\n");
sbfo.append("</fo:layout-master-set>\r\n");
sbfo.append("<fo:page-sequence master-reference=\"only\">\r\n");
sbfo.append("<fo:static-content flow-name=\"xsl-region-before\">\r\n");
sbfo.append("<!---->\r\n");
sbfo.append("<!--   GLAVA  -->\r\n");
sbfo.append("<fo:table border-width=\"0pt\" border-style=\"solid\" border-color=\"black\" padding=\"1pt\" border-separation=\"0pt\" >\r\n");
sbfo.append("<fo:table-column column-width=\"120mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"72mm\"/>\r\n");

sbfo.append("<fo:table-body>\r\n");

        	
        	sbfo.append("<fo:table-row><fo:table-cell number-columns-spanned=\"2\"><fo:block>&#160;</fo:block></fo:table-cell></fo:table-row>\r\n");

sbfo.append("<xsl:apply-templates select=\"//uptekst\"/>\r\n");

sbfo.append("</fo:table-body>\r\n");

sbfo.append("</fo:table>\r\n");




sbfo.append("<!-- END  GLAVA -->\r\n");
sbfo.append("</fo:static-content>\r\n");
sbfo.append("<fo:static-content flow-name=\"xsl-region-after\">\r\n");


sbfo.append("<fo:table border-width=\"0pt\" border-style=\"solid\" border-color=\"black\" padding=\"1pt\" border-separation=\"0pt\">\r\n");
sbfo.append("<fo:table-column column-width=\"77mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"40mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"77mm\"/>\r\n");
sbfo.append("<fo:table-body>\r\n");
sbfo.append("<fo:table-row>\r\n");
sbfo.append("<fo:table-cell border-width=\"1pt\" border-style=\"solid\" border-color=\"white\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"7pt\" line-height=\"7pt\" font-family=\"verdana\">\r\n");
sbfo.append("<xsl:value-of select=\"dataa/strann/opis\"/>\r\n");
sbfo.append("<fo:page-number/>\r\n");
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("<fo:table-cell border-width=\"1pt\" border-style=\"solid\" border-color=\"white\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"7pt\" line-height=\"7pt\" font-family=\"verdana\">\r\n");
sbfo.append("<xsl:value-of select=\"dataa/strann/verzija\"/>\r\n"); 
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("<fo:table-cell border-width=\"1pt\" border-style=\"solid\" border-color=\"white\" text-align=\"right\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"7pt\" line-height=\"7pt\" font-family=\"verdana\">\r\n");
sbfo.append("<xsl:value-of select=\"dataa/datumiz/opis\"/>\r\n");
sbfo.append("<xsl:value-of select=\"dataa/datumiz/vrednost\"/>\r\n");
sbfo.append("<xsl:value-of select=\"dataa/datumura/opis\"/>\r\n");
sbfo.append("<xsl:value-of select=\"dataa/datumura/vrednost\"/>\r\n");
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("</fo:table-row>\r\n");
sbfo.append("</fo:table-body>\r\n");
sbfo.append("</fo:table>\r\n");


sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  line-height=\"7pt\" text-align=\"center\">\r\n");
sbfo.append("<fo:leader leader-pattern=\"rule\" leader-length=\"192mm\" rule-thickness=\"0.5pt\"/>\r\n");
sbfo.append("</fo:block>\r\n");


sbfo.append("<fo:table border-width=\"0pt\" border-style=\"solid\" border-color=\"black\" padding=\"1pt\" border-separation=\"0pt\" >\r\n");

sbfo.append("<fo:table-column column-width=\"77mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"40mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"74mm\"/>\r\n");
sbfo.append("<fo:table-body>\r\n");
sbfo.append("<fo:table-row>\r\n");
sbfo.append("<fo:table-cell border-width=\"1pt\" border-style=\"solid\" border-color=\"white\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"7pt\" line-height=\"7pt\" font-family=\"verdana\">www.panteongroup.com</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("<fo:table-cell border-width=\"1pt\" border-style=\"solid\" border-color=\"white\">\r\n");
if (tp!=null && !nul.jeNull(tp.getF_vrednost_pod_crto()).equals("")) {
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"7pt\" line-height=\"7pt\" font-family=\"verdana\">"+nul.jeNull(tp.getF_vrednost_pod_crto())+"</fo:block>\r\n");
}
else {
	sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"7pt\" line-height=\"7pt\" font-family=\"verdana\">� Panteon Group d.o.o.</fo:block>\r\n");	
}

sbfo.append("</fo:table-cell>\r\n");



sbfo.append("<fo:table-cell border-width=\"1pt\" border-style=\"solid\" border-color=\"white\"  text-align=\"right\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"7pt\" line-height=\"7pt\" font-family=\"verdana\">ap@panteongroup.com\r\n");

sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("</fo:table-row>\r\n");
sbfo.append("</fo:table-body>\r\n");

sbfo.append("</fo:table>\r\n");





sbfo.append("</fo:static-content>\r\n");
sbfo.append("<fo:flow flow-name=\"xsl-region-body\">\r\n");

		
		
		
		
		
		
	///// dodam klicanje template	
sbfo.append(rex2);		
		
		
		
sbfo.append("</fo:flow>\r\n");



sbfo.append("</fo:page-sequence>\r\n");
sbfo.append("</fo:root>\r\n");
sbfo.append("</xsl:template>\r\n");


sbfo.append(rex3);		





sbfo.append("<xsl:template match=\"uptekst\">\r\n");
sbfo.append("<xsl:param name=\"aroa\" select=\"//uptekst/opis\"/>\r\n");
sbfo.append("<xsl:for-each select=\"$aroa\">\r\n");
sbfo.append("<fo:table-row>\r\n");

sbfo.append("<fo:table-cell>\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"10pt\" font-family=\"verdana\" line-height=\"9pt\" space-after.optimum=\"1pt\" text-align=\"left\" >\r\n");
sbfo.append("<xsl:value-of select=\".\"/>\r\n");
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
	sbfo.append("<fo:table-cell>\r\n");
		sbfo.append("<fo:block >\r\n");
		sbfo.append("</fo:block>\r\n");
	sbfo.append("</fo:table-cell>\r\n");
sbfo.append("</fo:table-row>\r\n");
sbfo.append("</xsl:for-each>\r\n");


sbfo.append("</xsl:template>\r\n");

sbfo.append("<!--FOOTER-->\r\n");

sbfo.append("<xsl:template match=\"footer\">\r\n");



sbfo.append("<fo:table    padding=\"10pt\"  >\r\n");
sbfo.append("<fo:table-column column-width=\"20mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"15mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"25mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"8mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"25mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"43mm\"/>\r\n");
sbfo.append("<fo:table-column column-width=\"52mm\"/>\r\n");


sbfo.append("<fo:table-body>\r\n");







sbfo.append("<fo:table-row>\r\n");



sbfo.append("<fo:table-cell number-columns-spanned=\"7\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"5pt\" font-family=\"verdana\" line-height=\"6pt\" space-after.optimum=\"1pt\" text-align=\"justify\" >\r\n");
sbfo.append("<xsl:value-of select=\"g440\"/>\r\n");
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("</fo:table-row>\r\n");
sbfo.append("<fo:table-row>\r\n");
sbfo.append("<fo:table-cell number-columns-spanned=\"7\" white-space-collapse=\"false\" linefeed-treatment=\"preserve\" white-space-treatment=\"preserve\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"5pt\" font-family=\"verdana\" line-height=\"6pt\" space-after.optimum=\"1pt\" text-align=\"left\">\r\n");
sbfo.append("<xsl:value-of select=\"p441\"/>\r\n");
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("</fo:table-row>\r\n");

sbfo.append("<fo:table-row>\r\n");
sbfo.append("<fo:table-cell number-columns-spanned=\"7\">\r\n");
sbfo.append("<fo:block   letter-spacing=\"0.4pt\" font-size=\"5pt\" font-family=\"verdana\" line-height=\"6pt\" space-after.optimum=\"1pt\" text-align=\"left\" >\r\n");
sbfo.append("<xsl:value-of select=\"g442\"/>\r\n");
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("</fo:table-row>\r\n");
sbfo.append("<fo:table-row>\r\n");
sbfo.append("<fo:table-cell number-columns-spanned=\"7\" white-space-collapse=\"false\" linefeed-treatment=\"preserve\" white-space-treatment=\"preserve\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"5pt\" font-family=\"verdana\" line-height=\"6pt\" space-after.optimum=\"1pt\" text-align=\"left\">\r\n");
sbfo.append("<xsl:value-of select=\"p443\"/>\r\n");
sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");
sbfo.append("</fo:table-row>\r\n");
sbfo.append("<fo:table-row>\r\n");

sbfo.append("<fo:table-cell number-columns-spanned=\"5\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"5pt\" font-family=\"verdana\" line-height=\"6pt\" space-after.optimum=\"1pt\" text-align=\"justify\" font-weight=\"bold\">\r\n");
sbfo.append("<xsl:value-of select=\"ime\"/>&#160;&#160;");

sbfo.append("</fo:block>\r\n");

sbfo.append("</fo:table-cell>\r\n");


sbfo.append("<fo:table-cell number-columns-spanned=\"5\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"5pt\" font-family=\"verdana\" line-height=\"6pt\" space-after.optimum=\"1pt\" text-align=\"justify\">\r\n");

sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");

sbfo.append("<fo:table-cell number-rows-spanned=\"3\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  font-size=\"5pt\" font-family=\"verdana\" line-height=\"6pt\" space-after.optimum=\"1pt\" text-align=\"right\" font-weight=\"bold\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  text-align=\"center\" >\r\n");
sbfo.append("<!--<fo:external-graphic  align=\"center\" src=\"D:/jakarta-tomcat-4.1.29/webapps/ics/fofiles/ebc.jpg\"/>;-->\r\n");
sbfo.append("</fo:block>\r\n");

sbfo.append("</fo:block>\r\n");
sbfo.append("</fo:table-cell>\r\n");

sbfo.append("</fo:table-row>\r\n");
sbfo.append("</fo:table-body>\r\n");
sbfo.append("</fo:table>\r\n");

sbfo.append("</xsl:template>\r\n");



sbfo.append("<xsl:template match=\"a4/bre\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  text-align=\"left\" ><xsl:value-of select=\".\"/></fo:block>\r\n");
sbfo.append("</xsl:template>\r\n");



sbfo.append("<xsl:template match=\"a2/bre\">\r\n");
sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  text-align=\"left\" ><xsl:value-of select=\".\"/></fo:block>\r\n");
sbfo.append("</xsl:template>\r\n");






sbfo.append("</xsl:stylesheet>\r\n");


		















sb.append("%////>\r\n");


sb.append("<////%\r\n");
sb.append( "cy.a(\"</dataa><!-- podatki konec  -->\");\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");



sb.append("if (cy.sb.toString().indexOf(\"<par>\")!=-1 || cy.sb.toString().indexOf(\"<col1>\")!=-1) {\r\n");
sb.append("flex=true;\r\n");
sb.append("Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(control.getlokacija_pdf_file()+control.getUser().toLowerCase()+\""+imefile_fo.toLowerCase()+".xml\"), \"UTF-8\"));\r\n");



sb.append("out3.write(cy.sb.toString().replaceAll(\"///\",\"\"));\r\n");
	////zaprem writer3
sb.append("out3.close();\r\n");
	
	  
sb.append("convertPDF.getPDF(contextUtil,pageContext.getServletContext(),control,\""+imefile_fo.toLowerCase()+"_fo"+sif.getId()+"\"+(nul.jeNull(request.getParameter(\"font\")).equals(\"\")?\"\":\"tahoma\")+\"\",control.getUser().toLowerCase()+\""+imefile_fo.toLowerCase()+".xml\",\""+imefile.toLowerCase()+"\");\r\n");
	sb.append("cy.clearStringBuffer();\r\n");
sb.append("}\r\n"); 

sb.append("////}\r\n");
sb.append("////catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");
sb.append("////System.out.println(ex.toString());\r\n");
//sb.append("////log.error(ex.toString());\r\n");
sb.append("////}\r\n");


sb.append("if (!flex) {\r\n");

sb.append("%////>\r\n");
sb.append("<html>\r\n");
sb.append("<body><center>\r\n");
sb.append("< %=ConPool.getPrevod(\""+sif.getId()+"M\"+control.getJezik()).replaceAll(\"_\",\" \") %////>");
sb.append("</body>\r\n");
sb.append("</html>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n"); 

sb.append("else {\r\n"); 
sb.append("%////>\r\n");

sb.append("<html>\r\n");
sb.append("<script language=\"javascript\">\r\n");
sb.append("document.location = \"pdfgen/"+imefile.toLowerCase() + "_<////%=control.getUser().toLowerCase()%////>.pdf?sid=\"+Math.random();\r\n");
sb.append("</script>\r\n");
sb.append("</html>\r\n");


///////////////




sb.append("<////%\r\n");
sb.append("control.izpisujePDF=false;\r\n");
sb.append("}\r\n"); 


sb.append("}\r\nelse {\r\n");
sb.append("%////>\r\n");
sb.append("<html><head><title>spreminjaj</title></head>\r\n");
 
sb.append("<style type=text/css> \r\n");
sb.append("@import \"barve.css\";\r\n");
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<body   style=\"margin: 0\"  >\r\n");
sb.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"valuecell\">\r\n");
sb.append("<p align=\"center\">\r\n");

sb.append("<////%=nul.jeNull(ConPool.getPrevod_admin(\"1100000\",\"Y\",control.getJezik()+\"\"))%////>\r\n");

sb.append("</p>\r\n");

sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("</body>\r\n");

sb.append("<////%\r\n");
sb.append("}\r\n");




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
pp.append("////if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
pp.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
pp.append("////}\r\n");
pp.append("%////>\r\n");

pp.append("<////%\r\n");
pp.append("////try {\r\n");
pp.append("String rezu=\"\";\r\n");
pp.append("String r=\"\";\r\n");






pp.append("Hashtable ht =new Hashtable();\r\n");
//sb.append("//ht.put(\"id\",\"id\");\r\n");
pp.append("Hashtable htn =new Hashtable();\r\n");
com.popultrade.dao.TemplatePPDAO daopp = (com.popultrade.dao.TemplatePPDAO)contextUtil.getBeanDao("templatePPDAO",pageContext.getServletContext());

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII151");

com.popultrade.model.TemplatePP tpp = new com.popultrade.model.TemplatePP();

tpp.setTemplatehead_id(sif.getId());


List liko = daopp.getTemplatePPs(tpp);
boolean jekontrola=false;
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
						jekontrola=true;
					}
					else {
						pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
						jestr = true;	
						jekontrola=true;
					}
					
					
				}
				else {
					pp.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):tu.getStolpec_metoda().replaceAll("get","").toLowerCase())+"\");\r\n");	
					jestr = true;
					jekontrola=true;
				}
				
				
			}
			
			
		}
		}


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII152");


if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_java_rocno()!=null) {
	pp.append(sif.getTemplateUiDodatno().getDodatno_java_rocno().replaceAll("\n","\r\n")+"\r\n");
}
if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_java_rocno2()!=null) {
	pp.append(sif.getTemplateUiDodatno().getDodatno_java_rocno2().replaceAll("\n","\r\n")+"\r\n");
}

pp.append("%////>\r\n");

pp.append("<html><head><title>spreminjaj</title></head>\r\n");

pp.append("<style type=text/css>\r\n");
pp.append("@import \"barve.css\";\r\n");
pp.append("@import \"tooltipcss.css\";\r\n");
pp.append("</style>\r\n");
pp.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
pp.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"tooltip.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");

if (jestr || jenum) {
	pp.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
	}
	if (jenum) {
	pp.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
	}
	pp.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
	pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");

pp.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
pp.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
pp.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
pp.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
pp.append("<body   style=\"margin: 0\"   onload=\"mom()\">\r\n");

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII153");

pp.append("<table  width=\"100%\" id=\"table1\" height=\"100%\"   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\" bgcolor=#C3E1FC	>\r\n");
pp.append("<tr>\r\n");
pp.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("<table  width=\"98%\" id=\"table2\" height=\"92%\"   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#E3F1FE\" align=\"center\">\r\n");
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_pdf"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\" "+(nul.jeNull(sif.getTarget_funkcija()).equals("")?"":"target='"+sif.getTarget_funkcija()+"'")+">\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#C3E1FC\" colspan=\"2\">\r\n");






pp.append("&nbsp;</td>\r\n");
pp.append("</tr>\r\n"); 



System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII154");
StringBuffer sbuu = new StringBuffer();
boolean jenekaj = false;
if (liko.size()>0) {
jenekaj = true;

Iterator ipp = liko.iterator();

while (ipp.hasNext()) {
com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)ipp.next();




 if (nul.jeNull(tu.getTip_inserta()).equals("hidden")) {
	


	 pp.append("<input type=\"hidden\" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   value=\"<////%="+nul.jeNull(tu.getStolpec_metoda()).replaceAll("\'","\"")+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n");
	}

 else {

pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#C3E1FC\" align=\"right\">\r\n");


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII155");


pp.append("<p align=\"center\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td align=\"left\" bgcolor=\"#A8D3FB\">\r\n");




//// r

pp.append(genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));






String max = nul.jeNull(tu.getStolpec_max_stevilo_znakov());
String dol = nul.jeNull(tu.getStolpec_sirina());
String tabi = nul.jeNull(tu.getTab_index());









if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {

/// kontrola in generacija AJAX


	/// kontrola in generacija AJAX
	   	String ime_field="";
        
        		
        		ime_field = nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tu.getRazlicno_ime_inputa()).toLowerCase();

String ajaxpolje = getAjaxPP(tu,contextUtil,pageContext.getServletContext(),ime_field);


Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(sif.getHead_class_name());
if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
	pp.append("<input type=\"text\"      "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"     class=\"inputIEx\"  onfocus=\"ajax_options_hide();change(this,'yellow');\" onblur=\"change(this,'white');\"  > <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"\" ><img src='call.gif' border='0'></a> \r\n");
	}
	else {
//pp.append("<input type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=r%////>\"   "+(!ajaxpolje.equals("")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+">\r\n");
pp.append("<input type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=r%////>\"  "+(!ajaxpolje.equals("")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+">\r\n");

	
	}
}
else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
/// nujno dodati v insert pogoje

pp.append("<input type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"    value=\"1\"  class=\"inputIEx\"  onfocus=\"ajax_options_hide();change(this,'yellow');\" onblur=\"change(this,'white');\" >\r\n");
}
else if (nul.jeNull(tu.getTip_inserta()).equals("view")) {
pp.append("<%////=rezu%////> \r\n");
}
else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
/// nujno dodati v insert pogoje
String cols = nul.jeNull(tu.getCols());
String rows = nul.jeNull(tu.getRows());

pp.append("<textarea "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  class=\"inputIEta\"  onfocus=\"ajax_options_hide();change(this,'yellow');\" onblur=\"change(this,'white');\" ><////%=r%////></textarea>\r\n");
}
else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
	
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII156");
	pp.append("<select "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  class=\"inputIEx\"  onfocus=\"ajax_options_hide();change(this,'yellow');\" onblur=\"change(this,'white');\"  >\r\n");
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
		dodaten =  dodaten+ " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()+\"\").equals(\"\")";
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
	
	
	pp.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n");
	
	
	}
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII159");
	
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
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII160");
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


}



pp.append("<tr>\r\n");
pp.append("<td colspan=\"2\" bgcolor=\"#C3E1FC\" align=\"center\">\r\n");

if (sbuu!=null && !sbuu.toString().equals("")) {
pp.append(sbuu.toString());
}



pp.append("<input TYPE=\"submit\" id=\"gumbb\" name=\"gumbb\" VALUE=\"< %=ConPool.getPrevod(\""+sif.getId()+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  style=\"font-family: Verdana; font-size: 8pt\">&nbsp;</td>\r\n");
pp.append("</tr>\r\n");

/// dodam parametre iz gumba
////dam parametre, ki posljem preko requesta

System.out.println("----------------------------- 1");
if (tgumb.getTemplateGumbiParametris()!=null && tgumb.getTemplateGumbiParametris().size()>0) {
 
 
 Iterator iko = tgumb.getTemplateGumbiParametris().iterator();
 
 System.out.println("----------------------------- 11");
 while (iko.hasNext()) {
	 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)iko.next();
	 
	 System.out.println("----------------------------- 112");
	 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("getParameter")!=-1) {
		 pp.append("<input type=hidden name=\""+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\"", "'").indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\"", "'").lastIndexOf("\'"))+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","\"")+")%////>\">\r\n");
	 }
	 
	 else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
	 pp.append("<input type=hidden name=\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\"))%////>\">\r\n");
	 }
	 System.out.println("----------------------------- 113");
 }
 
 
 
}
System.out.println("----------------------------- 12");


pp.append("</form></table>\r\n");
pp.append("<font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");
pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");






System.out.println("----------------------------- 13");




pp.append("</body>\r\n");

pp.append("<script language=\"javascript\">\r\n");
pp.append("\r\nfunction custom() {\r\n");

if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_javascript()!=null) {
	pp.append(sif.getTemplateUiDodatno().getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
}

pp.append("return true;\r\n");
pp.append("}\r\n");

if (!jekontrola) {
pp.append("\r\nfunction check() {\r\n");
pp.append("}\r\n");
}

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

Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_pdf"+sif.getId()+"_p"+".jsp"), "latin1"));



out3.write(pp.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();
}






//// pdf razdelim na vec delov

if (nul.jeNull(sif.getPdf_dolg()).equals("1")) { /// pogoj za uporabo dolgega pdfja

Writer  out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_tmp.jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();


sb.delete(0, sb.length());

BufferedReader syotto = new BufferedReader(new InputStreamReader(new FileInputStream(deploy_kam+imefile.toLowerCase()+"_tmp.jsp")));


String line = null;


boolean startRezi=false;

int zapfun = 0;
StringBuffer sbre = new StringBuffer();
StringBuffer sbx = new StringBuffer();


int odklep=0;
int zaklep=0;

while ((line = syotto.readLine()) !=null) {


if (line.indexOf("//========================================================")!=-1 && !startRezi) {
zapfun++;
startRezi = true;
sbx.append("generiraj"+zapfun+"(cx,cy, request,contextUtil,pageContext.getServletContext());\r\n");


sbre.append("public void generiraj"+zapfun+"(com.popultrade.webapp.conPool cx,com.popultrade.webapp.control cy,HttpServletRequest request,com.popultrade.webapp.ContextUtil contextUtil,ServletContext pageContext) {\r\n");
sbre.append("String r2=\"\";\r\n");
sbre.append("String r=\"\";\r\n");
sbre.append("String rezu=\"\";\r\n");

sbre.append("String sw=cy.getJezik();\r\n");
sbre.append("String jz=cy.getJezik();\r\n");


}
//else if (line.indexOf("============================6============================")!=-1 && startRezi) {
//startRezi=false;
//sbre.append("}\r\n");
//}

else {
if (startRezi) {
if (!line.equals("") && line.indexOf("//========================================================")==-1 && line.indexOf("//============================6============================")==-1) {
sbre.append(line.replaceAll("<%", "").replaceAll("%\\>", "").replaceAll("control\\.", "cy\\.").replaceAll("pageContext.getServletContext\\(\\)", "pageContext")+"\r\n");
if (line.indexOf("}")!=-1) {
zaklep++;

}
if (line.indexOf("{")!=-1) {
odklep++;
}

if (odklep-zaklep==0) {
startRezi=false;
sbre.append("}\r\n");
}
}


}
else {
if (!line.equals("") && line.indexOf("//========================================================")==-1 && line.indexOf("//============================6============================")==-1) {

sbx.append(line+"\r\n");

}
}
}


}





sb.append(sbx.toString().replaceFirst("//KODA---REPLACE", sbre.toString()));



sbx.delete(0, sbx.length());
sbre.delete(0,sbre.length());


/// brisem file tmp

try {
File fik = new File(deploy_kam+imefile.toLowerCase()+"_tmp.jsp");
fik.delete();

}
catch (Exception exx) {

}


}
else {


}



imefile = imefile+"_pdf"+sif.getId();
imefile_fo = imefile_fo+"_fo"+sif.getId();

}





////kreacija jsp za upload datoteke za parsat
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
//// kreacija jsp za upload datoteke za parsat konec

if (sif.getHead_tip().equals("UR")) {
	
	
	
	
	
	
	/////// prvi del upload
	
	
	
sb.append("<////%@ page contentType=\"text/html;charset=utf8\" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
sb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<////%\r\n");

sb.append("request.setCharacterEncoding(\"windows-1250\");\r\n");

if (true) {
com.popultrade.dao.TemplatePPDAO daopp = (com.popultrade.dao.TemplatePPDAO)contextUtil.getBeanDao("templatePPDAO",pageContext.getServletContext());

com.popultrade.model.TemplatePP tpp = new com.popultrade.model.TemplatePP();

tpp.setTemplatehead_id(sif.getId());


List liko = daopp.getTemplatePPs(tpp);
if (liko.size()>0) {
	

	Iterator ipp = liko.iterator();

	while (ipp.hasNext()) {
		com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)ipp.next();
		
		
		
		
		// if (nul.jeNull(tu.getTip_inserta()).equals("hidden")) {
			

			

			 sb.append("session.setAttribute(\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\",nul.jeNull(request.getParameter(\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"))); \r\n");
			//}
		 
	}
}



sb.append("Enumeration en = request.getParameterNames(); \r\n");

sb.append("while (en.hasMoreElements()) { \r\n");
sb.append("String neee = (String)en.nextElement(); \r\n");

	 sb.append("session.setAttribute(neee,request.getParameter(neee)); \r\n");
		
sb.append("} \r\n");






}



sb.append("if (control.getPravica()) {\r\n");



if (sif.getTemplatePPs()!=null && sif.getTemplatePPs().size()>0) {
	 
	 
	Iterator itf = sif.getTemplatePPs().iterator();
	
	while (itf.hasNext()) {
		com.popultrade.model.TemplatePP tpp = (com.popultrade.model.TemplatePP)itf.next();
		if (tpp.getRazlicno_ime_inputa()!=null && !nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")) {
			
			//sb.append("<////%\r\n");
		//	sb.append("if (request.getParameter(\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\")!=null) {\r\n");
			//sb.append("%////>\r\n");
			if (tpp.getStolpec_metoda().indexOf("request.getParameter")!=-1) {
				 //sb.append("<input type=hidden name=\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>\">\r\n");
					
		
			}
			else {
		// sb.append("<input type=hidden name=\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\"))%////>\">\r\n");
				sb.append("session.setAttribute(\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\",nul.jeNull(request.getParameter(\""+(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tpp.getRazlicno_ime_inputa()):nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get",""))+"\")));\r\n");
			
			}
		// sb.append("<////%\r\n");
		// sb.append("}\r\n");
	//	 sb.append("%////>\r\n");
		}
	
		
	}
 
}









sb.append("%////>\r\n");


sb.append("<html>\r\n");

sb.append("<head>\r\n");
sb.append("<meta http-equiv=\"Content-Language\" content=\"en-us\">\r\n");
sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1250\">\r\n");

sb.append("</head>\r\n");
sb.append("<script language=\"javascript\">\r\n");

sb.append("function gum() {\r\n");

sb.append("//parent.frames[2].location=\"nic.jsp\";\r\n");
sb.append("}\r\n");
sb.append("</script>\r\n");
sb.append("<body topmargin=\"0\" leftmargin=\"0\" rightmargin=\"0\" bottommargin=\"0\" marginwidth=\"0\" marginheight=\"0\" onload=\"gum()\">\r\n");

sb.append("<table width=\"100%\" id=\"table1\" height=\"100%\"   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\" bgcolor=#C3E1FC	>\r\n");
sb.append("<tr>\r\n");
sb.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
sb.append("</font>\r\n");
sb.append("<table  width=\"98%\" id=\"table2\" height=\"92%\"   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\">\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#E3F1FE\" align=\"center\">\r\n");
sb.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\">\r\n");
sb.append("<form ENCTYPE=\"multipart/form-data\" name=\"dod\" onsubmit=\"return mom()\"  METHOD=\"POST\" ACTION=\""+imefile.toLowerCase()+"_ur2"+sif.getId()+".jsp?opcija=new&siframm=new\">\r\n");
					
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" colspan=\"2\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" align=\"right\">\r\n");
sb.append("<p align=\"center\">< %=ConPool.getPrevod(\""+sif.getId()+"V\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td>\r\n");
sb.append("<td align=\"left\" bgcolor=\"#A8D3FB\"><input TYPE=\"FILE\" NAME=\"fupload\"  style=\"font-family: Verdana; font-size: 8pt\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td colspan=\"2\" bgcolor=\"#C3E1FC\" align=\"center\">\r\n");
sb.append("<input TYPE=\"submit\" VALUE=\"< %=ConPool.getPrevod(\""+sif.getId()+"C\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  style=\"font-family: Verdana; font-size: 8pt\">&nbsp;</td>\r\n");

sb.append("</tr>\r\n");
sb.append("</form></table>\r\n");
sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("<script language='javascript'>\r\n");

sb.append("function mom() {\r\n");
sb.append("if (document.dod.fupload.value=='') {\r\n");
sb.append("alert('Error: no file selected!');\r\n");
sb.append("return false;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");

sb.append("</script>\r\n");
sb.append("</body>\r\n");

sb.append("</html>\r\n");
sb.append("<////% }%////>\r\n");
	
	
	
BufferedWriter out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_ur1"+sif.getId()+""+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();
	
	
sb.delete(0,sb.length());
	
	












sb.append("<////%@ page contentType=\"text/html; charset=windows-1250\" import=\"jxl.*,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.util.Date,org.w3c.dom.*,javax.xml.xpath.*\"%////>\r\n");
sb.append("<jsp:useBean id=\"reader\" scope=\"page\" class=\"com.orange.fupload.MultiPartRequest\" type=\"com.orange.fupload.MultiPartRequest\" />\r\n");
sb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
 


sb.append("<////%\r\n");
sb.append("request.setCharacterEncoding(control.encoding); \r\n");
sb.append("response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("response.addHeader(\"Cache-Control\", \"no-cache\") ; \r\n");
sb.append("response.addDateHeader(\"Expires\", 0);  \r\n");


sb.append("if (!control.getPravica()) {\r\n");
sb.append("%////><jsp:forward page=\"logout.jsp\"/><////%\r\n");
sb.append("}\r\n");

sb.append("%////>\r\n");
sb.append("<html>\r\n");

sb.append("<head>\r\n");
sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1250\">\r\n");
sb.append("</head>\r\n");


sb.append("<////%\r\n");
sb.append("boolean jeok=false;\r\n");
sb.append("String napaka=\"\";\r\n");
sb.append("try {\r\n");
			
			
			
		/////////// dobim potrebne podatke za upload


//sb.append("com.popultrade.dao.PodjetjaUpload315DAO daol = (com.popultrade.dao.PodjetjaUpload315DAO)contextUtil.getBeanDao(\"podjetjaUpload315DAO\",pageContext.getServletContext());\r\n");


//sb.append("com.popultrade.model.PodjetjaUpload315 podj = daol.getPodjetjaUpload315(new Long(session.getAttribute(\"esd10_315_id\")+\"\"));\r\n");
			
			

sb.append("%////>\r\n");

sb.append("<body bgcolor=\"white\" topmargin=\"0\" leftmargin=\"0\" rightmargin=\"0\" bottommargin=\"0\" marginwidth=\"0\" marginheight=\"0\" onload=\"remo()\">\r\n");
sb.append("<table border=0 width=\"100%\" cellpadding=\"2\" style=\"border-collapse: collapse; font-family:Verdana; font-size:8pt\" >\r\n");
sb.append("<tr><td bgcolor=#C3E1FC  colspan=\"2\"	>\r\n");
sb.append("&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<////%\r\n");
		//System.out.println(\"XXXXXXXXXXXXCCCCCCCCCCCCCCCCCC\");
		////////////// upload parametri ///////////////////////
sb.append("reader.setMaxLength(60000000);\r\n");
sb.append("reader.setBufferSize(100000);\r\n");
		/// filter
		String exte = "";
		if (nul.jeNull(sif.getUpload_extension()).indexOf(",")!=-1) {
			
			String[] exx = nul.jeNull(sif.getUpload_extension()).split(",");
			
			for (int o=0;o<exx.length;o++) {
				exte = exte + "\""+exx[o]+"\",";
			}
			if (exte.endsWith(",")) {
				exte = exte.substring(0,exte.length()-1);
			}
			
		}
		else {
			exte = "\""+nul.jeNull(sif.getUpload_extension())+"\"";
		}
		
		
sb.append("String[] fltr={"+exte+"};\r\n");
sb.append("reader.setFilterToUpload(fltr);\r\n");
sb.append("reader.prepareProcess(request);\r\n");
sb.append("String filenamee= \"\";\r\n");
sb.append("String pName;\r\n");
sb.append("int size;\r\n");
sb.append("boolean isHeader;\r\n");
sb.append("ServletContext scon=pageContext.getServletContext();\r\n");
sb.append("String path = scon.getRealPath(\""+sif.getUpload_lokacija()+"\"); ////// direktorij, kamor dam xls datoteke z mrnji\r\n");
sb.append("reader.setTempDirectory(path);\r\n");
		//////////////////////////////////////////////////
sb.append("String ext=\"\";\r\n");

sb.append("Hashtable parameters = new Hashtable();\r\n");
sb.append("boolean pas = false;\r\n");
sb.append("while(reader.nextHeader()){\r\n");
		///// ce gre za file ga posnamem, ce ne preskocim in grem na naslednjega

		//// password



sb.append("if(reader.isFile()){\r\n");
		 // System.out.println(\"111\");
sb.append("filenamee=reader.getCurrentFileName();\r\n");
sb.append("ext= reader.getCurrentExtension();\r\n");
		//System.out.println(\"111222\");
sb.append("String em;\r\n");
		/////// kontrola , ce je prazen
sb.append("if(reader.isCurrentEmpty()) {\r\n");
sb.append("em=\"Datoteka neuspesno prebrana\";\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("em=\"Datoteka uspesno prebrana\";\r\n");
sb.append("}\r\n");
		//System.out.println(\"1113333\");
sb.append("if (true) {////// uporabim ce imam cer pogoj ext\r\n");
//sb.append("if (ext.equals(\"xml\") ) { ///// uporabim ce imam cer pogoj ext\r\n");
		//System.out.println(\"1115555\");
		//// posnamem
sb.append("jeok=false;\r\n");
//sb.append("if (ext.equals(\"xml\")  ) {///// uporabim ce imam cer pogoj ext\r\n");
sb.append("if (true) {////// uporabim ce imam cer pogoj ext\r\n");
		 // System.out.println(\"1116666\");
		//  reader.setCurrentFileName(control.user_sifra+\".keystore\");///// uporabim ce imam pfx
sb.append("reader.setCurrentFileName(filenamee);////// uporabim ce nimam pfx\r\n");
sb.append("reader.saveNextPart();\r\n");
		//  System.out.println(\"1117777\");
		//  reader.Clear();



		///  presnamem certifikat in mu dam drugo ime
sb.append("File fior = new File(scon.getRealPath(\""+sif.getUpload_lokacija()+"\")+\"/\"+filenamee); ////// \r\n");

		  
sb.append("File fio2 = new File(scon.getRealPath(\""+sif.getUpload_lokacija()+"/arhiv\")+\"/\"+control.getUser()+\"_\"+filenamee); ////// upora\r\n");

sb.append("if (fio2.exists()) {\r\n");
sb.append("fio2.delete();\r\n");
sb.append("}\r\n");
		  
sb.append("fior.renameTo(fio2);\r\n");

sb.append("jeok= true;\r\n");
		  
sb.append("}\r\n");
sb.append("if (jeok) {\r\n");
sb.append("%////>\r\n");


sb.append("<tr><td bgcolor=#E3F1FE width=\"800\"	>\r\n");
sb.append("<table border=\"0\" width=\"100%\" style=\"font-family: Verdana; font-size: 8pt\">\r\n");
sb.append("<tr>\r\n");
sb.append("<td ><span style=\"font-size: 9pt\">Ime datoteke:  &nbsp;</span></td>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\" width=220><b><span style=\"font-size: 9pt\"><////%=filenamee%////>&nbsp;</span></b></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td ><span style=\"font-size: 9pt\">Vrsta datoteke: &nbsp;</span></td>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\"><b><span style=\"font-size: 9pt\"><////%=ext%////>&nbsp;</span></b></td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td ><span style=\"font-size: 9pt\">Status datoteke: &nbsp;</span></td>\r\n");
sb.append("<td bgcolor=\"#C3E1FC\"><b><span style=\"font-size: 9pt\"><////%=em%////>&nbsp;</span></b></td>\r\n");
sb.append("</tr>\r\n");
			
sb.append("</table>\r\n");

sb.append("</td></tr>\r\n");
sb.append("<////%\r\n");
sb.append("break;\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
		//// zbrisem certifikat
		//System.out.println(\"--------------------++++++++++++++++++++++11\" );
sb.append("reader.Clear();\r\n");
		//System.out.println(\"--------------------++++++++++++++++++++++22\" );
sb.append("File fi = new File(scon.getRealPath(\""+sif.getUpload_lokacija()+"\")+\"/\"+filenamee);\r\n");
sb.append("fi.delete();\r\n");
		//System.out.println(\"--------------------++++++++++++++++++++++33\" );
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");

sb.append("%////>\r\n");


sb.append("<tr><td bgcolor=#E3F1FE width=\"575\"	>\r\n");
sb.append("<b><font size=\"2\" color=\"#CC0000\">Napaka:</font></b><font size=\"2\"> Datoteka ni pravilna!\r\n");
sb.append("</font>  <br>\r\n");


sb.append("</td></tr>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");

sb.append("pas=true;\r\n");
	//	System.out.println(\"--------------------++++++++++++++++++++++\" );
		///parameters.put(\"password\",reader.getField(\"password\"));
		//System.out.println(reader.getCurrentFieldName());
sb.append("reader.nextPart();\r\n");

sb.append("}\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");
/*
sb.append("<////%\r\n");
		//// ocistim reader
		//reader.Clear();

sb.append("Hashtable zeje = new Hashtable();\r\n");
sb.append("if ((ext.equals(\"xml\")) && jeok) {///// uporabim ce je ok, najdem path za imo ce je xml\r\n");
			
			


sb.append("File xmll = new File(scon.getRealPath(\"WEB-INF/esd10ji_arhiv\")+\"/\"+control.getUser()+\"_\"+filenamee);\r\n");



sb.append("Document doc = null;\r\n");
sb.append("XPathFactory factory=null;\r\n");

sb.append("javax.xml.parsers.DocumentBuilderFactory dbf =javax.xml.parsers.DocumentBuilderFactory.newInstance();\r\n");

sb.append("dbf.setNamespaceAware(true);\r\n");
sb.append("javax.xml.parsers.DocumentBuilder builder =dbf.newDocumentBuilder();\r\n");
sb.append("doc = builder.parse(xmll);\r\n");

//sb.append("String expression = podj.getXml_path();\r\n");
		   
//sb.append("if (expression==null || expression.equals(\"\")) {\r\n");
//sb.append("throw new Exception(\"Napaka: ni xml path podatka!\");\r\n");
//sb.append("}\r\n");
		   // Compile the expression to get a XPathExpression object.
//sb.append("Object imo = getElementvalue(getXMLValue(doc,expression));\r\n");
		   
sb.append("if (imo!=null && !imo.toString().equals(\"\")) {\r\n");
sb.append("session.setAttribute(\"upload_file\",control.getUser()+\"_\"+filenamee);\r\n");
//sb.append("session.setAttribute(\"esd10_315_imo\",imo+\"\");\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("napaka = \"Ne najdem IMO vrednosti pot: \"+expression;\r\n");
sb.append("jeok = false;\r\n");
sb.append("}\r\n");
		   
		   


sb.append("}\r\n");
sb.append("%////>\r\n");
*/

sb.append("<////%\r\n");

sb.append("if (!filenamee.equals(\"\")) {\r\n");

sb.append("session.setAttribute(\"upload_file\",control.getUser()+\"_\"+filenamee);\r\n");
sb.append("session.setAttribute(\"upload_file_path\",scon.getRealPath(\""+sif.getUpload_lokacija()+"/arhiv\")+\"/\"+control.getUser()+\"_\"+filenamee);\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");


sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("catch (Exception ex) {\r\n");
sb.append("%////>\r\n");


sb.append("<tr><td bgcolor=#E3F1FE width=\"575\"	>\r\n");
sb.append("<b><font size=\"2\" color=\"#CC0000\">Napaka:</font></b><font size=\"2\">  datoteka ni v pravilnem formatu!\r\n");
sb.append("</font>  <br>\r\n");


sb.append("</td></tr>\r\n");

sb.append("<////%\r\n");
sb.append("org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("log.error(ex.toString());\r\n");
sb.append("}\r\n");


sb.append("if (!napaka.equals(\"\")) {\r\n");
sb.append("jeok=false;\r\n");
sb.append("%////>\r\n");
			
sb.append("<tr><td bgcolor=#E3F1FE width=\"575\"	>\r\n");
sb.append("<b><font size=\"2\" color=\"#CC0000\">Napaka:</font></b><font size=\"2\"> <////%=napaka %////>\r\n");
sb.append("</font>  <br>\r\n");


sb.append("</td></tr>\r\n");
sb.append("<////%	\r\n");
sb.append("}\r\n");

sb.append("%////>\r\n");
sb.append("<tr><td bgcolor=#C3E1FC  colspan=\"2\" align=\"center\"	>&nbsp;\r\n");
sb.append("<inpudt type=button value=\"  Nazaj na upload  \" onclick=\"esd10_upload2.jsp\" style=\"font-family: Verdana; font-size: 8pt\"></td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");

sb.append("<script language=javascript> \r\n");

sb.append("function remo() {\r\n");
			
sb.append("<////%\r\n");
sb.append("if (jeok) {\r\n");
sb.append("%////>\r\n");
sb.append("document.location=\""+imefile.toLowerCase()+"_ur3"+sif.getId()+""+".jsp"+"\";\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");
sb.append("}\r\n");


sb.append("</script>\r\n");


sb.append("</body>\r\n");
sb.append("</html>\r\n");


 out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_ur2"+sif.getId()+""+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();
	
	
sb.delete(0,sb.length());







sb.append("<////%@ page contentType=\"text/html;charset=utf8\" import=\"org.apache.poi.xssf.usermodel.XSSFSheet,org.apache.poi.*,org.apache.poi.xssf.usermodel.XSSFWorkbook,org.apache.poi.ss.usermodel.*,org.apache.poi.hssf.usermodel.HSSFWorkbook,org.apache.poi.hssf.usermodel.HSSFCell,org.apache.poi.hssf.usermodel.HSSFRichTextString,org.apache.poi.hssf.usermodel.HSSFRow,org.apache.poi.hssf.usermodel.HSSFSheet,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
sb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");
sb.append("<jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");
 
 
sb.append("<////%!\r\n");

sb.append("public  byte[] getBytesFromFile(File file) throws IOException {\r\n");
sb.append("InputStream is = new FileInputStream(file);\r\n");
// Get the size of the file
sb.append("long length = file.length();\r\n");

sb.append("if (length > Integer.MAX_VALUE) {\r\n");
    // File is too large
sb.append("}\r\n");

// Create the byte array to hold the data
sb.append("byte[] bytes = new byte[(int)length];\r\n");

// Read in the bytes
sb.append("int offset = 0;\r\n");
sb.append("int numRead = 0;\r\n");
sb.append("while (offset < bytes.length && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {\r\n");
sb.append(" offset += numRead;\r\n");
sb.append("}\r\n");

// Ensure all the bytes have been read in
sb.append("if (offset < bytes.length) {\r\n");
sb.append("throw new IOException(\"Could not completely read file \"+file.getName());\r\n");
sb.append("}\r\n");

// Close the input stream and return bytes
sb.append("is.close();\r\n");
sb.append("return bytes;\r\n");

sb.append("}\r\n");


sb.append("%////>\r\n");
sb.append("<////%\r\n");
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

sb.append("boolean mum=false;\r\n");

	
sb.append("try {\r\n");




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



/*

sb.append("com.popultrade.model."+sif.getUpload_tabela()+" vseb =new com.popultrade.model."+sif.getUpload_tabela()+"();\r\n");
sb.append("com.popultrade.dao."+sif.getUpload_tabela()+"DAO dao = (com.popultrade.dao."+sif.getUpload_tabela()+"DAO)contextUtil.getBeanDao(\""+sif.getUpload_tabela().toLowerCase()+"DAO\",pageContext.getServletContext());\r\n");
sb.append("String napaka=\"\";\r\n");

sb.append("ServletContext scon=pageContext.getServletContext();\r\n");
*/

//sb.append("StringBuffer sb = new StringBuffer();\r\n");

//// spremenim v bayte
if (!nul.jeNull(sif.getParsaj_excel()).equals("1")) {

//sb.append("BufferedReader in=null;\r\n");

//sb.append("in = new BufferedReader(new InputStreamReader(new FileInputStream(session.getAttribute(\"upload_file_path\")+\"\"),\"utf-8\"));\r\n");


//sb.append("File file = new File(session.getAttribute(\"upload_file_path\")+\"\");\r\n");
/*sb.append("byte [] fileData = new byte[(int)file.length()];\r\n");
sb.append("DataInputStream dis = new DataInputStream(new FileInputStream(file));\r\n");
sb.append("dis.readFully(fileData);\r\n");
sb.append("dis.close();\r\n");*/

/*
sb.append("String linee=\"\";\r\n");

sb.append("String NL = System.getProperty(\"line.separator\");\r\n");
 
sb.append("while ( (linee = in.readLine()) != null) {\r\n");
	
sb.append("sb.append(linee+NL);\r\n");
	
sb.append("}\r\n");




sb.append("in.close();\r\n");*/


}

if (nul.jeNull(sif.getParsaj_excel()).equals("1")) {


sb.append("try {\r\n");
//sb.append("File inputWorkbook = new File(session.getAttribute(\"upload_file_path\")+\"\");\r\n");
sb.append("InputStream  inputWorkbook =new FileInputStream (session.getAttribute(\"upload_file_path\")+\"\");\r\n");
///////// preberem xls

//	File inputWorkbook = new File(inputFile);
sb.append("HSSFWorkbook w;\r\n");

sb.append("w = new HSSFWorkbook(inputWorkbook);\r\n");

sb.append("HSSFSheet  sheet = w.getSheetAt(0);\r\n");

sb.append("Iterator rows  = sheet.rowIterator ();\r\n");

sb.append("while (rows.hasNext ()) {\r\n");
sb.append("HSSFRow row = (HSSFRow )rows.next();\r\n");

sb.append("Iterator cells = row.cellIterator ();\r\n");
 sb.append("int prvi=0;\r\n");
sb.append("while (cells.hasNext ()) {\r\n");
sb.append("HSSFCell cell = (HSSFCell)cells.next ();\r\n");
//sb.append("for (int i = 0; i < sheet.getRows(); i++) {\r\n");
			//// preberem prvi stolpec
//sb.append("for (int j = 0; j <sheet.getColumns() ; j++) {\r\n");
//sb.append("Cell cell = sheet.getCell(j, i);\r\n");
					/// zapisem mrnje
					//if (cell.getContents()!=null && !cell.getContents().equals("") && !zeje.containsKey(cell.getContents()+""))
					
	sb.append("String vsebina =\"\";\r\n");	
	
sb.append("if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {\r\n");
  
					
sb.append("vsebina = cell.getStringCellValue();\r\n");
sb.append("}\r\n");
sb.append("else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {	\r\n");
sb.append("vsebina =\"\"+ cell.getNumericCellValue();\r\n");
sb.append("}\r\n");

sb.append("if (vsebina!=null && !vsebina.equals(\"\")) {\r\n");
sb.append("if (prvi==0) {\r\n");
sb.append("prvi=1;\r\n");
sb.append("sb.append(vsebina.replace(\"\\\\\", \"\\\\\\\\005C\").replaceAll(\"\\r\", \"\\\\\\\\000D\").replaceAll(\"\\n\", \"\\\\\\\\000A\").replaceAll(\";\", \"\\\\\\\\003B\"));\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");

sb.append("sb.append(\";\"+vsebina.replace(\"\\\\\", \"\\\\\\\\005C\").replaceAll(\"\\r\", \"\\\\\\\\000D\").replaceAll(\"\\n\", \"\\\\\\\\000A\").replaceAll(\";\", \"\\\\\\\\003B\"));\r\n");
sb.append("}\r\n");
sb.append("}\r\n");


//String bb = "";

//bb.replaceAll("\r", "\\000D").replaceAll("\n", "\\000A").replaceAll(";", "\\003B");


sb.append("}\r\n");
sb.append("sb.append(\"\\r\\n\");\r\n");
		
sb.append("}\r\n");


sb.append("}\r\n");
sb.append("catch (Exception exx) {\r\n"); /// probam xssl



//sb.append("File inputWorkbook = new File(session.getAttribute(\"upload_file_path\")+\"\");\r\n");
//sb.append("InputStream  inputWorkbook =new FileInputStream (session.getAttribute(\"upload_file_path\")+\"\");\r\n");
///////// preberem xls

	sb.append("XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream (session.getAttribute(\"upload_file_path\")+\"\"));\r\n");
	 sb.append("XSSFSheet sheet = (XSSFSheet) wb.getSheetAt(0);\r\n");


sb.append("Iterator rows  = sheet.rowIterator ();\r\n");

sb.append("while (rows.hasNext ()) {\r\n");
sb.append("Row row = (Row )rows.next();\r\n");

sb.append("Iterator cells = row.cellIterator ();\r\n");
sb.append("int prvi=0;\r\n");
sb.append("while (cells.hasNext ()) {\r\n");
sb.append("Cell cell = (Cell)cells.next ();\r\n");
sb.append("String vsebina =\"\";	\r\n");
	
sb.append("if (cell.getCellType() ==Cell.CELL_TYPE_STRING) {	\r\n");			
sb.append("vsebina = cell.getStringCellValue();\r\n");
sb.append("}\r\n");
sb.append("else if (cell.getCellType() ==Cell.CELL_TYPE_NUMERIC) {	\r\n");
sb.append("vsebina =\"\"+ cell.getNumericCellValue();\r\n");
sb.append("}\r\n");
sb.append("\r\n");

sb.append("if (vsebina!=null && !vsebina.equals(\"\")) {\r\n");
sb.append("if (prvi==0) {\r\n");
sb.append("prvi=1;\r\n");
sb.append("sb.append(vsebina.replace(\"\\\\\", \"\\\\\\\\005C\").replaceAll(\"\\r\", \"\\\\\\\\000D\").replaceAll(\"\\n\", \"\\\\\\\\000A\").replaceAll(\";\", \"\\\\\\\\003B\"));\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");

sb.append("sb.append(\";\"+vsebina.replace(\"\\\\\", \"\\\\\\\\005C\").replaceAll(\"\\r\", \"\\\\\\\\000D\").replaceAll(\"\\n\", \"\\\\\\\\000A\").replaceAll(\";\", \"\\\\\\\\003B\"));\r\n");
sb.append("}\r\n");
sb.append("}\r\n");


sb.append("}\r\n");
sb.append("sb.append(\"\\r\\n\");\r\n");
		
sb.append("}\r\n");





sb.append("}\r\n");



}













/*


/// dobim file
sb.append("dao.get"+sif.getHead_class_name()+"(new Long(rezu));\r\n");


sb.append("vseb.setId(new Long(rezu));\r\n");
sb.append("File filec = new File(session.getAttribute(\"upload_file_path\")+\"\");\r\n");
sb.append("vseb.set"+(sif.getUpload_tabela_stolpec().substring(0,1).toUpperCase()+sif.getUpload_tabela_stolpec().substring(1,sif.getUpload_tabela_stolpec().length()))+"(getBytesFromFile(filec));\r\n");


//sb.append("dao.save"+sif.getUpload_tabela()+"_CLOB(vseb,sb.toString());\r\n");

sb.append("dao.save"+sif.getHead_class_name()+"(vseb);\r\n");


*/






sb.append("if (rezu!=null && !rezu.equals(\"NIOK\")) {\r\n");

sb.append("com.popultrade.model."+imefile+" vsebf =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO daof = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length())+"DAO\",pageContext.getServletContext());\r\n");


/// 
//st vprasanj





String vpr = "";


for (int h=0;h<sif.getTemplateClasss().size();h++) {

vpr = vpr + "?,";
}

if (vpr.endsWith(",")) {
vpr = vpr.substring(0,vpr.length()-1);
}


sb.append("CallableStatement  cs = daof.pridobiConnectionZaProceduro().prepareCall( \""+sif.getZacetek_procedure()+vpr+sif.getKonec_procedure()+"\" );\r\n");



Iterator ito = sif.getTemplateClasss().iterator();
int zom = 1;
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
sb.append("cs.set"+tcl.getVrsta_pogoja()+"("+zom+","+pred+tcl.getVrednost_pogoja().replaceAll("\'","\"")+(pred.equals("")?"":"+\"\")")+");\r\n");

zom++;
}


sb.append("cs.execute();\r\n");
sb.append("cs.close();\r\n");

sb.append("err=ConPool.getPrevod(\""+idpr+"Z\"+control.getJezik());\r\n");	
sb.append("}\r\n");

sb.append("}\r\n");
sb.append("catch (Exception ex){\r\n");
sb.append("//jeok=false;\r\n");
sb.append("log.error(ex.toString());\r\n");
sb.append("err = ConPool.getPrevod(\""+idpr+"Y\"+control.getJezik())+ \" \"+ex.toString();\r\n");
sb.append("}\r\n");


/// setam pregled uploada loga

sb.append("control.prikaziLogUpload=true;\r\n");



sb.append("%////>\r\n");
sb.append("<html><head><title>spreminjaj</title></head>\r\n");
 
sb.append("<style type=text/css> \r\n");
sb.append("@import \"barve.css\";\r\n");
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<body   style=\"margin: 0\"  >\r\n");
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
else if (thed.getHead_tip().equals("HE")) {
	predpo="_view";
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
sb.append(sif.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp"+(nul.jeNull(sif.getOpis()).indexOf("?")!=-1?sif.getOpis():"")+"';\r\n");
}
else if (!nul.jeNull(sif.getTarget_funkcija()).equals("") && nul.jeNull(sif.getOpis()).indexOf("parent.frames")==-1) {
	sb.append(sif.getTarget_funkcija()+"="+sif.getTarget_funkcija()+"+'"+((nul.jeNull(sif.getOpis()).indexOf("?")!=-1 || nul.jeNull(sif.getOpis()).indexOf("&")!=-1)?sif.getOpis():"")+"';\r\n");
}
else if (!nul.jeNull(sif.getTarget_funkcija()).equals("") && nul.jeNull(sif.getOpis()).indexOf("parent.frames")!=-1) {
	sb.append(sif.getTarget_funkcija()+"="+sif.getOpis()+";\r\n");
}
//sb.append("top.window.hideFrame();\r\n");
sb.append("}\r\n");



if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
	}
	
	
	
}


sb.append("var timerId = setTimeout(mom, 5000); \r\n");
sb.append("</script>\r\n");


out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_ur3"+sif.getId()+""+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();
	
	
sb.delete(0,sb.length());






























	
	
	
	
	
	
	
	
	Hashtable meto = templateUtil.getClassMetodeImenaHTGet(imefile);
///// kreiram predhoden page, ce je
	 boolean jenum = false;
	 boolean jestr = false;
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
	pp.append("////if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
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

	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII151");

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
	
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII152");
	
	
	
	
	
	pp.append("%////>\r\n");

	pp.append("<html><head><title>spreminjaj</title></head>\r\n");

	pp.append("<style type=text/css>\r\n");
	pp.append("@import \"barve.css\";\r\n");
	pp.append("</style>\r\n");
	pp.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");


	if (jestr || jenum) {
		pp.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
		}
		if (jenum) {
		pp.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
		}
		pp.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
		pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
	
	pp.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
	pp.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<body   style=\"margin: 0\"   onload=\"mom()\">\r\n");
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII153");
	
pp.append("<table  width=\"100%\" id=\"table1\" height=\"100%\"   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\" bgcolor=#C3E1FC	>\r\n");
pp.append("<tr>\r\n");
pp.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("<table  width=\"98%\" id=\"table2\" height=\"92%\"   border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#E3F1FE\" align=\"center\">\r\n");
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_ur1"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#C3E1FC\" colspan=\"2\">\r\n");






pp.append("&nbsp;</td>\r\n");
pp.append("</tr>\r\n");



System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII154");
StringBuffer sbuu = new StringBuffer();
boolean jenekaj = false;
if (liko.size()>0) {
jenekaj = true;

Iterator ipp = liko.iterator();

while (ipp.hasNext()) {
	com.popultrade.model.TemplatePP tu = (com.popultrade.model.TemplatePP)ipp.next();
	
	
	
	
	 if (nul.jeNull(tu.getTip_inserta()).equals("hidden")) {
		

		

		 pp.append("<input type=\"hidden\" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   value=\"<////%="+nul.jeNull(tu.getStolpec_metoda()).replaceAll("\'","\"")+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n");
		}
	
	 else {
	
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#C3E1FC\" align=\"right\">\r\n");


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII155");


pp.append("<p align=\"center\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td align=\"left\" bgcolor=\"#A8D3FB\">\r\n");



String max = nul.jeNull(tu.getStolpec_max_stevilo_znakov());
String dol = nul.jeNull(tu.getStolpec_sirina());
String tabi = nul.jeNull(tu.getTab_index());
if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {
	
	/// kontrola in generacija AJAX
		/// kontrola in generacija AJAX
	   	String ime_field="";
        
        		
        	//	ime_field = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
        		ime_field = nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tu.getRazlicno_ime_inputa()).toLowerCase();
        		
	String ajaxpolje = getAjaxPP(tu,contextUtil,pageContext.getServletContext(),ime_field);

	
	Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(sif.getHead_class_name());
	if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
		pp.append("<input type=\"text\"      "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"     onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"  > <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"\" ><img src='call.gif' border='0'></a> \r\n");
		}
		else {
pp.append("<input type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"  "+(!ajaxpolje.equals("")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+">\r\n");
}
}
else if (nul.jeNull(tu.getTip_inserta()).equals("password")) {
	/// nujno dodati v insert pogoje

	pp.append("<input type=\"password\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\">\r\n");
}
else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
	/// nujno dodati v insert pogoje

	pp.append("<input type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\" >\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
	/// nujno dodati v insert pogoje
	String cols = nul.jeNull(tu.getCols());
	String rows = nul.jeNull(tu.getRows());
	
	pp.append("<textarea "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=rezu%////></textarea>\r\n");
}
	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
		
		
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII156");
		pp.append("<select "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n");
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
		
		
		pp.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n");
		
		
		}
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII159");
		
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
		
		System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII160");
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


}



pp.append("<tr>\r\n");
pp.append("<td colspan=\"2\" bgcolor=\"#C3E1FC\" align=\"center\">\r\n");

if (sbuu!=null && !sbuu.toString().equals("")) {
	pp.append(sbuu.toString());
}



pp.append("<input TYPE=\"submit\" VALUE=\"< %=ConPool.getPrevod(\""+sif.getId()+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  style=\"font-family: Verdana; font-size: 8pt\">&nbsp;</td>\r\n");
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
pp.append("</td>\r\n");
pp.append("</tr>\r\n");
pp.append("</table>\r\n");
	
	
	
	
	
	
	
	
	
	
	
	pp.append("</body>\r\n");
	
	
	pp.append("<script language=\"javascript\">\r\n");
	pp.append("\r\nfunction custom() {\r\n");

//	if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_javascript()!=null) {
	//	pp.append(sif.getTemplateUiDodatno().getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
//	}

	pp.append("return true;\r\n");
	
	pp.append("}\r\n");
	
	pp.append("\r\nfunction mom() {\r\n");
	//pp.append("top.window.hideFrame();\r\n");
	
	
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

	 out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_ur1"+sif.getId()+"_p"+".jsp"), "latin1"));



	out3.write(pp.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
}

	
	
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
//// kreacija jsp za search
if (sif.getHead_tip().equals("SE")) {



    com.popultrade.dao.TemplateUiDAO daoui = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());



sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");


sb.append("<////%\r\n");
sb.append("////request.setCharacterEncoding(control.encoding);\r\n");
sb.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("////response.addDateHeader(\"Expires\", 0);\r\n");



sb.append("if (!control.getPravica()) {\r\n");
sb.append("%////><jsp:forward page=\"logout.jsp\"/><////%\r\n");
sb.append("}\r\n");


sb.append("try {\r\n");
sb.append("com.popultrade.model."+class_name+" vseb =new com.popultrade.model."+class_name+"();\r\n");
sb.append("com.popultrade.dao."+class_name+"DAO dao = (com.popultrade.dao."+class_name+"DAO)contextUtil.getBeanDao(\""+class_name.substring(0,1).toLowerCase()+class_name.substring(1)+"DAO\",pageContext.getServletContext());\r\n");

sb.append("if (session.getAttribute(\""+class_name.toLowerCase()+"_search\")!=null) {\r\n");
sb.append("vseb = (com.popultrade.model."+class_name+")session.getAttribute(\""+class_name.toLowerCase()+"_search\");\r\n");
sb.append("}\r\n");
	


sb.append("%////>\r\n");

sb.append("<////%\r\n");

sb.append("boolean bok=false;\r\n");



//// javascript kontrole


System.out.println("SEARCHCHHHHHHHHHHHHHH 1");

sb.append("Hashtable ht =new Hashtable();\r\n");
//sb.append("//ht.put(\"id\",\"id\");\r\n");
sb.append("Hashtable htn =new Hashtable();\r\n");
//sb.append("//htn.put(\"kolicina\",\"kol_kg\");\r\n");
sb.append("Hashtable htnn =new Hashtable();\r\n");

com.popultrade.model.TemplateUi tui = new com.popultrade.model.TemplateUi();
System.out.println("SEARCHCHHHHHHHHHHHHHH 2");
tui.setTemplatehead_id(new Long(idpr));
List tempui = daoui.getTemplateUis(tui);

Hashtable meto = templateUtil.getClassMetodeImenaHTGet(imefile);
boolean jenum = false;
boolean jenumm = false;
boolean jestr = false;
String dodaj_datum="";

if (tempui.size()>0) {
Iterator termo = tempui.iterator();

Hashtable metos = templateUtil.getClassMetodeImenaHTGet(imefile);
while (termo.hasNext()) {
	com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)termo.next();
	
	/// dodaj kontrolo
	if (nul.jeNull(tu.getKontrola_javascript()).equals("DA")) {
		
		/// vrsta kontrole, numeric ali string ali datum
		
		if (meto.containsKey(tu.getStolpec_metoda())) {
			
			if (meto.get(tu.getStolpec_metoda()).toString().indexOf("int")!=-1 ||meto.get(tu.getStolpec_metoda()).toString().indexOf("Integer")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Long")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Double")!=-1) {
				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				
				sb.append("htn.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				jenum = true;
			}
			else {
				sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
				jestr = true;	
			}
			
			
		}
		else {
			sb.append("ht.put(\"\"+ConPool.getPrevod(\""+tu.getId()+"J\"+control.getJezik()).replaceAll(\"_\",\" \"),\""+tu.getStolpec_metoda().replaceAll("get","").toLowerCase()+"\");\r\n");	
			jestr = true;
		}
		
		
	}
 	else if (nul.jeNull(tu.getKontrola_numericno()).equals("1")) { /////// v primeru da je samo kontrola da je vrednost numericna
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
	
	
	if (metos.containsKey(nul.jeNull(tu.getStolpec_metoda()))) {
		
		if (((String)metos.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
			//dodaj_datum = dodaj_datum + "dp_ca1 = new Epoch('epoch_popup','popup',document.dod."+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+");\r\n";
		}
		
	}
	
	
}
}
System.out.println("SEARCHCHHHHHHHHHHHHHH 3");
sb.append("%////>\r\n");

sb.append("<html><head><title>spreminjaj</title></head>\r\n");
sb.append("<link type='text/css' href='styles/basic.css' rel='stylesheet' media='screen' />\r\n");
sb.append("<link type='text/css' href='styles/basic_ie.css' rel='stylesheet' media='screen' />\r\n");

sb.append("<style type=text/css>\r\n");
sb.append("@import \"barve.css\";\r\n");
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");


if (jestr || jenum) {
sb.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
}
if (jenum) {
sb.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
}
if (jenumm) {
sb.append("<////%=javaScript.getControlsNumericValuesHashtableZNulo(\"document.dod\",htnn) %////>\r\n");
}
//sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"scripts/epoch_styles.css\">\r\n");
//sb.append("<script type=\"text/javascript\" src=\"scripts/epoch_classes.js\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
	sb.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
	sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
sb.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
sb.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script type='text/javascript' src='js/jquery.simplemodal.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
sb.append("<script type='text/javascript' src='js/basic.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");


sb.append("<script language='javascript'>\r\n");
com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());

System.out.println("SEARCHCHHHHHHHHHHHHHH 4");

com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();

System.out.println(":::::::::::::::::::::::::::::::: "+sif.getId());
tuidd = daouid.getTemplateUiDodatnos(sif.getId()+"");


if (tuidd!=null && tuidd.getDodatno_javascript2()!=null) {
	sb.append(tuidd.getDodatno_javascript2().replaceAll("\n","\r\n")+"\r\n");
}



System.out.println("SEARCHCHHHHHHHHHHHHHH 5");
sb.append("function chg() {\r\n");


/// reset lokacij

if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}

sb.append(dodaj_datum+"\r\n");
//parent.frames[2].location = "nic.jsp";


//dp_ca1 = new Epoch('epoch_popup','popup',document.dod.eta1);
 
//dp_ca0 = new Epoch('epoch_popup','popup',document.dod.eta2);
 
//sb.append("top.window.hideFrame();\r\n");


if (tuidd!=null && tuidd.getDodatno_javascript_onload()!=null) {
	sb.append(tuidd.getDodatno_javascript_onload().replaceAll("\n","\r\n")+"\r\n");
}


sb.append("}\r\n");

sb.append("function subm() {\r\n");
if (tuidd!=null && tuidd.getDodatno_javascript_funkcije()!=null) {
	sb.append(tuidd.getDodatno_javascript_funkcije().replaceAll("\n","\r\n")+"\r\n");
}


sb.append("oknoShow();\r\n");
if (!nul.jeNull(sif.getTarget_isci()).equals("")) {
	  
	
	sb.append("document.dod.target="+sif.getTarget_isci().replaceAll("location","")+"name;\r\n");
	
}

Iterator itmoo = tempui.iterator();


System.out.println("SEARCHCHHHHHHHHHHHHHH 6");
while (itmoo.hasNext()) {
	
	com.popultrade.model.TemplateUi tuii = (com.popultrade.model.TemplateUi)itmoo.next();
	
	if (!nul.jeNull(tuii.getTip_polja()).equals("PR")) {
	if (nul.jeNull(tuii.getSamo_velike_crke()).equals("1") ) {
		
		
		String pass = (nul.jeNull(tuii.getParameter_drugo_ime()).equals("")?nul.jeNull(tuii.getStolpec_metoda()).toLowerCase().replaceAll("get",""):nul.jeNull(tuii.getParameter_drugo_ime()).toLowerCase().replaceAll("get",""));	
		
			sb.append("document.dod."+pass+".value=document.dod."+pass+".value.toUpperCase();\r\n");
			sb.append("document.dod."+pass+".value=encodeURIComponent(document.dod."+pass+".value);\r\n");
			
		}
	else {
		
		String pass = (nul.jeNull(tuii.getParameter_drugo_ime()).equals("")?nul.jeNull(tuii.getStolpec_metoda()).toLowerCase().replaceAll("get",""):nul.jeNull(tuii.getParameter_drugo_ime()).toLowerCase().replaceAll("get",""));	
		if (pass!=null && !pass.equals("")) {
		//sb.append("document.dod."+pass+".value=document.dod."+pass+".value.toUpperCase();\r\n");
		sb.append("document.dod."+pass+".value=encodeURIComponent(document.dod."+pass+".value);\r\n");
		}
	}
	}
}
sb.append("}\r\n");




System.out.println("SEARCHCHHHHHHHHHHHHHH 7");

sb.append("</script>\r\n");



sb.append("<body   style=\"margin: 0\"  background=\"podlaga.jpg\" bgproperties=\"fixed\"  onload=\"chg()\">\r\n");


//loading overlay okno
sb.append("<div id=\"basic-modal-content\"><img src='loadingg.gif'></div>\r\n");


sb.append("<////%\r\n");

sb.append("String rezu=\"\";\r\n");

sb.append("%////>\r\n");


com.popultrade.model.TemplateGumbi tgumbb = new com.popultrade.model.TemplateGumbi() ;


if (sif.getVeza_gumb()!=null && !sif.getVeza_gumb().toString().equals("")) {


tgumbb = daotgi.getTemplateGumbi(sif.getVeza_gumb());

//sif.getVeza_gumb()
}

String target_search=""+imefile.toLowerCase()+"_list"+tgumbb.getTemplatehead_id()+".jsp";

if (!nul.jeNull(sif.getTarget_search_rocno()).equals("")) {
	target_search = sif.getTarget_search_rocno();
}
sb.append("<form name=\"dod\" method=\"get\" action=\""+target_search+"\" target=\"ifr2\" onSubmit=\"return subm()\">\r\n");
sb.append("<input type=\"hidden\" name=\"isci\" value=\"yes\">\r\n");



////dam parametre, ki posljem preko requesta
if (tgumb.getTemplateGumbiParametris()!=null && tgumb.getTemplateGumbiParametris().size()>0) {
	 
	 
	 Iterator iko = tgumb.getTemplateGumbiParametris().iterator();
	 
	 
	 while (iko.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)iko.next();
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("getParameter")!=-1) {
		
			 
			 if (nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("")) {
				 sb.append("<input type=hidden name=\""+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","\"")+")%////>\">\r\n");
					 }
			 else {
				// parametri = parametri + "&"+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
				 sb.append("<input type=hidden name=\""+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","\"")+")%////>\">\r\n");
						
			 }
			 
			 
			
		 }
		 
		 else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
		 sb.append("<input type=hidden name=\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\" value=\"<////%=nul.jeNull(request.getParameter(\""+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"\"))%////>\">\r\n");
		 }
	 }
	 
	 
	 
}




System.out.println("SEARCHCHHHHHHHHHHHHHH 8");



sb.append("<table border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\"  width=\"100%\"  ><tr><td colspan=\"4\" class=\"opiscell\">&nbsp;</td></tr>\r\n");




if (tempui.size()>0) {
	Iterator itmo = tempui.iterator();
	
	
	
	while (true) {
			
		
		String premo = "";
		String premoe = "";
		if (itmo.hasNext()) {
			
			com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)itmo.next();
			/// ce je polje prazno
			if (nul.jeNull(tu.getTip_polja()).equals("PR")) {
				
			
				premoe=premoe+"<tr>";
		            		  
		        premoe=premoe+"<td class=\"opiscell\" COLLSPANN  >< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>&nbsp;</td>";
  		 
		        
				
			}
			else {
		
				premo = premo + "<tr>";
      		  
		        premo = premo + "<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td class=\"valuecell\" width=\"30%\" COLLSPANN>";
		            
		        
	
		        premo = premo + genFieldSEE(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name());
		        	
		        
		        /// kontrola, ce ima se enega, za logiko dodatnega prikaza
		        
		        if (true) {
		        	
		        	//// 
		        //	com.popultrade.dao.TemplateUiDAO dauid = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		        	
		        //	com.popultrade.model.TemplateUi tuim = dauid.getTemplateUi(tu.getTemplateui_id().getId());
		        
		        
		        Iterator nexc = tu.getTemplateuis().iterator();
		        
		        while (nexc.hasNext()) {
		        	com.popultrade.model.TemplateUi tuinext = (com.popultrade.model.TemplateUi)nexc.next();
		        	premo = premo + " < %=ConPool.getPrevod(\""+tuinext.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ";
		        	
		        	premo = premo + genFieldSEE(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name());
		        	
		        }
		        
		        
		        	
		        	
		        }
		        
		        
		        premo = premo + "</td>";
		           
            		 
        
		}
		}
		else {
			break;
		}
		if (itmo.hasNext()) {
			com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)itmo.next();
			
			/// ce je polje prazno
			if (nul.jeNull(tu.getTip_polja()).equals("PR")) {
				if (!premoe.equals("")) {
			
				sb.append(premoe.replaceAll("COLLSPANN","colspan=\"4\"")+"</tr>\r\n");
				
				}
				else if (!premo.equals("")) {
					
					sb.append(premo.replaceAll("COLLSPANN"," colspan=\"3\"")+"</tr>\r\n");
						
				}
			}
			else {
				if (!premoe.equals("")) {
					
					sb.append(premoe.replaceAll("COLLSPANN","colspan=\"2\"")+"\r\n");
					
					}
					else if (!premo.equals("")) {
						
						sb.append(premo.replaceAll("COLLSPANN"," width=\"30%\" ")+"\r\n");
							
					}
				
				sb.append("<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td class=\"valuecell\" width=\"30%\">\r\n");
				sb.append(genFieldSEE(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));
		        
				
		        /// kontrola, ce ima se enega, za logiko dodatnega prikaza
		        
		        if (true) {
		        	
		        	//// 
		        //	com.popultrade.dao.TemplateUiDAO dauid = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		        	
		        //	com.popultrade.model.TemplateUi tuim = dauid.getTemplateUi(tu.getTemplateui_id().getId());
		        
		        
		        Iterator nexc = tu.getTemplateuis().iterator();
		        
		        while (nexc.hasNext()) {
		        	com.popultrade.model.TemplateUi tuinext = (com.popultrade.model.TemplateUi)nexc.next();
		        	
		        	sb.append(" < %=ConPool.getPrevod(\""+tuinext.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ");
		        	sb.append(genFieldSEE(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name()));
		        	
		        }
		        
		        
		        	
		        	
		        }
		        
		        
		        sb.append("</td>");
sb.append("</tr>\r\n");
		
			}
	
		
		}
		else {
			break;
		}
	
	
	}
	
	
	
	
}

System.out.println("SEARCHCHHHHHHHHHHHHHH 9");

	
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\" colspan=\"4\" align=\"right\" bgcolor=\"#C3E1FC\">\r\n");
sb.append("<p align=\"center\"><input  type=reset  value=\"< %=ConPool.getPrevod(\""+idpr+"S\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" style=\"font-family: Verdana; font-size: 8pt\"> <input type=submit  value=\"< %=ConPool.getPrevod(\""+idpr+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" style=\"font-family: Verdana; font-size: 8pt\">\r\n");
sb.append("</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");
sb.append("</form>\r\n");
	
	
	
	sb.append("<script language='javascript'>\r\n");
sb.append("function custom() {\r\n");


	


sb.append("return true;\r\n");
sb.append("}\r\n");
sb.append("function mom() {\r\n");

sb.append("//parent.frames[3].location = \"nic.jsp\";\r\n");
sb.append("<////%\r\n");
sb.append("////if (request.getParameter(\"akcijaXY\")==null) {\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");
sb.append("}\r\n");
sb.append("</script>\r\n");


sb.append("<////%\r\n");


sb.append("////}\r\n");
sb.append("////catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("////log.error(ex.toString());\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");
System.out.println("SEARCHCHHHHHHHHHHHHHH 10");

imefile = imefile+"_isci"+sif.getId();


}
////konec kreacije jsp za search
/////////////////
////////////////































if (!sif.getHead_tip().equals("UP") && !sif.getHead_tip().equals("UR")) {
if (imefile_fo!=null && !imefile_fo.equals("")) {

Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam_fo+imefile_fo.toLowerCase()+".fo"), "UTF-8"));



out3.write(sbfo.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();


/// zapisem se pdf za tahomo z fiksnimi fonti


Writer out4 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam_fo+imefile_fo.toLowerCase()+"tahoma.fo"), "UTF-8"));



out4.write(sbfo.toString().replaceAll("29.7cm","30.48cm").replaceAll("< %=","<////%=").replaceAll("////","").replaceAll("verdana", "tahoma").replaceAll("font-size=\"7pt\"", "font-size=\"8pt\"").replaceAll("font-size=\"6pt\"", "font-size=\"8pt\""));
////zaprem writer3
out4.close();


}


Writer  out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();
imefile = deploy_kam+imefile.toLowerCase()+".jsp";
}
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
