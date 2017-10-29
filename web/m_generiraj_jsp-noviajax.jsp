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

public com.popultrade.webapp.ContextUtil contextUtil2 = null;


private com.popultrade.webapp.Parametri parametri = new com.popultrade.webapp.Parametri();
public String deploy_kam =parametri.getParametri().getProperty("deploy_kam");// "E:/Tomcat5.0/webapps/popultrade/";



//// cvreiram vsebina za gumb pp view opcija (nexttoji se sestavljajo)

public String createPPView(com.popultrade.model.TemplateView tu) {


String premo="";

			 System.out.println("1VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
			 Iterator iteb = tu.getTemplateClasses().iterator();
			 premo = premo + "<%\r\n"; 
			 premo = premo + "rezu=\"\";\r\n"; 
			 premo = premo + "rezu2=\"\";\r\n"; 
			 
			// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
		
			// nul.getDatumFormatFromDate()
			 while (iteb.hasNext()) {
				 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
				 ///
				 
				 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
					 
					System.out.println("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm" +tc.getPredpona_pogoja());
					 
					 /// pogoj
					 premo = premo + "\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n";
					 
					 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
						 premo = premo + "rezu=nul.formatNumber(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
						 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
					 }
					 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
						 premo = premo + "rezu=nul.getDatumFormatFromDate(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
					 }
					 else {
						 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
							 if (tc.getFunkcija_formata2().indexOf(".get")==-1) {
								 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul\\.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
									 }
								 else {
									 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
												
								 }
								 
							 
						 }
						 else {
						
							 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
								 if (tc.getVrednost_pogoja().startsWith("\"+")) {
								 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
								 }
								 else {
									 premo = premo + "rezu="+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
										 
								 }
							 }
							 else {
								 premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
									
							 }
						 }
						 }
						 
					 premo = premo + "rezu2=rezu2+\" \"+rezu;\r\n";
					 
					 premo = premo + "}\r\n";
					 
				 }
				 
				 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) ) {
					 
						
					 System.out.println("122VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
					 
					 
					 /// vrednost iz clase
					 
					 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
	/// pogoj
	if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
	premo = premo + nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n";
	}
	 	 
	
	
	String dodaten = "";
	if (tc.getTemplateClassClass().getTemplateClasss().size()>0) {
	
		Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();
		
		while (tre.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
		
		if (tcc.getVrsta_pogoja()!=null && tcc.getVrsta_pogoja().equals("class")) {
		
			if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
			dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("get","vseb.get")+"()+\"\").equals(\"\")";
			}
		
		
		}
		else if (tcc.getVrednost_pogoja()!=null && tcc.getVrednost_pogoja().indexOf("request.getParameter")!=-1){
			dodaten = dodaten+  " && !nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("'","\"")+"+\"\").equals(\"\")";
		}
		
		
		}
		/// dodaten pogoj da sploh gleda po bazi
		
		
		
	}
	premo = premo + "rezu=\"\";\r\n";	
	
	
	
	
	
	
	premo = premo + "if (true "+dodaten+") {\r\n";
	
	premo = premo + "com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

	premo = premo + "com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n";




	/// setam vrednosti
System.out.println("133VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil2,this.getServletContext(),tc.getTemplateClassClass().getClass_name());
	
	while (tre.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
		
		///////// ///////// ///////////
		
		
		String rett = tcc.getVrednost_pogoja().replaceAll("\'","\"");
		
		if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			if (((String)meto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				rett = "nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceFirst("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()).replaceAll(\"_\",\"\\\\_\")";
				}
				else {
					rett = ""+tcc.getVrednost_pogoja();
					
				}
			}
			else {
				
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				rett = tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceFirst("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()";
				}
				else {
					rett = ""+tcc.getVrednost_pogoja();
					
				}
			
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
		
		
		//sb.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
		if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			premo = premo + "mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n";
		}
		else {
			if (rett.indexOf("request.getParameter(")!=-1) {
				
				premo = premo + "mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n";
					}
					else {
						premo = premo + "mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n";	
					}
		}
		
		
		System.out.println("441VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
		
		
		
		
	}


	premo = premo + "List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n";




	premo = premo + "if (remi.size()>0) {\r\n";

	premo = premo + "mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n";

	System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE123 ::: "+tc.getPredpona_pogoja());


	//// pogoji vrednosti

	Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();


	while (vredno.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();
		System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE335 ::: "+tc.getPredpona_pogoja());
		if (tcv.getTemplateClasses().size()>0) {
		/// dobim templateclass
		Iterator item = tcv.getTemplateClasses().iterator();
				 while (item.hasNext()) {
				 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
				 
				 
				 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
					 
					
					 
					 /// pogoj
					 premo = premo + "\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n";
					 
					 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
						 premo = premo + "rezu=nul.formatNumber(mod."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
						 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
					 }
					 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
						 premo = premo + "rezu=nul.getDatumFormatFromDate(mod."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
					 }
					 else {
						 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
							 if (nul.jeNull(txc.getFunkcija_formata2()).indexOf(".get")==-1) {
								 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul\\.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
									 }
								 else {
									 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
												
								 }
							// premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
								 
							 
						 }
						 else {
					
							 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf(".get")==-1) {
								
								 if (txc.getVrednost_pogoja().startsWith("\"+")) {
								 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
								 }
								 else {
									 premo = premo + "rezu="+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
										 
								 }
							 
							 }
								 else {
									 premo = premo + "rezu="+txc.getVrednost_pogoja()+";\r\n\r\n";
										
								 }
							
						 
						 }
						 }
						 
					 
					 
					 premo = premo + "}\r\n";
					 
				 }
				 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
					 
					 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
						 
						 if (nul.jeNull(txc.getFunkcija_formata2()).indexOf(".get")==-1) {
							 premo = premo + "rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
										 }
							 else {
								 premo = premo + "rezu=rezu+"+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
											
							 } 
						 
					 }
					 else {
						 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf(".get")==-1) {
							
							 if (txc.getVrednost_pogoja().startsWith("\"+")) {
							 premo = premo + "rezu=rezu+\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
							 }
							 else {
								 premo = premo + "rezu=rezu+"+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
									
							 }
						 
						 }
							 else {
								 premo = premo + "rezu=rezu+"+txc.getVrednost_pogoja()+";\r\n\r\n";
									
							 }
						
					 
					 }
				 }
				 }
		}
		else {
			
			System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEExxx ::: "+tc.getPredpona_pogoja());
			String dodvred = "";
		if (!nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
			
	
			
			dodvred = " "+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
		
		
		}
			
		System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: "+tc.getPredpona_pogoja());
			premo = premo + "rezu="+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n";
			
		}
		
		
		
	}


	premo = premo + "rezu2=rezu2+\" \"+rezu;\r\n";



	premo = premo + "}\r\n";



	premo = premo + "}\r\n";


	if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
	premo = premo + "}\r\n";
	}			 
						 
						 
					 }
					 
					 
					 
					 
					 
					 
					 
					 
					 
				 }
				 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
					// System.out.println("FORMATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT" +nul.jeNull(tc.getFunkcija_formata1()));
					 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
						 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
							 premo = premo + "rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
												 }
							 else {
								 premo = premo + "rezu=rezu+"+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
											
							 } 
							 
						 
					 }
					 else {
					
							
						 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
						
							 
							 if (tc.getVrednost_pogoja().startsWith("\"+")) {
							 premo = premo + "rezu=rezu+\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request\\.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request\\.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
							 }
							 else {
								 premo = premo + "rezu=rezu+"+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request\\.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request\\.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
									 
							 }
						 
						 }
							 else {
								 premo = premo + "rezu=rezu+"+tc.getVrednost_pogoja()+";\r\n\r\n";
									
							 }
						
					 
					 }
					 premo = premo + "rezu2=rezu2+\" \"+rezu;\r\n";
				 }
				 
				 
			 }
			 premo = premo + "rezu=rezu2;\r\n";
			 premo = premo + "%////>\r\n";
			 
			 
			 return premo;




}

///////// konec createPPView 












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
	sbl.append("<////%@ page contentType=\"text/html; \" import=\"org.apache.poi.ss.usermodel.FontCharset,javax.mail.*,javax.mail.internet.*,javax.activation.*,org.apache.poi.ss.usermodel.Sheet,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.apache.poi.hssf.usermodel.HSSFWorkbook,org.apache.poi.hssf.usermodel.HSSFSheet,org.apache.poi.hssf.usermodel.HSSFRow,org.apache.poi.hssf.usermodel.HSSFCell,org.apache.poi.hssf.usermodel.HSSFCellStyle,org.apache.poi.hssf.usermodel.HSSFFont,org.apache.poi.hssf.usermodel.*,org.apache.poi.hssf.util.HSSFColor,java.util.Hashtable\"%////>\r\n");
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
				sbl.append("dodpog = (!dodpog.equals(\"\")?\" and \":\"\")+ \""+dodaten_sql_pogoj+"\";\r\n");
				
			
			if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
			sbl.append(" }\r\n");
			}
		}
		
		}
		
		
	}

	sbl.append("String dodaten_sql_pogoj = dodpog;\r\n");
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
	  

	    int  stej=0;
	      int bar = 0;
	      String[] barv = new String[2];
	      barv[0]="ADD9FF";
	      barv[1]="D2EAFF";
	      
	      int htvsst=0;
	   
	      Iterator itbi = lin.iterator();
	      
	      int stz = 0;
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
	             
	             
	             
	             sbl.append("s.setColumnWidth( (short) "+stz+", (short) "+suti+"); \r\n");
stz++;
	//sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"'  bgcolor='#F0F0F0'  title='\"+ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") +\"'>\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</td>\");\r\n");
	               
	        
	//bar++;

	              }
	              
	              
	          
	          
	          /////// imena
	          
	    
	      itbi = lin.iterator();
	      sbl.append("int rowss = 0;\r\n");
	      sbl.append("int zapp = 0;\r\n");


      sbl.append("r = s.createRow(rowss);\r\n");
     sbl.append("rowss++;\r\n");

	      while (itbi.hasNext()) {
	     	
	     	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbi.next();

     ////////// naslovi columov

     sbl.append("c = r.createCell((short)zapp);\r\n");
  //   c.setEncoding(HSSFWorkbook.ENCODING_UTF_16);
     sbl.append("c.setCellValue(ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") );\r\n");
     sbl.append("c.setCellStyle(style);\r\n");
	sbl.append("zapp++;\r\n");
	          
	          //sbl.append("outt.append(\"<td width='"+tli.getStolpec_width()+"' align='"+tli.getStolpec_align()+"'  bgcolor='#F0F0F0'  title='\"+ConPool.getPrevod(\""+tli.getId()+"H\"+control.getJezik()).replaceAll(\"_\",\" \") +\"'>\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</td>\");\r\n");
	
	          }
	          
	          
	          
	          
	          
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
			 			if (metog.containsKey(tli.getStolpec_metoda().replaceAll("get", "set"))) {
			if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("String")!=-1) {
			}
			else if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("Long")!=-1) {
		tipm = "stylenumber";
				
			}
			else if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("Integer")!=-1 || ((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("int")!=-1) {
			tipm = "stylenumber";
				
			}
			else if (((String)metog.get(tli.getStolpec_metoda().replaceAll("get", "set"))).indexOf("Double")!=-1) {
			 	tipm = "stylenumber";
			 }
			 }	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
			 	
	sbl.append("c = r.createCell((short)zapp);\r\n");
	sbl.append("if (rezu!=null && rezu.indexOf(\">\")==-1) {\r\n");
	sbl.append(" c.setCellStyle("+tipm+");\r\n");
	sbl.append("}\r\n");
	sbl.append("else {\r\n");
	sbl.append(" c.setCellStyle(styleleft);\r\n");
	sbl.append("}\r\n");
    sbl.append("c.setCellValue(rezu.replaceAll(\"<br>\",\"\\r\\n\").replaceAll(\"\\\\<[^>]*>\",\"\"));\r\n");
   
 //  sbl.append(" c.setEncoding((short)HSSFCell.ENCODING_UTF_16);\r\n");
    
     sbl.append("zapp++;\r\n");
		 
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
			sbl.append("@import \"barve.css\";\r\n");
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
	sbl.append(tml.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp<////%=(nul.jeNull(request.getQueryString()).equals(\"\")?\"\":\"?\"+nul.jeNull(request.getQueryString()))%////>';\r\n");

//	sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+"+'<////%=nul.jeNull(request.getParameter(\"nipost\")).equals(\"da\")?\"\":\"?\"+nul.jeNull(request.getQueryString())%////>';\r\n");

		
	}
	
	else if (!nul.jeNull(tml.getTarget_funkcija()).equals("") ) {
		
		sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+"+'<////%=nul.jeNull(request.getParameter(\"nipost\")).equals(\"da\")?\"\":\"?\"+nul.jeNull(request.getQueryString())%////>';\r\n");

		
	}
	
	sbl.append("}</script>\r\n");
	
	sbl.append("</body>\r\n");
	
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 17");

	
	sbl.append("%////>\r\n");
	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_mle.jsp"), "latin1"));



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
	sbl.append("<////%@ page contentType=\"text/html; \" import=\"javax.mail.*,javax.mail.internet.*,javax.activation.*,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
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
				sbl.append("dodpog = (!dodpog.equals(\"\")?\" and \":\"\")+ \""+dodaten_sql_pogoj+"\";\r\n");
				
			
			if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
			sbl.append(" }\r\n");
			}
		}
		
		}
		
		
	}

	sbl.append("String dodaten_sql_pogoj = dodpog;\r\n");
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


	sbl.append("outt.append(\"<body>\");\r\n");



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
			sbl.append("@import \"barve.css\";\r\n");
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
	sbl.append(tml.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp<////%=(nul.jeNull(request.getQueryString()).equals(\"\")?\"\":\"?\"+nul.jeNull(request.getQueryString()))%////>';\r\n");

//	sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+"+'<////%=nul.jeNull(request.getParameter(\"nipost\")).equals(\"da\")?\"\":\"?\"+nul.jeNull(request.getQueryString())%////>';\r\n");

		
	}
	
	else if (!nul.jeNull(tml.getTarget_funkcija()).equals("") ) {
		
		sbl.append(tml.getTarget_funkcija()+"="+tml.getTarget_funkcija()+"+'<////%=nul.jeNull(request.getParameter(\"nipost\")).equals(\"da\")?\"\":\"?\"+nul.jeNull(request.getQueryString())%////>';\r\n");

		
	}
	
	sbl.append("}</script>\r\n");
	
	sbl.append("</body>\r\n");
	
	System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ::: 17");
	
	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_ml.jsp"), "latin1"));



	out3.write(sbl.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
			
	
			}
catch (Exception ec) {
	System.out.println("Napaka pri generaciji mail lista "+ec.toString());
}


	
	
	return "";
	
	
	
}






















public String getFieldHead(String premo,com.popultrade.model.TemplateView tu) {
	try {
		 if (tu.getTemplateClasses().size()>0) {
			 
			 
			 ////////// sestavim pogoje iz PP gumba
			 premo = premo +createPPView(tu);
			 
			 
			 
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
				 premo = premo + "rezu=nul.jeNull(vseb."+tu.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n";
				 premo = premo + "%////>\r\n";
			 }
		 }
	        
	   
		 
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
				com.popultrade.dao.TemplateHeadDAO daothead = (com.popultrade.dao.TemplateHeadDAO)contextUtil2.getBeanDao("templateHeadDAO",this.getServletContext());
				
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
	        	
	        
	        
	    //    premo = premo + "</td>";
	        return premo;
	}
	catch (Exception ex) {
		System.out.println(ex.toString());
	}
	return "";
}







//// search







public String genFieldSE(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {
	//com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	try {
	String premo="";
	
        
        /// pogoji prikaza
        System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111");
        	 /// pogledam, ce ima pogoje
	 
	 if (tu.getTemplateClasses().size()>0) {
		  
		premo = premo + createPP(tu,"templateui");
		 
	 }
	 else {
		 System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 xxx");
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
		 
		 System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP yyyy");
	 }
	
        
        /// pogoji prikaza
        


         System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 666666");
      
        if (nul.jeNull(tu.getVnos_kdaj()).equals("BO") || nul.jeNull(tu.getVnos_kdaj()).equals("UP") || nul.jeNull(tu.getVnos_kdaj()).equals("AJ")  || nul.jeNull(tu.getVnos_kdaj()).equals("IN") ) {
        	
        	
        	if (!nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).equals("")) {
 		premo = premo + "<////%\r\n\r\n";
          		
        		premo = premo + nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).replaceAll("\'","\"")+"\r\n";
        		
          		premo = premo + "%////>\r\n";
        	}
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
        	
        	  System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 777777");
        	
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
        		//	dodc =  " onkeyup=\"javascript:this.value=this.value.toUpperCase();\" ";
        		}
        		
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("") && nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  readonly type=\"text\" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  style=\"border: 0px solid #D2EAFF;background-color:#D2EAFF;font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+">\r\n";
        	
        	
        	}
        	else {
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
        		//premo = premo + "<input type=\"text\" value=\"<////%=rezu%////>\"   "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  style=\"font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" ><img src='call.gif' border='0'></a> \r\n";
        		premo = premo + "<input type=\"text\"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIExVC\" ":" class=\"inputIEx\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\"><img src='call.gif' border='0'></a> \r\n";
        		
        		
        		}
        		else {
        			
        		
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\"text\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  "+(novajax?"":ajaxpolje)+"  value=\"<////%=rezu%////>\">\r\n";
            				
        			}
        			else {
        			premo = premo + "<input type=\"text\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"   "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  "+(novajax?"":ajaxpolje)+"  value=\"<////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")%////>\">\r\n";
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
        	
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"text\" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=A"+tu.getId()+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\"><img src='call.gif' border='0'></a> ";
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"text\" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"   maxlength=\'5\' size=\'6\' value=\"<////%=B"+tu.getId()+"%////>\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" >";
	        	
        	}
        	}
        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
        		/// nujno dodati v insert pogoje
        		
        		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
        		
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  >";
                	
        		}
        		else {
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\").equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"   >";
                		
        		}
        		}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
        		/// nujno dodati v insert pogoje
        		String cols = nul.jeNull(tu.getCols());
        		String rows = nul.jeNull(tu.getRows());
        		
        		premo = premo + "<textarea "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\")%////></textarea>";
        	}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
          		
          		 System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 1213412");
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
        		}
        		else {
        			
        			 System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 101");
        			premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(nul.jeNull(tabi).equals("")?"":"tabindex=\'"+nul.jeNull(tabi)+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
        			System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 102");	
        		}
          		
          		 System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1");
          		premo = premo + "<option></option>";

          	/// kontrola hintov, ce ima dodam opcije
          	if (tu.getTemplateClassClass()!=null && tu.getTemplateClassClass().getClass_name()!=null) {
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 103");
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
          		
          		
          		
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 104");
          		
          		String clna = tu.getTemplateClassClass().getClass_name();
          		premo = premo + "<////%\r\n";
          		
          		premo = premo + "if (true "+dodaten+") {\r\n";
          		premo = premo + "com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n";

          		premo = premo + "com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n";

          		
          		//// vrednosti
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 105");
          		Iterator ikov = tu.getTemplateClassClass().getTemplateClasss().iterator();
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 106");
          		Hashtable meto = templateUtil.getClassMetodeImenaHTGet(clna);
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 107");
          		while (ikov.hasNext()) {
          		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
          		
          		if (!nul.jeNull(tcc.getIme_pogoja()).equals("") && meto.containsKey(nul.jeNull(tcc.getIme_pogoja()))) {
          		
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1071");
				String rett=tcc.getVrednost_pogoja().replaceAll("\'","\"")+"+\"\"";
				System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1072");
				if (((String)meto.get(nul.jeNull(tcc.getIme_pogoja()))).indexOf("Long")!=-1) {
					
					System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1073");
					
					rett = "new Long("+rett+")";
					
					
					
				}
				else if (((String)meto.get(nul.jeNull(tcc.getIme_pogoja()))).indexOf("int")!=-1 || ((String)meto.get(nul.jeNull(tcc.getIme_pogoja()))).indexOf("Integer")!=-1) {
					System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1074");
				
					rett = "Integer.parseInt("+rett+")";
					
				}
				else if (((String)meto.get(nul.jeNull(tcc.getIme_pogoja()))).indexOf("Double")!=-1) {
					System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1075");
					
					rett = "Double.parseDouble("+rett+")";
				}
				
				System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1076");
				
          		
          		
          		premo = premo + "mod"+clna+"."+nul.jeNull(tcc.getIme_pogoja())+"("+rett +");\r\n";
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 1077");
          		}
          		}
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 108");
          		
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
          		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 109");
          		
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
          		
          	System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 2");
          	
          		
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
          	
          	
          	
          	
        	 System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 888889");
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
          		
          		//premo = premo + "<////%=rezu%////>\r\n";
          		
          		
          		premo = premo + "<////%\r\n}\r\n";
          		premo = premo + "%////>\r\n";
          		
          		
        	}
        	System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 3");
        		
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
				
				 premo = premo + "<img "+wi+"  "+he+" src='"+thead.getHead_class_name().toLowerCase()+"_ob"+thead.getId()+".jsp?id=<////%=vseb.getId()%////>' border='0' >;\r\n";
				
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
        		
        	//	premo = premo + "<////%=rezu%////>\r\n";
        		
        	}
        System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP 1111 222 4");
	
	return premo;
	}
	
	catch (Exception ex) {
		System.out.println("Napaka pri gen field :" + ex.toString());
	}
	
	return "";
	
}








//// end search














public String genFieldPredhodenPage(com.popultrade.model.TemplatePP tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {

	String premo="";
	 if (tu.getTemplateClasses().size()>0) {
		  
		 Iterator iteb = tu.getTemplateClasses().iterator();
		 premo = premo + "<%\r\n";
		 premo = premo + "rezu=\"\";\r\n";
		 
		// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
	
		// nul.getDatumFormatFromDate()
		 while (iteb.hasNext()) {
			 
			 
			 premo = premo + createPP(tu,"templatepp");
			 
		 }
		 
		 premo = premo + "%////>\r\n";
		 
		 
		 
		 
	 }
	return premo;
	
}





public String genField(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {
	//com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	try {
	String premo="";
	
        
        /// pogoji prikaza
        
        	 /// pogledam, ce ima pogoje
	 
	 if (tu.getTemplateClasses().size()>0) {
		 
		 
		 if (!nul.jeNull(tu.getTip_inserta()).equals("file")) {
		 premo = premo + createPP(tu,"templateui");
		 }
		 
		 
	 }
	 else {
		  if (!nul.jeNull(tu.getTip_inserta()).equals("file")) {
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
  else if (nul.jeNull(tu.getTip_inserta()).equals("file") ) {
        		
        		String inum = "file";
        		
        		
        		
        		String dodc = "";
        		
        	
        	
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		String imecb = "";
        			premo = premo + "<table cellpadding=0 cellspacing=0  style=\" font-family:Verdana; font-size:8pt\" ><tr><td>\r\n";
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\""+inum+"\"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"    "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"   "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"    style=\"border: 0px solid #D2EAFF;font-family: Verdana; font-size: 8pt;\" >\r\n";
            				imecb = nul.jeNull(tu.getParameter_drugo_ime());
        			}
        			else {
        			premo = premo + "<input type=\""+inum+"\"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"    "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"  "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"   style=\"border: 0px solid #D2EAFF;font-family: Verdana; font-size: 8pt;\"   onblur=\"change(this,'white');\"  >";
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
        				premo = premo + "<input type=\""+inum+"\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"    "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+"  onblur=\"change(this,'white');\"   value=\"<////%=rezu%////>\">\r\n";
            				
        			}
        			else {
        			premo = premo + "<input type=\""+inum+"\" "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"     onblur=\"change(this,'white');\" >\r\n";
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
			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  readonly type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  style=\"border: 0px solid #D2EAFF;background-color:#D2EAFF;font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" >\r\n";
        	}
        	else {
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
        		premo = premo + "<input type=\""+inum+"\"  "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\"><img src='call.gif' border='0'></a> \r\n";
        		}
        		else { 
        			
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\""+inum+"\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"   "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"   value=\"<////%=rezu%////>\">\r\n";
            				
        			}
        			else {
        			premo = premo + "<input type=\""+inum+"\" "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  >\r\n";
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
        	
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=A"+tu.getId()+"%////>\" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  "+ajaxpolje+"> <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\"><img src='call.gif' border='0'></a> ";
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"   maxlength=\'5\' size=\'6\' value=\"<////%=B"+tu.getId()+"%////>\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  >";
	        	
        	}
        	}
        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
        		/// nujno dodati v insert pogoje
        		
        		
        		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
        			
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"    value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" >";
            			
        		}
        		else {
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" >";
        		}
        		}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
        		/// nujno dodati v insert pogoje
        		String cols = nul.jeNull(tu.getCols());
        		String rows = nul.jeNull(tu.getRows());
        		
        		premo = premo + "<textarea "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=rezu%////></textarea>";
        	}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
          		//System.out.println("XXXXXXXXXXXXXXXXXXXXXXX--------XXXXXXXXXXXXXXXXXXX");
          		
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
          		}
        		else {
        			premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
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
				
				
				
          		
          		
          		premo = premo + "mod"+clna+"."+tcc.getIme_pogoja()+"("+rett +");\r\n";
          		
          		}
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
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" ><////%=nul.jeNull(modi"+clna+"."+vrednost+"())%////></option>;\r\n";
          		}
          		else {
          			premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" <////%=nul.jeNull(modi"+clna+"."+sifra+"()).equals(nul.jeNull(vseb."+tu.getStolpec_metoda()+"()))?\"selected\":\"\"%////>><////%=nul.jeNull(modi"+clna+"."+vrednost+"())%////></option>;\r\n";
              		
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






public String getAjaxPP(com.popultrade.model.TemplatePP tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,String ime_field) {
	com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();
	
	String premos="";
	
 
	
	if (tu.getTemplateDD()!=null && tu.getTemplateDD().getId()!=null) {
		
		

		//System.out.println("-----------------------------"+tu.getTemplateClassClass().getTemplateClasss().size());
		
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
		if (!nul.jeNull(tu.getTemplateDD().getHead_select_dodatni_pogoji()).equals("")) {
			order_by = nul.jeNull(tu.getTemplateDD().getHead_select_dodatni_pogoji());
		}
		
		String dodaten_HQL = "";
		
		premos = premos + "String dod_hql=\"\";\r\n";
		
		if (nul.jeNull(tu.getTemplateDD().getUporabi_dodaten_hql_pogoj()).equals("1")) {
			dodaten_HQL = "sss";
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


		premos = premos + "String rezu_format=\"\";\r\n";
		premos = premos + "if (remix.size()>0) {\r\n";
		
		
		
 		sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tu.getTemplateDD().getId());
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
		

		try {
		/// shranim file za ajax
		if ((tu.getTemplateDD().getStatus()).equals("1")) {
		Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"), "latin1"));



		out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
		////zaprem writer3
		out3.close();
		String velike_crke = "";//nul.jeNull(tu.getSamo_velike_crke());
		
		return "  autocomplete=\"off\" onfocus=\"ajax_options_hide();change(this,'yellow');"+"setKlici(this,1);\"  onfocsus=\"ajax_options_hide();change(this,'yellow');"+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"','0')}\"  onclick=\"setKlici(this,2);\" onkeyup=\""+" if (doll('"+ime_field+"')){ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"','0')}\" ";
		}
		}
		catch (Exception exx) {
			System.out.println("NAPAKA AJAX::: "+exx.toString());
		}
		
	}
	return "";
	 
	
}















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
else if (sif.getHead_tip().equals("PD")) {
	predpo="_pdf"+sif.getId();
}
else if (sif.getHead_tip().equals("LI")) {
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
//// kreacija jsp za list
if (sif.getHead_tip().equals("OB")) {

	
	System.out.println("Izdelujem OB jsp");

	//// odstranim iz cache
	
	if (ConPool.cache.containsKey("jsp"+sif.getId()+control.getJezik())) {
		ConPool.cache.remove("jsp"+sif.getId()+control.getJezik());
	}

///// dodatni pogoji, v javi
com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();

com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());

tuidd = daouid.getTemplateUiDodatnos(idpr);




	 String parametriSE = ""; // parametri za search, parmetri ki setirajo stran ostevilcenje ker qurystring je kot post

sb.append("<////%@ page trimDirectiveWhitespaces=\"true\"  contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.net.URLDecoder\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<////jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");
sb.append("<////%!\r\n");

sb.append("com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();\r\n");
sb.append("public void displayObject(HttpServletResponse resp,HttpServletRequest request,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,com.popultrade.webapp.control control) {\r\n");




sb.append("try {\r\n");   
		
	
		
		

// get list from daoobject
sb.append("com.popultrade.dao."+imefile +"DAO dao = (com.popultrade.dao."+imefile +"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length()) +"DAO\",servletContext);\r\n");


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
		sb.append("lis = dao.get"+imefile +"s(sif,1,1,dodaten_sql_pogoj,orderby,orderbysmer);\r\n");
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
		sb.append("resp.setContentType(\""+tem.getBaza_content_type()+"\");\r\n");
		
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
		
		}
		
		
		
		sb.append("resp.setHeader(\"Content-Disposition\",\"attachment;filename="+filn+"\");\r\n");
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
sb.append("////request.setCharacterEncoding(control.encoding);\r\n");
sb.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("////response.addDateHeader(\"Expires\", 0);\r\n");
sb.append("////if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
sb.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");

	
sb.append("<////% displayObject(response,request,contextUtil,pageContext.getServletContext(),control); %////>\r\n");



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
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,\"\",new Date(),3);\r\n");

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
sb.append("com.popultrade.dao."+imefile +"DAO dao = (com.popultrade.dao."+imefile +"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length()) +"DAO\",pageContext.getServletContext());\r\n");


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
sb.append("com.popultrade.dao."+imefile+"DAO daokont = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");

sb.append("vsebkont = daokont.get"+imefile+"(new Long(request.getParameter(\"id\")));\r\n");

sb.append("if (vsebkont!=null && vsebkont.getId()!=null) {\r\n");

//sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("control.geet", "control.get")+") {\r\n");
sb.append("if ("+dgum.getDodaten_hql_pogoj().replaceAll("\'", "\"").replaceAll("getTime", "geetTime").replaceAll("request.get", "request.geet").replaceAll("control.get", "control.geet").replaceAll("get", "vsebkont.get").replaceAll("request.geet", "request.get").replaceAll("geetTime", "getTime").replaceAll("control.geet", "control.get")+") {\r\n");


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
sb.append("dao.remove"+imefile +"(new Long(request.getParameter(\"id\")));\r\n");


//// dodatno klicem update zaporednih stevilk


if (sif.getTemplateUiDodatno()!=null && sif.getTemplateUiDodatno().getDodatno_delete()!=null && !sif.getTemplateUiDodatno().getDodatno_delete().equals("")) {

	sb.append("dao.remove"+imefile+"resetZapst(\""+sif.getTemplateUiDodatno().getDodatno_delete()+"\",request.getParameter(\"zapst\"));\r\n");

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


sb.append("session.setAttribute(\""+imefile.toLowerCase() +"_search\",sif);\r\n");

sb.append("}\r\n");
sb.append("else if (nul.jeNull(request.getParameter(\"isk\")).equals(\"1\")) {\r\n");
sb.append("iskanje = true;\r\n");
sb.append("sif = (com.popultrade.model."+imefile +")session.getAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");

sb.append("}\r\n");
sb.append("else {\r\n");

sb.append("session.removeAttribute(\""+imefile.toLowerCase() +"_search\");\r\n");
sb.append("}\r\n");















sb.append("List lis =null;\r\n");



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

sb.append("A:hover{color:red}\r\n");
sb.append("#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}\r\n");
sb.append("DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;\r\n");
sb.append("background-color:Silver; layer-background-color:2686D8}\r\n");
sb.append("</style>\r\n");
sb.append("<link type='text/css' href='styles/basic.css' rel='stylesheet' media='screen' />\r\n");
sb.append("<link type='text/css' href='styles/basic_ie.css' rel='stylesheet' media='screen' />\r\n");


sb.append("<style type=text/css>\r\n");

sb.append("@import \"barve.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"js/jquery.contextmenu.css\";\r\n");
sb.append("</style>\r\n");




sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"tooltip.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"js/jquery.contextmenu.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
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

sb.append("function chg() {\r\n");




sb.append(" <////%\r\n");
sb.append("if (request.getParameter(\"idback\")!=null && !request.getParameter(\"idback\").equals(\"null\") && !request.getParameter(\"idback\").equals(\"\")) {\r\n");
sb.append("%////>\r\n");
sb.append("kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(document.getElementById(\"sprememba\"),document.getElementById(\"sprememba\").className);\r\n");
sb.append("window.scroll(1,document.getElementById(\"sprememba\").offsetTop-15);\r\n");

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
 if (!nul.jeNull(sif.getStruktura_tree()).equals("1")) {
sb.append("<body  style=\"margin: 0\"   background=\"podlaga.jpg\" bgproperties=\"fixed\"  onLoad=\"chg();resHead()\" >\r\n");
}
else {
sb.append("<body  style=\"margin: 0\"   background=\"podlaga.jpg\" bgproperties=\"fixed\"  onLoad=\"chg()\" >\r\n");
}

// loading overlay okno
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

sb.append("<table id=\"table1\"   width=100% cellspacing=1  style=\" font-family: Verdana; font-size: 7pt\">\r\n");
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
      barv[0]="ADD9FF";
      barv[1]="D2EAFF";
      
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
     		
     		
             if (bar==2) {
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
sbh.append("<th class=\""+(nul.jeNull(tli.getStolpec_fiksen()).equals("1")?"cmenu4":"cmenu3")+"\" id=\"th"+tli.getId()+"\" align=\""+tli.getStolpec_align()+"\" bgcolor=\""+barv[bar] +"\" < %=dodo.replaceAll(\"XXX\",spp[1])%////> onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(p"+tli.getId()+")\">");
if (nul.jeNull(tli.getStolpec_order()).equals("1")) {
sbh.append("<a href=\"#\" onclick=\"document.location='"+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?<////%=!iskanje?\"\":\"isk=1&\"%////>orderup="+tli.getStolpec_metoda().replaceAll("get","").toLowerCase()+"&orderupsmer=< %=(nul.jeNull(request.getParameter(\"orderupsmer\")).equals(\"asc\")?\"desc\":\"asc\")%////>&<////%=request.getQueryString()%////>';return false;\"  style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\">");
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
              
   
sbh.append("<th  bgcolor=\"D2EAFF\" align=center ----REPLACEMENUUP---- ><span id='res009'>\r\n");
             

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
		 
		 
		 if (tli.getUrl_gumba().equals("vnos.gif") && tli.getLokacija_gumba().equals("H")) {
			 b=1;
		 }
		 
    	 
     }
     
     if (a==1 && b==1) {
    	 jepredpona=true;
     }
     
     
     itbg = ling.iterator();
     
     while (itbg.hasNext()) {
    	
    	 com.popultrade.model.TemplateGumbi tli = (com.popultrade.model.TemplateGumbi)itbg.next();
 		 String target = "'";
 		 /// dobim parametre , ki dodam gumbu
 		 
 		 Iterator igy = tli.getTemplateGumbiParametris().iterator();
 		 

 		 
		 String predpo = "";
		 String targetv = imefile;
		 
		 String predpage = ""; /// v primeru da ima predpage
		 
	
		 
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
				 else if (therd.getHead_tip().equals("HE")) {
				 	predpo="_view";
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
				 
			 if (nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("")) {
				 parametri = parametri + "&"+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
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
 		 
		 if (tli.getTarget_gumba().equals("0")) {
			 target = "parent.frames[0].location='";
		 }
		 else  if (tli.getTarget_gumba().equals("1")) {
			 target = "parent.frames[1].location='";
		 }
		 else  if (tli.getTarget_gumba().equals("2")) {
			 target = "parent.frames[2].location='";
		 }
		 else  if (tli.getTarget_gumba().equals("3")) {
			 target = "parent.frames[0].location='frameinr_";
		 }
		 else  if (tli.getTarget_gumba().equals("4")) {
			 target = "parent.frames[1].location='frameinr_";
		 }
		 else  if (tli.getTarget_gumba().equals("5")) {
			 target = "parent.frames[2].location='frameinr_";
		 }	 
		 else  if (tli.getTarget_gumba().equals("6")) {
			 target = "parent.frames[0].location='frameinc_";
		 }
		 else  if (tli.getTarget_gumba().equals("7")) {
			 target = "parent.frames[1].location='frameinc_";
		 }
		 else  if (tli.getTarget_gumba().equals("8")) {
			 target = "parent.frames[2].location='frameinc_";
		 }
		 
		 else  if (tli.getTarget_gumba().equals("B")) {
			 target = "window.open('";
		 }
		 
		 String alert = "";
		 
		 if (nul.jeNull(tli.getUporabi_alert()).equals("1")) {
			 alert = "vprasaj('< %=ConPool.getPrevod(\""+tli.getId()+"D\"+control.getJezik())%////>','"+(nul.jeNull(tli.getOnemogoci_gumbe()).equals("1")?"1":"0")+"','009')?";
		 }
		 
		 
		 if (tli.getTemplateClass()!=null && !tli.getLokacija_gumba().equals("V") && !tli.getLokacija_gumba().equals("Z") && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")  && (nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).indexOf("request.getParameter")!=-1 || nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).indexOf("control.get")!=-1)) {
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
			 
		 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1") && tli.getLokacija_gumba().equals("H")) {
			 
			 sbh.append("<span id='"+nul.jeNull(tli.getPrikazi_gumb_ime())+"' style='display:<////%=!napr?\"none\":\"inline\"%////>'>");
			 
		 }
			 
    	 if (tli.getUrl_gumba().equals("vnos.gif") && tli.getLokacija_gumba().equals("H")) {
    	
			 if (jepredpona) {
				 predpage = "_p";
			 }
			 
    	 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+targetv.toLowerCase() +"_edit"+upid+predpage+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\"vnos.gif\" /></a>\r\n");
    	
    	 
    	 }
    	 
    	 else if (tli.getUrl_gumba().equals("search.gif") && tli.getLokacija_gumba().equals("H")) {	 
    		 
    	 parametriSE = parametri;
        	 sbh.append("<a href=\"#\"  onClick=\""+alert+""+target+targetv.toLowerCase() +"_isci"+seidi.get(targetv.toLowerCase())+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\"search.gif\" /></a>\r\n");
        	 
    	 
    	 
    	 }
    	 else if (tli.getLokacija_gumba().equals("H")){
    		 
    		    if (!nul.jeNull(tli.getRocni_url()).trim().equals("")) {
    		    	if (tli.getTarget_gumba().equals("B")) {
    		    		 sbh.append("<a  href=\"#\"  onclick=\""+target+nul.jeNull(tli.getRocni_url())+"?opcija=new"+parametri+"');return false;\" ><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
    		    	    	
    		    	
    		    	 }
    				 else {
    		    	 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+nul.jeNull(tli.getRocni_url())+"?opcija=new"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
    				 }	
    		    }
    		    else {
    		 if (tli.getTarget_gumba().equals("B")) {
    		 sbh.append("<a  href=\"#\"  onclick=\""+target+targetv.toLowerCase() +predpo+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"');return false;\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
    		 }
    		 else {
    			 
    			 if (nul.jeNull(tli.getVrednosti_iz_checkbox()).equals("1")) {
        			 je_check_box = "<form name='dod' method='post' action='"+targetv.toLowerCase() +predpo+".jsp?jemulticheckbox=da"+parametri+"'>";
        			 sbh.append("<a href=\"#\" onClick=\""+alert+"document.dod.submit()"+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
         			
        		 }
    			 else {
    			 sbh.append("<a href=\"#\" onClick=\""+alert+""+target+targetv.toLowerCase() +predpo+".jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
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
    		 menu_mouse = menu_mouse + "\r\n'< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>':{onclick:function(menuItem,menu) {  "+alert+""+target+targetv.toLowerCase() +predpo+".jsp?idre=56'+ document.getElementById(\'M"+tli.getId()+"_\'+this.id).value"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+"; } ,icon:'"+nul.jeNull(tli.getUrl_gumba())+"'},";
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
    		 menu_mouse_hint = menu_mouse_hint + "\r\n'< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>':{onclick:function(menuItem,menu) {  "+alert+""+target+targetv.toLowerCase() +predpo+".jsp?idre=56'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+"; } ,icon:'"+nul.jeNull(tli.getUrl_gumba())+"'},";
    		 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
    			 menu_mouse_hint = menu_mouse_hint + "<%}%////>"; 
    		 }
    		 
    		 }
    	 
	 if (nul.jeNull(tli.getPrikazi_gumb_z_js()).equals("1")) {
			 
			 //sbh.append("</span>");
			 
		 }
    	 
    	 if (tli.getTemplateClass()!=null && !tli.getLokacija_gumba().equals("V")  && !tli.getLokacija_gumba().equals("Z") && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("") && (nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).indexOf("request.getParameter")!=-1 || nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).indexOf("control.get")!=-1)) {
    				 sbh.append("<%\r\n"); 
			 sbh.append("}\r\n"); 
			 sbh.append("\r\n%////>\r\n"); 
		 }
    	 
     }

                



//deploy_kam+imefile.toLowerCase()+"_ml.jsp"

if (sif.getTemplatemaillist()!=null && sif.getTemplatemaillist().getUporabi()!=null && sif.getTemplatemaillist().getUporabi().equals("1")) {
	 sbh.append("<%\r\n"); 
	 sbh.append("if ((nul.jeNull(request.getParameter(\"isk\")).equals(\"1\") || nul.jeNull(request.getParameter(\"isci\")).equals(\"yes\")) && !nul.jeNull(control.getEmail()).equals(\"\")) {\r\n"); 
	 
	 sbh.append("String vrsticaa = \"\";\r\n");
	 sbh.append("if (nul.jeNull(request.getQueryString()).equals(\"\")) {\r\n");
	 
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
	 
	 sbh.append("\r\n%////>\r\n"); 
	
	 sbh.append("<a href=\"#\"   onClick=\"oknoShow();"+sif.getTemplatemaillist().getTarget_frame()+"='"+imefile.toLowerCase()+"_ml.jsp"+"?opcija=new&siframm=new&sifrant=f&isk=1&novo=<////%=nul.jeNull(request.getParameter(\"novo\"))%////><%////=vrsticaa.equals(\"\")?\"&nipost=da\":vrsticaa%////>"+parametriSE+"';return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+sif.getId()+"K\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+sif.getTemplatemaillist().getUrl_gumb()+"\" /></a>\r\n");
		
	if (sif.getTemplatemaillist().getUporabi_excel()!=null && sif.getTemplatemaillist().getUporabi_excel().equals("1")) {
			 sbh.append("<a href=\"#\"   onClick=\"oknoShow();"+sif.getTemplatemaillist().getTarget_frame()+"='"+imefile.toLowerCase()+"_mle.jsp"+"?opcija=new&siframm=new&sifrant=f&isk=1&novo=<////%=nul.jeNull(request.getParameter(\"novo\"))%////><%////=vrsticaa.equals(\"\")?\"&nipost=da\":vrsticaa%////>"+parametriSE+"';return false;\" href=\"Javascript: PGAPP()\"><img title=\"Excel send\" border=\"0\" src=\"e.gif\" /></a>\r\n");
		
		
		}
		
	 sbh.append("<%\r\n"); 
	 sbh.append("}\r\n"); 
	 sbh.append("\r\n%////>\r\n"); 
	
	
}




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

sb.append("<////%}\r\n%////>\r\n");

//sb.append("<////%}%////>\r\n"); /// konec jehead kontrole  ---------------------------------------------------------------
sb.append("</div>\r\n");
























//// druga tabela


sb.append("<table id=\"table2\"   width=100% cellspacing=1  style=\" font-family: Verdana; font-size: 7pt\">\r\n");

sb.append("<////%if (!nul.jeNull(request.getParameter(\"jehead\")).equals(\"1\")) {%////>\r\n");


sb.append(sbh.toString());

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
sb.append("int br = 0;\r\n");
sb.append("String oe_kup_nap = \"\";\r\n");


sb.append("Iterator it = lis.iterator();\r\n\r\n");

sb.append("String rezu=\"\";\r\n\r\n");

sb.append("String[] colss = stolpci.split(\"---\");\r\n");


sb.append("while (it.hasNext()){  // while start\r\n");

sb.append("com.popultrade.model."+imefile +" vseb = (com.popultrade.model."+imefile +")(it.next());\r\n");
sb.append("stvrstic++;\r\n");

sb.append("if (br==2){\r\n");
 sb.append(" br=0;\r\n");
sb.append("}\r\n");
sb.append("if (prisotnost.users.containsKey(nul.jeNull(vseb.getId()+\"\"))) {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"green\"  >\r\n");
sb.append("////<%\r\n");
sb.append("}\r\n");
sb.append("else if (vseb.getId().toString().equals(nul.jeNull(request.getParameter(\"idback\")))) {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"<////%=colors[br]%////>\" id=sprememba onMouseOver=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"rollOver2":"rollOver")+"')\" onMouseOut=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>')\">\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"<////%=colors[br]%////>"+(!menu_mouse.equals("")?" cmenu2":"")+"\"  id=\"<////%=vseb.getId()%////>\"   onMouseOver=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"rollOver2":"rollOver")+"')\" onMouseOut=\"colors"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>')\">\r\n");
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
		 
		 sb.append(this.createPP(tli, "templatelist")+"\r\n");
		  
		 
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
		 sb.append("if (sifhint.containsKey(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")))) {\r\n");
		 sb.append("sifhintp.put(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")),sifhint.get(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))));\r\n");
		 sb.append("}\r\n\r\n");
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
	 
	 
	 
	 if (nul.jeNull(tli.getStolpec_checkbox()).equals("1")) {
		 sb.append("<td width=\""+tli.getStolpec_width()+"\" align=\""+tli.getStolpec_align()+"\" "+hinto+"><input type='checkbox' value='< %=rezu%////>' name='"+tli.getStolpec_metoda().toLowerCase().replaceAll("get","")+"____< %=rezu%////>'  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\" ></td>\r\n");
		 
	 }
	 else {
		 String doddiv = "";
		if (nul.jeNull(tli.getUporabi_div_vrednost()).equals("1")) {
			doddiv = "<span id=\""+tli.getUporabi_div_ime()+"<////%=vseb.getId()%////>\">";
		}
		 
		 
	 
	 sb.append("<td width=\""+tli.getStolpec_width()+"\" align=\""+tli.getStolpec_align()+"\" "+hinto+">"+doddiv+"\r\n\r\n");
	 
	 
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
				
				 sb.append("<img "+wi+"  "+he+" src='"+thead.getHead_class_name().toLowerCase()+"_ob"+thead.getId()+".jsp?id=<////%=vseb.getId()%////>' border='0' >\r\n");
				
				}

			}
			else {
		 sb.append("<img "+wi+"  "+he+" src='<////%=control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu%////>' border='0' >\r\n");
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


     sb.append(doddiv+"</td>\r\n");
     
     
     
     
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


sb.append("<td  align=\"center\"><span id='res<////%=vseb.getId()%////>'>\r\n");


sb.append("<////%\r\n");

sb.append("if (!prisotnost.users.containsKey(nul.jeNull(vseb.getId()+\"\"))) {\r\n");
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
	 if (tli.getTarget_gumba().equals("0")) {
		 target = "parent.frames[0].location='";
	 }
	 else  if (tli.getTarget_gumba().equals("1")) {
		 target = "parent.frames[1].location='";
	 }
	 else  if (tli.getTarget_gumba().equals("2")) {
		 target = "parent.frames[2].location='";
	 }
	 else  if (tli.getTarget_gumba().equals("3")) {
		 target = "parent.frames[0].location='frameinr_";
	 }
	 else  if (tli.getTarget_gumba().equals("4")) {
		 target = "parent.frames[1].location='frameinr_";
	 }
	 else  if (tli.getTarget_gumba().equals("5")) {
		 target = "parent.frames[2].location='frameinr_";
	 }	 
	 else  if (tli.getTarget_gumba().equals("6")) {
		 target = "parent.frames[0].location='frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("7")) {
		 target = "parent.frames[1].location='frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("8")) {
		 target = "parent.frames[2].location='frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("B")) {
		 target = "window.open('";
	 }
	 
	 /// dobim parametre , ki dodam gumbu
	 
	 Iterator igy = tli.getTemplateGumbiParametris().iterator();
	 
	 String parametri = "";
	 
	 while (igy.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)igy.next();
		 
		 if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
			// parametri = parametri + "&"+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 parametri = parametri + "&"+(!nul.jeNull(tgpp.getDugacno_ime_parametra()).trim().equals("")?nul.jeNull(tgpp.getDugacno_ime_parametra()).trim():(nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
				
		 }
		 
		 else if (nul.jeNull(tgpp.getStolpec_metoda()).startsWith("'") || nul.jeNull(tgpp.getStolpec_metoda()).startsWith("\"")) {
			 parametri = parametri + "&"+nul.jeNull(tgpp.getDugacno_ime_parametra()).trim()+"="+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","").replaceAll("\"","")+"";
				
		 }
		 
		 else {
		 parametri = parametri + "&"+(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))+"=< %=vseb."+tgpp.getStolpec_metoda()+"()%////>";
		 }
	 
	 }
	 
	 
	 if ( tli.getLokacija_gumba().equals("Z")&& !jestartvrstice ) {
		 jestartvrstice = true;
		 sb.append("<!--PLUSS--><br><span  id='vrst<////%=vseb.getId()%////>' style='display:none'>");
		 
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
				 else if (therd.getHead_tip().equals("HE")) {
				 	predpo="_view";
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
				alert = nul.jeNull(tli.getUporabi_alert_fun()).replaceAll("[ALERT]","'< %=ConPool.getPrevod(\""+tli.getId()+"J\"+control.getJezik())%////>'")+"?";
				
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
		 
	
		 
		 
		 if (!nul.jeNull(tli.getRocni_url()).trim().equals("") && (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {	 
			 if (tli.getTarget_gumba().equals("B")) {	 
		 sb.append("<a  href=\"#\"  onclick=\""+deljs+alert+""+target+nul.jeNull(tli.getRocni_url())+""+parametri+"');return false;\" ><img onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\"  title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\""+urlg+"\" "+del1+" /></a>\r\n");

	    	 }
			 else {
	    	 sb.append("<a href=\"#\" onClick=\""+alert+""+target+nul.jeNull(tli.getRocni_url())+""+parametri+"'"+(target.indexOf("window")!=-1?")":"")+(!alert.equals("")?":''":"")+";return false;\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"  onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" border=\"0\" src=\""+tli.getUrl_gumba()+"\" /></a>\r\n");
			 }	
		 }
		 else	 if (tli.getUrl_gumba().equals("x.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z")) && nul.jeNull(tli.getKlici_funkcijo()).equals("Brisi")) {	 
		 
	
			 
		 sb.append("<a onClick=\"return vprasaj2('< %=ConPool.getPrevod(\""+tli.getId()+"D\"+control.getJezik())%////>','"+(nul.jeNull(tli.getOnemogoci_gumbe()).equals("1")?"1":"0")+"','<////%=vseb.getId()%////>','"+targetv.toLowerCase()+"_list"+sif.getId() +".jsp?akcijaXY=DELETE&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"')\" href=\""+targetv.toLowerCase()+"_list"+sif.getId() +".jsp?akcijaXY=DELETE&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"\"><img src=\"x.gif\" border=0 title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");
		
 
		 
	 }
	 
	 else if (tli.getUrl_gumba().equals("h.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z")) && nul.jeNull(tli.getKlici_funkcijo()).equals("Brisi")) {
		 
		 
		 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+"_view.jsp?opcija=spremeni&siframm=new&idback=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+";"+deljs+"return false;\"><img src=\""+urlg+"\" border=0 "+del1+" onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 else if (tli.getUrl_gumba().equals("u.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {
		 
		 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+(predpo.indexOf("_p")==-1?predpo:predpo.substring(0,predpo.indexOf("_p")))+".jsp?opcija=spremeni&siframm=new&idback=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+";"+deljs+"return false;\"><img src=\""+urlg+"\" "+del1+" border=0 onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 else if (tli.getUrl_gumba().equals("i.gif") &&  (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {
		 
		 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+";"+deljs+"return false;\"><img src=\""+urlg+"\" "+del1+" onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\"  border=0 onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 
	 else if ( (tli.getLokacija_gumba().equals("V") || tli.getLokacija_gumba().equals("Z"))) {

		 if (tli.getTarget_gumba().equals("B")) { /// ce je blank
			 sb.append("<a target=\"_blank\" href=\"#\" onclick=\""+deljs+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"');return false;\"><img src=\""+urlg+"\" "+del1+" border=0 onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");
				 }
    		 else {
    			 sb.append("<a href=\"\" onClick=\""+alert+""+target+targetv.toLowerCase()+predpo+".jsp?opcija=spremeni&siframm=new&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"'"+(!alert.equals("")?":''":"")+";"+deljs+"return false;\"><img "+del1+" src=\""+urlg+"\" border=0 onClick=\"kliknivSivo"+(nul.jeNull(sif.getStruktura_tree_head()).equals("1")?"2":"")+"(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");
	
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
		 
		 skupaj.append("<a  href=\"#\"  onclick=\"return odpriVrstico('<////%=vseb.getId()%////>')\"><img src=\"od.gif\" border=\"0\" id=\"vimg<////%=vseb.getId()%////>\"></a>");
		 
		 skupaj.append("<%"); 
		 skupaj.append("}\r\n"); 
		 skupaj.append("%////>"); 
		 
		 
	 }
	 ///////////




	 
}





sb.append("<////%\r\n");

sb.append("}\r\n");
sb.append("%////>\r\n");





sb.append("</span></td>\r\n");
sb.append("</tr>\r\n");

/// opcija za tree prikaz

 if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {

sb.append("<tr style='display:none;' id='tr<////%=vseb.getId()%////>'><td style='width:8px'>&nbsp;</td><td colspan='"+(st_stolpcev)+"'><span id=\"pm<////%=vseb.getId()%////>\">\r\n");
 sb.append("</span></td>\r\n");
sb.append("</tr>\r\n");
 }





sb.append("<////%\r\n");
sb.append("br++;\r\n");

sb.append("}/////////////// while end\r\n");


 sb.append("%////>\r\n");
 if (je_check_box!=null && !je_check_box.equals("")) {
		sb.append("</form>\r\n");
		
	}
sb.append("</table>\r\n");
sb.append("<div id=\"popup\" style=\"position:absolute; z-index:1; visibility: hidden\"></div>\r\n");


if (!nul.jeNull(tuidd.getDodatno_insert()).equals("")) {
sb.append("\r\n"+nul.jeNull(tuidd.getDodatno_insert())+"\r\n");
}

sb.append("<script language=javascript>\r\n");


//// opcija ajaxa za tree strukturo, klices iz javascripte z idjem


 if (nul.jeNull(sif.getStruktura_tree()).equals("1")) {


sb.append("function odpriPodList(idpodm,preskoci) {\r\n");
sb.append("if (idpodm==null || idpodm=='' || idpodm=='null') {\r\n");
sb.append("document.location=document.location;\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("if ((document.getElementById(\"pmg\"+idpodm).src+\"\").indexOf(\""+sif.getStruktura_tree_gumbo()+"\")!=-1 || preskoci==1) {\r\n");

sb.append("document.getElementById(\"tr\"+idpodm).style.display=\"\";\r\n");

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

sb.append("document.getElementById(\"pmg\"+idpodm).src=\""+sif.getStruktura_tree_gumbz()+"\";\r\n");

sb.append("}\r\n");
sb.append("else if ((document.getElementById(\"pmg\"+idpodm).src+\"\").indexOf(\"empty.gif\")==-1) {\r\n");

sb.append("document.getElementById(\"pm\"+idpodm).innerHTML=\"\";\r\n");
sb.append("document.getElementById(\"pmg\"+idpodm).src=\""+sif.getStruktura_tree_gumbo()+"\";\r\n");
sb.append("document.getElementById(\"tr\"+idpodm).style.display=\"none\";\r\n");
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
sb.append("<table  border=\"0\" cellpadding=\"7\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family:Verdana; font-size:8pt;\">\r\n");
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
sb.append("<table  border=\"0\" cellpadding=\"7\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family:Verdana; font-size:8pt;\">\r\n");
sb.append("<tr bgcolor=\"ededed\">\r\n");
sb.append("<td align=center >\r\n");
sb.append("Browse page: </td><td>\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=1<////%=iskk%////>\">first</a></td><td>|</td>\r\n");


sb.append("<////%\r\n");
sb.append("int vse=0;\r\n");
sb.append("int ststr=0;\r\n");

sb.append("int prvii=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(\"\")?1:Integer.parseInt(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\");\r\n");

sb.append("if (prvii>1) {\r\n");
sb.append("int prej = prvii-1;\r\n");
sb.append("%////>\r\n");
sb.append("<td>\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">previous</a></td>\r\n");

sb.append("<td>|</td>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");


sb.append("for (int y=0;y<strec;y++) {\r\n");
sb.append("vse++;\r\n");
sb.append("if (vse==stizpisov) {\r\n");
sb.append("vse=0;\r\n");

sb.append("ststr++;\r\n");
sb.append("if ((prvii-5)<ststr && ststr<(prvii+5)) {\r\n");
sb.append("%////>\r\n");
sb.append("<td align=center bgcolor=\"<////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(ststr+\"\")?\"white\":\"ededed\" %////>\"> <a hrefs=\"\" style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=ststr %////><////%=iskk%////>\"><////%=ststr %////></a> </td><td>|</td>\r\n");
sb.append("<////%\r\n");

sb.append("}\r\n");
sb.append("}\r\n");

sb.append("}\r\n");
sb.append("if (vse!=0) {\r\n");
sb.append("%////>\r\n");
sb.append("<td align=center bgcolor=\"<////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(ststr+1+\"\")?\"white\":\"ededed\" %////>\"> <a hrefs=\"\" style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=ststr+1 %////><////%=iskk%////>\"><////%=ststr+1 %////></a> </td><td>|</td>\r\n");
sb.append("<////%\r\n");


sb.append("}\r\n");



sb.append("if (prvii<=ststr) {\r\n");
sb.append("int prej = prvii+1;\r\n");
sb.append("%////>\r\n");
sb.append("<td>\r\n");
sb.append(" <a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">next</a></td>\r\n");

sb.append("<td>|</td>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");



sb.append("<td><a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+"_list"+sif.getId()+".jsp?pagenumber=<////%=ststr+1%////><////%=iskk%////>\">last</a></td>\r\n");
sb.append("<td>|</td>\r\n");
sb.append("<td >\r\n");
sb.append("page: <////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")+\"\").equals(\"\")?\"1\":session.getValue(\"pagenumber"+imefile+""+sif.getId()+"\")%////> of <////%=ststr+1%////> </td>\r\n");
sb.append("<td>|</td>\r\n");
sb.append("<td>\r\n");
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
	pp.append("@import \"barve.css\";\r\n");
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
	
	pp.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
	pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
	
	pp.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
	pp.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
	pp.append("<body   style=\"margin: 0\"   onload=\"mom()\">\r\n");
	
	
	
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

    System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15666");
sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.apache.commons.io.*\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");
sb.append("<////jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");

sb.append("<////%\r\n");
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
sb.append("String napaka=\"\";\r\n");

if (!nul.jeNull(sif.getUporabi_count()).equals("1")) {
sb.append("boolean mum=false;\r\n");


sb.append("if (!nul.jeNull(request.getParameter(\"id\")).equals(\"\")) {\r\n");
sb.append("if (!prisotnost.users.containsKey(nul.jeNull(request.getParameter(\"id\")))) {\r\n");

  ///// brisem iz obdelave, ce je kakega obdeloval
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,\"\",new Date(),3);\r\n");
///// ce ni v obdelavi ga vpisem
//ConPool.narociloVObdelavi(request.getParameter("stevilka_narocila"),control.getUser2(),control.company);
sb.append("prisotnost.addUserNarocilo(control.idUporabnikaLock,request.getParameter(\"id\"),new Date(),1);\r\n");
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
else {
	sb.append("boolean mum=true;\r\n");
}


sb.append("if (mum) {\r\n");

sb.append("com.popultrade.model."+imefile+" vseb =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO dao = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");



if (nul.jeNull(sif.getZacetek_procedure()).trim().equals("")) {
	sb.append("if (request.getParameter(\"id\")!=null && request.getParameter(\"akcijaXY\")==null) {\r\n");
sb.append("vseb = dao.get"+imefile+"(new Long(nul.jeNullDefault(request.getParameter(\"id\"))));\r\n");
}
else {
	
	sb.append("if ("+nul.jeNull(sif.getZacetek_procedure())+"!=null && request.getParameter(\"akcijaXY\")==null) {\r\n");
sb.append("vseb = dao.get"+imefile+"("+nul.jeNull(sif.getZacetek_procedure())+");\r\n");	
}
/////// dobim dodatne opcije
com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());



com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();


tuidd = daouid.getTemplateUiDodatnos(idpr);













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
sb.append("com.popultrade.model."+imefile+" vsebkont =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO daokont = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");

sb.append("vsebkont = daokont.get"+imefile+"(new Long(request.getParameter(\"id\")));\r\n");

sb.append("if (vsebkont!=null && vsebkont.getId()!=null) {\r\n");

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

sb.append("String rezu=\"\";\r\n");
sb.append("vseb = dao.get"+imefile+"(new Long(nul.jeNullDefault(request.getParameter(\"id\"))));\r\n");


sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request);\r\n");


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
	if (nul.jeNull(tuid.getTip_inserta()).equals("checkbox")) {
		//System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII19999522");
		
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
dodaj_upd=dodaj_upd+"Part filePart = request.getPart(\""+nul.jeNull(tuid.getStolpec_metoda()).toLowerCase().replaceAll("get","")+"\");\r\n";

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
 dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(null);\r\n";
 

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
				dodaj_ins=dodaj_ins+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
				//dodaj_upd=dodaj_upd+"dat=\"\";\r\n";
				dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
				
				}
				else if (nul.jeNull(tuid.getVnos_kdaj()).equals("UP")) {
					//dodaj_upd=dodaj_upd+"dat=\"\";\r\n";
				
					dodaj_upd=dodaj_upd+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
					
				}
				else if (nul.jeNull(tuid.getVnos_kdaj()).equals("IN")) {
					
					//dodaj_ins=dodaj_ins+"dat=\"\";\r\n";
					dodaj_ins=dodaj_ins+"vseb."+nul.jeNull(tuid.getStolpec_metoda()).replaceAll("get","set")+"(nul.parseDatumUra("+dodaj_datum_ui+"));\r\n";
					
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




if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_update()!=null && !tuidd.getDodatno_update().equals("")) {
	
	
	String vru  = tuidd.getDodatno_update().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			if (splu[i].indexOf("[F")==-1) {
		//	sb.append("vseb."+splu[i]+";\r\n");
			
			
			if (vru.startsWith("set")) {
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
			
		if (vru.startsWith("set")) {
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

sb.append(dodaj_upd);

sb.append("}\r\n");

sb.append("else {\r\n");

if (!nul.jeNull(tuidd.getDodatno_delete()).equals("")) {
	sb.append(nul.jeNull(tuidd.getDodatno_delete()).replaceAll("\'","\"") + " {\r\n");

	sb.append("rabiinsert=\"X\";\r\n");
	sb.append("}\r\n");
	
}

sb.append("String rezu=\"\";\r\n");
sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request);\r\n");
/// dodatno insert





if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_insert()!=null && !tuidd.getDodatno_insert().equals("")) {
	
	
	String vru  = tuidd.getDodatno_insert().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			/*	if (splu[i].indexOf("[F")==-1) {
			sb.append("vseb."+splu[i]+";\r\n");
			}*/
			
			if (splu[i].indexOf("[F")==-1) {
				
				if (splu[i].startsWith("if") || splu[i].startsWith("else") || splu[i].startsWith("}")) {
					sb.append(""+splu[i]+";\r\n");
				}
				else {
					sb.append("vseb."+splu[i]+";\r\n");
				} 
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
			
		if (vru.startsWith("if") || vru.startsWith("else") || vru.startsWith("}")) {
			sb.append(""+vru+";\r\n");
		}
		else {
			sb.append("vseb."+vru+";\r\n");
		}
		
		}
			else if (vru.indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),vru.substring(vru.indexOf("[F")+2,vru.indexOf("]"))));
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+getFormatReturn(imefile,vru.substring(0,vru.indexOf("(")),"rezu")+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
			}
	}
	
	
	
}
sb.append(dodaj_ins);


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
sb.append("dao.save"+imefile+"(vseb);\r\n");
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
sb.append("@import \"barve.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
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
	sb.append("<script type=\"text/javascript\" src=\"ezcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
	sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
sb.append("<script language='javascript' src='popcalendar.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>'></script>\r\n");
sb.append("<script language='javascript' src='datum2.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
//sb.append("<script language='javascript' src='js/ajax.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");

sb.append("<script src=\"scripts/jquery.min.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script><script src=\"js/typeahead.bundle.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n"); /// novi dropdown

sb.append("<body   style=\"margin: 0\"  onload=\"mom()\">\r\n");
sb.append("<////%\r\n");

sb.append("String rezu=\"\";\r\n");
sb.append("////if (request.getParameter(\"akcijaXY\")==null) {\r\n");
sb.append("%////>\r\n");

sb.append("<form name=dod action=\""+imefile.toLowerCase() +"_edit"+sif.getId()+".jsp\" method=\"post\" "+(soFileInput?" enctype=\"multipart/form-data\"":"")+"   onSubmit=\""+(jekontrola?"return check()":"")+"\">\r\n");

sb.append("<////%\r\n");
sb.append("////if (vseb.getId()!=null && !vseb.getId().equals(\"\")) {\r\n");
sb.append("%////>\r\n");
sb.append("<input type=hidden name=\"akcijaXY\" value=\"UPDATE\">\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("////else {\r\n");
sb.append("%////>\r\n");
sb.append("<input type=hidden name=\"akcijaXY\" value=\"NEW\">\r\n");



sb.append("<////%\r\n");

if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_java_default()!=null && !tuidd.getDodatno_java_default().equals("")) {
	
	
	String vru  = tuidd.getDodatno_java_default().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			if (splu[i].indexOf("[F")==-1) {
			sb.append("vseb."+splu[i]+";\r\n");
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
			sb.append("vseb."+vru+";\r\n");
			}
			else if (vru.indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),vru.substring(vru.indexOf("[F")+2,vru.indexOf("]"))));
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+getFormatReturn(imefile,vru.substring(0,vru.indexOf("(")),"rezu")+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
			}
	}
	
	
	
}


sb.append("////}\r\n");
sb.append("%////>\r\n");

//// dam parametre, ki posljem preko requesta
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

sb.append("<input type=hidden name=\"id\" value=\"<////%=nul.jeNull(vseb.getId()+\"\")%////>\">\r\n");




sb.append("<table border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\"  width=\"100%\"  ><tr><td colspan=\"4\" class=\"opiscell\">&nbsp;</td></tr>\r\n");


System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII12");
StringBuffer hintpomoc = new StringBuffer();
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
		            		  
		        premoe=premoe+"<td class=\""+(nul.jeNull(ConPool.getPrevod(tu.getId()+"P"+control.getJezik())).equals("")?"valuecell":"opiscell")+"\" COLLSPANN  >< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>&nbsp;</td>";
  		 
		        
				
			}
			else {
		
				premo = premo + "<tr>";
      		  	String hintp = "";
				 if (nul.jeNull(tu.getHint_pomoc()).equals("1")) {
				     	hintpomoc.append("<span id='Q"+tu.getId()+"' style='display:none;'>< %=ConPool.getPrevod(\""+tu.getId()+"Q\"+control.getJezik()).replaceAll(\"_\",\" \").replaceAll(\"\\n\",\"<br>\").replaceAll(\"\\\"\",\"'\") %////></span>\r\n");
					hintp = "<a href=\"\" tabindex=\"-1\" style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\"  onmouseout=\"hideddrivetip()\" onclick=\"ddrivetip(document.getElementById('Q"+tu.getId()+"').innerHTML);return false;\">";
						 }
				
		        premo = premo + "<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">"+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+"</td><td class=\"valuecell\" COLLSPANN>";
		            
		       
		        
		        
		        premo = premo + genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name());
		        	
		        
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
		        	premo = premo + genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name());
		        	
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
			
					
					if (!nul.jeNull(ConPool.getPrevod(tu.getId()+"P"+control.getJezik())).equals("")) {
						sb.append(premoe.replaceAll("COLLSPANN","colspan=\"2\"")+"<td class=\"opiscell\" colspan='2'  >< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>&nbsp;</td></tr>\r\n");
					}
					else {
				sb.append(premoe.replaceAll("COLLSPANN","colspan=\"4\"")+"</tr>\r\n");
					}
				
				
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
				
			  	String hintp = "";
				 if (nul.jeNull(tu.getHint_pomoc()).equals("1")) {
			        	hintpomoc.append("<span id='Q"+tu.getId()+"' style='display:none;'>< %=ConPool.getPrevod(\""+tu.getId()+"Q\"+control.getJezik()).replaceAll(\"_\",\" \").replaceAll(\"\\n\",\"<br>\").replaceAll(\"\\\"\",\"'\") %////></span>\r\n");
			        hintp = "<a href=\"\" tabindex=\"-1\" style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\"  onmouseout=\"hideddrivetip()\" onclick=\"ddrivetip(document.getElementById('Q"+tu.getId()+"').innerHTML);return false;\">";
				 }
				 
				sb.append("<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">"+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+"</td><td class=\"valuecell\" width=\"30%\">\r\n");
		
				
				sb.append(genField(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));
		        	
		        
		        /// kontrola, ce ima se enega, za logiko dodatnega prikaza
		        
		        if (true) {
		        	
		        	//// 
		        //	com.popultrade.dao.TemplateUiDAO dauid = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		        	
		        //	com.popultrade.model.TemplateUi tuim = dauid.getTemplateUi(tu.getTemplateui_id().getId());
		        
		        
		        Iterator nexc = tu.getTemplateuis().iterator();
		        
		        while (nexc.hasNext()) {
		        	com.popultrade.model.TemplateUi tuinext = (com.popultrade.model.TemplateUi)nexc.next();
		        	
		        //	sb.append(" < %=ConPool.getPrevod(\""+tuinext.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ");
		        	sb.append(genField(tuinext,nul,templateUtil,contextUtil,pageContext.getServletContext(),true,sif.getHead_class_name()));
		        	
		        }
		        
		        
		        	
		        	
		        }
				
				
				
				
				
				
				
sb.append("</td>\r\n");
sb.append("</tr>\r\n");
		
			}
	
		
		}
		else {
			break;
		}
	
	
	}
	
	
	
	
}

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII13");

	
	sb.append("<tr><td colspan=\"4\" class=\"opiscell\" align=\"center\"><input id=\"submitbutton\"  type=submit value=\"< %=ConPool.getPrevod(\""+idpr+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" style=\"font-family: Verdana; font-size: 8pt\">&nbsp;</td></tr></table></form>\r\n");
	sb.append(hintpomoc.toString());
	sb.append("<script language='javascript'>\r\n");




sb.append(dodatno_custom_kontrole_function+"\r\n");
sb.append(this.getKontrolaAjaxJS()+ "\r\n");
sb.append("\r\nfunction custom() {\r\n");



sb.append(this.getKontrolaAjaxJSf()+ "\r\n");


this.kontrolaAjaxJS="";
this.kontrolaAjaxJSf="";

sb.append(dodatno_custom_kontrole+"\r\n");

if (tuidd!=null && tuidd.getId()!=null && tuidd.getDodatno_javascript()!=null && !tuidd.getDodatno_javascript().equals("")) {

	
	sb.append(tuidd.getDodatno_javascript().replaceAll("\n","\r\n")+"\r\n");
	
	
}


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

sb.append("document.dod.submitbutton.disabled=true;\r\n");
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



sb.append("function mom() {\r\n");

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
sb.append("%////>\r\n");

sb.append("<table border=\"0\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family: Verdana; font-size: 8pt\"  width=\"100%\" >\r\n");
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
		 parametri = parametri + ehn+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"=< %=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("\'","\"")+")%////>";
			 
	 }
	 else if (!nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")) {
	 
	 	parametri = parametri + ehn + tgpp.getDugacno_ime_parametra()+"="+nul.jeNull(tgpp.getStolpec_metoda());
	 
	 }
	 
}
sb.append("<script language=javascript>\r\n");


sb.append("function mom() {\r\n");

sb.append("<////%if (bok) {%////>\r\n");  
sb.append("alert('<////%=napaka%////>');\r\n");  
sb.append("<////%}%////>\r\n");  
sb.append("}\r\n");

if (!nul.jeNull(sif.getUporabi_count_ld()).equals("1")) { /// ce uporabim refresh pri update

sb.append("var mon = "+sif.getTarget_funkcija()+"+\"\";\r\n");
System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII14");
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
sb.append("@import \"barve.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
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

System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII15");


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
pp.append("<table width=\"98%\" id=\"table2\" height=\"92%\"  border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#E3F1FE\" align=\"center\">\r\n");
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_edit"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\">\r\n");
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
	
	
	pp.append(genFieldPredhodenPage(tu,nul,templateUtil,contextUtil,pageContext.getServletContext(),false,sif.getHead_class_name()));
	
    
	
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
	   	String ime_field="";
        
        		
        		ime_field = nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase();
        		
        	
	String ajaxpolje = getAjaxPP(tu,contextUtil,pageContext.getServletContext(),ime_field);

	
	Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(sif.getHead_class_name());
	if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
		pp.append("<input type=\"text\"      "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"     onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" onblur=\"change(this,'white');\" class=\"inputIEx\"  > <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"\" ><img src='call.gif' border='0'></a> \r\n");
		}
		else {
pp.append("<input type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"  "+(!ajaxpolje.equals("")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici(this,1);\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+">\r\n");
}
}
else if (nul.jeNull(tu.getTip_inserta()).equals("password")) {
	/// nujno dodati v insert pogoje

	pp.append("<input type=\"password\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\">\r\n");
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

	Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(deploy_kam+imefile.toLowerCase()+"_edit"+sif.getId()+"_p"+".jsp"), "latin1"));



	out3.write(pp.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
	////zaprem writer3
	out3.close();
}








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
//// kreacija jsp za view head
if (sif.getHead_tip().equals("HE")) {



    com.popultrade.dao.TemplateViewDAO daoui = (com.popultrade.dao.TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO",pageContext.getServletContext());



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
sb.append("////if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
sb.append("%////><jsp////:forward page=\"logout.jsp\"/><////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");
sb.append("////try {\r\n");
sb.append("boolean bok=false;\r\n");
sb.append("com.popultrade.model."+imefile+" vseb =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO dao = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");
//sb.append("if (request.getParameter(\"id\")!=null ) {\r\n");


///// dodatni pogoji, v javi
com.popultrade.model.TemplateUiDodatno tuidd = new com.popultrade.model.TemplateUiDodatno();

com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());

tuidd = daouid.getTemplateUiDodatnos(idpr);

if (sif.getTemplateClasss().size()>0) {
	
	
	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),imefile);
	Iterator ikov = sif.getTemplateClasss().iterator();
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
		sb.append("vseb."+tcc.getIme_pogoja()+"("+ rett+");\r\n");	
	}
	else {
		
	sb.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
	sb.append("vseb."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
	sb.append(" }\r\n");
	
	}
	
	}
	else {
		
		if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
		sb.append(nul.jeNull(tcc.getDodaten_pogoj_za_request()).replaceAll("'","\"") + " {\r\n");
		}
		
		dodaten_sql_pogoj = nul.jeNull(tcc.getDodaten_hql_pogoj());
		sb.append("dodpog = \""+dodaten_sql_pogoj+"\";\r\n");
		
		
		if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
		sb.append(" }\r\n");
		}
	}
	
	}
	
	
}


			sb.append("List lis =null;\r\n");

			sb.append("lis = dao.get"+imefile +"s(vseb,1,1,\"\",\"\",\"\");\r\n");
			sb.append("if (lis !=null && lis.size()==1) {\r\n");
sb.append("vseb = (com.popultrade.model."+imefile+")lis.get(0);\r\n");
sb.append("}\r\n");



//sb.append("}\r\n");


sb.append("String rezu=\"\";\r\n");
sb.append("String rezu2=\"\";\r\n");

//sb.append("//htn.put(\"kolicina\",\"kol_kg\");\r\n");


com.popultrade.model.TemplateView tui = new com.popultrade.model.TemplateView();

tui.setTemplatehead_id(new Long(idpr));
List tempui = daoui.getTemplateViews(tui);


sb.append(nul.jeNull(tuidd.getDodatno_java_rocno()));

sb.append("%////>\r\n");

sb.append("<html><head><title>spreminjaj</title></head>\r\n");

sb.append("<style type=text/css>\r\n");

sb.append("@import \"barve.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("@import \"js/jquery.contextmenu.css\";\r\n");
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"tooltip.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>\"></script>\r\n");
sb.append("<script language='javascript' src='colors.js?verzija=<////%=nul.jeNull(ConPool.getPrevod_admin(\"1000009\",\"Y\",control.getJezik()+\"\"))%////>' ></script>\r\n");
sb.append("<script language='javascript' >\r\n");
sb.append("function mom() {\r\n");



if (!nul.jeNull(tuidd.getDodatno_javascript()).equals("")) {
	
	sb.append(nul.jeNull(tuidd.getDodatno_javascript())+"\r\n");
	
}


if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}
sb.append("top.window.hideFrame();\r\n");
sb.append("}\r\n</script>\r\n");
sb.append("<body   style=\"margin: 0\"  onload=\"mom()\">\r\n");


sb.append("<table border=\"0\" cellspacing=\"1\" style=\" font-family:Verdana; font-size:8pt\"  width=\"100%\"  ><tr><td colspan=\"4\" class=\"opiscell\">&nbsp;</td></tr>\r\n");


StringBuffer hintpomoc = new StringBuffer();

if (tempui.size()>0) {
	Iterator itmo = tempui.iterator();
	
	
	
	while (true) {
			
		
		String premo = "";
		String premoe = "";
		if (itmo.hasNext()) {
			
			com.popultrade.model.TemplateView tu = (com.popultrade.model.TemplateView)itmo.next();
		  	String hintp = "";
			 if (nul.jeNull(tu.getHint_pomoc()).equals("1")) {
			     	hintpomoc.append("<span id='Q"+tu.getId()+"' style='display:none;'>< %=ConPool.getPrevod(\""+tu.getId()+"Q\"+control.getJezik()).replaceAll(\"_\",\" \").replaceAll(\"\\n\",\"<br>\").replaceAll(\"\\\"\",\"'\") %////></span>\r\n");
				hintp = "<a href=\"\" tabindex=\"-1\" style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\"  onmouseout=\"hideddrivetip()\" onclick=\"ddrivetip(document.getElementById('Q"+tu.getId()+"').innerHTML);return false;\">";
					 }
			/// ce je polje prazno
			if (nul.jeNull(tu.getTip_polja()).equals("PR")) {
				
			
				premoe=premoe+"<tr>";
		            		  
		        premoe=premoe+"<td class=\""+(nul.jeNull(ConPool.getPrevod(tu.getId()+"P"+control.getJezik())).equals("")?"valuecell":"opiscell")+"\" COLLSPANN  >"+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+"&nbsp;</td>";
  		 
		        
				
			}
			else {
		
				premo = premo + "<tr>";
      		  
		        premo = premo + "<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">"+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+"</td><td class=\"valuecell\" width=\"30%\" COLLSPANN>";
		            
		        
		        /// pogoji prikaza
		        
		        	 /// pogledam, ce ima pogoje

premo = getFieldHead( premo, tu);
if (!nul.jeNull(tu.getTip_polja()).equals("PR")) {
	sb.append("<////%\r\n");
	sb.append("rezu=\"\";\r\n");
	sb.append("%////>\r\n");
	}

		 ///// dodatna polja (next to gumb)          
if (true) {

Iterator nexc = tu.getTemplateviews().iterator();

while (nexc.hasNext()) {
	com.popultrade.model.TemplateView tuinext = (com.popultrade.model.TemplateView)nexc.next();
	premo = premo + " < %=ConPool.getPrevod(\""+tuinext.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ";

	premo =  getFieldHead( premo, tuinext);
	if (!nul.jeNull(tuinext.getTip_polja()).equals("PR")) {
		sb.append("<////%\r\n");
		sb.append("rezu=\"\";\r\n");
		sb.append("%////>\r\n");
		}
}


	
	
}		 
premo = premo + "</td>";
		}
		}
		else {
			break;
		}
		if (itmo.hasNext()) {
			com.popultrade.model.TemplateView tu = (com.popultrade.model.TemplateView)itmo.next();
			//// pomoc hint
		  	String hintp = "";
			 if (nul.jeNull(tu.getHint_pomoc()).equals("1")) {
			     	hintpomoc.append("<span id='Q"+tu.getId()+"' style='display:none;'>< %=ConPool.getPrevod(\""+tu.getId()+"Q\"+control.getJezik()).replaceAll(\"_\",\" \").replaceAll(\"\\n\",\"<br>\").replaceAll(\"\\\"\",\"'\") %////></span>\r\n");
				hintp = "<a href=\"\" tabindex=\"-1\" style=\"text-decoration: none;color:black; border-bottom-style:dotted;border-bottom-width: 1px\"  onmouseout=\"hideddrivetip()\" onclick=\"ddrivetip(document.getElementById('Q"+tu.getId()+"').innerHTML);return false;\">";
					 }
			/// ce je polje prazno
			if (nul.jeNull(tu.getTip_polja()).equals("PR")) {
				if (!premoe.equals("")) {
					if (!nul.jeNull(ConPool.getPrevod(tu.getId()+"P"+control.getJezik())).equals("")) {
						sb.append(premoe.replaceAll("COLLSPANN","colspan=\"2\"")+"<td class=\"opiscell\" colspan='2'  >"+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+"&nbsp;</td></tr>\r\n");
					}
					else {
				sb.append(premoe.replaceAll("COLLSPANN","colspan=\"4\"")+"</tr>\r\n");
					}
				//sb.append(premoe.replaceAll("COLLSPANN","colspan=\"4\"")+"</tr>\r\n");
				
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
				
				sb.append("<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">"+hintp+"< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>"+(hintp.equals("")?"":"</a>")+"</td><td class=\"valuecell\" width=\"30%\">\r\n");
		
				
				
		
				sb.append(getFieldHead("", tu));
				
				if (!nul.jeNull(tu.getTip_polja()).equals("PR")) {
				sb.append("<////%\r\n");
				sb.append("rezu=\"\";\r\n");
				sb.append("%////>\r\n");
				}
				 ///// dodatna polja (next to gumb)          
				if (true) {

				Iterator nexc = tu.getTemplateviews().iterator();

				while (nexc.hasNext()) {
					com.popultrade.model.TemplateView tuinext = (com.popultrade.model.TemplateView)nexc.next();
					sb.append("< %=ConPool.getPrevod(\""+tuinext.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ");
				
					sb.append(getFieldHead( "", tuinext));
					if (!nul.jeNull(tuinext.getTip_polja()).equals("PR")) {
						sb.append("<////%\r\n");
						sb.append("rezu=\"\";\r\n");
						sb.append("%////>\r\n");
						}
				}


					
					
				}	
				 
				 
				sb.append("</td>\r\n");
sb.append("</tr>\r\n");
		
			}
	
		
		}
		else {
			break;
		}
	
	
	}
	
	
	
	
}



	
	sb.append("<tr><td colspan=\"4\" class=\"opiscell\" align=\"center\">&nbsp;</td></tr></table></form>\r\n");
	sb.append(hintpomoc.toString());
sb.append("////<%\r\n}\r\n");
sb.append("////catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("////log.error(ex.toString());\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");



imefile = imefile+"_view";

}
////konec kreacija jsp za view head
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
