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




//// lokacija kam deployat jspje
String deploy_kam =parametrii.getParametri().getProperty("deploy_kam")+"tablet/";// "E:/Tomcat5.0/webapps/ics_test/";
//String deploy_kam  = "C:/Tomcat5.0/webapps/ics/";




%>
 


<%!
//public String deploy_kam = "E:/Tomcat5.0/webapps/ics_test/";
//public String deploy_kam = "C:/Tomcat5.0/webapps/ics/";
private com.popultrade.webapp.Parametri parametri = new com.popultrade.webapp.Parametri();
public String deploy_kam =parametri.getParametri().getProperty("deploy_kam")+"tablet/";// "E:/Tomcat5.0/webapps/popultrade/";







private com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
com.popultrade.webapp.TemplateUtils templateUtil = new com.popultrade.webapp.TemplateUtils();

//// inicializacija koledarja z js
StringBuffer init_koledar = new StringBuffer();

StringBuffer init_scroller = new StringBuffer();

private void set_js_Koledar(String dodatno) {
	init_koledar.append(dodatno+"\r\n");
}
private void set_js_Scroller(String dodatno) {
	init_scroller.append(dodatno+"\r\n");
}
///// select za koledar
private String dodajKoledar(String dodatno,String ime) {
	
	this.set_js_Koledar("$('#"+ime+"').scroller();");
	
	return "<input type=\"text\"  "+dodatno+"> \r\n";
	
	
}
///// select za dropdown
private void dodajScroller(String ime) {
	
	this.set_js_Scroller("$('#"+ime+"').dlist();");

	
	
}

private String genListMail(String idpr,String order_by,String order_by_smer,String imefile,com.popultrade.model.TemplateHead sif,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext) {
	
	try {

	StringBuffer sbl = new StringBuffer();

	sbl.append("<////%@ page contentType=\"text/html; \" import=\"javax.mail.*,javax.mail.internet.*,javax.activation.*,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
	sbl.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
	sbl.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
	sbl.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
	sbl.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");



	sbl.append("<////%\r\n");
	sbl.append("////request.setCharacterEncoding(control.encoding);\r\n");
	sbl.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
	sbl.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
	sbl.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
	sbl.append("////response.addDateHeader(\"Expires\", 0);\r\n");
	sbl.append("////if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"U\")) {\r\n");
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
				sbl.append("dodpog = dodpog+ \""+dodaten_sql_pogoj+"\";\r\n");
				
			
			if (!nul.jeNull(tcc.getDodaten_pogoj_za_request()).equals("")) {
			sbl.append(" }\r\n");
			}
		}
		
		}
		
		
	}

	sbl.append("String dodaten_sql_pogoj = dodpog;\r\n");


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
	
	sbl.append("outt.append(\"<html><head><title>Event Log Report</title><meta http-equiv='content-type' content='text/html; charset=utf-8'/><meta http-equiv='X-UA-Compatible' content='IE=8;FF=3'/><style type='text/css'>* {font-family: verdana;}a,a:link,a:active,a:visited {text-decoration: none;cursor: pointer;color: #035;}body {margin: 1ex;padding: 0ex;}img {border: 0px;}table {border-collapse: collapse;border-spacing: 0px;}td,th {cursor: default;border: 1px solid #DDD;padding: 1pt 1ex;margin: 0px}th {text-align: left;font-weight: bold;background-color: #F0F0F0;}td.ROW_NUMBER {background-color: #F3F3F3;text-align: center;}td.EVENT_TYPE_I {color: #10109F;text-align: center;}td.EVENT_TYPE_W {color: #808010;text-align: center;}td.EVENT_TYPE_E {color: #9F1010;text-align: center;}</style></head>\");\r\n");
	
	
	
	
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



	while (itbv.hasNext()) {
		
		 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();

		 
		 //// prikaz stolpca
		 /// numeric
		// sbl.append("<%\r\n");
		 sbl.append("rezu=\"\";\r\n");
		 
		// sbl.append("%////>\r\n");
		 
		 
		 /// pogledam, ce ima pogoje
		 
		 if (tli.getTemplateClasses().size()>0) {
			 
			 Iterator iteb = tli.getTemplateClasses().iterator();
			// sbl.append("<%\r\n");
			 sbl.append("rezu=\"\";\r\n");
			 
			// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
		
			// nul.getDatumFormatFromDate()
			 while (iteb.hasNext()) {
				 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
				 
				 
				 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
							 
					
					
					 /// pogoj
					 sbl.append("\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n");
					 
					 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
						 sbl.append("rezu=nul.formatNumber(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
						 //sbl.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
					 }
					 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
						 sbl.append("rezu=nul.getDatumFormatFromDate(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
					 }
					 else {
			 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
							 
								 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
									 sbl.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
																										 }
								 else {
									 sbl.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2()+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
														
								 }   	 
							 
						 }
						 else {
						
								
							 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
									
								 sbl.append("rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
															 }
								 else {
									 sbl.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
													
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
	sbl.append("rezu=\"\";\r\n");	
	sbl.append("if (true "+dodaten+") {\r\n");
	//sbl.append("if (true) {\r\n");
	//sbl.append("rezu=\"\";\r\n");	 		 
	sbl.append("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n");

	sbl.append("com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n");




	/// setam vrednosti

	Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tc.getTemplateClassClass().getClass_name());

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




	sbl.append("if (remi.size()>0) {\r\n");

	sbl.append("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n");




	//// pogoji vrednosti

	Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();


	while (vredno.hasNext()) {
		com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();
		
		if (tcv.getTemplateClasses().size()>0) {
		/// dobim templateclass
		Iterator item = tcv.getTemplateClasses().iterator();
				 while (item.hasNext()) {
				 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
				 
				 
				 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
					 
					 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF")) {
					 sbl.append("rezu=\"\";\r\n");
					 }
					 /// pogoj
					 sbl.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("\\.get","\\.geet").replaceAll("get","vseb.get").replaceAll("\\.geet","\\.get")+" {\r\n");
					 
					 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
						 sbl.append("rezu=nul.formatNumber(mod."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
						 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
					 }
					 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
						 sbl.append("rezu=nul.getDatumFormatFromDate(mod."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
					 }
					 else {
			 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
				 if (nul.jeNull(txc.getFunkcija_formata2()).indexOf(".get")==-1) {
					 sbl.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
																									 }
				 else {
					 sbl.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2()+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n");
										
				 }   
								 
							 
						 }
						 else {
							 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
								 sbl.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
																 			 }
								 else {
									 sbl.append("rezu="+txc.getVrednost_pogoja()+";\r\n\r\n");
													
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
				
			
			sbl.append("rezu="+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n");
			}
		
		
		
	}




	sbl.append("}\r\n");



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
					
						 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
							 sbl.append("rezu=rezu+\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("nul.je","\"+nul.je").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
																			 			 }
							 else {
								 sbl.append("rezu=rezu+"+tc.getVrednost_pogoja()+";\r\n\r\n");
												
							 }
						
					 
					 }
				 }
				 
				 
			 }
			 
			// sbl.append("%////>\r\n");
			 
			 
			 
			 
		 }
		 else {
			 
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
		 }
		 
		 if (nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals("") ) {
			 
			// sbl.append("<%\r\n");
			 sbl.append("rezu=nul.cutString(rezu,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n");
			// sbl.append("%////>\r\n");
			 
			 
		 }
		 
		 String hinto = "";
		 /// ce ima hinte stolpec
		 if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
			
			// sbl.append("<%\r\n");
			 
			 //sbl.append("if (sifhint.containsKey(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\")))) {\r\n");
			 hinto = " title='\"+nul.jeNull((String)sifhint.get(\"p"+tli.getId()+"\"+nul.menjajSifrantZnake(nul.jeNull(vseb."+tli.getStolpec_metoda()+"()+\"\").replaceAll(\"\'\",\"\").replaceAll(\"\\\"\",\"\").replaceAll(\"&\",\"\").replaceAll(\"\\\\.\",\"\"))))+\"'";
			 
			 
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
			 sbl.append("outt.append(\"<img "+wi+"  "+he+" src='\"+control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu+\"' border='0' >\");\r\n");
			//	 sbl.append("<////%\r\n");
				sbl.append("}\r\n\r\n");
			// sbl.append("%////>\r\n");
			 }
			 else {
				 sbl.append("outt.append(rezu);\r\n");
			 }	
		 
		 
	    // sbl.append("< %=rezu%////>\r\n\r\n");
	     


	     sbl.append("outt.append(\"</td>\");\r\n");
		 }
	       
	       
	}





	//sbl.append("<td  align=\"center\"><span id='res<////%=vseb.getId()%////>'>\r\n");








//	sbl.append("</span></td>\r\n");
	sbl.append("outt.append(\"</tr>\");\r\n");

	//sbl.append("<////%\r\n");
	sbl.append("br++;\r\n");

	sbl.append("}/////////////// while end\r\n");


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
							sbl.append("<script language='javascript' src='colors.js' ></script>\r\n");
	
	
	sbl.append("<body   style=\"margin: 0\" >\r\n");
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
	sbl.append("</body>\r\n");
	
	
	
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
			 System.out.println("1VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
			 Iterator iteb = tu.getTemplateClasses().iterator();
			 premo = premo + "<%\r\n"; 
			 premo = premo + "rezu=\"\";\r\n"; 
			 premo = premo + "rezu2=\"\";\r\n"; 
			 
			// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
		
			// nul.getDatumFormatFromDate()
			 while (iteb.hasNext()) {
				 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
				 
				 
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
							 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("nul\\.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
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

	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tc.getTemplateClassClass().getClass_name());
	
	while (tre.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
		
		///////// ///////// ///////////
		
		
		String rett = tcc.getVrednost_pogoja().replaceAll("\'","\"");
		
		if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			if (((String)meto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				rett = "nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()).replaceAll(\"_\",\"\\\\_\")";
				}
				else {
					rett = ""+tcc.getVrednost_pogoja();
					
				}
			}
			else {
				
				if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				rett = tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()";
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
								 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul\\.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
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
							 premo = premo + "rezu=rezu+\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
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
							 premo = premo + "rezu=rezu+\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request\\.getParameter","request.geetParameter").replaceAll("nul\\.je","\"+nul.je").replaceAll("get","vseb.get").replaceAll("request\\.geetParameter","request.getParameter")+"+\"\";\r\n\r\n";
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
			 premo = premo + "<img "+wi+"  "+he+" src='<////%=control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu%////>' border='0' >\r\n";
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
        
        	 /// pogledam, ce ima pogoje
	 
	 if (tu.getTemplateClasses().size()>0) {
		  
		 Iterator iteb = tu.getTemplateClasses().iterator();
		 premo = premo + "<%\r\n";
		 
		 
		// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
	
		// nul.getDatumFormatFromDate()
		 while (iteb.hasNext()) {
			 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
			 
			 
			 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
						 
				
				 
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
						 
						 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
							 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
														 }
							 else {
								 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
											
							 }  
						 
					 }
					 else {
						 
						 
					 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf("request.getParameter(")!=-1) {
					 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("()","").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
					 }
					 else {
						
						 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
							 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
										 			 }
							 else {
								 premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
									
							 }
							
					 }
					 
					 
					 }
					 
					 }
					 
				 
				 
				 premo = premo + "}\r\n";
				 
			 }
			 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
				 
					
				 
				 
				 
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



//premo = premo + "if (true) {\r\n";
//premo = premo + "rezu=\"\";\r\n";	 	 
premo = premo + "com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

premo = premo + "com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n";




/// setam vrednosti

Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

Hashtable metoc = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tc.getTemplateClassClass().getClass_name());

while (tre.hasNext()) {
	com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
	
	///////// ///////// ///////////
	
	
	String rett = tcc.getVrednost_pogoja().replaceAll("\'","\"");
	
	//if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	//	rett = tcc.getVrednost_pogoja().replaceAll("get","vseb.get")+"()";
	//}
	
	if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
		if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
			if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				//rett = tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()";
			
			rett = "nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()).replaceAll(\"_\",\"\\\\_\")";
			}
			else {
				rett = ""+tcc.getVrednost_pogoja();
				
			}
		}
		else {
			
			if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
			rett = tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()";
			}
			else {
				rett = ""+tcc.getVrednost_pogoja();
				
			}
		
		
		}
	}
	
	
	//System.out.println(((String)meto.get(tcc.getIme_pogoja()))+ " ::: IME POGOJA ::: "+tcc.getIme_pogoja());
	
	if (metoc.containsKey(tcc.getIme_pogoja())) {
		if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
			
		//System.out.println("SOLEMMM : "+rett);
		
		if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1 || nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			//rett = rett+"\"\"";
		}
		
		else	if (rett.indexOf("\"")==-1) {
				rett = "\""+rett+"\"";
			}
		}
		else if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
			if (rett.indexOf("\"")==-1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
				rett = "\""+rett+"\"";
			}
			
			rett = "new Long("+rett+")";
			
		}
		else if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)metoc.get(tcc.getIme_pogoja())).indexOf("int")!=-1) {
			if (rett.indexOf("\"")==-1) {
				
			
			rett = rett.replaceAll("\"", "").replaceAll("\'", "");
			rett = "\""+rett+"\"";
			}
			
			rett = "Integer.parseInt("+rett+"+\"\")";
			
		}
		else if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
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
	
	
	
	
	
	
	
}


premo = premo + "List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n";




premo = premo + "if (remi.size()>0) {\r\n";

premo = premo + "mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n";




//// pogoji vrednosti

Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();


while (vredno.hasNext()) {
	com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();
	
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
							 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
															 }
							 else {
								 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
											
							 }  
						 
					 }
					 else {
					
						 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf(".get")==-1) {
							 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
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
						 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
															 }
						 else {
							 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
										
						 }  
				 }
				 else {
					 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf(".get")==-1) {
						 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
											 			 }
						 else {
							 premo = premo + "rezu="+txc.getVrednost_pogoja()+";\r\n\r\n";
								
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
			
		
			premo = premo + "rezu="+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n";
		}
	
	
	
}




premo = premo + "}\r\n";



premo = premo + "}\r\n";


if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
premo = premo + "}\r\n";
}			 
					 
					 
				 }
				 
				 
				 
				 
				 
				 
				 
				 
				 
			 }
			 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
				
				 
	 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
					 
					 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
						 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
																 }
						 else {
							 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
										
						 }  
					 
				 }
				 else {
					 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
						 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("nul.je","\"+nul.je").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
												 			 }
						 else {
							 premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
								
						 }
				
				 
				 }
			 }
			 
			 
		 }
		 
		 premo = premo + "%////>\r\n";
		 
		 
		 
		 
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
        	
        	String ajaxpolje = getAjax(tu,contextUtil,servletContext);
  
        	
        	
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
        		premo = premo + this.dodajKoledar(""+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIExVC\" ":" class=\"inputIEx\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\" "+ajaxpolje+"",nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()) +"  \r\n";
        		
        		
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
        	
        		premo = premo + this.dodajKoledar(""+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=A"+tu.getId()+"%////>\" style=\"font-family: Verdana; font-size: 8pt\" "+ajaxpolje+"",nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase());
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"   maxlength=\'5\' size=\'6\' value=\"<////%=B"+tu.getId()+"%////>\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\" >";
	        	
        	}
        	}
        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
        		/// nujno dodati v insert pogoje
        		
        		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
        		
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"  >";
                	
        		}
        		else {
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()+\"\").equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"   >";
                		
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




















public String genField(com.popultrade.model.TemplateUi tu,com.popultrade.webapp.chkNull nul,com.popultrade.webapp.TemplateUtils templateUtil,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext,boolean dodaj_prevod,String class_name) {
	//com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	try {
	String premo="";
	
        
        /// pogoji prikaza
        
        	 /// pogledam, ce ima pogoje
	 
	 if (tu.getTemplateClasses().size()>0) {
		  
		 Iterator iteb = tu.getTemplateClasses().iterator();
		 premo = premo + "<%\r\n";
		 premo = premo + "rezu=\"\";\r\n";
		 
		// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
	
		// nul.getDatumFormatFromDate()
		 while (iteb.hasNext()) {
			 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
			 
			 
			 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
						 
				
				 
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
						 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
							 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
																		 }
							 else {
								 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
											
							 }   
							 
						 
					 }
					 else {
						 
						 
					 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf("request.getParameter(")!=-1) {
					 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("()","").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
					 }
					 else {
						
						 
						 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
								
							 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
											 }
							 else {
								 premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
									
							 }
						 	
					 }
					 
					 
					 }
					 
					 }
					 
				 
				 
				 premo = premo + "}\r\n";
				 
			 }
			 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
				 
					
				 
				 
				 
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
	
	if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
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



//premo = premo + "if (true) {\r\n";
//premo = premo + "rezu=\"\";\r\n";	 	 
premo = premo + "com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

premo = premo + "com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n";




/// setam vrednosti

Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

Hashtable metoc = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),tc.getTemplateClassClass().getClass_name());

while (tre.hasNext()) {
	com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
	
	///////// ///////// ///////////
	
	
	String rett = tcc.getVrednost_pogoja().replaceAll("\'","\"");
	
	//if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	//	rett = tcc.getVrednost_pogoja().replaceAll("get","vseb.get")+"()";
	//}
	
	if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
		if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
			if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
				
			rett = "nul.jeNull("+tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()).replaceAll(\"_\",\"\\\\_\")";
			}
			else {
				rett = ""+tcc.getVrednost_pogoja();
				
			}
		}
		else {
			if (tcc.getVrednost_pogoja().indexOf(".get")==-1) {
			rett = tcc.getVrednost_pogoja().replaceAll("request.getParameter","request.geetParameter").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter")+"()";
		
		}
		else {
			rett = ""+tcc.getVrednost_pogoja();
			
		}
		
		}
	}
	
	
	//System.out.println(((String)meto.get(tcc.getIme_pogoja()))+ " ::: IME POGOJA ::: "+tcc.getIme_pogoja());
	
	if (metoc.containsKey(tcc.getIme_pogoja())) {
		if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
			
		//System.out.println("SOLEMMM : "+rett);
		
		if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1 || nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			//rett = rett+"\"\"";
		}
		
		else	if (rett.indexOf("\"")==-1) {
				rett = "\""+rett+"\"";
			}
		}
		else if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
			if (rett.indexOf("\"")==-1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
				rett = "\""+rett+"\"";
			}
			
			rett = "new Long("+rett+")";
			
		}
		else if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)metoc.get(tcc.getIme_pogoja())).indexOf("int")!=-1) {
			if (rett.indexOf("\"")==-1) {
				
			
			rett = rett.replaceAll("\"", "").replaceAll("\'", "");
			rett = "\""+rett+"\"";
			}
			
			rett = "Integer.parseInt("+rett+"+\"\")";
			
		}
		else if (((String)metoc.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
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
		
	
	
	
	
	
	
	
}


premo = premo + "List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n";




premo = premo + "if (remi.size()>0) {\r\n";

premo = premo + "mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n";




//// pogoji vrednosti

Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();


while (vredno.hasNext()) {
	com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();
	
	if (tcv.getTemplateClasses().size()>0) {
	/// dobim templateclass
	Iterator item = tcv.getTemplateClasses().iterator();
			 while (item.hasNext()) {
			 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
			 
			 
			 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
				 
				
				 
				 /// pogoj
				// premo = premo + "rezu=\"\";\r\n";
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
							 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
																			 }
							 else {
								 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
											
							 }  
							 
						 
					 }
					 else {
					
						 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
								
							 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
												 }
							 else {
								 premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
									
							 }
						
					 
					 }
					 }
					 
				 
				 
				 premo = premo + "}\r\n";
				 
			 }
			 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
				
				 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
					 
					 if (nul.jeNull(txc.getFunkcija_formata2()).indexOf(".get")==-1) {
						 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
					 }
				
						 else {
							 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(txc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
										
						 }  
					 
				 }
				 else {
					 if (nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1")) {
						 premo = premo + "rezu="+nul.jeNull(txc.getVrsta_pogoja()).replaceAll("\'","\"")+";\r\n\r\n";
							
					 }
					 else if (nul.jeNull(txc.getVrednost_pogoja()).indexOf(".get")==-1) {
						
					 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
		 			 }
					 
					 else {
						 premo = premo + "rezu="+txc.getVrednost_pogoja()+";\r\n\r\n";
							
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
			
		
			premo = premo + "rezu="+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n";
		}
	
	
	
}




premo = premo + "}\r\n";



premo = premo + "}\r\n";


if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
premo = premo + "}\r\n";
}			 
					 
					 
				 }
				 
				 
				 
				 
				 
				 
				 
				 
				 
			 }
			 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
				
				 
	 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
					 
					 if (nul.jeNull(tc.getFunkcija_formata2()).indexOf(".get")==-1) {
						 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
																					 }
						 else {
							 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"")+nul.jeNull(tc.getFunkcija_formata3()).replaceAll("\'","\"")+");\r\n\r\n";
										
						 }   
					 
				 }
				 else {
					 if (nul.jeNull(tc.getVrednost_pogoja()).indexOf(".get")==-1) {
							
						 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("nul.je","\"+nul.je").replaceAll("get","vseb.get").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
								 }
						 else {
							 premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
								
						 }
				 }
			 }
			 
			 
		 }
		 
		 premo = premo + "%////>\r\n";
		 
		 
		 
		 
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
        
      
        if (nul.jeNull(tu.getVnos_kdaj()).equals("BO") || nul.jeNull(tu.getVnos_kdaj()).equals("UP") || nul.jeNull(tu.getVnos_kdaj()).equals("AJ")  || nul.jeNull(tu.getVnos_kdaj()).equals("IN") ) {
        	
        	
        	if (!nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).equals("")) {
         		premo = premo + "<////%\r\n\r\n";
                  		
                		premo = premo + nul.jeNull(tu.getDodaten_pogoj_prikaza_edit()).replaceAll("\'","\"")+"\r\n";
                		
                  		premo = premo + "%////>\r\n";
                	}
        	/// kontrola in generacija AJAX/////
        	
        	String ajaxpolje = getAjax(tu,contextUtil,servletContext);
  
        	if (ajaxpolje!=null && !ajaxpolje.equals("")) {
        		if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        	
        		dodajScroller( nul.jeNull(tu.getParameter_drugo_ime()).trim());
        	}
        		else {
        			dodajScroller(nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase());	
        		}
        	
        		
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
        			premo = premo + "if (vseb.getId()==null) {\r\n";
        			premo = premo + "%////>\r\n";
        		}
        	
        			
        			
        			
        			//// dodam prevod
        			
        			if (dodaj_prevod) {
        				
        				
        				premo =premo + " < %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////> ";
        				
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
        	
        	
else if (nul.jeNull(tu.getTip_inserta()).equals("textbox") || nul.jeNull(tu.getTip_inserta()).equals("password")) {
        		
        		String inum = "text";
        		if (tu.getTip_inserta().equals("password")) {
        			inum = "password";
        		}
        		
        	if (!nul.jeNull(tu.getDatum_vnos_tip()).equals("1")) {
        		
        		String dodc = "";
        		
        		if (ajaxpolje.equals("") && velike_crke.equals("1")) {
        			dodc = " onkeyup=\"javascript:this.value=this.value.toUpperCase();\" ";
        		}
        		
        	if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("") && nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  readonly type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  style=\"border: 0px solid #D2EAFF;background-color:#D2EAFF;font-family: Verdana; font-size: 8pt;"+(velike_crke.equals("1")?"text-transform:uppercase;":"")+"\" "+ajaxpolje+">\r\n";
        	}
        	else {
        		
        		
        		Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(class_name);
        		if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
        		premo = premo + this.dodajKoledar(""+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"     "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+"",nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+ " \r\n";
        		}
        		else { 
        			
        			if (!nul.jeNull(tu.getParameter_drugo_ime()).trim().equals("")) {
        				premo = premo + "<input type=\""+inum+"\" "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"  name=\""+nul.jeNull(tu.getParameter_drugo_ime())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"  "+dodc+"   "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+"  value=\"<////%=rezu%////>\">\r\n";
            				
        			}
        			else {
        			premo = premo + "<input type=\""+inum+"\" "+(nul.jeNull(tu.getVnos_kdaj_fiksno()).equals("1")?"readonly":"")+"  "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\" "+dodc+"  "+(velike_crke.equals("1")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"VC\" ":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\" ")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+">\r\n";
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
        	
        		premo = premo +this.dodajKoledar(""+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+"  "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=A"+tu.getId()+"%////>\" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"  "+ajaxpolje+"",nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()) + "\r\n ";
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\""+inum+"\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"_U\"   maxlength=\'5\' size=\'6\' value=\"<////%=B"+tu.getId()+"%////>\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"  >";
	        	
        	}
        	}
        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
        		/// nujno dodati v insert pogoje
        		
        		
        		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
        			
        			premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"    value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\" >";
            			
        		}
        		else {
        		premo = premo + "<input "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" type=\"checkbox\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"1\"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\" >";
        		}
        		}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
        		/// nujno dodati v insert pogoje
        		String cols = nul.jeNull(tu.getCols());
        		String rows = nul.jeNull(tu.getRows());
        		
        		premo = premo + "<textarea "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+"  onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEta\" ><////%=rezu%////></textarea>";
        	}
          	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
          		//System.out.println("XXXXXXXXXXXXXXXXXXXXXXX--------XXXXXXXXXXXXXXXXXXX");
          		
          		if (nul.jeNull(tu.getVnos_kdaj()).equals("AJ")) {
          		premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" name=\""+(!nul.jeNull(tu.getParameter_drugo_ime()).equals("")?tu.getParameter_drugo_ime().toLowerCase():nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
          		}
        		else {
        			premo = premo + "<select "+(nul.jeNull(tu.getJavascript_event_uporabi()).equals("1")?nul.jeNull(tu.getJavascript_event()):"")+" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
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
       			 premo = premo + "<img "+wi+"  "+he+" src='../<////%=control.lokacijaslika + nul.jeNull(vseb.getId()+\"\")+\"/\"+rezu%////>' border='0' >\r\n";
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







public String getAjaxPP(com.popultrade.model.TemplatePP tu,com.popultrade.webapp.ContextUtil contextUtil,ServletContext servletContext) {
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
		
		return "  autocomplete=\"off\" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();"+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+"\"  onfocsus=\"ajax_options_hide();change(this,'yellow');"+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"')\" onkeyup=\""+(velike_crke.equals("1")?"this.value=this.value.toUpperCase();":"")+" ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"+(daj_v_parameter.equals("")?"":(daj_v_parameter.endsWith("\'")?daj_v_parameter.substring(0,daj_v_parameter.length()-2)+"+'&'":daj_v_parameter+"&'"))+",'1','"+daj_v_set+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"','"+(nul.jeNull(tu.getTemplateDD().getMin_st_znakov()+"").equals("")?"0":tu.getTemplateDD().getMin_st_znakov()+"")+"')\" ";
		}
		}
		catch (Exception exx) {
			System.out.println("NAPAKA AJAX::: "+exx.toString());
		}
		
	}
	return "";
	 
	
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
							 
		premos = premos + "com.popultrade.dao."+tmdd.getClass_name()+"DAO doax =(com.popultrade.dao."+ tmdd.getClass_name()+"DAO)contextUtil.getBeanDao(\""+tmdd.getClass_name().substring(0,1).toLowerCase() +tmdd.getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

		premos = premos + "com.popultrade.model."+tmdd.getClass_name() +" modx = new com.popultrade.model."+tmdd.getClass_name() +"();\r\n";



		com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",servletContext);

		/// setam vrednosti

		com.popultrade.model.TemplateDDPogoji sifh = new com.popultrade.model.TemplateDDPogoji();


		sifh.setTemplatedd_id(tmdd.getId());
		sifh.setTip("P");
		
	
		System.out.println("-----------------------------");
		System.out.println("-----------------------------234");
		System.out.println("-----------------------------");
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
						 rett="request.getParameter(\""+tcc.getVrednost_metode().replaceAll("\'","\"").toLowerCase()+"\")+\"\"";
			
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
			
			System.out.println("-----------------------------");
			System.out.println("-----------------------------567");
			System.out.println("-----------------------------");
			
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

		System.out.println("-----------------------------");
		System.out.println("-----------------------------789");
		System.out.println("-----------------------------");
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
		
		System.out.println("-----------------------------");
		System.out.println("-----------------------------34436634");
		System.out.println("-----------------------------");
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
								 
			premos = premos + "com.popultrade.dao."+tmdd.getClass_name()+"DAO doax =(com.popultrade.dao."+ tmdd.getClass_name()+"DAO)contextUtil.getBeanDao(\""+tmdd.getClass_name().substring(0,1).toLowerCase() +tmdd.getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

			premos = premos + "com.popultrade.model."+tmdd.getClass_name() +" modx = new com.popultrade.model."+tmdd.getClass_name() +"();\r\n";



			com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",servletContext);

			/// setam vrednosti

			com.popultrade.model.TemplateDDPogoji sifh = new com.popultrade.model.TemplateDDPogoji();


			sifh.setTemplatedd_id(tmdd.getId());
			sifh.setTip("P");
			
		
			System.out.println("-----------------------------");
			System.out.println("-----------------------------234");
			System.out.println("-----------------------------");
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
			
			daj_v_js_f = daj_v_js_f + ""+tcc.getIme_metode().replaceAll("set","").toLowerCase()+"=\"+document.dod."+tcc.getVrednost_metode().toLowerCase()+".value+\"&";
			
			
			System.out.println("-----------------------------");
			System.out.println("-----------------------------1011112 xxxxxxxxxxxxxxxxxxxxxxxx");
			System.out.println("-----------------------------");
			
			
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
				
				System.out.println("-----------------------------");
				System.out.println("-----------------------------567");
				System.out.println("-----------------------------");
				
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

			System.out.println("-----------------------------");
			System.out.println("-----------------------------789");
			System.out.println("-----------------------------");
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
			
		
			
			System.out.println("-----------------------------");
			System.out.println("-----------------------------1011112");
			System.out.println("-----------------------------");
			
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
			
			System.out.println("-----------------------------");
			System.out.println("-----------------------------34436634xxxxxxxxxxxxxxxxxx");
			System.out.println("-----------------------------");
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
	
	Hashtable meto = templateUtil.getClassMetodeImenaHT(contextUtil,this.getServletContext(),classname);

	

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
else if (sif.getHead_tip().equals("PD")) {
	predpo="_pdf"+sif.getId();
}
else if (sif.getHead_tip().equals("LI")) {
	predpo="_list"+sif.getId();
}
else if (sif.getHead_tip().equals("UP")) {
	predpo="_upload"+sif.getId()+"_1";
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

if (sif.getHead_tip().equals("PR")) {








sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
sb.append("<jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
sb.append("<jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");
sb.append("<jsp:useBean id=\"prisotnost\" scope=\"application\" class=\"com.popultrade.webapp.kontrolaPrisotnosti\" />\r\n");
 
 
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
	


//// kreiram funkcije, ki se uporabi za kontrole

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

	
sb.append("CallableStatement  cs = dao.pridobiConnectionZaProceduro().prepareCall( \""+sif.getZacetek_procedure()+vpr+sif.getKonec_procedure()+"\" );\r\n");
	 


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




sb.append("%////>\r\n");
sb.append("<html><head><title>spreminjaj</title></head>\r\n");
 
sb.append("<style type=text/css> \r\n");
sb.append("@import \"barve.css\";\r\n");
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js' ></script>\r\n");
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
else if (thed.getHead_tip().equals("EX")) {
	predpo="_exp"+thed.getId();
}
else if (thed.getHead_tip().equals("EE")) {
	predpo="_expe"+thed.getId();
}
else if (thed.getHead_tip().equals("UP")) {
	predpo="_upload"+thed.getId()+"_1";
}
sb.append(sif.getTarget_funkcija()+"='"+nul.jeNull(thed.getHead_class_name()).toLowerCase()+predpo+".jsp';\r\n");
}
else if (!nul.jeNull(sif.getTarget_funkcija()).equals("")) {
	sb.append(sif.getTarget_funkcija()+"="+sif.getTarget_funkcija()+";\r\n");
}
if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
	
	Iterator rese = sif.getTemplateHeadResets().iterator();
	
	while (rese.hasNext()) {
		com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
		
		
		sb.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
		
		
	}
	
	
	
}
//sb.append("top.window.hideFrame();\r\n");
sb.append("}\r\n");

sb.append("var timerId = setInterval(mom, 5000); \r\n");
sb.append("</script>\r\n");

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
	
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII152");
	
	
	
	
	
	pp.append("%////>\r\n");

	pp.append("<html><head><title>spreminjaj</title></head>\r\n");

	pp.append("<style type=text/css>\r\n");
	pp.append("@import \"barve.css\";\r\n");
	pp.append("</style>\r\n");
	pp.append("<script language='javascript' src='colors.js' ></script>\r\n");


	if (jestr || jenum) {
		pp.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
		}
		if (jenum) {
		pp.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
		}
		pp.append("<script type=\"text/javascript\" src=\"ezcalendar.js\"></script>\r\n");
		pp.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"ezcalendar.css\" />\r\n");
	
	pp.append("<script language='javascript' src='popcalendar.js'></script>\r\n");
	pp.append("<script language='javascript' src='datum2.js' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax.js' ></script>\r\n");
	pp.append("<script language='javascript' src='js/ajax-dynamic-list-n.js' ></script>\r\n");
	pp.append("<body   style=\"margin: 0\"   onload=\"mom()\">\r\n");
	
	System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIII153");
	
pp.append("<table border=\"1\" width=\"100%\" id=\"table1\" height=\"100%\" style=\"border-collapse: collapse\" bgcolor=#C3E1FC	>\r\n");
pp.append("<tr>\r\n");
pp.append("<td align=\"center\" valign=\"middle\"><font style=\"font-size: 4pt\">&nbsp;\r\n");
pp.append("</font>\r\n");
pp.append("<table border=\"1\" width=\"98%\" id=\"table2\" height=\"92%\" bordercolor=\"#FFFFFF\" style=\"border-collapse: collapse\">\r\n");
pp.append("<tr>\r\n");
pp.append("<td bgcolor=\"#E3F1FE\" align=\"center\">\r\n");
pp.append("<table border=\"0\" id=\"table3\" style=\"font-family: Verdana; font-size: 8pt\" cellpadding=\"3\" width=\"404\" cellspacing=\"1\"><form METHOD=\"POST\" name=\"dod\" ACTION=\""+imefile.toLowerCase()+"_proc"+sif.getId()+".jsp?opcija=new&siframm=new\" onsubmit=\"return check()\">\r\n");
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
	
	String ajaxpolje = getAjaxPP(tu,contextUtil,pageContext.getServletContext());

	
	Hashtable metocs = templateUtil.getClassMetodeImenaHTGet(sif.getHead_class_name());
	if (((String)metocs.get(nul.jeNull(tu.getStolpec_metoda()))).indexOf("Date")!=-1) {
		pp.append(this.dodajKoledar(""+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+"     onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" onblur=\"change(this,'white');\" class=\"inputIEx\"  > <a href=\"javascript: showCalendar('"+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"')\" value=\"\" ",nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\r\n");
		}
		else {
pp.append("<input type=\"text\" "+(tabi.equals("")?"":"tabindex=\'"+tabi+"\'")+" id=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"  name=\""+(!nul.jeNull(tu.getRazlicno_ime_inputa()).equals("")?nul.jeNull(tu.getRazlicno_ime_inputa()):nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase())+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"size=\'"+dol+"\'")+" value=\"<////%=rezu%////>\"  "+(!ajaxpolje.equals("")?" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\"":" class=\"inputIEx"+(!ajaxpolje.equals("")?"a":"")+"\"")+" "+(ajaxpolje.equals("")?" onfocus=\"ajax_options_hide();change(this,'yellow');setKlici();\" ":"")+"  onblur=\"change(this,'white');\"  "+ajaxpolje+">\r\n");
}
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

		
		//if (nul.jeNull(tu.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
			//
		//}
		
		pp.append("%////>\r\n");
		if (nul.jeNull(tu.getStolpec_metoda()).indexOf("request.getParameter")==-1) {
		pp.append("<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"()+\"\")%////>\"  >"+vrednost+"</option>;\r\n");
		}
		else {
			pp.append("<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"()+\"\")%////>\" <////%=nul.jeNull(modi"+clna+"."+sifra+"()+\"\").equals(nul.jeNull("+nul.jeNull(tu.getStolpec_metoda())+"))%////> >"+vrednost+"</option>;\r\n");
			
		}
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
			 sb.append("<input type=hidden name=\""+nul.jeNull(tgpp.getStolpec_metoda()).substring(nul.jeNull(tgpp.getStolpec_metoda()).indexOf("\'")+1,nul.jeNull(tgpp.getStolpec_metoda()).lastIndexOf("\'"))+"\" value=\"<////%=nul.jeNull("+nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("'","\"")+")%////>\">\r\n");
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
	
	
	pp.append("<script language=\"javascript\">\r\n");
	
	
	pp.append("\r\nfunction mom() {\r\n");
	if (sif.getTemplateHeadResets()!=null && sif.getTemplateHeadResets().size()>0) {
		
		Iterator rese = sif.getTemplateHeadResets().iterator();
		
		while (rese.hasNext()) {
			com.popultrade.model.TemplateHeadReset thr = (com.popultrade.model.TemplateHeadReset)rese.next();
			
			
			pp.append(thr.getReset_lokacija()+" = \""+thr.getReset_page()+"\";\r\n");
			
			
		}
		
		
		
	}
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
