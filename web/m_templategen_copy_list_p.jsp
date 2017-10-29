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


 







private Hashtable zeonetoone = new Hashtable();


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
  
          
          if (one.indexOf("mappedBy=,")==-1) {
          
           //  vsek+="-----."+method.getName().replaceFirst("get", "set")+"(null);\r\n";
           
           String outt = one.substring(one.indexOf("mappedBy=")+9);
           outt = outt.substring(0,outt.indexOf(","));
           
           System.out.println("=============================== "+outt+" ============= "+method.getReturnType());
           
           String veze ="get"+ outt.substring(0,1).toUpperCase()+outt.substring(1);
           String retr = method.getReturnType().toString().substring(method.getReturnType().toString().lastIndexOf(".")+1);
           
           String vek = this.getOneToOneConnectionLast(retr,veze);
          
           return vek;
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
                    
                    else if (method.getName() != null &&  method.getName().startsWith("get") ) {
                    //	System.out.println("------------ XXXX>>> "+method.getName());
                    //	metode.put(method.getName()+"", method.getReturnType()+":::::DBTYPE");
                    //	System.out.println("------------ XXxxXX>>> "+method.getName());
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



	public String digIn(String clasname,String nadrejena,String pre,int zapo,int stop,String pree,int poljaa) { //// zapo = zaporedje vedno 2, stop = stevilo digov za onetoone, poljaa = prikazi tudi polja
	
	int zap = zapo;
	int zax = zapo-1;
	int vmes = stop+1;
	String prex = "";
	String nadr = nadrejena+"---";
	//System.out.println("------------ 1 ");
	Hashtable[] hik =  getClassMetodeImenaHTGet(clasname,nadrejena,false);
			Hashtable htt =hik[0];
		Hashtable vseb = hik[1];
		//System.out.println("------------ 2 ");
		String retu = "";
		Enumeration enn = htt.keys();
		//System.out.println("------------ 3 ");
		while (enn.hasMoreElements()) {
		//	System.out.println("------------ 4 ");
		String key = (String)enn.nextElement();
	//	System.out.println("------------ 5 " +key);
		String kont = (String)htt.get(key);
	//	System.out.println("------------ >>> "+kont);
		if (kont.indexOf("util.List")!=-1) {
		
		//// naredim list
		
		String cell = kont.substring(kont.indexOf("::::")+4);
		String cn = cell.substring(cell.lastIndexOf(".")+1,cell.length());
		
		retu +="<li>"+prex+ cn+"\r\n";
	
	//	zap++;
		retu += this.digIn(cn,nadr+clasname,"",zap+1,vmes,prex,poljaa);
	
		retu +="</li>";
		zap++;
		zap++;
		}
		/// ce gre za onetoone
		else if (kont.indexOf("class ")!=-1 && kont.indexOf("DBTYPE")==-1) {
	//	zap++;
		//zap++;
		
		String cell = kont.substring(kont.indexOf("class ")+6, kont.indexOf("::::"));
		String cn = cell.substring(cell.lastIndexOf(".")+1,cell.length());
		
	
		retu +="<li>"+prex+ cn+"\r\n";
		
		
		//retu += "daox"+zap+".save"+cn+"(glavno"+zap+"x);\r\n";
		
		//zeonetoone.put(cell.substring(cell.lastIndexOf(".")+1,cell.length()).toLowerCase(), "");
	//	
	if (vmes<=2) {
		retu += this.digIn(cell.substring(cell.lastIndexOf(".")+1,cell.length()),nadr+clasname,"x",zap+1,vmes,prex,poljaa);
	}

	retu +="</li>";
		zap++;
		zap++;
		}
		else if ((kont.indexOf(".String")!=-1 || kont.indexOf(".Long")!=-1  || kont.indexOf(".Integer")!=-1 || kont.indexOf(".Double")!=-1 || kont.indexOf(".Date")!=-1) && kont.indexOf("DBTYPE")!=-1) {
			//String cell = kont.substring(kont.indexOf("::::")+4);
		//	String cn = cell.substring(cell.lastIndexOf(".")+1,cell.length());
		if (poljaa==1 ) {
			retu +="<li>"+key+"</li>\r\n";
		}
		}
		 
		
		}
		if (!retu.equals("")) {
		
		return "<ul>"+retu+"</ul>";
		}
		else {
		return retu;
		}
	}






	public String clonirajClassTree(com.popultrade.webapp.ContextUtil contextUtil,HttpServletRequest request,com.popultrade.webapp.control control,com.popultrade.webapp.conPool ConPool) {
		
		String ven = "";
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
	
		
		if (!obstaja) {
			
		

			
			
			ven +="<body>\r\n";
		ven += "<ul class=\"tree\"><li>"+ime+"</li>\r\n";
		 ven += (digIn(ime,"NOBENACLASA","",2,0,"",1)); /// 
		 ven += "</ul>\r\n";
		 
		 
		System.out.println(ven);
		
		
		///////////////////////////////////////////////
		///////////////////////////////////////////////
		///////////////////////////////////////////////
		///////////////////////////////////////////////
		}
		
		}
		catch (Exception ed) {
		
		System.out.println("------------- "+ed.toString());
		}
		
		
				
			return ven;	
		
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
	
	%>
	<html>
	
	<style >

 ul.tree, ul.tree ul {
     list-style-type: none;
     background: url(vline.png) repeat-y;
     margin: 0;
     padding: 0;
   }
   
   ul.tree ul {
     margin-left: 10px;
   }

   ul.tree li {
     margin: 0;
     padding: 0 12px;
     line-height: 25px;
     background: url(node.png) no-repeat;
    // color: #369;
   //  font-weight: bold;
   font-family:verdana;
   }

   ul.tree li.last {
     background: #fff url(lastnode.png) no-repeat;
   }
   
   ul.tree li:last-child {
     background: #fff url(lastnode.png) no-repeat;
   }
			   
	</style>
	   <script type="text/javascript">
    window.onload = function () {
      var tree = document.getElementById("tree");
      var lists = [ tree ];
     
      for (var i = 0; i < tree.getElementsByTagName("ul").length; i++)
        lists[lists.length] = tree.getElementsByTagName("ul")[i];

      for (var i = 0; i < lists.length; i++) {
        var item = lists[i].lastChild;
     	 
        while (!item.tagName || item.tagName.toLowerCase() != "li")
     	  item = item.previousSibling;

        item.className += " last";
      }
    };
   </script>
	<body>
	
	<%=clonirajClassTree(contextUtil,request,control,ConPool)%>
	</body>
	</html>
	<%

	

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>