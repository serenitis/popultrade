package com.popultrade.webapp;

import com.popultrade.dao.*;
import com.popultrade.model.*;
import java.io.*;
import java.lang.reflect.Method;
import java.util.*;
import java.util.jar.JarEntry;
import java.util.jar.JarInputStream;
import javax.servlet.ServletContext;
import org.apache.commons.lang.StringUtils;
// Referenced classes of package com.popultrade.webapp:
//            chkNull, control, Parametri, ContextUtil

public class TemplateUtils implements java.io.Serializable 
{

	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1009897867655443234L;
	private String lokacija_jar;
    public chkNull nul;
    private control cont;
    private String packageName_fixno;
    private Parametri parametri;
    
    
    private ContextUtil contextUtil2;
    private ServletContext servletContext2;
    
    private String id_veza=""; // veza na predhoden del fo datoteke, pri sestavljanju fo datoteke, ce vmes je select brez prikaza se zveze naslednji na podlagi tega parametra
    private boolean id_v_je=false;
    private boolean headerizpis = false; // ce naslov je bil ze izpisan
    
    public String getLokacija_jar() {
		return lokacija_jar;
	}

	public void setLokacija_jar(String lokacija_jar) {
		this.lokacija_jar = lokacija_jar;
	}


	Hashtable ht_loop;
    Hashtable ht_loop_id;
    Hashtable ht_loop_idv;
    Hashtable ht_loop_a;
    Hashtable ht_loop_b;
    int zapi;
    int zapifo;
    Hashtable ht_loopfo;
    Hashtable ht_loopfo_id;
	
    
    
    //// replace v primeru <header></header> --- se pravi brez vsebine
    
    String replaceHeaders =  "";
    
    
    
    
    
	
	
    public TemplateUtils()
    {
    	
    	
    	
      //  lokacija_jar = "c:/Tomcat7.0/webapps/ics/WEB-INF/lib/ics-dao.jar";
        lokacija_jar =  "/home/red5u/red5/webapps/icsm/WEB-INF/lib/icsm-dao.jar";
        nul = new chkNull();
        cont = new control();
        packageName_fixno = "com.popultrade.model";
        parametri = new Parametri();
        ht_loop = new Hashtable();
        ht_loop_id = new Hashtable();
        ht_loop_idv = new Hashtable();
        ht_loop_a = new Hashtable();
        ht_loop_b = new Hashtable();
        zapi = 0;
        zapifo = 0;
        ht_loopfo = new Hashtable();
        ht_loopfo_id = new Hashtable();
        try
        {
            lokacija_jar = parametri.getParametri().getProperty("lokacija_jar");
            packageName_fixno = parametri.getParametri().getProperty("packageName_fixno");
        }
        catch(Exception er) { }
    }
    
    
    
    


    public Hashtable[] getClassMetodeImenaHTGet(String ime_classe,String nadrejena,boolean ena)
    {
        Hashtable metode = new Hashtable();
         Hashtable vsebine = new Hashtable();
        try
        {
            Class testClass = Class.forName((new StringBuilder()).append("com.popultrade.model").append(".").append(ime_classe).toString());
            Method methods[] = testClass.getDeclaredMethods();
        
           
           
            Method arr$[] = methods;
            int len$ = arr$.length;
            for(int i$ = 0; i$ < len$; i$++)
            {
            
            
             boolean dajn = false;
                Method method = arr$[i$];
                if(method.getName() != null && method.getName().startsWith("get")  && ((method.getReturnType()+"").indexOf("java.util.List")!=-1 || (method.getReturnType()+"").indexOf(".model.")!=-1)) {
                    
                    
                  String kon = "";
                       java.lang.annotation.Annotation[] ano= method.getAnnotations();
         //  testClass.getDeclaredAnnotations()
         boolean nextjoin  = false;
           for (int k=0;k<ano.length;k++) {
           String one = ano[k].toString();
           
           if (one.indexOf("OneToMany")!=-1) {
           
           if (one.indexOf("targetEntity")!=-1) {
           String delo = one.substring(one.indexOf("targetEntity=")+13);
            kon = delo.substring(delo.indexOf(" ")+1,delo.indexOf(")"));
           dajn=true;
           System.out.println("-xx- "+kon);
           //// zapisem sete za nove idje
           
         /*  if (vsebine.containsKey(method.getName())) {
             vsebine.put(method.getName(), vsebine.get(method.getName()) +";\r\n"+ "-----."+method.getName().replaceFirst("get", "set")+"(null)");
         
           }
           else {
           
           vsebine.put(method.getName(),"-----."+method.getName().replaceFirst("get", "set")+"(null)");
           }*/
           
           String retk = kon.substring(kon.lastIndexOf(".")+1);
           
           vsebine.put(method.getName(), getClassMetodeImenaHTGetNullable(retk));
           
           
           
           nextjoin=true;
           }
           
           }
            if (one.indexOf("JoinColumn")!=-1 && nextjoin) {
            nextjoin=false;
              String name1 = one.substring(one.indexOf("referencedColumnName=")+21);
            name1 = name1.substring(0,name1.indexOf(","));
            name1 = name1.substring(0,1).toUpperCase()+name1.substring(1);
            
            
            String name = one.substring(one.indexOf("name=")+5);
            name = name.substring(0,name.indexOf(","));
            
            
            name = name.substring(0,1).toUpperCase()+name.substring(1)+"(_____.get"+name1+"())";
            if (!ena) {
            vsebine.put(method.getName(), vsebine.get(method.getName()) +"\r\n"+ "-----.set"+name+";\r\n"); /// menjam id da je vezan na novo
            }
            }
           
         //  System.out.println("-++- "+one);
           
           
                 if (one.indexOf("OneToOne")!=-1 && one.indexOf("mappedBy=,")==-1) { /// ne sme biti reverse
           dajn=true;
          // if (one.indexOf("targetEntity")!=-1) {
         //  String delo = one.substring(one.indexOf("targetEntity=")+13);
          //  kon = delo.substring(delo.indexOf(" ")+1,delo.indexOf(")"));
           
       //    System.out.println("-x- "+kon);
           
           
         String cvt =   method.getReturnType().toString();
               String retk = cvt.substring(cvt.lastIndexOf(".")+1);
         //  if (!ena) {
           vsebine.put(method.getName(), getClassMetodeImenaHTGetNullable(retk));
        //   }
           
          // }
           
           }
           
           }
                    
                    String kontr = "";
                    
                    
                    
                    if (kon.indexOf(".")!=-1) {
                    kontr = kon.substring(kon.lastIndexOf(".")+1);
                    
                    }
                    
                    if (kon.equals("")) {
                    
                    kontr = (method.getReturnType()+"").toLowerCase();
                    
                    kontr = kontr.substring(kontr.lastIndexOf(".")+1);
                    
                    }
                    
                    
                   // System.out.println("::: "+method.getName()+" ::: "+method.getReturnType()+" ::: "+nadrejena +" _ "+(method.getReturnType()+"").toLowerCase().endsWith(nadrejena.toLowerCase()));
                    System.out.println(nadrejena.toLowerCase()+"-------- "+kontr.toLowerCase()+" ------- "+StringUtils.countMatches(nadrejena.toLowerCase(), kontr.toLowerCase()));
                    /// ce je vec kot n nadrejenih ne dodam
                       if (StringUtils.countMatches(nadrejena.toLowerCase(), kontr.toLowerCase())<3   ) {
                 
                  //  if (!kon.toLowerCase().endsWith(nadrejena.toLowerCase()) && !(method.getReturnType()+"").toLowerCase().endsWith(nadrejena.toLowerCase())) {
                   
                  /*  if (kon.equals("")) {
                    
                    String omn = (method.getReturnType()+"").toLowerCase();
                    
                    omn = omn.substring(omn.lastIndexOf(".")+1);
                    
                    if (zeonetoone.containsKey(omn)) {
                    dajn=false;
                    }
                    
                    }*/
                    
                    
                    if (dajn) {
                   metode.put(method.getName(), (new StringBuilder()).append(method.getReturnType()).append("").toString()+"::::"+kon);
                    }
                    
                    }
                    }
                    
    
            }



        }
        catch(ClassNotFoundException ex)
        {
            System.out.println((new StringBuilder()).append("Napaka pri pridobivanju imena clase! ").append(ex.toString()).toString());
        }
        
        
        Hashtable[] retx = new Hashtable[2];
		retx[0]=metode;
		retx[1]=vsebine;
        return retx;
    }


    
    
    

    public String getClassMetodeImenaHTGetNullable(String ime_classe)
      {
     String vsek = "";
          try
          {
              Class testClass = Class.forName((new StringBuilder()).append("com.popultrade.model").append(".").append(ime_classe).toString());
              Method methods[] = testClass.getDeclaredMethods();
          
             
             
              Method arr$[] = methods;
              int len$ = arr$.length;
              for(int i$ = 0; i$ < len$; i$++)
              {
              
              
               boolean dajn = false;
                  Method method = arr$[i$];
                  if(method.getName() != null && method.getName().startsWith("get")  && ((method.getReturnType()+"").indexOf("java.util.List")!=-1 || (method.getReturnType()+"").indexOf(".model.")!=-1)) {
                      
                      
                    String kon = "";
                         java.lang.annotation.Annotation[] ano= method.getAnnotations();
           //  testClass.getDeclaredAnnotations()
           boolean nextjoin  = false;
             for (int k=0;k<ano.length;k++) {
             String one = ano[k].toString();
             
             if (one.indexOf("OneToMany")!=-1) {
             
             if (one.indexOf("targetEntity")!=-1) {
             String delo = one.substring(one.indexOf("targetEntity=")+13);
              kon = delo.substring(delo.indexOf(" ")+1,delo.indexOf(")"));
             dajn=true;
             System.out.println("-- "+kon);
             //// zapisem sete za nove idje
             
          
             vsek+="-----."+method.getName().replaceFirst("get", "set")+"(null);\r\n";
             
             
             nextjoin=true;
             }
             
             }
              if (one.indexOf("JoinColumn")!=-1 && nextjoin) {
              nextjoin=false;
                String name1 = one.substring(one.indexOf("referencedColumnName=")+21);
              name1 = name1.substring(0,name1.indexOf(","));
              name1 = name1.substring(0,1).toUpperCase()+name1.substring(1);
              
              
              String name = one.substring(one.indexOf("name=")+5);
              name = name.substring(0,name.indexOf(","));
              
              
              name = name.substring(0,1).toUpperCase()+name.substring(1)+"(_____.get"+name1+"())";
              
              if (vsek.indexOf("-----.set"+name)==-1) {
              }
              else {
              vsek+=  "-----.set"+name+";\r\n"; /// menjam id da je vezan na novo
  			}
              }
             
          //   System.out.println("-++- "+one);
             
             
                   if (one.indexOf("OneToOne")!=-1 ) { /// ne sme biti reverse
          //   dajn=true;
            // if (one.indexOf("targetEntity")!=-1) {
           //  String delo = one.substring(one.indexOf("targetEntity=")+13);
            //  kon = delo.substring(delo.indexOf(" ")+1,delo.indexOf(")"));
            
            if (one.indexOf("mappedBy=,")==-1) {
            
               vsek+="-----."+method.getName().replaceFirst("get", "set")+"(null);\r\n";
             }
             
             //System.out.println("-- "+kon);
            // }
             
             }
             
             }
                      
                    //  System.out.println("::: "+method.getName()+" ::: "+method.getReturnType()+" ::: "+nadrejena +" _ "+(method.getReturnType()+"").toLowerCase().endsWith(nadrejena.toLowerCase()));
                      
                     
                    
                      
                      
                      }
              }

          }
          catch(ClassNotFoundException ex)
          {
              System.out.println((new StringBuilder()).append("Napaka pri pridobivanju imena clase! ").append(ex.toString()).toString());
          }
          
        
          return vsek;
      }

    
    
    
    

    public String createPPView(TemplateView tu,String imevseb) {
    	
      	
    	 
    	String premo = "";
    	
        System.out.println("1VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
        Iterator iteb = tu.getTemplateClasses().iterator();
        premo = (premo+"<%\r\n");
        
        
        com.popultrade.dao.TemplateClassPPDAO daouid = (com.popultrade.dao.TemplateClassPPDAO)contextUtil2.getBeanDao("templateClassPPDAO",servletContext2);
   	 com.popultrade.model.TemplateClassPP tuidd = daouid.getTemplateClassPPs(""+tu.getId());
   	 System.out.println("-------------------------------------------------------------------");
   	 if (tuidd!=null && tuidd.getContent()!=null){
   	 premo = premo + tuidd.getContent()+"\r\n"; 
   	 }
        
      //  premo = premo+content;
        
        premo = (premo+"r=r+\"\";\r\n");
        do
        {
            if(!iteb.hasNext()) {
                break;
            }
            
            TemplateClass tc = (TemplateClass)iteb.next();
            if((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT"))
            {
                premo = (premo+"\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n");
                if(!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#") != -1)
                    premo = (premo+"r=nul.formatNumber("+imevseb+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+tu.getFormat_stolpca()+"\");\r\n");
                else
                if(!nul.jeNull(tu.getFormat_stolpca()).equals(""))
                    premo = (premo+"r=nul.getDatumFormatFromDate("+imevseb+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+tu.getFormat_stolpca()+"\");\r\n");
                else
                if(!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals(""))
                    premo = (premo+"r="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get"))+"()+\"\""+(nul.jeNull(tc.getFunkcija_formata3()).indexOf("vseb.") != -1 ? replaceNeznanke2(replaceNeznanke1(nul.jeNull(tc.getFunkcija_formata3())).replaceAll("get", ("mod"+imevseb+".get"))) : nul.jeNull(tc.getFunkcija_formata3()).replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get")))+");\r\n\r\n");
                else
                    premo = (premo+"r="+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get"))+"+\"\";\r\n\r\n");
                premo = (premo+"r2=r2+\" \"+r;\r\n");
                premo = (premo+"}\r\n");
            } else
            if(nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE"))
            {
                System.out.println("122VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
                if(tc.getTemplateClassClass() != null && tc.getTemplateClassClass().getId() != null)
                {
                    if(!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE"))
                        premo = (premo+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n");
                    premo = (premo+"if (true) {\r\n");
                    premo = (premo+"r=\"\";\r\n");
                    premo = (premo+"com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0, 1).toLowerCase()+tc.getTemplateClassClass().getClass_name().substring(1)+"DAO\",pageContext.getServletContext());\r\n");
                    premo = (premo+"com.popultrade.model."+tc.getTemplateClassClass().getClass_name()+" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name()+"();\r\n");
                    System.out.println("133VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: ");
                    Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();
                    Hashtable meto = getClassMetodeImenaHT(null,null,tc.getTemplateClassClass().getClass_name());
                    for(; tre.hasNext(); System.out.println("441VALUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ::: "))
                    {
                        TemplateClass tcc = (TemplateClass)tre.next();
                        String rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("'", "\"");
                        String kontr = "";
                        if(nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
                            if(tcc.getVrednost_pogoja() != null && !nul.jeNull(tcc.getVrednost_pogoja()).substring(tcc.getVrednost_pogoja().length() - 1, tcc.getVrednost_pogoja().length()).equals(")"))
                            {
                                rett = (nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get", (""+imevseb+".get"))+"()");
                                kontr = ("if ("+rett+"!=null) {");
                            } else
                            {
                                rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get", (""+imevseb+".get")).replaceAll("'", "\"");
                            }
                        
                        }
                        else if (nul.jeNull(tcc.getVrsta_pogoja()).equals("variable")) {
                            rett = nul.jeNull(tcc.getVrednost_pogoja());
                            
                        	
                        }
                        
                        if(meto.containsKey(tcc.getIme_pogoja()))
                            if(((String)meto.get(tcc.getIme_pogoja())).indexOf("String") != -1)
                            {
                                if(rett.indexOf("control.") == -1 && rett.indexOf("nul.") == -1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class") && !nul.jeNull(tcc.getVrsta_pogoja()).equals("variable") && rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                            } else
                            if(((String)meto.get(tcc.getIme_pogoja())).indexOf("Long") != -1)
                            {
                                if(rett.indexOf("\"") == -1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class") && !nul.jeNull(tcc.getVrsta_pogoja()).equals("variable")) {
                                    rett = ("\""+rett+"\"");
                            }
                                
                                
                                rett = ("new Long("+rett+")");
                            } else
                            if(((String)meto.get(tcc.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcc.getIme_pogoja())).indexOf("int") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                {
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                    if(!nul.jeNull(tcc.getVrsta_pogoja()).equals("class") && !nul.jeNull(tcc.getVrsta_pogoja()).equals("variable")) {
                                        rett = ("\""+rett+"\"");
                                    }
                                    else {
                                        rett = rett;
                                    }
                                }
                                rett = ("Integer.parseInt("+rett+"+\"\")");
                            } else
                            if(((String)meto.get(tcc.getIme_pogoja())).indexOf("Double") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                {
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                    if(!nul.jeNull(tcc.getVrsta_pogoja()).equals("class") && !nul.jeNull(tcc.getVrsta_pogoja()).equals("variable"))
                                        rett = ("\""+rett+"\"");
                                    else
                                        rett = rett;
                                }
                                if(rett.indexOf(",") != -1)
                                    rett = rett.replaceAll("\\,", "\\.");
                                rett = ("Double.parseDouble("+rett+"+\"\")");
                            }
                        if(nul.jeNull(tcc.getVrsta_pogoja()).equals("class") || nul.jeNull(tcc.getVrsta_pogoja()).equals("variable"))
                        {
                            if(!kontr.equals(""))
                                premo = (premo+kontr+"\r\n");
                            
                            premo = (premo+"mod."+tcc.getIme_pogoja()+"("+rett+");\r\n");
                            
                            if(!kontr.equals(""))
                                premo = (premo+"}\r\n");
                        } else
                        {
                            premo = (premo+"mod."+tcc.getIme_pogoja()+"("+rett+"+\"\");\r\n");
                        }
                    }

                    tre = tc.getTemplateClassClass().getTemplateClasss().iterator();
                    String kontif = "";
                    do
                    {
                        if(!tre.hasNext())
                            break;
                        TemplateClass tcc = (TemplateClass)tre.next();
                        String rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("'", "\"");
                        if(nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
                            if(tcc.getVrednost_pogoja() != null && !nul.jeNull(tcc.getVrednost_pogoja()).substring(tcc.getVrednost_pogoja().length() - 1, tcc.getVrednost_pogoja().length()).equals(")"))
                            {
                                rett = ("nul.jeN("+nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get", (""+imevseb+".get"))+"()+\"\")");
                                kontif = (kontif+" !"+rett+".equals(\"\") && ");
                            } else
                            {
                                rett = ("nul.jeN("+nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get", (""+imevseb+".get")).replaceAll("'", "\"")+"+\"\")");
                            }
                    }
                        else if(nul.jeNull(tcc.getVrsta_pogoja()).equals("variable")) {
                        	
                            rett = (""+nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get", (""+imevseb+".get")).replaceAll("'", "\"")+"");
                            
                        }
                        
                    } while(true);
                    if(!kontif.equals(""))
                        premo = (premo+"if ("+kontif.substring(0, kontif.length() - 3)+") {\r\n");
                    premo = (premo+"List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n");
                    premo = (premo+"if (remi.size()>0) {\r\n");
                    premo = (premo+"mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name()+")remi.get(0);\r\n");
                    premo = (premo+"try {\r\n");
                    Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
label0:
                    do
                    {
                        if(!vredno.hasNext())
                            break;
                        TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                        if(tcv.getTemplateClasses().size() > 0)
                        {
                            Iterator item = tcv.getTemplateClasses().iterator();
                            do
                            {
                                if(!item.hasNext())
                                    continue label0;
                                TemplateClass txc = (TemplateClass)item.next();
                                if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                {
                                    if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF"))
                                        premo = (premo+"r=\"\";\r\n");
                                    premo = (premo+"\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n");
                                    if(!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#") != -1)
                                        premo = (premo+"r=nul.formatNumber(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+tu.getFormat_stolpca()+"\");\r\n");
                                    else
                                    if(!nul.jeNull(tu.getFormat_stolpca()).equals(""))
                                        premo = (premo+"r=nul.getDatumFormatFromDate(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+tu.getFormat_stolpca()+"\");\r\n");
                                    else
                                    if(!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals(""))
                                        premo = (premo+"r="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", "mod.get")+"()+\"\""+(nul.jeNull(txc.getFunkcija_formata3()).indexOf("vseb.") != -1 ? replaceNeznanke2(replaceNeznanke1(nul.jeNull(txc.getFunkcija_formata3())).replaceAll("get", "mod.get")) : nul.jeNull(txc.getFunkcija_formata3()).replaceAll("'", "\"").replaceAll("get", "mod.get"))+");\r\n\r\n");
                                    else
                                        premo = (premo+"r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", "mod.get")+"+\"\";\r\n\r\n");
                                    premo = (premo+"}\r\n");
                                } else
                                if(nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
                                    if(!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals(""))
                                        premo = (premo+"r="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", "mod.get")+"()+\"\""+(nul.jeNull(txc.getFunkcija_formata3()).indexOf("vseb.") != -1 ? replaceNeznanke2(replaceNeznanke1(nul.jeNull(txc.getFunkcija_formata3())).replaceAll("get", "mod.get")) : nul.jeNull(txc.getFunkcija_formata3()).replaceAll("'", "\"").replaceAll("get", "mod.get"))+");\r\n\r\n");
                                    else
                                    if(nul.jeNull(tc.getUporabi_kot_neznanka()).equals("1"))
                                        premo = (premo+""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n");
                                    else
                                        premo = (premo+"r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", "mod.get")+"+\"\";\r\n\r\n");
                            }
                                else  if(nul.jeNull(txc.getPredpona_pogoja()).equals("VARIABLE")) {
                                   
                                    premo = (premo+""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("get", "mod.get")+";\r\n\r\n");
                                     }
                                
                            	if (!nul.jeN(txc.getRocna_vrednost()).equals("")) {
                            		premo = premo +(txc.getRocna_vrednost()+";\r\n");
                            	}
                                
                            
                            } while(true);
                        }
                        String dodvred = "";
                        if(!nul.jeNull(tc.getVrednost_pogoja()).equals(""))
                            dodvred = (" "+tc.getVrednost_pogoja().replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get")).replaceAll("\"\"\\)", "\"\"\\)")+" + \" - \"+ ");
                        premo = (premo+"r="+dodvred+"nul.jeN(mod."+tcv.getVrednost()+"());\r\n\r\n");
                    } while(true);
                    premo = (premo+"r2=r2+\" \"+r;\r\n");
                    premo = (premo+"}\r\n");
                    premo = (premo+"catch (Exception exxx){}\r\n");
                    premo = (premo+"}\r\n");
                    if(!kontif.equals(""))
                        premo = (premo+"}\r\n");
                    premo = (premo+"}\r\n");
                    if(!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE"))
                        premo = (premo+"}\r\n");
                }
            } else
            if(nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT"))
            {
                if(!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals(""))
                    premo = (premo+"r="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", "mod.get")+"()+\"\""+(nul.jeNull(tc.getFunkcija_formata3()).indexOf("vseb.") != -1 ? nul.jeNull(tc.getFunkcija_formata3()).replaceAll("'", "\"") : nul.jeNull(tc.getFunkcija_formata3()).replaceAll("'", "\"").replaceAll("get", "mod.get"))+");\r\n\r\n");
                else
                if(nul.jeNull(tc.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tc.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)
                    premo = (premo+"r="+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n");
                else
                if(nul.jeNull(tc.getUporabi_kot_neznanka()).equals("1"))
                    premo = (premo+""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n");
                else {
                  if (!nul.jeNull(tc.getVrednost_pogoja()).trim().equals("")) {  
                	  premo = (premo+"r=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get"))+"+\"\";\r\n\r\n");}
                }
                  premo = (premo+"r2=r2+\" \"+r;\r\n");
            }
            else if(nul.jeNull(tc.getPredpona_pogoja()).equals("VARIABLE"))
                {
           	  premo = (premo+""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", (""+imevseb+".get"))+";\r\n\r\n");
             
                   
                }
            
        	if (!nul.jeN(tc.getRocna_vrednost()).equals("")) {
        		premo = premo +(tc.getRocna_vrednost()+";\r\n");
        	}
            
            
        } while(true);
        premo = (premo+"r=r2;\r\n");
        premo = (premo+"%////>\r\n");
        
        
        
    	return premo;
    	
    }
    
    
    public String createPP(Object tlii,String tipobjekta,String idfunkcije,String class1) {
    	
    	
    	StringBuffer sb = new StringBuffer();

    	Iterator iteb=null;

		String format_stolpca=""; 
		 String idd = "";
		 if (tipobjekta.equals("templateui")) {
		 format_stolpca = ((com.popultrade.model.TemplateUi)tlii).getFormat_stolpca();
		 idd = ((com.popultrade.model.TemplateUi)tlii).getId()+"";
		  iteb = ((com.popultrade.model.TemplateUi)tlii).getTemplateClasses().iterator();
		}
		else if (tipobjekta.equals("templatelist")) {
		format_stolpca = ((com.popultrade.model.TemplateList)tlii).getFormat_stolpca();
		idd = ((com.popultrade.model.TemplateList)tlii).getId()+"";
		 iteb = ((com.popultrade.model.TemplateList)tlii).getTemplateClasses().iterator();
		
		}
			else if (tipobjekta.equals("templatepp")) {
		format_stolpca = ((com.popultrade.model.TemplatePP)tlii).getFormat_stolpca();
		idd = ((com.popultrade.model.TemplatePP)tlii).getId()+"";
		 iteb = ((com.popultrade.model.TemplatePP)tlii).getTemplateClasses().iterator();
		
		}
    	
    	
      //  Iterator iteb = tli.getTemplateClasses().iterator();
        
        
        
        
        
        sb.append("<%\r\n");
        
        com.popultrade.dao.TemplateClassPPDAO daouid = (com.popultrade.dao.TemplateClassPPDAO)contextUtil2.getBeanDao("templateClassPPDAO",servletContext2);
   	 com.popultrade.model.TemplateClassPP tuidd = daouid.getTemplateClassPPs(""+idd);
   	 System.out.println("-------------------------------------------------------------------");
   	 if (tuidd!=null && tuidd.getContent()!=null){
   	 sb.append(tuidd.getContent()+"\r\n"); 
   	 }
        
        
        
        do
        {
            if(!iteb.hasNext()) {
                break;
            }
            
            TemplateClass tc = (TemplateClass)iteb.next();
            if((nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && (!nul.jeNull(tc.getVrednost_pogoja()).equals("") || !nul.jeNull(tc.getFunkcija_formata1()).equals("")) && !nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") && !nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT"))
            {
                sb.append("r=\"\";\r\n");
                sb.append(("\r\n"+nul.jeNull(tc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"));
                if(!nul.jeNull(format_stolpca).equals("") && nul.jeNull(format_stolpca).indexOf("#") != -1)
                    sb.append(("r=nul.formatNumber(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+format_stolpca+"\");\r\n"));
                else
                if(!nul.jeNull(format_stolpca).equals(""))
                    sb.append(("r=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+format_stolpca+"\");\r\n"));
                else
                if(!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals(""))
                    sb.append(("r="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+"()+\"\""+replaceNeznanke2(replaceNeznanke1(nul.jeNull(tc.getFunkcija_formata3())).replaceAll("get", ("mod"+idfunkcije+class1+".get")))+");\r\n\r\n"));
                else
                    sb.append(("r="+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+";\r\n\r\n"));
                sb.append("}\r\n");
            } else
            if((nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE") || nul.jeNull(tc.getPredpona_pogoja()).equals("IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(tc.getPredpona_pogoja()).equals("ELSE")) && nul.jeNull(tc.getVrednost_pogoja()).equals(""))
            {
                if(tc.getTemplateClassClass() != null && tc.getTemplateClassClass().getId() != null)
                {
                    if(!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE"))
                    {
                        sb.append("r=\"\";\r\n");
                        sb.append((nul.jeNull(tc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(tc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"));
                    }
                    sb.append("if (true) {\r\n");
                    sb.append("r=\"\";\r\n");
                    sb.append(("com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO doa =(com.popultrade.dao."+tc.getTemplateClassClass().getClass_name()+"DAO)contextUtil.getBeanDao(\""+tc.getTemplateClassClass().getClass_name().substring(0, 1).toLowerCase()+tc.getTemplateClassClass().getClass_name().substring(1)+"DAO\",pageContext.getServletContext());\r\n"));
                    sb.append(("com.popultrade.model."+tc.getTemplateClassClass().getClass_name()+" mod = new com.popultrade.model."+tc.getTemplateClassClass().getClass_name()+"();\r\n"));
                    Iterator tre = tc.getTemplateClassClass().getTemplateClasss().iterator();
                    Hashtable metto = getClassMetodeImenaHT(null,null,tc.getTemplateClassClass().getClass_name());
                    while(tre.hasNext()) 
                    {
                        TemplateClass tcc = (TemplateClass)tre.next();
                        String rett = nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("'", "\"");
                        if(nul.jeNull(tcc.getVrsta_pogoja()).equals("class")) {
                            rett = (nul.jeNull(tcc.getVrednost_pogoja()).replaceAll("get", ("mod"+idfunkcije+class1+".get"))+"()");
                    }
                        else  if(nul.jeNull(tcc.getVrsta_pogoja()).equals("variable")) {
                            rett = (nul.jeNull(tcc.getVrednost_pogoja()));
                            
                        }
                        
                        if(metto.containsKey(tcc.getIme_pogoja()))
                            if(((String)metto.get(tcc.getIme_pogoja())).indexOf("String") != -1)
                            {
                                if(rett.indexOf("control.") == -1 && rett.indexOf("nul.") == -1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class") && !nul.jeNull(tcc.getVrsta_pogoja()).equals("variable") && rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                            } else
                            if(((String)metto.get(tcc.getIme_pogoja())).indexOf("Long") != -1)
                            {
                                if(rett.indexOf("\"") == -1 && !nul.jeNull(tcc.getVrsta_pogoja()).equals("class") && !nul.jeNull(tcc.getVrsta_pogoja()).equals("variable")) {
                                    rett = ("\""+rett+"\"");
                                }
                                rett = ("new Long("+rett+")");
                            } else
                            if(((String)metto.get(tcc.getIme_pogoja())).indexOf("Integer") != -1 || ((String)metto.get(tcc.getIme_pogoja())).indexOf("int") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                {
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                    rett = ("\""+rett+"\"");
                                }
                                rett = ("Integer.parseInt("+rett+"+\"\")");
                            } else
                            if(((String)metto.get(tcc.getIme_pogoja())).indexOf("Double") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                {
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                    rett = ("\""+rett+"\"");
                                }
                                if(rett.indexOf(",") != -1)
                                    rett = rett.replaceAll("\\,", "\\.");
                                rett = ("Double.parseDouble("+rett+"+\"\")");
                            }
                        if(nul.jeNull(tcc.getVrsta_pogoja()).equals("class") || nul.jeNull(tcc.getVrsta_pogoja()).equals("variable"))
                            sb.append(("mod."+tcc.getIme_pogoja()+"("+rett+");\r\n"));
                        else
                            sb.append(("mod."+tcc.getIme_pogoja()+"("+rett+"+\"\");\r\n"));
                    }
                    sb.append(("List remi=doa.get"+tc.getTemplateClassClass().getClass_name()+"s(mod);\r\n"));
                    sb.append("if (remi.size()>0) {\r\n");
                    sb.append(("mod=(com.popultrade.model."+tc.getTemplateClassClass().getClass_name()+")remi.get(0);\r\n"));
                    Iterator vredno = tc.getTemplateClassClass().getTemplateClassClass_vrednostis().iterator();
label0:
                    do
                    {
                        if(!vredno.hasNext())
                            break;
                        TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                        if(tcv.getTemplateClasses().size() > 0)
                        {
                            Iterator item = tcv.getTemplateClasses().iterator();
                            do
                            {
                                if(!item.hasNext())
                                    continue label0;
                                TemplateClass txc = (TemplateClass)item.next();
                                if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                {
                                    sb.append("r=\"\";\r\n");
                                    sb.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"));
                                    if(!nul.jeNull(format_stolpca).equals("") && nul.jeNull(format_stolpca).indexOf("#") != -1)
                                        sb.append(("r=nul.formatNumber(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+format_stolpca+"\");\r\n"));
                                    else
                                    if(!nul.jeNull(format_stolpca).equals(""))
                                        sb.append(("r=nul.getDatumFormatFromDate(mod."+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("<.*?>", "")+",\""+format_stolpca+"\");\r\n"));
                                    else
                                    if(!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals(""))
                                        sb.append(("r="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", "mod.get")+"()+\"\""+replaceNeznanke2(replaceNeznanke1(nul.jeNull(txc.getFunkcija_formata3())).replaceAll("get", "mod.get"))+");\r\n\r\n"));
                                    else
                                        sb.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", "mod.get")+";\r\n\r\n"));
                                    sb.append("}\r\n");
                                } else
                                if(nul.jeNull(txc.getPredpona_pogoja()).equals("FORMAT")) {
                                    if(!nul.jeNull(txc.getFunkcija_formata1()).equals("") && !nul.jeNull(txc.getFunkcija_formata2()).equals(""))
                                        sb.append(("r="+nul.jeNull(txc.getFunkcija_formata1())+"("+txc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", "mod.get")+"()+\"\""+replaceNeznanke2(replaceNeznanke1(nul.jeNull(txc.getFunkcija_formata3())).replaceAll("get", "mod.get"))+");\r\n\r\n"));
                                    else
                                    if(nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                        sb.append((""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", "mod.get")+";\r\n\r\n"));
                                    else
                                        sb.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", "mod.get")+";\r\n\r\n"));
                            }
                                else  if(nul.jeNull(txc.getPredpona_pogoja()).equals("VARIABLE")) {
                                     
                                    sb.append((""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", "mod.get")+";\r\n\r\n"));
                                        }
                            	if (!nul.jeN(txc.getRocna_vrednost()).equals("")) {
                            		sb.append(txc.getRocna_vrednost()+";\r\n");
                            	}
                            
                            } while(true);
                        }
                        String dodvred = "";
                        if(!nul.jeNull(tc.getVrednost_pogoja()).equals(""))
                            dodvred = (" "+tc.getVrednost_pogoja().replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("\"\"\\)", "\"\"\\)")+" + \" - \"+ ");
                        sb.append(("r="+dodvred+"nul.jeN(mod."+tcv.getVrednost()+"());\r\n\r\n"));
                    } while(true);
                    sb.append("}\r\n");
                    sb.append("}\r\n");
                    if(!nul.jeNull(tc.getPredpona_pogoja()).equals("VALUE"))
                        sb.append("}\r\n");
                }
            } else
            if(nul.jeNull(tc.getPredpona_pogoja()).equals("FORMAT")) {
                if(!nul.jeNull(tc.getFunkcija_formata1()).equals("") && !nul.jeNull(tc.getFunkcija_formata2()).equals(""))
                    sb.append(("r="+nul.jeNull(tc.getFunkcija_formata1())+"("+tc.getFunkcija_formata2().replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+"()+\"\""+replaceNeznanke2(replaceNeznanke1(nul.jeNull(tc.getFunkcija_formata3())).replaceAll("get", ("mod"+idfunkcije+class1+".get")))+");\r\n\r\n"));
                else
                if(nul.jeNull(tc.getUporabi_kot_neznanka()).equals("1"))
                    sb.append((""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+";\r\n\r\n"));
                else
                    sb.append(("r=\""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+"\";\r\n\r\n"));
            }
            else if(nul.jeNull(tc.getPredpona_pogoja()).equals("VARIABLE")) {
                   
                sb.append((""+nul.jeNull(tc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+";\r\n\r\n"));
                     }
        	if (!nul.jeN(tc.getRocna_vrednost()).equals("")) {
        		sb.append(tc.getRocna_vrednost()+";\r\n");
        	}
            
        } while(true);
        
        
        sb.append("%////>\r\n");
        
        
        
        
    	return sb.toString();
    	
    	
    	
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private String generirajFunkcijoLoop(ContextUtil contextUtil, ServletContext servletContext, String idnaprej, String nic, String idprej, String idfunk)
    {
        StringBuffer sb = new StringBuffer();
        try
        {
            TemplateClassClassDAO daol = (TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO", servletContext);
            sb.append("if (true) {\r\n");
            System.out.println("-------------------------------- 1");
            TemplateClassClass tcc = daol.getTemplateClassClass(new Long(idnaprej));
            String class1 = tcc.getClass_name();
            String classtip = "";
            String brisanje = "";
            if(tcc.getTip_funkcije() != null && !tcc.getTip_funkcije().equals(""))
                classtip = tcc.getTip_funkcije();
            if(tcc.getBrisi() != null)
                brisanje = tcc.getBrisi();
            System.out.println("-------------------------------- 12");
            if(!classtip.equals("UP"))
            {
                sb.append(("com.popultrade.dao."+class1+"DAO doa"+idnaprej+class1+" =(com.popultrade.dao."+class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0, 1).toLowerCase()+class1.substring(1)+"DAO\",pageContext.getServletContext());\r\n"));
                sb.append(("com.popultrade.model."+class1+" mod"+idnaprej+class1+" = new com.popultrade.model."+class1+"();\r\n"));
                
                //// naredim kopiranje celotne prehodne vrednosti v novo
                if (brisanje!=null && brisanje.equals("IN")) {
                	
                sb.append("mod"+idnaprej+class1+" = (com.popultrade.model."+class1+")contextUtil.cloneBean("+idprej+");\r\n");
               // sb.append(("com.popultrade.model."+class1+" clomod"+idnaprej+class1+" = new com.popultrade.model."+class1+"();\r\n"));
                      
                	
                	Hashtable[] hik =  getClassMetodeImenaHTGet(class1,"NOBENACLASA",true);  /// prvi
        			Hashtable htt =hik[0];
        	
        				Enumeration enn = htt.keys();
        		System.out.println("==========================================================================\r\n");
        		String celnull = "";
        		while (enn.hasMoreElements()) {
        		
        		String key = (String)enn.nextElement();
        		
        		//String kont = (String)htt.get(key);
        	//	System.out.println(vseb.get(key).toString().replace("_____", "clone1").replace("-----", "clone1") + "\r\n");
        		System.out.println(key + "=======================================================================\r\n");
        		
        		sb.append("mod"+idnaprej+class1+"."+(key.replaceFirst("get", "set"))+"(null);\r\n");
        		
        		}
        		
        		sb.append("mod"+idnaprej+class1+".setId(null);\r\n");
        		
        		
                	
                }
                
                
                
            }
            Iterator tre = tcc.getTemplateClasss().iterator();
            Hashtable meto = getClassMetodeImenaHT(contextUtil,  servletContext,tcc.getClass_name());
            System.out.println("-------------------------------- 13");
            do
            {
                if(!tre.hasNext()){
                    break;
            }
                TemplateClass tcci = (TemplateClass)tre.next();
                if(!nul.jeNull(tcci.getUporabi_kot_rezultat()).equals("1"))
                	
                	if (nul.jeNull(tcci.getRocna_vrednost_rabi()).equals("1")) { ///// rabim rocno setiranje pogoja
                		
                		sb.append(tcci.getRocna_vrednost());
                		
                		
                		  sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+"rezux"+");\r\n"));
                          
                	}
                
                	else    if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("[F") != -1)
                    {
                        TemplateUtils templateUtil = new TemplateUtils();
                        sb.append("if (true) {\r\n");
                        sb.append(templateUtil.generirajFunkcijo(contextUtil, servletContext, nul.jeNull(tcci.getVrednost_pogoja()).substring(tcci.getVrednost_pogoja().indexOf("[F") + 2, tcci.getVrednost_pogoja().indexOf("]"))));
                        String rett = "rezu";
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            rett = ("new Long("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                            rett = ("Integer.parseInt("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            rett = ("Double.parseDouble("+rett+")");
                        System.out.println("-------------------------------- 121");
                        sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        sb.append("rezu=\"\";\r\n");
                        sb.append("}\r\n");
                    } else
                    if(nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("session.getAttribute"))
                    {
                        String rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"+\"\"");
                        System.out.println("-------------------------------- 122");
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            rett = ("new Long("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                            rett = ("Integer.parseInt("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1){
                            rett = ("Double.parseDouble("+rett+")");
                    }
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                            if(nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")) {
                                sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                    }    else {
                                sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                        sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        System.out.println("-------------------------------- 123");
                    }
                        }
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                            sb.append(" }\r\n");
                        }
                    } else
                    {
                        String rett = "";
                        System.out.println("-------------------------------- 124");
                        if(nul.jeNull(tcci.getIzvor_vrednosti()).equals("V"))
                            rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", (""+idprej+".get")).replaceAll("'", "\"");
                        else
                            rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("'", "\"");
                        if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)
                            rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("'", "\"");
                        if((rett.indexOf("get") == -1 || rett.indexOf("request.getParameter") != -1 || rett.indexOf("session.getAttribute") != -1) && meto.containsKey(tcci.getIme_pogoja()))
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("String") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                                rett = ("new Long("+rett+")");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                if(rett.indexOf(",") != -1)
                                    rett = rett.replaceAll("\\,", "\\.");
                            }
                        System.out.println("-------------------------------- 137");
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                            if(nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")){
                                sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                    }  else {
                                sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                    }
                        }
                        sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                            sb.append(" }\r\n");
                        }
                    }
            } while(true);
            
            System.out.println("-------------------------------- 134");
            if(classtip.equals("IN") || classtip.equals("UP") || classtip.equals("UU"))
            {
                sb.append(("doa"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".save"+class1+"(mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+");\r\n"));
            }
            else
            if(classtip.equals("ER"))
            {
                String orderby = "";
                String orderbysmer = "";
                int max_st_iz = 10000;
                String dodatenhql = "";
                if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                    dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter");
                if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                    orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                    orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                    max_st_iz = tcc.getMax_st_izpisov().intValue();
                sb.append(("List remi"+idnaprej+class1+"=doa"+idnaprej+class1+".get"+class1+"s(mod"+idnaprej+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                sb.append(("if (remi"+idnaprej+class1+".size()>0) {\r\n"));
                sb.append(("mod"+idnaprej+class1+"=(com.popultrade.model."+class1+")remi"+idnaprej+class1+".get(0);\r\n"));
                sb.append("}\r\n");
            } else
            if(classtip.equals("LI"))
            {
                String orderby = "";
                String orderbysmer = "";
                int max_st_iz = 10000;
                String dodatenhql = "";
                if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                    dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter");
                if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                    orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                    orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                    max_st_iz = tcc.getMax_st_izpisov().intValue();
                sb.append(("List remi"+idnaprej+class1+"=doa"+idnaprej+class1+".get"+class1+"s(mod"+idnaprej+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                sb.append(("if (remi"+idnaprej+""+class1+".size()>0) {\r\n"));
                sb.append(("List lis"+idnaprej+class1+" =remi"+idnaprej+""+class1+";\r\n"));
                sb.append(("Iterator it"+idnaprej+class1+" = lis"+idnaprej+class1+".iterator();\r\n\r\n"));
                sb.append(("while (it"+idnaprej+class1+".hasNext()){  // while start\r\n"));
                sb.append(("  mod"+idnaprej+class1+" = (com.popultrade.model."+class1+")(it"+idnaprej+class1+".next());\r\n"));
            } else
            if(classtip.equals("SU"))
            {
                String orderby = "";
                String orderbysmer = "";
                int max_st_iz = 10000;
                String dodatenhql = "";
                if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                    dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter");
                if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                    orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                    orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                    max_st_iz = tcc.getMax_st_izpisov().intValue();
                sb.append(("List remi"+idnaprej+class1+"=doa"+idnaprej+class1+".get"+class1+"s(mod"+idnaprej+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                sb.append(("if (remi"+idnaprej+""+class1+".size()>0) {\r\n"));
                sb.append(("List lis"+idnaprej+class1+" =remi"+idnaprej+""+class1+";\r\n"));
                sb.append(("Iterator it"+idnaprej+class1+" = lis"+idnaprej+class1+".iterator();\r\n\r\n"));
                sb.append(("com.popultrade.model."+class1+" modx"+idnaprej+class1+"= new com.popultrade.model."+class1+"();\r\n"));
                sb.append(("while (it"+idnaprej+class1+".hasNext()){  // while start\r\n"));
                sb.append(("  modx"+idnaprej+class1+" = (com.popultrade.model."+class1+")(it"+idnaprej+class1+".next());\r\n"));
                if(tcc.getTemplateClassClass_vrednostis().size() > 0)
                {
                    for(Iterator itmo = tcc.getTemplateClassClass_vrednostis().iterator(); itmo.hasNext(); sb.append("}\r\n"))
                    {
                        TemplateClassClass_vrednosti tv = (TemplateClassClass_vrednosti)itmo.next();
                        sb.append(("if (modx"+idnaprej+class1+"."+tv.getVrednost()+"()!=null) {\r\n"));
                        sb.append(("if (mod"+idnaprej+class1+"."+tv.getVrednost()+"()==null) {\r\n"));
                        sb.append(("mod"+idnaprej+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(0);\r\n"));
                        sb.append("}\r\n");
                        sb.append(("mod"+idnaprej+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(mod"+idnaprej+class1+"."+tv.getVrednost()+"()+modx"+idnaprej+class1+"."+tv.getVrednost()+"());\r\n"));
                    }

                }
                sb.append("}\r\n");
                sb.append("}\r\n");
            } else
            if(classtip.equals("CO"))
            {
                String orderby = "";
                String orderbysmer = "";
                int max_st_iz = 10000;
                String dodatenhql = "";
                if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                    dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter");
                if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                    orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                    orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                    max_st_iz = tcc.getMax_st_izpisov().intValue();
                sb.append(("List remi"+idnaprej+class1+"=doa"+idnaprej+class1+".get"+class1+"s(mod"+idnaprej+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                sb.append(("if (remi"+idnaprej+""+class1+".size()>0) {\r\n"));
                sb.append(("List lis"+idnaprej+class1+" =remi"+idnaprej+""+class1+";\r\n"));
                sb.append(("Iterator it"+idnaprej+class1+" = lis"+idnaprej+class1+".iterator();\r\n\r\n"));
                sb.append(("com.popultrade.model."+class1+" modx"+idnaprej+class1+"= new com.popultrade.model."+class1+"();\r\n"));
                sb.append(("while (it"+idnaprej+class1+".hasNext()){  // while start\r\n"));
                sb.append(("  modx"+idnaprej+class1+" = (com.popultrade.model."+class1+")(it"+idnaprej+class1+".next());\r\n"));
                if(tcc.getTemplateClassClass_vrednostis().size() > 0)
                {
                    for(Iterator itmo = tcc.getTemplateClassClass_vrednostis().iterator(); itmo.hasNext(); sb.append("}\r\n"))
                    {
                        TemplateClassClass_vrednosti tv = (TemplateClassClass_vrednosti)itmo.next();
                        sb.append(("if (modx"+idnaprej+class1+"."+tv.getVrednost()+"()!=null) {\r\n"));
                        sb.append(("if (mod"+idnaprej+class1+"."+tv.getVrednost()+"()==null) {\r\n"));
                        sb.append(("mod"+idnaprej+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(0);\r\n"));
                        sb.append("}\r\n");
                        sb.append(("mod"+idnaprej+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(mod"+idnaprej+class1+"."+tv.getVrednost()+"()+1);\r\n"));
                    }

                }
                sb.append("}\r\n");
                sb.append("}\r\n");
            }
            System.out.println("-------------------------------- 14");
            if(brisanje.equals("BR"))
                sb.append(("doa"+idnaprej+class1+".remove"+class1+"(mod"+idnaprej+class1+".getId());\r\n"));
            if(brisanje.equals("UA"))
            {
                tre = tcc.getTemplateClasss().iterator();
                System.out.println("-------------------------------- 13");
                do
                {
                    if(!tre.hasNext())
                        break;
                    TemplateClass tcci = (TemplateClass)tre.next();
                    if(nul.jeNull(tcci.getUporabi_kot_rezultat()).equals("1"))
                    {
                        System.out.println("-------------------------------- 13");
                        System.out.println("-------------------------------- 13");
                        System.out.println("-------------------------------- 13");
                        System.out.println("-------------------------------- 13");
                        if(nul.jeNull(tcci.getUporabi_kot_rezultat()).equals("1"))
                        {
                            System.out.println("-------------------------------- 131");
                            System.out.println("-------------------------------- 131");
                            System.out.println("-------------------------------- 131");
                            System.out.println("-------------------------------- 131");
                            
                            if (nul.jeNull(tcci.getRocna_vrednost_rabi()).equals("1")) { ///// rabim rocno setiranje pogoja
                        		
                        		sb.append(tcci.getRocna_vrednost());
                        		
                        		
                        		  sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+"rezux"+");\r\n"));
                                  
                        	}
                        
                        	else  if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("[F") != -1)
                            {
                                TemplateUtils templateUtil = new TemplateUtils();
                                sb.append("if (true) {\r\n");
                                sb.append(templateUtil.generirajFunkcijo(contextUtil, servletContext, nul.jeNull(tcci.getVrednost_pogoja()).substring(tcci.getVrednost_pogoja().indexOf("[F") + 2, tcci.getVrednost_pogoja().indexOf("]"))));
                                String rett = "rezu";
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                                    rett = ("new Long("+rett+")");
                                else
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                                    rett = ("Integer.parseInt("+rett+")");
                                else
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                                    rett = ("Double.parseDouble("+rett+")");
                                System.out.println("-------------------------------- 121");
                                sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                                sb.append("rezu=\"\";\r\n");
                                sb.append("}\r\n");
                            } else
                            if(nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("session.getAttribute"))
                            {
                                String rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"+\"\"");
                                System.out.println("-------------------------------- 122");
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                                    rett = ("new Long("+rett+")");
                                else
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                                    rett = ("Integer.parseInt("+rett+")");
                                else
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                                    rett = ("Double.parseDouble("+rett+")");
                                if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                                    if(nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")){
                                        sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                            } else{
                                        sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                            }
                                }
                                sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                                System.out.println("-------------------------------- 123");
                                if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                                    sb.append(" }\r\n");}
                            } else
                            {
                                String rett = "";
                                System.out.println("-------------------------------- 124");
                                if(nul.jeNull(tcci.getIzvor_vrednosti()).equals("V"))
                                    rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", (""+idprej+".get")).replaceAll("'", "\"");
                                else
                                    rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("'", "\"");
                                if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)
                                    rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("'", "\"");
                                if((rett.indexOf("get") == -1 || rett.indexOf("request.getParameter") != -1 || rett.indexOf("session.getAttribute") != -1) && meto.containsKey(tcci.getIme_pogoja()))
                                    if(((String)meto.get(tcci.getIme_pogoja())).indexOf("String") != -1)
                                    {
                                        if(rett.indexOf("\"") == -1)
                                            rett = ("\""+rett+"\"");
                                    } else
                                    if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                                    {
                                        if(rett.indexOf("\"") == -1)
                                            rett = ("\""+rett+"\"");
                                        rett = ("new Long("+rett+")");
                                    } else
                                    if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1)
                                    {
                                        if(rett.indexOf("\"") != -1)
                                            rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                    } else
                                    if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                                    {
                                        if(rett.indexOf("\"") != -1)
                                            rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                        if(rett.indexOf(",") != -1)
                                            rett = rett.replaceAll("\\,", "\\.");
                                    }
                                System.out.println("-------------------------------- 137");
                                if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                                    if(nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")){
                                        sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                                } else{
                                        sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                                }
                                }
                                    sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                                if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                                    sb.append(" }\r\n");}
                            }
                        }
                    }
                } while(true);
                sb.append(("doa"+idnaprej+class1+".save"+class1+"(mod"+idnaprej+class1+");\r\n"));
            }
            if(!brisanje.equals("BR") && !brisanje.equals("UA"))
            {
                Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
                if(tcc.getTemplateClassClass_vrednostis().size() > 0)
                    do
                    {
                        if(!vredno.hasNext())
                            break;
                        TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                        if(tcv.getTemplateClasses().size() > 0)
                        {
                            Iterator item = tcv.getTemplateClasses().iterator();
                            while(item.hasNext()) 
                            {
                                TemplateClass txc = (TemplateClass)item.next();
                                if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                {
                                    sb.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get"))+" {\r\n"));
                                    if(txc.getTemplateClassClass() != null && txc.getTemplateClassClass().getClass_name() != null && !txc.getTemplateClassClass().getClass_name().equals(""))
                                    {
                                        TemplateUtils tu = new TemplateUtils();
                                        System.out.println("-++++++++++++++++++++++++++++++++++------------------------------- 1");
                                        sb.append(tu.generirajFunkcijoLoop(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej));
                                    } else
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1"))
                                        sb.append(("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n"));
                                    else
                                    if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                        if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))          //// logika po update
                                            sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get"))+";\r\n\r\n"));
                                        else
                                            sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get"))+";\r\n\r\n"));
                                    System.out.println("-------------------------------- 7");
                                    sb.append("}\r\n");
                                } else
                                {
                                    if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("session.get") == -1)
                                    {
                                        if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                        {
                                            if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                            {
                                                if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                                    sb.append(("rezu=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("nul.je", "nul.je").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+")+\"\";\r\n\r\n"));
                                            } else
                                            if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]") != -1)
                                            {
                                                String dodd = "";
                                                if(nul.jeNull(txc.getVrednost_pogoja()).length() > "[SIZE]".length())
                                                    dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]") + 1, nul.jeNull(txc.getVrednost_pogoja()).length());
                                                sb.append(("rezu=(remi"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".size() "+dodd+") + \"\";\r\n"));
                                            } else
                                            {
                                                sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                            }
                                        } else
                                        {
                                            sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                        }
                                    } else
                                    if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                    {
                                        if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                            sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n"));
                                        else
                                            sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                    } else
                                    {
                                        sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                    }
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1"))
                                        sb.append(("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n"));
                                    else
                                    if(nul.jeNull(txc.getVrednost_pogoja()).equals(""));
                                }
                            }
                        } else
                        {
                            System.out.println("-------------------------------- 72");
                            if(nul.jeNull(tcv.getRabi_kot()).equals("VR"))
                                sb.append(("rezu=mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n"));
                        }
                    } while(true);
            }
            sb.append("}\r\n");
            if(classtip.equals("LI"))
            {
                sb.append("}\r\n");
                sb.append("}\r\n");
            }
            System.out.println("-------------------------------- 73");
            return sb.toString();
        }
        catch(Exception en)
        {
            System.out.println(("Napaka loop gen funkcija: "+en.toString()));
        }
        return "";
    }

    public String generirajFunkcijo(ContextUtil contextUtil, ServletContext servletContext, String idfunkcije)
    {
    	
    	this.contextUtil2=contextUtil;
    	this.servletContext2 = servletContext;
        StringBuffer sb = new StringBuffer();
        try
        {
            TemplateFunkcijaStartDAO daol = (TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO", servletContext);
            TemplateFunkcijaStart tfs = daol.getTemplateFunkcijaStart(new Long(idfunkcije));
            if(tfs != null && tfs.getTemplateClassClass() != null && tfs.getTemplateClassClass().getClass_name() != null && !tfs.getTemplateClassClass().getClass_name().equals(""))
            {
                sb.append("if (true) {\r\n");
                if(nul.jeNull(tfs.getVrednosti_preko_checkbox()).equals("1") && !nul.jeNull(tfs.getStolpec_metoda_checkbox()).equals(""))
                {
                    sb.append("Enumeration en = request.getParameterNames();\r\n");
                    sb.append("while (en.hasMoreElements()) {\r\n");
                    sb.append("String vrednost_checkbox = (String)en.nextElement();\r\n");
                    sb.append(("if (vrednost_checkbox.startsWith(\""+nul.jeNull(tfs.getStolpec_metoda_checkbox()).toLowerCase().trim()+"____\")) {\r\n"));
                }
                TemplateClassClass tcc = tfs.getTemplateClassClass();
                String class1 = tcc.getClass_name();
                String classtip = "";
                String brisanje = "";
                if(tcc.getTip_funkcije() != null && !tcc.getTip_funkcije().equals(""))
                    classtip = tcc.getTip_funkcije();
                if(tcc.getBrisi() != null)
                    brisanje = tcc.getBrisi();
                sb.append(("com.popultrade.dao."+class1+"DAO doa"+idfunkcije+class1+" =(com.popultrade.dao."+class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0, 1).toLowerCase()+class1.substring(1)+"DAO\",pageContext.getServletContext());\r\n"));
                sb.append(("com.popultrade.model."+class1+" mod"+idfunkcije+class1+" = new com.popultrade.model."+class1+"();\r\n"));
                Iterator tre = tfs.getTemplateClassClass().getTemplateClasss().iterator();
                Hashtable meto = getClassMetodeImenaHT( contextUtil,  servletContext,tcc.getClass_name());
                do
                {
                    if(!tre.hasNext())
                        break;
                    TemplateClass tcci = (TemplateClass)tre.next();
                    if(!nul.jeNull(tcci.getUporabi_kot_rezultat()).equals("1"))
                    	if (nul.jeNull(tcci.getRocna_vrednost_rabi()).equals("1")) { ///// rabim rocno setiranje pogoja
                    		
                    		sb.append(tcci.getRocna_vrednost());
                    		
                    		
                    		  sb.append(("mod"+idfunkcije+class1+"."+tcci.getIme_pogoja()+"("+"rezux"+");\r\n"));
                                
                    	}
                    
                    	else 
                    	
                    	
                        if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("[F") != -1)
                        {
                            TemplateUtils templateUtil = new TemplateUtils();
                            sb.append("if (true) {\r\n");
                            sb.append(templateUtil.generirajFunkcijo(contextUtil, servletContext, tcci.getVrednost_pogoja().substring(tcci.getVrednost_pogoja().indexOf("[F") + 2, tcci.getVrednost_pogoja().indexOf("]"))));
                            String rett = "rezu";
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                                rett = ("new Long("+rett+")");
                            else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                                rett = ("Integer.parseInt("+rett+")");
                            else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                                rett = ("Double.parseDouble("+rett+")");
                            sb.append(("mod"+idfunkcije+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                            sb.append("rezu=\"\";\r\n");
                            sb.append("}\r\n");
                        } else
                        if(nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("session.getAttribute"))
                        {
                            String rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"+\"\"");
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                                rett = ("new Long("+rett+")");
                            else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                                rett = ("Integer.parseInt("+rett+")");
                            else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                                rett = ("Double.parseDouble("+rett+")");
                            if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                                sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                            }
                                sb.append(("mod"+idfunkcije+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                            if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                                sb.append(" }\r\n");}
                        } else
                        {
                            String rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("'", "\"");
                            if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)
                                rett = tcci.getVrednost_pogoja().replaceAll("'", "\"");
                            if((rett.indexOf("get") == -1 || rett.indexOf("request.getParameter") != -1 || rett.indexOf("session.getAttribute") != -1) && meto.containsKey(tcci.getIme_pogoja()))
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("String") != -1)
                                {
                                    if(rett.indexOf("\"") == -1)
                                        rett = ("\""+rett+"\"");
                                } else
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                                {
                                    if(rett.indexOf("\"") == -1)
                                        rett = ("\""+rett+"\"");
                                    rett = ("new Long("+rett+")");
                                } else
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1)
                                {
                                    if(rett.indexOf("\"") != -1)
                                        rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                } else
                                if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                                {
                                    if(rett.indexOf("\"") != -1)
                                        rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                    if(rett.indexOf(",") != -1)
                                        rett = rett.replaceAll("\\,", "\\.");
                                }
                            if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                                sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                            }
                                sb.append(("mod"+idfunkcije+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                            if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                                sb.append(" }\r\n");
                            }
                        }
                } while(true);
                if(classtip.equals("IN") || classtip.equals("UP") || classtip.equals("UU")) {
                    sb.append(("doa"+idfunkcije+class1+".save"+class1+"(mod"+idfunkcije+class1+");\r\n"));
                }
                else
                if(classtip.equals("ER"))
                {
                    String orderby = "";
                    String orderbysmer = "";
                    int max_st_iz = 10000;
                    String dodatenhql = "";
                    if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                        dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji());
                    if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                        orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                    if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                        orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                    if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                        max_st_iz = tcc.getMax_st_izpisov().intValue();
                    sb.append(("List remi"+idfunkcije+class1+"=doa"+idfunkcije+class1+".get"+class1+"s(mod"+idfunkcije+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                    sb.append(("if (remi"+idfunkcije+class1+".size()>0) {\r\n"));
                    sb.append(("mod"+idfunkcije+class1+"=(com.popultrade.model."+class1+")remi"+idfunkcije+class1+".get(0);\r\n"));
                    sb.append("}\r\n");
                } else
                if(classtip.equals("LI"))
                {
                    String orderby = "";
                    String orderbysmer = "";
                    int max_st_iz = 10000;
                    String dodatenhql = "";
                    if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                        dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji());
                    if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                        orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                    if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                        orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                    if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                        max_st_iz = tcc.getMax_st_izpisov().intValue();
                    sb.append(("List remi"+idfunkcije+class1+"=doa"+idfunkcije+class1+".get"+class1+"s(mod"+idfunkcije+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                    sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
                    sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
                    sb.append(("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
                    sb.append(("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
                    sb.append(("  mod"+idfunkcije+class1+" = (com.popultrade.model."+class1+")(it"+idfunkcije+class1+".next());\r\n"));
                } else
                if(classtip.equals("SU"))
                {
                    String orderby = "";
                    String orderbysmer = "";
                    int max_st_iz = 10000;
                    String dodatenhql = "";
                    if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                        dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji());
                    if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                        orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                    if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                        orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                    if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                        max_st_iz = tcc.getMax_st_izpisov().intValue();
                    sb.append(("List remi"+idfunkcije+class1+"=doa"+idfunkcije+class1+".get"+class1+"s(mod"+idfunkcije+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                    sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
                    sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
                    sb.append(("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
                    sb.append(("com.popultrade.model."+class1+" modx"+idfunkcije+class1+"= new com.popultrade.model."+class1+"();\r\n"));
                    sb.append(("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
                    sb.append(("  modx"+idfunkcije+class1+" = (com.popultrade.model."+class1+")(it"+idfunkcije+class1+".next());\r\n"));
                    if(tcc.getTemplateClassClass_vrednostis().size() > 0)
                    {
                        for(Iterator itmo = tcc.getTemplateClassClass_vrednostis().iterator(); itmo.hasNext(); sb.append("}\r\n"))
                        {
                            TemplateClassClass_vrednosti tv = (TemplateClassClass_vrednosti)itmo.next();
                            sb.append(("if (modx"+idfunkcije+class1+"."+tv.getVrednost()+"()!=null) {\r\n"));
                            sb.append(("if (mod"+idfunkcije+class1+"."+tv.getVrednost()+"()==null) {\r\n"));
                            sb.append(("mod"+idfunkcije+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(0);\r\n"));
                            sb.append("}\r\n");
                            sb.append(("mod"+idfunkcije+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(mod"+idfunkcije+class1+"."+tv.getVrednost()+"()+modx"+idfunkcije+class1+"."+tv.getVrednost()+"());\r\n"));
                        }

                    }
                    sb.append("}\r\n");
                    sb.append("}\r\n");
                } else
                if(classtip.equals("CO"))
                {
                    String orderby = "";
                    String orderbysmer = "";
                    int max_st_iz = 10000;
                    String dodatenhql = "";
                    if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals(""))
                        dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji());
                    if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                        orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                    if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                        orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                    if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                        max_st_iz = tcc.getMax_st_izpisov().intValue();
                    sb.append(("List remi"+idfunkcije+class1+"=doa"+idfunkcije+class1+".get"+class1+"s(mod"+idfunkcije+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                    sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
                    sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
                    sb.append(("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
                    sb.append(("com.popultrade.model."+class1+" modx"+idfunkcije+class1+"= new com.popultrade.model."+class1+"();\r\n"));
                    sb.append(("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
                    sb.append(("  modx"+idfunkcije+class1+" = (com.popultrade.model."+class1+")(it"+idfunkcije+class1+".next());\r\n"));
                    if(tcc.getTemplateClassClass_vrednostis().size() > 0)
                    {
                        for(Iterator itmo = tcc.getTemplateClassClass_vrednostis().iterator(); itmo.hasNext(); sb.append("}\r\n"))
                        {
                            TemplateClassClass_vrednosti tv = (TemplateClassClass_vrednosti)itmo.next();
                            sb.append(("if (modx"+idfunkcije+class1+"."+tv.getVrednost()+"()!=null) {\r\n"));
                            sb.append(("if (mod"+idfunkcije+class1+"."+tv.getVrednost()+"()==null) {\r\n"));
                            sb.append(("mod"+idfunkcije+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(0);\r\n"));
                            sb.append("}\r\n");
                            sb.append(("mod"+idfunkcije+class1+"."+tv.getVrednost().replaceAll("get", "set")+"(mod"+idfunkcije+class1+"."+tv.getVrednost()+"()+1);\r\n"));
                        }

                    }
                    sb.append("}\r\n");
                    sb.append("}\r\n");
                }
                if(brisanje.equals("BR"))
                    sb.append(("doa"+idfunkcije+class1+".remove"+class1+"(mod"+idfunkcije+class1+".getId());\r\n"));
                else
                if(!brisanje.equals("BR"))
                {
                    Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
                    if(tcc.getTemplateClassClass_vrednostis().size() > 0)
label0:
                        do
                        {
                            if(!vredno.hasNext())
                                break;
                            TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                            if(tcv.getTemplateClasses().size() > 0)
                            {
                                Iterator item = tcv.getTemplateClasses().iterator();
                                do
                                {
                                    if(!item.hasNext())
                                        continue label0;
                                    TemplateClass txc = (TemplateClass)item.next();
                                    if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                    {
                                        sb.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+" {\r\n"));
                                        if(txc.getTemplateClassClass() != null && txc.getTemplateClassClass().getClass_name() != null && !txc.getTemplateClassClass().getClass_name().equals(""))
                                        {
                                            sb.append(generirajFunkcijoLoop(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idfunkcije+class1), idfunkcije));
                                        } else
                                        {
                                            if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.getParameter") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("session.getAttribute") == -1)
                                            {
                                                if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                                {
                                                    if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                                    {
                                                        if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                                            sb.append(("rezu=("+txc.getVrednost_pogoja().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nul.je", "nul.je").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+")+\"\";\r\n\r\n"));
                                                    } else
                                                    if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]") != -1)
                                                    {
                                                        String dodd = "";
                                                        if(nul.jeNull(txc.getVrednost_pogoja()).length() > "[SIZE]".length())
                                                            dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]") + 1, nul.jeNull(txc.getVrednost_pogoja()).length());
                                                        sb.append(("rezu=(remi"+idfunkcije+class1+".size() "+dodd+") + \"\";\r\n"));
                                                    } else
                                                    {
                                                        sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                                    }
                                                } else
                                                {
                                                    sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                                }
                                            } else
                                            if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                            {
                                                if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                                    sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+"\";\r\n\r\n"));
                                                else
                                                    sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                            } else
                                            {
                                                sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                            }
                                            if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1"))
                                                sb.append(("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n"));
                                            else
                                            if(nul.jeNull(txc.getVrednost_pogoja()).equals(""));
                                        }
                                        sb.append("}\r\n");
                                    } else {
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
                                        sb.append(("odg_funkcija=nul.jeNull(ConPool.getPrevod(\""+txc.getId()+"P\"+control.getJezik()));\r\n"));
                                    }
                                        else {
                                    if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
                                        if(nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1")) {
                                            sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+";\r\n\r\n"));
                                        }else{
                                        	
                                        	if (!nul.jeN(txc.getRocna_vrednost()).equals("")) {
                                        		sb.append(txc.getRocna_vrednost()+";\r\n");
                                        	}
                                            sb.append(("rezu="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+";\r\n\r\n"));
                                       
                                        
                                        }
                                    }
                                        }
                                    }
                                        } while(true);
                            }
                            if(nul.jeNull(tcv.getRabi_kot()).equals("VR"))
                                sb.append(("rezu=mod"+idfunkcije+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n"));
                        } while(true);
                }
                sb.append("}\r\n");
                if(classtip.equals("LI"))
                {
                    sb.append("}\r\n");
                    sb.append("}\r\n");
                }
                if(nul.jeNull(tfs.getVrednosti_preko_checkbox()).equals("1") && !nul.jeNull(tfs.getStolpec_metoda_checkbox()).equals(""))
                {
                    sb.append("}\r\n");
                    sb.append("}\r\n");
                }
            }
            return sb.toString();
        }
        catch(Exception ex)
        {
            System.out.println(("Napaka pri generaciji funkcije: "+ex.toString()));
        }
        return "";
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
/// dobim annotations za nosql, ce gre za @Embeddable 
    public boolean isEmbeddable(String ime_classe)
      {
     String vsek = "";
          try
          {
              Class testClass = Class.forName((new StringBuilder()).append(packageName_fixno).append(".").append(ime_classe).toString());
              Method methods[] = testClass.getDeclaredMethods();
          
              java.lang.annotation.Annotation[] anoc = testClass.getAnnotations();
             if (anoc!=null) {
              for (int k=0;k<anoc.length;k++) {
                  String one = anoc[k].toString();
           //   System.out.println("--------------------------------------------- ::::::: "+one);
                  
                  if (one.indexOf("Embeddable")!=-1) {
                	  return true;
                  }
                  
                  
              }
             }
         
         

          }
          catch(ClassNotFoundException ex)
          {
              System.out.println((new StringBuilder()).append("Napaka pri pridobivanju imena clase! ").append(ex.toString()).toString());
          }
          
        
          return false;
      }
    
    
    
    
    public List getClasseNamesInPackageEmbeddable(ContextUtil contextUtil, ServletContext servletContext,String jarName, String packageName)
    {
        jarName = lokacija_jar;
        packageName = packageName_fixno;
        ArrayList classes = new ArrayList();
        packageName = packageName.replaceAll("\\.", "/");
        try
        {
            JarInputStream jarFile = new JarInputStream(new FileInputStream(jarName));
            do
            {
                JarEntry jarEntry = jarFile.getNextJarEntry();
                if(jarEntry == null) {
                    break;
                }
                if(jarEntry.getName().startsWith(packageName) && jarEntry.getName().endsWith(".class")) {
                	
                	
                	
                	
                	if (isEmbeddable(jarEntry.getName().replaceAll("/", "\\.").replaceAll((packageName_fixno+"."), "").replaceAll(".class", ""))) {
                    classes.add(jarEntry.getName().replaceAll("/", "\\.").replaceAll((packageName_fixno+"."), "").replaceAll(".class", ""));
                	}
                }
            } while(true);
            
            
            
            /// dobim custom class
            TemplateCustomClassDAO daol = (TemplateCustomClassDAO)contextUtil.getBeanDao("templateCustomClassDAO", servletContext);
            List tcc = daol.getTemplateCustomClasss(new TemplateCustomClass(),"class_name","desc" );
            
            Iterator iter = tcc.iterator();
            
            while (iter.hasNext()) {
            	
            	TemplateCustomClass kol = (TemplateCustomClass)iter.next();
            	
            	classes.add(kol.getClass_name()+" (custom)");
            	
            	
            }
            
            
            
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return sortedListValues(classes);
    }
    
    
    
    
    public List getClasseNamesInPackageNoEmbeddable(ContextUtil contextUtil, ServletContext servletContext,String jarName, String packageName)
    {
        jarName = lokacija_jar;
        packageName = packageName_fixno;
        ArrayList classes = new ArrayList();
        packageName = packageName.replaceAll("\\.", "/");
        try
        {
            JarInputStream jarFile = new JarInputStream(new FileInputStream(jarName));
            do
            {
                JarEntry jarEntry = jarFile.getNextJarEntry();
                if(jarEntry == null) {
                    break;
                }
                if(jarEntry.getName().startsWith(packageName) && jarEntry.getName().endsWith(".class")) {
                	
                	
                	
                	
                	if (!isEmbeddable(jarEntry.getName().replaceAll("/", "\\.").replaceAll((packageName_fixno+"."), "").replaceAll(".class", ""))) {
                    classes.add(jarEntry.getName().replaceAll("/", "\\.").replaceAll((packageName_fixno+"."), "").replaceAll(".class", ""));
                	}
                }
            } while(true);
            
            
            
            /// dobim custom class
            TemplateCustomClassDAO daol = (TemplateCustomClassDAO)contextUtil.getBeanDao("templateCustomClassDAO", servletContext);
            List tcc = daol.getTemplateCustomClasss(new TemplateCustomClass(),"class_name","desc" );
            
            Iterator iter = tcc.iterator();
            
            while (iter.hasNext()) {
            	
            	TemplateCustomClass kol = (TemplateCustomClass)iter.next();
            	
            	classes.add(kol.getClass_name()+" (custom)");
            	
            	
            }
            
            
            
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return sortedListValues(classes);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    public List getClasseNamesInPackage(ContextUtil contextUtil, ServletContext servletContext,String jarName, String packageName)
    {
        jarName = lokacija_jar;
        packageName = packageName_fixno;
        ArrayList classes = new ArrayList();
        packageName = packageName.replaceAll("\\.", "/");
        try
        {
            JarInputStream jarFile = new JarInputStream(new FileInputStream(jarName));
            do
            {
                JarEntry jarEntry = jarFile.getNextJarEntry();
                if(jarEntry == null) {
                    break;
                }
                if(jarEntry.getName().startsWith(packageName) && jarEntry.getName().endsWith(".class")) {
                	
                	
                	isEmbeddable(jarEntry.getName().replaceAll("/", "\\.").replaceAll((packageName_fixno+"."), "").replaceAll(".class", ""));
                	
                	
                    classes.add(jarEntry.getName().replaceAll("/", "\\.").replaceAll((packageName_fixno+"."), "").replaceAll(".class", ""));
                }
            } while(true);
            
            
            
            /// dobim custom class
            TemplateCustomClassDAO daol = (TemplateCustomClassDAO)contextUtil.getBeanDao("templateCustomClassDAO", servletContext);
            List tcc = daol.getTemplateCustomClasss(new TemplateCustomClass(),"class_name","desc" );
            
            Iterator iter = tcc.iterator();
            
            while (iter.hasNext()) {
            	
            	TemplateCustomClass kol = (TemplateCustomClass)iter.next();
            	
            	classes.add(kol.getClass_name()+" (custom)");
            	
            	
            }
            
            
            
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return sortedListValues(classes);
    }

    public List getClassMetodeImena(ContextUtil contextUtil, ServletContext servletContext,String ime_classe)
    {
        ArrayList imena = new ArrayList();
        try
        {
        	
        	if (ime_classe.indexOf("(custom)")==-1) {
        	
          /*  Class testClass = Class.forName(ime_classe);
            Method methods[] = testClass.getDeclaredMethods();
            Method arr$[] = methods;
            int len$ = arr$.length;
            for(int i$ = 0; i$ < len$; i$++)
            {
                Method method = arr$[i$];
                if(method.getName() != null && method.getName().startsWith("get"))
                    imena.add((method.getName()+" ----XXX---- "+method.getReturnType()));
            }*/
            //// zadnji parameter definira globino vezave na druge tabele oz. zacetek globine do 3 vezave globoko
        		return this.getClassMetodeImenaSPodclasami( contextUtil,servletContext, ime_classe,"get",0);
            
            
            
        	}
        	else if (contextUtil!=null) {
        		
        		
        		/// dobim iz custom tabele
        		
        		String izct = ime_classe.substring(ime_classe.lastIndexOf(".")+1,ime_classe.indexOf("(custom)")-1);
        		System.out.println("Custom clasa : "+izct);
        		
        		 TemplateCustomClassDAO daol = (TemplateCustomClassDAO)contextUtil.getBeanDao("templateCustomClassDAO", servletContext);
        		 TemplateCustomClass tcc = daol.getTemplateCustomClass(izct );
                 
        		String vsee = tcc.getClassv();
        		
        		
        		String[] spli = vsee.split("\n");
        		
        		for (int i=0;i<spli.length;i++) {
        			
        			if (spli[i].startsWith("public") && spli[i].indexOf(" get")!=-1) {
        				
        				String rezanget = spli[i].substring(spli[i].indexOf("get"),spli[i].indexOf("("));
        				String rezantip = spli[i].substring(spli[i].indexOf(" ")+1,spli[i].indexOf(" get"));
        				
        				imena.add((rezanget+" ----XXX---- "+rezantip));
        				
        			}
        			
        		}
        		
        		 
        		 
        		
        		
        	}
            
            
            

        }
        catch(Exception ex)
        {
            System.out.println(("Napaka pri pridobivanju imena clase! "+ex.toString()));
        }
        return sortedListValues(imena);
    }

    public Hashtable getClassMetodeImenaHT(ContextUtil contextUtil, ServletContext servletContext,String ime_classe)
    {
        Hashtable metode = new Hashtable();
        try
        {
        	
        	if (ime_classe.indexOf("(custom)")==-1) {
        		
            Class testClass = Class.forName((packageName_fixno+"."+ime_classe));
            Method methods[] = testClass.getDeclaredMethods();
            Method arr$[] = methods;
            int len$ = arr$.length;
            for(int i$ = 0; i$ < len$; i$++)
            {
                Method method = arr$[i$];
                if(method.getName() != null && method.getName().startsWith("get"))
                    metode.put(method.getName().replaceAll("get", "set"), (method.getReturnType()+""));
            }
            
            
            
        }
        	else if (contextUtil!=null) {
    		
    		
    		/// dobim iz custom tabele
    		
    		String izct = ime_classe.substring(ime_classe.lastIndexOf(".")+1,ime_classe.indexOf("(custom)")-1);
    		System.out.println("Custom clasa : "+izct);
    		
    		 TemplateCustomClassDAO daol = (TemplateCustomClassDAO)contextUtil.getBeanDao("templateCustomClassDAO", servletContext);
    		 TemplateCustomClass tcc = daol.getTemplateCustomClass(izct );
             
    		String vsee = tcc.getClassv();
    		
    		
    		String[] spli = vsee.split("\n");
    		
    		for (int i=0;i<spli.length;i++) {
    			
    			if (spli[i].startsWith("public") && spli[i].indexOf(" set")!=-1) {
    				
    				String rezanget = spli[i].substring(spli[i].indexOf("set"),spli[i].indexOf("("));
    				String rezantip = spli[i].substring(spli[i].indexOf(" ")+1,spli[i].indexOf(" set"));
    				
    			//	imena.add((rezanget+" ----XXX---- "+rezantip));
    				
    				if (!rezantip.equals("Date")) {
    				metode.put(rezanget, "class java.lang."+rezantip);
    				}
    				else {
    					metode.put(rezanget, "class java.util."+rezantip);
    				}
    				
    				
    				
    			}
    			
    		}
    		
    		 
    		 
    		
    		
    	}
            
            
            
            

        }
        catch(ClassNotFoundException ex)
        {
            System.out.println(("Napaka pri pridobivanju imena clase! "+ex.toString()));
        }
        return sortedMapValues(metode);
    }

    public List sortedListValues(List soro)
    {
        Collections.sort(soro);
        return soro;
    }

    public Hashtable sortedMapValues(Hashtable map)
    {
        if(map != null && map.size() > 0)
        {
            Enumeration en = map.keys();
            List sorto = new ArrayList();
            for(; en.hasMoreElements(); sorto.add((String)en.nextElement()));
            Collections.sort(sorto);
            Hashtable rett = new Hashtable();
            String nexx;
            for(Iterator it = sorto.iterator(); it.hasNext(); rett.put(nexx, map.get(nexx)))
                nexx = (String)it.next();

            return rett;
        } else
        {
            return null;
        }
    }

    public List getClassMetodeImenaSPodclasami(ContextUtil contextUtil, ServletContext servletContext,String ime_classe, String getset,int zapo)
    {
        ArrayList imena = new ArrayList();
        try
        {
        	int zzapo = zapo+1;
        	if (ime_classe.indexOf("(custom)")==-1) {
            Class testClass = Class.forName(ime_classe);
            Method methods[] = testClass.getDeclaredMethods();
            Method arr$[] = methods;
            int len$ = arr$.length;
            for(int i$ = 0; i$ < len$; i$++)
            {
                Method method = arr$[i$];
                if(method.getName() != null && method.getName().startsWith(getset))
                    if(zzapo<3 &&  method.getReturnType().toString().indexOf("[B") == -1 && method.getReturnType().toString().indexOf("String") == -1 && method.getReturnType().toString().indexOf("Integer") == -1 && method.getReturnType().toString().indexOf("Long") == -1 && method.getReturnType().toString().indexOf("Double") == -1 && method.getReturnType().toString().indexOf("Date") == -1 && method.getReturnType().toString().indexOf("List") == -1 && method.getReturnType().toString().indexOf("int") == -1)
                    {
                        TemplateUtils tu = new TemplateUtils();
                        List li = new ArrayList();
                        System.out.println(("++++++++++++++++++++++++++++++++xx++++++++++++++ "+method.getReturnType().toString().trim()));
                        String reko = method.getReturnType().toString();
                        if(reko.indexOf(".") != -1)
                            reko = reko.substring(reko.lastIndexOf(".") + 1, reko.length());
                        li = tu.getClassMetodeImenaSPodclasami(contextUtil,servletContext,(packageName_fixno+"."+reko.trim()), getset,zzapo);
                        String key;
                        for(Iterator enn = li.iterator(); enn.hasNext(); imena.add((method.getName()+"()."+key)))
                            key = (String)enn.next();

                    } else
                    {
                        imena.add((method.getName()+" ----XXX---- "+(method.getReturnType())));
                    }
            }
            
            
            
     	}
    	else if (contextUtil!=null) {
    		
    		
    		/// dobim iz custom tabele
    		
    		String izct = ime_classe.substring(ime_classe.lastIndexOf(".")+1,ime_classe.indexOf("(custom)")-1);
    		System.out.println("Custom clasa : "+izct);
    		
    		 TemplateCustomClassDAO daol = (TemplateCustomClassDAO)contextUtil.getBeanDao("templateCustomClassDAO", servletContext);
    		 TemplateCustomClass tcc = daol.getTemplateCustomClass(izct );
             
    		String vsee = tcc.getClassv();
    		
    		
    		String[] spli = vsee.split("\n");
    		
    		for (int i=0;i<spli.length;i++) {
    			
    			if (spli[i].startsWith("public") && spli[i].indexOf(" "+getset)!=-1) {
    				
    				String rezanget = spli[i].substring(spli[i].indexOf(""+getset),spli[i].indexOf("("));
    				String rezantip = spli[i].substring(spli[i].indexOf(" ")+1,spli[i].indexOf(" "+getset));
    				
    				imena.add((rezanget+" ----XXX---- "+rezantip));
    				
    			}
    			
    		}
    		
    		 
    		 
    		
    		
    	}
            
            
            
            
            
            

        }
        catch(ClassNotFoundException ex)
        {
            System.out.println(("Napaka pri pridobivanju imena clase! "+ex.toString()));
        }
        return sortedListValues(imena);
    }

    public Hashtable getClassMetodeImenaHTZPodclassami(String ime_classe, String getset,boolean krajse)
    {
    	
    
    		return getClassMetodeImenaHTZPodclassami2( ime_classe,  getset,true);
    	
    	
    }
    
    public Hashtable getClassMetodeImenaHTZPodclassami(String ime_classe, String getset)
    {
    	
    	return getClassMetodeImenaHTZPodclassami2( ime_classe,  getset,false);
    }
    
    
    
    public Hashtable getClassMetodeImenaHTZPodclassami2(String ime_classe, String getset,boolean krajse)
    {
        Hashtable metode = new Hashtable();
        try
        {
        	
        	Class testClass=null;//Class.forName(ime_classe);
        	
            /*  Class testClass = Class.forName(ime_classe);
            Method methods[] = testClass.getDeclaredMethods();
            Method arr$[] = methods;
            int len$ = arr$.length;
            for(int i$ = 0; i$ < len$; i$++)
            {
                Method method = arr$[i$];
                if(method.getName() != null && method.getName().startsWith("get"))
                    imena.add((method.getName()+" ----XXX---- "+method.getReturnType()));
            }*/
        	
        	System.out.println("XXXXXXXXXXXXX 1 "+ime_classe);
        	if (krajse) {
        	testClass = Class.forName(packageName_fixno+"."+ime_classe);
        	}
        	
        	
        	else {
             testClass = Class.forName(packageName_fixno+"."+ime_classe);
        	}
            
            
            Method methods[] = testClass.getDeclaredMethods();
            Method arr$[] = methods;
           // int len$ = arr$.length;
            System.out.println("XXXXXXXXXXXXX 1");
            int len$ = arr$.length;
            for(int i$ = 0; i$ < len$; i$++)
            {
            	System.out.println("XXXXXXXXXXXXX2");
                Method method = arr$[i$];
                if(method.getName() != null && method.getName().startsWith(getset))
                    if(method.getReturnType().toString().indexOf("[B")==-1 && !method.getReturnType().toString().endsWith("String") && !method.getReturnType().toString().endsWith("Integer") && !method.getReturnType().toString().endsWith("Long") && !method.getReturnType().toString().endsWith("Double") && !method.getReturnType().toString().endsWith("Date") && !method.getReturnType().toString().endsWith("List") && !method.getReturnType().toString().endsWith("int"))
                    {
                    	System.out.println("XXXXXXXXXXXXX 3 "+method.getReturnType());
                        TemplateUtils tu = new TemplateUtils();
                        Hashtable neww = new Hashtable();
                        neww = tu.getClassMetodeImenaHTZPodclassami(method.getName().replaceAll(getset, ""), getset);
                        String key;
                        
                        Enumeration enn = neww.keys();
                        
                        while (enn.hasMoreElements()) {
                        	key = (String)enn.nextElement();
                        	
                        	
                        	
                        	System.out.println("XXXXXXXXXXXXX 4 "+key);
                        	//// se enkrat
                        	
                                  if( method.getReturnType().toString().indexOf("[B")==-1 && !neww.get(key).toString().endsWith("String") && !neww.get(key).toString().endsWith("Integer") && !neww.get(key).toString().endsWith("Long") && !neww.get(key).toString().endsWith("Double") && !neww.get(key).toString().endsWith("Date") && !neww.get(key).toString().endsWith("List") && !neww.get(key).toString().endsWith("int"))
                                  {
                                	  TemplateUtils tu2 = new TemplateUtils();
                                      Hashtable neww2 = new Hashtable();
                                      neww2 = tu2.getClassMetodeImenaHTZPodclassami(key.replaceAll(getset, ""), getset);
                                      String key2;
                                	  
                                      Enumeration enn2 = neww2.keys();
                                      
                                      while (enn2.hasMoreElements()) {
                                      	key2 = (String)enn2.nextElement();
                                      	 metode.put(method.getName()+"."+key+"."+key2, neww2.get(key2));
                                      }
                                      
                                  }
                                  else {
                                	  
                                	  metode.put(method.getName()+"."+key, neww.get(key));
                                  }
                        	  
                        	
                        	
                        	
                        }
                      //  System.out.println("XXXXXXXXXXXXX 5");
                       /* for(Enumeration enn = neww.keys(); enn.hasMoreElements(); metode.put((method.getName()+"."+key), neww.get(key))) {
                            key = (String)enn.nextElement();
                        }*/

                    } else
                    {
                    //	System.out.println("XXXXXXXXXXXXX 6");
                        metode.put(method.getName(), (method.getReturnType()+""));
                    }
            }

        }
        catch(ClassNotFoundException ex)
        {
            System.out.println(("Napaka pri pridobivanju imena clase! getClassMetodeImenaHTZPodclassami "+ex.toString()));
        }
        return sortedMapValues(metode);
    }

    public Hashtable getClassMetodeImenaHTGet(String ime_classe)
    {
        Hashtable metode = new Hashtable();
        try
        {
        	
        	/*
            Class testClass = Class.forName((packageName_fixno+"."+ime_classe));
            Method methods[] = testClass.getDeclaredMethods();
            Method arr$[] = methods;
            int len$ = arr$.length;
            for(int i$ = 0; i$ < len$; i$++)
            {
                Method method = arr$[i$];
                if(method.getName() != null && method.getName().startsWith("get"))
                    metode.put(method.getName(), (method.getReturnType()+""));
            }
            */
            
        metode=	getClassMetodeImenaHTZPodclassami(ime_classe,"get",true);
            

        }
        catch(Exception ex)
        {
            System.out.println(("Napaka pri pridobivanju imena clase! "+ex.toString()));
        }
        return sortedMapValues(metode);
    }

    public Hashtable getFunkcijeZaFormat()
    {
        Hashtable imena = new Hashtable();
        imena.put("nul.cutString", "cutString(String vrednost,int size) odreze parameter vrednost na vneseni size");
        imena.put("nul.addNule", "addNule(String vrednost,int stnul) dodam nicle pred vrednost,stnul - max skupno st. znakov");
        imena.put("nul.sestejDoubleVrednosti", "sestejDoubleVrednosti(String id,Double[] vrednosti,String format_rezultata) sesteje vec double vrednosti skupaj in vrne rezultat na podlagi formata");
        imena.put("nul.sestejDoubleVrednosti", "sestejDoubleVrednosti(String id,Double[] vrednosti,String format_rezultata) sesteje vec double vrednosti skupaj in vrne rezultat na podlagi formata");
        imena.put("nul.sestejIntegerVrednosti", "sestejIntegerVrednosti(String id,Integer[] vrednosti) sesteje vec integer vrednosti skupaj in vrne rezultat");
        return imena;
    }

    public List getKonstantePriLogu()
    {
        ArrayList imena = new ArrayList();
        imena.add("control.idUporabnika");
        imena.add("control.getPodjetje()");
        imena.add("control.getSzsifra()");
        imena.add("nul.getDatumFormat('yyyy')");
        imena.add("control.getJezik()");
        imena.add("control.getUserName()");
        imena.add("control.getPravica_status_dispozicije()");
        imena.add("new Date()");
        imena.add("nul.addDaysToDate(Date dt,int stdni)");
        imena.add("control.getUporablja_pozicijsko_mapo()");
        imena.add("control.getPrivilegij_podjetje()");
        imena.add("control.getUser_alias()");
        
        return imena;
    }

    
/*
    public String[] generirajFunkcijo_PDF(ContextUtil contextUtil, ServletContext servletContext, String idfunkcije, control comm, int zapom)
    {
    	
    	this.contextUtil2=contextUtil;
    	this.servletContext2 = servletContext;
        cont = comm;
        String rettu[] = new String[5];
        StringBuffer sb = new StringBuffer();
        StringBuffer sbfo = new StringBuffer();
        StringBuffer sbfo_template = new StringBuffer();
        try
        {
            ht_loop.clear();
            ht_loop_a.clear();
            this.ht_loop_b.clear();
            ht_loop_id.clear();
            ht_loopfo.clear();
            ht_loopfo_id.clear();
            ht_loop_idv.clear();
            zapi = 0;
            TemplateFunkcijaStartDAO daol = (TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO", servletContext);
            TemplateFunkcijaStart tfs = daol.getTemplateFunkcijaStart(new Long(idfunkcije));
            if(tfs != null && tfs.getTemplateClassClass() != null && tfs.getTemplateClassClass().getClass_name() != null && !tfs.getTemplateClassClass().getClass_name().equals(""))
            {
                sb.append("if (true) {\r\n");
                TemplateClassClass tcc = tfs.getTemplateClassClass();
                String class1 = tcc.getClass_name();
                rettu[1] = class1;
                String classtip = "";
                if(tcc.getTip_funkcije() != null && !tcc.getTip_funkcije().equals("")){
                    classtip = tcc.getTip_funkcije();
            }
                sb.append(("com.popultrade.dao."+class1+"DAO doa"+tcc.getId()+class1+" =(com.popultrade.dao."+class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0, 1).toLowerCase()+class1.substring(1)+"DAO\",pageContext.getServletContext());\r\n"));
                sb.append(("com.popultrade.model."+class1+" mod"+tcc.getId()+class1+" = new com.popultrade.model."+class1+"();\r\n"));
                Iterator tre = tfs.getTemplateClassClass().getTemplateClasss().iterator();
                Hashtable meto = getClassMetodeImenaHT(contextUtil,  servletContext,tcc.getClass_name());
                do
                { /// definira funkcijo s parametri
                    if(!tre.hasNext())
                        break;
                    TemplateClass tcci = (TemplateClass)tre.next();
                    if(nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("session.getAttribute"))
                    {
                        String rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"+\"\"");
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            rett = ("new Long("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                            rett = ("Integer.parseInt("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            rett = ("Double.parseDouble("+rett+")");
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) 
                            sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Date") != -1 && (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1))
                            rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"");
                        sb.append(("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                        	
                            sb.append(" }\r\n");
                    }
                    } else
                    	
                    {
                        String rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", (""+tcc.getId()+".get")).replaceAll("'", "\"");
                        if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)
                            rett = tcci.getVrednost_pogoja().replaceAll("'", "\"");
                        if((rett.indexOf("get") == -1 || rett.indexOf("request.getParameter") != -1 || rett.indexOf("session.getAttribute") != -1) && meto.containsKey(tcci.getIme_pogoja()))
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("String") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                                rett = ("new Long("+rett+")");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                if(rett.indexOf(",") != -1)
                                    rett = rett.replaceAll("\\,", "\\.");
                            }
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals(""))
                            sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Date") != -1 && (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1))
                            rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"");
                        sb.append(("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals(""))
                            sb.append(" }\r\n");
                    }
                } while(true);
                
                
                
                
                if(classtip.equals("ER") || classtip.equals("LI") || classtip.equals("CO"))
                {
                    String orderby = "";
                    String orderbysmer = "";
                    int max_st_iz = 10000;
                    String dodatenhql = "";
                    if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals("")){
                        dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji());
                    }
                    if(!nul.jeNull(tcc.getOrder_by_smer()).equals("")){
                        orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                }
                    if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals("")){
                        orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                }
                    if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0){
                        max_st_iz = tcc.getMax_st_izpisov().intValue();
                }
                    sb.append(("List remi"+tcc.getId()+class1+"=doa"+tcc.getId()+class1+".get"+class1+"s(mod"+tcc.getId()+class1+",1,"+max_st_iz+",\""+dodatenhql+"\",\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                    
                    
                    if(classtip.equals("ER") || classtip.equals("LI"))
                    {
                        if(tfs.getTemplateviews() != null && tfs.getTemplateviews().size() > 0)
                        {
                            sb.append(genViews_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, false, contextUtil, servletContext, classtip));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genViews_PDF_fo((tfs.getTemplateClassClass().getId()+""), "1", tp);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                        } else
                        if(tfs.getTemplatelists() != null && tfs.getTemplatelists().size() > 0)
                        {
                            sb.append(genList_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, false, classtip));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genList_PDF_fo(tfs, (tfs.getTemplateClassClass().getId()+""), class1, tp);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                        }
                    } else
                    if(classtip.equals("CO")){
                        if(tfs.getTemplateviews() != null && tfs.getTemplateviews().size() > 0)
                        {
                            sb.append(genViews_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, true, contextUtil, servletContext, classtip));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genViews_PDF_fo((tfs.getTemplateClassClass().getId()+""), "1", tp);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                        } else
                        if(tfs.getTemplatelists() != null && tfs.getTemplatelists().size() > 0)
                        {
                            sb.append(genList_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, true, classtip));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genList_PDF_fo(tfs, (tfs.getTemplateClassClass().getId()+""), class1, tp);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                        }
                }
                    if(tfs.getTemplatelists().size() == 0 && tfs.getTemplateviews().size() == 0){
                    	sb.append(("r=\"\";\r\n"));
                }
                        sb.append(("//////DOME"+tcc.getId()+"//////\r\n"));
                    Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
                    if(tcc.getTemplateClassClass_vrednostis().size() > 0){
                        while(vredno.hasNext()) 
                        {
                            TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                            StringBuffer ht_loop_b = new StringBuffer();
                            if(tcv.getTemplateClasses().size() > 0)
                            {
                                Iterator item = tcv.getTemplateClasses().iterator();
                                String solom = "";
                                do
                                {
                                    if(!item.hasNext()){
                                        break;
                                }
                                    TemplateClass txc = (TemplateClass)item.next();
                                    if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                    {
                                        if(txc.getTemplateClassClass() == null || txc.getTemplateClassClass().getClass_name() == null || txc.getTemplateClassClass().getClass_name().equals(""))
                                        {
                                            ht_loop_b.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+" {\r\n"));
                                            if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.getParameter") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("session.getAttribute") == -1)
                                            {
                                                if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                                {
                                                    if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                                    {
                                                        if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                                            ht_loop_b.append(("r=("+txc.getVrednost_pogoja().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nul.je", "nul.je").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+")+\"\";\r\n\r\n"));
                                                    } else
                                                    if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]") != -1)
                                                    {
                                                        String dodd = "";
                                                        if(nul.jeNull(txc.getVrednost_pogoja()).length() > "[SIZE]".length())
                                                            dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]") + 1, nul.jeNull(txc.getVrednost_pogoja()).length());
                                                        ht_loop_b.append(("r=(remi"+idfunkcije+class1+".size() "+dodd+") + \"\";\r\n"));
                                                    } else
                                                    {
                                                        ht_loop_b.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                                    }
                                                } else
                                                {
                                                    ht_loop_b.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                                    System.out.println("===================================================================  XXcccccccXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                
                                                }
                                            } else
                                            if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                            {
                                                if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                                    ht_loop_b.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n"));
                                                else
                                                    ht_loop_b.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                            } else
                                            {
                                                ht_loop_b.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            }
                                            if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1"))
                                                ht_loop_b.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                            else
                                            if(nul.jeNull(txc.getVrednost_pogoja()).equals(""));
                                            ht_loop_b.append("}\r\n");
                                        }
                                    } else {
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
                                        ht_loop_b.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                    }else {
                                    if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
                                        if(nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1")) {
                                            ht_loop_b.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+";\r\n\r\n"));
                                        
                                            System.out.println("===========sssssss========================================================  XXXX");
                                            System.out.println("============sssssssssss=======================================================  XXXX");
                                            System.out.println("=============sssssssss======================================================  XXXX");
                                            System.out.println("=============sssssssssss======================================================  XXXX");
                                            System.out.println("=============ssssssssss======================================================  XXXX");
                                            System.out.println("=============ssssssssssss======================================================  XXXX");
                                            System.out.println("=============ssssssssssss======================================================  XXXX ");
                                        
                                        }else{
                                            ht_loop_b.append(("r=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idfunkcije+class1+".get"))+"\";\r\n\r\n"));
                                        
                                        	if (!nul.jeN(txc.getRocna_vrednost()).equals("")) {
                                        		ht_loop_b.append(txc.getRocna_vrednost()+";\r\n");
                                        	}
                                        
                                        
                                        }
                                    }
                                    }
                                    }
                                        } while(true);
                                
                             	ht_loop_id.put(zapi+"", tcv.getId());
                            	
                           	 System.out.println("===================================================== ++++ "+zapi);
                           	zapi++;
                           	ht_loop_a.put(tcv.getId(), ht_loop_b.toString());
                                
                            } 
                            else{
                            if(nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
                                ht_loop_b.append(("r=mod"+idfunkcije+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n"));
                            }
                            System.out.println("=====================================================");
                            System.out.println("======================================sssss==========");
                            System.out.println("=====================================================");
                            System.out.println("=====================================================");
                            System.out.println(("=================="+ht_loop_b.toString()));
                            if(ht_loop_b != null && !ht_loop_b.toString().equals("")) {
                            	ht_loop_id.put(zapi+"", tcv.getId());
                            	
                            	 System.out.println("===================================================== ++++ "+zapi);
                            	zapi++;
                            	ht_loop_a.put(tcv.getId(), ht_loop_b.toString());
                            }
                            	
                            	System.out.println("=====================================================");
                            System.out.println("======================================sssss==========");
                            System.out.println("=====================================================");
                            System.out.println("=====================================================");
                            try
                            {
                                ht_loop_b.delete(0, ht_loop_b.length());
                            }
                            catch(Exception nn) { }
                        }
                        }
                }
                    
                    
                    
                    if(tfs.getTemplateClassClass() != null && tfs.getTemplateClassClass().getClass_name() != null && !tfs.getTemplateClassClass().getClass_name().equals(""))
                    {
                        System.out.println((classtip+" :::----------------ssssssssXXXXXXXXXXXX ---------------------- +++++++++++++++++++ ---------------------------------"));
                        ht_loop_id.put((zapi+""), tcc.getId());
                        zapi++;
                 
                      
                       ht_loop.put(tcc.getId(), generirajFunkcijoLoop_PDF(contextUtil, servletContext,tfs.getTemplateClassClass().getId()+"", "", ("mod"+idfunkcije+class1), idfunkcije, sbfo, sbfo_template,true));
                   
                    
                    }
                }///////////////////////////////////////////////////////////////////////////////
            }
            String preretu = "";
            String retuu = sb.toString();
            if(tfs.getTemplatelists().size() == 0 && tfs.getTemplateviews().size() == 0){
                retuu = "";
        }
            System.out.println(retuu);
            for(int u = 0; u < ht_loop_id.size(); u++)
            {
            	
System.out.println("-*----------------- *************** ---------------- "+u);
            	
                if(u != 0 && ht_loop_a!=null && ht_loop_a.containsKey(ht_loop_id.get((u+""))))
                {
                    String htm = (String)ht_loop_a.get(ht_loop_id.get((u+"")));
                    System.out.println("=====================================================");
                    System.out.println(("====================================================cccc=\n"+htm));
                    preretu = (preretu+htm);
                    System.out.println("===================================================ccccc==");
                    System.out.println("=====================================================");
                    ht_loop_a.remove(ht_loop_id.get((u+"")));
                }
                if(u == 0)
                {
                	
                	System.out.println("================SIZZZZZZZZZZZ =====================================" + tfs.getTemplatelists().size());
                	System.out.println("================SIZZZZZZZZZZZ =====================================" + retuu);
                	
                	
                	
                	
                    if(tfs!=null && tfs.getTemplatelists()!=null &&  tfs.getTemplatelists().size() == 0 && tfs.getTemplateviews().size() == 0)
                        if(retuu.indexOf(("//////DOME"+ht_loop_id.get((u+""))+"//////")) != -1) {
                            retuu = retuu.replaceFirst(("//////DOME"+ht_loop_id.get((u+""))+"//////"), (String)ht_loop.get(ht_loop_id.get((u+""))));
                        }
                        else{
                            retuu = (retuu+(String)ht_loop.get(ht_loop_id.get((u+""))));
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println(retuu);
                    continue;
                }
                }
                if(u == 1)
                {
                    if(retuu.indexOf("//////DOME0//////") != -1)
                        retuu = retuu.replaceFirst("//////DOME0//////", (String)ht_loop.get(ht_loop_id.get((u+""))));
                    else
                    if(retuu.indexOf(("//////DOME"+ht_loop_id.get((u+""))+"//////")) != -1)
                        retuu = retuu.replaceFirst(("//////DOME"+ht_loop_id.get((u+""))+"//////"), (String)ht_loop.get(ht_loop_id.get((u+""))));
                    else
                        retuu = (retuu+(String)ht_loop.get(ht_loop_id.get((u+""))));
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println(retuu);
                    continue;
                }
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                if(retuu.indexOf(("//////DOME"+ht_loop_id.get((u+""))+"//////")) != -1) {
                    retuu = retuu.replaceFirst(("//////DOME"+ht_loop_id.get((u+""))+"//////"), (String)ht_loop.get(ht_loop_id.get((u+""))));
                }
                else {
                    retuu = (retuu+(String)ht_loop.get(ht_loop_id.get((u+""))));
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println(retuu);
                }
                
            }

            if(tfs.getTemplatelists().size() != 0 || tfs.getTemplateviews().size() != 0)
            
            	/// add first
            	retuu = (String)ht_loop_a.get(ht_loop_id.get("0"))+retuu;
            	
            	retuu = (retuu+"}\r\n");
            rettu[0] = (preretu+retuu);
            rettu[2] = sbfo.toString();
            rettu[3] = sbfo_template.toString();
            rettu[4] = replaceHeaders;
            
            return rettu;
        }
        catch(Exception ex)
        {
            System.out.println(("Napaka pri generaciji funkcije: "+ex.toString()));
        }
        return null;
    }
*/
    
    
    
    
    
    
    
    private StringBuffer whole_fo_template = new StringBuffer();
    private StringBuffer whole_fo = new StringBuffer();
    private int whole_zap = 0; // zaporedje, ce je vec loopv v isti stopnji, se da enega pod drugim, ne pa enega znotraj drugega
    /// zadnji narejen
    private int whole_i = 0;

    private Hashtable whole_ht = new Hashtable();

    
    
    
    
    
    public String[] generirajFunkcijo_PDF(ContextUtil contextUtil, ServletContext servletContext, String idfunkcije, control comm, int zapom,boolean naslov,int wholzap,boolean reset)
    {
    	
    	System.out.println("LOOP ::: "+idfunkcije);
    	 StringBuffer celfo = new StringBuffer();
    	 StringBuffer delfo = new StringBuffer();
    	int tipfo = 0; // 1 - view fo | 2 - list fo
    	
    	if (naslov || reset) {
    		whole_fo_template = new StringBuffer();
    	    whole_fo = new StringBuffer();
    	    whole_zap = wholzap; 
    	    whole_i=0;
    	    whole_ht = new Hashtable();
    	    //celfo = new StringBuffer();
    	}
    	

    	this.id_veza="";
    	this.id_v_je=false;
    	
    	this.contextUtil2=contextUtil;
    	this.servletContext2 = servletContext;
        cont = comm;
        String rettu[] = new String[7];
        StringBuffer sb = new StringBuffer();
        StringBuffer sbfo = new StringBuffer();
        StringBuffer sbfo_template = new StringBuffer();
        try
        {
            ht_loop.clear();
            ht_loop_a.clear();
            this.ht_loop_b.clear();
            ht_loop_id.clear();
            ht_loopfo.clear();
            ht_loopfo_id.clear();
            ht_loop_idv.clear();
            zapi = 0;
            TemplateFunkcijaStartDAO daol = (TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO", servletContext);
            TemplateFunkcijaStart tfs = daol.getTemplateFunkcijaStart(new Long(idfunkcije));
            if(tfs != null && tfs.getTemplateClassClass() != null && tfs.getTemplateClassClass().getClass_name() != null && !tfs.getTemplateClassClass().getClass_name().equals(""))
            {
                sb.append("if (true) {\r\n");
                sb.append("r=\"\";\r\n");
                TemplateClassClass tcc = tfs.getTemplateClassClass();
                String class1 = tcc.getClass_name();
                rettu[1] = class1;
                String classtip = "";
                if(tcc.getTip_funkcije() != null && !tcc.getTip_funkcije().equals("")){
                    classtip = tcc.getTip_funkcije();
            }
                
                sb.append(("com.popultrade.dao."+class1+"DAO doa"+tcc.getId()+class1+" =(com.popultrade.dao."+class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0, 1).toLowerCase()+class1.substring(1)+"DAO\",pageContext.getServletContext());\r\n"));
                sb.append(("com.popultrade.model."+class1+" mod"+tcc.getId()+class1+" = new com.popultrade.model."+class1+"();\r\n"));
                sb.append("dodpogo=\"\";\r\n");
                
                Iterator tre = tfs.getTemplateClassClass().getTemplateClasss().iterator();
                Hashtable meto = getClassMetodeImenaHT(contextUtil,  servletContext,tcc.getClass_name());
                do
                { /// definira funkcijo s parametri
                    if(!tre.hasNext()) {
                        break;
                    }
                    TemplateClass tcci = (TemplateClass)tre.next();
                    if(nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("session.getAttribute"))
                    {
                        
                    	String rett = "";
                    		
                    	if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                    	 rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"+\"\"");
                        
                        
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            rett = ("new Long("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                            rett = ("Integer.parseInt("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            rett = ("Double.parseDouble("+rett+")");
                        
                    	}
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                            sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                    }
                        if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Date") != -1 && (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)){
                            rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"");
                    }
                        }
                        
                        if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                        sb.append(("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        }
                    	if (!nul.jeNull(tcci.getDodaten_pogoj_za_request()).equals("")) {
                    		sb.append("dodpogo+=\""+tcci.getDodaten_pogoj_za_request()+"\";\r\n");
                    	}
                        
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                        	
                            sb.append(" }\r\n");
                    }
                        
                    	
                        
                    
                    	
                        
                        
                    } else
                    	
                    {
                    	
                    	String rett= "";
                    	if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                         rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", (""+tcc.getId()+".get")).replaceAll("'", "\"");
                        
                        
                        if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)
                            rett = tcci.getVrednost_pogoja().replaceAll("'", "\"");
                       
                        
                        if((rett.indexOf("get") == -1 || rett.indexOf("request.getParameter") != -1 || rett.indexOf("session.getAttribute") != -1) && meto.containsKey(tcci.getIme_pogoja()))
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("String") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                                rett = ("new Long("+rett+")");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                if(rett.indexOf(",") != -1)
                                    rett = rett.replaceAll("\\,", "\\.");
                            }
                        
                        
                    	}
                        
                        
                        
                        
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                            sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                    }
                        
                        if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Date") != -1 && (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1)){
                            rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"");
                    }
                        }
                        if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                            
                        sb.append(("mod"+tcc.getId()+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        
                        }
                        if (!nul.jeNull(tcci.getDodaten_pogoj_za_request()).equals("")) {
                    		sb.append("dodpogo+=\""+tcci.getDodaten_pogoj_za_request()+"\";\r\n");
                    	}
                        
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")){
                            sb.append(" }\r\n");
                        }
                        
                        
                    	
                        
                        
                    	
                        
                        
                    }
                } while(true);
                
                
                
                
                if(classtip.equals("ER") || classtip.equals("LI") || classtip.equals("CO"))
                {
                    String orderby = "";
                    String orderbysmer = "";
                    int max_st_iz = 10000;
                    String dodatenhql = "";
                    if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals("")){
                        dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji());
                        
                        
                        sb.append("dodpogo+=\""+dodatenhql+"\";\r\n");
                        
                    }
                    if(!nul.jeNull(tcc.getOrder_by_smer()).equals("")){
                        orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                }
                    if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals("")){
                        orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                }
                    if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0){
                        max_st_iz = tcc.getMax_st_izpisov().intValue();
                }
                    sb.append(("List remi"+tcc.getId()+class1+"=doa"+tcc.getId()+class1+".get"+class1+"s(mod"+tcc.getId()+class1+",1,"+max_st_iz+",dodpogo,\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
                    sb.append("dodpogo=\"\";\r\n");
                    
                    if(classtip.equals("ER") || classtip.equals("LI"))
                    {
                        if(tfs.getTemplateviews() != null && tfs.getTemplateviews().size() > 0)
                        {
                            sb.append(genViews_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, false, contextUtil, servletContext, classtip));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genViews_PDF_fo((tfs.getTemplateClassClass().getId()+""), "1", tp,naslov,wholzap);
                            tipfo = 1;
                            System.out.println("====================x00x============ TIP fo pdf "+tipfo);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                            celfo.append(reti[1]);
                          /*  whole_fo_template.append(reti[0]);
                            if (wzap==1) {
                            whole_fo.append(reti[1]);
                            }*/
                            
                        } else
                        if(tfs.getTemplatelists() != null && tfs.getTemplatelists().size() > 0)
                        {
                            sb.append(genList_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, false, classtip,contextUtil,servletContext));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genList_PDF_fo(tfs, (tfs.getTemplateClassClass().getId()+""), class1, tp,wholzap);
                            tipfo=2;
                            System.out.println("====================x001x============ TIP fo pdf "+tipfo);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                            celfo.append(reti[1]);
                          /*  whole_fo_template.append(reti[0]);
                            if (wzap==1) {
                                whole_fo.append(reti[1]);
                                }*/
                        }
                        else {
                        	setEmpty_PDF_fo(wholzap);
                        }
                    } else
                    if(classtip.equals("CO")){
                        if(tfs.getTemplateviews() != null && tfs.getTemplateviews().size() > 0)
                        {
                            sb.append(genViews_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, true, contextUtil, servletContext, classtip));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genViews_PDF_fo((tfs.getTemplateClassClass().getId()+""), "1", tp,naslov,wholzap);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                            celfo.append(reti[1]);
                            tipfo=1;
                            System.out.println("====================x11x============ TIP fo pdf "+tipfo);
                          /*  whole_fo_template.append(reti[0]);
                            if (wzap==1) {
                                whole_fo.append(reti[1]);
                                }*/
                        } else
                        if(tfs.getTemplatelists() != null && tfs.getTemplatelists().size() > 0)
                        {
                            sb.append(genList_PDF(tfs, (tfs.getTemplateClassClass().getId()+""), class1, true, classtip,contextUtil,servletContext));
                            TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                            TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tfs.getId());
                            String reti[] = genList_PDF_fo(tfs, (tfs.getTemplateClassClass().getId()+""), class1, tp,wholzap);
                            sbfo.append(reti[0]);
                            sbfo_template.append(reti[1]);
                            
                            celfo.append(reti[1]);
                            
                            tipfo=2;
                            System.out.println("====================x22x============ TIP fo pdf "+tipfo);
                          /*  whole_fo_template.append(reti[0]);
                            if (wzap==1) {
                                whole_fo.append(reti[1]);
                                }*/
                        }
                        else {
                        	setEmpty_PDF_fo(wholzap);
                        }
                }
                    if(tfs.getTemplatelists().size() == 0 && tfs.getTemplateviews().size() == 0){
                    	sb.append(("r=\"\";\r\n"));
                    //	tipfo=0;
                }
                   
                        sb.append(("//////DOME"+tcc.getId()+"//////\r\n"));
                    Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
                    
                    
                    
                    
                    if(tcc.getTemplateClassClass_vrednostis().size() > 0){
                    	
                    
                    	
                        while(vredno.hasNext()) 
                        {
                            TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                            StringBuffer ht_loop_b = new StringBuffer();
                            if(tcv.getTemplateClasses().size() > 0)
                            {
                                Iterator item = tcv.getTemplateClasses().iterator();
                                String solom = "";
                                do
                                {
                                    if(!item.hasNext()){
                                        break;
                                }
                                    TemplateClass txc = (TemplateClass)item.next();
                                    if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                    {
                                        if(txc.getTemplateClassClass() == null || txc.getTemplateClassClass().getClass_name() == null || txc.getTemplateClassClass().getClass_name().equals(""))
                                        {
                                            sb.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("'", "\"").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get"))+" {\r\n"));
                                            if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.getParameter") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("session.getAttribute") == -1)
                                            {
                                                if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                                {
                                                    if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                                    {
                                                        if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                                            sb.append(("r=("+txc.getVrednost_pogoja().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get")).replaceAll("nul.je", "nul.je").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+")+\"\";\r\n\r\n"));
                                                    } else
                                                    if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]") != -1)
                                                    {
                                                        String dodd = "";
                                                        if(nul.jeNull(txc.getVrednost_pogoja()).length() > "[SIZE]".length())
                                                            dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]") + 1, nul.jeNull(txc.getVrednost_pogoja()).length());
                                                        sb.append(("r=(remi"+(tfs.getTemplateClassClass().getId()+"")+class1+".size() "+dodd+") + \"\";\r\n"));
                                                    } else
                                                    {
                                                        sb.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                                    }
                                                } else
                                                {
                                                    sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                                    System.out.println("===================================================================  XXcccccccXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                    System.out.println("===================================================================  XXXX");
                                                
                                                }
                                            } else
                                            if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                            {
                                                if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                                    sb.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n"));
                                                else
                                                    sb.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get")).replaceAll("nulg.geet", "nul.get")+"+\"\";\r\n\r\n"));
                                            } else
                                            {
                                                sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("nul.get", "nulg.geet").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get")).replaceAll("nulg.geet", "nul.get")+";\r\n\r\n"));
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            System.out.println("===================================================================  XXXX");
                                            }
                                            if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1"))
                                                sb.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                            else
                                            if(nul.jeNull(txc.getVrednost_pogoja()).equals(""));
                                            sb.append("}\r\n");
                                        }
                                    } else {
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
                                        sb.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                    }else {
                                    if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
                                        if(nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1")) {
                                            sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get"))+";\r\n\r\n"));
                                        
                                            System.out.println("===========sssssss========================================================  XXXX");
                                            System.out.println("============sssssssssss=======================================================  XXXX");
                                            System.out.println("=============sssssssss======================================================  XXXX");
                                            System.out.println("=============sssssssssss======================================================  XXXX");
                                            System.out.println("=============ssssssssss======================================================  XXXX");
                                            System.out.println("=============ssssssssssss======================================================  XXXX");
                                            System.out.println("=============ssssssssssss======================================================  XXXX ");
                                        
                                        }else{
                                            sb.append(("r=\""+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1+".get"))+"\";\r\n\r\n"));
                                        
                                        	if (!nul.jeN(txc.getRocna_vrednost()).equals("")) {
                                        		sb.append(txc.getRocna_vrednost()+";\r\n");
                                        	}
                                        
                                        
                                        }
                                    }
                                    }
                                    }
                                        } while(true);
                                
                             	ht_loop_id.put(zapi+"", tcv.getId());
                            	
                           	 System.out.println("===================================================== ++++ "+zapi);
                           	zapi++;
                           	ht_loop_a.put(tcv.getId(), ht_loop_b.toString());
                                
                            } 
                            else{
                            if(nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
                                ht_loop_b.append(("r=mod"+(tfs.getTemplateClassClass().getId()+"")+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n"));
                            }
                            System.out.println("=====================================================");
                            System.out.println("======================================sssss==========");
                            System.out.println("=====================================================");
                            System.out.println("=====================================================");
                            System.out.println(("=================="+ht_loop_b.toString()));
                            if(ht_loop_b != null && !ht_loop_b.toString().equals("")) {
                            	ht_loop_id.put(zapi+"", tcv.getId());
                            	
                            	 System.out.println("===================================================== ++++ "+zapi);
                            	zapi++;
                            	ht_loop_a.put(tcv.getId(), ht_loop_b.toString());
                            }
                            	
                            	System.out.println("=====================================================");
                            System.out.println("======================================sssss==========");
                            System.out.println("=====================================================");
                            System.out.println("=====================================================");
                            try
                            {
                                ht_loop_b.delete(0, ht_loop_b.length());
                            }
                            catch(Exception nn) { }
                        }
                        }
                }
                    
                    
                    
                    if(tfs.getTemplateClassClass() != null && tfs.getTemplateClassClass().getClass_name() != null && !tfs.getTemplateClassClass().getClass_name().equals(""))
                    {
                        System.out.println((classtip+" :::----------------ssssssssXXXXXXXXXXXX ---------------------- +++++++++++++++++++ ---------------------------------"));
                        ht_loop_id.put((zapi+""), tcc.getId());
                        zapi++;
                        
                    	whole_zap=whole_zap+1;
                     	int wzap = whole_zap;
                        
                    	/*com.popultrade.dao.TemplateClassDAO daotc = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",servletContext);
                    	com.popultrade.model.TemplateClass sifi = new com.popultrade.model.TemplateClass();


                    	sifi.setTemplatehead_id(tfs.getId());
                    	
                    	
                    		List lisi =null;

                    		lisi = daotc.getTemplateClasss(sifi,1,100);
                    		
                    		
                    		Iterator limo = lisi.iterator();
                    		
                    		String ook = "";
                    		
                    		while (limo.hasNext()) {
                    			
                    			com.popultrade.model.TemplateClass si =(com.popultrade.model.TemplateClass)limo.next();
                    			ook = ("---predpona0---"+ nul.jeNull(si.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(si.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", "mod"+ idfunkcije +class1+ ".get").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter") + " {\r\n");
                               	
                    		}
                    	*/
                      
                     //  ht_loop.put(tcc.getId(), generirajFunkcijoLoop_PDF(contextUtil, servletContext,tfs.getTemplateClassClass().getId()+"", "", ("mod"+idfunkcije+class1), idfunkcije, sbfo, sbfo_template,true));
                     	System.out.println("=============================dx=== TIP fo pdf "+tipfo);
                     	String[] reko = generirajFunkcijoLoop_PDF(contextUtil, servletContext,tfs.getTemplateClassClass().getId()+"", "", ("mod"+(tfs.getTemplateClassClass().getId()+"")+class1), (tfs.getTemplateClassClass().getId()+""), sbfo, sbfo_template,true,wzap);
                     	
                     	
                    sb.append(""+reko[0]);
                    
                    System.out.println("=============================dxxxxx=== TIP fo pdf "+tipfo);
                    
                    delfo.append(reko[1]); // append template
                    celfo.append(reko[2]); // append call to template
                    System.out.println("=============================dx=== template ");
                    System.out.println("=============================dx=== template ");
                    System.out.println("=============================dx=== template ");
                    System.out.println("=============================dx=== template ");
                    System.out.println(reko[2]);
                    System.out.println("=============================dx=== template ");
                    System.out.println("=============================dx=== template ");
                    System.out.println("=============================dx=== template ");
                    System.out.println("=============================dx=== template ");
                   // sb.append("}\r\n");
                    
                    }
                    
                    
                    sb.append(this.konec_xml+"\r\n}\r\n");
                    this.konec_xml="";
                    System.out.println("================================ TIP fo pdf "+tipfo);
                    System.out.println("================================ TIP fo pdf "+tipfo);
                    System.out.println("================================ TIP fo pdf "+tipfo);
                    System.out.println("================================ TIP fo pdf "+tipfo);
                    System.out.println("================================ TIP fo pdf "+tipfo);
                    if (tipfo==2) {
                    celfo.append(this.genList_PDF_fo_end_s());
                    }
                    else if (tipfo==1) {
                    	celfo.append(this.genViews_PDF_fo_end());
                    }
                    
                    celfo.append(delfo.toString());
                    
                }///////////////////////////////////////////////////////////////////////////////
            }
            String preretu = "";
            String retuu = sb.toString();
            if(tfs.getTemplatelists().size() == 0 && tfs.getTemplateviews().size() == 0){
                retuu = "";
        }
            System.out.println(retuu);
         /*   for(int u = 0; u < ht_loop_id.size(); u++)
            {
            	
System.out.println("-*----------------- *************** ---------------- "+u);
            	
                if(u != 0 && ht_loop_a!=null && ht_loop_a.containsKey(ht_loop_id.get((u+""))))
                {
                    String htm = (String)ht_loop_a.get(ht_loop_id.get((u+"")));
                    System.out.println("=====================================================");
                    System.out.println(("====================================================cccc=\n"+htm));
                    preretu = (preretu+htm);
                    System.out.println("===================================================ccccc==");
                    System.out.println("=====================================================");
                    ht_loop_a.remove(ht_loop_id.get((u+"")));
                }
                if(u == 0)
                {
                	
                	System.out.println("================SIZZZZZZZZZZZ =====================================" + tfs.getTemplatelists().size());
                	System.out.println("================SIZZZZZZZZZZZ =====================================" + retuu);
                	
                	
                	
                	
                    if(tfs!=null && tfs.getTemplatelists()!=null &&  tfs.getTemplatelists().size() == 0 && tfs.getTemplateviews().size() == 0)
                        if(retuu.indexOf(("//////DOME"+ht_loop_id.get((u+""))+"//////")) != -1) {
                            retuu = retuu.replaceFirst(("//////DOME"+ht_loop_id.get((u+""))+"//////"), (String)ht_loop.get(ht_loop_id.get((u+""))));
                        }
                        else{
                            retuu = (retuu+(String)ht_loop.get(ht_loop_id.get((u+""))));
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println(retuu);
                    continue;
                }
                }
                if(u == 1)
                {
                    if(retuu.indexOf("//////DOME0//////") != -1)
                        retuu = retuu.replaceFirst("//////DOME0//////", (String)ht_loop.get(ht_loop_id.get((u+""))));
                    else
                    if(retuu.indexOf(("//////DOME"+ht_loop_id.get((u+""))+"//////")) != -1)
                        retuu = retuu.replaceFirst(("//////DOME"+ht_loop_id.get((u+""))+"//////"), (String)ht_loop.get(ht_loop_id.get((u+""))));
                    else
                        retuu = (retuu+(String)ht_loop.get(ht_loop_id.get((u+""))));
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                    System.out.println(retuu);
                    continue;
                }
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                if(retuu.indexOf(("//////DOME"+ht_loop_id.get((u+""))+"//////")) != -1) {
                    retuu = retuu.replaceFirst(("//////DOME"+ht_loop_id.get((u+""))+"//////"), (String)ht_loop.get(ht_loop_id.get((u+""))));
                }
                else {
                    retuu = (retuu+(String)ht_loop.get(ht_loop_id.get((u+""))));
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ ::: ");
                System.out.println(retuu);
                }
                
            }*/

            if(tfs.getTemplatelists().size() != 0 || tfs.getTemplateviews().size() != 0)
            
            	/// add first
            	/*retuu = (String)ht_loop_a.get(ht_loop_id.get("0"))+retuu;
            	
            	retuu = (retuu+"}\r\n");*/
            	
            	retuu = sb.toString();
            rettu[0] = (preretu+retuu);
            rettu[2] = sbfo.toString();
            
            rettu[3] = sbfo_template.toString();
           // rettu[3] = celfo.toString();
            
            rettu[4] = replaceHeaders;
            rettu[6] = celfo.toString();
            rettu[5] = sbfo.toString();
            
            
            return rettu;
        }
        catch(Exception ex)
        {
            System.out.println(("Napaka pri generaciji funkcije: "+ex.toString()));
        }
        return null;
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /////////////// loop
    
    boolean ze_crta=false;
    private String[] generirajFunkcijoLoop_PDF(ContextUtil contextUtil, ServletContext servletContext, String idnaprej, String sbb, String idprej, String idfunk, StringBuffer sbfo, 
            StringBuffer sbfo_template,boolean prvix,int xzap)
    {
    	
    	String[] retu = new String[3];
    	retu[0]="";
    	retu[1]="";
    	retu[2]="";
    	
    	 StringBuffer celfo = new StringBuffer(); // whole template for this loop
    	 StringBuffer delfo = new StringBuffer(); // template
    	 StringBuffer temfo = new StringBuffer(); // call to template 
    	StringBuffer tsufo = new StringBuffer(); // call to template if sub loops has and not this one
    	
    	int tipfo = 0;
    	System.out.println("LOOP ::: "+idfunk+" ::: "+idprej);
  
        try {
            StringBuffer sb = new StringBuffer();
            System.out.println("-------------- a 1");
            if (!ze_crta) {
                sb.append("//========================================================\r\n");
                ze_crta=true;
                }
            TemplateClassClassDAO daol = (TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO", servletContext);
            TemplateClassClass tcc = daol.getTemplateClassClass(new Long(idnaprej));
            String class1 = tcc.getClass_name();
            //// pogoj
            
            
       
            boolean jepogoj = false;
      
            
            List teml = tcc.getTemplateClasss();
            TemplateClass temc = new TemplateClass();
            if (teml.size()>0) {
            	
            	temc = (TemplateClass)teml.get(0);
            }
            
            System.out.println("-------------- a 12");
            sb.append("if (true) {\r\n");
          
            String classtip = "";
            
           // tcc.get
            
            if(tcc.getTip_funkcije() != null && !tcc.getTip_funkcije().equals("")) {
                classtip = tcc.getTip_funkcije();
        }
            if(!classtip.equals("UP"))
            {
            	
            	 
            	
                if(!prvix) {
                	sb.append(("com.popultrade.dao."+class1+"DAO doa"+idnaprej+class1+" =(com.popultrade.dao."+class1+"DAO)contextUtil.getBeanDao(\""+class1.substring(0, 1).toLowerCase()+class1.substring(1)+"DAO\",pageContext.getServletContext());\r\n"));
           
                	sb.append(("com.popultrade.model."+class1+" mod"+idnaprej+class1+" = new com.popultrade.model."+class1+"();\r\n"));
                }
            }
            
            
            Iterator tre = tcc.getTemplateClasss().iterator();
            Hashtable meto = getClassMetodeImenaHT(contextUtil,  servletContext,tcc.getClass_name());
            do
            {
            	
            	
            	 System.out.println("-------------- a 13");
            	
            	
                if(!tre.hasNext()) {
                    break;
                }
                
                TemplateClass tcci = (TemplateClass)tre.next();
                if(!nul.jeNull(tcci.getUporabi_kot_rezultat()).equals("1")) {
                    if(nul.jeNull(tcci.getVrednost_pogoja()).startsWith("control.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("nul.") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("request.getParameter") || nul.jeNull(tcci.getVrednost_pogoja()).startsWith("session.getAttribute"))
                    {
                    	
                    	String rett = "";
                    	if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                         rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"+\"\"");
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Date") != -1 && (nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1))
                            rett = (tcci.getVrednost_pogoja().replaceAll("'", "\"")+"");
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            rett = ("new Long("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1 || ((String)meto.get(tcci.getIme_pogoja())).indexOf("int") != -1)
                            rett = ("Integer.parseInt("+rett+")");
                        else
                        if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            rett = ("Double.parseDouble("+rett+")");
                        
                    	}
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                        
                            if(nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")) {
                            	if(!prvix)sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                            }
                            	else {
                            	if(!prvix)sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                    }
                        }
                        
                        
                        if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                        if(!prvix)sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        }
                        
                        
                    	if (!nul.jeNull(tcci.getDodaten_pogoj_za_request()).equals("")) {
                    		if(!prvix)sb.append("dodpogo+=\""+tcci.getDodaten_pogoj_za_request()+"\";\r\n");
                    	}
                        
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                        	if(!prvix)sb.append(" }\r\n");
                        }
                    	
                        
                    
                        
                        
                    } else
                    {
                        String rett = "";
                       
                        
                        if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                        
                        if(nul.jeNull(tcci.getIzvor_vrednosti()).equals("V")) {
                            rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", (""+idprej+".get")).replaceAll("'", "\"");
                    }
                        else {
                            rett = nul.jeNull(tcci.getVrednost_pogoja()).replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("'", "\"");
                    }
                        if(nul.jeNull(tcci.getVrednost_pogoja()).indexOf("request.getParameter") != -1 || nul.jeNull(tcci.getVrednost_pogoja()).indexOf("session.getAttribute") != -1) {
                            rett = tcci.getVrednost_pogoja().replaceAll("'", "\"");
                    }
                        if((rett.indexOf("get") == -1 || rett.indexOf("request.getParameter") != -1 || rett.indexOf("session.getAttribute") != -1) && meto.containsKey(tcci.getIme_pogoja()))
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("String") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Long") != -1)
                            {
                                if(rett.indexOf("\"") == -1)
                                    rett = ("\""+rett+"\"");
                                rett = ("new Long("+rett+")");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Integer") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                            } else
                            if(((String)meto.get(tcci.getIme_pogoja())).indexOf("Double") != -1)
                            {
                                if(rett.indexOf("\"") != -1)
                                    rett = rett.replaceAll("\"", "").replaceAll("'", "");
                                if(rett.indexOf(",") != -1)
                                    rett = rett.replaceAll("\\,", "\\.");
                            }
                        
                        
                        }
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                            if(nul.jeNull(tcci.getIzvor_vrednosti_pogoj()).equals("V")) {
                            	if(!prvix)sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", (""+idprej+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                            }
                            	else {
                            	if(!prvix)sb.append(("if "+tcci.getDodaten_hql_pogoj().replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geStParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geStParameter", "request.getParameter")+" {\r\n"));
                            }
                    }
                        
                        
                        if (!nul.jeNull(tcci.getVrednost_pogoja()).equals("")) {
                            
                        
                        if(!prvix)sb.append(("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcci.getIme_pogoja()+"("+rett+");\r\n"));
                        
                        }
                        if (!nul.jeNull(tcci.getDodaten_pogoj_za_request()).equals("")) {
                        	if(!prvix)sb.append("dodpogo+=\""+tcci.getDodaten_pogoj_za_request()+"\";\r\n");
                    	}
                        
                        if(!nul.jeNull(tcci.getDodaten_hql_pogoj()).equals("")) {
                        	if(!prvix)sb.append(" }\r\n");
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    	
                        
                        
                        
                        
                    }
            }
            } while(true);
            
            
            String id_vezax="";
            System.out.println("-------------- a 4");
            String[] remio = new String[3];
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            System.out.println(("++++++++++++++++++++++++"+classtip+"++++++++++++++++++++++++++++++"));
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            if(classtip.equals("IN") || classtip.equals("UP")) {
            	if(!prvix) {
            		sb.append(("doa"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".save"+class1+"(mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+");\r\n"));
            	}
            }
            if(classtip.equals("ER") || classtip.equals("LI") || classtip.equals("CO"))
            {
                String orderby = "";
                String orderbysmer = "";
                int max_st_iz = 10000;
                String dodatenhql = "";
                if(!nul.jeNull(tcc.getDodatni_hql_pogoji()).equals("")){
                    dodatenhql = nul.jeNull(tcc.getDodatni_hql_pogoji());
                	
                		sb.append("dodpogo+=\""+tcc.getDodatni_hql_pogoji()+"\";\r\n");
                	
            }
                if(!nul.jeNull(tcc.getOrder_by_smer()).equals(""))
                    orderbysmer = nul.jeNull(tcc.getOrder_by_smer());
                if(!nul.jeNull(tcc.getHead_select_dodatni_pogoji()).equals(""))
                    orderby = nul.jeNull(tcc.getHead_select_dodatni_pogoji());
                if(!nul.jeNull((tcc.getMax_st_izpisov()+"")).equals("") && tcc.getMax_st_izpisov().intValue() > 0)
                    max_st_iz = tcc.getMax_st_izpisov().intValue();
                if(!prvix)sb.append(("List remi"+idnaprej+class1+"=doa"+idnaprej+class1+".get"+class1+"s(mod"+idnaprej+class1+",1,"+max_st_iz+",dodpogo,\""+orderby+"\",\""+orderbysmer+"\");\r\n"));
               
                if(!prvix)sb.append("dodpogo=\"\";\r\n");
                
                boolean avtowhile = false;
 
                System.out.println((tcc.getTemplateviews().size()+"///VIEWWWWWWWWW//////////////////////// "+classtip+" ////////////////////////////"+tcc.getTemplatelists().size()));
             
                if(tcc.getTemplateviews() != null && tcc.getTemplateviews().size() > 0)
                {
                    
                    if(classtip.equals("CO")){
                    	System.out.println("/////////////////////////////////-//////////////////////////xxxxxxxxxxx/");
                    	
                    	
                    	
                        remio = genViews_PDF2(tcc, idnaprej, class1, true, contextUtil, servletContext);
                    }
                    else {
                        remio = genViews_PDF2(tcc, idnaprej, class1, false, contextUtil, servletContext);
                    }
   
                    if(!prvix){
                    	sb.append(remio[0]);
                }
                    TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                    TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tcc.getId());
                    String reti[] = genViews_PDF_fo(idnaprej, "2", tp,false,xzap);
                    tipfo=1;
                    String idf = idfunk;
                    System.out.println("====================x1x============ TIP fo pdf "+tipfo);
               	 System.out.println("///////////////////******************/////////////////////////");
            	 System.out.println("///////////////////******************/////////////////////////");
            	 System.out.println("///////////////////*v***"+idf+"*****/////////////////////////");
            	 System.out.println("///////////////////******************/////////////////////////");
                System.out.println("///////////////////******************/////////////////////////");
                    if (!this.id_veza.equals("") && id_v_je ) {
                    	idf = this.id_veza;
                    	this.id_veza="";
                    
                    	 System.out.println("///////////////////*v***"+idf+"*****/////////////////////////");
                    	 System.out.println("///////////////////******************/////////////////////////");
                      
                        id_v_je=false;
                    	
                    }
                    
                    
                    
                    
                    
                    
                    
                   // if (whole_zap==1) {
                    /*
                    String whole = whole_fo.toString();
                    
                    System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC  ::: <!--DODAJXX"+(wzap-1)+"-->");
                    
                    if (whole.indexOf("<!--DODAJXX"+(wzap-1)+"-->")!=-1) {
                    	System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC NAJDEM ::: <!--DODAJXX"+(wzap-1)+"-->");
                    	whole=whole.replace("<!--DODAJXX"+(wzap-1)+"-->", reti[0]);
                    	
                    }
                    else {
                    	 whole_fo_template.append(reti[0]);
                    }
                    if (whole.indexOf("<!--SPODAJ"+wzap+"-->")!=-1) {
                    	
                    	whole=whole.replace("<!--SPODAJ"+(wzap)+"-->", reti[1]);
                    	
                    }
                    
                    
                    whole_fo.delete(0, whole_fo.length());
                    whole_fo.append(whole+reti[1]);
                        */
                    
                   // }
                    
                    
                    
                    
                    if(sbfo_template.toString().indexOf(("<!--DODAJ"+idf+"-->")) != -1)
                    {
                        String repl = sbfo_template.toString();
                        String en = repl.substring(0, repl.indexOf(("<!--DODAJ"+idf+"-->")));
                        String dv = repl.substring(repl.indexOf(("<!--DODAJ"+idf+"-->")) , repl.length());
                        sbfo_template.delete(0, sbfo_template.length());
                        sbfo_template.append((en+reti[0]+"<!--DODAJ"+idf+"-->"+dv));
                 
                    } else
                    {
                        sbfo.append(reti[0]);
                 
                    }
                    sbfo_template.append(reti[1]);
                    
                    temfo.append(reti[0]);
                    celfo.append(reti[1]);
                    
                  //  if (this.id_veza.equals("")) {
                        this.id_veza=idnaprej;
                      //  }
                    
                } else
                if(tcc.getTemplatelists() != null && tcc.getTemplatelists().size() > 0)
                {
                   
                    if(classtip.equals("CO")){
                    	
                    
                        remio = genList_PDF2(tcc, idnaprej, class1, true,contextUtil,servletContext);
                    }
                    else{
                        remio = genList_PDF2(tcc, idnaprej, class1, false,contextUtil,servletContext);
                    }
                    
                    if(!prvix) {
                    	sb.append(remio[0]);
                    }
                    
                    tipfo=2;
                    System.out.println("====================xx============ TIP fo pdf "+tipfo);
                    System.out.println("////////////////////////////////////////////////////////////");
                    System.out.println("////////////////////////////////////////////////////////////");
                    System.out.println("////////////////////////////////////////////////////////////");
                    System.out.println("////////////////////////////////////////////////////////////");
                    System.out.println("////////////////////////////////////////////////////////////");
                    TemplatePdfParametriDAO dap = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
                    TemplatePdfParametri tp = dap.getTemplatePdfParametriByVezaId(tcc.getId());
                    String reti[] = genList_PDF_fo(tcc, idnaprej, class1, tp,xzap);
                    
                    String idf = idfunk;
                    
               	 System.out.println("///////////////////******************/////////////////////////");
            	 System.out.println("///////////////////******************/////////////////////////");
            	 System.out.println("///////////////////*l***"+idf+"*****/////////////////////////");
            	 System.out.println("///////////////////******************/////////////////////////");
                System.out.println("///////////////////******************/////////////////////////");
                    
                    if (!this.id_veza.equals("") && id_v_je ) {
                    	idf = this.id_veza;
                    	 System.out.println("///////////////////*l***"+idf+"*****/////////////////////////");
                    	 System.out.println("///////////////////******************/////////////////////////");
                      
                    	this.id_veza="";
                    	id_v_je=false;
                    	
                   
                    }
                    /*
                    String whole = whole_fo.toString();
                    
                    System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC 2 ::: <!--DODAJXX"+(wzap-1)+"-->");
                    
                    if (whole.indexOf("<!--DODAJXX"+(wzap-1)+"-->")!=-1) {
                    	 System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC  2 ::: <!--DODAJXX"+(wzap-1)+"-->");
                    	whole=whole.replace("<!--DODAJXX"+(wzap-1)+"-->", reti[0]);
                    	
                    }
                    else {
                   	 whole_fo_template.append(reti[0]);
                   }
                    if (whole.indexOf("<!--SPODAJ"+wzap+"-->")!=-1) {
                    	
                    	whole=whole.replace("<!--SPODAJ"+(wzap)+"-->", reti[1]);
                    	
                    }
                    whole_fo.delete(0, whole_fo.length());
                    whole_fo.append(whole+reti[1]);
                    
                    */
                    
                    
                    
                    
                    if(sbfo_template.toString().indexOf(("<!--DODAJ"+idf+"-->")) != -1)
                    {
                        String repl = sbfo_template.toString();
                        String en = repl.substring(0, repl.indexOf(("<!--DODAJ"+idf+"-->")));
                        String dv = repl.substring(repl.indexOf(("<!--DODAJ"+idf+"-->")) , repl.length());
                        sbfo_template.delete(0, sbfo_template.length());
                        sbfo_template.append((en+reti[0]+"<!--DODAJ"+idf+"-->"+dv));
                    } else
                    {
                        sbfo.append(reti[0]);
                    }
                    sbfo_template.append(reti[1]);
                    
                    temfo.append(reti[0]);
                    celfo.append(reti[1]);
                    
                   // if (this.id_veza.equals("")) {
                        this.id_veza=idnaprej;
                     //   }
                    
                    
                } else
                if(classtip.equals("LI"))
                {
                	if(!prvix)sb.append(("if (remi"+idnaprej+""+class1+".size()>0) {\r\n"));
                	if(!prvix)sb.append(("List lis"+idnaprej+class1+" =remi"+idnaprej+""+class1+";\r\n"));
                	if(!prvix)sb.append(("Iterator itx"+idnaprej+class1+" = lis"+idnaprej+class1+".iterator();\r\n\r\n"));
                	if(!prvix)sb.append(("com.popultrade.model."+class1+" modoo"+idnaprej+""+class1+"=new com.popultrade.model."+class1+"();\r\n"));
                	if(!prvix)sb.append(("while (itx"+idnaprej+class1+".hasNext()){  // while start\r\n"));
                	if(!prvix)sb.append(("mod"+idnaprej+class1+"=(com.popultrade.model."+class1+")itx"+idnaprej+class1+".next();\r\n"));
                    avtowhile = true;
                    
                    id_v_je=true;
                    setEmpty_PDF_fo(xzap);
                    tipfo=0;
                    System.out.println("====================xcx============ TIP fo pdf "+tipfo);
                } else
                {
                	if(!prvix)sb.append(("if (remi"+idnaprej+class1+".size()>0) {\r\n"));
                	if(!prvix)sb.append(("mod"+idnaprej+class1+"=(com.popultrade.model."+class1+")remi"+idnaprej+class1+".get(0);\r\n"));
                	if(!prvix)sb.append("}\r\n");
                	setEmpty_PDF_fo(xzap);
                	id_v_je=true;
                	tipfo=0;
                	System.out.println("====================xcx============ TIP fo pdf "+tipfo);
                }
                
              
                
                
                Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
                int oko = 0;
                
                if(tcc.getTemplateClassClass_vrednostis().size() > 0){
                //	whole_zap=whole_zap+1;
                	int zgor = whole_zap;
                    do
                    {
                       
                    	
                    	 System.out.println("-------------- a 15");
                    	
                    	if(!vredno.hasNext()){
                            break;
                    }
                    	
                    	  
                   	 
                    //	int wzap = zgor;
                    	
                        TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                        System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
                        System.out.println(("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: "+tcc.getTemplateClassClass_vrednostis().size()));
                        System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
                        if(tcv.getTemplateClasses().size() > 0)
                        {
                        	
                        	
                            Iterator item = tcv.getTemplateClasses().iterator();
                           boolean prvireset = false;
                          
                           
                           whole_zap = zgor;
                           whole_zap=whole_zap+1;
                       	int wzap = whole_zap;
                       	
                      /*	
                        int wzap = zgor;
                        if (oko!=0) {
                        zgor++;
                        wzap=zgor;
                        }
                        else {
                        whole_zap=whole_zap+1;
                        wzap=whole_zap;
                        oko=1;
                        }*/
                       	
                       	/*
                        whole_zap=whole_zap+1;
                       	int wzap = whole_zap;*/
                        	// wzap++;
                            while(item.hasNext()) 
                            {
                                TemplateClass txc = (TemplateClass)item.next();
                                if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                {
                                	
                                	if (!prvireset) {
                                	sb.append("r=\"\";\r\n");
                                	prvireset=true;
                                	}
                                	//sb.append(""+ nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", "mod"+ idnaprej +class1+ ".get").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter") + " {\r\n");
                                    
                                    
                                    
                                    
                                  //  sb.append(("\r\n"+.append(nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"));
                                    if(txc.getTemplateClassClass() != null && txc.getTemplateClassClass().getClass_name() != null && !txc.getTemplateClassClass().getClass_name().equals(""))
                                    {
                                        if(tcc.getTemplateviews().size() == 0 && tcc.getTemplatelists().size() == 0) {
                                        	sb.append(("r=\"\";\r\n"));
                                        	sb.append(("//////DOME"+idnaprej+"//////\r\n"));
                                    }
                                        if(!ht_loop.containsKey(idnaprej))
                                        {
                                            ht_loop_id.put((zapi+""), idnaprej);
                                            zapi++;
                                          //  ht_loop.put(idnaprej, ""+ nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", "mod"+ idnaprej +class1+ ".get").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter") + " {\r\n"+generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false)+"\r\n}\r\n");
                                          
                                            String[] reko = generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false,wzap);
                                            
                                            
                                            sb.append( ""+ nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", "mod"+ idnaprej +class1+ ".get").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter") + " {\r\n"+reko[0]+"\r\n}\r\n");
                                           // this.id_veza="";
                                            
                                         	if (!temfo.toString().trim().equals("")) {
                                            	celfo.append(reko[2]);
                                            	}
                                            	else {
                                            		tsufo.append(reko[2]);
                                            	}
                                                delfo.append(reko[1]);
                                            
                                            
                                            
                                            if(!prvix)sb.append(""+remio[1]);
                                      remio[1]="";
                                        
                                        } else
                                        {
                                         //   ht_loop.put(idnaprej, (ht_loop.get(idnaprej)+""+ nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", "mod"+ idnaprej +class1+ ".get").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"+generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false)+"\r\n }\r\n") );
                                           
                                        	String[] reko = generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false,wzap);
                                         	if (!temfo.toString().trim().equals("")) {
                                            	celfo.append(reko[2]);
                                            	}
                                            	else {
                                            		tsufo.append(reko[2]);
                                            	}
                                                delfo.append(reko[1]);
                                        	
                                            sb.append( ( nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", "mod"+ idnaprej +class1+ ".get").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"+reko[0]+"\r\n }\r\n") );
                                          //  this.id_veza="";
                                            
                                            if(!prvix)sb.append(""+remio[1]);
                                            remio[1]="";
                                        }
                                    } else{
                                    	StringBuffer pogee  = new StringBuffer();
                                    	if(!prvix)pogee.append(""+ nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", "mod"+ idnaprej +class1+ ".get").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter") + " {\r\n");
                                        	
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
                                    	if(!prvix)pogee.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                }
                                    else {
                                    if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                        if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1")) {
                                        	if(!prvix)pogee.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get"))+";\r\n\r\n"));
                                        }
                                        	else {
                                        	if(!prvix)pogee.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get"))+";\r\n\r\n"));
                                        	}
                                        	}
                                    
                                    if(!prvix)pogee.append("}\r\n");
                                    
                                    //////////////////////////////
                                    if(!ht_loop.containsKey(idnaprej))
                                    {
                                    	
                                    	
                                        ht_loop_id.put((zapi+""), idnaprej);
                                        zapi++;
                                        ht_loop.put(idnaprej, pogee.toString() + "\r\n");
                                        
                                        sb.append(pogee.toString());
                                     //   if(!prvix)sb.append(""+remio[1]);
                              //    remio[1]="";
                                    
                                    } else
                                    {
                                        ht_loop.put(idnaprej, (ht_loop.get(idnaprej)+""+pogee.toString()) );
                                        
                                        
                                        sb.append(pogee.toString());
                                        
                                        
                                        
                                     //   if(!prvix)sb.append(""+remio[1]);
                                     //   remio[1]="";
                                    }
                                    
                                    /////////////////////////
                                    
                                    }
                                 //   sb.append("}\r\n");
                                } else
                                {
                                    if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("session.get") == -1)
                                    {
                                        if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                        {
                                            if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                            {
                                                if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                                	if(!prvix)sb.append(("r=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("nul.je", "nul.je").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+")+\"\";\r\n\r\n"));
                                            } else
                                            if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]") != -1)
                                            {
                                                String dodd = "";
                                                if(nul.jeNull(txc.getVrednost_pogoja()).length() > "[SIZE]".length())
                                                    dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]") + 1, nul.jeNull(txc.getVrednost_pogoja()).length());
                                                if(!prvix)sb.append(("r=(remi"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".size() "+dodd+") + \"\";\r\n"));
                                            } else
                                            {
                                            	if(!prvix)sb.append(("r=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get"))+")+\"\";\r\n\r\n"));
                                            }
                                        } else
                                        {
                                        	if(!prvix)sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get"))+";\r\n\r\n"));
                                        }
                                    } else
                                    if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1")) {
                                    	if(!prvix)sb.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n"));
                                    }
                                    	else {
                                    	if(!prvix)sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n"));
                                    	}
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
                                    	if(!prvix)sb.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                    }else 
                                    if(nul.jeNull(txc.getVrednost_pogoja()).equals(""));
                                }
                            }
                            
                            
                            
                            
                        } else
                        if(nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
                        	if(!prvix)sb.append(("r=mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n"));
                        }
                        }
                    
                    while(true);
                    
                }
                if(avtowhile)
                {
                	if(!prvix)sb.append("}\r\n");
                	if(!prvix)sb.append("}\r\n");
                }
                
                System.out.println("-------------- a 16");
                if (remio[1]!=null && !remio[1].equals("")) {
                	if(!prvix)sb.append(nul.jeNull(remio[1]));
                	if(!prvix)sb.append(nul.jeNull(remio[2]));
                }
                else {
                	if(!prvix)sb.append(nul.jeNull(remio[2]));
                }
                sb.append("//EEEEEEEEEEEEEEEEEEEEEEEEEE\r\n");
            }
            else  if(classtip.equals("UP") || classtip.equals("IN"))  {
            	
                Iterator vredno = tcc.getTemplateClassClass_vrednostis().iterator();
                if(tcc.getTemplateClassClass_vrednostis().size() > 0)
                    do
                    {
                        if(!vredno.hasNext())
                            break;
                        TemplateClassClass_vrednosti tcv = (TemplateClassClass_vrednosti)vredno.next();
                        System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
                        System.out.println(("::xxxxxx ||||||||||||||||dddddddddddddddd||||||||||||||||| :::::: "+tcc.getTemplateClassClass_vrednostis().size()));
                        System.out.println("::xxxxxx ||||||||||||||||||||||||||||||||| :::::: ");
                        if(tcv.getTemplateClasses().size() > 0)
                        {
                        	
                         	 whole_zap=whole_zap+1;
                         	int wzap = whole_zap;
                            Iterator item = tcv.getTemplateClasses().iterator();
                            while(item.hasNext()) 
                            {
                                TemplateClass txc = (TemplateClass)item.next();
                                if(nul.jeNull(txc.getPredpona_pogoja()).equals("IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE IF") || nul.jeNull(txc.getPredpona_pogoja()).equals("ELSE"))
                                {
                                	sb.append("r=\"\";\r\n");
                                //	sb.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"));
                                    if(txc.getTemplateClassClass() != null && txc.getTemplateClassClass().getClass_name() != null && !txc.getTemplateClassClass().getClass_name().equals(""))
                                    {
                                        if(tcc.getTemplateviews().size() == 0 && tcc.getTemplatelists().size() == 0)
                                        	if(!prvix){
                                        		sb.append(("r=\"\";\r\n"));
                                        		sb.append(("//////DOME"+idnaprej+"//////\r\n"));
                                        	}
                                        
                                        if(!ht_loop.containsKey(idnaprej))
                                        {
                                            ht_loop_id.put((zapi+""), idnaprej);
                                            zapi++;
                                          //  ht_loop.put(idnaprej,("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n")+ generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false)+"}");
                                          
                                            
                                           String[] reko =  generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false,wzap);
                                        
                                           if (!temfo.toString().trim().equals("")) {
                                            	celfo.append(reko[2]);
                                            	}
                                            	else {
                                            		tsufo.append(reko[2]);
                                            	}
                                                delfo.append(reko[1]);
                                                
                                            sb.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n")+ reko[0]+"}");
                                            //this.id_veza="";
                                            
                                            if(!prvix)sb.append(""+remio[1]);
                                        } else
                                        {
                                         //   ht_loop.put(idnaprej,( (ht_loop.get(idnaprej)+"\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"+generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false)+"\r\n}\r\n")+""));
                                          
                                        	String[] reko =  generirajFunkcijoLoop_PDF(contextUtil, servletContext, (txc.getTemplateClassClass().getId()+""), "", ("mod"+idnaprej+class1), idnaprej, sbfo, sbfo_template,false,wzap);
                                        
                                        	if (!temfo.toString().trim().equals("")) {
                                        	celfo.append(reko[2]);
                                        	}
                                        	else {
                                        		tsufo.append(reko[2]);
                                        	}
                                            delfo.append(reko[1]);
                                            
                                        	
                                        	sb.append(( ("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"+reko[0]+"\r\n}\r\n")+""));
                                          // this.id_veza="";
                                            
                                            if(!prvix)sb.append(""+remio[1]);
                                        }
                                    } else {
                                    	
                                    	
                                    	StringBuffer pogee = new StringBuffer();
                                    	
                                    	pogee.append(("\r\n"+nul.jeNull(txc.getPredpona_pogoja()).toLowerCase()+" "+nul.jeNull(txc.getDodaten_hql_pogoj()).replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+" {\r\n"));
                                        
                                    	
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1")) {
                                    	if(!prvix) {
                                    		pogee.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                    	}
                                    else {
                                    if(!nul.jeNull(txc.getVrednost_pogoja()).equals("")) {
                                    	if(!prvix)  {
                                    		
                                    		pogee.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+idnaprej+class1+".get"))+";\r\n\r\n"));
                                    	}
                                    }
                                    }
                                    }
                                    
                                    pogee.append("} //\r\n");
                                    
                                    sb.append(pogee);
                                    ////////////////////////////////////////////////
                                    /*
                                    if(!ht_loop.containsKey(idnaprej))
                                    {
                                        ht_loop_id.put((zapi+""), idnaprej);
                                        zapi++;
                                        ht_loop.put(idnaprej,pogee.toString()+"\r\n");
                                       // if(!prvix)sb.append(""+remio[1]);
                                    } else
                                    {
                                        ht_loop.put(idnaprej, ht_loop.get(idnaprej)+pogee.toString()+"");
                                      //  if(!prvix)sb.append(""+remio[1]);
                                    }*/
                                    
                                    
                                    //////////////////////////////////////////////////
                                    
                                    
                                }
                                    		//  sb.append("}\r\n");
                                } else
                                {
                                    if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("control.") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("nul.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("request.get") == -1 && nul.jeNull(txc.getVrednost_pogoja()).indexOf("session.get") == -1)
                                    {
                                        if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                        {
                                            if(!nul.jeNull(txc.getUporabi_kot_rezultat()).equals("1"))
                                            {
                                                if(!nul.jeNull(txc.getVrednost_pogoja()).equals(""))
                                                	if(!prvix)sb.append(("r=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("session.getAttribute", "session.geStAttribute").replaceAll("request.getParameter", "request.geetParameter").replaceAll("get", ("mod"+idnaprej+class1+".get")).replaceAll("nul.je", "nul.je").replaceAll("session.geStAttribute", "session.getAttribute").replaceAll("request.geetParameter", "request.getParameter")+")+\"\";\r\n\r\n"));
                                            } else
                                            if(nul.jeNull(txc.getVrednost_pogoja()).indexOf("[SIZE]") != -1)
                                            {
                                                String dodd = "";
                                                if(nul.jeNull(txc.getVrednost_pogoja()).length() > "[SIZE]".length())
                                                    dodd = nul.jeNull(txc.getVrednost_pogoja()).substring(nul.jeNull(txc.getVrednost_pogoja()).lastIndexOf("]") + 1, nul.jeNull(txc.getVrednost_pogoja()).length());
                                                if(!prvix)sb.append(("r=(remi"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".size() "+dodd+") + \"\";\r\n"));
                                            } else
                                            {
                                            	if(!prvix)sb.append(("r=("+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get"))+")+\"\";\r\n\r\n"));
                                            }
                                        } else
                                        {
                                        	if(!prvix)sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"").replaceAll("get", ("mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+".get"))+";\r\n\r\n"));
                                        }
                                    } else
                                    if(!nul.jeNull(txc.getUporabi_kot_neznanka()).equals("1"))
                                    	if(!prvix)sb.append(("r="+nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n"));
                                    else
                                    	if(!prvix)sb.append((nul.jeNull(txc.getVrednost_pogoja()).replaceAll("'", "\"")+";\r\n\r\n"));
                                    if(nul.jeNull(txc.getKot_rezultat_uporabi_prevod()).equals("1"))
                                    	if(!prvix)sb.append(("odg_funkcija=nul.jeNull(cx.getPrevod(\""+txc.getId()+"P\"+jz));\r\n"));
                                    else
                                    if(nul.jeNull(txc.getVrednost_pogoja()).equals(""));
                                }
                            }
                        } else
                        if(nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
                        	
                        	if(!prvix) {
                        		sb.append(("r=mod"+(classtip.equals("UP") ? idfunk : idnaprej)+class1+"."+tcv.getVrednost()+"()+\"\";\r\n\r\n"));
                        	}
                        	
                        }
                    } while(true);
            }
            
           // sb.append("}\r\n");
            sb.append("}//closed\r\n");
            System.out.println("-------------- a 17");
            if (jepogoj) {
            	if(!prvix)sb.append("}\r\n");
                	
            	
            }
            if(!prvix)sb.append("//============================6============================\r\n");

            
            
            System.out.println("====================x============ TIP fo pdf "+tipfo);
            System.out.println("====================x============ TIP fo pdf "+tipfo);
            System.out.println("====================x============ TIP fo pdf "+tipfo);
            System.out.println("====================x============ TIP fo pdf "+tipfo);
            System.out.println("====================x============ TIP fo pdf "+tipfo);
            
            if (tipfo==2) {
                celfo.append(this.genList_PDF_fo_end());
                }
                else if (tipfo==1) {
                	celfo.append(this.genViews_PDF_fo_end());
                }
            
            celfo.append(delfo.toString());
            
            retu[0] = sb.toString();
            retu[1] = celfo.toString();
            
         	if (temfo.toString().trim().equals("")) {
            	
            retu[2] = tsufo.toString();
         	}
         	else {
         		  retu[2] = temfo.toString();
         	}
            ze_crta=false;
            return retu;
            
            
            
        }
        catch(Exception en)
        {
            System.out.println(("Napaka loop gen funkcija: "+en.toString()));
        }
        System.out.println("-------------- a 18");
        return retu;
    }

    
    
    
    
    // konec xmlja se zapise na koncu funkcije
    private String konec_xml = "";
    
    
    
    
    /// get attributes format
    
    
    private String getAttributeFormat(String value,boolean addFoblock) {
    	
StringBuffer sbb = new StringBuffer();

sbb.append("<xsl:variable name=\"isprop\" select='nul:getIsPropFromFile("+value+")' />\r\n");


if (addFoblock) {
sbb.append("<fo:block>\r\n");
}
	sbb.append("<xsl:if test=\"$isprop='YES'\">\r\n");
sbb.append("<xsl:variable name=\"bgc\" select='nul:getPropFromFile(\"bgc\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"talign\" select='nul:getPropFromFile(\"talign\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"tcolor\" select='nul:getPropFromFile(\"tcolor\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"fweight\" select='nul:getPropFromFile(\"fweight\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"lheight\" select='nul:getPropFromFile(\"lheight\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"padding\" select='nul:getPropFromFile(\"padding\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"tpadding\" select='nul:getPropFromFile(\"tpadding\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"lpadding\" select='nul:getPropFromFile(\"lpadding\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"rpadding\" select='nul:getPropFromFile(\"rpadding\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"bpadding\" select='nul:getPropFromFile(\"bpadding\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"fsize\" select='nul:getPropFromFile(\"fsize\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"ffamily\" select='nul:getPropFromFile(\"ffamily\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"margin\" select='nul:getPropFromFile(\"margin\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"lmargin\" select='nul:getPropFromFile(\"lmargin\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"tmargin\" select='nul:getPropFromFile(\"tmargin\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"rmargin\" select='nul:getPropFromFile(\"rmargin\","+value+")' />\r\n");
sbb.append("<xsl:variable name=\"bmargin\" select='nul:getPropFromFile(\"bmargin\","+value+")' />\r\n");
sbb.append("<xsl:if test=\"$bgc!=''\">\r\n");
sbb.append("<xsl:attribute name=\"background-color\"><xsl:value-of select=\"$bgc\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$ffamily!=''\">\r\n");
sbb.append("<xsl:attribute name=\"font-family\"><xsl:value-of select=\"$ffamily\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$tcolor!=''\">\r\n");
sbb.append("<xsl:attribute name=\"text-color\"><xsl:value-of select=\"$tcolor\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$talign!=''\">\r\n");
sbb.append("<xsl:attribute name=\"text-align\"><xsl:value-of select=\"$talign\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$fweight!=''\">\r\n");
sbb.append("<xsl:attribute name=\"font-weight\"><xsl:value-of select=\"$fweight\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$lheight!=''\">\r\n");
sbb.append("<xsl:attribute name=\"line-height\"><xsl:value-of select=\"$lheight\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$padding!=''\">\r\n");
sbb.append("<xsl:attribute name=\"padding\"><xsl:value-of select=\"$padding\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$lpadding!=''\">\r\n");
sbb.append("<xsl:attribute name=\"padding-left\"><xsl:value-of select=\"$lpadding\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$tpadding!=''\">\r\n");
sbb.append("<xsl:attribute name=\"padding-top\"><xsl:value-of select=\"$tpadding\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$rpadding!=''\">\r\n");
sbb.append("<xsl:attribute name=\"padding-right\"><xsl:value-of select=\"$rpadding\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$bpadding!=''\">\r\n");
sbb.append("<xsl:attribute name=\"padding-bottom\"><xsl:value-of select=\"$bpadding\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$fsize!=''\">\r\n");
sbb.append("<xsl:attribute name=\"font-size\"><xsl:value-of select=\"$fsize\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$margin!=''\">\r\n");
sbb.append("<xsl:attribute name=\"margin\"><xsl:value-of select=\"$margin\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$lmargin!=''\">\r\n");
sbb.append("<xsl:attribute name=\"margin-left\"><xsl:value-of select=\"$lmargin\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$tmargin!=''\">\r\n");
sbb.append("<xsl:attribute name=\"margin-top\"><xsl:value-of select=\"$tmargin\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$rmargin!=''\">\r\n");
sbb.append("<xsl:attribute name=\"margin-right\"><xsl:value-of select=\"$rmargin\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:if test=\"$bmargin!=''\">\r\n");
sbb.append("<xsl:attribute name=\"margin-bottom\"><xsl:value-of select=\"$bmargin\"/></xsl:attribute>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("</xsl:if>\r\n");
sbb.append("<xsl:value-of select='nul:getPropFromFile(\"\","+value+")'/>&#160;");
    
if (addFoblock) {
	sbb.append("</fo:block>\r\n");
}


return sbb.toString();

    }
    
    
    
    
    
    
    
    /// get attributes values
    private String getPDF_properties(Long ids,String typee, ContextUtil contextUtil, ServletContext servletContext) {
    	
    	
    	try {
    		
    		TemplatePdfParametriDAO dao = (TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO", servletContext);
    		
    		TemplatePdfParametri tpp = dao.getTemplatePdfParametriByVezaIdType(ids, typee);
    		
    		/*
    		bgc char 25
    		talign char 6
    		tcolor char 25
    		fweight char 6
    		lheight char 6
    		padding char 6
    		tpadding char 6
    		lpadding char 6
    		rpadding char 6
    		bpadding char 6
    		fsize char 6
    		ffamily char 25
    		margin char 6
    		lmargin char 6
    		tmargin char 6
    		rmargin char 6
    		bmargin char 6*/
    		
    		
    		
    		///
    		String prope = "";
    		
    		if (tpp.getBgc()!=null && !tpp.getBgc().equals("")) {
    			prope += "bgc:::"+tpp.getBgc()+"--X|X--";
    		}
    		if (tpp.getTalign()!=null && !tpp.getTalign().equals("")) {
    			prope += "talign:::"+tpp.getTalign()+"--X|X--";
    		}
    		if (tpp.getTcolor()!=null && !tpp.getTcolor().equals("")) {
    			prope += "tcolor:::"+tpp.getTcolor()+"--X|X--";
    		}
    		if (tpp.getFweight()!=null && !tpp.getFweight().equals("")) {
    			prope += "fweight:::"+tpp.getFweight()+"--X|X--";
    		}
    		if (tpp.getLheight()!=null && !tpp.getLheight().equals("")) {
    			prope += "lheight:::"+tpp.getLheight()+"--X|X--";
    		}
    		if (tpp.getPadding()!=null && !tpp.getPadding().equals("")) {
    			prope += "padding:::"+tpp.getPadding()+"--X|X--";
    		}
    		if (tpp.getTpadding()!=null && !tpp.getTpadding().equals("")) {
    			prope += "tpadding:::"+tpp.getTpadding()+"--X|X--";
    		}
    		if (tpp.getLpadding()!=null && !tpp.getLpadding().equals("")) {
    			prope += "lpadding:::"+tpp.getLpadding()+"--X|X--";
    		}
    		if (tpp.getRpadding()!=null && !tpp.getRpadding().equals("")) {
    			prope += "rpadding:::"+tpp.getRpadding()+"--X|X--";
    		}
    		if (tpp.getBpadding()!=null && !tpp.getBpadding().equals("")) {
    			prope += "bpadding:::"+tpp.getBpadding()+"--X|X--";
    		}
    		if (tpp.getFsize()!=null && !tpp.getFsize().equals("")) {
    			prope += "fsize:::"+tpp.getFsize()+"--X|X--";
    		}
    		if (tpp.getFfamily()!=null && !tpp.getFfamily().equals("")) {
    			prope += "ffamily:::"+tpp.getFfamily()+"--X|X--";
    		}
    		if (tpp.getMargin()!=null && !tpp.getMargin().equals("")) {
    			prope += "margin:::"+tpp.getMargin()+"--X|X--";
    		}
    		if (tpp.getLmargin()!=null && !tpp.getLmargin().equals("")) {
    			prope += "lmargin:::"+tpp.getLmargin()+"--X|X--";
    		}
    		if (tpp.getTmargin()!=null && !tpp.getTmargin().equals("")) {
    			prope += "tmargin:::"+tpp.getTmargin()+"--X|X--";
    		}
    		if (tpp.getRmargin()!=null && !tpp.getRmargin().equals("")) {
    			prope += "rmargin:::"+tpp.getRmargin()+"--X|X--";
    		}
    		if (tpp.getBmargin()!=null && !tpp.getBmargin().equals("")) {
    			prope += "bmargin:::"+tpp.getBmargin()+"--X|X--";
    		}
    		
    		return prope;
    		
    		
    		
    		
    		
    	}
    	catch (Exception ec) {
    		System.out.println("Error getting properties from templatepdfparametri : "+ec.toString());
    	}
    	
    	return "";
    	
    }
    
    
    
    private String genViews_PDF_count(TemplateFunkcijaStart tui, String idfunkcije, String class1, ContextUtil contextUtil, ServletContext servletContext)
    {
        StringBuffer sb;
        String headerform;
label0:
        {
            sb = new StringBuffer();
            sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
            sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
            sb.append(("Iterator itx"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
            sb.append(("com.popultrade.model."+class1+" mod"+idfunkcije+""+class1+"=new com.popultrade.model."+class1+"();\r\n"));
            sb.append(("while (itx"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
            sb.append(("com.popultrade.model."+tui.getClass_name()+"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")(itx"+idfunkcije+class1+".next());\r\n"));
            Iterator ie = tui.getTemplateviews().iterator();
            do
            {
                if(!ie.hasNext())
                    break;
                TemplateView tw = (TemplateView)ie.next();
                if(nul.jeNull(tw.getTip_sestevka()).equals("COUNT"))
                    sb.append(("mod"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n"));
                else
                if(nul.jeNull(tw.getTip_sestevka()).equals("SUM"))
                    sb.append(("mod"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?mod"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+(modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0));\r\n"));
            } while(true);
            sb.append("}  // while end\r\n");
            sb.append(("cy.a(\"<header"+idfunkcije+">\");\r\n"));
            replaceHeaders+=("<header"+idfunkcije+"></header"+idfunkcije+">"+"--X--");
            sb.append("String cosmi = \"\";\r\n");
            sb.append("%////>\r\n");
            Iterator wie = tui.getTemplateviews().iterator();
         //   headerform = "";
            boolean preskoci;
            do
            {
                System.out.println("sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss wie");
                preskoci = false;
                if(!wie.hasNext())
                    break label0;
                TemplateView tw = (TemplateView)wie.next();
                if(tw.getPdf_header() != null && tw.getPdf_header().equals("1"))
                {
                    String rei = "";
                    sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                    sb.append("<////%\r\n");
                    sb.append(("cosmi=\"<naslov><opis>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</opis><vrednost>\"+r+\"</vrednost></naslov>\";\r\n"));
                    sb.append("r=\"\";\r\n");
                   
                    sb.append("%////>\r\n");
                    preskoci = true;
                } else
                if(tw.getTip_polja().equals("PR"))
                {
                    sb.append("<////%\r\n");
                    sb.append(("cy.a(\"<par><ay>PR</ay><a1>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a1><a2></a2>\");\r\n"));
                    sb.append("r=\"\";\r\n");
                    sb.append("%////>\r\n");
                } else
                {
                    String rei = "";
                    sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                    sb.append("<////%\r\n");
                    sb.append(("cy.a(\"<par><ay>PU</ay><a1>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a1><a2>\"+r+\"</a2>\");\r\n"));
                    sb.append("r2=\"\";\r\n");
                    sb.append("r=\"\";\r\n");
                    sb.append("%////>\r\n");
                }
                if(!wie.hasNext())
                    break;
                tw = (TemplateView)wie.next();
                if(!preskoci)
                    if(tw.getTip_polja().equals("PR"))
                    {
                        sb.append("<////%\r\n");
                        sb.append("cy.a(\"<a3></a3><a4></a4><ax>PR</ax></par>\");\r\n");
                        sb.append("%////>\r\n");
                    } else
                    {
                        String rei = "";
                        sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                        sb.append("<////%\r\n");
                        sb.append(("cy.a(\"<a3>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz)+\"</a3><a4>\"+r+\"</a4><ax>PU</ax></par>\");\r\n"));
                        sb.append("r2=\"\";\r\n");
                        sb.append("r=\"\";\r\n");
                        sb.append("%////>\r\n");
                    }
            } while(true);
            if(!preskoci)
            {
                sb.append("<////%\r\n");
                sb.append("cy.a(\"<a3></a3><a4></a4><ax>PR</ax></par>\");\r\n");
                sb.append("%////>\r\n");
            }
        }
        sb.append("<////%\r\n");
        sb.append("//////DOME0//////\r\n");
        
        
        
        konec_xml+=("cy.a(\"</header"+idfunkcije+">\");\r\n");
        konec_xml+=("cy.a(cosmi);\r\n");
        konec_xml+=("}\r\n");
        
     /*   sb.append(("cy.a(\"</header"+idfunkcije+">\");\r\n"));
        sb.append("cy.a(cosmi);\r\n");
     //   sb.append(headerform);
        sb.append("}\r\n");*/
        
        
        
        return sb.toString();
    }

    private String genViews_PDF(TemplateFunkcijaStart tui, String idfunkcije, String class1, boolean jecount, ContextUtil contextUtil, ServletContext servletContext, String classtip)
    {
        StringBuffer sb;
        String headerform;
label0:
        {
            sb = new StringBuffer();
            TemplateViewDAO dao = (TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO", servletContext);
            TemplateView sif = new TemplateView();
            sif.setTemplatehead_id(tui.getId());
            List lie = dao.getTemplateViews(sif);
            if(!jecount)
            {
                sb.append(("Iterator itremi"+idfunkcije+""+class1+" = remi"+idfunkcije+""+class1+".iterator();\r\n"));
            } else
            {
                sb.append(("Iterator itx"+idfunkcije+class1+" = remi"+idfunkcije+class1+".iterator();\r\n\r\n"));
                sb.append(("com.popultrade.model."+class1+" modoo"+idfunkcije+""+class1+"=new com.popultrade.model."+class1+"();\r\n"));
                sb.append(("while (itx"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
                sb.append(("com.popultrade.model."+tui.getClass_name()+"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")(itx"+idfunkcije+class1+".next());\r\n"));
                Iterator ie = lie.iterator();
                do
                {
                    if(!ie.hasNext())
                        break;
                    TemplateView tw = (TemplateView)ie.next();
                    if(nul.jeNull(tw.getTip_sestevka()).equals("COUNT"))
                        sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n"));
                    else
                    if(nul.jeNull(tw.getTip_sestevka()).equals("SUM"))
                        sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+(modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0));\r\n"));
                } while(true);
                sb.append("}  // while end\r\n");
                sb.append(("List lik"+idfunkcije+""+class1+" = new ArrayList();  // array list\r\n"));
                sb.append(("lik"+idfunkcije+""+class1+".add(modoo"+idfunkcije+class1+");\r\n"));
                sb.append(("Iterator itremi"+idfunkcije+""+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n"));
            }
           // sb.append("String r2=\"\";\r\n");
          ////  if(classtip.equals("LI") || classtip.equals("CO"))
         ////   {
                sb.append(("while (itremi"+idfunkcije+""+class1+".hasNext()) {\r\n"));
                sb.append(("mod"+idfunkcije+""+class1+"=(com.popultrade.model."+class1+")itremi"+idfunkcije+""+class1+".next();\r\n"));
          /*  } else
            {
                sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
                sb.append(("mod"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")remi"+idfunkcije+class1+".get(0);\r\n"));
            }*/
            sb.append(("cy.a(\"<header"+idfunkcije+">\");\r\n"));
            
            replaceHeaders+=("<header"+idfunkcije+"></header"+idfunkcije+">"+"--X--");
            sb.append("String cosmi = \"\";\r\n");
            sb.append("%////>\r\n");
            Iterator wie = lie.iterator();
          //  headerform = "";
            String pogojvrs = "";
            boolean preskoci;
            do
            {
                System.out.println("sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss wie");
                pogojvrs = "";
                preskoci = false;
                if(!wie.hasNext()){
                    break label0;
            }
                TemplateView tw = (TemplateView)wie.next();
                if(tw.getTemplateuidodatno() != null && !nul.jeNull(tw.getTemplateuidodatno().getDodatno_java()).equals("")){
                    pogojvrs = tw.getTemplateuidodatno().getDodatno_java().replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("'", "\"");
                
                
            }
                
                String slik = "";
                if(nul.jeNull(tw.getJeslika()).equals("1"))
                    slik = ("<slik>1</slik>"+(nul.jeNull((tw.getSlika_width()+"")).equals("") || tw.getSlika_width().intValue() <= 0 ? "<w></w>" : ("<w>"+tw.getSlika_width()+"pt</w>"))+(nul.jeNull((tw.getSlika_height()+"")).equals("") || tw.getSlika_height().intValue() <= 0 ? "<h></h>" : ("<h>"+tw.getSlika_height()+"pt</h>")));
                else
                    slik = "<slik>0</slik>";
                if(tw.getPdf_header() != null && tw.getPdf_header().equals("1"))
                {
                    String rei = "";
                    sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                    sb.append(nextTO(tw, idfunkcije, class1,contextUtil,servletContext));
                    sb.append("<////%\r\n");
                    sb.append(("cosmi=\"<naslov><opis>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</opis><vrednost>\"+"+(nul.jeNull(tw.getJeslika()).equals("1") ? ("control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+r") : "r")+"+\"</vrednost></naslov>\";\r\n"));
                    sb.append("r=\"\";\r\n");
                    sb.append("%////>\r\n");
                    preskoci = true;
                } else
                if(tw.getTip_polja().equals("PR"))
                {
                    sb.append("<////%\r\n");
                    sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                    sb.append(("cy.a(\"<par>"+slik+"<ay>PR</ay><a1>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a1><a2></a2>\");\r\n"));
                    sb.append(pogojvrs.equals("") ? "" : "}");
                    sb.append("%////>\r\n");
                } else
                {
                    String rei = "";
                    sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                    sb.append(nextTO(tw, idfunkcije, class1,contextUtil,servletContext));
                    sb.append("<////%\r\n");
                    sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                    sb.append(("cy.a(\"<par>"+slik+"<ay>PU</ay><a1>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a1><a2>\"+"+(nul.jeNull(tw.getJeslika()).equals("1") ? ("control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+r") : "r")+"+\"</a2>\");\r\n"));
                    sb.append(pogojvrs.equals("") ? "" : "}");
                    sb.append("r2=\"\";\r\n");
                    sb.append("r=\"\";\r\n");
                    sb.append("%////>\r\n");
                }
                if(!wie.hasNext())
                    break;
                tw = (TemplateView)wie.next();
                slik = "";
                if(nul.jeNull(tw.getJeslika()).equals("1"))
                    slik = ("<slik2>1</slik2>"+(nul.jeNull((tw.getSlika_width()+"")).equals("") || tw.getSlika_width().intValue() <= 0 ? "<w></w>" : ("<w>"+tw.getSlika_width()+"pt</w>"))+(nul.jeNull((tw.getSlika_height()+"")).equals("") || tw.getSlika_height().intValue() <= 0 ? "<h></h>" : ("<h>"+tw.getSlika_height()+"pt</h>")));
                else
                    slik = "<slik2>0</slik2>";
                if(!preskoci)
                    if(tw.getTip_polja().equals("PR"))
                    {
                        sb.append("<////%\r\n");
                        sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                        sb.append(("cy.a(\"<a3>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a3><a4></a4><ax>PR</ax>"+slik+"</par>\");\r\n"));
                        sb.append(pogojvrs.equals("") ? "" : "}");
                        sb.append("%////>\r\n");
                    } else
                    {
                        String rei = "";
                        sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                        sb.append(nextTO(tw, idfunkcije, class1,contextUtil,servletContext));
                        sb.append("<////%\r\n");
                        sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                        sb.append(("cy.a(\"<a3>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a3><a4>\"+"+(nul.jeNull(tw.getJeslika()).equals("1") ? ("control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+r") : "r")+"+\"</a4><ax>PU</ax>"+slik+"</par>\");\r\n"));
                        sb.append(pogojvrs.equals("") ? "" : "}");
                        sb.append("r=\"\";\r\n");
                        sb.append("r2=\"\";\r\n");
                        sb.append("%////>\r\n");
                    }
            } while(true);
            if(!preskoci)
            {
                sb.append("<////%\r\n");
                sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                sb.append("cy.a(\"<a3></a3><a4></a4><ax>PR</ax><slik2>0</slik2></par>\");\r\n");
                sb.append(pogojvrs.equals("") ? "" : "}");
                sb.append("%////>\r\n");
            }
        }
        sb.append("<////%\r\n");
        
        
        sb.append("//////DOME0//////\r\n");
        
        konec_xml+=("cy.a(cosmi);\r\n");
        konec_xml+=("cy.a(\"</header"+idfunkcije+">\");\r\n");
        
        konec_xml+=("}\r\n");
        
        /*
        sb.append("cy.a(cosmi);\r\n");
        sb.append(("cy.a(\"</header"+idfunkcije+">\");\r\n"));
      //  sb.append(headerform);
        sb.append("}\r\n");*/
        return sb.toString();
    }

    private String[] genViews_PDF2(TemplateClassClass tui, String idfunkcije, String class1, boolean jecount, ContextUtil contextUtil, ServletContext servletContext)
    {
        StringBuffer sb;
label0:
        {
            sb = new StringBuffer();
            TemplateViewDAO dao = (TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO", servletContext);
            TemplateView sif = new TemplateView();
            sif.setTemplatehead_id(tui.getId());
            List lie = dao.getTemplateViews(sif);
            //sb.append(("//XXXXXXXXXXXXXXXXXXXXXXXXXXXX PDF views 2"));
            System.out.println("////////////////////////////////////////////////////////////xxxxxxxxxx");
            System.out.println("////////////////////////////////////////////////////////////xxxxxxxxxxxxx");
            if(!jecount)
            {
                sb.append(("Iterator itremi"+idfunkcije+""+class1+" = remi"+idfunkcije+""+class1+".iterator();\r\n"));
            } else
            {
                sb.append(("Iterator itx"+idfunkcije+class1+" = remi"+idfunkcije+class1+".iterator();\r\n\r\n"));
                sb.append(("com.popultrade.model."+class1+" modoo"+idfunkcije+""+class1+"=new com.popultrade.model."+class1+"();\r\n"));
                sb.append(("while (itx"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
                sb.append(("com.popultrade.model."+tui.getClass_name()+"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")(itx"+idfunkcije+class1+".next());\r\n"));
                Iterator ie = lie.iterator();
                do
                {
                    if(!ie.hasNext())
                        break;
                    TemplateView tw = (TemplateView)ie.next();
                    if(nul.jeNull(tw.getTip_sestevka()).equals("COUNT"))
                        sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n"));
                    else
                    if(nul.jeNull(tw.getTip_sestevka()).equals("SUM"))
                        sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+(modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0));\r\n"));
                } while(true);
                sb.append("}  // while end\r\n");
                sb.append(("List lik"+idfunkcije+""+class1+" = new ArrayList();  // array list\r\n"));
                sb.append(("lik"+idfunkcije+""+class1+".add(modoo"+idfunkcije+class1+");\r\n"));
                sb.append(("Iterator itremi"+idfunkcije+""+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n"));
            }
            sb.append(("while (itremi"+idfunkcije+""+class1+".hasNext()) {\r\n"));
            sb.append(("mod"+idfunkcije+""+class1+"=(com.popultrade.model."+class1+")itremi"+idfunkcije+""+class1+".next();\r\n"));
            sb.append(("cy.a(\"<header"+idfunkcije+">\");\r\n"));
            
            replaceHeaders+=("<header"+idfunkcije+"></header"+idfunkcije+">"+"--X--");
            
            sb.append("%////>\r\n");
            Iterator wie = lie.iterator();
            String pogojvrs = "";
            do
            {
                System.out.println("sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss wie");
                pogojvrs = "";
                if(!wie.hasNext())
                    break label0;
                TemplateView tw = (TemplateView)wie.next();
                if(tw.getTemplateuidodatno() != null && !nul.jeNull(tw.getTemplateuidodatno().getDodatno_java()).equals(""))
                    pogojvrs = tw.getTemplateuidodatno().getDodatno_java().replaceAll("get", ("mod"+idfunkcije+class1+".get")).replaceAll("'", "\"");
                String slik = "";
                if(nul.jeNull(tw.getJeslika()).equals("1"))
                    slik = ("<slik>1</slik>"+(nul.jeNull((tw.getSlika_width()+"")).equals("") || tw.getSlika_width().intValue() <= 0 ? "<w></w>" : ("<w>"+tw.getSlika_width()+"pt</w>"))+(nul.jeNull((tw.getSlika_height()+"")).equals("") || tw.getSlika_height().intValue() <= 0 ? "<h></h>" : ("<h>"+tw.getSlika_height()+"pt</h>")));
                else
                    slik = "<slik>0</slik>";
                if(tw.getTip_polja().equals("PR"))
                {
                    sb.append("<////%\r\n");
                    sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                    sb.append(("cy.a(\"<par>"+slik+"<ay>PR</ay><a1>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a1><a2></a2>\");\r\n"));
                    sb.append(pogojvrs.equals("") ? "" : "}");
                    sb.append("%////>\r\n");
                } else
                {
                    String rei = "";
                    sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                    sb.append(nextTO(tw, idfunkcije, class1,contextUtil,servletContext));
                    sb.append("<////%\r\n");
                    sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                    sb.append(("cy.a(\"<par>"+slik+"<ay>PU</ay><a1>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a1><a2>\"+"+(nul.jeNull(tw.getJeslika()).equals("1") ? ("control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+r") : "r")+"+\"</a2>\");\r\n"));
                    sb.append(pogojvrs.equals("") ? "" : "}");
                    sb.append("r2=\"\";\r\n");
                    sb.append("r=\"\";\r\n");
                    sb.append("%////>\r\n");
                }
                if(!wie.hasNext())
                    break;
                tw = (TemplateView)wie.next();
                slik = "";
                if(nul.jeNull(tw.getJeslika()).equals("1"))
                    slik = "<slik2>1</slik2>";
                else
                    slik = "<slik2>0</slik2>";
                if(tw.getTip_polja().equals("PR"))
                {
                    sb.append("<////%\r\n");
                    sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                    sb.append(("cy.a(\"<a3>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a3><a4></a4><ax>PR</ax>"+slik+"</par>\");\r\n"));
                    sb.append(pogojvrs.equals("") ? "" : "}");
                    sb.append("%////>\r\n");
                } else
                {
                    String rei = "";
                    sb.append(getFieldHead(rei, tw, (idfunkcije+""+class1),contextUtil,servletContext));
                    sb.append(nextTO(tw, idfunkcije, class1,contextUtil,servletContext));
                    sb.append("<////%\r\n");
                    sb.append(pogojvrs.equals("") ? "" : pogojvrs);
                    sb.append(("cy.a(\"<a3>\"+\""+(getPDF_properties(tw.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tw.getId()+"P\"+jz) +\"</a3><a4>\"+"+(nul.jeNull(tw.getJeslika()).equals("1") ? ("control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+r") : "r")+"+\"</a4><ax>PU</ax>"+slik+"</par>\");\r\n"));
                    sb.append(pogojvrs.equals("") ? "" : "}");
                    sb.append("r2=\"\";\r\n");
                    sb.append("r=\"\";\r\n");
                    sb.append("%////>\r\n");
                }
            } while(true);
            sb.append("<////%\r\n");
            sb.append(pogojvrs.equals("") ? "" : pogojvrs);
            sb.append("cy.a(\"<a3>&#160;</a3><a4></a4><ax>PR</ax><slik2>0</slik2></par>\");\r\n");
            sb.append(pogojvrs.equals("") ? "" : "}");
            sb.append("%////>\r\n");
        }
        sb.append("<////%\r\n");
        
        StringBuffer sbn = new StringBuffer();
     
        sbn.append(("cy.a(\"</header"+idfunkcije+">\");\r\n"));
        sbn.append("}\r\n");
        
        String[] ret = {sb.toString(),("r=\"\";\r\n")+("//////DOME"+idfunkcije+"//////\r\n"),sbn.toString()};
        
        return ret;
    }

    
    private void setVezavo(StringBuffer sb, StringBuffer sbfo,int whole_zapp,String idfunkcije) {

        int replo = 0;
        if (whole_ht.containsKey(whole_zapp+"")) {
        	replo =Integer.parseInt(whole_ht.get(whole_zapp+"")+"");
        	System.out.println("ZE OBSTAJA  32 ---:: "+replo);
        }
        else {
        	if (whole_i!=0) {
        	replo = whole_i;
        	
        	}
        	else {
        		replo = whole_zapp-1;
        	}
        }
    	
    	 String whole = whole_fo.toString();
    	 System.out.println("MENJAM ::: "+idfunkcije +" z "+whole_zapp);
    	 System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC 2 ::: <!--DODAJXX"+replo+"-->" + " --- "+"<!--DODAJXX"+replo+"-->");
         
         if (whole.indexOf("<!--DODAJXX"+replo+"-->")!=-1) {
         	 System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC  2 ::: <!--DODAJXX"+replo+"-->");
         	whole=whole.replace("<!--DODAJXX"+replo+"-->", sb.toString()+"<!--DODAJXX"+replo+"-->");
         	
         }
         else {
        	 whole_fo_template.append(sb.toString());
        }
         if (whole.indexOf("<!--SPODAJ"+whole_zapp+"-->")!=-1) {
        	 System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC  s2 ::: <!--SPODAJ"+(whole_zapp)+"-->");
         	whole=whole.replace("<!--SPODAJ"+(whole_zapp)+"-->", sbfo.toString()+"<!--SPODAJ"+(whole_zapp)+"-->");
         	
         }
         else {
        	 whole= whole+sbfo.toString();
         }
         whole_fo.delete(0, whole_fo.length());
         whole_fo.append(whole);
         
       	if (whole_i!=0) {
      		if (!whole_ht.containsKey(whole_zapp+"")) {
     	      whole_ht.put(whole_zapp+"", (whole_zapp-1)+"");
     	      System.out.println("PUT :: "+whole_zapp+ " :: "+(whole_zapp-1));
      		}
     	      
     	}
     	else {
     		if (!whole_ht.containsKey(whole_zapp+"")) {
     		whole_ht.put(whole_zapp+"", (whole_zapp-1)+"");
     		
     		System.out.println("PUT :: "+whole_zapp+ " :: "+(whole_zapp-1));
     		}
     	}
       	
       	
       	whole_i = whole_zapp;
       	
    }
    
    
    private void setEmpty_PDF_fo(int whole_zapp) {
    	
    	
    //	if (!whole_ht.contains(whole_zapp)) {
    	
    	
    	
    	
        StringBuffer sb = new StringBuffer();
        StringBuffer sbfo = new StringBuffer();
        sb.append(("<!--DODAJXX"+whole_zapp+"-->"));
    sbfo.append("<!--SPODAJ"+whole_zapp+"-->\r\n");
        
        
        int replo = 0;
        if (whole_ht.containsKey(whole_zapp+"")) {
        	replo =Integer.parseInt(whole_ht.get(whole_zapp+"")+"");
        	
        }
        else {
        	if (whole_i!=0) {
        	replo = whole_i;
        	
        	}
        	else {
        		replo = whole_zapp-1;
        	}
        }
    	
    	 String whole = whole_fo.toString();
         
    	 System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC 23 ::: <!--SPODAJ"+replo+"-->" + " --- "+whole_zapp);
         
         if (whole.indexOf("<!--DODAJXX"+replo+"-->")!=-1) {
         	 System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC  233 ::: <!--DODAJXX"+replo+"-->");
         	whole=whole.replace("<!--DODAJXX"+replo+"-->", sb.toString()+"<!--DODAJXX"+replo+"-->");
         	
         }
         else {
        	 whole_fo_template.append(sb.toString());
        }
         if (whole.indexOf("<!--SPODAJ"+whole_zapp+"-->")!=-1) {
        	 System.out.println("ISCCCCCCCCCCCCCCCCCCCCCC 24 ::: <!--SPODAJ"+replo+"-->" + " --- "+whole_zapp);
         	whole=whole.replace("<!--SPODAJ"+(whole_zapp)+"-->", sbfo.toString()+"<!--SPODAJ"+(whole_zapp)+"-->");
         	
         }
         else {
        	 whole= whole+sbfo.toString();
         }
         
         
         
         whole_fo.delete(0, whole_fo.length());
         whole_fo.append(whole);
         
      	if (whole_i!=0) {
     		if (!whole_ht.containsKey(whole_zapp+"")) {
    	      whole_ht.put(whole_zapp+"", (whole_zapp-1)+"");
    	      System.out.println("PUT :: "+whole_zapp+ " :: "+whole_i);
     		}
    	      
    	}
    	else {
    		if (!whole_ht.containsKey(whole_zapp+"")) {
    		whole_ht.put(whole_zapp+"", (whole_zapp-1)+"");
    		
    		System.out.println("PUT :: "+whole_zapp+ " :: "+(whole_zapp-1));
    		}
    	}
         whole_i = whole_zapp;
         
         
    	/*}
    	else {
    		System.out.println("ZE OBSTAJA ---:: "+whole_zapp);
    	}*/
         
        
    }
    
  
    
    
    private String[] genViews_PDF_fo(String idfunkcije, String kje, TemplatePdfParametri tpar,boolean naslov,int whole_zapp)
    {
    	
    
    	
    	
    	
    	
        if(tpar == null){
            tpar = new TemplatePdfParametri();
    }
        StringBuffer sb = new StringBuffer();
        StringBuffer sbfo = new StringBuffer();
        if(kje == "1" )
        {
            sb.append(("<xsl:apply-templates select=\"//header"+idfunkcije+"\"/>"));
            if (naslov) {
            sbfo.append("<xsl:template match=\"naslov\">\r\n");
            sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"  "+(nul.jeNull(tpar.getMargin_bottom()).equals("") ? "margin-bottom=\"20\"" : "margin-bottom=\""+tpar.getMargin_bottom()+"\"")+"  "+(nul.jeNull(tpar.getPdf_header_width()).equals("1") ? "font-weight=\"bold\"" : "")+" text-align=\"center\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getPdf_header_font_size()).equals("") ? "16" : ((Object) (Integer.valueOf(Integer.parseInt(nul.jeNull(tpar.getPdf_header_font_size())) + 2))))+"pt\" font-size=\""+(nul.jeNull(tpar.getPdf_header_font_size()).equals("") ? "10" : nul.jeNull(tpar.getPdf_header_font_size()))+"pt\"  padding-top=\"3.5pt\">"+"<xsl:value-of select=\".\"/>"+"</fo:block> </xsl:template>"));
            }
            sbfo.append(("<xsl:template match=\"header"+idfunkcije+"\">\r\n"));
            sbfo.append("<xsl:param name=\"amo\" select=\"par\"/>\r\n");
            sbfo.append("<xsl:apply-templates select=\"naslov\"/>\r\n");
            
            
        } else
        {
            sb.append(("<xsl:apply-templates select=\"header"+idfunkcije+"\"/>"));
            sbfo.append(("<xsl:template match=\"header"+idfunkcije+"\">\r\n"));
            sbfo.append("<xsl:param name=\"amo\" select=\"par\"/>\r\n");
        }
        sbfo.append("<fo:table  "+(nul.jeNull(tpar.getMargin_top()).trim().equals("") ? "":"margin-top=\""+tpar.getMargin_top()+"\"")+"  "+(nul.jeNull(tpar.getPdf_list_okvir()).equals("1") ? "border-width=\"0.5pt\"":"border-width=\"0.5pt\"")+" border-style=\"solid\"   border-collapse=\"separate\"   "+(nul.jeNull(tpar.getPdf_list_okvir()).equals("1") ? "border-color=\"black\"" : "border-color=\"white\"")+"   padding=\""+(nul.jeNull(tpar.getPdf_header_padding()).equals("") ? "2":tpar.getPdf_header_padding())+"pt\" border-separation=\""+(nul.jeNull(tpar.getPdf_header_spacing()).equals("") ? "1":tpar.getPdf_header_spacing())+"pt\" >\r\n");
        sbfo.append(("<fo:table-column column-width=\""+(nul.jeNull(tpar.getPdf_cell_width_prevod()).equals("") ? "38" : nul.jeNull(tpar.getPdf_cell_width_prevod()))+"mm\"/>\r\n"));
        sbfo.append(("<fo:table-column column-width=\""+(nul.jeNull(tpar.getPdf_cell_width_value()).equals("") ? "65" : nul.jeNull(tpar.getPdf_cell_width_value()))+"mm\"/>\r\n"));
        sbfo.append(("<fo:table-column column-width=\""+(nul.jeNull(tpar.getPdf_cell_width_prevod()).equals("") ? "38" : nul.jeNull(tpar.getPdf_cell_width_prevod()))+"mm\"/>\r\n")); 
        sbfo.append(("<fo:table-column column-width=\""+(nul.jeNull(tpar.getPdf_cell_width_value()).equals("") ? "55" : nul.jeNull(tpar.getPdf_cell_width_value()))+"mm\"/>\r\n"));
        sbfo.append("<fo:table-body>\r\n");

        	
        	sbfo.append("<fo:table-row><fo:table-cell number-columns-spanned=\"4\"><fo:block></fo:block></fo:table-cell></fo:table-row>\r\n");
        	
    
        sbfo.append("<xsl:for-each select=\"$amo\">\r\n");
        sbfo.append("<xsl:if test=\"ax='PU' and ay='PU'\">\r\n");
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\" padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\">\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"       >\r\n"));
       // sbfo.append("<xsl:value-of select=\"a1\"/>\r\n");
        
        sbfo.append( getAttributeFormat("a1",false));
        
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\" padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"     border-style=\"solid\" border-color=\"white\">\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  linefeed-treatment=\"preserve\" font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\" text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_width()).equals("1") ? "font-weight=\"bold\"" : "")+">\r\n"));
        sbfo.append(genViews_PDF_fo_slike("", "a2"));
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\">\r\n");
        sbfo.append(("<fo:block   letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"  >\r\n"));
       // sbfo.append("<xsl:value-of select=\"a3\"/>\r\n");
        sbfo.append( getAttributeFormat("a3",false));
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\" border-style=\"solid\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"   border-color=\"white\">\r\n");
        sbfo.append(("<fo:block   letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  linefeed-treatment=\"preserve\" font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_width()).equals("1") ? "font-weight=\"bold\"" : "")+">\r\n"));
        sbfo.append(genViews_PDF_fo_slike("2", "a4"));
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("<xsl:if test=\"ay='PU' and ax='PR'\">\r\n");
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\">\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"   font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"        >\r\n"));
        
        
        //sbfo.append("<xsl:value-of select=\"a1\"/>\r\n");
        sbfo.append( getAttributeFormat("a1",false));
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"   border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"3\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"   linefeed-treatment=\"preserve\" font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\" text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_width()).equals("1") ? "font-weight=\"bold\"" : "")+">\r\n"));
        sbfo.append(genViews_PDF_fo_slike("", "a2"));
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("<xsl:if test=\"ay='PR' and ax='PR'\">\r\n");
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append("<xsl:if test=\"a1!='' and a3=''\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\" padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"4\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"    >\r\n"));
       // sbfo.append("<xsl:value-of select=\"a1\"/>&#160;\r\n");
        sbfo.append( getAttributeFormat("a1",false));
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("<xsl:if test=\"a1='' and a3!=''\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"   border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"2\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\" text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"       >\r\n"));
        sbfo.append("&#160;\r\n");
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\"  border-color=\"white\" number-columns-spanned=\"2\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"         >\r\n"));
      //  sbfo.append("<xsl:value-of select=\"a3\"/>&#160;\r\n");
        sbfo.append( getAttributeFormat("a3",false));
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("<xsl:if test=\"a1='' and a3=''\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"4\" >\r\n");
        sbfo.append(("<fo:block   letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"       >\r\n"));
        sbfo.append("&#160;\r\n");
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("<xsl:if test=\"a1!='' and a3!=''\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"2\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"     >\r\n"));
       // sbfo.append("<xsl:value-of select=\"a1\"/>&#160;\r\n");
        sbfo.append( getAttributeFormat("a1",false));
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"   border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"2\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"   font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"       >\r\n"));
      //  sbfo.append("<xsl:value-of select=\"a3\"/>&#160;\r\n");
        sbfo.append( getAttributeFormat("a3",false));
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("<xsl:if test=\"ay='PR' and ax='PU'\">\r\n");
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append("<xsl:if test=\"a1!=''\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"2\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"   padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"     >\r\n"));
      //  sbfo.append("<xsl:value-of select=\"a1\"/>&#160;\r\n");
        sbfo.append( getAttributeFormat("a1",false));
        
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("<xsl:if test=\"a1=''\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    border-style=\"solid\" border-color=\"white\" number-columns-spanned=\"2\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\" font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\" text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"       >\r\n"));
        sbfo.append("&#160;\r\n");
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        
        sbfo.append("</xsl:if>\r\n");
        
        
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"    "+(nul.jeNull(tpar.getPdf_header_bgcolor_prevod()).equals("") ? "" : ("background-color=\"#"+tpar.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\">\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_size_prevod_width()).equals("1") ? "font-weight=\"bold\"" : "")+"     >\r\n"));
       // sbfo.append("<xsl:value-of select=\"a3\"/>\r\n");
        sbfo.append( getAttributeFormat("a3",false));
        
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpar.getPadding()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding()))+"pt\"   border-style=\"solid\" border-color=\"white\" >\r\n");
        sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpar.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpar.getPadding_top()))+"pt\"  linefeed-treatment=\"preserve\" font-size=\""+(nul.jeNull(tpar.getPdf_font_size()).equals("") ? "8" : nul.jeNull(tpar.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpar.getLine_height()).equals("") ? "10" : tpar.getLine_height())+"pt\"  text-align=\"left\" "+(nul.jeNull(tpar.getPdf_font_width()).equals("1") ? "font-weight=\"bold\"" : "")+">\r\n"));
        sbfo.append(genViews_PDF_fo_slike("2", "a4"));
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:if>\r\n");
        sbfo.append("</xsl:for-each>\r\n");
        sbfo.append("</fo:table-body>\r\n");
        sbfo.append("</fo:table>\r\n");
        
        
        sbfo.append(("<!--DODAJ"+idfunkcije+"-->"));
       // sbfo.append(("<!--DODAJ"+idfunkcije+"-->"));
        sbfo.append(("<!--DODAJXX"+(whole_zapp)+"-->"));
        
        if(nul.jeNull(tpar.getUporabi_page_break()).equals("1")){
            sbfo.append("<fo:block  break-after=\"page\"></fo:block>\r\n");
    }
        
      //  sbfo.append("</xsl:template>\r\n");
        
        sbfo.append("<!--SPODAJ"+whole_zapp+"-->\r\n");
        
     //   setVezavo( sb,  sbfo, whole_zapp, idfunkcije);
       // whole_i = whole_zapp;
        
        
        String ruk[] = new String[2];
        ruk[0] = sb.toString();
        ruk[1] = sbfo.toString();
        return ruk;
    }
    
    
    
    private String genViews_PDF_fo_end() {
    	return "</xsl:template>\r\n";
    }
    
    
    
    
    

    private String genViews_PDF_fo_slike(String slik, String vrednost)
    {
        String rett = "";
        rett = (rett+"<xsl:if test=\"slik"+slik+"='0'\">\r\n");
        if(vrednost.equals("a2") || vrednost.equals("a4"))
        {
            rett = (rett+"<xsl:if test=\"count("+vrednost+"/bre)=0\">\r\n");
          
            
            
            //rett = (rett+"<xsl:value-of select=\""+vrednost+"\"/>&#160;\r\n");
            rett = rett+ getAttributeFormat(vrednost,true);
            
            
            rett = (rett+"</xsl:if>\r\n");
            rett = (rett+"<xsl:apply-templates select=\""+vrednost+"/bre\"/>\r\n");
        } else
        {
            //rett = (rett+"<xsl:value-of select=\""+vrednost+"\"/>&#160;\r\n");
            rett = rett+ getAttributeFormat(vrednost,true);
            
            
        }
        rett = (rett+"</xsl:if>\r\n");
        rett = (rett+"<xsl:if test=\"slik"+slik+"='1'\">\r\n");
        rett = (rett+"<fo:external-graphic width=\"{(w)}\"  height=\"{(h)}\"  align=\"center\" src=\"{("+vrednost+")}\"/>\r\n");
        rett = (rett+"</xsl:if>\r\n");
        return rett;
    }

    private String[] genList_PDF_fo(TemplateFunkcijaStart tui, String idfunkcije, String class1, TemplatePdfParametri tpp,int whole_zapp)
    {
        if(tpp == null)
            tpp = new TemplatePdfParametri();
        StringBuffer sb = new StringBuffer();
        StringBuffer sbfo = new StringBuffer();
        String imenavrstic = "";
        sbfo.append(("<xsl:template match=\"stolpec"+idfunkcije+"\">\r\n"));
        sbfo.append(("<xsl:param name=\"aro\" select=\"//stolpec"+idfunkcije+"/col\"/>\r\n"));
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append("<xsl:for-each select=\"$aro\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpp.getPadding()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding()))+"pt\"    "+(nul.jeNull(tpp.getPdf_header_bgcolor_prevod()).equals("") ? "background-color=\"#E2E2E2\"" : ("background-color=\"#"+tpp.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\"  >\r\n");
        sbfo.append(("<fo:block   letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpp.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding_top()))+"pt\" font-size=\""+(nul.jeNull(tpp.getPdf_head_glava_lista_font_size()).equals("") ? "8" : nul.jeNull(tpp.getPdf_head_glava_lista_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpp.getLine_height()).equals("") ? "10" : tpp.getLine_height())+"pt\"  text-align=\"center\" "+(nul.jeNull(tpp.getPdf_head_glava_lista_font_width()).equals("1") ? "font-weight=\"bold\"" : "")+" >\r\n"));
     //   sbfo.append("<xsl:value-of select=\".\"/>\r\n");
       
        sbfo.append( getAttributeFormat("colv",false));
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</xsl:for-each>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:template>\r\n");
        sbfo.append(("<xsl:template match=\"vrstice"+idfunkcije+"\">\r\n"));
        sbfo.append(("<xsl:apply-templates select=\"//vrstica"+idfunkcije+"\"/>\r\n"));
        sbfo.append("</xsl:template>\r\n");
        
    //    sb.append(("<xsl:if test=\"vrstice"+idfunkcije+"\">\r\n"));
        sb.append(("<fo:table   "+(nul.jeNull(tpp.getMargin_top()).trim().equals("") ? "":"margin-top=\""+tpp.getMargin_top()+"\"")+"  "+(nul.jeNull(tpp.getPdf_list_okvir()).equals("1") ? "border-width=\"0.5pt\"":"border-width=\"0.5pt\"")+" border-style=\"solid\"  border-collapse=\"separate\"  "+(nul.jeNull(tpp.getPdf_list_okvir()).equals("1") ? "border-color=\"black\"" : "border-color=\"white\"")+"  padding=\""+(nul.jeNull(tpp.getPdf_header_padding()).equals("") ? "1":tpp.getPdf_header_padding())+"pt\" border-separation=\""+(nul.jeNull(tpp.getPdf_header_spacing()).equals("") ? "1":tpp.getPdf_header_spacing())+"pt\">\r\n"));
        sbfo.append(("<xsl:template match=\"vrstica"+idfunkcije+"\">\r\n"));
        int zapoo = 1;
        Iterator itbv = tui.getTemplatelists().iterator();
        sbfo.append("<fo:table-row>\r\n");
        
        int stcolumn = 0;
        while(itbv.hasNext()) 
        {
            TemplateList tli = (TemplateList)itbv.next();
            sb.append(("<fo:table-column column-width=\""+tli.getStolpec_width()+"mm\"/>\r\n"));
            sbfo.append("<fo:table-cell border-width=\"0pt\" border-style=\"solid\" border-color=\"white\">\r\n");
            sbfo.append("<fo:block  padding=\""+(nul.jeNull(tpp.getPadding()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding()))+"pt\" padding-top=\""+(nul.jeNull(tpp.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding_top()))+"pt\" letter-spacing=\"0.4pt\" font-size=\""+(nul.jeNull(tpp.getPdf_head_glava_lista_font_size()).equals("") ? "8" : nul.jeNull(tpp.getPdf_head_glava_lista_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpp.getLine_height()).equals("") ? "10" : tpp.getLine_height())+"pt\"  text-align=\""+tli.getStolpec_align()+"\" "+(nul.jeNull(tpp.getPdf_head_glava_lista_font_width()).equals("1") ? "font-weight=\"bold\"" : "")+">\r\n");
         //   sbfo.append(("<xsl:value-of select=\"col"+zapoo+"\"/>\r\n"));
            
            sbfo.append( getAttributeFormat("col"+zapoo,false));
            
            sbfo.append("</fo:block>\r\n");
            sbfo.append("</fo:table-cell>\r\n");
            zapoo++;
            stcolumn++;
        }
        
        
        
        
        
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append(("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpp.getPadding()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding()))+"pt\"   border-style=\"solid\" border-color=\"white\" number-columns-spanned=\""+tui.getTemplatelists().size()+"\">\r\n"));
        sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  >\r\n");
        sbfo.append(("<!--DODAJ"+idfunkcije+"-->"));
        sbfo.append(("<!--DODAJXX"+whole_zapp+"-->"));
        
        
        
        
        
        
        
        
   /*     sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:template>\r\n");*/
        if(!nul.jeNull(tpp.getPdf_list_brez_head()).equals("1"))
        {
            sb.append("<fo:table-header>\r\n");
          
            sb.append(("<xsl:apply-templates select=\"//stolpec"+idfunkcije+"\"/>\r\n"));
          
            sb.append("</fo:table-header>\r\n");
        }
        sb.append("<fo:table-body>\r\n");
        if (stcolumn>0) {
        	
        	sb.append("<fo:table-row><fo:table-cell number-columns-spanned=\""+stcolumn+"\"><fo:block></fo:block></fo:table-cell></fo:table-row>\r\n");
        	
        }
        
        
        sb.append(("<xsl:apply-templates select=\"//vrstice"+idfunkcije+"\"/>\r\n"));
        sb.append("</fo:table-body>\r\n");
        sb.append("</fo:table>\r\n");
        
        
        sbfo.append("<!--SPODAJ"+whole_zapp+"-->\r\n");
        setVezavo( sb,  sbfo, whole_zapp, idfunkcije);
        
        // whole_i = whole_zapp;
            
      //  sb.append("</xsl:if>\r\n");
        
        
        String retu[] = new String[2];
        retu[0] = sb.toString();
        retu[1] = sbfo.toString();
        return retu;
    }
    
    
    private String genList_PDF_fo_end_s() {
       return ("</fo:block>\r\n")+"</fo:table-cell>\r\n"+"</fo:table-row>\r\n</xsl:template>\r\n";
    }
    

    private String[] genList_PDF_fo(TemplateClassClass tui, String idfunkcije, String class1, TemplatePdfParametri tpp,int whole_zapp)
    {
        if(tpp == null)
            tpp = new TemplatePdfParametri();
        StringBuffer sb = new StringBuffer();
        StringBuffer sbfo = new StringBuffer();
        String imenavrstic = "";
        sbfo.append(("<xsl:template match=\"stolpec"+idfunkcije+"\">\r\n"));
        sbfo.append("<xsl:param name=\"aro\" select=\"col\"/>\r\n");
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append("<xsl:for-each select=\"$aro\">\r\n");
        sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpp.getPadding()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding()))+"pt\"    "+(nul.jeNull(tpp.getPdf_header_bgcolor_prevod()).equals("") ? "background-color=\"#E2E2E2\"" : ("background-color=\"#"+tpp.getPdf_header_bgcolor_prevod()+"\""))+"   border-style=\"solid\" border-color=\"white\">\r\n");
        sbfo.append(("<fo:block   letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpp.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding_top()))+"pt\" font-size=\""+(nul.jeNull(tpp.getPdf_head_glava_lista_font_size()).equals("") ? "8" : nul.jeNull(tpp.getPdf_head_glava_lista_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpp.getLine_height()).equals("") ? "10" : tpp.getLine_height())+"pt\" text-align=\"center\" "+(nul.jeNull(tpp.getPdf_head_glava_lista_font_width()).equals("1") ? "font-weight=\"bold\"" : "")+">\r\n"));
       
        
        
     //   sbfo.append("<xsl:value-of select=\".\"/>\r\n");
        sbfo.append( getAttributeFormat("colv",false));
        
        
        
        sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</xsl:for-each>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:template>\r\n");
        sbfo.append(("<xsl:template match=\"vrstice"+idfunkcije+"\">\r\n"));
        sbfo.append(("<xsl:apply-templates select=\"vrstica"+idfunkcije+"\"/>\r\n"));
        sbfo.append("</xsl:template>\r\n");
        
        sb.append(("<xsl:if test=\"vrstice"+idfunkcije+"\">\r\n"));
        sb.append(("<fo:table  "+(nul.jeNull(tpp.getMargin_top()).trim().equals("") ? "":"margin-top=\""+tpp.getMargin_top()+"\"")+"  "+(nul.jeNull(tpp.getPdf_list_okvir()).equals("1") ? "border-width=\"0.5pt\"":"border-width=\"0.5pt\"")+" border-style=\"solid\"   border-collapse=\"separate\"   "+(nul.jeNull(tpp.getPdf_list_okvir()).equals("1") ? "border-color=\"black\"" : "border-color=\"white\"")+"      padding=\""+(nul.jeNull(tpp.getPdf_header_padding()).equals("") ? "1":tpp.getPdf_header_padding())+"pt\" border-separation=\""+(nul.jeNull(tpp.getPdf_header_spacing()).equals("") ? "1":tpp.getPdf_header_spacing())+"pt\">\r\n"));
        sbfo.append(("<xsl:template match=\"vrstica"+idfunkcije+"\">\r\n"));
        int zapoo = 1;
        Iterator itbv = tui.getTemplatelists().iterator();
        sbfo.append("<fo:table-row>\r\n");
        int stcolumn=0;
        while(itbv.hasNext()) 
        {
        	stcolumn++;
            TemplateList tli = (TemplateList)itbv.next();
            sb.append(("<fo:table-column column-width=\""+tli.getStolpec_width()+"mm\"/>\r\n"));
            sbfo.append(("<xsl:if test=\"slik"+zapoo+"='1'\">\r\n"));
            String he = "";
            String wi = "";
            String hes = "";
            String wis = "";
            if(nul.jeNull(tli.getJeslika()).equals("1"))
            {
                if(!nul.jeNull((tli.getSlika_width()+"")).equals("") && tli.getSlika_width().intValue() > 0)
                {
                    wi = ("width=\""+tli.getSlika_width().intValue() + 4+"pt\"");
                    wis = ("width=\""+tli.getSlika_width()+"pt\"");
                }
                if(!nul.jeNull((tli.getSlika_height()+"")).equals("") && tli.getSlika_height().intValue() > 0)
                {
                    he = ("height=\""+tli.getSlika_height().intValue() + 4+"pt\"");
                    hes = ("height=\""+tli.getSlika_height()+"pt\"");
                }
            }
            sbfo.append(("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpp.getPadding()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding()))+"pt\"  "+hes+" border-style=\"solid\" border-color=\"white\">\r\n"));
            sbfo.append(("<fo:block  letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpp.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding_top()))+"pt\" font-size=\""+(nul.jeNull(tpp.getPdf_font_size()).equals("") ? "7" : nul.jeNull(tpp.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpp.getLine_height()).equals("") ? "10" : tpp.getLine_height())+"pt\"  text-align=\""+(nul.jeNull(tli.getStolpec_align()).equals("") ? "left" : nul.jeNull(tli.getStolpec_align()))+"\" >\r\n"));
            sbfo.append(("<fo:external-graphic "+hes+" "+wis+" align=\"center\" src=\"{(col"+zapoo+")}\"/>\r\n"));
            sbfo.append("</fo:block>\r\n");
            sbfo.append("</fo:table-cell>\r\n");
            sbfo.append("</xsl:if>\r\n");
            sbfo.append(("<xsl:if test=\"slik"+zapoo+"='0'\">\r\n"));
            sbfo.append("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpp.getPadding()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding()))+"pt\"    border-style=\"solid\" border-color=\"white\">\r\n");
            sbfo.append(("<fo:block   letter-spacing=\"0.4pt\"  padding-top=\""+(nul.jeNull(tpp.getPadding_top()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding_top()))+"pt\" font-size=\""+(nul.jeNull(tpp.getPdf_font_size()).equals("") ? "7" : nul.jeNull(tpp.getPdf_font_size()))+"pt\" font-family=\"verdana\" line-height=\""+(nul.jeNull(tpp.getLine_height()).equals("") ? "10" : tpp.getLine_height())+"pt\"  text-align=\""+(nul.jeNull(tli.getStolpec_align()).equals("") ? "left" : nul.jeNull(tli.getStolpec_align()))+"\" >\r\n"));
           // sbfo.append(("<xsl:value-of select=\"col"+zapoo+"\"/>\r\n"));
            
            sbfo.append( getAttributeFormat("col"+zapoo,false));
            
            
            sbfo.append("</fo:block>\r\n");
            sbfo.append("</fo:table-cell>\r\n");
            sbfo.append("</xsl:if>\r\n");
            zapoo++;
        }
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("<fo:table-row>\r\n");
        sbfo.append(("<fo:table-cell border-width=\"0pt\"  padding=\""+(nul.jeNull(tpp.getPadding()).trim().equals("") ? "1":nul.jeNull(tpp.getPadding()))+"pt\"    border-style=\"solid\" border-color=\"white\" number-columns-spanned=\""+tui.getTemplatelists().size()+"\">\r\n"));
        sbfo.append("<fo:block  letter-spacing=\"0.4pt\"  space-after.optimum=\"1pt\"  >\r\n");
        sbfo.append(("<!--DODAJ"+idfunkcije+"-->"));
        sbfo.append(("<!--DODAJXX"+whole_zapp+"-->"));
      /*  sbfo.append("</fo:block>\r\n");
        sbfo.append("</fo:table-cell>\r\n");
        sbfo.append("</fo:table-row>\r\n");
        sbfo.append("</xsl:template>\r\n");*/
        if(!nul.jeNull(tpp.getPdf_list_brez_head()).equals("1"))
        {
            sb.append("<fo:table-header>\r\n");
            
            sb.append("<xsl:if test=\"stolpec"+idfunkcije+"\">\r\n");
            
            sb.append(("<xsl:apply-templates select=\"stolpec"+idfunkcije+"\"/>\r\n"));
            
            sb.append("</xsl:if>\r\n");
            
            sb.append("</fo:table-header>\r\n");
        }
        sb.append("<fo:table-body>\r\n");
        
   if (stcolumn>0) {
        	
        //	sbfo.append("<fo:table-row><fo:table-cell number-columns-spanned=\""+stcolumn+"\"><fo:block></fo:block></fo:table-cell></fo:table-row>\r\n");
        	
        }
   
   sbfo.append("<!--SPODAJ"+whole_zapp+"-->\r\n");
   
        
        
        sb.append(("<xsl:apply-templates select=\"vrstice"+idfunkcije+"\"/>\r\n"));
        sb.append("</fo:table-body>\r\n");
        sb.append("</fo:table>\r\n");
        sb.append("</xsl:if>\r\n");
        
        
        
    //    setVezavo( sb,  sbfo, whole_zapp, idfunkcije);   
          //  whole_i = whole_zapp;
            
        
        
        
        
        
        
        
        String retu[] = new String[2];
        retu[0] = sb.toString();
        retu[1] = sbfo.toString();
        return retu;
    }
    
    
    private String genList_PDF_fo_end() {
        return "</fo:block>\r\n</fo:table-cell>\r\n</fo:table-row>\r\n</xsl:template>\r\n";
    }
    
    

    private String genList_PDF(TemplateFunkcijaStart tui, String idfunkcije, String class1, boolean jecount, String classtip, ContextUtil contextUtil, ServletContext servletContext)
    {
        StringBuffer sb = new StringBuffer();
        if(!jecount)
        {
            sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
            sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
            sb.append(("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
        } else
        {
            sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
            sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
            sb.append(("Iterator itx"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
            sb.append(("com.popultrade.model."+class1+" com.popultrade.model."+class1+" modoo"+idfunkcije+""+class1+"=new com.popultrade.model."+class1+"();\r\n"));
            sb.append(("while (itx"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
            sb.append(("com.popultrade.model."+tui.getClass_name()+"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")(itx"+idfunkcije+class1+".next());\r\n"));
            Iterator ie = tui.getTemplatelists().iterator();
            do
            {
                if(!ie.hasNext())
                    break;
                TemplateList tw = (TemplateList)ie.next();
                if(nul.jeNull(tw.getTip_sestevka()).equals("COUNT"))
                    sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n"));
                else
                if(nul.jeNull(tw.getTip_sestevka()).equals("SUM"))
                    sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+(modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0));\r\n"));
            } while(true);
            sb.append("}  // while end\r\n");
            sb.append(("List lik"+idfunkcije+""+class1+" = new ArrayList();  // array list\r\n"));
            sb.append(("lik"+idfunkcije+""+class1+".add(modoo"+idfunkcije+class1+");\r\n"));
            sb.append(("Iterator it"+idfunkcije+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n\r\n"));
        }
        String imenavrstic = "";
        sb.append(("cy.a(\"<vrstice"+idfunkcije+">\");\r\n"));
        String stolpci = ("<stolpec"+idfunkcije+">");
        replaceHeaders+=("<stolpec"+idfunkcije+"></stolpec"+idfunkcije+">"+"--X--");
        if(classtip.equals("LI") || classtip.equals("CO"))
        {
            sb.append(("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
            sb.append(("mod"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")(it"+idfunkcije+class1+".next());\r\n"));
        } else
        {
            sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
            sb.append(("mod"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")remi"+idfunkcije+class1+".get(0);\r\n"));
        }
        sb.append(("cy.a(\"<vrstica"+idfunkcije+">\");\r\n"));
        sb.append("%////>\r\n");
        int zapoo = 1;
        for(Iterator itbv = tui.getTemplatelists().iterator(); itbv.hasNext();)
        {
            TemplateList tli = (TemplateList)itbv.next();
            stolpci = (stolpci+"<col><colv>\"+\""+(getPDF_properties(tli.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tli.getId()+"P\"+sw) +\"</colv></col>");
            if(tli.getTemplateClasses().size() > 0)
            {
            	 
            	
            	sb.append(createPP(tli,"templatelist",idfunkcije,class1));
            	
            	
            	
            	
            } else if(!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#") != -1)
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.formatNumber(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>", "")+"(),\""+tli.getFormat_stolpca()+"\");\r\n"));
                sb.append("%////>\r\n");
            } else
            if(!nul.jeNull(tli.getFormat_stolpca()).equals(""))
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>", "")+"(),\""+tli.getFormat_stolpca()+"\");\r\n"));
                sb.append("%////>\r\n");
            } else
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.jeN(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("'", "\"")+"()+\"\");\r\n\r\n"));
                sb.append("%////>\r\n");
            }
            if(nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals(""))
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.cutString(r,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n"));
                sb.append("%////>\r\n");
            }
            String slik = "";
            if(nul.jeNull(tli.getJeslika()).equals("1"))
            {
                slik = ("<slik"+zapoo+">1</slik"+zapoo+">");
                sb.append("<%\r\n");
                sb.append(("cy.a(\""+slik+"<col"+zapoo+">\"+\""+(getPDF_properties(tli.getId(),"v",contextUtil,servletContext))+"\"+control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+r+\"</col"+zapoo+">\");\r\n"));
                sb.append("%////>\r\n");
            } else
            {
                slik = ("<slik"+zapoo+">0</slik"+zapoo+">");
                sb.append("<%\r\n");
                sb.append(("cy.a(\""+slik+"<col"+zapoo+">\"+\""+(getPDF_properties(tli.getId(),"v",contextUtil,servletContext))+"\"+r+\"</col"+zapoo+">\");\r\n"));
                sb.append("%////>\r\n");
            }
            zapoo++;
        }

        sb.append("<////%\r\n");
        sb.append(("cy.a(\"</vrstica"+idfunkcije+">\");\r\n"));
        sb.append("}  // while end\r\n");
        sb.append(("cy.a(\"</vrstice"+idfunkcije+">\");\r\n"));
        stolpci = (stolpci+"</stolpec"+idfunkcije+">");
        sb.append(("cy.a(\""+stolpci+"\");\r\n"));
        sb.append("}\r\n");
        return sb.toString();
    }

    private String[] genList_PDF2(TemplateClassClass tui, String idfunkcije, String class1, boolean jecount, ContextUtil contextUtil, ServletContext servletContext)
    {
        StringBuffer sb = new StringBuffer();
        sb.append("if (true) {\r\n");
        if(!jecount)
        {
            sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
            sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
            sb.append(("Iterator it"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
        } else
        {
            sb.append(("if (remi"+idfunkcije+""+class1+".size()>0) {\r\n"));
            sb.append(("List lis"+idfunkcije+class1+" =remi"+idfunkcije+""+class1+";\r\n"));
            sb.append(("Iterator itx"+idfunkcije+class1+" = lis"+idfunkcije+class1+".iterator();\r\n\r\n"));
            sb.append(("com.popultrade.model."+class1+" modoo"+idfunkcije+""+class1+"=new com.popultrade.model."+class1+"();\r\n"));
            sb.append(("while (itx"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
            sb.append(("com.popultrade.model."+tui.getClass_name()+"  modd"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")(itx"+idfunkcije+class1+".next());\r\n"));
            Iterator ie = tui.getTemplatelists().iterator();
            do
            {
                if(!ie.hasNext()) {
                    break;}
                
                TemplateList tw = (TemplateList)ie.next();
                if(nul.jeNull(tw.getTip_sestevka()).equals("COUNT"))
                    sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+1);\r\n"));
                else
                if(nul.jeNull(tw.getTip_sestevka()).equals("SUM"))
                    sb.append(("modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda().replaceAll("get", "set")+"((modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modoo"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0)+(modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"()!=null?modd"+idfunkcije+class1+"."+tw.getStolpec_metoda()+"():0));\r\n"));
            } while(true);
            sb.append("}  // while end\r\n");
            sb.append(("List lik"+idfunkcije+""+class1+" = new ArrayList();  // array list\r\n"));
            sb.append(("lik"+idfunkcije+""+class1+".add(modoo"+idfunkcije+class1+");\r\n"));
            sb.append(("Iterator it"+idfunkcije+class1+" = lik"+idfunkcije+""+class1+".iterator();\r\n\r\n"));
        }
        String imenavrstic = "";
        sb.append(("cy.a(\"<vrstice"+idfunkcije+">\");\r\n"));
        String stolpci = ("<stolpec"+idfunkcije+">");
        replaceHeaders+=("<stolpec"+idfunkcije+"></stolpec"+idfunkcije+">"+"--X--");
        sb.append(("while (it"+idfunkcije+class1+".hasNext()){  // while start\r\n"));
        sb.append((" mod"+idfunkcije+class1+" = (com.popultrade.model."+tui.getClass_name()+")(it"+idfunkcije+class1+".next());\r\n"));
        sb.append(("cy.a(\"<vrstica"+idfunkcije+">\");\r\n"));
        sb.append("%////>\r\n");
        int zapoo = 1;
        for(Iterator itbv = tui.getTemplatelists().iterator(); itbv.hasNext();)
        {
            TemplateList tli = (TemplateList)itbv.next();
            stolpci = (stolpci+"<col><colv>\"+\""+(getPDF_properties(tli.getId(),"t",contextUtil,servletContext))+"\"+cx.gP2(\""+tli.getId()+"P\"+sw)+\"</colv></col>");
           
            
            
            
            
            
            
            
            if(tli.getTemplateClasses().size() > 0)
            {
            	
            	
            	//////  templatelist pp
                
                
            	sb.append(createPP(tli,"templatelist",idfunkcije,class1)+"\r\n");
                
                
                
                
                
                
            } else
            if(!nul.jeNull(tli.getFormat_stolpca()).equals("") && nul.jeNull(tli.getFormat_stolpca()).indexOf("#") != -1)
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.formatNumber(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>", "")+"(),\""+tli.getFormat_stolpca()+"\");\r\n"));
                sb.append("%////>\r\n");
            } else
            if(!nul.jeNull(tli.getFormat_stolpca()).equals(""))
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.getDatumFormatFromDate(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("<.*?>", "")+"(),\""+tli.getFormat_stolpca()+"\");\r\n"));
                sb.append("%////>\r\n");
            } else
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.jeN(mod"+idfunkcije+class1+"."+tli.getStolpec_metoda().replaceAll("'", "\"")+"()+\"\");\r\n\r\n"));
                sb.append("%////>\r\n");
            }
            if(nul.jeNull(tli.getStolpec_max_width_uporabi()).equals("1") && !nul.jeNull(tli.getStolpec_max_width()).equals(""))
            {
                sb.append("<%\r\n");
                sb.append(("r=nul.cutString(r,Integer.parseInt(\""+tli.getStolpec_max_width()+"\"));\r\n\r\n"));
                sb.append("%////>\r\n");
            }
            String slik = "";
            if(nul.jeNull(tli.getJeslika()).equals("1"))
            {
                slik = ("<slik"+zapoo+">1</slik"+zapoo+">");
                sb.append("<%\r\n");
                sb.append(("cy.a(\""+slik+"<col"+zapoo+">\"+\""+(getPDF_properties(tli.getId(),"v",contextUtil,servletContext))+"\"+control.lokacijaupload+mod"+idfunkcije+class1+".getId()+\"/\"+r+\"</col"+zapoo+">\");\r\n"));
                sb.append("%////>\r\n");
            } else
            {
                slik = ("<slik"+zapoo+">0</slik"+zapoo+">");
                sb.append("<%\r\n");
                sb.append(("cy.a(\""+slik+"<col"+zapoo+">\"+\""+(getPDF_properties(tli.getId(),"v",contextUtil,servletContext))+"\"+r+\"</col"+zapoo+">\");\r\n"));
                sb.append("%////>\r\n");
            }
            zapoo++;
        }

        sb.append("<////%\r\n");
      
        StringBuffer sbm = new StringBuffer();
        
       
        sbm.append(("cy.a(\"</vrstica"+idfunkcije+">\");\r\n"));
        sbm.append("}  // while end\r\n");
        sbm.append(("cy.a(\"</vrstice"+idfunkcije+">\");\r\n"));
        stolpci = (stolpci+"</stolpec"+idfunkcije+">");
        sbm.append(("cy.a(\""+stolpci+"\");\r\n"));
        sbm.append("}\r\n");
        sbm.append("}\r\n");
        
       String[] ret = {sb.toString(),("r=\"\";\r\n")+("//////DOME"+idfunkcije+"//////\r\n"),sbm.toString()};
        
        return ret;
    }

    public String getFieldHead(String premo, TemplateView tu, String imevseb, ContextUtil contextUtil, ServletContext servletContext)
    {
        try
        {
            imevseb = ("mod"+imevseb);
            if(tu.getTemplateuidodatno() != null && tu.getTemplateuidodatno().getDodatno_java_rocno() != null && !tu.getTemplateuidodatno().getDodatno_java_rocno().trim().equals(""))
            {
                premo = (premo+"<%\r\n");
                premo = (premo+"r=\"\";\r\n");
                premo = (premo+tu.getTemplateuidodatno().getDodatno_java_rocno().replaceAll("XpredponaX", imevseb));
                premo = (premo+"%////>");
            } else
            if(tu.getTemplateClasses().size() > 0)
            {
            	
            	
            //// create pp head
                
                
            	premo = premo + (createPPView(tu,imevseb)+"\r\n");
                
                
                
                
                
                
                
                
            } else
            if(!nul.jeNull(tu.getFormat_stolpca()).equals("") && nul.jeNull(tu.getFormat_stolpca()).indexOf("#") != -1)
            {
                premo = (premo+"<%\r\n");
                premo = (premo+"r=r+\" \"+\""+(getPDF_properties(tu.getId(),"v",contextUtil,servletContext))+"\"+nul.formatNumber("+imevseb+"."+tu.getStolpec_metoda().replaceAll("<.*?>", "")+"(),\""+tu.getFormat_stolpca()+"\");\r\n");
                premo = (premo+"%////>");
            } else
            if(!nul.jeNull(tu.getFormat_stolpca()).equals(""))
            {
                premo = (premo+"<%\r\n");
                premo = (premo+"r=r+\" \"+\""+(getPDF_properties(tu.getId(),"v",contextUtil,servletContext))+"\"+nul.getDatumFormatFromDate("+imevseb+"."+tu.getStolpec_metoda().replaceAll("<.*?>", "")+"(),\""+tu.getFormat_stolpca()+"\");\r\n");
                premo = (premo+"%////>");
            } else
            {
                premo = (premo+"<%\r\n");
                premo = (premo+"r=r+\" \"+\""+(getPDF_properties(tu.getId(),"v",contextUtil,servletContext))+"\"+nul.jeN("+imevseb+"."+tu.getStolpec_metoda().replaceAll("'", "\"")+"()+\"\");\r\n\r\n");
                premo = (premo+"%////>");
            }
            return premo;
        }
        catch(Exception ex)
        {
            System.out.println(ex.toString());
        }
        return "";
    }

    public String nextTO(TemplateView tw, String idfunkcije, String class1, ContextUtil contextUtil, ServletContext servletContext)
    {
        String ret = "";
        if(tw.getTemplateviews() != null && tw.getTemplateviews().size() > 0)
        {
            List liko = tw.getTemplateviews();
            for(Iterator io = liko.iterator(); io.hasNext();)
            {
                TemplateView tww = (TemplateView)io.next();
                ret = (ret+"<////%\r\n");
                ret = (ret+"r2=r;\r\n");
                ret = (ret+"%////>\r\n");
                String rei = "";
                ret = (ret+"<////%\r\n r=r+\" \"+\""+(getPDF_properties(tww.getId(),"v",contextUtil,servletContext))+"\"+cx.gP(\""+tww.getId()+"P\"+sw)+\" \";\r\n %////>\r\n"+getFieldHead(rei, tww, (idfunkcije+""+class1),contextUtil,servletContext));
            }

        }
        return ret;
    }

    public String replaceNeznanke1(String repl)
    {
        if(repl != null)
        {
            repl = repl.replaceAll("'", "\"").replaceAll("vseb.get", "vseb.geet").replaceAll("control.get", "control.geet").replaceAll("request.getPara", "request.geetPara").replaceAll("session.getAttr", "session.geetAttr");
            return repl;
        } else
        {
            return "";
        }
    }

    public String replaceNeznanke2(String repl)
    {
        if(repl != null) 
        {
            repl = repl.replaceAll("'", "\"").replaceAll("vseb.geet", "vseb.get").replaceAll("control.geet", "control.get").replaceAll("request.geetPara", "request.getPara").replaceAll("session.geetAttr", "session.getAttr");
            return repl;
        } else
        {
            return "";
        }
    }


}
