<%@ page contentType="text/html; " import="org.apache.commons.lang.StringUtils,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,net.sf.beanlib.api.BeanMethodCollector,java.lang.reflect.Method"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<%
///////////// jasp ki generira copiranje class iz hibernate
///////////// hibernate mora imeti annotatione iz jave , kopira se le onetoone (1x) in onetomany
///////////// ce se zeli kopirat oz. setirat default polja (samo prva clasa ne vezane) je treba preko requesta poslati parametre z istim imenom kot v 
///////////// hibernate model objektih
///////////// jsp za copiranje se vedno generira na novo, ce se spremeni jar datoteka od hibernate, ce ne rabi ze generirano
		//// dobim kot default vedno podatke iz requesta, 
		/// modelname -> ime clase oz. model classe hibernata 
		/// modelid -> id ki definiram kot dodatek imenu jsp copy datoteke (opcijsko)
		/// ostalo so parametri , po katerih iscem v bazi, vse najdene na podlagi parametrov se kopira
		/// tipcopy -> tip lista za kopiranje za template ali ne  (template,prazno)
		
		/// polja, ki se setirajo pri kopiranju v primeru da damo en gumb pod drugi template se setira vezo na novi template (veza_id se spremeni) npr za string morajo biti v naslednjem formatu (_S<ime polja v hibernate>=<vrednost>) => _L za long | _I za integer | _D za double


%>
<%!


 


private int stpodclass=8; /// max stevilo podclass ki kopiram




private Hashtable zeonetoone = new Hashtable();


  public String getClassMetodeImenaHTGetNullable(String ime_classe)
    {
   String vsek = "";
        try
        {
        	
        	if (ime_classe.indexOf(",")!=-1) {
        	ime_classe = ime_classe.substring(0,ime_classe.indexOf(","));
        	}
        	
        	
        	System.out.println("* -------- a1 " +ime_classe);
            Class testClass = Class.forName((new StringBuilder()).append("com.popultrade.model").append(".").append(ime_classe).toString());
            System.out.println("* -------- a2");
            Method methods[] = testClass.getDeclaredMethods();
        
            System.out.println("* -------- a3");
           
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
          
          if (one.indexOf("mappedBy=,")==-1 && one.indexOf("mappedBy=)")==-1) {
          
             vsek+="-----."+method.getName().replaceFirst("get", "set")+"(null);\r\n";
           }
          else {
          vsek +="";
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
            System.out.println((new StringBuilder()).append("Napaka pri pridobivanju imena clase getClassMetodeImenaHTGetNullable! ").append(ex.toString()).toString());
        }
        
      
        return vsek;
    }




  public String getOneToOneConnectionLast(String ime_classe,String metodaa)
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
                
              //  System.out.println("ISCEMMMMMMMMMM "+ime_classe+" ::: "+method.getName()+" ::: "+metodaa);
                
                if(method.getName() != null && method.getName().equals(metodaa) ) {
                    
                    
                  String kon = "";
                       java.lang.annotation.Annotation[] ano= method.getAnnotations();
         //  testClass.getDeclaredAnnotations()
    
           for (int k=0;k<ano.length;k++) {
           String one = ano[k].toString();
           
        
            if (one.indexOf("JoinColumn")!=-1 ) {
           
            /*  String name1 = one.substring(one.indexOf("referencedColumnName=")+21);
            name1 = name1.substring(0,name1.indexOf(","));
            name1 = name1.substring(0,1).toUpperCase()+name1.substring(1);
            */
            
            String name = one.substring(one.indexOf("name=")+5);
            name = name.substring(0,name.indexOf(","));
            
             System.out.println("++++++++++++++++++++++++++++++++++++++ "+name);
          
            return name.substring(0,1).toUpperCase()+name.substring(1);
            
           
           
            }
           
          System.out.println("-++- "+one);
          
           
           }
             
                    
                    
                    }
            }

        }
        catch(ClassNotFoundException ex)
        {
            System.out.println((new StringBuilder()).append("Napaka pri pridobivanju imena clase! ").append(ex.toString()).toString());
        }
        
      
        return vsek;
    }





  public String getOneToOneConnection(String ime_classe,String key)
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
                if(method.getName() != null && method.getName().equals(key)  ) {
                    
                    
                  String kon = "";
                       java.lang.annotation.Annotation[] ano= method.getAnnotations();
         //  testClass.getDeclaredAnnotations()
         boolean nextjoin  = false;
           for (int k=0;k<ano.length;k++) {
           String one = ano[k].toString();
           
       
           
           System.out.println("-++- "+one);
           
           
                 if (one.indexOf("OneToOne")!=-1 ) { /// ne sme biti reverse
  
          
          if (one.indexOf("mappedBy=,")==-1 && one.indexOf("mappedBy=)")==-1 ) {
          
           //  vsek+="-----."+method.getName().replaceFirst("get", "set")+"(null);\r\n";
           
           String outt = one.substring(one.indexOf("mappedBy=")+9);
           
           if (outt.indexOf(",")!=-1) {
           outt = outt.substring(0,outt.indexOf(","));
           }
           if (outt.indexOf(")")!=-1) {
               outt = outt.substring(0,outt.indexOf(")"));
               }
           
           System.out.println("=============================== "+outt+" ============= "+method.getReturnType());
           
           String veze ="get"+ outt.substring(0,1).toUpperCase()+outt.substring(1);
           String retr = method.getReturnType().toString().substring(method.getReturnType().toString().lastIndexOf(".")+1);
           
           String vek = this.getOneToOneConnectionLast(retr,veze);
           
           
          
           return vek;
           }
          else {
          return "";
          }
           
           //System.out.println("-- "+kon);
          // }
           
           }
           
           }
                    
              
                    
                    
                    }
            }

        }
        catch(ClassNotFoundException ex)
        {
            System.out.println((new StringBuilder()).append("Napaka pri pridobivanju imena clase! ").append(ex.toString()).toString());
        }
        
      
        return vsek;
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
           System.out.println("*-------------------- xxxxxxxxxx ------------- 1");
           
           
           
           String retk = kon.substring(kon.lastIndexOf(".")+1);
           
           vsebine.put(method.getName(), getClassMetodeImenaHTGetNullable(retk));
           
           System.out.println("*-------------------- xxxxxxxxxx ------------- 2");
           
           nextjoin=true;
           }
           
           }
            if (one.indexOf("JoinColumn")!=-1 && nextjoin) {
            	
            	System.out.println("*-------------------- xxxxxxxxxx ------------- 3");
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
           
           
                 if (one.indexOf("OneToOne")!=-1 && one.indexOf("mappedBy=,")==-1 && one.indexOf("mappedBy=)")==-1) { /// ne sme biti reverse
           dajn=true;
           System.out.println("*-------------------- xxxxxxxxxx ------------- 4");
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
                 System.out.println("*-------------------- xxxxxxxxxx ------------- 5");
           }
           System.out.println("*-------------------- xxxxxxxxxx ------------- 56");
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
                     //  if (StringUtils.countMatches(nadrejena.toLowerCase(), kontr.toLowerCase())<stpodclass-1   ) {
                 
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
                   // }
                    
    
            }



        }
        catch(ClassNotFoundException ex)
        {
            System.out.println((new StringBuilder()).append("Napaka pri pridobivanju imena clase -xx! ").append(ex.toString()).toString());
        }
        
        
        Hashtable[] retx = new Hashtable[2];
		retx[0]=metode;
		retx[1]=vsebine;
        return retx;
    }


        
        Hashtable funkcije = new Hashtable();
       // Hashtable neznanke = new Hashtable();
        
int stfun = 10;
int zap=2;
	public String digIn(String clasname,String nadrejena,String pre,int zapo,int stop,HttpServletRequest request,int maxx) {
	
	//int zap = zapo;
	
	
	if (maxx<stpodclass) {
	
	stfun++;
	int max = maxx+1;
	int trenutno = stfun;
	/*if (trenutno>14) {
		return "";
	}*/
	int zax = zapo-1;
	int vmes = stop+1;
	String nadr = nadrejena+"---";
	
	if (nadr.indexOf(",")!=-1) {
		nadr=	nadr.substring(0, nadr.indexOf(","));
		}
	
	Hashtable[] hik =  getClassMetodeImenaHTGet(clasname,nadrejena,false);
			Hashtable htt =hik[0];
		Hashtable vseb = hik[1];
		String retu = "";
		Enumeration enn = htt.keys();
		String dodpar = "";
		
		if (clasname.indexOf(",")!=-1) {
			clasname=	clasname.substring(0, clasname.indexOf(","));
			}
		
		retu += "public void fun"+trenutno+"(com.popultrade.webapp.ContextUtil contextUtil,HttpServletRequest request,com.popultrade.model."+clasname+" glavno"+(zax)+pre+",com.popultrade.model."+clasname+" clone"+(zax)+pre+") {\r\n";
		
		while (enn.hasMoreElements()) {
		
		String key = (String)enn.nextElement();
		
		String kont = (String)htt.get(key);
		
		if (kont.indexOf("util.List")!=-1) {
		
		//// naredim list
		
		String cell = kont.substring(kont.indexOf("::::")+4);
		System.out.println("CN 210 -------------- "+cell);
		if (cell.indexOf(",")!=-1) {
		cell=	cell.substring(0, cell.indexOf(","));
		}
		
		System.out.println("CN 212 -------------- "+cell);
		String cn = cell.substring(cell.lastIndexOf(".")+1,cell.length());
		
		
		retu += "if (!nul.jeNull(request.getParameter(\""+cn+"\")).equals(\"NE\")) {\r\n"; /// ce je preko requesta ime classe in ima vrednost NE se ne kopira class
		
		
		retu += "List li"+zap+" = glavno"+(zax)+pre+"."+key+"();\r\n";
		retu += "if (li"+zap+"!=null) {\r\n";
		retu += "Iterator it"+zap+" = li"+zap+".iterator();\r\n";
		retu += "while (it"+zap+".hasNext()) {\r\n";
	//	neznanke.put(kont.substring(kont.indexOf("::::")+4) + " glavno"+(zap)+"", "");
		
	String konts = kont.substring(kont.indexOf("::::")+4);
	
			if (konts.indexOf(",")!=-1) {
				konts=	konts.substring(0, konts.indexOf(","));
			}
			
	
		retu +=  konts + " glavno"+(zap)+" = ("+konts+")it"+zap+".next();\r\n";
		
		
		
		
		
		
		
	//	neznanke.put("com.popultrade.dao."+cn+"DAO daox"+zap, "");
		//neznanke.put("com.popultrade.model."+cn+" clone"+zap, "");
		
		retu += "com.popultrade.dao."+cn+"DAO daox"+zap+" = (com.popultrade.dao."+cn+"DAO)contextUtil.getBeanDao(\""+(cn.substring(0,1).toLowerCase()+cn.substring(1))+"DAO\",request.getServletContext());\r\n";
		//retu += "com.popultrade.model."+cn+" clone"+zap+" = replicator.copy(glavno"+zap+");\r\n";
		retu += "com.popultrade.model."+cn+" clone"+zap+" =(com.popultrade.model."+cn+")contextUtil.cloneBean(glavno"+zap+");\r\n";
		
		
////////////polja dodatno set

retu += getDefaultPolja(request,cn,"");


/////////////////////////////

		
		
		retu += "clone"+zap+".setId(null);\r\n";
		
		retu += vseb.get(key).toString().replace("_____", "clone"+(zax)+pre+"").replace("-----", "clone"+zap+"") + "\r\n";
		
		
		
		retu += "daox"+zap+".save"+cn+"(clone"+zap+");\r\n";
		//zap++;
		retu += this.digIn(cn,nadr+clasname,"",zap,vmes, request,max);
		retu += "}\r\n";
		
		retu += "}\r\n";
		
		retu += "}\r\n";
		
		zap++;
		zap++;
		}
		/// ce gre za onetoone
		else if (kont.indexOf("class ")!=-1) {
	//	zap++;
		//zap++;
		
		//neznanke.put(kont.substring(kont.indexOf("class ")+6, kont.indexOf("::::"))+ " glavno"+zap+"x", "");
		
		retu += kont.substring(kont.indexOf("class ")+6, kont.indexOf("::::"))+ " glavno"+zap+"x = ("+kont.substring(kont.indexOf("class ")+6, kont.indexOf("::::"))+")glavno"+(zax)+pre+"."+key+"();\r\n";
		
		String cell = kont.substring(kont.indexOf("class ")+6, kont.indexOf("::::"));
		System.out.println("CN 21 -------------- "+cell);
		if (cell.indexOf(",")!=-1) {
			cell=	cell.substring(0, cell.indexOf(","));
			}
		
		System.out.println("CN 22 -------------- "+cell);
		
		String cn = cell.substring(cell.lastIndexOf(".")+1,cell.length());
		
		
		
		retu += "if (glavno"+zap+"x!=null) {\r\n";
		
		retu += "if (!nul.jeNull(request.getParameter(\""+cn+"\")).equals(\"NE\")) {\r\n";
		
		//neznanke.put("com.popultrade.dao."+cn+"DAO daox"+zap, "");
		retu += "com.popultrade.dao."+cn+"DAO daox"+zap+" = (com.popultrade.dao."+cn+"DAO)contextUtil.getBeanDao(\""+(cn.substring(0,1).toLowerCase()+cn.substring(1))+"DAO\",request.getServletContext());\r\n";
		//	retu += "com.popultrade.model."+cn+" clone"+zap+"x = replicator.copy(glavno"+zap+"x);\r\n";
		//neznanke.put("com.popultrade.model."+cn+" clone"+zap+"x", "");
		retu += "com.popultrade.model."+cn+" clone"+zap+"x =(com.popultrade.model."+cn+")contextUtil.cloneBean(glavno"+zap+"x);\r\n";
		
		retu += "clone"+zap+"x.setId(null);\r\n";
		
////////////polja dodatno set

retu += getDefaultPolja(request,cn,"");


/////////////////////////////
		
		
		// System.out.println("======================z========= "+this.getOneToOneConnection(clasname,key)+" ::xcv");
		retu += "clone"+zap+"x.set"+this.getOneToOneConnection(clasname,key)+"(clone"+zax+pre+".getId());\r\n";
		retu += vseb.get(key).toString().replace("_____", "clone"+(zax)+pre+"").replace("-----", "clone"+zap+"x") + "\r\n";
		
		
		retu += "daox"+zap+".save"+cn+"(clone"+zap+"x);\r\n";
		
		
		
		
		
		//retu += "daox"+zap+".save"+cn+"(glavno"+zap+"x);\r\n";
		
		//zeonetoone.put(cell.substring(cell.lastIndexOf(".")+1,cell.length()).toLowerCase(), "");
	//	
	//if (vmes<stpodclass) {
		
	//zap++;
		retu += this.digIn(cell.substring(cell.lastIndexOf(".")+1,cell.length()),nadr+clasname,"x",zap,vmes, request,max);
	//}
	retu += "}\r\n";
	retu += "}\r\n";
	
		zap++;
		zap++;
		}
		
		 
		
		}
		retu += "} /// end function fun"+trenutno+"\r\n";
		
		
		funkcije.put(retu,"");
		
		
		
		if (nadrejena.equals("NOBENACLASA")) {
			zapo=1;
		}
		
		return "fun"+trenutno+"(contextUtil,request,glavno"+zapo+pre+",clone"+zapo+pre+");\r\n";
	}
	else {
	return "";
	}
	}






	public String clonirajClassTree(com.popultrade.webapp.ContextUtil contextUtil,HttpServletRequest request,com.popultrade.webapp.control control,com.popultrade.webapp.conPool ConPool) {
		
		
		try {
		
		//// disabled
		if (request.getParameter("modelname")==null || request.getParameter("modelname").equals("")) {
		
			System.out.println("ERROR: ne najdem modelname za kloniranje !!!!!");
			
			return "nic.jsp";
		
		}
		
		String ime = request.getParameter("modelname");
		
		////
		
		//// kontrola, ce ze obstaja datoteka
		
		//// dobim kot default vedno podatke iz requesta, 
		/// modelname -> ime clase oz. model classe hibernata 
		/// modelid -> id ki definiram kot dodatek imenu jsp copy datoteke (opcijsko)
		/// ostalo so parametri , po katerih iscem v bazi, vse najdene na podlagi parametrov se kopira
		/// tipcopy -> tip lista za kopiranje za template ali ne  (template,prazno)
		
		String outfile = "";
		boolean obstaja = false;
		try {
			
			String fim =ConPool.getLokacija_jspcopy_datotek()+ request.getParameter("modelname") + request.getParameter("modelid")+ConPool.getCasbuildjar()+".jsp";
			
			File fi = new File(fim);
			
			if (fi.exists()) {
				obstaja = true;
			}
			else {
				
				outfile=fim;
			}
			
		}
		catch (Exception emo) {
			
		}
		
		if (!obstaja) {
			
		
		StringBuffer sbb = new StringBuffer();
		
		
		
		sbb.append("<%////@ page contentType=\"text/html; \" import=\"org.apache.commons.lang.StringUtils,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,net.sf.beanlib.api.BeanMethodCollector,java.lang.reflect.Method\"%////>\r\n");
		sbb.append("<////jsp:useBean id=\"ConPool\" scope=\"application\" class=\"com.popultrade.webapp.conPool\"/>\r\n");
		sbb.append("<////jsp:useBean id=\"control\" scope=\"session\" class=\"com.popultrade.webapp.control\" />\r\n");
		sbb.append("<////jsp:useBean id=\"nul\" scope=\"session\" class=\"com.popultrade.webapp.chkNull\" />\r\n");
		sbb.append("<////jsp:useBean id=\"contextUtil\" scope=\"session\" class=\"com.popultrade.webapp.ContextUtil\" />\r\n");
		sbb.append("<////jsp:useBean id=\"javaScript\" scope=\"request\" class=\"com.popultrade.webapp.JavaScriptControl\" />\r\n");
		sbb.append("<////jsp:useBean id=\"templateUtil\" scope=\"session\" class=\"com.popultrade.webapp.TemplateUtils\" />\r\n");
		
		sbb.append("<////%\r\n");
		sbb.append("if (control.getUser().equals(\"anonymous\") || (!control.getPrivilegijeUporabnika().equals(\"A\") && !control.getPrivilegijeUporabnika().equals(\"U\"))) {\r\n");
		sbb.append("%////><jsp:forward page=\"m_loginu.html\"/><////%\r\n");
		sbb.append("}\r\n");
		sbb.append("try {\r\n");
		
		
		sbb.append("ServletContext sc = request.getServletContext();\r\n");
		
			Hashtable[] hik =  getClassMetodeImenaHTGet(ime,"NOBENACLASA",true);  /// prvi
			Hashtable htt =hik[0];
		Hashtable vseb = hik[1];
				Enumeration enn = htt.keys();
		System.out.println("==========================================================================\r\n");
		String celnull = "";
		while (enn.hasMoreElements()) {
		
		String key = (String)enn.nextElement();
		
		String kont = (String)htt.get(key);
	//	System.out.println(vseb.get(key).toString().replace("_____", "clone1").replace("-----", "clone1") + "\r\n");
		System.out.println(key + "=======================================================================\r\n");
		
		celnull += "clone1."+(key.replaceFirst("get", "set"))+"(null);\r\n";
		
		
		}
		System.out.println(celnull);
		
		System.out.println("==========================================================================\r\n");
		
		
		
		
		//net.sf.beanlib.hibernate.HibernateBeanReplicator replicator = new net.sf.beanlib.hibernate3.Hibernate3BeanReplicator();
		sbb.append("com.popultrade.dao."+ime+"DAO daothead = (com.popultrade.dao."+ime+"DAO)contextUtil.getBeanDao(\""+(ime.substring(0,1).toLowerCase()+ime.substring(1))+"DAO\",sc);\r\n");
		sbb.append("com.popultrade.model."+ime+" glavnox = new com.popultrade.model."+ime+"();\r\n");
		
		sbb.append("glavnox = (com.popultrade.model."+ime+")contextUtil.getPopulatedObject(glavnox,request);//daothead.getTemplateHead(new Long(\"16550\"));\r\n");
		//System.out.println("TO CLONE");
		//if (request.getParameter("tipcopy")!=null && request.getParameter("tipcopy").equals("template")) {
		//sbb.append("List lik = daothead.get"+ime+"s(glavnox, 1, 1000);\r\n");
		//}
		//else {
			sbb.append("List lik = daothead.get"+ime+"s(glavnox, 1, 1000,\"\",\"\",\"\");\r\n");
		//}
		
		sbb.append("Iterator it = lik.iterator();\r\n");
		
		sbb.append("while (it.hasNext()) {\r\n");
			
		sbb.append("com.popultrade.model."+ime+" glavno1 = (com.popultrade.model."+ime+")it.next();\r\n");
		
		
		//System.out.println("TO CLONE "+glavno1.getId());
		sbb.append("com.popultrade.model."+ime+" clone1 = (com.popultrade.model."+ime+")contextUtil.cloneBean(glavno1);\r\n");
		
		//System.out.println("TO CLONE2 "+clone1.getId());
		
	/*	clone1.setTemplateClasss(null);
clone1.setTemplateFunkcijaStarts(null);
clone1.setTemplateUiDodatno(null);
clone1.setTemplatemaillist(null);
clone1.setTemplateGumbis(null);
clone1.setTemplatePPs(null);
clone1.setTemplateHeadResets(null);*/
sbb.append("if (!nul.jeNull(request.getParameter(\"mmove\")).equals(\"yes\")) {\r\n"); /// ce ne gre za move naredim copy
sbb.append(celnull);

sbb.append("clone1.setId(null);\r\n");
sbb.append(" }\r\n");
//// setam ostala polja, ki dobim preko requesta
/// polja za string morajo biti v naslednjem formatu (_S<ime polja v hibernate>=<vrednost>) => _L za long | _I za integer | _D za double

/// ce gre za move se clone1 zamenja z glavno1



//////////// polja dodatno set

sbb.append(getDefaultPolja(request,ime,"t"));


/////////////////////////////



		
		/*List li = clone.getTemplateClasss();
		
		Iterator it = li.iterator();
		while (it.hasNext()) {
		it.next();
		}
		*/
		
		System.out.println();
		
		/// dobim strukturo in kopiram se vezave z drugimi tabelami
		sbb.append("if (!nul.jeNull(request.getParameter(\"mmove\")).equals(\"yes\")) {\r\n");/// ce ne gre za move naredim copy

sbb.append("daothead.save"+ime+"(clone1);\r\n");
		
		sbb.append(digIn(ime,"NOBENACLASA","",2,0, request,1).replace("fun11(contextUtil,request)","fun11(contextUtil,request,glavno1,clone1)"));
		sbb.append("}\r\n");
		sbb.append("else {\r\n");
		sbb.append("daothead.save"+ime+"(glavno1);\r\n");
		sbb.append("}\r\n");
		
		
		sbb.append("}\r\n");
		
		sbb.append("}catch (Exception exo) {\r\n");
		sbb.append("System.out.println(\"Error pri kopiranju class-e: \"+exo.toString());\r\n");
		sbb.append("}\r\n");
		sbb.append("%////>\r\n");
		
		sbb.append("<script language='javascript'>parent.frames["+request.getParameter("target")+"].location=parent.frames["+request.getParameter("target")+"].location;</script>");
		
		
		sbb.append("<%!\r\n");
		sbb.append("com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();\r\n\r\n");
	/*Enumeration en = neznanke.keys();
		
		while (en.hasMoreElements()) {
			
			sbb.append((String)en.nextElement()+";\r\n");
			
		}*/
		
		Enumeration en = funkcije.keys();
		
		while (en.hasMoreElements()) {
			
			sbb.append(((String)en.nextElement()).replace("public void fun11(com.popultrade.webapp.ContextUtil contextUtil,HttpServletRequest request)", "public void fun11(com.popultrade.webapp.ContextUtil contextUtil,HttpServletRequest request,com.popultrade.model."+ime+" glavno1,com.popultrade.model."+ime+" clone1)")+"\r\n");
			
		}
		
		sbb.append("%////>\r\n");
		
		try {
	          File file = new File(outfile);
	          BufferedWriter output = new BufferedWriter(new FileWriter(file));
	          output.write(sbb.toString().replaceAll("////", ""));
	          output.close();
	        } catch ( IOException e ) {
	           e.printStackTrace();
	        }
		
		}
		
		
		
		///////////////////////////////////////////////
		///////////////////////////////////////////////
		///////////////////////////////////////////////
		///////////////////////////////////////////////
		
		
		}
		catch (Exception ed) {
		
		System.out.println("------------- "+ed.toString());
		}
		
		
				
			return request.getParameter("modelname") + request.getParameter("modelid")+ConPool.getCasbuildjar()+".jsp";	
		
	}
	
	
	
	
	/// dobim default sete polj iz requesta za doloceno tabelo (ime), prvi ce je zacetna classa - prva classa je vedno locena od ostalih zaradi primera, da naslednje clase vsebujejo lahko isto
	private String getDefaultPolja(HttpServletRequest request,String ime,String prvi)  {
		
		StringBuffer sbb = new StringBuffer();

Enumeration polja = request.getParameterNames();

while (polja.hasMoreElements()) {
	String namp = (String)polja.nextElement();
	System.out.println("ZZZZZZZZXXXZZZZZZZZZ "+namp + " ::: "+"_t"+prvi+ime+"_L");
	if (namp.startsWith("_t"+prvi+ime+"_L")) {
		String nampp = namp.substring(namp.indexOf("_L")+2);
		sbb.append("if (!nul.jeNull(request.getParameter(\"mmove\")).equals(\"yes\")) {\r\n");/// ce ne gre za move naredim copy

		sbb.append("clone1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(new Long(request.getParameter(\""+namp+"\")));\r\n");
		sbb.append("}\r\n");
		sbb.append("else {\r\n");
		
		sbb.append("if (nul.jeNull(request.getParameter(\""+namp+"\")).equals(\"\")) {\r\n");
		sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(null);\r\n");
		sbb.append("}\r\n");
		sbb.append("else {\r\n");
		sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(new Long(request.getParameter(\""+namp+"\")));\r\n");
		sbb.append("}\r\n");
		sbb.append("}\r\n");
		
	}
	else if (namp.startsWith("_t"+prvi+ime+"_S")) {
		String nampp = namp.substring(namp.indexOf("_S")+2);
		sbb.append("if (!nul.jeNull(request.getParameter(\"mmove\")).equals(\"yes\")) {\r\n");/// ce ne gre za move naredim copy

		sbb.append("clone1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(request.getParameter(\""+namp+"\"));\r\n");
		sbb.append("}\r\n");
sbb.append("else {\r\n");

sbb.append("if (nul.jeNull(request.getParameter(\""+namp+"\")).equals(\"\")) {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(null);\r\n");
sbb.append("}\r\n");
sbb.append("else {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(request.getParameter(\""+namp+"\"));\r\n");
sbb.append("}\r\n");
		sbb.append("}\r\n");
	}
	else if (namp.startsWith("_t"+prvi+ime+"_I")) {
		String nampp = namp.substring(namp.indexOf("_I")+2);
		sbb.append("if (!nul.jeNull(request.getParameter(\"mmove\")).equals(\"yes\")) {\r\n");/// ce ne gre za move naredim copy

		sbb.append("clone1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(Integer.parseInt(request.getParameter(\""+namp+"\")));\r\n");
		sbb.append("}\r\n");
sbb.append("else {\r\n");
sbb.append("if (nul.jeNull(request.getParameter(\""+namp+"\")).equals(\"\")) {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(null);\r\n");
sbb.append("}\r\n");
sbb.append("else {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(Integer.parseInt(request.getParameter(\""+namp+"\")));\r\n");
sbb.append("}\r\n");
		sbb.append("}\r\n");
	}
	else if (namp.startsWith("_t"+prvi+ime+"_D")) {
		String nampp = namp.substring(namp.indexOf("_D")+2);
		sbb.append("if (!nul.jeNull(request.getParameter(\"mmove\")).equals(\"yes\")) {\r\n");/// ce ne gre za move naredim copy

		sbb.append("clone1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(Double.parseDouble(request.getParameter(\""+namp+"\")));\r\n");
		sbb.append("}\r\n");
sbb.append("else {\r\n");

sbb.append("if (nul.jeNull(request.getParameter(\""+namp+"\")).equals(\"\")) {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(null);\r\n");
sbb.append("}\r\n");
sbb.append("else {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(Double.parseDouble(request.getParameter(\""+namp+"\")));\r\n");
sbb.append("}\r\n");
		sbb.append("}\r\n");
	}
	else if (namp.startsWith("_t"+prvi+ime+"_T")) { //// datum, format dd-MM-yyyy in opcijsko ura HH:mm
		String nampp = namp.substring(namp.indexOf("_T")+2);
		sbb.append("if (!nul.jeNull(request.getParameter(\"mmove\")).equals(\"yes\")) {\r\n");/// ce ne gre za move naredim copy

		sbb.append("clone1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(nul.parseDatumUra(request.getParameter(\""+namp+"\")));\r\n");
		sbb.append("}\r\n");
sbb.append("else {\r\n");
sbb.append("if (nul.jeNull(request.getParameter(\""+namp+"\")).equals(\"\")) {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(null);\r\n");
sbb.append("}\r\n");
sbb.append("else {\r\n");
sbb.append("glavno1.set"+(nampp.substring(0,1).toUpperCase()+nampp.substring(1))+"(nul.parseDatumUra(request.getParameter(\""+namp+"\")));\r\n");
sbb.append("}\r\n");
		sbb.append("}\r\n");
	}
	
	
	
	
	
}

return sbb.toString();	
		
		
	}
	
	
	
	
	
	
	
	
	

 %>



<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="m_loginu.html"/><%
}
%>

<%
try {
	
	String forw = "jspcopy/"+clonirajClassTree(contextUtil,request,control,ConPool);
	
	%><jsp:forward page="<%=forw %>"/><%
	

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>