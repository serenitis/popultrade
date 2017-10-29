package com.popultrade.webapp;

import java.io.FileInputStream;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.jar.JarEntry;
import java.util.jar.JarInputStream;

import javax.servlet.ServletContext;

import com.popultrade.model.TemplatePdfParametri;

public class TemplateUtilsExp  implements java.io.Serializable {
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 3255679876542657891L;
	/// lokacija jar
	private  String lokacija_jar = "e:/Tomcat5.0/webapps/popultrade/WEB-INF/lib/popultrade-dao.jar";
	//private final String lokacija_jar = "c:/Tomcat5.0/webapps/popultrade/WEB-INF/lib/popultrade-dao.jar";
	public chkNull nul = new chkNull();
	
	private control cont = new control();
	
	/// package name
	private  String packageName_fixno = "com.popultrade.model";
	
	
	private Parametri parametri = new Parametri();
	
	public TemplateUtilsExp() {
		try {
		this.lokacija_jar = parametri.getParametri().getProperty("lokacija_jar");
		this.packageName_fixno = parametri.getParametri().getProperty("packageName_fixno");
		}
		catch (Exception er) {
			
		}
		}
	
	
	
	
	//////////////////
	//////////////////
	///////////////////
	////// kreacija pdf funkcija
	///////////////////
	
	




	private String genList_EDI2(com.popultrade.model.TemplateClassClass tui,String idfunkcije,String class1,boolean jecount) {
		
		
		
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("if (true) {\r\n");
		

			sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
			sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
			//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
			sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");


		
	//sb.append("String rezu=\"\";\r\n\r\n");


	String imenavrstic = "";



	sb.append("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n");

	sb.append(" mod"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name() +")(it"+idfunkcije+class1+".next());\r\n");
		

	//sb.append( "sbu.append(\"<vrstica"+idfunkcije+">\");\r\n");	
	//sb.append( "%////>\r\n");
	int zapoo = 1;
	Iterator itbv = tui.getTemplatelists().iterator();

	while (itbv.hasNext()) {

	com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();


	/// pogledam, ce ima pogoje

	if (tli.getTemplateClasses().size()>0) {
	 
	 Iterator iteb = tli.getTemplateClasses().iterator();
	// sb.append("<%\r\n");
	 
	 
	// String remu = ""; /////// format number , ce je double in ce ima vnesen format

	// nul.getDatumFormatFromDate()
	 while (iteb.hasNext()) {
		 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
		 
		 
		 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
					 
			
			 
			 /// pogoj
			 sb.append("\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n");
			 
			 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
				 sb.append("rezu=nul.formatNumber(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
				 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
			 }
			 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
				 sb.append("rezu=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
			 }
			 else {
	 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
					 
					sb.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n");
						 
					 
				 }
				 else {
				 sb.append("rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
				 }
				 }
				 
			 
			 
			 sb.append("}\r\n");
			 
		 }
		 
		 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
			 
				
			 
			 
			 
			 /// vrednost iz clase
			 
			 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
	/// pogoj
	if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
	sb.append( nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get")+" {\r\n");
	}

	sb.append("if (true) {\r\n");
	sb.append("rezu=\"\";\r\n");	 		 
	sb.append("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n");

	sb.append("com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n");




	/// setam vrednosti

	Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

	Hashtable metto = this.getClassMetodeImenaHT(tc.getTemplateClassClass().getClass_name());

	while (tre.hasNext()) {
	com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();

	/////// /////// /////////


	String rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("\'","\"");

	if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get","mod"+idfunkcije+class1+".get")+"()";
	}

	//System.out.println(((String)metto.get(tcc.getIme_pogoja()))+ " ::: IME POGOJA ::: "+tcc.getIme_pogoja());

	if (metto.containsKey(tcc.getIme_pogoja())) {
	if (((String)metto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
		
	//System.out.println("SOLEMMM : "+rett);

	if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1 || nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
		//rett = rett+"\"\"";
	}

	else	if (rett.indexOf("\"")==-1) {
			rett = "\""+rett+"\"";
		}
	}
	else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
		if (rett.indexOf("\"")==-1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			rett = "\""+rett+"\"";
		}
		
		rett = "new Long("+rett+")";
		
	}
	else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)metto.get(tcc.getIme_pogoja())).indexOf("int")!=-1) {
		if (rett.indexOf("\"")==-1) {
			
		
		rett = rett.replaceAll("\"", "").replaceAll("\'", "");
		rett = "\""+rett+"\"";
		}
		
		rett = "Integer.parseInt("+rett+"+\"\")";
		
	}
	else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
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
	//sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");



	if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
		sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
		
	}
	else {
		

	sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
	}





	}


	sb.append("List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n");




	sb.append("if (remi.size()>0) {\r\n");

	sb.append("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n");




	////pogoji vrednosti

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
			 sb.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get")+" {\r\n");
			 
			 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
				 sb.append("rezu=nul.formatNumber(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
				 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
			 }
			 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
				 sb.append("rezu=nul.getDatumFormatFromDate(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
			 }
			 else {
	 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
					 
					 sb.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
						 
					 
				 }
				 else {
				 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
				 }
				 }
				 
			 
			 
			 sb.append("}\r\n");
			 
		 }
		 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
			 
			 
	if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
				 
				 sb.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
					 
				 
			 }
			 else {
			 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
			 }
		 }
		 }
	}
	else {
	String dodvred = "";
	if (!nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
		dodvred = " "+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
	}
		

	sb.append("rezu="+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n");
	}



	}




	sb.append("}\r\n");



	sb.append("}\r\n");


	if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
	sb.append("}\r\n");
	}			 
				 
				 
			 }
			 
			 
			 
			 
			 
			 
			 
			 
			 
		 }
		 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
			 
	if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
				 
				 sb.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n");
					 
				 
			 }
			 else {
			 sb.append("rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
			 }
		 }
		 
		 
	 }
	 
//	 sb.append("%////>\r\n");
	 
	 
	 
	 
	}
	else {
	 
	 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
		// sb.append("<%\r\n");
		 sb.append("rezu=nul.formatNumber(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
		/// sb.append("%////>\r\n");
		 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
	 }
	 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
		// sb.append("<%\r\n");
		 sb.append("rezu=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
		// sb.append("%////>\r\n");
	 }
	 else {
		// sb.append("<%\r\n");
		 sb.append("rezu=nul.jeNull(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
		// sb.append("%////>\r\n");
	 }
	}



	// String hinto = "";
	/// ce ima hinte stolpec
	// if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
	// hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(typeof(p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_mettoda()+"())%////>)=='string'?p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_mettoda()+"())%////>:'')\"";
	 
	// }


	if (nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals("") ) {
	 
	// sb.append("<%\r\n");
	 sb.append("rezu=nul.cutString(rezu,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n");
	// sb.append("%////>\r\n");
	 
	 
	}



	//sb.append("<%\r\n");
	sb.append("sbu.append(\"\"+nul.getEDIFormat(rezu,"+tli.getStolpec_width()+",\""+tli.getStolpec_align()+"\")+\"\");\r\n");
	//sb.append("%////>\r\n");
	

	zapoo++;

	}

	sb.append("sbu.append(\"\\r\\n\");\r\n");	

	//sb.append("<////%\r\n");



	sb.append("//////DOME"+idfunkcije+"//////\r\n");



		
		
	sb.append("}  // while end\r\n");		
		



		
		sb.append("}\r\n");
		
		
		sb.append("}\r\n");
		
		return sb.toString();
		
		
		
		
	}
	
	
	
	
	
	
	
	

	
	
	public String[] generirajFunkcijo_EDI(ContextUtil contextUtil,ServletContext servletContext,String idfunkcije,control comm,int zapom) {
		
		this.cont=comm;
		
		String[] rettu = new String[4];
		StringBuffer sb = new StringBuffer();
		StringBuffer sbfo = new StringBuffer();
		StringBuffer sbfo_template = new StringBuffer();
		try {
			ht_loop.clear();
			ht_loop_id.clear();
			
			ht_loopfo.clear();
			ht_loopfo_id.clear();
			
			
			zapi=0;
			com.popultrade.dao.TemplateFunkcijaStartDAO daol = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",servletContext);
			
			
			com.popultrade.model.TemplateFunkcijaStart tfs = daol.getTemplateFunkcijaStart(new Long(idfunkcije));
			
			if (tfs!=null && tfs.getTemplateClassClass()!=null && tfs.getTemplateClassClass().getClass_name()!=null && !tfs.getTemplateClassClass().getClass_name().equals("")) {
				
				sb.append("if (true) {\r\n");
				
				com.popultrade.model.TemplateClassClass tcc = tfs.getTemplateClassClass();
				
				/// dobim classclass
				
				String class1 = tcc.getClass_name();
				rettu[1] = class1;
				String classtip ="";
				if (tcc.getTip_funkcije()!=null && !tcc.getTip_funkcije().equals("")) {
				classtip = tcc.getTip_funkcije();
				}
				
				
				
				 
				sb.append("com.popultrade.dao."+class1+"DAO doa"+tcc.getId()+class1+" =(com.popultrade.dao."+ class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0,1).toLowerCase() +class1.substring(1) +"DAO\",pageContext.getServletContext());\r\n");

				sb.append("com.popultrade.model."+class1 +" mod"+tcc.getId()+class1+" = new com.popultrade.model."+class1 +"();\r\n");

				
				/// setam vrednosti

				Iterator tre = tfs.getTemplateClassClass().getTemplateClasss().iterator();

				/// dobim tipe funkcij
				
				Hashtable meto = this.getClassMetodeImenaHT(tcc.getClass_name());

				while (tre.hasNext()) {
					com.popultrade.model.TemplateClass tcci = (com.popultrade.model.TemplateClass)tre.next();
					
				if (nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter")) {
						String rett=tcci.getVrednost_pogoja().replaceAll("\'","\"")+"+\"\"";
						
						//System.out.println(meto.get(tcci.getIme_pogoja())+":::::::::::::::::::: s :::::::::::::: "+tcci.getIme_pogoja());
						if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
							
							
							
							rett = "new Long("+rett+")";
							
							
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int")!=-1) {
							rett = "Integer.parseInt("+rett+")";
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
						
							rett = "Double.parseDouble("+rett+")";
						}
						
						
			if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
							
							
						
						
									sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idfunkcije+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
								
								
							
						}
						
						
					sb.append("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");
					if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						sb.append(" }\r\n");
					}
					
					}
					else {
						
						
						String rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get",""+tcc.getId()+".get").replaceAll("\'","\"");
						
						if (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter")!=-1) {
							 rett = tcci.getVrednost_pogoja().replaceAll("\'","\"");
						}
						
						
						if (rett.indexOf("get")==-1 || rett.indexOf("request.getParameter")!=-1) {
						//System.out.println("DDDDDDDD "+tcci.getIme_pogoja()+" :::: "+((String)meto.get(tcci.getIme_pogoja())));
						if (meto.containsKey(tcci.getIme_pogoja())) {
							if (((String)meto.get(tcci.getIme_pogoja())).indexOf("String")!=-1) {
								if (rett.indexOf("\"")==-1) {
									rett = "\""+rett+"\"";
								}
							}
							else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
							
								if (rett.indexOf("\"")==-1) {
									rett = "\""+rett+"\"";
								}
								
								rett = "new Long("+rett+")";
								
								
								
							}
							else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1) {
								if (rett.indexOf("\"")!=-1) {
									rett = rett.replaceAll("\"", "").replaceAll("\'", "");
								}
								
							}
							else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
								if (rett.indexOf("\"")!=-1) {
									rett = rett.replaceAll("\"", "").replaceAll("\'", "");
								}
								if (rett.indexOf(",")!=-1) {
									rett = rett.replaceAll("\\,", "\\.");
								}
								
							}
							
						}
						}
						if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
					
							sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idfunkcije+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
										
						}
						sb.append("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");	
						
						if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
							sb.append(" }\r\n");
						}
						
						
					}
					
				}

				 if (classtip.equals("ER") || classtip.equals("LI") || classtip.equals("CO")) { /// iscem le en rezultat
					 sb.append("List remi"+tcc.getId()+class1+"=doa"+tcc.getId()+class1+".get"+class1+"s(mod"+tcc.getId()+class1+");\r\n");

					 
					 if (classtip.equals("ER") || classtip.equals("LI")) {
					
				//	sb.append("if (remi"+idfunkcije+class1+".size()>0) {\r\n");

					//sb.append("mod"+idfunkcije+class1+"=(com.popultrade.model."+class1 +")remi"+idfunkcije+class1+".get(0);\r\n");
					
					//sb.append("}\r\n");
					
					
				if (tfs.getTemplatelists()!=null && tfs.getTemplatelists().size()>0) { ////// izpis tabele stolpcev
						
						sb.append(genList_EDI(tfs,tfs.getTemplateClassClass().getId()+"",class1,false) );
						//sbfo.append(genList_PDF_fo(tfs,idfunkcije,class1));
			//// dobim format viewja
						
						com.popultrade.dao.TemplatePdfParametriDAO dap = (com.popultrade.dao.TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO",servletContext);
						
						
						TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
						
					
						 
					}
					
					
					
					 }
		
					
				
					
					if (tfs.getTemplatelists().size()==0 && tfs.getTemplateviews().size()==0) {
						sb.append("//////DOME"+tcc.getId()+"//////\r\n");
					}
					
					
					
					 if (tfs.getTemplateClassClass()!=null && tfs.getTemplateClassClass().getClass_name()!=null && !tfs.getTemplateClassClass().getClass_name().equals("")) {
						 
						 //// funkcija
						 //sb.append("\r\n//////DOME//////\r\n");
						 
						// int flip = zapi;
						 System.out.println(classtip+ " :::----------------ssssssssXXXXXXXXXXXX ---------------------- +++++++++++++++++++ ---------------------------------");
							
						 ht_loop_id.put(zapi+"",tcc.getId());
						 zapi++;
						// System.out.println(tcc.getId()+" ::: ////////////88888888888////////////////////// |||||||||||||||||||| "+tfs.getTemplateClassClass().getId());
						 ht_loop.put(tcc.getId(), generirajFunkcijoLoop_EDI( contextUtil, servletContext,tfs.getTemplateClassClass().getId()+"", "","mod"+idfunkcije+class1,idfunkcije,sbfo,sbfo_template));
						 
					
					 }
					
					
					
				}
				/* else if (classtip.equals("UP") || classtip.equals("IN")) {
					 System.out.println("----------------ssssssss---------------------- +++++++++++++++++++ ---------------------------------");
						 
			 if (tfs.getTemplateClassClass()!=null && tfs.getTemplateClassClass().getClass_name()!=null && !tfs.getTemplateClassClass().getClass_name().equals("")) {
						 
						 //// funkcija
						 //sb.append("\r\n//////DOME//////\r\n");
						 System.out.println("-------------------------------------- +++++++++++++++++++ ---------------------------------");
						// int flip = zapi;
						 
						 ht_loop_id.put(zapi+"",tcc.getId());
						 zapi++;
						// System.out.println(tcc.getId()+" ::: ////////////88888888888////////////////////// |||||||||||||||||||| "+tfs.getTemplateClassClass().getId());
						 ht_loop.put(tcc.getId(), generirajFunkcijoLoop_PDF( contextUtil, servletContext,tfs.getTemplateClassClass().getId()+"", "","mod"+idfunkcije+class1,idfunkcije,sbfo,sbfo_template));
						 System.out.println("-------------------------------------- +++++++++++++++++++sssssss ---------------------------------");
							
					
					 }
					 
				 }*/
				
				
				 

				
			}///////////
			
			
			
			
			//// sestavi
			String retuu = sb.toString();
			if (tfs.getTemplatelists().size()==0 && tfs.getTemplateviews().size()==0) {
				retuu = "";
			}
		
			System.out.println(retuu);
			
			
			for (int u=0;u<ht_loop_id.size();u++) {
				if (u==0) {
				//	System.out.println(ht_loop_id.get(u+"")+"+++++++++++++++++++++++++++ "+u+" ++++++++++++++++++++++++++++"+(String)ht_loop.get(ht_loop_id.get(u+"")));
					if (tfs.getTemplatelists().size()==0 && tfs.getTemplateviews().size()==0) {
					if (retuu.indexOf("//////DOME"+ht_loop_id.get(u+"")+"//////")!=-1) {
						retuu = retuu.replaceFirst("//////DOME"+ht_loop_id.get(u+"")+"//////",(String)ht_loop.get(ht_loop_id.get(u+"")));	
						}
						else {
							retuu = retuu + (String)ht_loop.get(ht_loop_id.get(u+""));	
						}
				}
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					
					System.out.println(retuu);
				}
				else if (u==1) {
				//	System.out.println(ht_loop_id.get(u+"")+"+++++++++++++++++++++++++++ "+u+" ++++++++++++++++++++++++++++"+(String)ht_loop.get(ht_loop_id.get(u+"")));
						if (retuu.indexOf("//////DOME0//////")!=-1) {
					retuu = retuu.replaceFirst("//////DOME0//////",(String)ht_loop.get(ht_loop_id.get(u+"")));
						}
						else {
							if (retuu.indexOf("//////DOME"+ht_loop_id.get(u+"")+"//////")!=-1) {
								retuu = retuu.replaceFirst("//////DOME"+ht_loop_id.get(u+"")+"//////",(String)ht_loop.get(ht_loop_id.get(u+"")));	
								}
								else {
									retuu = retuu + (String)ht_loop.get(ht_loop_id.get(u+""));	
								}
						}
						System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
						System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
						System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
						System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
						System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
						System.out.println(retuu);
						}
				else {
				//	System.out.println(ht_loop_id.get(u+"")+"+++++++++++++++++++++++++ "+u+" ++++++++++++++++++++++++++++++ ::: ");
				//	System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: "+(String)ht_loop.get(ht_loop_id.get(u+"")));
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");				
					if (retuu.indexOf("//////DOME"+ht_loop_id.get(u+"")+"//////")!=-1) {
					retuu = retuu.replaceFirst("//////DOME"+ht_loop_id.get(u+"")+"//////",(String)ht_loop.get(ht_loop_id.get(u+"")));	
					}
					else {
						retuu = retuu + (String)ht_loop.get(ht_loop_id.get(u+""));	
					}
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");		
					System.out.println(retuu);
					}
				
				
			}
			
			if (tfs.getTemplatelists().size()==0 && tfs.getTemplateviews().size()==0) {
			//	retuu = "";
			}
			else {
			retuu=retuu + "}\r\n";
			}
			//sb.append("}\r\n");
			
			rettu[0] = retuu;
			rettu[2] = sbfo.toString();
			rettu[3] = sbfo_template.toString();
			return rettu;
			
			
		}
		catch (Exception ex) {
			System.out.println("Napaka pri generaciji funkcije: "+ex.toString());
		}
		
		return null;
	}
	
	
private String generirajFunkcijoLoop_EDI(ContextUtil contextUtil,ServletContext servletContext,String idnaprej,String sbb,String idprej,String idfunk,StringBuffer sbfo,StringBuffer sbfo_template) {
		
		try {
			
			StringBuffer sb = new StringBuffer();
			
			com.popultrade.dao.TemplateClassClassDAO daol = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",servletContext);
			
			sb.append("if (true) {\r\n");
			
			com.popultrade.model.TemplateClassClass tcc = daol.getTemplateClassClass(new Long(idnaprej));
			
			/// dobim classclass
			
			String class1 = tcc.getClass_name();
			
			String classtip ="";
			if (tcc.getTip_funkcije()!=null && !tcc.getTip_funkcije().equals("")) {
			classtip = tcc.getTip_funkcije();
			}
			
			
			
			 if (!classtip.equals("UP")) {
			sb.append("com.popultrade.dao."+class1+"DAO doa"+idnaprej+class1+" =(com.popultrade.dao."+ class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0,1).toLowerCase() +class1.substring(1) +"DAO\",pageContext.getServletContext());\r\n");

			sb.append("com.popultrade.model."+class1 +" mod"+idnaprej+class1+" = new com.popultrade.model."+class1 +"();\r\n");
			 }
			
			/// setam vrednosti

			Iterator tre = tcc.getTemplateClasss().iterator();

			/// dobim tipe funkcij
			
			Hashtable meto = this.getClassMetodeImenaHT(tcc.getClass_name());

			while (tre.hasNext()) {
				com.popultrade.model.TemplateClass tcci = (com.popultrade.model.TemplateClass)tre.next();
	 if (nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.")  || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter")  ) {
					String rett=tcci.getVrednost_pogoja().replaceAll("\'","\"")+"+\"\"";
					
					//System.out.println(meto.get(tcci.getIme_pogoja())+":::::::::::::::::::: s :::::::::::::: "+tcci.getIme_pogoja());
					if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
						
						
						
						rett = "new Long("+rett+")";
						
						
						
					}
					else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int")!=-1) {
						rett = "Integer.parseInt("+rett+")";
						
					}
					else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
					
						rett = "Double.parseDouble("+rett+")";
					}
					//// dam pogoj ce je
					if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						
											
					
							if (nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")) {
						sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+idprej+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							else {
								sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idnaprej+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							
						
					}
					
				
					
				sb.append("mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");
					
				
				if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
					sb.append(" }\r\n");
				}
				
				}
				else {
					
					
					String rett = "";
					
					
					if (nul.jeNull(tcci.getIzvor_vrednosti()).equals("V")) {
					rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get",""+idprej+".get").replaceAll("\'","\"");
					}
					else {
						rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get",""+"mod"+idnaprej+class1+".get").replaceAll("\'","\"");
						
						
					}
					
					if (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter")!=-1) {
						 rett = tcci.getVrednost_pogoja().replaceAll("\'","\"");
					}
					
					
					if (rett.indexOf("get")==-1 || rett.indexOf("request.getParameter")!=-1) {
					//System.out.println("DDDDDDDD "+tcci.getIme_pogoja()+" :::: "+((String)meto.get(tcci.getIme_pogoja())));
					if (meto.containsKey(tcci.getIme_pogoja())) {
						if (((String)meto.get(tcci.getIme_pogoja())).indexOf("String")!=-1) {
							if (rett.indexOf("\"")==-1) {
								rett = "\""+rett+"\"";
							}
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
						
							if (rett.indexOf("\"")==-1) {
								rett = "\""+rett+"\"";
							}
							
							rett = "new Long("+rett+")";
							
							
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1) {
							if (rett.indexOf("\"")!=-1) {
								rett = rett.replaceAll("\"", "").replaceAll("\'", "");
							}
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
							if (rett.indexOf("\"")!=-1) {
								rett = rett.replaceAll("\"", "").replaceAll("\'", "");
							}
							if (rett.indexOf(",")!=-1) {
								rett = rett.replaceAll("\\,", "\\.");
							}
							
						}
						
					}
					}
					
					
			if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						
									
							if (nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")) {
						sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+idprej+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							else {
								sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idnaprej+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							
						
					}
			
			
					sb.append("mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");	
					
					
					
					if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						sb.append(" }\r\n");
					}
					
					
				}
				
			}
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("++++++++++++++++++++++++"+classtip+"++++++++++++++++++++++++++++++");
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

if (classtip.equals("IN") || classtip.equals("UP")) {
	
	
	sb.append("doa"+(classtip.equals("UP")?idfunk:idnaprej)+class1+".save"+class1+"(mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+");\r\n");
	//if (tfs.getTemplatelists().size()==0 && tfs.getTemplateviews().size()==0) {
	//	sb.append("//////DOME"+tcc.getId()+"//////\r\n");
	//}
	//String remio = genViews_Exp2(tcc,idnaprej,class1,false,contextUtil,servletContext,vred,idnaprej);
//	sb.append(remio);
}

		 if (classtip.equals("ER") || classtip.equals("LI") || classtip.equals("CO")) { /// iscem le en rezultat
				
				sb.append("List remi"+idnaprej+class1+"=doa"+idnaprej+class1+".get"+class1+"s(mod"+idnaprej+class1+");\r\n");

				
				
				
		 if (tcc.getTemplatelists()!=null && tcc.getTemplatelists().size()>0) { ////// izpis tabele stolpcev
					
					
					String remio = "";
					
				
						 remio = genList_EDI2(tcc,idnaprej,class1,false); 
					 
					/*if (sb.toString().indexOf("//////DOME"+idfunk+"//////")!=-1) {
						
						String repl =  sb.toString();

						String en = repl.substring(0,repl.indexOf("//////DOME"+idfunk+"//////"));
						String dv = repl.substring(repl.indexOf("//////DOME"+idfunk+"//////")+("//////DOME"+idfunk+"//////").length(),repl.length());

						sb.delete(0,sb.length());
						sb.append(en+remio+dv);

					}
					else {*/
						sb.append(remio);
						
						
						
						
						
						
						System.out.println("////////////////////////////////////////////////////////////");
						System.out.println("////////////////////////////////////////////////////////////");
					//	System.out.println(idfunk+"///remio////////////////////////////////////////////////////"+remio);
						System.out.println("////////////////////////////////////////////////////////////");
						System.out.println("////////////////////////////////////////////////////////////");
						System.out.println("////////////////////////////////////////////////////////////");
						
			
				}
				

				
				else {
				
				
			sb.append("if (remi"+idnaprej+class1+".size()>0) {\r\n");

				sb.append("mod"+idnaprej+class1+"=(com.popultrade.model."+class1 +")remi"+idnaprej+class1+".get(0);\r\n");
				
				sb.append("}\r\n");
				}
				
				
				
				
				
				
				Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
				//boolean prvavrednost=false;
				if (tcc.getTemplateClassClass_vrednostis().size()>0) {
				while (vredno.hasNext()) {
					com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();
					System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
					System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: "+tcc.getTemplateClassClass_vrednostis().size());
					System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
					if (tcv.getTemplateClasses().size()>0) {
					//	System.out.println(":::yyyyyyy::::: "+tcc.getTemplateClassClass_vrednostis().size());
							/// dobim templateclass
							Iterator item = tcv.getTemplateClasses().iterator();
									 while (item.hasNext()) {
									 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
									 
									 
									 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
										 
										
										 
										 /// pogoj
										 sb.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get")+" {\r\n");
										 
										/* if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
											 sb.append("rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
											 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
										 }
										 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
											 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
										 }
										 else {*/
											 if (txc.getTemplateClassClass()!=null && txc.getTemplateClassClass().getClass_name()!=null && !txc.getTemplateClassClass().getClass_name().equals("")) {
												 
												 //// funkcija
												
												 
												 
												 if (tcc.getTemplateviews().size()==0 && tcc.getTemplatelists().size()==0) {
												 sb.append("//////DOME"+idnaprej+"//////\r\n");
												 }
												 
												 if (!ht_loop.containsKey(idnaprej)) {
												 
												 ht_loop_id.put(zapi+"", idnaprej);
												 
												 zapi++;
												 ht_loop.put(idnaprej,generirajFunkcijoLoop_EDI( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,sbfo,sbfo_template));
												 
												 
												 
												 }
												 else {
													 ht_loop.put(idnaprej,ht_loop.get(idnaprej)+generirajFunkcijoLoop_EDI( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,sbfo,sbfo_template));
													 
													 
												 }
							
												 
												 
												 
												 
												 
												 
											 }
											 else {
											if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
												 sb.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
												 }
											 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
												 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
											  
											 }
											 }
											 // }
											 
										 
										 
										 sb.append("}\r\n");
										 
									 }
									 else { /// v primeru, da je format
										 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get")==-1) {
											
											 if (!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1")) {
												 //sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
												 if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
												// sb.append("rezu="+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+";\r\n\r\n");
												 sb.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","nul.je").replaceAll("request.geetParameter","request.getParameter")+")+\"\";\r\n\r\n");
												 }
											 }
														 else {
															 
															 
																 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]")!=-1) {
																	 String dodd = "";
																	 
																	 if (nul.jeNull(txc.getVrednost_pogoja()).length()>"[SIZE]".length()) {
																		 dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]")+1,nul.jeNull(txc.getVrednost_pogoja()).length());
																	 }
																	 sb.append("rezu=(remi"+(classtip.equals("UP")?idfunk:idnaprej)+class1+".size() "+dodd+") + \"\";\r\n");
																 }
																 else {
															 
															 
															 sb.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+")+\"\";\r\n\r\n");
																 }
														 }
											 
											 
											// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
												
										 
										 
										 }
												 else {
													 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
														
												 }
										 if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
											 sb.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
											 }
										 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
											// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
										 
										 }
									 }
									 }
							}
							else {
							//	System.out.println(":::::bbbbbbbbb::: "+tcc.getTemplateClassClass_vrednostis().size());
								if (nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
									//System.out.println("::::vvvvvvvv:::: "+tcc.getTemplateClassClass_vrednostis().size());
								sb.append("rezu=mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n");
								}
							}
					
					
					
					
					
					
				}
				}
				
				

				
				
				
			}
		 else if (classtip.equals("UP") || classtip.equals("IN")) { /////////////// update insert
			 
			 
			 
				Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
				//boolean prvavrednost=false;
				if (tcc.getTemplateClassClass_vrednostis().size()>0) {
				while (vredno.hasNext()) {
					com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();
					System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
					System.out.println("::xxxxxx ||||||||||||||||dddddddddddddddd||||||||||||||||| :::::: "+tcc.getTemplateClassClass_vrednostis().size());
					System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
					if (tcv.getTemplateClasses().size()>0) {
					//	System.out.println(":::yyyyyyy::::: "+tcc.getTemplateClassClass_vrednostis().size());
							/// dobim templateclass
							Iterator item = tcv.getTemplateClasses().iterator();
									 while (item.hasNext()) {
									 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
									 
									 
									 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
										 
										
										 
										 /// pogoj
										 sb.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get")+" {\r\n");
										 
										/* if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
											 sb.append("rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
											 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
										 }
										 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
											 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
										 }
										 else {*/
											 if (txc.getTemplateClassClass()!=null && txc.getTemplateClassClass().getClass_name()!=null && !txc.getTemplateClassClass().getClass_name().equals("")) {
												 
												 //// funkcija
													//if (tfs.getTemplatelists().size()==0 && tfs.getTemplateviews().size()==0) {
														
													//}
												 
												 
												 if (tcc.getTemplateviews().size()==0 && tcc.getTemplatelists().size()==0) {
													 sb.append("//////DOME"+idnaprej+"//////\r\n");
													 }
												 
												 if (!ht_loop.containsKey(idnaprej)) {
												 
												 ht_loop_id.put(zapi+"", idnaprej);
												 
												 zapi++;
												 ht_loop.put(idnaprej,generirajFunkcijoLoop_EDI( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,sbfo,sbfo_template));
												 
												 
												 
												 }
												 else {
													 ht_loop.put(idnaprej,ht_loop.get(idnaprej)+generirajFunkcijoLoop_EDI( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,sbfo,sbfo_template));
													 
													 
												 }
							
												 
												 
												 
												 
												 
												 
											 }
											 else {
											if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
												 sb.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
												 }
											 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
												 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
											  
											 }
											 }
											 // }
											 
										 
										 
										 sb.append("}\r\n");
										 
									 }
									 else { /// v primeru, da je format
										 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get")==-1) {
											
											 if (!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1")) {
												 //sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
												 if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
												// sb.append("rezu="+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+";\r\n\r\n");
												 sb.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","nul.je").replaceAll("request.geetParameter","request.getParameter")+")+\"\";\r\n\r\n");
												 }
											 }
														 else {
															 
															 
																 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]")!=-1) {
																	 String dodd = "";
																	 
																	 if (nul.jeNull(txc.getVrednost_pogoja()).length()>"[SIZE]".length()) {
																		 dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]")+1,nul.jeNull(txc.getVrednost_pogoja()).length());
																	 }
																	 sb.append("rezu=(remi"+(classtip.equals("UP")?idfunk:idnaprej)+class1+".size() "+dodd+") + \"\";\r\n");
																 }
																 else {
															 
															 
															 sb.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+")+\"\";\r\n\r\n");
																 }
														 }
											 
											 
											// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
												
										 
										 
										 }
												 else {
													 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
														
												 }
										 if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
											 sb.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
											 }
										 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
											// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
										 
										 }
									 }
									 }
							}
							else {
							//	System.out.println(":::::bbbbbbbbb::: "+tcc.getTemplateClassClass_vrednostis().size());
								if (nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
									//System.out.println("::::vvvvvvvv:::: "+tcc.getTemplateClassClass_vrednostis().size());
								sb.append("rezu=mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n");
								}
							}
					
					
					
					
					
					
				}
				}
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
		 }

			
			
			
			
		 sb.append("}\r\n");
			
			return sb.toString();
			
		}
		catch (Exception en) {
			System.out.println("Napaka loop gen funkcija: "+en.toString());
		}
		return "";
		
	}
	
	//////////////////
	//////////////////
	//////////////////
	////// end kreacija pdf funkcija
	//////////////////
	/////////////////
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	/// dobim vse model classe
	
	public  List getClasseNamesInPackage (String jarName, String packageName){
		
		// za zdaj dam fiksno lokacijo in package name (varnost)
		jarName = lokacija_jar;
		packageName = this.packageName_fixno;
		 ArrayList classes = new ArrayList ();

		 packageName = packageName.replaceAll("\\." , "/");
		
		 try{
		   JarInputStream jarFile = new JarInputStream
		      (new FileInputStream (jarName));
		   JarEntry jarEntry;

		   while(true) {
		     jarEntry=jarFile.getNextJarEntry ();
		     if(jarEntry == null){
		       break;
		     }
		     if((jarEntry.getName ().startsWith (packageName)) &&
		          (jarEntry.getName ().endsWith (".class")) ) {
		    	 
		    	 
		    //  System.out.println("Found " + jarEntry.getName().replaceAll("/", "\\.").replaceAll("", packageName).replaceAll(".class", ""));
		       classes.add (jarEntry.getName().replaceAll("/", "\\.").replaceAll(this.packageName_fixno+".", "").replaceAll(".class", ""));
		    
		     
		     }
		   }
		 }
		 catch( Exception e){
		   e.printStackTrace ();
		 }
		 return sortedListValues(classes);
		}
	
	
	
	
	public List getClassMetodeImena(String ime_classe) {
		
		ArrayList imena = new ArrayList ();
		try {
			 Class testClass= Class.forName(ime_classe);

			 //Get the methods
			 Method[] methods = testClass.getDeclaredMethods();

			 //Loop through the methods and print out their names
			 for (Method method : methods) {
			     //System.out.println(method.getName());
			   //  Class parameters[] = {String.class};

			  //   Method myMethod = testClass.getMethod(method.getName(), parameters);
			       //     Object arguments[] = {"name"};
			         //   myMethod.invoke(objectToCallMethodOn, arguments);
			     
			     
			     
			     if (method.getName()!=null && method.getName().startsWith("get")) {
			     imena.add (method.getName() + " ----XXX---- "+method.getReturnType());
			     }
			 }

			}
			catch (ClassNotFoundException ex) {
				System.out.println("Napaka pri pridobivanju imena clase! "+ex.toString());
			}

		return sortedListValues(imena);
		
	}
	
	
	
	//// metode za kreacijo pogojev
	public Hashtable getClassMetodeImenaHT(String ime_classe) {
		Hashtable metode = new Hashtable();
		//ArrayList imena = new ArrayList ();
		try {
			 Class testClass= Class.forName(packageName_fixno+"."+ime_classe);

			 //Get the methods
			 Method[] methods = testClass.getDeclaredMethods();

			 //Loop through the methods and print out their names
			 for (Method method : methods) {
			     //System.out.println(method.getName() + "-------------");
			   //  Class parameters[] = {String.class};

			  //   Method myMethod = testClass.getMethod(method.getName(), parameters);
			       //     Object arguments[] = {"name"};
			         //   myMethod.invoke(objectToCallMethodOn, arguments);
			     
			     
			     
			     if (method.getName()!=null && method.getName().startsWith("get")) {
			    	 //System.out.println("C: "+method.getName()+" M: "+method.getReturnType());
			    	 metode.put (method.getName().replaceAll("get","set"),method.getReturnType()+"");
			     }
			 }

			}
			catch (ClassNotFoundException ex) {
				System.out.println("Napaka pri pridobivanju imena clase! "+ex.toString());
			}

		return sortedMapValues(metode);
		
	}
	
	
	
	//// sort list
	
	public List sortedListValues(List soro) { // a Hashtable is a Map
		// List rval = new ArrayList(map.values());
		 
		Collections.sort(soro); // assumes mutually Comparable values
		 return soro;
		 }
		 
	
	
	
	
	
	/////// sort ht
	
	public Hashtable sortedMapValues(Hashtable map) { // a Hashtable is a Map
		if (map!=null && map.size()>0) {
		Enumeration en = map.keys();
		List sorto = new ArrayList();
		while (en.hasMoreElements()) {
			
			sorto.add((String)en.nextElement());
			
		}
		
		
		// List rval = new ArrayList(map.values());
		 
		Collections.sort(sorto); // assumes mutually Comparable values
		
		
		Hashtable rett = new Hashtable();
		Iterator it = sorto.iterator();
		while (it.hasNext()) {
			
			String nexx = (String)it.next();
			
			rett.put(nexx, map.get(nexx));
			
		}
		
		
		
		
		
		 return rett;
		}
		else {
			return null;
		}
		
		}
		
		
		
		 
	
	
	
	
	public List getClassMetodeImenaSPodclasami(String ime_classe,String getset) {
		
		ArrayList imena = new ArrayList ();
		try {
			 Class testClass= Class.forName(ime_classe);

			 //Get the methods
			 Method[] methods = testClass.getDeclaredMethods();

			 //Loop through the methods and print out their names
			 for (Method method : methods) {
			    
			   //  Class parameters[] = {String.class};

			  //   Method myMethod = testClass.getMethod(method.getName(), parameters);
			       //     Object arguments[] = {"name"};
			         //   myMethod.invoke(objectToCallMethodOn, arguments);
			     
			     
			     
			     if (method.getName()!=null && method.getName().startsWith(getset)) {
			    	// System.out.println(method.getName() + " "+method.getReturnType());
			    	 
			      	 
			    	 if (method.getReturnType().toString().indexOf("String")==-1 
			    			 && method.getReturnType().toString().indexOf("Integer") ==-1 
			    			 && method.getReturnType().toString().indexOf("Long") ==-1 
			    			 && method.getReturnType().toString().indexOf("Double") ==-1 
			    			 && method.getReturnType().toString().indexOf("Date") ==-1 
			    			 && method.getReturnType().toString().indexOf("List")==-1 
			    			 && method.getReturnType().toString().indexOf("Byte")==-1 
			    			 && method.getReturnType().toString().indexOf("int")==-1 ) {
			    		 //// dobim pod metode
			    		 
			    		 TemplateUtilsExp tu = new TemplateUtilsExp();
			    		 
			    		 List li = new ArrayList();
			    		 
			    		 li=tu.getClassMetodeImenaSPodclasami(packageName_fixno+"."+method.getName().replaceAll(getset, ""), getset);
			    		 
			    		 Iterator enn = li.iterator();
			    		 
			    		 while (enn.hasNext()) {
			    			 String key = (String)enn.next();
			    		 
			    		// metode.put(method.getName()+"."+key, neww.get(key));
			    		 imena.add (method.getName() +"()."+key);
			    		 
			    		 }
			    		 
			    		 
			    		 
			    	 }
			    	 else {
			    		 imena.add (method.getName() + " ----XXX---- "+method.getReturnType());
			    	 }
			    	 
			    	 
			    	 
			    	 
			    	 
			    	 
			    	 
			   //  imena.add (method.getName() + " ----XXX---- "+method.getReturnType());
			     }
			 }

			}
			catch (ClassNotFoundException ex) {
				System.out.println("Napaka pri pridobivanju imena clase! "+ex.toString());
			}

		return sortedListValues(imena);
		
	}
	
	
	
	
	//// metode za izpis metod v klasi vkljucno z podclassami
	public Hashtable getClassMetodeImenaHTZPodclassami(String ime_classe,String getset) {
		Hashtable metode = new Hashtable();
		//ArrayList imena = new ArrayList ();
		try {
			 Class testClass= Class.forName(packageName_fixno+"."+ime_classe);

			 //Get the methods
			 Method[] methods = testClass.getDeclaredMethods();

			 //Loop through the methods and print out their names
			 for (Method method : methods) {
			    // System.out.println(method.getName() + "-------------");
			   //  Class parameters[] = {String.class};

			  //   Method myMethod = testClass.getMethod(method.getName(), parameters);
			       //     Object arguments[] = {"name"};
			         //   myMethod.invoke(objectToCallMethodOn, arguments);
			     
			     
			     
			     if (method.getName()!=null && method.getName().startsWith(getset)) {
			    	// System.out.println("CLASS: "+method.getName()+" M: "+method.getReturnType());
			    	 
			    	 
			    	 if (!method.getReturnType().toString().startsWith("String") 
			    			 && !method.getReturnType().toString().startsWith("Integer") 
			    			 && !method.getReturnType().toString().startsWith("Long") 
			    			 && !method.getReturnType().toString().startsWith("Double") 
			    			 && !method.getReturnType().toString().startsWith("Date") 
			    			 && !method.getReturnType().toString().startsWith("List")
			    			  && !method.getReturnType().toString().startsWith("Byte")
			    			 && !method.getReturnType().toString().startsWith("int")) {
			    		 //// dobim pod metode
			    		 
			    		 TemplateUtils tu = new TemplateUtils();
			    		 
			    		 Hashtable neww = new Hashtable();
			    		 
			    		 neww=tu.getClassMetodeImenaHTZPodclassami(method.getName().replaceAll(getset, ""), getset);
			    		 
			    		 Enumeration enn = neww.keys();
			    		 
			    		 while (enn.hasMoreElements()) {
			    			 String key = (String)enn.nextElement();
			    		 
			    		 metode.put(method.getName()+"."+key, neww.get(key));
			    		 }
			    		 
			    		 
			    		 
			    	 }
			    	 else {
			    	 metode.put (method.getName(),method.getReturnType()+"");
			    	 }
			    	 
			    	 
			    	 
			    	 
			     }
			 }

			}
			catch (ClassNotFoundException ex) {
				System.out.println("Napaka pri pridobivanju imena clase! "+ex.toString());
			}

		return sortedMapValues(metode);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//// metode za kreacijo pogojev
	public Hashtable getClassMetodeImenaHTGet(String ime_classe) {
		Hashtable metode = new Hashtable();
		//ArrayList imena = new ArrayList ();
		try {
			 Class testClass= Class.forName(packageName_fixno+"."+ime_classe);

			 //Get the methods
			 Method[] methods = testClass.getDeclaredMethods();

			 //Loop through the methods and print out their names
			 for (Method method : methods) {
			   //  System.out.println(method.getName() + "-------------");
			   //  Class parameters[] = {String.class};

			  //   Method myMethod = testClass.getMethod(method.getName(), parameters);
			       //     Object arguments[] = {"name"};
			         //   myMethod.invoke(objectToCallMethodOn, arguments);
			     
			     
			     
			     if (method.getName()!=null && method.getName().startsWith("get")) {
			    	// System.out.println("C: "+method.getName()+" M: "+method.getReturnType());
			    	 metode.put (method.getName(),method.getReturnType()+"");
			     }
			 }

			}
			catch (ClassNotFoundException ex) {
				System.out.println("Napaka pri pridobivanju imena clase! "+ex.toString());
			}

		return sortedMapValues(metode);
		
	}
	
	
	
	public Hashtable getFunkcijeZaFormat() {
		
		Hashtable imena = new Hashtable();
		imena.put ("nul.cutString","cutString(String vrednost,int size) odreze parameter vrednost na vneseni size");
	
		imena.put ("nul.addNule","addNule(String vrednost,int stnul) dodam nicle pred vrednost,stnul - max skupno st. znakov");
		
		imena.put ("nul.sestejDoubleVrednosti","sestejDoubleVrednosti(String id,Double[] vrednosti,String format_rezultata) sesteje vec double vrednosti skupaj in vrne rezultat na podlagi formata");
		imena.put ("nul.sestejDoubleVrednosti","sestejDoubleVrednosti(String id,Double[] vrednosti,String format_rezultata) sesteje vec double vrednosti skupaj in vrne rezultat na podlagi formata");
		imena.put ("nul.sestejIntegerVrednosti","sestejIntegerVrednosti(String id,Integer[] vrednosti) sesteje vec integer vrednosti skupaj in vrne rezultat");
		
		//imena.put ("nul.cutString","cutString(String vrednost,int size) odreze parameter vrednost na vneseni size");
		
		
		return imena;
	}
	
	
	
	public List getKonstantePriLogu() {
		
		ArrayList imena = new ArrayList ();
		imena.add ("control.idUporabnika");
		imena.add ("control.getPodjetje()");
		imena.add("nul.getDatumFormat('yyyy')");
		imena.add ("control.getJezik()");
		imena.add ("control.getUserName()");
		imena.add ("new Date()");
		imena.add("nul.addDaysToDate(Date dt,int stdni)");
		
		
		return imena;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//////////////////
	//////////////////
	///////////////////
	////// kreacija pdf funkcija
	///////////////////
	
	Hashtable ht_loop = new Hashtable();
	Hashtable ht_loop_id = new Hashtable();
	int zapi=0;
	int zapifo=0;
	
	Hashtable ht_loopfo = new Hashtable();
	Hashtable ht_loopfo_id = new Hashtable();
	
	
	public String[] generirajFunkcijo_EXP(ContextUtil contextUtil,ServletContext servletContext,String idfunkcije,control comm) {
		
		this.cont=comm;
		
		String[] rettu = new String[4];
		StringBuffer sb = new StringBuffer();
		StringBuffer sbfo = new StringBuffer();
		StringBuffer sbfo_template = new StringBuffer();
		try {
			ht_loop.clear();
			ht_loop_id.clear();
			
			ht_loopfo.clear();
			ht_loopfo_id.clear();
			
			
			zapi=0;
			com.popultrade.dao.TemplateFunkcijaStartDAO daol = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",servletContext);
			
			
			com.popultrade.model.TemplateFunkcijaStart tfs = daol.getTemplateFunkcijaStart(new Long(idfunkcije));
			
			if (tfs!=null && tfs.getTemplateClassClass()!=null && tfs.getTemplateClassClass().getClass_name()!=null && !tfs.getTemplateClassClass().getClass_name().equals("")) {
				
				sb.append("if (true) {\r\n");
				
				com.popultrade.model.TemplateClassClass tcc = tfs.getTemplateClassClass();
				
				/// dobim classclass
				
				String class1 = tcc.getClass_name();
				rettu[1] = class1;
				String classtip ="";
				if (tcc.getTip_funkcije()!=null && !tcc.getTip_funkcije().equals("")) {
				classtip = tcc.getTip_funkcije();
				}
				
				
				
				 
				sb.append("com.popultrade.dao."+class1+"DAO doa"+tcc.getId()+class1+" =(com.popultrade.dao."+ class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0,1).toLowerCase() +class1.substring(1) +"DAO\",pageContext.getServletContext());\r\n");

				sb.append("com.popultrade.model."+class1 +" mod"+tcc.getId()+class1+" = new com.popultrade.model."+class1 +"();\r\n");

				
				/// setam vrednosti

				Iterator tre = tfs.getTemplateClassClass().getTemplateClasss().iterator();

				/// dobim tipe funkcij
				
				Hashtable meto = this.getClassMetodeImenaHT(tcc.getClass_name());

				while (tre.hasNext()) {
					com.popultrade.model.TemplateClass tcci = (com.popultrade.model.TemplateClass)tre.next();
					
				if (nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter")) {
						String rett=tcci.getVrednost_pogoja().replaceAll("\'","\"")+"+\"\"";
						
						//System.out.println(meto.get(tcci.getIme_pogoja())+":::::::::::::::::::: s :::::::::::::: "+tcci.getIme_pogoja());
						if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
							
							
							
							rett = "new Long("+rett+")";
							
							
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int")!=-1) {
							rett = "Integer.parseInt("+rett+")";
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
						
							rett = "Double.parseDouble("+rett+")";
						}
						
						
			if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
							
							
						
						
									sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idfunkcije+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
								
								
							
						}
						
						
					sb.append("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");
					if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						sb.append(" }\r\n");
					}
					
					}
					else {
						
						
						String rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get",""+tcc.getId()+".get").replaceAll("\'","\"");
						
						if (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter")!=-1) {
							 rett = tcci.getVrednost_pogoja().replaceAll("\'","\"");
						}
						
						
						if (rett.indexOf("get")==-1 || rett.indexOf("request.getParameter")!=-1) {
						//System.out.println("DDDDDDDD "+tcci.getIme_pogoja()+" :::: "+((String)meto.get(tcci.getIme_pogoja())));
						if (meto.containsKey(tcci.getIme_pogoja())) {
							if (((String)meto.get(tcci.getIme_pogoja())).indexOf("String")!=-1) {
								if (rett.indexOf("\"")==-1) {
									rett = "\""+rett+"\"";
								}
							}
							else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
							
								if (rett.indexOf("\"")==-1) {
									rett = "\""+rett+"\"";
								}
								
								rett = "new Long("+rett+")";
								
								
								
							}
							else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1) {
								if (rett.indexOf("\"")!=-1) {
									rett = rett.replaceAll("\"", "").replaceAll("\'", "");
								}
								
							}
							else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
								if (rett.indexOf("\"")!=-1) {
									rett = rett.replaceAll("\"", "").replaceAll("\'", "");
								}
								if (rett.indexOf(",")!=-1) {
									rett = rett.replaceAll("\\,", "\\.");
								}
								
							}
							
						}
						}
						if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
					
							sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idfunkcije+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
										
						}
						sb.append("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");	
						
						if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
							sb.append(" }\r\n");
						}
						
						
					}
					
				}

				 if (classtip.equals("ER") || classtip.equals("LI") || classtip.equals("CO")) { /// iscem le en rezultat
					 sb.append("List remi"+tcc.getId()+class1+"=doa"+tcc.getId()+class1+".get"+class1+"s(mod"+tcc.getId()+class1+");\r\n");

					 
					 if (classtip.equals("ER") || classtip.equals("LI")) {
					
				//	sb.append("if (remi"+idfunkcije+class1+".size()>0) {\r\n");

					//sb.append("mod"+idfunkcije+class1+"=(com.popultrade.model."+class1 +")remi"+idfunkcije+class1+".get(0);\r\n");
					
					//sb.append("}\r\n");
					
					
				//	if (tfs.getTemplateviews()!=null && tfs.getTemplateviews().size()>0) {
						
						//sb.append(genViews_PDF(tfs,tcc.getId()+"",class1,false) );
						
						sb.append(genViews_Exp(tfs,tfs.getTemplateClassClass().getId()+"",class1,false,contextUtil, servletContext,tcc.getId()+"") );
						
			
						
				//	}
			
					
					
					
					 }
					 else if (classtip.equals("CO")) {
						 
						 
						 
							if (tfs.getTemplateviews()!=null && tfs.getTemplateviews().size()>0) {
								
							//	sb.append(genViews_Exp(tfs,tfs.getTemplateClassClass().getId()+"",class1,true) );

						
								
							}
			
						 
						 
					 }
					
					
					
					
					
					
					
					 if (tfs.getTemplateClassClass()!=null && tfs.getTemplateClassClass().getClass_name()!=null && !tfs.getTemplateClassClass().getClass_name().equals("")) {
						 
						 //// funkcija
						 //sb.append("\r\n//////DOME//////\r\n");
						 
						// int flip = zapi;
						 
						// ht_loop_id.put(zapi+"",tcc.getId());
						// zapi++;
						// System.out.println(tcc.getId()+" ::: ////////////88888888888////////////////////// |||||||||||||||||||| "+tfs.getTemplateClassClass().getId());
						// ht_loop.put(tcc.getId(), generirajFunkcijoLoop_EXP( contextUtil, servletContext,tfs.getTemplateClassClass().getId()+"", "","mod"+idfunkcije+class1,idfunkcije,sbfo,sbfo_template));
						 
					
					 }
					
					
					
				}

				
				
				 

				
			}///////////
			
			
			
			
			//// sestavi
			String retuu = sb.toString();
			for (int u=0;u<ht_loop_id.size();u++) {
				if (u==0) {
					System.out.println(ht_loop_id.get(u+"")+"+++++++++++++++++++++++++++ "+u+" ++++++++++++++++++++++++++++"+(String)ht_loop.get(ht_loop_id.get(u+"")));
				
				
				}
				else if (u==1) {
					System.out.println(ht_loop_id.get(u+"")+"+++++++++++++++++++++++++++ "+u+" ++++++++++++++++++++++++++++"+(String)ht_loop.get(ht_loop_id.get(u+"")));
						retuu = retuu.replaceFirst("//////DOME0//////",(String)ht_loop.get(ht_loop_id.get(u+"")));
				}
				else {
					System.out.println(ht_loop_id.get(u+"")+"+++++++++++++++++++++++++ "+u+" ++++++++++++++++++++++++++++++ ::: ");
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: "+(String)ht_loop.get(ht_loop_id.get(u+"")));
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");				
					if (retuu.indexOf("//////DOME"+ht_loop_id.get(u+"")+"//////")!=-1) {
					retuu = retuu.replaceFirst("//////DOME"+ht_loop_id.get(u+"")+"//////",(String)ht_loop.get(ht_loop_id.get(u+"")));	
					}
					else {
						retuu = retuu + (String)ht_loop.get(ht_loop_id.get(u+""));	
					}
					}
				
				
			}
			
			
			retuu=retuu + "}\r\n";
			//sb.append("}\r\n");
			
			rettu[0] = retuu;
			rettu[2] = sbfo.toString();
			rettu[3] = sbfo_template.toString();
			return rettu;
			
			
		}
		catch (Exception ex) {
			System.out.println("Napaka pri generaciji funkcije: "+ex.toString());
		}
		
		return null;
	}
	
	
private String generirajFunkcijoLoop_EXP(ContextUtil contextUtil,ServletContext servletContext,String idnaprej,String sbb,String idprej,String idfunk,com.popultrade.model.TemplateClassClass_vrednosti vred) {
		
		try {
System.out.println("generirajFunkcijoLoop_EXP _ __________________________________ 1");
			StringBuffer sb = new StringBuffer();
			
			com.popultrade.dao.TemplateClassClassDAO daol = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",servletContext);
			
			sb.append("if (true) {\r\n");
			System.out.println("generirajFunkcijoLoop_EXP _ __________________________________ 1222222");
			com.popultrade.model.TemplateClassClass tcc = daol.getTemplateClassClass(new Long(idnaprej));
			
			/// dobim classclass
			
			String class1 = tcc.getClass_name();
			
			String classtip ="";
			if (tcc.getTip_funkcije()!=null && !tcc.getTip_funkcije().equals("")) {
			classtip = tcc.getTip_funkcije();
			}
			
			System.out.println("generirajFunkcijoLoop_EXP _ __________________________________ 123333333");
			
			 if (!classtip.equals("UP")) {
			sb.append("com.popultrade.dao."+class1+"DAO doa"+idnaprej+class1+" =(com.popultrade.dao."+ class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0,1).toLowerCase() +class1.substring(1) +"DAO\",pageContext.getServletContext());\r\n");

			sb.append("com.popultrade.model."+class1 +" mod"+idnaprej+class1+" = new com.popultrade.model."+class1 +"();\r\n");
			 }
			
			/// setam vrednosti

			Iterator tre = tcc.getTemplateClasss().iterator();

			/// dobim tipe funkcij
			
			Hashtable meto = this.getClassMetodeImenaHT(tcc.getClass_name());
			System.out.println("generirajFunkcijoLoop_EXP _ __________________________________ 1444444444");
			while (tre.hasNext()) {
				com.popultrade.model.TemplateClass tcci = (com.popultrade.model.TemplateClass)tre.next();
	 if (nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.")  || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter")  ) {
					String rett=tcci.getVrednost_pogoja().replaceAll("\'","\"")+"+\"\"";
					
					//System.out.println(meto.get(tcci.getIme_pogoja())+":::::::::::::::::::: s :::::::::::::: "+tcci.getIme_pogoja());
					if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
						
						
						
						rett = "new Long("+rett+")";
						
						
						
					}
					else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int")!=-1) {
						rett = "Integer.parseInt("+rett+")";
						
					}
					else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
					
						rett = "Double.parseDouble("+rett+")";
					}
					//// dam pogoj ce je
					if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						
											
					
							if (nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")) {
						sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+idprej+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							else {
								sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idnaprej+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							
						
					}
					
				
					
				sb.append("mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");
					
				
				if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
					sb.append(" }\r\n");
				}
				
				}
				else {
					
					
					String rett = "";
					
					
					if (nul.jeNull(tcci.getIzvor_vrednosti()).equals("V")) {
					rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get",""+idprej+".get").replaceAll("\'","\"");
					}
					else {
						rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get",""+"mod"+idnaprej+class1+".get").replaceAll("\'","\"");
						
						
					}
					
					if (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter")!=-1) {
						 rett = tcci.getVrednost_pogoja().replaceAll("\'","\"");
					}
					
					
					if (rett.indexOf("get")==-1 || rett.indexOf("request.getParameter")!=-1) {
					//System.out.println("DDDDDDDD "+tcci.getIme_pogoja()+" :::: "+((String)meto.get(tcci.getIme_pogoja())));
					if (meto.containsKey(tcci.getIme_pogoja())) {
						if (((String)meto.get(tcci.getIme_pogoja())).indexOf("String")!=-1) {
							if (rett.indexOf("\"")==-1) {
								rett = "\""+rett+"\"";
							}
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Long")!=-1) {
						
							if (rett.indexOf("\"")==-1) {
								rett = "\""+rett+"\"";
							}
							
							rett = "new Long("+rett+")";
							
							
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer")!=-1) {
							if (rett.indexOf("\"")!=-1) {
								rett = rett.replaceAll("\"", "").replaceAll("\'", "");
							}
							
						}
						else if (((String)meto.get(tcci.getIme_pogoja())).indexOf("Double")!=-1) {
							if (rett.indexOf("\"")!=-1) {
								rett = rett.replaceAll("\"", "").replaceAll("\'", "");
							}
							if (rett.indexOf(",")!=-1) {
								rett = rett.replaceAll("\\,", "\\.");
							}
							
						}
						
					}
					}
					
					
			if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						
									
							if (nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")) {
						sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+idprej+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							else {
								sb.append("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get",""+"mod"+idnaprej+class1+".get").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n");
							}
							
						
					}
			
			
					sb.append("mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n");	
					
					
					
					if (!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
						sb.append(" }\r\n");
					}
					
					
				}
				
			}
			
			
			
			if (classtip.equals("IN") || classtip.equals("UP")) {
				
				
				sb.append("doa"+(classtip.equals("UP")?idfunk:idnaprej)+class1+".save"+class1+"(mod"+(classtip.equals("UP")?idfunk:idnaprej)+class1+");\r\n");

				//String remio = genViews_Exp2(tcc,idnaprej,class1,false,contextUtil,servletContext,vred,idnaprej);
			//	sb.append(remio);
			}
			
			
			

		 if (classtip.equals("ER") || classtip.equals("LI") || classtip.equals("CO") ) { /// iscem le en rezultat
				
				sb.append("List remi"+idnaprej+class1+"=doa"+idnaprej+class1+".get"+class1+"s(mod"+idnaprej+class1+");\r\n");

				
				
				
				System.out.println("generirajFunkcijoLoop_EXP _ __________________________________ 155555555555555");
				 
				 
				 
				//if (tcc.getTemplateClassClass_vrednostis().size()>0) {
					
					//sb.append(genViews_PDF2(tcc,idnaprej,class1) );
					//sbfo.append(genViews_PDF_fo(idnaprej) );
					
					String remio ="";
					/*if ( classtip.equals("CO")) {
					remio = genViews_Exp2(tcc,idnaprej,class1,true,contextUtil,servletContext,vred);
					}
					else {*/
						remio = genViews_Exp2(tcc,idnaprej,class1,false,contextUtil,servletContext,vred,idnaprej);
					//}
		
					
					System.out.println("generirajFunkcijoLoop_EXP _ __________________________________ 15555ddddddddddddddddd5555555555");
					
					
					System.out.println("////////////////////////////////////////////////////////////");
					System.out.println("////////////////////////////////////////////////////////////");
					System.out.println(idfunk+"///VIEWWWWWWWWW////////////////////////////////////////////////////"+remio);
					System.out.println("////////////////////////////////////////////////////////////");
					System.out.println("////////////////////////////////////////////////////////////");
					System.out.println("////////////////////////////////////////////////////////////");
		
				sb.append(remio);
				//}
				
			/*	else {
				
					System.out.println("generirajFunkcijoLoop_EXP _ __________________________________ 1666666666666666666");
			sb.append("if (remi"+idnaprej+class1+".size()>0) {\r\n");

				sb.append("mod"+idnaprej+class1+"=(com.popultrade.model."+class1 +")remi"+idnaprej+class1+".get(0);\r\n");
				
				sb.append("}\r\n");
				}*/

				
				

				
				
				
			}
			

			
			
			
			
		 sb.append("}\r\n");
			
			return sb.toString();
			
		}
		catch (Exception en) {
			System.out.println("Napaka loop gen funkcija: "+en.toString());
		}
		return "";
		
	}
	
	//////////////////
	//////////////////
	//////////////////
	////// end kreacija pdf funkcija
	//////////////////
	/////////////////
	
	
	
	
	
	//////////////////
////////////////////
///////////////////
////// generira view za pdf
///////////////////
///////////////////




private String genViews_PDF_count(com.popultrade.model.TemplateFunkcijaStart tui,String idfunkcije,String class1) {
	
	
	StringBuffer sb = new StringBuffer();
	
	
	////// le en rezultat zA head
	sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
	sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
	//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
	
	
	
	
	sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");

//sb.append("String rezu=\"\";\r\n\r\n");


//String imenavrstic = "";

//1sb.append( "sbu.append(\"<vrstice"+idfunkcije+">\");\r\n");


//String stolpci = "<stolpec"+idfunkcije+">";

	sb.append("mod"+idfunkcije+""+class1+"=new com.popultrade.model."+class1 +"();\r\n");
	

sb.append("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n");

sb.append("com.popultrade.model."+tui.getClass_name() +"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name() +")(it"+idfunkcije+class1+".next());\r\n");
//// kaj sestevam oz countam
Iterator ie = tui.getTemplateviews().iterator();

while (ie.hasNext()) {
	
	com.popultrade.model.TemplateView tw = (com.popultrade.model.TemplateView)ie.next();
	
	
	if (nul.jeNull(tw.getTip_sestevka()).equals("COUNT")) {
	sb.append( "mod"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n");	
	}
	else if (nul.jeNull(tw.getTip_sestevka()).equals("SUM")) {
		sb.append( "mod"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"());\r\n");	
			
	}
	
}



//sb.append( "sbu.append(\"<vrstica"+idfunkcije+">\");\r\n");	



sb.append("}  // while end\r\n");




	
	//sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");

	

	
sb.append( "sbu.append(\"<header"+idfunkcije+">\");\r\n");
sb.append( "String cosmi = \"\";\r\n");//(\"<header"+idfunkcije+">\");\r\n");
sb.append("%////>\r\n");

//// ipisem vse vrstice headerja
Iterator wie = tui.getTemplateviews().iterator();
String headerform = "";
while (true) {
	System.out.println("sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss wie");
	boolean preskoci=false;
	if (wie.hasNext()) {
		
		
	com.popultrade.model.TemplateView tw = (com.popultrade.model.TemplateView)wie.next();
	
	if (tw.getPdf_header()!=null && tw.getPdf_header().equals("1")) {
		String rei = "";
		sb.append(getFieldHead(rei,tw,idfunkcije+""+class1));
		//headerform=headerform+("<////%\r\n");
		sb.append("<////%\r\n");
		sb.append( "cosmi=\"<naslov><opis>\"+ConPool.getPrevod(\""+tw.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</opis><vrednost> \"+rezu+\"</vrednost></naslov>\";\r\n");
		sb.append("%////>\r\n");
		//headerform=headerform+("%////>\r\n");
		preskoci=true;
	}
	else {
	if (tw.getTip_polja().equals("PR")) {
		sb.append("<////%\r\n");
		sb.append( "sbu.append(\"<par><ay>PR</ay><a1>\"+ConPool.getPrevod(\""+tw.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</a1><a2></a2>\");\r\n");
		sb.append("%////>\r\n");
	}
	else {
		String rei = "";
		sb.append(getFieldHead(rei,tw,idfunkcije+""+class1));	
		sb.append("<////%\r\n");
	sb.append( "sbu.append(\"<par><ay>PU</ay><a1>\"+ConPool.getPrevod(\""+tw.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</a1><a2>\"+rezu+\"</a2>\");\r\n");
	sb.append("%////>\r\n");
	}
	
	}
	}
	else {
		break;
	}
	
	
	///// desno izpis
	if (wie.hasNext()) {
		com.popultrade.model.TemplateView tw = (com.popultrade.model.TemplateView)wie.next();
		
		if (!preskoci) {
		if (tw.getTip_polja().equals("PR")) {
			sb.append("<////%\r\n");
			sb.append( "sbu.append(\"<a3></a3><a4></a4><ax>PR</ax></par>\");\r\n");
			sb.append("%////>\r\n");
		}
		else {
			String rei = "";
			sb.append(getFieldHead(rei,tw,idfunkcije+""+class1));
			
			sb.append("<////%\r\n");
	sb.append( "sbu.append(\"<a3>\"+ConPool.getPrevod(\""+tw.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</a3><a4>\"+rezu+\"</a4><ax>PU</ax></par>\");\r\n");
	sb.append("%////>\r\n");
		}
		
		}
		
		}
	else {
		if (!preskoci) {
		sb.append("<////%\r\n");
	
		sb.append( "sbu.append(\"<a3></a3><a4></a4><ax>PR</ax></par>\");\r\n");
		sb.append("%////>\r\n");
		}
		break;
	}
	}
	
sb.append("<////%\r\n");



sb.append("//////DOME0//////\r\n");




sb.append( "sbu.append(\"</header"+idfunkcije+">\");\r\n");
sb.append( "sbu.append(cosmi);\r\n");
sb.append(headerform);
	
	sb.append("}\r\n");
	
		
		
		
		
	
	
	return sb.toString();
	
	
	
	
	
	
	
}










private String genViews_Exp(com.popultrade.model.TemplateFunkcijaStart tui,String idfunkcije,String class1,boolean jecount,ContextUtil contextUtil,ServletContext servletContext,String idnaprej) {
	
	
	StringBuffer sb = new StringBuffer();
	
	
	
	
	
	
	
	
	
	if (!jecount) {
	//	sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
		//sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
		//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
		//sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");
		sb.append("Iterator itremi"+idfunkcije+""+class1+" = remi"+idfunkcije+""+class1+".iterator();\r\n");
		}
		else {
			
			
			
			////// le en rezultat zA head
			//sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
		//	sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
			//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
			
			
			
			
			sb.append("Iterator it"+idfunkcije+class1+" = remi"+idfunkcije+class1+".iterator();\r\n\r\n");

		//sb.append("String rezu=\"\";\r\n\r\n");


		//String imenavrstic = "";

		//1sb.append( "sbu.append(\"<vrstice"+idfunkcije+">\");\r\n");


		//String stolpci = "<stolpec"+idfunkcije+">";

			sb.append("com.popultrade.model."+class1 +" modoo"+idfunkcije+""+class1+"=new com.popultrade.model."+class1 +"();\r\n");
			

		sb.append("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n");

		sb.append("com.popultrade.model."+tui.getClass_name() +"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name() +")(it"+idfunkcije+class1+".next());\r\n");
		//// kaj sestevam oz countam
		Iterator ie = tui.getTemplateviews().iterator();

		while (ie.hasNext()) {
			
			com.popultrade.model.TemplateView tw = (com.popultrade.model.TemplateView)ie.next();
			
			
			if (nul.jeNull(tw.getTip_sestevka()).equals("COUNT")) {
			sb.append( "modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n");	
			}
			else if (nul.jeNull(tw.getTip_sestevka()).equals("SUM")) {
				sb.append( "modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"());\r\n");	
					
			}
			
		}

		//sb.append( "sbu.append(\"<vrstica"+idfunkcije+">\");\r\n");	

		sb.append("}  // while end\r\n");


			/// dam v array list

		sb.append("List lik"+idfunkcije+""+class1+" = new ArrayList();  // array list\r\n");
			
		sb.append("lik"+idfunkcije+""+class1+".add(modoo"+idfunkcije+class1+");\r\n");  // array list\r\n");
			
			
	//	sb.append("Iterator it"+idfunkcije+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n\r\n");
		sb.append("Iterator itremi"+idfunkcije+""+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n");
		}
	

	
	
	sb.append("while (itremi"+idfunkcije+""+class1+".hasNext()) {\r\n");
			sb.append("mod"+idfunkcije+""+class1+"=(com.popultrade.model."+class1 +")itremi"+idfunkcije+""+class1+".next();\r\n");

		StringBuffer sbj = new StringBuffer();	
		////// ce ima tag ga dodam	





sb.append( "String cosmi = \"\";\r\n");//(\"<header"+idfunkcije+">\");\r\n");


//// izpis vseh vrednosti, ce imajo formattaga
Iterator tre = tui.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
String attribute = "";

while (tre.hasNext()) {
	
	com.popultrade.model.TemplateClassClass_vrednosti tcl = (com.popultrade.model.TemplateClassClass_vrednosti)tre.next();
	System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP ::::::::: "+tcl.getTemplateClasses().size());
	System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP ::::::::: "+tui.getIme_funkcije()+" ---- "+tcl.getTemplateClasses().size());
	System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP ::::::::: "+tcl.getTemplateClasses().size());
	if (tcl.getTemplatetag()!=null && nul.jeNull(tcl.getTemplatetag().getUporabi_tag()).equals("1")) {
	if (nul.jeNull(tcl.getTemplatetag().getJe_attribute_taga()).equals("1") && nul.jeNull(tcl.getTemplatetag().getUporabi_tag()).equals("1")) {
		attribute = attribute + getFieldHead_Exp("",tcl,tcl.getVrednost(),"mod"+idfunkcije+""+class1)+"\r\n";
		//// kreira formatirano vrednost
		
		attribute = attribute + " cosmi=cosmi+\" "+tcl.getTemplatetag().getTag_name()+"=\\\"\"+rezu+\"\\\"\";\r\n"; //// doda se vrednost
	}
	else if (nul.jeNull(tcl.getTemplatetag().getUporabi_tag()).equals("1") ) {
		
		
		
		if (nul.jeNull(tcl.getTemplatetag().getTag_ima_childe()).equals("1") ) {
			
			//sbj.append("%////>\r\n");
			//sbj.append( "sbu.append(\"<"+tcl.getTemplatetag().getTag_name()+">\");\r\n");
			
			sbj.append("//////DOME"+tcl.getId()+"//////\r\n");
			
			//String idnaprej = tcl.getId()+"";
			
			 System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP ::::::::: "+tcl.getTemplateClasses().size());
			if (tcl.getTemplateClasses().size()>0) {
				//	System.out.println(":::yyyyyyy::::: "+tcc.getTemplateClassClass_vrednostis().size());
						/// dobim templateclass
						Iterator item = tcl.getTemplateClasses().iterator();
								 while (item.hasNext()) {
								 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
								 System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP222222222222");
								 
								 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
									 
									 System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP11111111111111");
									 
									 /// pogoj
									 sbj.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get")+" {\r\n");
									 
									/* if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
										 sb.append("rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
										 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
									 }
									 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
										 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
									 }
									 else {*/
									 
									 
									 
										 if (txc.getTemplateClassClass()!=null && txc.getTemplateClassClass().getClass_name()!=null && !txc.getTemplateClassClass().getClass_name().equals("")) {
											 
											 System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP ::: "+nul.jeNull(tui.getTemplatetag().getTag_name_parent()));
											 
											 
											 if (tcl.getTemplatetag()!=null && !nul.jeNull(tcl.getTemplatetag().getTag_name_parent()).equals("")) {
													sbj.append( "sbu.append(\"<"+nul.jeNull(tcl.getTemplatetag().getTag_name_parent())+">\");\r\n");
												 }
											 sbj.append(generirajFunkcijoLoop_EXP( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,tcl));
											 if (tcl.getTemplatetag()!=null && !nul.jeNull(tcl.getTemplatetag().getTag_name_parent()).equals("")) {
													sbj.append( "sbu.append(\"</"+nul.jeNull(tcl.getTemplatetag().getTag_name_parent())+">\");\r\n");
												 }
											 
										 }
										 else {
										if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
											 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
											 }
										 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
											 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
										  
										 }
										 }
										 // }
										 
									 
									 
									 sbj.append("}\r\n");
									 
								 }
								 else { /// v primeru, da je format
									 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get")==-1) {
										
										 if (!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1")) {
											 //sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
											 if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
											// sb.append("rezu="+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+";\r\n\r\n");
											 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","nul.je").replaceAll("request.geetParameter","request.getParameter")+")+\"\";\r\n\r\n");
											 }
										 }
													 else {
														 
														 
															 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]")!=-1) {
																 String dodd = "";
																 
																 if (nul.jeNull(txc.getVrednost_pogoja()).length()>"[SIZE]".length()) {
																	 dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]")+1,nul.jeNull(txc.getVrednost_pogoja()).length());
																 }
																 sbj.append("rezu=(remi"+idnaprej+class1+".size() "+dodd+") + \"\";\r\n");
															 }
															 else {
														 
														 
														 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+")+\"\";\r\n\r\n");
															 }
													 }
										 
										 
										// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
											
									 
									 
									 }
											 else {
												 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
													
											 }
									 if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
										 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
										 }
									 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
										// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
									 
									 }
								 }
								 }
						}
				
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

			//sbj.append( "sbu.append(\"<"+tcl.getTemplatetag().getTag_name()+">\");\r\n");
			//sbj.append("\r\n");

			//sbj.append("<////%\r\n");
		}
		else {
		sbj.append(getFieldHead_Exp("",tcl,tcl.getVrednost(),"mod"+idfunkcije+""+class1)+"\r\n");
		
		
		//sbj.append("%////>\r\n");
		sbj.append( "sbu.append(\"<"+tcl.getTemplatetag().getTag_name()+">\"+rezu+\"</"+tcl.getTemplatetag().getTag_name()+">\");\r\n");
	//	sbj.append("\r\n");

	//	sbj.append("<////%\r\n");
		}
		
		
		
	}
	
	
	}
	else if (tcl.getTemplateClasses().size()>0) {
		
		
		
		
		
		//sbj.append("%////>\r\n");
		//sbj.append( "sbu.append(\"<"+tcl.getTemplatetag().getTag_name()+">\");\r\n");
		
		sbj.append("//////DOME"+tcl.getId()+"//////\r\n");
		
		//String idnaprej = tcl.getId()+"";
		
		 System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP ::::::::: "+tcl.getTemplateClasses().size());
		if (tcl.getTemplateClasses().size()>0) {
			//	System.out.println(":::yyyyyyy::::: "+tcc.getTemplateClassClass_vrednostis().size());
					/// dobim templateclass
					Iterator item = tcl.getTemplateClasses().iterator();
							 while (item.hasNext()) {
							 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
							 System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP222222222222");
							 
							 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
								 
								 System.out.println("LOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPP11111111111111");
								 
								 /// pogoj
								 sbj.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get")+" {\r\n");
								 
								/* if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
									 sb.append("rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
									 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
								 }
								 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
									 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
								 }
								 else {*/
								 
								 
								 
									 if (txc.getTemplateClassClass()!=null && txc.getTemplateClassClass().getClass_name()!=null && !txc.getTemplateClassClass().getClass_name().equals("")) {
										 
								
										 sbj.append(generirajFunkcijoLoop_EXP( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,tcl));
								
										 
									 }
									 else {
									if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
										 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
										 }
									 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
										 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
									  
									 }
									 }
									 // }
									 
								 
								 
								 sbj.append("}\r\n");
								 
							 }
							 else { /// v primeru, da je format
								 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get")==-1) {
									
									 if (!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1")) {
										 //sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
										 if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
										// sb.append("rezu="+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+";\r\n\r\n");
										 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","nul.je").replaceAll("request.geetParameter","request.getParameter")+")+\"\";\r\n\r\n");
										 }
									 }
												 else {
													 
													 
														 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]")!=-1) {
															 String dodd = "";
															 
															 if (nul.jeNull(txc.getVrednost_pogoja()).length()>"[SIZE]".length()) {
																 dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]")+1,nul.jeNull(txc.getVrednost_pogoja()).length());
															 }
															 sbj.append("rezu=(remi"+idnaprej+class1+".size() "+dodd+") + \"\";\r\n");
														 }
														 else {
													 
													 
													 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+")+\"\";\r\n\r\n");
														 }
												 }
									 
									 
									// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
										
								 
								 
								 }
										 else {
											 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
												
										 }
								 if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
									 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
									 }
								 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
									// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
								 
								 }
							 }
							 }
					}
			
	
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
}


sbj.append("//////DOME0//////\r\n");


//sbj.append( "sbu.append(cosmi);\r\n");



if (tui.getTemplatetag()!=null && nul.jeNull(tui.getTemplatetag().getUporabi_tag()).equals("1")) {
	
sb.append(attribute);
	sb.append( "sbu.append(\"<"+nul.jeNull(tui.getTemplatetag().getTag_name())+"\"+cosmi+\">\");\r\n");

	
	sb.append(sbj.toString());
	
	
	sb.append( "sbu.append(\"</"+nul.jeNull(tui.getTemplatetag().getTag_name())+">\");\r\n");


	}
else {
	sb.append(sbj.toString());
}


	
	sb.append("}\r\n");
	
		
		
		
		
	
	
	return sb.toString();
	
	
	
	
	
	
	
}
	






private String genViews_Exp2(com.popultrade.model.TemplateClassClass tui,String idfunkcije,String class1,boolean jecount,ContextUtil contextUtil,ServletContext servletContext,com.popultrade.model.TemplateClassClass_vrednosti vred,String idnaprej) {
	
	
	StringBuffer sb = new StringBuffer();
	
	
	
	
	
	try {
	
	
	
	if (!jecount) {
	//	sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
		//sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
		//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
		//sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");
		sb.append("Iterator itremi"+idfunkcije+""+class1+" = remi"+idfunkcije+""+class1+".iterator();\r\n");
		}
		else {
			
			
		}
	

	System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 1");
	
	sb.append("while (itremi"+idfunkcije+""+class1+".hasNext()) {\r\n");
			sb.append("mod"+idfunkcije+""+class1+"=(com.popultrade.model."+class1 +")itremi"+idfunkcije+""+class1+".next();\r\n");

		StringBuffer sbj = new StringBuffer();	
		////// ce ima tag ga dodam	





sb.append( "String cosmi"+idfunkcije+""+class1+" = \"\";\r\n");//(\"<header"+idfunkcije+">\");\r\n");
System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 2");

//// izpis vseh vrednosti, ce imajo formattaga
Iterator tre = tui.getTemplateClassClass_vrednostis().iterator();
String attribute = "";

while (tre.hasNext()) {
	
	com.popultrade.model.TemplateClassClass_vrednosti tcl = (com.popultrade.model.TemplateClassClass_vrednosti)tre.next();
	System.out.println(":::yyyyyyy::::: "+tcl.getTemplateClasses().size());
	System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 14");
	System.out.println(":::yyyyyyy::::: "+tcl.getTemplateClasses().size());
	
	
	
	if (tcl.getTemplatetag()!=null && nul.jeNull(tcl.getTemplatetag().getUporabi_tag()).equals("1")) {
	if (nul.jeNull(tcl.getTemplatetag().getJe_attribute_taga()).equals("1") && nul.jeNull(tcl.getTemplatetag().getUporabi_tag()).equals("1")) {
		attribute = attribute + getFieldHead_Exp("",tcl,tcl.getVrednost(),"mod"+idfunkcije+""+class1)+"\r\n";
		//// kreira formatirano vrednost
		
		attribute = attribute + " cosmi"+idfunkcije+""+class1+"=cosmi"+idfunkcije+""+class1+"+\" "+tcl.getTemplatetag().getTag_name()+"=\\\"\"+rezu+\"\\\"\";\r\n"; //// doda se vrednost
	}
	else if (nul.jeNull(tcl.getTemplatetag().getUporabi_tag()).equals("1") ) {
		
		System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 3");
		
		
		if (nul.jeNull(tcl.getTemplatetag().getTag_ima_childe()).equals("1") ) {
			
			//sbj.append("%////>\r\n");
			//sbj.append( "sbu.append(\"<"+tcl.getTemplatetag().getTag_name()+">\");\r\n");
			
			sbj.append("//////DOME"+tcl.getId()+"//////\r\n");
			
		//	String idnaprej = tcl.getId()+"";
			
			
			if (tcl.getTemplateClasses().size()>0) {
				//	System.out.println(":::yyyyyyy::::: "+tcc.getTemplateClassClass_vrednostis().size());
						/// dobim templateclass
						Iterator item = tcl.getTemplateClasses().iterator();
								 while (item.hasNext()) {
								 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
								 
								 
								 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
									 
									
									 
									 /// pogoj
									 sbj.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get")+" {\r\n");
									 
									/* if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
										 sb.append("rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
										 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
									 }
									 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
										 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
									 }
									 else {*/
									 
									 
									 
										 if (txc.getTemplateClassClass()!=null && txc.getTemplateClassClass().getClass_name()!=null && !txc.getTemplateClassClass().getClass_name().equals("")) {
											 
											 if (tcl.getTemplatetag()!=null && !nul.jeNull(tcl.getTemplatetag().getTag_name_parent()).equals("")) {
												sbj.append( "sbu.append(\"<"+nul.jeNull(tcl.getTemplatetag().getTag_name_parent())+">\");\r\n");
											 }
											 
											 
							
											 sbj.append(generirajFunkcijoLoop_EXP( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,tcl));
											 if (tcl.getTemplatetag()!=null && !nul.jeNull(tcl.getTemplatetag().getTag_name_parent()).equals("")) {
													sbj.append( "sbu.append(\"</"+nul.jeNull(tcl.getTemplatetag().getTag_name_parent())+">\");\r\n");
												 }
											 
										 }
										 else {
										if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
											 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
											 }
										 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
											 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
										  
										 }
										 }
										 // }
										 
									 
									 
									 sbj.append("}\r\n");
									 
								 }
								 else { /// v primeru, da je format
									 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get")==-1) {
										
										 if (!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1")) {
											 //sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
											 if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
											// sb.append("rezu="+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+";\r\n\r\n");
											 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","nul.je").replaceAll("request.geetParameter","request.getParameter")+")+\"\";\r\n\r\n");
											 }
										 }
													 else {
														 
														 
															 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]")!=-1) {
																 String dodd = "";
																 
																 if (nul.jeNull(txc.getVrednost_pogoja()).length()>"[SIZE]".length()) {
																	 dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]")+1,nul.jeNull(txc.getVrednost_pogoja()).length());
																 }
																 sbj.append("rezu=(remi"+idnaprej+class1+".size() "+dodd+") + \"\";\r\n");
															 }
															 else {
														 
														 
														 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+")+\"\";\r\n\r\n");
															 }
													 }
										 
										 
										// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
											
									 
									 
									 }
											 else {
												 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
													
											 }
									 if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
										 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
										 }
									 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
										// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
									 
									 }
								 }
								 }
						}
				
			
			
			
			
			
			
			
			
			System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 18");
			
			
			
			
			
			
			
			
			
			
			

			//sbj.append( "sbu.append(\"<"+tcl.getTemplatetag().getTag_name()+">\");\r\n");
			//sbj.append("\r\n");

			//sbj.append("<////%\r\n");
		}
		else {
			
			System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 19");
			
		sbj.append(getFieldHead_Exp("",tcl,tcl.getVrednost(),"mod"+idfunkcije+""+class1)+"\r\n");
		
		
	//	sbj.append("%////>\r\n");
		sbj.append( "sbu.append(\"<"+tcl.getTemplatetag().getTag_name()+">\"+rezu+\"</"+tcl.getTemplatetag().getTag_name()+">\");\r\n");
	//	sbj.append("\r\n");

	//	sbj.append("<////%\r\n");
		}
		
		
		
	}
	
	
	}
	
	
	
	else if (tcl.getTemplateClasses().size()>0) {
		
				/// dobim templateclass
				Iterator item = tcl.getTemplateClasses().iterator();
						 while (item.hasNext()) {
						 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
						 
						 
						 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
							 
							
							 
							 /// pogoj
							 sbj.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get")+" {\r\n");
							 
							/* if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
								 sb.append("rezu=nul.formatNumber(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
								 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
							 }
							 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
								 sb.append("rezu=nul.getDatumFormatFromDate(vseb."+txc.getVrednost_pogoja().replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
							 }
							 else {*/
							 
							 
							 
								 if (txc.getTemplateClassClass()!=null && txc.getTemplateClassClass().getClass_name()!=null && !txc.getTemplateClassClass().getClass_name().equals("")) {
									 
								
									 
					
									 sbj.append(generirajFunkcijoLoop_EXP( contextUtil, servletContext,txc.getTemplateClassClass().getId()+"", "","mod"+idnaprej+class1,idnaprej,tcl));
									
								 }
								 else {
								if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
									 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
									 }
								 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
									 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
								  
								 }
								 }
								 // }
								 
							 
							 
							 sbj.append("}\r\n");
							 
						 }
						 else { /// v primeru, da je format
							 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get")==-1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get")==-1) {
								
								 if (!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1")) {
									 //sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
									 if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
									// sb.append("rezu="+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("request.geetParameter","request.getParameter").replaceAll("\"\"\\)","\"\"\\)+\"")+";\r\n\r\n");
									 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("request.getParameter","request.geetParameter").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","nul.je").replaceAll("request.geetParameter","request.getParameter")+")+\"\";\r\n\r\n");
									 }
								 }
											 else {
												 
												 
													 if (nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]")!=-1) {
														 String dodd = "";
														 
														 if (nul.jeNull(txc.getVrednost_pogoja()).length()>"[SIZE]".length()) {
															 dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]")+1,nul.jeNull(txc.getVrednost_pogoja()).length());
														 }
														 sbj.append("rezu=(remi"+idnaprej+class1+".size() "+dodd+") + \"\";\r\n");
													 }
													 else {
												 
												 
												 sbj.append("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+")+\"\";\r\n\r\n");
													 }
											 }
								 
								 
								// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
									
							 
							 
							 }
									 else {
										 sbj.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
											
									 }
							 if (nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
								 sbj.append("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n");
								 }
							 else if (!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
								// sb.append("rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idnaprej+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
							 
							 }
						 }
						 }
				}
	
	
	
	
	
}


sbj.append("//////DOME0//////\r\n");


//sbj.append( "sbu.append(cosmi);\r\n");

System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 110");


if (vred.getTemplatetag()!=null && nul.jeNull(vred.getTemplatetag().getUporabi_tag()).equals("1")) {
	
sb.append(attribute);
	sb.append( "sbu.append(\"<"+nul.jeNull(vred.getTemplatetag().getTag_name())+"\"+cosmi"+idfunkcije+""+class1+"+\">\");\r\n");

	
	sb.append(sbj.toString());
	
	
	sb.append( "sbu.append(\"</"+nul.jeNull(vred.getTemplatetag().getTag_name())+">\");\r\n");


	}
else {
	sb.append(sbj.toString());
}


	
	sb.append("}\r\n");
	
		
	System.out.println("AAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSS ::: 111");
	
		
	}
	catch (Exception ex) {
		System.out.println("Napaka genViews_Exp2 ::: "+ex.toString());
	}
	
	
	return sb.toString();
	
	
	
	
	
	
	
}
	


































////////////
/////////// kreira vrednosti oz rezultate za tage , cista_vrednost je vrednost iz vrednosti tabele
////////////

public String getFieldHead_Exp(String premo,com.popultrade.model.TemplateClassClass_vrednosti tu,String cista_vrednost,String class_name) {
	try {
		System.out.println("1VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE999999999999999999999999999999E ::: ");
		//com.popultrade.webapp.TemplateUtilsExp templateUtil = new com.popultrade.webapp.TemplateUtilsExp();
		 if (tu.getTemplateClasses().size()>0) {
			 System.out.println("1VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE9999999999999999999999999999999999999EEEE ::: ");
			 Iterator iteb = tu.getTemplateClasses().iterator();
			// premo = premo + "<%\r\n"; 
			 
			 
			// String remu = ""; ///////// format number , ce je double in ce ima vnesen format
		
			// nul.getDatumFormatFromDate()
			 while (iteb.hasNext()) {
				 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
				 
				 
				 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
					 
					System.out.println("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm" +tc.getPredpona_pogoja());
					 
					 /// pogoj
					 premo = premo + "\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get",class_name+".get")+" {\r\n";
					 
				
						 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
							 
							 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get",class_name+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n";
								 
							 
						 }
						 else {
						 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get",class_name+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
						 }
						 
						 
					 
					 
					 premo = premo + "}\r\n";
					 
				 }
				 
				 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) ) {
					 
						
					 System.out.println("122VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
					 
					 
					 /// vrednost iz clase
					 
					 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
	/// pogoj
	if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
	premo = premo + nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get",class_name+".get")+" {\r\n";
	}
	 	 
	premo = premo + "if (true) {\r\n";
	premo = premo + "rezu=\"\";\r\n";	 
	premo = premo + "com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

	premo = premo + "com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n";




	/// setam vrednosti
System.out.println("133VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
	Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

	Hashtable meto = this.getClassMetodeImenaHT(tc.getTemplateClassClass().getClass_name());
	
	while (tre.hasNext()) {
		com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
		
		///////// ///////// ///////////
		
		
		String rett = tcc.getVrednost_pogoja().replaceAll("\'","\"");
		
		if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
			rett = tcc.getVrednost_pogoja().replaceAll("get",class_name+".get")+"()";
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
		premo = premo + "mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n";
		
		
		
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
					 premo = premo + "\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get",class_name+".get")+" {\r\n";
					 
				
						 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
							 
							 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
								 
							 
						 }
						 else {
						 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
						 }
						 
						 
					 
					 
					 premo = premo + "}\r\n";
					 
				 }
				 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
					 
					 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
						 
						 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
							 
						 
					 }
					 else {
					 premo = premo + "rezu=\""+txc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
					 }
				 }
				 }
		}
		else {
			
			System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEExxx ::: "+tc.getPredpona_pogoja());
			String dodvred = "";
		if (!nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
			dodvred = " "+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get",class_name+".get").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
		}
			
		System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: "+tc.getPredpona_pogoja());
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
					// System.out.println("FORMATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT" +nul.jeNull(tc.getFunkcija_formata1()));
					 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
						 
						 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get",class_name+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n";
							 
						 
					 }
					 else {
					 premo = premo + "rezu=\""+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get",class_name+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
					 }
				 }
				 
				 
			 }
			 
		//	 premo = premo + "%////>\r\n";
			 
			 
			 
			 
		 }
		 else {
			 System.out.println("1VALUEEEEEEEEEEsssssssssssssssssssssssssssssssssssssssssssEEEEEEEEEEEEEEEEEEEEEEEEE999999999999999999999999999999E ::: ");
	
			//	 premo = premo + "<%\r\n";
				 premo = premo + "rezu=nul.jeNull("+class_name+"."+cista_vrednost.replaceAll("\'","\"")+"()+\"\");\r\n\r\n";
			//	 premo = premo + "%////>";
			 
		 }
	        
	   
	        	//	premo = premo + "<////%=rezu%////>";
	        		
	        	
	        
	        
	    //    premo = premo + "</td>";
	        return premo;
	}
	catch (Exception ex) {
		System.out.println(ex.toString());
	}
	return "";
}


































































private String genList_EDI(com.popultrade.model.TemplateFunkcijaStart tui,String idfunkcije,String class1,boolean jecount) {
	
	
	
	
	StringBuffer sb = new StringBuffer();
	
	if (!jecount) {
	sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
	sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
	//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
	sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");
	}
	else {
		
		
		
		////// le en rezultat zA head
		sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
		sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
		//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
		
		
		
		
		sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");

	//sb.append("String rezu=\"\";\r\n\r\n");


	//String imenavrstic = "";

	//1sb.append( "sbu.append(\"<vrstice"+idfunkcije+">\");\r\n");


	//String stolpci = "<stolpec"+idfunkcije+">";

		sb.append("modoo"+idfunkcije+""+class1+"=new com.popultrade.model."+class1 +"();\r\n");
		

	sb.append("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n");

	sb.append("com.popultrade.model."+tui.getClass_name() +"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name() +")(it"+idfunkcije+class1+".next());\r\n");
	//// kaj sestevam oz countam
	Iterator ie = tui.getTemplateviews().iterator();

	while (ie.hasNext()) {
		
		com.popultrade.model.TemplateView tw = (com.popultrade.model.TemplateView)ie.next();
		
		
		if (nul.jeNull(tw.getTip_sestevka()).equals("COUNT")) {
		sb.append( "modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n");	
		}
		else if (nul.jeNull(tw.getTip_sestevka()).equals("SUM")) {
			sb.append( "modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"());\r\n");	
				
		}
		
	}

	//sb.append( "sbu.append(\"<vrstica"+idfunkcije+">\");\r\n");	

	sb.append("}  // while end\r\n");


		/// dam v array list

	sb.append("List lik"+idfunkcije+""+class1+" = new ArrayList();  // array list\r\n");
		
	sb.append("lik"+idfunkcije+""+class1+".add(modoo"+idfunkcije+class1+");\r\n");  // array list\r\n");
		
		
	sb.append("Iterator it"+idfunkcije+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n\r\n");
		
	}
	
	
	
	
	
	
	
	

//sb.append("String rezu=\"\";\r\n\r\n");



sb.append("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n");

sb.append("mod"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name() +")(it"+idfunkcije+class1+".next());\r\n");


//sb.append( "%////>\r\n");
int zapoo = 1;
Iterator itbv = tui.getTemplatelists().iterator();

while (itbv.hasNext()) {

com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();




/// pogledam, ce ima pogoje

if (tli.getTemplateClasses().size()>0) {
 
 Iterator iteb = tli.getTemplateClasses().iterator();
 
 
 
// String remu = ""; /////// format number , ce je double in ce ima vnesen format

// nul.getDatumFormatFromDate()
 while (iteb.hasNext()) {
	 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
	 
	 
	 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
				 
		
		 
		 /// pogoj
		 sb.append("\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n");
		 
		 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
			 sb.append("rezu=nul.formatNumber(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
			 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
		 }
		 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
			 sb.append("rezu=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
		 }
		 else {
 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
				 
				sb.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n");
					 
				 
			 }
			 else {
			 sb.append("rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
			 }
			 }
			 
		 
		 
		 sb.append("}\r\n");
		 
	 }
	 
	 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
		 
			
		 
		 
		 
		 /// vrednost iz clase
		 
		 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
/// pogoj
if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
sb.append( nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get")+" {\r\n");
}

sb.append("if (true) {\r\n");
sb.append("rezu=\"\";\r\n");	 		 
sb.append("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n");

sb.append("com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n");




/// setam vrednosti

Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

Hashtable metto = this.getClassMetodeImenaHT(tc.getTemplateClassClass().getClass_name());

while (tre.hasNext()) {
com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();

/////// /////// /////////


String rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("\'","\"");

if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get","mod"+idfunkcije+class1+".get")+"()";
}

//System.out.println(((String)metto.get(tcc.getIme_pogoja()))+ " ::: IME POGOJA ::: "+tcc.getIme_pogoja());

if (metto.containsKey(tcc.getIme_pogoja())) {
if (((String)metto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
	
//System.out.println("SOLEMMM : "+rett);

if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1 || nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	//rett = rett+"\"\"";
}

else	if (rett.indexOf("\"")==-1) {
		rett = "\""+rett+"\"";
	}
}
else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
	
	if (rett.indexOf("\"")==-1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
		rett = "\""+rett+"\"";
	}

	
	rett = "new Long("+rett+")";
	
}
else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)metto.get(tcc.getIme_pogoja())).indexOf("int")!=-1) {
	if (rett.indexOf("\"")==-1) {
		
	
	rett = rett.replaceAll("\"", "").replaceAll("\'", "");
	rett = "\""+rett+"\"";
	}
	
	rett = "Integer.parseInt("+rett+"+\"\")";
	
}
else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
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
//sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");




if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
	
}
else {
	

sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
}




}


sb.append("List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n");




sb.append("if (remi.size()>0) {\r\n");

sb.append("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n");




////pogoji vrednosti

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
			 sb.append("rezu=nul.formatNumber(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
			 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
		 }
		 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
			 sb.append("rezu=nul.getDatumFormatFromDate(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
		 }
		 else {
 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
				 
				 sb.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
					 
				 
			 }
			 else {
			 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
			 }
			 }
			 
		 
		 
		 sb.append("}\r\n");
		 
	 }
	 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
		 
		 
if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
			 
			 sb.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
				 
			 
		 }
		 else {
		 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
		 }
	 }
	 }
}
else {
String dodvred = "";
if (!nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
	dodvred = " "+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","vseb.get").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
}
	

sb.append("rezu="+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n");
}



}




sb.append("}\r\n");



sb.append("}\r\n");


if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
sb.append("}\r\n");
}			 
			 
			 
		 }
		 
		 
		 
		 
		 
		 
		 
		 
		 
	 }
	 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
		 
if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
			 
			 sb.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n");
				 
			 
		 }
		 else {
		 sb.append("rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
		 }
	 }
	 
	 
 }
 
 //sb.append("%////>\r\n");
 
 
 
 
}
else {
 
 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
	// sb.append("<%\r\n");
	 sb.append("rezu=nul.formatNumber(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
	// sb.append("%////>\r\n");
	 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
 }
 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
	// sb.append("<%\r\n");
	 sb.append("rezu=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
	// sb.append("%////>\r\n");
 }
 else {
//	 sb.append("<%\r\n");
	 sb.append("rezu=nul.jeNull(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
	// sb.append("%////>\r\n");
 }
}



// String hinto = "";
/// ce ima hinte stolpec
// if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
// hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(typeof(p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_mettoda()+"())%////>)=='string'?p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_mettoda()+"())%////>:'')\"";
 
// }


if (nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals("") ) {
 
// sb.append("<%\r\n");
 sb.append("rezu=nul.cutString(rezu,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n");
// sb.append("%////>\r\n");
 
 
}
String slik = "";

//	sb.append("<%\r\n");
//	sb.append("sbu.append(\""+slik+"<col"+zapoo+">\"+rezu+\"</col"+zapoo+">\");\r\n");
	
	sb.append("sbu.append(\"\"+nul.getEDIFormat(rezu,"+tli.getStolpec_width()+",\""+tli.getStolpec_align()+"\")+\"\");\r\n");
	
	//sb.append("%////>\r\n");


zapoo++;

}


sb.append("sbu.append(\"\\r\\n\");\r\n");	

	
sb.append("}  // while end\r\n");		
	


	
	
	
	
	sb.append("}\r\n");
	
	
	//sb.append("%////>\r\n");
	
	return sb.toString();
	
	
	
	
}







private String genList_PDF2(com.popultrade.model.TemplateClassClass tui,String idfunkcije,String class1,boolean jecount) {
	
	
	
	
	StringBuffer sb = new StringBuffer();
	
	sb.append("if (true) {\r\n");
	
	
	
	
	
	
	
	
	
	
	
	
//	sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
//	sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
	//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
	
	
	
	
	//sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");

	
	
	
	
	
	
	if (!jecount) {
		sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
		sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
		//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
		sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");
		}
		else {
			
			
			
			////// le en rezultat zA head
			sb.append("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n");
			sb.append("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n");
			//sb.append("List mod"+idfunkcije+""+rex[1]+"=(com.popultrade.model."+rex[1] +")remi"+idfunkcije+rex[1]+".get(0);\r\n");
			
			
			
			
			sb.append("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n");

		//sb.append("String rezu=\"\";\r\n\r\n");


		//String imenavrstic = "";

		//1sb.append( "sbu.append(\"<vrstice"+idfunkcije+">\");\r\n");


		//String stolpci = "<stolpec"+idfunkcije+">";

			sb.append("modoo"+idfunkcije+""+class1+"=new com.popultrade.model."+class1 +"();\r\n");
			

		sb.append("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n");

		sb.append("com.popultrade.model."+tui.getClass_name() +"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name() +")(it"+idfunkcije+class1+".next());\r\n");
		//// kaj sestevam oz countam
		Iterator ie = tui.getTemplateviews().iterator();

		while (ie.hasNext()) {
			
			com.popultrade.model.TemplateView tw = (com.popultrade.model.TemplateView)ie.next();
			
			
			if (nul.jeNull(tw.getTip_sestevka()).equals("COUNT")) {
			sb.append( "modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n");	
			}
			else if (nul.jeNull(tw.getTip_sestevka()).equals("SUM")) {
				sb.append( "modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"());\r\n");	
					
			}
			
		}

		//sb.append( "sbu.append(\"<vrstica"+idfunkcije+">\");\r\n");	

		sb.append("}  // while end\r\n");


			/// dam v array list

		sb.append("List lik"+idfunkcije+""+class1+" = new ArrayList();  // array list\r\n");
			
		sb.append("lik"+idfunkcije+""+class1+".add(modoo"+idfunkcije+class1+");\r\n");  // array list\r\n");
			
			
		sb.append("Iterator it"+idfunkcije+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n\r\n");
			
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//sb.append("String rezu=\"\";\r\n\r\n");


String imenavrstic = "";

sb.append( "sbu.append(\"<vrstice"+idfunkcije+">\");\r\n");


String stolpci = "<stolpec"+idfunkcije+">";



sb.append("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n");

sb.append(" mod"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name() +")(it"+idfunkcije+class1+".next());\r\n");
	

sb.append( "sbu.append(\"<vrstica"+idfunkcije+">\");\r\n");	
sb.append( "%////>\r\n");
int zapoo = 1;
Iterator itbv = tui.getTemplatelists().iterator();

while (itbv.hasNext()) {

com.popultrade.model.TemplateList tli = (com.popultrade.model.TemplateList)itbv.next();


stolpci = stolpci + "<col>\"+ConPool.getPrevod(\""+tli.getId()+"P\"+control.getJezik()).replaceAll(\"_\",\" \") +\"</col>";


/// pogledam, ce ima pogoje

if (tli.getTemplateClasses().size()>0) {
 
 Iterator iteb = tli.getTemplateClasses().iterator();
 sb.append("<%\r\n");
 
 
// String remu = ""; /////// format number , ce je double in ce ima vnesen format

// nul.getDatumFormatFromDate()
 while (iteb.hasNext()) {
	 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
	 
	 
	 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
				 
		
		 
		 /// pogoj
		 sb.append("\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","vseb.get")+" {\r\n");
		 
		 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
			 sb.append("rezu=nul.formatNumber(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
			 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
		 }
		 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
			 sb.append("rezu=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
		 }
		 else {
 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
				 
				sb.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n");
					 
				 
			 }
			 else {
			 sb.append("rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
			 }
			 }
			 
		 
		 
		 sb.append("}\r\n");
		 
	 }
	 
	 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
		 
			
		 
		 
		 
		 /// vrednost iz clase
		 
		 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
/// pogoj
if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
sb.append( nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get")+" {\r\n");
}

sb.append("if (true) {\r\n");
sb.append("rezu=\"\";\r\n");	 		 
sb.append("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n");

sb.append("com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n");




/// setam vrednosti

Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

Hashtable metto = this.getClassMetodeImenaHT(tc.getTemplateClassClass().getClass_name());

while (tre.hasNext()) {
com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();

/////// /////// /////////


String rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("\'","\"");

if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get","mod"+idfunkcije+class1+".get")+"()";
}

//System.out.println(((String)metto.get(tcc.getIme_pogoja()))+ " ::: IME POGOJA ::: "+tcc.getIme_pogoja());

if (metto.containsKey(tcc.getIme_pogoja())) {
if (((String)metto.get(tcc.getIme_pogoja())).indexOf("String")!=-1) {
	
//System.out.println("SOLEMMM : "+rett);

if (rett.indexOf("control.")!=-1 || rett.indexOf("nul.")!=-1 || nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	//rett = rett+"\"\"";
}

else	if (rett.indexOf("\"")==-1) {
		rett = "\""+rett+"\"";
	}
}
else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Long")!=-1) {
	if (rett.indexOf("\"")==-1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
		rett = "\""+rett+"\"";
	}
	
	rett = "new Long("+rett+")";
	
}
else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Integer")!=-1 || ((String)metto.get(tcc.getIme_pogoja())).indexOf("int")!=-1) {
	if (rett.indexOf("\"")==-1) {
		
	
	rett = rett.replaceAll("\"", "").replaceAll("\'", "");
	rett = "\""+rett+"\"";
	}
	
	rett = "Integer.parseInt("+rett+"+\"\")";
	
}
else if (((String)metto.get(tcc.getIme_pogoja())).indexOf("Double")!=-1) {
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
//sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");



if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
	sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n");
	
}
else {
	

sb.append("mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n");
}





}


sb.append("List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n");




sb.append("if (remi.size()>0) {\r\n");

sb.append("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n");




////pogoji vrednosti

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
		 sb.append("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get")+" {\r\n");
		 
		 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
			 sb.append("rezu=nul.formatNumber(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
			 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
		 }
		 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
			 sb.append("rezu=nul.getDatumFormatFromDate(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tli.getFormat_stolpca()+"\");\r\n");
		 }
		 else {
 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
				 
				 sb.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
					 
				 
			 }
			 else {
			 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
			 }
			 }
			 
		 
		 
		 sb.append("}\r\n");
		 
	 }
	 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
		 
		 
if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
			 
			 sb.append("rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n");
				 
			 
		 }
		 else {
		 sb.append("rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
		 }
	 }
	 }
}
else {
String dodvred = "";
if (!nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
	dodvred = " "+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
}
	

sb.append("rezu="+dodvred+"nul.jeNull(mod."+tcv.getVrednost()+"());\r\n\r\n");
}



}




sb.append("}\r\n");



sb.append("}\r\n");


if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
sb.append("}\r\n");
}			 
			 
			 
		 }
		 
		 
		 
		 
		 
		 
		 
		 
		 
	 }
	 else if (nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
		 
if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
			 
			 sb.append("rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n");
				 
			 
		 }
		 else {
		 sb.append("rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get","mod"+idfunkcije+class1+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n");
		 }
	 }
	 
	 
 }
 
 sb.append("%////>\r\n");
 
 
 
 
}
else {
 
 if (!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#")!=-1) {
	 sb.append("<%\r\n");
	 sb.append("rezu=nul.formatNumber(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
	 sb.append("%////>\r\n");
	 //sb.append("rezu="+tc.getVrednost_pogoja()+";\r\n\r\n");
 }
 else if (!nul.jeNull(tli.getFormat_stolpca()).equals("")) {
	 sb.append("<%\r\n");
	 sb.append("rezu=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tli.getFormat_stolpca()+"\");\r\n");
	 sb.append("%////>\r\n");
 }
 else {
	 sb.append("<%\r\n");
	 sb.append("rezu=nul.jeNull(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n");
	 sb.append("%////>\r\n");
 }
}



// String hinto = "";
/// ce ima hinte stolpec
// if (tli.getTemplateClassClass()!=null && tli.getTemplateClassClass().getClass_name()!=null && !tli.getTemplateClassClass().getClass_name().equals("")) {
// hinto = " onmouseout=\"hideddrivetip()\" onmousemove=\"ddrivetip(typeof(p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_mettoda()+"())%////>)=='string'?p"+tli.getId()+"<////%=nul.jeNull(vseb."+tli.getStolpec_mettoda()+"())%////>:'')\"";
 
// }


if (nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals("") ) {
 
 sb.append("<%\r\n");
 sb.append("rezu=nul.cutString(rezu,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n");
 sb.append("%////>\r\n");
 
 
}
String slik = "";
if (nul.jeNull(tli.getJeslika()).equals("1")) {
	slik = "<slik"+zapoo+">1</slik"+zapoo+">";
	sb.append("<%\r\n");
	sb.append("sbu.append(\""+slik+"<col"+zapoo+">\"+control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+rezu+\"</col"+zapoo+">\");\r\n");
	sb.append("%////>\r\n");
}
else {
slik = "<slik"+zapoo+">0</slik"+zapoo+">";
sb.append("<%\r\n");
sb.append("sbu.append(\""+slik+"<col"+zapoo+">\"+rezu+\"</col"+zapoo+">\");\r\n");
sb.append("%////>\r\n");
}

zapoo++;

}


sb.append("<////%\r\n");



sb.append("//////DOME"+idfunkcije+"//////\r\n");



sb.append( "sbu.append(\"</vrstica"+idfunkcije+">\");\r\n");	
		
	
sb.append("}  // while end\r\n");		
	

//sb.append("%////>\r\n");
sb.append( "sbu.append(\"</vrstice"+idfunkcije+">\");\r\n");

stolpci = stolpci+"</stolpec"+idfunkcije+">";
sb.append("sbu.append(\""+stolpci+"\");\r\n");



	
	
	
	
	sb.append("}\r\n");
	
	
	sb.append("}\r\n");
	
	return sb.toString();
	
	
	
	
}



























	
		
		public String getFieldHead(String premo,com.popultrade.model.TemplateView tu,String imevseb) {
			try {
				 imevseb = "mod"+imevseb;
				 if (tu.getTemplateClasses().size()>0) {
					 System.out.println("1VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
					 Iterator iteb = tu.getTemplateClasses().iterator();
					 premo = premo + "<%\r\n"; 
					 
					
					// String remu = ""; /////// format number , ce je double in ce ima vnesen format
				
					// nul.getDatumFormatFromDate()
					 while (iteb.hasNext()) {
						 com.popultrade.model.TemplateClass tc = (com.popultrade.model.TemplateClass)iteb.next();
						 
						 
						 if ((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
							 
							//System.out.println("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm" +tc.getPredpona_pogoja());
							 
							 /// pogoj
							 premo = premo + "\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get",""+imevseb+".get")+" {\r\n";
							 
							 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
								 premo = premo + "rezu=nul.formatNumber("+imevseb+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
								 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
							 }
							 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
								 premo = premo + "rezu=nul.getDatumFormatFromDate("+imevseb+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
							 }
							 else {
								 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
									 
									 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get",""+imevseb+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n";
										 
									 
								 }
								 else {
								 premo = premo + "rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get",""+imevseb+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
								 }
								 }
								 
							 
							 
							 premo = premo + "}\r\n";
							 
						 }
						 
						 else  if ((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) ) {
							 
								
							 System.out.println("122VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
							 
							 
							 /// vrednost iz clase
							 
							 if (tc.getTemplateClassClass()!=null && tc.getTemplateClassClass().getId()!=null) {
			/// pogoj
			if (!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE")) {
			premo = premo + nul.jeNull(tc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get",""+imevseb+".get")+" {\r\n";
			}
			 	 
			premo = premo + "if (true) {\r\n";
			premo = premo + "rezu=\"\";\r\n";	 
			premo = premo + "com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+ tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0,1).toLowerCase() +tc.getTemplateClassClass().getClass_name().substring(1) +"DAO\",pageContext.getServletContext());\r\n";

			premo = premo + "com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +"();\r\n";




			/// setam vrednosti
		System.out.println("133VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
			Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();

			Hashtable meto = this.getClassMetodeImenaHT(tc.getTemplateClassClass().getClass_name());
			
			while (tre.hasNext()) {
				com.popultrade.model.TemplateClass tcc = (com.popultrade.model.TemplateClass)tre.next();
				
				/////// /////// /////////
				
				
				String rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("\'","\"");
				
				if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
					rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get",""+imevseb+".get")+"()";
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
			//	premo = premo + "mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n";
				
				
				
				if (nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
					premo = premo + "mod."+tcc.getIme_pogoja()+"("+ rett+");\r\n";
					
				}
				else {
					
				
					premo = premo + "mod."+tcc.getIme_pogoja()+"("+ rett+"+\"\");\r\n";
				}
				System.out.println("441VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
				
				
				
				
			}


			premo = premo + "List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n";




			premo = premo + "if (remi.size()>0) {\r\n";

			premo = premo + "mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name() +")remi.get(0);\r\n";

		//	System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE123 ::: "+tc.getPredpona_pogoja());


			//// pogoji vrednosti

			Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();


			while (vredno.hasNext()) {
				com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)vredno.next();
				//System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE335 ::: "+tc.getPredpona_pogoja());
				if (tcv.getTemplateClasses().size()>0) {
				/// dobim templateclass
				Iterator item = tcv.getTemplateClasses().iterator();
						 while (item.hasNext()) {
						 com.popultrade.model.TemplateClass txc = (com.popultrade.model.TemplateClass)item.next();
						 
						 
						 if (nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE")) {
							 
							
							 
							 /// pogoj
							 premo = premo + "\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase() + " "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("\'","\"").replaceAll("get",""+imevseb+".get")+" {\r\n";
							 
							 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
								 premo = premo + "rezu=nul.formatNumber(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
								 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
							 }
							 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
								 premo = premo + "rezu=nul.getDatumFormatFromDate(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>","")+",\""+tu.getFormat_stolpca()+"\");\r\n";
							 }
							 else {
								 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
									 
									 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
										 
									 
								 }
								 else {
								 premo = premo + "rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
								 }
								 }
								 
							 
							 
							 premo = premo + "}\r\n";
							 
						 }
						 else if (nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
							 
							 if (!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals("")) {
								 
								 premo = premo + "rezu="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(txc.getFunkcija_formata3())+");\r\n\r\n";
									 
								 
							 }
							 else {
							 premo = premo + "rezu=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("get","mod.get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
							 }
						 }
						 }
				}
				else {
					
					//System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEExxx ::: "+tc.getPredpona_pogoja());
					String dodvred = "";
				if (!nul.jeNull(tc.getVrednost_pogoja()).equals("")) {
					dodvred = " "+tc.getVrednost_pogoja().replaceAll("\'","\"").replaceAll("get",""+imevseb+".get").replaceAll("\"\"\\)","\"\"\\)") +" + \" - \"+ ";
				}
					
				//System.out.println("VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: "+tc.getPredpona_pogoja());
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
							// System.out.println("FORMATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT" +nul.jeNull(tc.getFunkcija_formata1()));
							 if (!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals("")) {
								 
								 premo = premo + "rezu="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("\'","\"").replaceAll("get",""+imevseb+".get").replaceAll("nul.je","\"+nul.je").replaceAll("\"\"\\)","\"\"\\)+\"")+"()+\"\""+nul.jeNull(tc.getFunkcija_formata3())+");\r\n\r\n";
									 
								 
							 }
							 else {
							 premo = premo + "rezu=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("\'","\"").replaceAll("nul.je","\"+nul.je").replaceAll("get",""+imevseb+".get").replaceAll("\"\"\\)","\"\"\\)+\"")+"\";\r\n\r\n";
							 }
						 }
						 
						 
					 }
					 
					 premo = premo + "%////>\r\n";
					 
					 
					 
					 
				 }
				 else {
					 
					 if (!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#")!=-1) {
						 premo = premo + "<%\r\n";
						 premo = premo + "rezu=nul.formatNumber("+imevseb+"."+tu.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tu.getFormat_stolpca()+"\");\r\n";
						 premo = premo + "%////>";
						 //premo = premo + "rezu="+tc.getVrednost_pogoja()+";\r\n\r\n";
					 }
					 else if (!nul.jeNull(tu.getFormat_stolpca()).equals("")) {
						 premo = premo + "<%\r\n";
						 premo = premo + "rezu=nul.getDatumFormatFromDate("+imevseb+"."+tu.getStolpec_metoda().replaceAll("<.*?>","")+"(),\""+tu.getFormat_stolpca()+"\");\r\n";
						 premo = premo + "%////>";
					 }
					 else {
						 premo = premo + "<%\r\n";
						 premo = premo + "rezu=nul.jeNull("+imevseb+"."+tu.getStolpec_metoda().replaceAll("\'","\"")+"()+\"\");\r\n\r\n";
						 premo = premo + "%////>";
					 }
				 }
			        
			   
			        	//	premo = premo + "<////%=rezu%////>";
			        		
			        	
			        
			        
			    //    premo = premo + "</td>";
			        return premo;
			}
			catch (Exception ex) {
				System.out.println(ex.toString());
			}
			return "";
		
		
		
	}
	
	
	
	
	
	
}
