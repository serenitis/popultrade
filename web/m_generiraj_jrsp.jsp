<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
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

// stevilo prikazov vrstic

int stpri = control.st_vrstic;


// steje stevilo vrstic
int stej = 0;

// barve vrstic
String[] colors = {"plava1","plava2","silver"};





// stevilo vrstic
int stvrstic=0;

boolean iskanje=false;

try {

	

	
	
	
	
// get list from daoobject
com.popultrade.dao.TemplateHeadDAO dao = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());



com.popultrade.model.TemplateHead sif = new com.popultrade.model.TemplateHead();


sif = dao.getTemplateHead(new Long(request.getParameter("id")));


String imefile = sif.getHead_class_name();
StringBuffer sb =new StringBuffer();
String order_by = nul.jeNull(sif.getHead_select_dodatni_pogoji());
String order_by_smer = nul.jeNull(sif.getOrder_by_smer());
String class_name = sif.getHead_class_name();
String idpr = sif.getId()+"";
String dodaten_sql_pogoj =  "";///sif.getHead_select_dodatni_pogoji();
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
	



sb.append("<////%@ page contentType=\"text/html; \" import=\"java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date\"%////>\r\n");
sb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
sb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
sb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
sb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");



sb.append("<////%\r\n");
sb.append("////request.setCharacterEncoding(control.encoding);\r\n");
sb.append("////response.setContentType(\"text/html; charset=\"+control.encoding);\r\n");
sb.append("////response.addHeader(\"Pragma\" , \"No-cache\") ;\r\n");
sb.append("////response.addHeader(\"Cache-Control\", \"no-cache\") ;\r\n");
sb.append("////response.addDateHeader(\"Expires\", 0);\r\n");
sb.append("////if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"A\")) {\r\n");
sb.append("%////><jsp////:forward page=\"m_loginu.html\"/><////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");
sb.append("<////%\r\n");

sb.append("// stevilo prikazov vrstic\r\n");

sb.append("int stpri = control.st_vrstic;\r\n");


// steje stevilo vrstic
sb.append("int stej = 0;\r\n");

// barve vrstic
sb.append("String[] colors = {\"plava1\",\"plava2\",\"silver\"};\r\n");





// stevilo vrstic
sb.append("int stvrstic=0;\r\n");

sb.append("boolean iskanje=false;\r\n");

		sb.append("try {\r\n");

// get list from daoobject
sb.append("com.popultrade.dao."+imefile +"DAO dao = (com.popultrade.dao."+imefile +"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1,imefile.length()) +"DAO\",pageContext.getServletContext());\r\n");


sb.append("if (request.getParameter(\"akcija\")!=null && request.getParameter(\"akcija\").equals(\"DELETE\"))  {\r\n");


sb.append("dao.remove"+imefile +"(new Long(request.getParameter(\"id\")));\r\n");


sb.append("}\r\n");


sb.append("int pagenum=1;\r\n");
sb.append("int stizpisov=stpri;\r\n");

sb.append("if (request.getParameter(\"pagenumber\")!=null && !request.getParameter(\"pagenumber\").equals(\"\")) {\r\n");

sb.append("pagenum = Integer.parseInt(request.getParameter(\"pagenumber\"));\r\n");
sb.append("session.putValue(\"pagenumber"+imefile +"\",pagenum+\"\");\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("if (session.getValue(\"pagenumber"+imefile +"\")!=null) {\r\n");
sb.append("pagenum = Integer.parseInt(session.getValue(\"pagenumber"+imefile +"\")+\"\");\r\n");
sb.append("}\r\n");
sb.append("}\r\n");


sb.append("String orderby = \""+order_by+"\";\r\n");
sb.append("String orderbysmer = \""+order_by_smer+"\";\r\n");
sb.append("String dodaten_sql_pogoj = \"\";\r\n");



sb.append("com.popultrade.model."+imefile +" sif = new com.popultrade.model."+imefile +"();\r\n");


///////// searchi

sb.append("if (nul.jeNull(request.getParameter(\"isci\")).equals(\"yes\")) {\r\n");
sb.append("iskanje = true;\r\n");
//sif = (com.popultrade.model.Users)contextUtil.getPopulatedObject(sif,request);



/// dobim vse pogoje iskanja iz clase

 List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
		
		Iterator itti = li.iterator();

		while (itti.hasNext()) {
		
			String nex =(String)itti.next();
			String param = nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","");
				
			if (nex.indexOf("String")!=-1 || nex.indexOf("Integer")!=-1 || nex.indexOf("int")!=-1) {
			sb.append("if (!nul.jeNull(request.getParameter(\""+param+"\")).equals(\"\")) {\r\n");
			sb.append("sif.set"+param+"(nul.jeNull(request.getParameter(\""+param+"\"))+\"\");\r\n");
			sb.append("}\r\n");
			}
			else if (nex.indexOf("Long")!=-1) {
				sb.append("if (!nul.jeNull(request.getParameter(\""+param+"\")).equals(\"\")) {\r\n");
				sb.append("sif.set"+param+"(new Long(nul.jeNull(request.getParameter(\""+param+"\"))));\r\n");
				sb.append("}\r\n");
			}
			else if (nex.indexOf("java.util.Date")!=-1) {
				
				if (param.endsWith("1")) {
					sb.append("if (!nul.jeNull(request.getParameter(\""+param+"\")).equals(\"\")) {\r\n");
					sb.append("sif.set"+param+"(nul.parseDatumUra(nul.jeNull(request.getParameter(\""+param+"\")+\" 00:00\")));\r\n");
					sb.append("}\r\n");

				}
				if (param.endsWith("2")) {
					sb.append("if (!nul.jeNull(request.getParameter(\""+param+"\")).equals(\"\")) {\r\n");
					sb.append("sif.set"+param+"(nul.parseDatumUra(nul.jeNull(request.getParameter(\""+param+"\")+\" 23:59\")));\r\n");
					sb.append("}\r\n");
					
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













sb.append("int strec = dao.getSt"+imefile +"(sif,dodaten_sql_pogoj);\r\n");



sb.append("List lis =null;\r\n");

sb.append("lis = dao.get"+imefile +"s(sif,pagenum,stizpisov,dodaten_sql_pogoj,orderby,orderbysmer);\r\n");







sb.append("%////>\r\n");
sb.append("<html><head><title></title></head>\r\n");
sb.append("<style>\r\n");

sb.append("A:hover{color:red}\r\n");
sb.append("#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}\r\n");
sb.append("DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;\r\n");
sb.append("background-color:Silver; layer-background-color:2686D8}\r\n");
sb.append("</style>\r\n");
sb.append("<style type=text/css>\r\n");

sb.append("@import \"barve.css\";\r\n");
sb.append("@import \"tooltipcss.css\";\r\n");
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js' ></script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"tooltip.js\"></script>\r\n");

sb.append("<script language=javascript>\r\n");

////////// potrditev brisanja
sb.append("function vprasaj() {\r\n");
sb.append("  var a = window.confirm(\"< %=ConPool.getPrevod(\""+idpr+"R\"+control.getJezik())%////>\");\r\n");
sb.append(" if (a==true) {\r\n");

sb.append("   return true;\r\n");
sb.append("  }\r\n");
sb.append(" else {\r\n");
sb.append("   return false;\r\n");
sb.append("}\r\n");
sb.append("}\r\n");


sb.append("function chg() {\r\n");




sb.append(" <////%\r\n");
sb.append("if (request.getParameter(\"idback\")!=null && !request.getParameter(\"idback\").equals(\"null\") && !request.getParameter(\"idback\").equals(\"\")) {\r\n");
sb.append("%////>\r\n");
sb.append("kliknivSivo(document.getElementById(\"sprememba\"),document.getElementById(\"sprememba\").className);\r\n");
sb.append("window.scroll(1,document.getElementById(\"sprememba\").offsetTop-15);\r\n");

sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");

sb.append("parent.frames[2].location = \"nic.jsp\";\r\n");
sb.append("parent.frames[3].location = \"nic.jsp\";\r\n");
sb.append("}\r\n");
sb.append("</script>\r\n");
sb.append("<script type=\"text/javascript\" language=\"JavaScript\" src=\"helpmaster3.js\"></script>\r\n");

sb.append("<script language=javascript>\r\n");

     /////// hinti opisi
     
     
     
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
	sb.append("com.popultrade.dao."+clna +"DAO dao"+clna+" = (com.popultrade.dao."+clna +"DAO)contextUtil.getBeanDao(\""+clna.substring(0,1).toLowerCase()+clna.substring(1,clna.length()) +"DAO\",pageContext.getServletContext());\r\n");

	sb.append("com.popultrade.model."+clna +" mod"+clna+" = new com.popultrade.model."+clna +"();\r\n");

	
	//// vrednosti
	
	Iterator ikov = tli.getTemplateClassClass().getTemplateClasss().iterator();
	
	while (ikov.hasNext()) {
	com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)ikov.next();	
	
	
	sb.append("mod"+clna+"."+tcc.getIme_pogoja()+"("+tcc.getVrednost_pogoja().replaceAll("\'","\"") +");\r\n");
	
	
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

	
	sb.append("%////>\r\n");
	sb.append("p"+tli.getId()+"<////%=modi"+clna+"."+sifra+"()%////>=\"<////%=modi"+clna+"."+vrednost+"()%////>\";\r\n");

	sb.append("<////%\r\n\r\n");
	sb.append("}\r\n\r\n");
	
	}
	
	
	sb.append("%////>\r\n");
	
	
}

    	 
    	 
     }

           



sb.append("</script>\r\n");


sb.append("<body  style=\"margin: 0\"   background=\"podlaga.jpg\" bgproperties=\"fixed\"  onLoad=\"chg();menuBarInit()\" >\r\n");
sb.append("<div id=\"popup\" style=\"position:absolute; z-index:1; visibility: hidden\"></div>\r\n");
sb.append("<div id=\"divBg\" style=\"width:100%\">\r\n");
sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\" align=\"CENTER\" valign=\"MIDDLE\" style=\" font-family:Verdana; font-size:7pt\">\r\n");
sb.append("<tr bgcolor=\"2686D8\">\r\n");

  

      stej=0;
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
               

sb.append("<td width=\""+tli.getStolpec_width()+"\" align=\""+tli.getStolpec_align()+"\" bgcolor=\""+barv[bar] +"\" onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(p"+tli.getId()+")\">< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td>\r\n");
               
        
bar++;

              }
              
              
              
              
sb.append("<td  bgcolor=\"D2EAFF\" align=center>\r\n");
             

/// gumbi
     com.popultrade.dao.TemplateGumbiDAO daotg = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());

     
     
     com.popultrade.model.TemplateGumbi sifcg = new com.popultrade.model.TemplateGumbi();
     sifcg.setTemplatehead_id(new Long(idpr+""));
 
     List ling = daotg.getTemplateGumbis(sifcg);
     Iterator itbg = ling.iterator();
     
     
     
     while (itbg.hasNext()) {
    	
    	 com.popultrade.model.TemplateGumbi tli = (com.popultrade.model.TemplateGumbi)itbg.next();
 		 String target = "";
		 if (tli.getTarget_gumba().equals("0")) {
			 target = "parent.frames[0].location=";
		 }
		 else  if (tli.getTarget_gumba().equals("1")) {
			 target = "parent.frames[1].location=";
		 }
		 else  if (tli.getTarget_gumba().equals("2")) {
			 target = "parent.frames[2].location=";
		 }
		 else  if (tli.getTarget_gumba().equals("3")) {
			 target = "parent.frames[0].location=frameinr_";
		 }
		 else  if (tli.getTarget_gumba().equals("4")) {
			 target = "parent.frames[1].location=frameinr_";
		 }
		 else  if (tli.getTarget_gumba().equals("5")) {
			 target = "parent.frames[2].location=frameinr_";
		 }	 
		 else  if (tli.getTarget_gumba().equals("6")) {
			 target = "parent.frames[0].location=frameinc_";
		 }
		 else  if (tli.getTarget_gumba().equals("7")) {
			 target = "parent.frames[1].location=frameinc_";
		 }
		 else  if (tli.getTarget_gumba().equals("8")) {
			 target = "parent.frames[2].location=frameinc_";
		 }
		 
    	 if (tli.getUrl_gumba().equals("add.gif") && tli.getLokacija_gumba().equals("H")) {	 
    	 sb.append("<a onClick=\"return godown('"+target+""+imefile.toLowerCase() +"_edit.jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>')\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\"add.gif\" /></a>\r\n");
    	 }
    	 
    	 if (tli.getUrl_gumba().equals("search.gif") && tli.getLokacija_gumba().equals("H")) {	 
        	 sb.append("<a onClick=\"return godown('"+target+""+imefile.toLowerCase() +"_isci.jsp?opcija=new&siframm=new&sifrant=< %=request.getParameter(\"sifrant\")%////>')\" href=\"Javascript: PGAPP()\"><img title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" border=\"0\" src=\"search.gif\" /></a>\r\n");
        	 }
    	 
    	 
     }

                
   




sb.append("&nbsp;</td>\r\n");
      
      
      
      
      
      
      
sb.append("</tr>\r\n");
 

sb.append("</table>\r\n");
sb.append("</div>\r\n");






sb.append("<table width=100% cellspacing=1  style=\" font-family: Verdana; font-size: 7pt\">\r\n");
sb.append("<tr><td colspan=3>&nbsp</td></tr>\r\n");
sb.append("<////%\r\n");

/// menja barvo
sb.append("int br = 0;\r\n");
sb.append("String oe_kup_nap = \"\";\r\n");


sb.append("Iterator it = lis.iterator();\r\n\r\n");

sb.append("String rezu=\"\";\r\n\r\n");


sb.append("while (it.hasNext()){  // while start\r\n");

sb.append("com.popultrade.model."+imefile +" vseb = (com.popultrade.model."+imefile +")(it.next());\r\n");
sb.append("stvrstic++;\r\n");

sb.append("if (br==2){\r\n");
 sb.append(" br=0;\r\n");
sb.append("}\r\n");

sb.append("if (vseb.getId().toString().equals(nul.jeNull(request.getParameter(\"idback\")))) {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"<////%=colors[br]%////>\" id=sprememba onMouseOver=\"colors(this,'rollOver')\" onMouseOut=\"colors(this,'<////%=colors[br]%////>')\">\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("%////>\r\n");
sb.append("<tr class=\"<////%=colors[br]%////>\"  onMouseOver=\"colors(this,'rollOver')\" onMouseOut=\"colors(this,'<////%=colors[br]%////>')\">\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");


sb.append("%////>\r\n");


Iterator itbv = lin.iterator();



while (itbv.hasNext()) {
	
	 com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();

	 
	 //// prikaz stolpca
	 /// numeric
	 
	 
	 
	 /// pogledam, ce ima pogoje
	 
	 if (tli.getTemplateClasses().size()>0) {
		 
		 Iterator iteb = tli.getTemplateClasses().iterator();
		 sb.append("<%\r\n");
		 
		 
		// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
	
		// nul.getDatumFormatFromDate()
		 while (iteb.hasNext()) {
			 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
			 
			 
			 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && !nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
				 
				
				 
				 /// pogoj
				 sb.append("\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n");
				 
				 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
					 sb.append("rezu=nul.formatNumber(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
					 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
				 }
				 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
					 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
				 }
				 else {
					 
					 sb.append("rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
				 }
					 
				 
				 
				 sb.append("}\r\n");
				 
			 }
			 
			 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
				 
					
				 
				 
				 
				 /// vrednost iz clase
				 
				 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
/// pogoj
sb.append(nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n");
					 		 
 	 
sb.append("if (true) {\r\n");
					 
sb.append("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+" doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n");

sb.append("com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n");




/// setam vrednosti

Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();


while (tre.hasNext()) {
	com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
	
	
	
	sb.append("mod."+tcc.getIme_pogoja()+"("+tcc.getVrednost_pogoja().replaceAll("\'","\"")+");\r\n");
	
	
}


sb.append("List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n");




sb.append("if (remi.size()>0) {\r\n");

sb.append("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0)\r\n");




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
				 sb.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n");
				 
				 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
					 sb.append("rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
					 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
				 }
				 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
					 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
				 }
				 else {
					 
					 sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
				 }
					 
				 
				 
				 sb.append("}\r\n");
				 
			 }
			 }
	}
	else {
		sb.append("rezu=mod."+tcv.getVrednost()+"();\r\n\r\n");
	}
	
	
	
}






sb.append("}\r\n");



sb.append("}\r\n");



sb.append("}\r\n");
					 
					 
					 
				 }
				 
				 
				 
				 
				 
				 
				 
				 
				 
			 }
			 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
				 sb.append("rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","vseb.get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
				 
			 }
			 
			 
		 }
		 
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
	 

	 
	 String hinto = "";
	 /// ce ima hinte stolpec
	 if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
		 hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(typeof(p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_metoda()+"())%////>)=='string'?p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_metoda()+"())%////>:'')\"";
		 
	 }
	 
	 
	 sb.append("<td width=\""+tli.getStolpec_width()+"\" align=\""+tli.getStolpec_align()+"\" "+hinto+">< %=rezu%////></td>\r\n");
       
       
       
}





sb.append("<td  align=\"center\">\r\n");






Iterator itbgd = ling.iterator();



while (itbgd.hasNext()) {
	
	 com.popultrade.model.TemplateGumbi tli = (com.popultrade.model.TemplateGumbi)itbgd.next();
	 String target = "";
	 if (tli.getTarget_gumba().equals("0")) {
		 target = "parent.frames[0].location=";
	 }
	 else  if (tli.getTarget_gumba().equals("1")) {
		 target = "parent.frames[1].location=";
	 }
	 else  if (tli.getTarget_gumba().equals("2")) {
		 target = "parent.frames[2].location=";
	 }
	 else  if (tli.getTarget_gumba().equals("3")) {
		 target = "parent.frames[0].location=frameinr_";
	 }
	 else  if (tli.getTarget_gumba().equals("4")) {
		 target = "parent.frames[1].location=frameinr_";
	 }
	 else  if (tli.getTarget_gumba().equals("5")) {
		 target = "parent.frames[2].location=frameinr_";
	 }	 
	 else  if (tli.getTarget_gumba().equals("6")) {
		 target = "parent.frames[0].location=frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("7")) {
		 target = "parent.frames[1].location=frameinc_";
	 }
	 else  if (tli.getTarget_gumba().equals("8")) {
		 target = "parent.frames[2].location=frameinc_";
	 }
	 
	 
	 /// dobim parametre , ki dodam gumbu
	 
	 Iterator igy = tli.getTemplateGumbiParametris().iterator();
	 
	 String parametri = "";
	 
	 while (igy.hasNext()) {
		 com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)igy.next();
		 parametri = parametri + "&"+tgpp.getStolpec_metoda().replaceAll("get","")+"=< %=vseb."+tgpp.getStolpec_metoda()+"()%////>";
	 }
	 
	 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
		 sb.append("<%\r\n"); 
		 sb.append("if "+nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n"); 
		 sb.append("\r\n%////>\r\n"); 
	 }
		 
		 
	 if (tli.getUrl_gumba().equals("x.gif") && tli.getLokacija_gumba().equals("V")) {	 
		 
	
		 
		 sb.append("<a onClick=\"return vprasaj()\" href=\""+imefile.toLowerCase() +".jsp?akcija=DELETE&id=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"\"><img src=\"x.gif\" border=0 title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");
		

		 
	 }
	 
	 if (tli.getUrl_gumba().equals("h.gif") && tli.getLokacija_gumba().equals("V")) {
		 
		 
		 sb.append("<a href=\""+target+imefile.toLowerCase()+"_view.jsp?id=<////%=vseb.getId()%////>&opcija=spremeni&siframm=new&idback=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"\"><img src=\"h.gif\" border=0 onClick=\"kliknivSivo(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 if (tli.getUrl_gumba().equals("u.gif") && tli.getLokacija_gumba().equals("V")) {
		 
		 sb.append("<a href=\""+target+imefile.toLowerCase()+"_edit.jsp?id=<////%=vseb.getId()%////>&opcija=spremeni&siframm=new&idback=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter(\"sifrant\")%////>"+parametri+"\"><img src=\"u.gif\" border=0 onClick=\"kliknivSivo(this,'<////%=colors[br]%////>');\" title=\"< %=ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\"></a>\r\n");

		 
	 }
	 
	 if (tli.getTemplateClass()!=null && !nul.jeNull(tli.getTemplateClass().getDodaten_hql_pogoj()).equals("")) {
		 sb.append("<%"); 
		 sb.append("}\r\n"); 
		 sb.append("%////>"); 
	 }
	 
}











sb.append("</td>\r\n");
sb.append("</tr>\r\n");

sb.append("<////%\r\n");
sb.append("br++;\r\n");

sb.append("}/////////////// while end\r\n");


 sb.append("%////>\r\n");
  
sb.append("</table>\r\n");


sb.append("<script language=javascript>\r\n");
		sb.append("function go(asd,vv){\r\n");
				sb.append("if (vv == 1){\r\n");
						sb.append(" aaa = \"m_"+imefile.toLowerCase() +"_edit.jsp?id=\"+asd;\r\n");
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

sb.append("</script>\r\n");


sb.append("<////%\r\n");
// st izpisov
sb.append("if (strec>stizpisov) {\r\n");
sb.append("String iskk=\"\";\r\n");
sb.append("if (iskanje) {\r\n");
sb.append("iskk=\"&isk=1\";\r\n");
sb.append("}\r\n");
sb.append("%////><p align=center>\r\n");
sb.append("<table  border=\"0\" cellpadding=\"7\" cellspacing=\"1\" style=\"border-collapse: collapse; font-family:Verdana; font-size:8pt;\">\r\n");
sb.append("<tr bgcolor=\"ededed\">\r\n");
sb.append("<td align=center >\r\n");
sb.append("Browse page: </td><td>\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+".jsp?pagenumber=1<////%=iskk%////>\">first</a></td><td>|</td>\r\n");


sb.append("<////%\r\n");
sb.append("int vse=0;\r\n");
sb.append("int ststr=0;\r\n");

sb.append("int prvii=nul.jeNull(session.getValue(\"pagenumber"+imefile+"\")+\"\").equals(\"\")?1:Integer.parseInt(session.getValue(\"pagenumber"+imefile+"\")+\"\");\r\n");

sb.append("if (prvii>1) {\r\n");
sb.append("int prej = prvii-1;\r\n");
sb.append("%////>\r\n");
sb.append("<td>\r\n");
sb.append("<a style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">previous</a></td>\r\n");

sb.append("<td>|</td>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");
sb.append("<////%\r\n");

sb.append("for (int y=0;y<strec;y++) {\r\n");
sb.append("vse++;\r\n");
sb.append("if (vse==stizpisov) {\r\n");
sb.append("vse=0;\r\n");

sb.append("ststr++;\r\n");
sb.append("if ((prvii-5)<ststr && ststr<(prvii+5)) {\r\n");
sb.append("%////>\r\n");
sb.append("<td align=center bgcolor=\"<////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+"\")+\"\").equals(ststr+\"\")?\"white\":\"ededed\" %////>\"> <a hrefs=\"\" style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+".jsp?pagenumber=<////%=ststr %////><////%=iskk%////>\"><////%=ststr %////></a> </td><td>|</td>\r\n");
sb.append("<////%\r\n");

sb.append("}\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("if (vse!=0) {\r\n");
sb.append("%////>\r\n");
sb.append("<td align=center bgcolor=\"<////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+"\")+\"\").equals(ststr+1+\"\")?\"white\":\"ededed\" %////>\"> <a hrefs=\"\" style=\"text-decoration:none;color:black\"  href=\""+imefile.toLowerCase()+".jsp?pagenumber=<////%=ststr+1 %////><////%=iskk%////>\"><////%=ststr+1 %////></a> </td><td>|</td>\r\n");
sb.append("<////%\r\n");


sb.append("}\r\n");



sb.append("if (prvii<=ststr) {\r\n");
sb.append("int prej = prvii+1;\r\n");
sb.append("%////>\r\n");
sb.append("<td>\r\n");
sb.append(" <a style=\"text-decoration:none;color:black\"  href=\"m_"+imefile.toLowerCase()+".jsp?pagenumber=<////%=prej%////><////%=iskk%////>\">next</a></td>\r\n");

sb.append("<td>|</td>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");



sb.append("<td><a style=\"text-decoration:none;color:black\"  href=\"m_"+imefile.toLowerCase()+".jsp?pagenumber=<////%=ststr+1%////><////%=iskk%////>\">last</a></td>\r\n");
sb.append("<td>|</td>\r\n");
sb.append("<td >\r\n");
sb.append("page: <////%=nul.jeNull(session.getValue(\"pagenumber"+imefile+"\")+\"\").equals(\"\")?\"1\":session.getValue(\"pagenumber"+imefile+"\")%////> of <////%=ststr+1%////> </td>\r\n");
sb.append("<td>|</td>\r\n");
sb.append("<td>\r\n");
sb.append("records: <////%=strec%////></td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table></p>\r\n");
sb.append("<////%\r\n");
sb.append("}\r\n");
sb.append("%////>\r\n");

sb.append("</body></html>\r\n");
 sb.append("<////%\r\n");

sb.append("}\r\n");
sb.append("catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("////log.error(ex.toString());\r\n");
sb.append("}\r\n");

sb.append("%////>\r\n");



























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
sb.append("////if (control.getUser().equals(\"anonymous\") || !control.getPrivilegijeUporabnika().equals(\"A\")) {\r\n");
sb.append("%////><jsp////:forward page=\"m_loginu.html\"/><////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");
sb.append("////try {\r\n");
sb.append("boolean bok=false;\r\n");
sb.append("com.popultrade.model."+imefile+" vseb =new com.popultrade.model."+imefile+"();\r\n");
sb.append("com.popultrade.dao."+imefile+"DAO dao = (com.popultrade.dao."+imefile+"DAO)contextUtil.getBeanDao(\""+imefile.substring(0,1).toLowerCase()+imefile.substring(1)+"DAO\",pageContext.getServletContext());\r\n");
sb.append("if (request.getParameter(\"id\")!=null && request.getParameter(\"akcija\")==null) {\r\n");
sb.append("vseb = dao.get"+imefile+"(new Long(nul.jeNullDefault(request.getParameter(\"id\"))));\r\n");
sb.append("}\r\n");

sb.append("else if (request.getParameter(\"akcija\")!=null)  {\r\n");

sb.append("if (!bok) {\r\n");

sb.append("if (request.getParameter(\"id\")!=null && !request.getParameter(\"id\").equals(\"\")) {\r\n");

sb.append("String rezu=\"\";\r\n");
sb.append("vseb = dao.get"+imefile+"(new Long(nul.jeNullDefault(request.getParameter(\"id\"))));\r\n");
sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request);\r\n");

com.popultrade.dao.TemplateUiDodatnoDAO daouid = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());



com.popultrade.model.TemplateUiDodatno tuid = new com.popultrade.model.TemplateUiDodatno();


tuid = daouid.getTemplateUiDodatnos(idpr);



if (tuid!=null && tuid.getId()!=null && tuid.getDodatno_update()!=null && !tuid.getDodatno_update().equals("")) {
	
	
	String vru  = tuid.getDodatno_update().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			if (splu[i].indexOf("[F")==-1) {
			sb.append("vseb."+splu[i]+";\r\n");
			}
			else if (splu[i].indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),splu[i].substring(splu[i].indexOf("[F")+2,splu[i].indexOf("]"))));
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+"rezu"+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
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
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+"rezu"+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
			}
	}
	
	
	
}


/// dodatno update


sb.append("}\r\n");

sb.append("else {\r\n");
sb.append("String rezu=\"\";\r\n");
sb.append("vseb = (com.popultrade.model."+imefile+")contextUtil.getPopulatedObject(vseb,request);\r\n");
/// dodatno insert





if (tuid!=null && tuid.getId()!=null && tuid.getDodatno_insert()!=null && !tuid.getDodatno_insert().equals("")) {
	
	
	String vru  = tuid.getDodatno_insert().trim();
	
	if (vru.indexOf("\n")!=-1) {
		
		
		String[] splu = vru.split("\n");
		
		for (int i=0;i<splu.length;i++) {
			if (splu[i].indexOf("[F")==-1) {
			sb.append("vseb."+splu[i]+";\r\n");
			}
			else if (splu[i].indexOf("[F")!=-1) {
				
				
				sb.append(templateUtil.generirajFunkcijo(contextUtil,pageContext.getServletContext(),splu[i].substring(splu[i].indexOf("[F")+2,splu[i].indexOf("]"))));
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+"rezu"+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
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
				sb.append("vseb."+vru.substring(0,vru.indexOf("'"))+"rezu"+vru.substring(vru.lastIndexOf("'")+1,vru.length())+"\r\n");
			}
	}
	
	
	
}

sb.append("}\r\n");



sb.append("dao.save"+imefile+"(vseb);\r\n");

sb.append("}\r\n");
sb.append("}\r\n");



//// javascript kontrole




sb.append("Hashtable ht =new Hashtable();\r\n");
//sb.append("//ht.put(\"id\",\"id\");\r\n");
sb.append("Hashtable htn =new Hashtable();\r\n");
//sb.append("//htn.put(\"kolicina\",\"kol_kg\");\r\n");


com.popultrade.model.TemplateUi tui = new com.popultrade.model.TemplateUi();

tui.setTemplatehead_id(new Long(idpr));
List tempui = daoui.getTemplateUis(tui);

Hashtable meto = templateUtil.getClassMetodeImenaHTGet(imefile);
boolean jenum = false;
boolean jestr = false;
if (tempui.size()>0) {
Iterator termo = tempui.iterator();


while (termo.hasNext()) {
	com.popultrade.model.TemplateUi tu = (com.popultrade.model.TemplateUi)termo.next();
	
	/// dodaj kontrolo
	if (nul.jeNull(tu.getKontrola_javascript()).equals("DA")) {
		
		/// vrsta kontrole, numeric ali string ali datum
		
		if (meto.containsKey(tu.getStolpec_metoda())) {
			
			if (meto.get(tu.getStolpec_metoda()).toString().indexOf("int")!=-1 ||meto.get(tu.getStolpec_metoda()).toString().indexOf("Integer")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Long")!=-1 || meto.get(tu.getStolpec_metoda()).toString().indexOf("Double")!=-1) {
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
	
	
}
}

sb.append("%////>\r\n");

sb.append("<html><head><title>spreminjaj</title></head>\r\n");

sb.append("<style type=text/css>\r\n");
sb.append("@import \"barve.css\";\r\n");
sb.append("</style>\r\n");
sb.append("<script language='javascript' src='colors.js' ></script>\r\n");


if (jestr) {
sb.append("<////%=javaScript.getControlsEmptyValuesHashtable(\"document.dod\",ht) %////>\r\n");
}
if (jenum) {
sb.append("<////%=javaScript.getControlsNumericValuesHashtable(\"document.dod\",htn) %////>\r\n");
}
sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"scripts/epoch_styles.css\">\r\n");
sb.append("<script type=\"text/javascript\" src=\"scripts/epoch_classes.js\"></script>\r\n");
sb.append("<script language='javascript' src='popcalendar.js'></script>\r\n");
sb.append("<script language='javascript' src='datum2.js' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax.js' ></script>\r\n");
sb.append("<script language='javascript' src='js/ajax-dynamic-list-n.js' ></script>\r\n");
sb.append("<body   style=\"margin: 0\"  onload=\"mom()\">\r\n");
sb.append("<////%\r\n");

sb.append("String rezu=\"\";\r\n");
sb.append("////if (request.getParameter(\"akcija\")==null) {\r\n");
sb.append("%////>\r\n");

sb.append("<form name=dod action=\""+imefile.toLowerCase() +"_edit.jsp\" method=\"post\" onSubmit=\"return check()\">\r\n");

sb.append("<////%\r\n");
sb.append("////if (vseb.getId()!=null && !vseb.getId().equals(\"\")) {\r\n");
sb.append("%////>\r\n");
sb.append("<input type=hidden name=\"akcija\" value=\"UPDATE\">\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("////else {\r\n");
sb.append("%////>\r\n");
sb.append("<input type=hidden name=\"akcija\" value=\"NEW\">\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");

sb.append("<input type=hidden name=\"id\" value=\"<////%=nul.jeNull(vseb.getId()+\"\")%////>\">\r\n");

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
		            		  
		        premoe=premoe+"<td class=\"opiscell\" COLLSPANN  >&nbsp;</td>";
  		 
		        
				
			}
			else {
		
				premo = premo + "<tr>";
      		  
		        premo = premo + "<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td class=\"valuecell\" width=\"30%\" COLLSPANN>";
		            
		        
		        /// pogoji prikaza
		        
		        	 /// pogledam, ce ima pogoje
			 
			 if (tu.getTemplateClasses().size()>0) {
				  
				 Iterator iteb = tu.getTemplateClasses().iterator();
				 premo = premo + "<%\r\n";
				 
				 
				// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
			
				// nul.getDatumFormatFromDate()
				 while (iteb.hasNext()) {
					 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
					 
					 
					 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && !nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
						 
						
						 
						 /// pogoj
						 premo = premo + "\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n";
						 
						 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
							 premo = premo + "rezu=nul.formatNumber(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
							 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
						 }
						 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
							 premo = premo + "rezu=nul.getDatumFormatFromDate(vseb."+tc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
						 }
						 else {
							 
							 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
						 }
							 
						 
						 
						 premo = premo + "}\r\n";
						 
					 }
					 
					 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
						 
							
						 
						 
						 
						 /// vrednost iz clase
						 
						 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
		/// pogoj
		premo = premo + nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n";
							 		 
		 	 
		premo = premo + "if (true) {\r\n";
							 
		premo = premo + "com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+" doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

		premo = premo + "com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n";




		/// setam vrednosti

		Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();


		while (tre.hasNext()) {
			com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
			
			
			
			premo = premo + "mod."+tcc.getIme_pogoja()+"("+tcc.getVrednost_pogoja().replaceAll("\'","\"")+");\r\n";
			
			
		}


		premo = premo + "List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n";




		premo = premo + "if (remi.size()>0) {\r\n";

		premo = premo + "mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0)\r\n";




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
						 premo = premo + "\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n";
						 
						 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
							 premo = premo + "rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
							 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
						 }
						 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
							 premo = premo + "rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
						 }
						 else {
							 
							 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
						 }
							 
						 
						 
						 premo = premo + "}\r\n";
						 
					 }
					 }
			}
			else {
				premo = premo + "rezu=mod."+tcv.getVrednost()+"();\r\n\r\n";
			}
			
			
			
		}






		premo = premo + "}\r\n";



		premo = premo + "}\r\n";



		premo = premo + "}\r\n";
							 
							 
							 
						 }
						 
						 
						 
						 
						 
						 
						 
						 
						 
					 }
					 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
						 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","vseb.get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
						 
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
					 premo = premo + "rezu=nul.jeNull(vseb."+tu.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n";
					 premo = premo + "%////>\r\n";
				 }
			 }
		        
		      
		        if (nul.jeNull(tu.getVnos_kdaj()).equals("BO") || nul.jeNull(tu.getVnos_kdaj()).equals("UP")  || nul.jeNull(tu.getVnos_kdaj()).equals("IN") ) {
		        	
		        	
		        	
		        	/// kontrola in generacija AJAX
		        	
		        	String ajaxpolje = "";
		        	String premos="";
		        	if (tu.getTemplateDD()!=null && tu.getTemplateDD().getId()!=null) {
		        		
		        		
		        		
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
		        		
		        		
		        		
		        		
		   		 	 
		        		premos = premos + "if (true) {\r\n";
		        							 
		        		premos = premos + "com.popultrade.dao."+tu.getTemplateDD().getClass_name()+"DAO doax =(com.popultrade.dao."+ tu.getTemplateDD().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tu.getTemplateDD().getClass_name().substring(0,1).toLowerCase() +tu.getTemplateDD().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

		        		premos = premos + "com.popultrade.model."+tu.getTemplateDD().getClass_name() +" modx = new com.popultrade.model."+tu.getTemplateDD().getClass_name() +"();\r\n";



		        		com.popultrade.dao.TemplateDDPogojiDAO daodd = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",pageContext.getServletContext());

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
		        			
		        			if (meto.containsKey(tcc.getIme_metode())) {
							if (((String)meto.get(tcc.getIme_metode())).indexOf("Long")!=-1) {
								
								
								
								rett = "new Long("+rett+")";
								
								
								
							}
							else if (((String)meto.get(tcc.getIme_metode())).indexOf("int")!=-1 || ((String)meto.get(tcc.getIme_metode())).indexOf("Integer")!=-1) {
								rett = "Integer.parseInt("+rett+")";
								
							}
							else if (((String)meto.get(tcc.getIme_metode())).indexOf("Double")!=-1) {
							
								rett = "Double.parseDouble("+rett+")";
							}
		        			}
		        			
		        			
		        			
		        			premos = premos + "modx."+tcc.getIme_metode()+"("+rett+");\r\n";
		        			String dodd = "&";
		        			if (daj_v_parameter.equals("")) {
		        				dodd = "?";
		        			}
		        			daj_v_parameter = daj_v_parameter +dodd+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+"='+document.dod."+tcc.getVrednost_metode().replaceAll("set","").toLowerCase()+".value";
		        			
		        		}


		        		premos = premos + "List remix=doax.get"+tu.getTemplateDD().getClass_name()+"s(modx);\r\n";




		        		premos = premos + "if (remix.size()>0) {\r\n";
		        		
		        		
		        		
		         		sifh = new com.popultrade.model.TemplateDDPogoji();


						sifh.setTemplatedd_id(tu.getTemplateDD().getId());
						sifh.setTip("V");
						
					
						
					
						
						lish = daodd.getTemplateDDPogojis(sifh);
						tre = lish.iterator();
						String daj_v_id="";
						String daj_v_set="";
						String daj_v_vrednost="";
						
						/////// vrednosti pogoja
		        		while (tre.hasNext()) {
		        			com.popultrade.model.TemplateDDPogoji tcc = (com.popultrade.model.TemplateDDPogoji)tre.next();
		        			
		        			
		        			if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("1")) {
		        				daj_v_id = daj_v_id +"<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////> ___ ";
		        				daj_v_vrednost = daj_v_vrednost + "<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////> ";
		        				daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
		        				
		        			}
		        			else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("2")) {
		        				daj_v_id = daj_v_id +"<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////> ___ ";
		        			//	daj_v_vrednost = daj_v_vrednost + "<%="+tcc.getRezultat_metode()+"%////> ";
		        				daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
		        			}
		        			
							else if (nul.jeNull(tcc.getPrikazi_vrednost()).equals("3")) {
								//daj_v_id = daj_v_id +"<%="+tcc.getRezultat_metode()+"%////> ___ ";
		        				daj_v_vrednost = daj_v_vrednost + "<%=nul.jeNull(vsebx.get"+tcc.getRezultat_metode()+"()+\"\")%////> ";
		        				//daj_v_set = daj_v_set + tcc.getIme_metode().replaceAll("get","").toLowerCase()+" ___ ";
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
		        		
		        		
		        		
		        		/// shranim file za ajax
		        		
		        		Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("c:/"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"), "latin1"));



						out3.write(premos.replaceAll("< %=","<////%=").replaceAll("////",""));
						////zaprem writer3
						out3.close();
		        		
		        		
						ajaxpolje = "  autocomplete=\"off\"  onkeyup=\"ajax_showOptionsID(this,'getCountriesByLetters',event,'"+tu.getTemplateDD().getClass_name().toLowerCase()+tu.getTemplateDD().getId()+".jsp"+daj_v_parameter+",'1','"+daj_v_set+"')\" ";
		        		
		        		
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
		        	
		        	
		        	String max = nul.jeNull(tu.getStolpec_max_stevilo_znakov());
		        	String dol = nul.jeNull(tu.getStolpec_sirina());
		        	if (nul.jeNull(tu.getTip_inserta()).equals("textbox")) {
					premo = premo + "<input type=\"text\"  id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"   "+(max.equals("")?"":"maxlength=\'"+max+"\'")+" "+(dol.equals("")?"":"dol=\'"+dol+"\'")+" value=\"<////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"())%////>\" style=\"font-family: Verdana; font-size: 8pt\" "+ajaxpolje+">";
		        	}
		        	else if (nul.jeNull(tu.getTip_inserta()).equals("checkbox")) {
		        		/// nujno dodati v insert pogoje
		        		premo = premo + "<input type=\"checkbox\" id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\"  <////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"()).equals(\"1\")?\"checked\":\"\"%////>  value=\"<////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"())%////>\" style=\"font-family: Verdana; font-size: 8pt\">";
		        	}
		          	else if (nul.jeNull(tu.getTip_inserta()).equals("textarea")) {
		        		/// nujno dodati v insert pogoje
		        		String cols = nul.jeNull(tu.getCols());
		        		String rows = nul.jeNull(tu.getRows());
		        		
		        		premo = premo + "<textarea id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" "+(cols.equals("")?"":"cols=\'"+cols+"\'")+" "+(rows.equals("")?"":"rows=\'"+rows+"\'")+" style=\"font-family: Verdana; font-size: 8pt\"><////%=nul.jeNull(vseb."+tu.getStolpec_metoda()+"())%////></textarea>";
		        	}
		          	else if (nul.jeNull(tu.getTip_inserta()).equals("dropbox")) {
		          		
		          		
		          		
		          		premo = premo + "<select id=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" name=\""+nul.jeNull(tu.getStolpec_metoda()).replaceAll("get","").toLowerCase()+"\" style=\"font-family: Verdana; font-size: 8pt\" >\r\n";
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
		          		 meto = templateUtil.getClassMetodeImenaHTGet(clna);
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
		          		premo = premo + "List li"+clna+" = dao"+clna+".get"+clna+"s(mod"+clna+");\r\n";
		          		
		          		premo = premo + "Iterator i"+clna+"=li"+clna+".iterator();\r\n";
		          		

		          		
		          		premo = premo + "while (i"+clna+".hasNext()) {\r\n";
		          		premo = premo + "com.popultrade.model."+clna +" modi"+clna+" = (com.popultrade.model."+clna +")i"+clna+".next();\r\n";

		          		
		          		premo = premo + "%////>\r\n";
		          		
		          		premo = premo + "<option value=\"<////%=nul.jeNull(modi"+clna+"."+sifra+"())%////>\" <////%=nul.jeNull(modi"+clna+"."+sifra+"()).equals(nul.jeNull(vseb."+tu.getStolpec_metoda()+"()))?\"selected\":\"\"%////>><////%=nul.jeNull(modi"+clna+"."+vrednost+"())%////></option>;\r\n";
		          		
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
		        	
		        	
		        	}
		        	else {
		        		premo = premo + "<////%=rezu%////>\r\n";
		        		
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
					
					sb.append(premo.replaceAll("COLLSPANN","colspan=\"3\"")+"</tr>\r\n");
						
				}
			}
			else {
				if (!premoe.equals("")) {
					
					sb.append(premoe.replaceAll("COLLSPANN","colspan=\"4\"")+"\r\n");
					
					}
					else if (!premo.equals("")) {
						
						sb.append(premo.replaceAll("COLLSPANN","")+"\r\n");
							
					}
				
				sb.append("<td class=\"opiscell\" width=\"20%\" align=\""+tu.getStolpec_align()+"\">< %=ConPool.getPrevod(\""+tu.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") %////></td><td class=\"valuecell\" width=\"30%\">\r\n");
		
sb.append("</td>\r\n");
sb.append("</tr>\r\n");
		
			}
	
		
		}
		else {
			break;
		}
	
	
	}
	
	
	
	
}



	
	sb.append("<tr><td colspan=\"4\" class=\"opiscell\" align=\"center\"><input type=submit value=\"< %=ConPool.getPrevod(\""+idpr+"R\"+control.getJezik()).replaceAll(\"_\",\" \") %////>\" style=\"font-family: Verdana; font-size: 8pt\">&nbsp;</td></tr></table></form>\r\n");
sb.append("<script language='javascript'>\r\n");
sb.append("function custom() {\r\n");



sb.append("return true;\r\n");
sb.append("}\r\n");
sb.append("function mom() {\r\n");

sb.append("parent.frames[3].location = \"nic.jsp\";\r\n");
sb.append("<////%\r\n");
sb.append("////if (request.getParameter(\"akcija\")==null) {\r\n");
sb.append("%////>\r\n");

sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");
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
sb.append("<p align=\"center\">PODATKI VNESENI/SPREMENJENI</td>\r\n");
sb.append("</tr>\r\n");
sb.append("<tr>\r\n");
sb.append("<td width=\"100%\"  class=\"opiscell\">&nbsp;</td>\r\n");
sb.append("</tr>\r\n");
sb.append("</table>\r\n");

sb.append("<script language=javascript>\r\n");
sb.append("var mon = parent.frames[1].document.location+\"\";\r\n");

sb.append("<////%\r\n");
sb.append("////if (request.getParameter(\"akcija\")!=null && !request.getParameter(\"akcija\").equals(\"NEW\")) {\r\n");
sb.append("%////>\r\n");
sb.append("if (mon.indexOf(\"idback\")!=-1) {\r\n");

sb.append("parent.frames[1].document.location = mon.substring(0,mon.indexOf(\"idback\")-1)+\"?idback=<////%=request.getParameter(\"id\")%////>\";\r\n");


sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("if (mon.indexOf(\"?\")!=-1) {\r\n");
sb.append("if (mon.indexOf(\"id=\")!=-1) {\r\n");
sb.append("parent.frames[1].document.location = mon.substring(0,mon.indexOf(\"?\")) + \"?idback=<////%=request.getParameter(\"id\")%////>\";\r\n");
     
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("parent.frames[1].document.location = parent.frames[1].document.location + \"&idback=<////%=request.getParameter(\"id\")%////>\";\r\n");
sb.append("}\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
sb.append("parent.frames[1].document.location = parent.frames[1].document.location + \"?idback=<////%=request.getParameter(\"id\")%////>\";\r\n");

sb.append("}\r\n");
sb.append("}\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("////else {\r\n");
sb.append("%////>\r\n");
sb.append("if (mon.indexOf(\"id=\")!=-1) {\r\n");
    
sb.append("parent.frames[1].document.location = mon.substring(0,mon.indexOf(\"?\"));\r\n");
sb.append("}\r\n");
sb.append("else {\r\n");
    
sb.append("parent.frames[1].document.location = parent.frames[1].document.location;\r\n");
sb.append("}\r\n");
sb.append("<////%\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");
sb.append("</script>\r\n");

sb.append("<////%\r\n");
sb.append("////}\r\n");

sb.append("////}\r\n");
sb.append("////catch (Exception ex){\r\n");
sb.append("////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");

sb.append("////log.error(ex.toString());\r\n");
sb.append("////}\r\n");
sb.append("%////>\r\n");





}
////konec kreacija jsp za update/insert
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




Writer out3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("c:/"+imefile+".jsp"), "latin1"));



out3.write(sb.toString().replaceAll("< %=","<////%=").replaceAll("////",""));
////zaprem writer3
out3.close();


}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());

log.error(ex.toString());
}

%>



