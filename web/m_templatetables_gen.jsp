<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="antexecutor" scope="request" class="com.popultrade.webapp.AntExecutor" />
 


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



<%!


public boolean createNoSqlDAO(String imecl,Hashtable nosql,String imefilee,com.popultrade.webapp.control control) {
	
	StringBuffer  daoo = new StringBuffer();
      
      
	  //  String imecl = (vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1));
	      
	    
	    daoo.append("package com.popultrade.dao;\r\n");

	    daoo.append("import java.util.Date;\r\n");
	    daoo.append("import java.util.List;\r\n");

	    daoo.append("import javax.persistence.Column;\r\n");
	    daoo.append("import javax.persistence.ElementCollection;\r\n");
	    daoo.append(" import javax.persistence.Entity;\r\n");
	    daoo.append("import javax.persistence.EntityManager;\r\n");
	    daoo.append("import javax.persistence.GeneratedValue;\r\n");
	    daoo.append("import javax.persistence.Id;\r\n");
	    daoo.append("import javax.persistence.NamedQuery;\r\n");
	    daoo.append("import javax.persistence.Table;\r\n");
	    daoo.append("import javax.persistence.Persistence;\r\n");
	    daoo.append("import javax.persistence.EntityManagerFactory;\r\n");
	    daoo.append("import com.popultrade.model."+imecl+";\r\n");
	    daoo.append("import com.popultrade.model.CreateLogFromClass;\r\n");
	    daoo.append("import java.io.ByteArrayInputStream;\r\n");
		daoo.append("import java.io.ByteArrayOutputStream;\r\n");
		daoo.append("import java.io.IOException;\r\n");
		daoo.append("import java.io.ObjectInputStream;\r\n");
		daoo.append("import java.io.ObjectOutputStream;\r\n");
		daoo.append("import java.text.*;\r\n");
		daoo.append("import java.util.*;\r\n");
		daoo.append("import org.hibernate.annotations.Fetch;\r\n");
		daoo.append("import org.hibernate.annotations.FetchMode;\r\n");
	    daoo.append("public class "+imecl+"DAO {\r\n");

	  nosql.put("com.popultrade.model."+imecl, "")    ;
	    	

	    	daoo.append("public "+imecl+" get"+imecl+"(String id,EntityManagerFactory emm) {\r\n");
	    		
	    		
	    		daoo.append("EntityManager em = emm.createEntityManager();\r\n");
	    		
	    		
	    		daoo.append(""+imecl+" la = em.find("+imecl+".class, id);\r\n");
	    	//	daoo.append("em.close();\r\n");
	    		daoo.append("return la;\r\n");
	    		
	    		daoo.append("}\r\n");
	    	
	    	
	    		
	    		daoo.append("public Object cloneObject(Object objSource) {\r\n");
	    			daoo.append("Object objDest=null;\r\n");
	    			daoo.append("try {\r\n");
	    				daoo.append("ByteArrayOutputStream bos = new ByteArrayOutputStream();\r\n");
	    				daoo.append("ObjectOutputStream oos = new ObjectOutputStream(bos);\r\n");
	    				daoo.append("oos.writeObject(objSource);\r\n");
	    				daoo.append("oos.flush();\r\n");
	    				daoo.append("oos.close();\r\n");
	    				daoo.append("bos.close();\r\n");
	    				daoo.append("byte[] byteData = bos.toByteArray();\r\n");
	    				daoo.append("ByteArrayInputStream bais = new ByteArrayInputStream(byteData);\r\n");
	    				
	    				daoo.append("try {\r\n");
	    					daoo.append("objDest = new ObjectInputStream(bais).readObject();\r\n");
	    					daoo.append("} catch (ClassNotFoundException e) {\r\n");
	    					daoo.append("e.printStackTrace();\r\n");
	    					daoo.append("}\r\n");
	    				daoo.append("} catch (IOException e) {\r\n");
	    				daoo.append("e.printStackTrace();\r\n");
	    				daoo.append("}\r\n");
	    			daoo.append("return objDest;\r\n");

	    			daoo.append("}\r\n");
	    		
	    		
	    		
	    		
	    		
	    		
	    		
	    		
	    		
	    		daoo.append("public boolean save"+imecl+"("+imecl+" la,EntityManagerFactory emm) {\r\n");
	    			daoo.append("try {\r\n");
	    				daoo.append("EntityManager em = emm.createEntityManager();\r\n");
	    				//daoo.append("if (la.getId()==null || la.getId().equals(\"\")) {\r\n");
	    				daoo.append("em.getTransaction().begin();\r\n");
	    				daoo.append("System.out.println(\"DODAM V BAZOoooooooooooooooooooooo\"+la.getId());\r\n");
	    				daoo.append("if (la.getId()==null || la.getId().equals(\"\")) {\r\n");
	    				daoo.append("la.setId(null);\r\n");
	    				
	    				//daoo.append("em.merge(la);\r\n");
	    			daoo.append("em.persist(la);\r\n");
	    				daoo.append("}\r\n");
	    				daoo.append("else {\r\n");
	    				daoo.append("em.merge(la);\r\n");
	    				daoo.append("}\r\n");
	    			daoo.append("em.getTransaction().commit();\r\n");

	    					daoo.append("em.close();\r\n");
	    			//daoo.append("em.merge(la);\r\n");
	    			daoo.append("return true;\r\n");
	    			daoo.append("}\r\n");
	    			daoo.append("catch (Exception exmo) {\r\n");
	    				daoo.append("exmo.printStackTrace();\r\n");
	    			daoo.append("}\r\n");
	    			daoo.append("return true;\r\n");
	    			daoo.append("}\r\n");
	    			
	    			
	    			
	    			daoo.append("public void remove"+imecl+"(String id,EntityManagerFactory emm) {\r\n");

	    				
	    				daoo.append("EntityManager em = emm.createEntityManager();\r\n");
	    				
	    				daoo.append("em.getTransaction().begin();\r\n");
	    				
	    				daoo.append(""+imecl+" la = this.get"+imecl+"(id, emm);\r\n");
	    				
	    				daoo.append("la = em.merge(la);\r\n");
	    				
	    				daoo.append("em.remove(la);\r\n");
	    				
	    				//daoo.append("em.remove(this.get"+imecl+"(id, emm));\r\n");
	    				
	    				
	    				
	    				daoo.append("em.getTransaction().commit();\r\n");

    					daoo.append("em.close();\r\n");
	    				daoo.append("}\r\n");
	    			
	    			
	    		
	    		 
    	    	daoo.append("public int getSt"+imecl+"("+imecl+" la,EntityManagerFactory emm) {\r\n");
    	    		
    	    		
    	    
    	    	
    	    		daoo.append("EntityManager em = emm.createEntityManager();\r\n");
    	    		
    	    		daoo.append("CreateLogFromClass clc = new CreateLogFromClass();\r\n");
    	    		//daoo.append("System.out.println(\"\"+clc.getSearchFromClass((Object)la)+\"\");\r\n");
    	    		//List lis =em.createQuery( "from LogAll where status='1'", com.popultrade.webapp.modelnosql.LogAll.class ).getResultList(); // em.createNativeQuery("db.logall.find("+clc.getSearchFromClass((Object)la, ConPool)+")" , LogAll.class ).getResultList();
    	    	daoo.append("Object lis =em.createNativeQuery( \"db."+imecl.toLowerCase()+".count({\"+clc.getSearchFromClass((Object)la).replace(\"'id'\",\"'_id'\")+\"})\" ).getSingleResult();\r\n");
    	    		//daoo.append("	System.out.println("2hhhh");\r\n");
    	    		
    	    		daoo.append("int vre = 0;\r\n");
    	    		daoo.append("try {\r\n");
    	    			daoo.append("vre = Integer.parseInt(lis.toString());\r\n");
    	    		daoo.append("}\r\n");
    	    		daoo.append("catch (Exception ecm) {\r\n");
    	    			daoo.append("}\r\n");
    	    			daoo.append("em.close();\r\n");
    	    		daoo.append("return vre;\r\n");
    	    		
    	    		daoo.append("}\r\n");
    	    	
	    		
	    		
	    		
	    		
	    		
	    		
	    	 
	    	daoo.append("public List<"+imecl+"> get"+imecl+"s("+imecl+" la,EntityManagerFactory emm,String orderb,final int pageNumber,final int pageSize) {\r\n");
	    		
	    		
	    	//String orderb="";
	    	daoo.append("String orderk = \"\";\r\n");
	    	daoo.append("if (orderb!=null && !orderb.equals(\"\")) {\r\n");
	    	
	    		daoo.append("orderb = orderb.replaceAll(\" \", \"\");\r\n");
	    		
	    		daoo.append("if (orderb.indexOf(\",\")!=-1) {\r\n");
	    		
	    			daoo.append("String[] orde = orderb.split(\",\");\r\n");
	    		
	    			daoo.append("boolean nomk = false;\r\n");
	    			
	    		daoo.append("for (int k=0;k>orde.length;k++) {\r\n");
	    		
	    		daoo.append("if (!nomk) {\r\n");
	    			daoo.append("nomk=true;\r\n");
	    		
	    		daoo.append("}\r\n");
	    		daoo.append("else {\r\n");
	    			daoo.append("orderk += \",\";\r\n");	
	    			daoo.append("}\r\n");
	    		
	    			daoo.append("if (orde[k].endsWith(\"asc\")) {\r\n");
	    				daoo.append("orderk += orde[k].replace(\"asc\", \":1\");\r\n");
	    		daoo.append("}\r\n");
	    			daoo.append("else if (orde[k].endsWith(\"desc\")) {\r\n");
	    				daoo.append("orderk += orde[k].replace(\"desc\", \":-1\");\r\n");
	    		daoo.append("}\r\n");
	    			daoo.append("}\r\n");
	    		
	    		
	    		daoo.append("}\r\n");
	    		daoo.append("else {\r\n");
	    			daoo.append("if (orderb.endsWith(\"asc\")) {\r\n");
	    				daoo.append("orderk += orderb.replace(\"asc\", \":1\");\r\n");
	    	    		daoo.append("}\r\n");
	    			daoo.append("else if (orderb.endsWith(\"desc\")) {\r\n");
	    	    				daoo.append("orderk += orderb.replace(\"desc\", \":-1\");\r\n");
	    	    		daoo.append("}\r\n");
	    			
	    			daoo.append("}\r\n");
	    		
	    		daoo.append("orderk = \",$orderby:{\"+orderk+\"}\";\r\n");
	    		daoo.append("}\r\n");
	    		daoo.append("	System.out.println(orderk);\r\n");
	    	
	    		daoo.append("EntityManager em = emm.createEntityManager();\r\n");
	    		
	    		daoo.append("CreateLogFromClass clc = new CreateLogFromClass();\r\n");
	    		//daoo.append("System.out.println(""+clc.getSearchFromClass((Object)la, ConPool)+"");
	    		daoo.append("System.out.println(\"\"+clc.getSearchFromClass((Object)la)+\" ---------\");\r\n");
	    		//List lis =em.createQuery( "from LogAll where status='1'", com.popultrade.webapp.modelnosql.LogAll.class ).getResultList(); // em.createNativeQuery("db.logall.find("+clc.getSearchFromClass((Object)la, ConPool)+")" , LogAll.class ).getResultList();
	    	daoo.append("List lis =em.createNativeQuery( \"{$query:{\"+clc.getSearchFromClass((Object)la).replace(\"'id'\",\"'_id'\")+\"}\"+orderk+\"}\","+imecl+".class ).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).getResultList();\r\n");
	    		//daoo.append("	System.out.println("2hhhh");\r\n");
	    		//daoo.append("em.close();\r\n");
	    		daoo.append("return lis;\r\n");
	    		
	    		daoo.append("}\r\n");
	    	
	    	
	    	daoo.append(" }\r\n");


	    
	    
	      	try {
	      		
	      		
	    		File filex = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/");
	    		
	    		
	    	  	   if (!filex.exists()) {
	    	  	        filex.mkdirs();
	    	  	   }
	    	  	   
	    	 		String fim = imefilee;//.substring(0,imefilee.indexOf("."));
	    			
	    			fim = fim + "DAO.java";
	    	  	   
	    	    //File file = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/"+fim);
	            File file = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/"+fim);
	            
	            if (!file.exists()) {
	            file.createNewFile();
	            }
	            
	            
	            BufferedWriter output = new BufferedWriter(new FileWriter(file));
	            output.write(daoo.toString().replaceAll("////", ""));
	            output.close();
	          } catch ( IOException e ) {
	             e.printStackTrace();
	             return false;
	          }
	return true;
}











/// many toone embedablle za nosql idji so znotraj collectiona
public String narediEmbeddableMTO(com.popultrade.webapp.chkNull nul,com.popultrade.webapp.control control,com.popultrade.model.TemplateTables vseb,Hashtable nosql) {
	
	StringBuffer sbc = new StringBuffer();
	try {
	
		
	//	if ((nul.jeN(vseb.getTable_type()).equals("1"))) {
			
			
			com.popultrade.model.TemplateTables ttab = new com.popultrade.model.TemplateTables();
			
			List liko = vseb.getTemplatetables();
			
			
			Iterator itko = liko.iterator();
			
			while (itko.hasNext()) {
				
				ttab = (com.popultrade.model.TemplateTables)itko.next();
				
				
				
				if (nul.jeN(ttab.getTable_type()).equals("1")) {
				sbc.append(narediEmbeddable(nul,control,vseb));

				}
				else {
					
				
			/*	sbc.append("private List "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
			
	sbc.append("@ElementCollection(targetClass="+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");

	sbc.append("@OrderColumn(name = \"idc\")\r\n");
	
	*/
	
	sbc.append("private List "+ttab.getTable_name_hibernate().toLowerCase()+"=new ArrayList();\r\n");
	
//sbc.append("@ElementCollection(targetClass="+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");

//sbc.append("@OrderColumn(name = \"idc\")\r\n");

sbc.append("@OneToMany(cascade = CascadeType.ALL,targetEntity=com.popultrade.model."+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");


sbc.append("public List get"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"() {\r\n");
sbc.append("return "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
sbc.append("}\r\n");

sbc.append("public void set"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"(List "+ttab.getTable_name_hibernate().toLowerCase()+") {\r\n");
sbc.append("this."+ttab.getTable_name_hibernate().toLowerCase()+" = "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
sbc.append("}\r\n\r\n\r\n");		
	

	
	/*
				
	sbc.append("public List get"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"() {\r\n");
	sbc.append("return "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbc.append("}\r\n");

	sbc.append("public void set"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"(List "+ttab.getTable_name_hibernate().toLowerCase()+") {\r\n");
	sbc.append("this."+ttab.getTable_name_hibernate().toLowerCase()+" = "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbc.append("}\r\n\r\n\r\n");		
		*/		



	////////////naredim embeddeable classe


	StringBuffer sbx = new StringBuffer();


	sbx.append("package com.popultrade.model;\r\n");

	sbx.append("import javax.persistence.*;\r\n");

	//sbx.append("import org.hibernate.annotations.Formula;\r\n");
	//sbx.append("import org.hibernate.annotations.Index;\r\n");
	sbx.append("import java.io.Serializable;\r\n");
	sbx.append("import java.util.ArrayList;\r\n");
	sbx.append("import java.util.Date;\r\n");

	sbx.append("import javax.persistence.GeneratedValue;\r\n");
	sbx.append("import org.hibernate.annotations.GenericGenerator;\r\n");
	sbx.append("import javax.persistence.Column;\r\n");
	sbx.append("import javax.persistence.ElementCollection;\r\n");
	sbx.append("import javax.persistence.Entity;\r\n");
	sbx.append("import javax.persistence.GeneratedValue;\r\n");
	sbx.append("import javax.persistence.Id;\r\n");
	sbx.append("import javax.persistence.NamedQuery;\r\n");
	sbx.append("import javax.persistence.Table;\r\n");
	sbx.append("import org.hibernate.annotations.Fetch;\r\n");
	sbx.append("import org.hibernate.annotations.FetchMode;\r\n");

	sbx.append("import org.hibernate.annotations.NotFound;\r\n");
	sbx.append("import org.hibernate.annotations.NotFoundAction;\r\n");
	sbx.append("import java.util.List;\r\n\r\n");

//	sbx.append("@Embeddable\r\n");
sbx.append("@Entity \r\n");

	sbx.append("public class "+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"  implements Serializable {\r\n\r\n\r\n");



	nosql.put("com.popultrade.model."+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1)), "")    ;


	com.popultrade.model.TemplateTablesCol tcol = new com.popultrade.model.TemplateTablesCol();

	List likt = ttab.getTemplateTablesCol();
	StringBuffer sbm = new StringBuffer();
	/*sbm.append("private String id;\r\n");

	sbx.append("@Column(name=\"id\")\r\n");

	sbx.append("public String getId() {\r\n");
	sbx.append("return id;\r\n");
	sbx.append("}\r\n");

	sbx.append("public void setId(String id) {\r\n");
	sbx.append("this.id = id;\r\n");
	sbx.append("}\r\n\r\n\r\n");

*/



	
	sbm.append("private String id;\r\n");


	sbx.append("@GeneratedValue(generator = \"uuid\")\r\n");
	sbx.append("@GenericGenerator(name = \"uuid\", strategy = \"uuid2\")\r\n");
	sbx.append("@Id\r\n");
	sbx.append("@Column(name=\"id\")\r\n");

	sbx.append("public String getId() {\r\n");
	sbx.append("return id;\r\n");
	sbx.append("}\r\n");

	sbx.append("public void setId(String id) {\r\n");
	sbx.append("this.id = id;\r\n");
	sbx.append("}\r\n\r\n\r\n");

	sbx.append("@ManyToOne\r\n");
	sbm.append("private "+vseb.getTable_name_hibernate()+" "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbx.append("public "+vseb.getTable_name_hibernate()+" get"+vseb.getTable_name_hibernate().toLowerCase().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().toLowerCase().substring(1)+"() {\r\n");
	sbx.append("return "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbx.append("}\r\n");

	sbx.append("public void set"+vseb.getTable_name_hibernate().toLowerCase().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().toLowerCase().substring(1)+"("+vseb.getTable_name_hibernate()+" "+vseb.getTable_name_hibernate().toLowerCase()+") {\r\n");
	sbx.append("this."+vseb.getTable_name_hibernate().toLowerCase()+" = "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbx.append("}\r\n\r\n\r\n");
	
	
	
	

	Iterator itkt = likt.iterator();

	while (itkt.hasNext()) {
		
		tcol = (com.popultrade.model.TemplateTablesCol)itkt.next();
		
		
		//// ce je many to one , opcija ce je tabela definirana kot embedable
		
				
	 if (nul.jeNull(tcol.getH_connection_type()).equals("ManyToOne")) {
			
			sbx.append("private "+tcol.getH_connection_table()+" "+tcol.getField_name()+";\r\n");
			
		/*	String proref = "";
			if (!nul.jeNull(vsebc.getH_connection_column()).equals("")) {
				proref = ",referencedColumnName=\""+vsebc.getH_connection_column()+"\"";
			}*/
			
			sbx.append("@ManyToOne\r\n");
		//	sbc.append("@JoinColumn(name=\""+vsebc.getH_connection_property_ref()+"\""+proref+",insertable=false,updatable=false,nullable=true)\r\n");
		//	sbc.append("@NotFound(action = NotFoundAction.IGNORE)\r\n");
			
			
			sbx.append("public "+tcol.getH_connection_table()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"() {\r\n");
			sbx.append("return "+tcol.getField_name().toLowerCase()+";\r\n");
			sbx.append("}\r\n");

			sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"("+tcol.getH_connection_table()+" "+tcol.getField_name().toLowerCase()+") {\r\n");
			sbx.append("this."+tcol.getField_name().toLowerCase()+" = "+tcol.getField_name().toLowerCase()+";\r\n");
			sbx.append("}\r\n\r\n\r\n");
			
			
		
		}
	else {
		
		
		
		
		sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+";\r\n");
		
		
		String wid = "";
		if (!nul.jeNull(tcol.getWidth()).equals("") && nul.jeNull(tcol.getWidth()).indexOf(",")==-1 && nul.jeNull(tcol.getWidth()).indexOf(".")==-1) {
			
			wid = ",length="+tcol.getWidth();
		}
		if (nul.jeNull(tcol.getIs_index()).equals("1")) {
			sbx.append("@Index(name=\""+tcol.getIndex_name()+"\")\r\n");
		}
		
		
		
		
		sbx.append("@Column(name=\""+(nul.jeNull(tcol.getField_name_db()).equals("")?tcol.getField_name().toLowerCase():tcol.getField_name_db().toLowerCase())+"\""+wid+")\r\n");
		if (!nul.jeN(tcol.getAccess_field_type()).equals("")) {
			
			sbx.append(tcol.getAccess_field_type()+"\r\n");
		}
		
		sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"() {\r\n");
		sbx.append("return "+tcol.getField_name().toLowerCase()+";\r\n");
		sbx.append("}\r\n");

		sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+") {\r\n");
		sbx.append("this."+tcol.getField_name().toLowerCase()+" = "+tcol.getField_name().toLowerCase()+";\r\n");
		sbx.append("}\r\n\r\n\r\n");
		
		if (nul.jeNull(tcol.getH_type_java()).equals("String")) {
//		hashcode.append("result = prime * result + (("+tcol.getField_name().toLowerCase()+" == null) ? 0 : "+tcol.getField_name().toLowerCase()+".hashCode());\r\n");
		//equals.append("if ("+tcol.getField_name().toLowerCase()+" == null) {\r\n");
		//equals.append("if (other."+tcol.getField_name().toLowerCase()+" != null)\r\n");
		//equals.append("return false;\r\n");
		//equals.append("} else if (!"+tcol.getField_name().toLowerCase()+".equals(other."+tcol.getField_name().toLowerCase()+"))\r\n");
		//equals.append("return false;\r\n");
		}
		if (nul.jeNull(tcol.getH_type_java()).equals("Date") && nul.jeNull(tcol.getH_datefromto()).equals("1")) { //// opcija za iskenje od do
		
			sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"1;\r\n");
			sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"2;\r\n");
			
			sbx.append("@Transient\r\n");
			sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1() {\r\n");
			sbx.append("return "+tcol.getField_name().toLowerCase()+"1;\r\n");
			sbx.append("}\r\n");

			sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"1) {\r\n");
			sbx.append("this."+tcol.getField_name().toLowerCase()+"1 = "+tcol.getField_name().toLowerCase()+"1;\r\n");
			sbx.append("}\r\n\r\n\r\n");
			sbx.append("@Transient\r\n");
			sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2() {\r\n");
			sbx.append("return "+tcol.getField_name().toLowerCase()+"2;\r\n");
			sbx.append("}\r\n");

			sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"2) {\r\n");
			sbx.append("this."+tcol.getField_name().toLowerCase()+"2 = "+tcol.getField_name().toLowerCase()+"2;\r\n");
			sbx.append("}\r\n\r\n\r\n");

			
			
			
		}

	}
	}

	try {
		
		File filex = new File(control.hibernate_classes+"");
	  	   if (!filex.exists()) {
	  	        filex.mkdirs();
	  	   }
	  	   
	  	   
	    File file = new File(control.hibernate_classes+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".java");
	    
	    if (!file.exists()) {
	  
	    file.createNewFile();
	    }
	    
	    
	    BufferedWriter output = new BufferedWriter(new FileWriter(file));
	    
	    output.write(sbx.toString().replaceAll("////", ""));
	    output.write(sbm.toString().replaceAll("////", "")+"\r\n\r\n");
	    output.write("}\r\n");
	    output.close();
	  } catch ( IOException e ) {
	     e.printStackTrace();
	  }


	////////////konec naredim embeddeable classe
			
			}
			

			
		//}
		
	}
	
	}
	catch (Exception exc) {
		
		System.out.println("Error: napaka pri kreiranje embeddable embeddable class!!! "+exc.toString() );
	}
	
	
	return sbc.toString();
	
	
	
	
}



public String narediEmbeddable(com.popultrade.webapp.chkNull nul,com.popultrade.webapp.control control,com.popultrade.model.TemplateTables vseb) {
	
	StringBuffer sbc = new StringBuffer();
	try {
	
		
	//	if ((nul.jeN(vseb.getTable_type()).equals("1"))) {
			
			
			com.popultrade.model.TemplateTables ttab = new com.popultrade.model.TemplateTables();
			
			List liko = vseb.getTemplatetables();
			
			
			Iterator itko = liko.iterator();
			
			while (itko.hasNext()) {
				
				ttab = (com.popultrade.model.TemplateTables)itko.next();
				
				sbc.append("private List "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
			
	sbc.append("@ElementCollection(targetClass="+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");

	sbc.append("@OrderColumn(name = \"idc\")\r\n");
				
	sbc.append("public List get"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"() {\r\n");
	sbc.append("return "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbc.append("}\r\n");

	sbc.append("public void set"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"(List "+ttab.getTable_name_hibernate().toLowerCase()+") {\r\n");
	sbc.append("this."+ttab.getTable_name_hibernate().toLowerCase()+" = "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbc.append("}\r\n\r\n\r\n");		
				



	////////////naredim embeddeable classe


	StringBuffer sbx = new StringBuffer();


	sbx.append("package com.popultrade.model;\r\n");

	sbx.append("import javax.persistence.*;\r\n");

	//sbx.append("import org.hibernate.annotations.Formula;\r\n");
	//sbx.append("import org.hibernate.annotations.Index;\r\n");
	sbx.append("import java.io.Serializable;\r\n");
	sbx.append("import java.util.ArrayList;\r\n");
	sbx.append("import java.util.Date;\r\n");

	sbx.append("import javax.persistence.GeneratedValue;\r\n");
	sbx.append("import org.hibernate.annotations.GenericGenerator;\r\n");
	sbx.append("import javax.persistence.Column;\r\n");
	sbx.append("import javax.persistence.ElementCollection;\r\n");
	sbx.append("import javax.persistence.Entity;\r\n");
	sbx.append("import javax.persistence.GeneratedValue;\r\n");
	sbx.append("import javax.persistence.Id;\r\n");
	sbx.append("import javax.persistence.NamedQuery;\r\n");
	sbx.append("import javax.persistence.Table;\r\n");
	sbx.append("import org.hibernate.annotations.Fetch;\r\n");
	sbx.append("import org.hibernate.annotations.FetchMode;\r\n");

	sbx.append("import org.hibernate.annotations.NotFound;\r\n");
	sbx.append("import org.hibernate.annotations.NotFoundAction;\r\n");
	sbx.append("import java.util.List;\r\n\r\n");

	sbx.append("@Embeddable\r\n");

	sbx.append("public class "+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"  implements Serializable {\r\n\r\n\r\n");





	com.popultrade.model.TemplateTablesCol tcol = new com.popultrade.model.TemplateTablesCol();

	List likt = ttab.getTemplateTablesCol();
	StringBuffer sbm = new StringBuffer();
	sbm.append("private String id;\r\n");

	sbx.append("@Column(name=\"id\")\r\n");

	sbx.append("public String getId() {\r\n");
	sbx.append("return id;\r\n");
	sbx.append("}\r\n");

	sbx.append("public void setId(String id) {\r\n");
	sbx.append("this.id = id;\r\n");
	sbx.append("}\r\n\r\n\r\n");



	Iterator itkt = likt.iterator();

	while (itkt.hasNext()) {
		
		tcol = (com.popultrade.model.TemplateTablesCol)itkt.next();
		
		
		
		
		
		sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+";\r\n");
		
		
		String wid = "";
		if (!nul.jeNull(tcol.getWidth()).equals("") && nul.jeNull(tcol.getWidth()).indexOf(",")==-1 && nul.jeNull(tcol.getWidth()).indexOf(".")==-1) {
			
			wid = ",length="+tcol.getWidth();
		}
		if (nul.jeNull(tcol.getIs_index()).equals("1")) {
			sbx.append("@Index(name=\""+tcol.getIndex_name()+"\")\r\n");
		}
		
		
		
		
		sbx.append("@Column(name=\""+(nul.jeNull(tcol.getField_name_db()).equals("")?tcol.getField_name().toLowerCase():tcol.getField_name_db().toLowerCase())+"\""+wid+")\r\n");
		if (!nul.jeN(tcol.getAccess_field_type()).equals("")) {
			
			sbx.append(tcol.getAccess_field_type()+"\r\n");
		}
		
		sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"() {\r\n");
		sbx.append("return "+tcol.getField_name().toLowerCase()+";\r\n");
		sbx.append("}\r\n");

		sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+") {\r\n");
		sbx.append("this."+tcol.getField_name().toLowerCase()+" = "+tcol.getField_name().toLowerCase()+";\r\n");
		sbx.append("}\r\n\r\n\r\n");
		
		if (nul.jeNull(tcol.getH_type_java()).equals("String")) {
//		hashcode.append("result = prime * result + (("+tcol.getField_name().toLowerCase()+" == null) ? 0 : "+tcol.getField_name().toLowerCase()+".hashCode());\r\n");
		//equals.append("if ("+tcol.getField_name().toLowerCase()+" == null) {\r\n");
		//equals.append("if (other."+tcol.getField_name().toLowerCase()+" != null)\r\n");
		//equals.append("return false;\r\n");
		//equals.append("} else if (!"+tcol.getField_name().toLowerCase()+".equals(other."+tcol.getField_name().toLowerCase()+"))\r\n");
		//equals.append("return false;\r\n");
		}
		if (nul.jeNull(tcol.getH_type_java()).equals("Date") && nul.jeNull(tcol.getH_datefromto()).equals("1")) { //// opcija za iskenje od do
		
			sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"1;\r\n");
			sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"2;\r\n");
			
			sbx.append("@Transient\r\n");
			sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1() {\r\n");
			sbx.append("return "+tcol.getField_name().toLowerCase()+"1;\r\n");
			sbx.append("}\r\n");

			sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"1) {\r\n");
			sbx.append("this."+tcol.getField_name().toLowerCase()+"1 = "+tcol.getField_name().toLowerCase()+"1;\r\n");
			sbx.append("}\r\n\r\n\r\n");
			sbx.append("@Transient\r\n");
			sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2() {\r\n");
			sbx.append("return "+tcol.getField_name().toLowerCase()+"2;\r\n");
			sbx.append("}\r\n");

			sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"2) {\r\n");
			sbx.append("this."+tcol.getField_name().toLowerCase()+"2 = "+tcol.getField_name().toLowerCase()+"2;\r\n");
			sbx.append("}\r\n\r\n\r\n");

			
			
			
		}

		
	}

	try {
		
		File filex = new File(control.hibernate_classes+"");
	  	   if (!filex.exists()) {
	  	        filex.mkdirs();
	  	   }
	  	   
	  	   
	    File file = new File(control.hibernate_classes+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".java");
	    
	    if (!file.exists()) {
	  
	    file.createNewFile();
	    }
	    
	    
	    BufferedWriter output = new BufferedWriter(new FileWriter(file));
	    
	    output.write(sbx.toString().replaceAll("////", ""));
	    output.write(sbm.toString().replaceAll("////", "")+"\r\n\r\n");
	    output.write("}\r\n");
	    output.close();
	  } catch ( IOException e ) {
	     e.printStackTrace();
	  }


	////////////konec naredim embeddeable classe
			
			}
			

			
		//}
		
		
	
	}
	catch (Exception exc) {
		
		System.out.println("Error: napaka pri kreiranje embeddable embeddable class!!! "+exc.toString() );
	}
	
	
	return sbc.toString();
	
	
	
	
}



%>


















<%

// stevilo prikazov vrstic

int stpri = 100;



// barve vrstic
String[] colors = {"plava1","plava2","silver"};





// stevilo vrstic
int stvrstic=0;

boolean iskanje = false;


try {

	
	
	
	
	
	
	StringBuffer valuee = new StringBuffer();
	StringBuffer beann = new StringBuffer();
	Hashtable nosql = new Hashtable();
	
	//// odstranim obstojece razen neodstranljivve, admin modul tabele
	
		
	String[] dire = new String[3];
	
	dire[0] = control.hibernate_classes+"";
	dire[1] = control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model")) + "dao/";
	dire[2] = control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model")) + "dao/hibernate/";
			
	
	for (int i=0;i<3;i++) {
	
	File folder = new File(dire[i]);
	   for (final File fileEntry : folder.listFiles()) {
        if (fileEntry.isDirectory()) {
           
        } else {
        	
        	if (fileEntry.getName().indexOf("Template")==-1 && fileEntry.getName().indexOf("Users")==-1 
        			&& fileEntry.getName().indexOf("Uploads")==-1
        			&& fileEntry.getName().indexOf("Prevodi")==-1
        			&& fileEntry.getName().indexOf("Jeziki")==-1
        			&& fileEntry.getName().indexOf("FrameSize")==-1
        			&& fileEntry.getName().indexOf("CreateLogFromClass")==-1
        			&& fileEntry.getName().indexOf("Base")==-1
        			&& fileEntry.getName().indexOf("Obvestila")==-1
        			&& fileEntry.getName().indexOf("Codes")==-1
        			&& fileEntry.getName().indexOf("Wse_prijave")==-1
        			&& fileEntry.getName().indexOf("OpenSessionInViewFilter")==-1
        			&& !fileEntry.getName().startsWith("DAO")) {
        		fileEntry.delete();
        		
        	}
        	else { /// dodam v xml za hibernate
        		//System.out.println("FILESSSSSSSSSS ::: "+fileEntry.getName());
        		if (i==0 && fileEntry.getName().indexOf("Base")==-1 && fileEntry.getName().indexOf("OpenSessionInViewFilter")==-1 && fileEntry.getName().indexOf("CreateLogFromClass")==-1) {
        		//cons_class.put(fileEntry.getName().substring(0,fileEntry.getName().lastIndexOf(".")), "");
        		
        		String namee = fileEntry.getName().substring(0,fileEntry.getName().lastIndexOf("."));
        		
        		
        		 
        			valuee.append("<value>com.popultrade.model."+namee+"</value>\r\n");
        			beann.append("<bean id=\""+(namee.substring(0,1).toLowerCase()+namee.substring(1))+"DAO\" class=\"com.popultrade.dao.hibernate."+namee+"DAOHibernate\" autowire=\"byName\"/>\r\n");
        		 
        		
        		
        		
        		}
        		
        	}
        	
          //  System.out.println(fileEntry.getName());
            
            
        }
    }
	
	}
	
	
	
	
	
	
	
	
	
	
// get list from daoobject
com.popultrade.dao.TemplateTablesDAO dao = (com.popultrade.dao.TemplateTablesDAO)contextUtil.getBeanDao("templateTablesDAO",pageContext.getServletContext());
com.popultrade.dao.TemplateTablesColDAO daop = (com.popultrade.dao.TemplateTablesColDAO)contextUtil.getBeanDao("templateTablesColDAO",pageContext.getServletContext());

 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	//dao.removeTemplateTables(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateTables",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateTables")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateTables")+"");
	}
	}


com.popultrade.model.TemplateTables sif = new com.popultrade.model.TemplateTables();
int strec = dao.getStTemplateTables(sif,"");
sif.setId_nad(new Long(request.getParameter("idg")));



com.popultrade.webapp.generator gen = new com.popultrade.webapp.generator();

List lis =null;

lis = dao.getTemplateTabless(sif,pagenum,5000,"","table_name_hibernate","asc");

/// dam notri reverse od onetoone za dodat v datoteke kasneje
Hashtable onetoone = new Hashtable();



Iterator it = lis.iterator();
int stej = 1;
while (it.hasNext()) {
	
	com.popultrade.model.TemplateTables vseb = (com.popultrade.model.TemplateTables)it.next();
	String imefile = (vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+".java";
	
	////////// naredim datoteke, ki rabim in shranim na disk
	
	if ((!nul.jeN(vseb.getTable_type()).equals("1"))) {
	valuee.append("<value>com.popultrade.model."+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+"</value>\r\n");
	beann.append("<bean id=\""+(vseb.getTable_name_hibernate().substring(0,1).toLowerCase()+vseb.getTable_name_hibernate().substring(1))+"DAO\" class=\"com.popultrade.dao.hibernate."+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+"DAOHibernate\" autowire=\"byName\"/>\r\n");
	}
	
	StringBuffer sb = new StringBuffer();
	
	
	sb.append("package com.popultrade.model;\r\n");

	sb.append("import javax.persistence.*;\r\n");

	sb.append("import org.hibernate.annotations.Formula;\r\n");
	sb.append("import org.hibernate.annotations.Index;\r\n");
	sb.append("import java.io.Serializable;\r\n");
	sb.append("import java.util.ArrayList;\r\n");
	sb.append("import java.util.Date;\r\n");

	if ((nul.jeN(vseb.getTable_type()).equals("1"))) {
	sb.append("import javax.persistence.GeneratedValue;\r\n");
	sb.append("import org.hibernate.annotations.GenericGenerator;\r\n");
	sb.append("import javax.persistence.Column;\r\n");
	sb.append("import javax.persistence.ElementCollection;\r\n");
	sb.append("import javax.persistence.Entity;\r\n");
	sb.append("import javax.persistence.GeneratedValue;\r\n");
	sb.append("import javax.persistence.Id;\r\n");
	sb.append("import javax.persistence.NamedQuery;\r\n");
	sb.append("import javax.persistence.Table;\r\n");
	}
	sb.append("import org.hibernate.annotations.Fetch;\r\n");
	sb.append("import org.hibernate.annotations.FetchMode;\r\n");
	sb.append("import org.hibernate.annotations.NotFound;\r\n");
	sb.append("import org.hibernate.annotations.NotFoundAction;\r\n");
	sb.append("import java.util.List;\r\n\r\n");

	sb.append("@Entity\r\n");
	sb.append("@Table (name=\""+vseb.getTable_name().toLowerCase()+"\")\r\n\r\n");

if ((nul.jeN(vseb.getTable_type()).equals("1"))) {
	sb.append("public class "+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+"  implements Serializable {\r\n\r\n\r\n");
	
}
else {
	sb.append("public class "+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+" extends BaseObject implements Serializable {\r\n\r\n\r\n");
	}
	
	if ((!nul.jeN(sif.getTable_type()).equals("1"))) {
		
	sb.append("private static final long serialVersionUID = "+gen.getKodoNumber6()+gen.getKodoNumber6()+gen.getKodoNumber6()+"L;\r\n");
	}
	
	/// polja
	
	
	com.popultrade.model.TemplateTablesCol sifc = new com.popultrade.model.TemplateTablesCol();
	sifc.setId_nad(vseb.getId());
	
	List cols = daop.getTemplateTablesCols(sifc, 1, 150, "", "field_name", "desc");
	
	Iterator itc = cols.iterator();
	
	StringBuffer sbc = new StringBuffer();
	StringBuffer hashcode = new StringBuffer();
	StringBuffer equals = new StringBuffer();
	StringBuffer criteriaa = new StringBuffer();
	StringBuffer crii = new StringBuffer();
	
	
	
	
	while (itc.hasNext()) {
		stej++;
		
		com.popultrade.model.TemplateTablesCol vsebc = (com.popultrade.model.TemplateTablesCol)itc.next();
		
		
		System.out.println("------------ ::::::::::::: 1");
		
		
		if (nul.jeNull(vsebc.getIs_primarykey()).equals("1")) {
			
			
			sb.append("private "+vsebc.getH_type_java()+" "+vsebc.getField_name()+";\r\n");
			
			
			
			if (nul.jeN(vseb.getTable_type()).equals("1")) {
			
			sbc.append("@GeneratedValue(generator = \"uuid\")\r\n");
			sbc.append("@GenericGenerator(name = \"uuid\", strategy = \"uuid2\")\r\n");
			sbc.append("@Id\r\n");
				
			}
			else {
			sbc.append("@Id\r\n");
			sbc.append("@Column(name=\""+(nul.jeNull(vsebc.getField_name_db()).equals("")?vsebc.getField_name().toLowerCase():vsebc.getField_name_db().toLowerCase())+"\")\r\n");
			sbc.append("@SequenceGenerator(name=\""+vsebc.getSequence_name()+"\", sequenceName=\""+vsebc.getSequence_name()+"\",allocationSize=1)\r\n");
			sbc.append("@GeneratedValue(strategy = GenerationType."+vsebc.getIncrement_type()+" ,generator=\""+vsebc.getSequence_name()+"\")\r\n");
			}
			
			
			
			sbc.append("public "+vsebc.getH_type_java()+" get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"() {\r\n");
			sbc.append("return "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n");

			sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"("+vsebc.getH_type_java()+" "+vsebc.getField_name().toLowerCase()+") {\r\n");
			sbc.append("this."+vsebc.getField_name().toLowerCase()+" = "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n\r\n\r\n");
			
			hashcode.append("result = prime * result + (("+vsebc.getField_name().toLowerCase()+" == null) ? 0 : "+vsebc.getField_name().toLowerCase()+".hashCode());\r\n");
			
			equals.append("if ("+vsebc.getField_name().toLowerCase()+" == null) {\r\n");
			equals.append("if (other."+vsebc.getField_name().toLowerCase()+" != null)\r\n");
			equals.append("return false;\r\n");
			equals.append("} else if (!"+vsebc.getField_name().toLowerCase()+".equals(other."+vsebc.getField_name().toLowerCase()+"))\r\n");
			equals.append("return false;\r\n");
			
		}
		
		
		else if (!nul.jeNull(vsebc.getH_property_formula()).equals("")) {
		
			
			sb.append("private "+vsebc.getH_type_java()+" "+vsebc.getField_name()+";\r\n");
			
			sbc.append("@Formula(\""+vsebc.getH_property_formula()+" \")\r\n");

			
			sbc.append("@Basic(fetch = FetchType.LAZY)\r\n");
			
			

			sbc.append("public "+vsebc.getH_type_java()+" get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"() {\r\n");
			sbc.append("return "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n");

			sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"("+vsebc.getH_type_java()+" "+vsebc.getField_name().toLowerCase()+") {\r\n");
			sbc.append("this."+vsebc.getField_name().toLowerCase()+" = "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n\r\n\r\n");
			
		
		}
		else if (nul.jeNull(vsebc.getH_connection_type()).equals("")) {
		
		sb.append("private "+vsebc.getH_type_java()+" "+vsebc.getField_name()+";\r\n");
		
		
		String wid = "";
		if (!nul.jeNull(vsebc.getWidth()).equals("") && nul.jeNull(vsebc.getWidth()).indexOf(",")==-1 && nul.jeNull(vsebc.getWidth()).indexOf(".")==-1) {
			
			wid = ",length="+vsebc.getWidth();
		}
		if (nul.jeNull(vsebc.getIs_index()).equals("1")) {
			sbc.append("@Index(name=\""+vsebc.getIndex_name()+"\")\r\n");
		}
		
		
		
		
		sbc.append("@Column(name=\""+(nul.jeNull(vsebc.getField_name_db()).equals("")?vsebc.getField_name().toLowerCase():vsebc.getField_name_db().toLowerCase())+"\""+wid+")\r\n");
		if (!nul.jeN(vsebc.getAccess_field_type()).equals("")) {
			
			sbc.append(vsebc.getAccess_field_type()+"\r\n");
		}
		
		sbc.append("public "+vsebc.getH_type_java()+" get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"() {\r\n");
		sbc.append("return "+vsebc.getField_name().toLowerCase()+";\r\n");
		sbc.append("}\r\n");

		sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"("+vsebc.getH_type_java()+" "+vsebc.getField_name().toLowerCase()+") {\r\n");
		sbc.append("this."+vsebc.getField_name().toLowerCase()+" = "+vsebc.getField_name().toLowerCase()+";\r\n");
		sbc.append("}\r\n\r\n\r\n");
		
		if (nul.jeNull(vsebc.getH_type_java()).equals("String")) {
		hashcode.append("result = prime * result + (("+vsebc.getField_name().toLowerCase()+" == null) ? 0 : "+vsebc.getField_name().toLowerCase()+".hashCode());\r\n");
		equals.append("if ("+vsebc.getField_name().toLowerCase()+" == null) {\r\n");
		equals.append("if (other."+vsebc.getField_name().toLowerCase()+" != null)\r\n");
		equals.append("return false;\r\n");
		equals.append("} else if (!"+vsebc.getField_name().toLowerCase()+".equals(other."+vsebc.getField_name().toLowerCase()+"))\r\n");
		equals.append("return false;\r\n");
		}
		if (nul.jeNull(vsebc.getH_type_java()).equals("Date") && nul.jeNull(vsebc.getH_datefromto()).equals("1")) { //// opcija za iskenje od do
		
			sb.append("private "+vsebc.getH_type_java()+" "+vsebc.getField_name()+"1;\r\n");
			sb.append("private "+vsebc.getH_type_java()+" "+vsebc.getField_name()+"2;\r\n");
			
			sbc.append("@Transient\r\n");
			sbc.append("public "+vsebc.getH_type_java()+" get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"1() {\r\n");
			sbc.append("return "+vsebc.getField_name().toLowerCase()+"1;\r\n");
			sbc.append("}\r\n");

			sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"1("+vsebc.getH_type_java()+" "+vsebc.getField_name().toLowerCase()+"1) {\r\n");
			sbc.append("this."+vsebc.getField_name().toLowerCase()+"1 = "+vsebc.getField_name().toLowerCase()+"1;\r\n");
			sbc.append("}\r\n\r\n\r\n");
			sbc.append("@Transient\r\n");
			sbc.append("public "+vsebc.getH_type_java()+" get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"2() {\r\n");
			sbc.append("return "+vsebc.getField_name().toLowerCase()+"2;\r\n");
			sbc.append("}\r\n");

			sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"2("+vsebc.getH_type_java()+" "+vsebc.getField_name().toLowerCase()+"2) {\r\n");
			sbc.append("this."+vsebc.getField_name().toLowerCase()+"2 = "+vsebc.getField_name().toLowerCase()+"2;\r\n");
			sbc.append("}\r\n\r\n\r\n");
			
		criteriaa.append("if ("+vseb.getTable_name_hibernate().toLowerCase()+".get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"1()!=null) {\r\n");
		criteriaa.append("criteria.add(Restrictions.ge(\""+vsebc.getField_name().toLowerCase()+"\","+vseb.getTable_name_hibernate().toLowerCase()+".get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"1()));\r\n");
		criteriaa.append("}\r\n");
		criteriaa.append("if ("+vseb.getTable_name_hibernate().toLowerCase()+".get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"2()!=null) {\r\n");
		criteriaa.append("criteria.add(Restrictions.le(\""+vsebc.getField_name().toLowerCase()+"\","+vseb.getTable_name_hibernate().toLowerCase()+".get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"2()));\r\n");
		criteriaa.append("}\r\n");
			
			
			
			
			
			
		}
		
		
		
		
		
		}
		else if (nul.jeNull(vsebc.getH_connection_type()).equals("OneToMany")) {
			
			sb.append("private List "+vsebc.getField_name()+" = new ArrayList();\r\n");
			
			String proref = "";
			if (!nul.jeNull(vsebc.getH_connection_property_ref()).equals("")) {
				proref = ",referencedColumnName=\""+vsebc.getH_connection_property_ref()+"\"";
			}
			
			
			String cass= "";
			
			if (!nul.jeN(vsebc.getH_connection_cascade()).equals("NONE")) {
				cass=	",cascade = CascadeType."+vsebc.getH_connection_cascade()+"";
			}
			
			sbc.append("@OneToMany(fetch=FetchType."+(vsebc.getH_property_formula_name()==null?"LAZY":vsebc.getH_property_formula_name())+",targetEntity=com.popultrade.model."+vsebc.getH_connection_table()+".class"+cass+")\r\n");
			if (vsebc.getH_connection_column()!=null && !vsebc.getH_connection_column().trim().equals("")) {
				sbc.append("@JoinColumn(name=\""+vsebc.getH_connection_column().trim()+"\""+proref+")\r\n");
			}
			if (!nul.jeNull(vsebc.getOrderby_relations()).equals("")) {
				sbc.append("@OrderBy(\""+vsebc.getOrderby_relations()+"\")\r\n");
			}
			

			sbc.append("public List get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"() {\r\n");
			sbc.append("return "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n");

			sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"(List "+vsebc.getField_name().toLowerCase()+") {\r\n");
			sbc.append("this."+vsebc.getField_name().toLowerCase()+" = "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n\r\n\r\n");
			
			
		
		}
		
	else if (nul.jeNull(vsebc.getH_connection_type()).equals("ManyToOne")) {
			
			sb.append("private "+vsebc.getH_connection_table()+" "+vsebc.getField_name()+";\r\n");
			
			String proref = "";
			if (!nul.jeNull(vsebc.getH_connection_column()).equals("")) {
				proref = ",referencedColumnName=\""+vsebc.getH_connection_column()+"\"";
			}
			
			sbc.append("@ManyToOne(fetch=FetchType."+(vsebc.getH_property_formula_name()==null?"LAZY":vsebc.getH_property_formula_name())+",targetEntity=com.popultrade.model."+vsebc.getH_connection_table()+".class)\r\n");
			
			if (!nul.jeN(vsebc.getH_connection_property_ref()).trim().equals("")) {
			sbc.append("@JoinColumn(name=\""+vsebc.getH_connection_property_ref()+"\""+proref+",insertable=false,updatable=false,nullable=true)\r\n");
			}
			sbc.append("@NotFound(action = NotFoundAction.IGNORE)\r\n");
			
			
			sbc.append("public "+vsebc.getH_connection_table()+" get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"() {\r\n");
			sbc.append("return "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n");

			sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"("+vsebc.getH_connection_table()+" "+vsebc.getField_name().toLowerCase()+") {\r\n");
			sbc.append("this."+vsebc.getField_name().toLowerCase()+" = "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n\r\n\r\n");
			
			
		
		}
		
		
		
		
		
		
		
		else if (nul.jeNull(vsebc.getH_connection_type()).equals("OneToOne")) {
			
			//System.out.println("----------------------------------------- CREATE ONETOONE");
			sb.append("private "+vsebc.getH_connection_table()+" "+vsebc.getField_name().toLowerCase()+";\r\n");
			
			sbc.append("@OneToOne(cascade = CascadeType."+vsebc.getH_connection_cascade()+",fetch=FetchType."+(vsebc.getH_property_formula_name()==null?"LAZY":vsebc.getH_property_formula_name())+",mappedBy=\""+vsebc.getH_mapped_by()+"\")\r\n");
			sbc.append("@NotFound(action = NotFoundAction.IGNORE)\r\n");
			
			sbc.append("public "+vsebc.getH_connection_table()+" get"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"() {\r\n");
			sbc.append("return "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n");


			sbc.append("public void set"+(vsebc.getField_name().substring(0,1).toUpperCase()+vsebc.getField_name().substring(1))+"("+vsebc.getH_connection_table()+" "+vsebc.getField_name().toLowerCase()+") {\r\n");
			sbc.append("this."+vsebc.getField_name().toLowerCase()+" = "+vsebc.getField_name().toLowerCase()+";\r\n");
			sbc.append("}\r\n\r\n\r\n");
			
			String reverse = "";
			
			
			reverse+="private "+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+" "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n";
			
			reverse+="@OneToOne\r\n";
			reverse+="@JoinColumn(name = \""+vsebc.getH_connection_column()+"\",insertable=false,updatable=false,nullable=true)\r\n";
			reverse+="@NotFound(action = NotFoundAction.IGNORE)\r\n";
			
			reverse+="public "+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+" get"+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1).toLowerCase())+"() {\r\n";
			reverse+="return "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n";
			reverse+="}\r\n";

			reverse+="public void set"+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1).toLowerCase())+"("+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+" "+vseb.getTable_name_hibernate().toLowerCase()+") {\r\n";
			reverse+="this."+vseb.getTable_name_hibernate().toLowerCase()+" = "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n";
			reverse+="}\r\n";
			
			
			
			//// reverse
			//System.out.println("----------------------------------------- CREATE ONETOONE 2 "+reverse);
			if (onetoone.containsKey(imefile)) {

				Hashtable hk = (Hashtable)onetoone.get(vsebc.getH_connection_table()+".java");
				hk.put(stej+"", reverse);
				onetoone.put(vsebc.getH_connection_table()+".java", hk);
				
			}
			else {
				Hashtable hk = new Hashtable();
				hk.put(stej+"", reverse);
				onetoone.put(vsebc.getH_connection_table()+".java", hk);
				
				
				
				
				
				
			}
			//System.out.println("----------------------------------------- CREATE ONETOONE 3");
		}

		
	}//// konec while columns
	
	
	//// naredim embedded logiko za nosql
		//System.out.println("----------------------------------------- CREATE ONETOONE 4");
	
	if ((nul.jeN(vseb.getTable_type()).equals("1"))) {
		
		//System.out.println("----------------------------------------- CREATE ONETOONE 5");
		com.popultrade.model.TemplateTables ttab = new com.popultrade.model.TemplateTables();
		
		List liko = vseb.getTemplatetables();
		
		
		Iterator itko = liko.iterator();
		
		while (itko.hasNext()) {
			
			ttab = (com.popultrade.model.TemplateTables)itko.next();
			System.out.println(ttab.getDescription()+ "------------------------------------------------------------------ xxx "+ttab.getTable_type());
			if (nul.jeNull(ttab.getTable_type()).equals("1")) {
				
			
			sbc.append("private List "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
		
sbc.append("@ElementCollection(targetClass="+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");

sbc.append("@OrderColumn(name = \"idc\")\r\n");
			
sbc.append("public List get"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"() {\r\n");
sbc.append("return "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
sbc.append("}\r\n");

sbc.append("public void set"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"(List "+ttab.getTable_name_hibernate().toLowerCase()+") {\r\n");
sbc.append("this."+ttab.getTable_name_hibernate().toLowerCase()+" = "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
sbc.append("}\r\n\r\n\r\n");		
			



////////////naredim embeddeable classe


StringBuffer sbx = new StringBuffer();


sbx.append("package com.popultrade.model;\r\n");

sbx.append("import javax.persistence.*;\r\n");

//sbx.append("import org.hibernate.annotations.Formula;\r\n");
//sbx.append("import org.hibernate.annotations.Index;\r\n");
sbx.append("import java.io.Serializable;\r\n");
sbx.append("import java.util.ArrayList;\r\n");
sbx.append("import java.util.Date;\r\n");

sbx.append("import javax.persistence.GeneratedValue;\r\n");
sbx.append("import org.hibernate.annotations.GenericGenerator;\r\n");
sbx.append("import javax.persistence.Column;\r\n");
sbx.append("import javax.persistence.ElementCollection;\r\n");
sbx.append("import javax.persistence.Entity;\r\n");
sbx.append("import javax.persistence.GeneratedValue;\r\n");
sbx.append("import javax.persistence.Id;\r\n");
sbx.append("import javax.persistence.NamedQuery;\r\n");
sbx.append("import javax.persistence.Table;\r\n");
sbx.append("import org.hibernate.annotations.Fetch;\r\n");
sbx.append("import org.hibernate.annotations.FetchMode;\r\n");

sbx.append("import org.hibernate.annotations.NotFound;\r\n");
sbx.append("import org.hibernate.annotations.NotFoundAction;\r\n");
sbx.append("import java.util.List;\r\n\r\n");

sbx.append("@Embeddable\r\n");

sbx.append("public class "+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"  implements Serializable {\r\n\r\n\r\n");





com.popultrade.model.TemplateTablesCol tcol = new com.popultrade.model.TemplateTablesCol();

List likt = ttab.getTemplateTablesCol();
StringBuffer sbm = new StringBuffer();
sbm.append("private String id;\r\n");

sbx.append("@Column(name=\"id\")\r\n");

sbx.append("public String getId() {\r\n");
sbx.append("return id;\r\n");
sbx.append("}\r\n");

sbx.append("public void setId(String id) {\r\n");
sbx.append("this.id = id;\r\n");
sbx.append("}\r\n\r\n\r\n");



Iterator itkt = likt.iterator();

while (itkt.hasNext()) {
	
	tcol = (com.popultrade.model.TemplateTablesCol)itkt.next();
	
	
	
	
	
	sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+";\r\n");
	
	
	String wid = "";
	if (!nul.jeNull(tcol.getWidth()).equals("") && nul.jeNull(tcol.getWidth()).indexOf(",")==-1 && nul.jeNull(tcol.getWidth()).indexOf(".")==-1) {
		
		wid = ",length="+tcol.getWidth();
	}
	if (nul.jeNull(tcol.getIs_index()).equals("1")) {
		sbx.append("@Index(name=\""+tcol.getIndex_name()+"\")\r\n");
	}
	
	
	
	
	sbx.append("@Column(name=\""+(nul.jeNull(tcol.getField_name_db()).equals("")?tcol.getField_name().toLowerCase():tcol.getField_name_db().toLowerCase())+"\""+wid+")\r\n");
	if (!nul.jeN(tcol.getAccess_field_type()).equals("")) {
		
		sbx.append(tcol.getAccess_field_type()+"\r\n");
	}
	
	sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"() {\r\n");
	sbx.append("return "+tcol.getField_name().toLowerCase()+";\r\n");
	sbx.append("}\r\n");

	sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+") {\r\n");
	sbx.append("this."+tcol.getField_name().toLowerCase()+" = "+tcol.getField_name().toLowerCase()+";\r\n");
	sbx.append("}\r\n\r\n\r\n");
	
	if (nul.jeNull(tcol.getH_type_java()).equals("String")) {
//	hashcode.append("result = prime * result + (("+tcol.getField_name().toLowerCase()+" == null) ? 0 : "+tcol.getField_name().toLowerCase()+".hashCode());\r\n");
	//equals.append("if ("+tcol.getField_name().toLowerCase()+" == null) {\r\n");
	//equals.append("if (other."+tcol.getField_name().toLowerCase()+" != null)\r\n");
	//equals.append("return false;\r\n");
	//equals.append("} else if (!"+tcol.getField_name().toLowerCase()+".equals(other."+tcol.getField_name().toLowerCase()+"))\r\n");
	//equals.append("return false;\r\n");
	}
	if (nul.jeNull(tcol.getH_type_java()).equals("Date") && nul.jeNull(tcol.getH_datefromto()).equals("1")) { //// opcija za iskenje od do
	
		sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"1;\r\n");
		sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"2;\r\n");
		
		sbx.append("@Transient\r\n");
		sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1() {\r\n");
		sbx.append("return "+tcol.getField_name().toLowerCase()+"1;\r\n");
		sbx.append("}\r\n");

		sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"1) {\r\n");
		sbx.append("this."+tcol.getField_name().toLowerCase()+"1 = "+tcol.getField_name().toLowerCase()+"1;\r\n");
		sbx.append("}\r\n\r\n\r\n");
		sbx.append("@Transient\r\n");
		sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2() {\r\n");
		sbx.append("return "+tcol.getField_name().toLowerCase()+"2;\r\n");
		sbx.append("}\r\n");

		sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"2) {\r\n");
		sbx.append("this."+tcol.getField_name().toLowerCase()+"2 = "+tcol.getField_name().toLowerCase()+"2;\r\n");
		sbx.append("}\r\n\r\n\r\n");

		
		
		
	}

	
}

//// embedable - embeddable

//sbx.append(narediEmbeddable(nul,control,ttab));







try {
	
	File filex = new File(control.hibernate_classes+"");
  	   if (!filex.exists()) {
  	        filex.mkdirs();
  	   }
  	   
  	   
    File file = new File(control.hibernate_classes+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".java");
    
    if (!file.exists()) {
  
    file.createNewFile();
    }
    
    
    BufferedWriter output = new BufferedWriter(new FileWriter(file));
    
    output.write(sbx.toString().replaceAll("////", ""));
    output.write(sbm.toString().replaceAll("////", "")+"\r\n\r\n");
    output.write("}\r\n");
    output.close();
  } catch ( IOException e ) {
     e.printStackTrace();
  }


////////////konec naredim embeddeable classe
		
		}
			else {
				
				
				
				sbc.append("private List "+ttab.getTable_name_hibernate().toLowerCase()+"=new ArrayList();\r\n");
			
	//sbc.append("@ElementCollection(targetClass="+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");

	//sbc.append("@OrderColumn(name = \"idc\")\r\n");

	sbc.append("@OneToMany(cascade = CascadeType.ALL,targetEntity=com.popultrade.model."+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");
	/*if (!nul.jeNull(ttab.getOrderby_relations()).equals("")) {
		sbc.append("@OrderBy(name=\""+ttab.getOrderby_relations()+"\")\r\n");
	}*/

	sbc.append("public List get"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"() {\r\n");
	sbc.append("return "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbc.append("}\r\n");

	sbc.append("public void set"+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"(List "+ttab.getTable_name_hibernate().toLowerCase()+") {\r\n");
	sbc.append("this."+ttab.getTable_name_hibernate().toLowerCase()+" = "+ttab.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbc.append("}\r\n\r\n\r\n");		
				



	////////////naredim embeddeable classe


	StringBuffer sbx = new StringBuffer();


	sbx.append("package com.popultrade.model;\r\n");

	sbx.append("import javax.persistence.*;\r\n");

	//sbx.append("import org.hibernate.annotations.Formula;\r\n");
	//sbx.append("import org.hibernate.annotations.Index;\r\n");
	sbx.append("import java.io.Serializable;\r\n");
	sbx.append("import java.util.ArrayList;\r\n");
	sbx.append("import java.util.Date;\r\n");

	sbx.append("import javax.persistence.GeneratedValue;\r\n");
	sbx.append("import org.hibernate.annotations.GenericGenerator;\r\n");
	sbx.append("import javax.persistence.Column;\r\n");
	sbx.append("import javax.persistence.ElementCollection;\r\n");
	sbx.append("import javax.persistence.Entity;\r\n");
	sbx.append("import javax.persistence.GeneratedValue;\r\n");
	sbx.append("import javax.persistence.Id;\r\n");
	sbx.append("import javax.persistence.NamedQuery;\r\n");
	sbx.append("import javax.persistence.Table;\r\n");
	sbx.append("import org.hibernate.annotations.Fetch;\r\n");
			sbx.append("import org.hibernate.annotations.FetchMode;\r\n");

	sbx.append("import org.hibernate.annotations.NotFound;\r\n");
	sbx.append("import org.hibernate.annotations.NotFoundAction;\r\n");
	sbx.append("import java.util.List;\r\n\r\n");

	//sbx.append("@Embeddable\r\n");
	sbx.append("@Entity\r\n");
	sbx.append("public class "+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+"  implements Serializable {\r\n\r\n\r\n");


	nosql.put("com.popultrade.model."+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1)), "")    ;


	com.popultrade.model.TemplateTablesCol tcol = new com.popultrade.model.TemplateTablesCol();

	List likt = ttab.getTemplateTablesCol();
	StringBuffer sbm = new StringBuffer();
	sbm.append("private String id;\r\n");


	sbx.append("@GeneratedValue(generator = \"uuid\")\r\n");
	sbx.append("@GenericGenerator(name = \"uuid\", strategy = \"uuid2\")\r\n");
	sbx.append("@Id\r\n");
	sbx.append("@Column(name=\"id\")\r\n");

	sbx.append("public String getId() {\r\n");
	sbx.append("return id;\r\n");
	sbx.append("}\r\n");

	sbx.append("public void setId(String id) {\r\n");
	sbx.append("this.id = id;\r\n");
	sbx.append("}\r\n\r\n\r\n");

	sbx.append("@ManyToOne\r\n");
	sbm.append("private "+vseb.getTable_name_hibernate()+" "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n");

	//sbc.append("@ElementCollection(targetClass="+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".class,fetch=FetchType.EAGER)\r\n");

	//sbc.append("@OrderColumn(name = \"idc\")\r\n");




	sbx.append("public "+vseb.getTable_name_hibernate()+" get"+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+"() {\r\n");
	sbx.append("return "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbx.append("}\r\n");

	sbx.append("public void set"+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+"("+vseb.getTable_name_hibernate()+" "+vseb.getTable_name_hibernate().toLowerCase()+") {\r\n");
	sbx.append("this."+vseb.getTable_name_hibernate().toLowerCase()+" = "+vseb.getTable_name_hibernate().toLowerCase()+";\r\n");
	sbx.append("}\r\n\r\n\r\n");	




	Iterator itkt = likt.iterator();

	while (itkt.hasNext()) {
		
		tcol = (com.popultrade.model.TemplateTablesCol)itkt.next();
		
		
		
		
		 if (nul.jeNull(tcol.getH_connection_type()).equals("ManyToOne")) {
				
				sbx.append("private "+tcol.getH_connection_table()+" "+tcol.getField_name()+";\r\n");
				
			/*	String proref = "";
				if (!nul.jeNull(vsebc.getH_connection_column()).equals("")) {
					proref = ",referencedColumnName=\""+vsebc.getH_connection_column()+"\"";
				}*/
				
				sbx.append("@ManyToOne\r\n");
			//	sbc.append("@JoinColumn(name=\""+vsebc.getH_connection_property_ref()+"\""+proref+",insertable=false,updatable=false,nullable=true)\r\n");
			//	sbc.append("@NotFound(action = NotFoundAction.IGNORE)\r\n");
				
				
				sbx.append("public "+tcol.getH_connection_table()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"() {\r\n");
				sbx.append("return "+tcol.getField_name().toLowerCase()+";\r\n");
				sbx.append("}\r\n");

				sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"("+tcol.getH_connection_table()+" "+tcol.getField_name().toLowerCase()+") {\r\n");
				sbx.append("this."+tcol.getField_name().toLowerCase()+" = "+tcol.getField_name().toLowerCase()+";\r\n");
				sbx.append("}\r\n\r\n\r\n");
				
				
			
			}
		else {
		
		
		
		
		sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+";\r\n");
		
		
		String wid = "";
		if (!nul.jeNull(tcol.getWidth()).equals("") && nul.jeNull(tcol.getWidth()).indexOf(",")==-1 && nul.jeNull(tcol.getWidth()).indexOf(".")==-1) {
			
			wid = ",length="+tcol.getWidth();
		}
		if (nul.jeNull(tcol.getIs_index()).equals("1")) {
			sbx.append("@Index(name=\""+tcol.getIndex_name()+"\")\r\n");
		}
		
		
		
		
		sbx.append("@Column(name=\""+(nul.jeNull(tcol.getField_name_db()).equals("")?tcol.getField_name().toLowerCase():tcol.getField_name_db().toLowerCase())+"\""+wid+")\r\n");
		if (!nul.jeN(tcol.getAccess_field_type()).equals("")) {
			
			sbx.append(tcol.getAccess_field_type()+"\r\n");
		}
		
		sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"() {\r\n");
		sbx.append("return "+tcol.getField_name().toLowerCase()+";\r\n");
		sbx.append("}\r\n");

		sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+") {\r\n");
		sbx.append("this."+tcol.getField_name().toLowerCase()+" = "+tcol.getField_name().toLowerCase()+";\r\n");
		sbx.append("}\r\n\r\n\r\n");
		
		if (nul.jeNull(tcol.getH_type_java()).equals("String")) {
//		hashcode.append("result = prime * result + (("+tcol.getField_name().toLowerCase()+" == null) ? 0 : "+tcol.getField_name().toLowerCase()+".hashCode());\r\n");
		//equals.append("if ("+tcol.getField_name().toLowerCase()+" == null) {\r\n");
		//equals.append("if (other."+tcol.getField_name().toLowerCase()+" != null)\r\n");
		//equals.append("return false;\r\n");
		//equals.append("} else if (!"+tcol.getField_name().toLowerCase()+".equals(other."+tcol.getField_name().toLowerCase()+"))\r\n");
		//equals.append("return false;\r\n");
		}
		if (nul.jeNull(tcol.getH_type_java()).equals("Date") && nul.jeNull(tcol.getH_datefromto()).equals("1")) { //// opcija za iskenje od do
		
			sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"1;\r\n");
			sbm.append("private "+tcol.getH_type_java()+" "+tcol.getField_name()+"2;\r\n");
			
			sbx.append("@Transient\r\n");
			sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1() {\r\n");
			sbx.append("return "+tcol.getField_name().toLowerCase()+"1;\r\n");
			sbx.append("}\r\n");

			sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"1("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"1) {\r\n");
			sbx.append("this."+tcol.getField_name().toLowerCase()+"1 = "+tcol.getField_name().toLowerCase()+"1;\r\n");
			sbx.append("}\r\n\r\n\r\n");
			sbx.append("@Transient\r\n");
			sbx.append("public "+tcol.getH_type_java()+" get"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2() {\r\n");
			sbx.append("return "+tcol.getField_name().toLowerCase()+"2;\r\n");
			sbx.append("}\r\n");

			sbx.append("public void set"+(tcol.getField_name().substring(0,1).toUpperCase()+tcol.getField_name().substring(1))+"2("+tcol.getH_type_java()+" "+tcol.getField_name().toLowerCase()+"2) {\r\n");
			sbx.append("this."+tcol.getField_name().toLowerCase()+"2 = "+tcol.getField_name().toLowerCase()+"2;\r\n");
			sbx.append("}\r\n\r\n\r\n");

			
			
			
		}

		}
	}

	//// embedable - embeddable

	sbx.append(narediEmbeddableMTO(nul,control,ttab,nosql));







	try {
		
		File filex = new File(control.hibernate_classes+"");
	  	   if (!filex.exists()) {
	  	        filex.mkdirs();
	  	   }
	  	   
	  	   
	    File file = new File(control.hibernate_classes+(ttab.getTable_name_hibernate().substring(0,1).toUpperCase()+ttab.getTable_name_hibernate().substring(1))+".java");
	    
	    if (!file.exists()) {
	  
	    file.createNewFile();
	    }
	    
	    
	    BufferedWriter output = new BufferedWriter(new FileWriter(file));
	    
	    output.write(sbx.toString().replaceAll("////", ""));
	    output.write(sbm.toString().replaceAll("////", "")+"\r\n\r\n");
	    output.write("}\r\n");
	    output.close();
	  } catch ( IOException e ) {
	     e.printStackTrace();
	  }


	////////////konec naredim embeddeable classe
			
				
				
				
			}
			
			
			
			
		}

		
	}
	
	
	
	
	////// naredim embedable za nosql manytoone znotraj collectiona so idji
	
/*	if ((nul.jeN(vseb.getTable_type()).equals("2"))) {
		
		
		com.popultrade.model.TemplateTables ttab = new com.popultrade.model.TemplateTables();
		
		List liko = vseb.getTemplatetables();
		
		
		Iterator itko = liko.iterator();
		
		while (itko.hasNext()) {
			
			ttab = (com.popultrade.model.TemplateTables)itko.next();
			
			
		
		}
		

		
	}*/
	
	
	
	
	/// zapisem file
	
	
	
	
	//System.out.println("----------------------------------------- CREATE ONETOONE 41");
	
	
if ((!nul.jeN(vseb.getTable_type()).equals("1"))) {
	//System.out.println("----------------------------------------- CREATE ONETOONE 42");
	sbc.append("public int hashCode() {\r\n");
	sbc.append("final int prime = 31;\r\n");
	sbc.append("int result = 1;\r\n");
	sbc.append(hashcode.toString());
	sbc.append("return result;\r\n");
	sbc.append("}\r\n\r\n\r\n");
	
	//System.out.println("----------------------------------------- CREATE ONETOONE 43");
	
	sbc.append("public boolean equals(Object obj) {\r\n");
	sbc.append("if (this == obj)\r\n");
	sbc.append("return true;\r\n");
	sbc.append("if (getClass() != obj.getClass())\r\n");
	sbc.append("return false;\r\n");
	sbc.append(""+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+" other = ("+(vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1))+") obj;\r\n");
	sbc.append(equals.toString()+"\r\n");
	sbc.append("return true;\r\n");
	sbc.append("}\r\n\r\n\r\n");
	
		
	sbc.append("public String toString() {\r\n");
	sbc.append("return null;\r\n");
	sbc.append("}\r\n\r\n\r\n");
	
}	
	
	
	try {
		//System.out.println("----------------------------------------- CREATE ONETOONE 44");
		File filex = new File(control.hibernate_classes+"");
	  	   if (!filex.exists()) {
	  	        filex.mkdirs();
	  	   }
	  	   
	  	   
        File file = new File(control.hibernate_classes+imefile);
        
        if (!file.exists()) {
      
        file.createNewFile();
        }
        
        
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(sb.toString().replaceAll("////", "")+"\r\n\r\n");
        output.write(sbc.toString().replaceAll("////", ""));
        output.write("}\r\n");
        output.close();
      } catch ( IOException e ) {
         e.printStackTrace();
      }


      ///////////////////////////////////////
      ////////////////// NAREDIM DAO
      ///////////////////////////////////////
        StringBuffer daoo = new StringBuffer();
        String imecl = (vseb.getTable_name_hibernate().substring(0,1).toUpperCase()+vseb.getTable_name_hibernate().substring(1));
        
      if ((!nul.jeN(vseb.getTable_type()).equals("1"))) {
      
  
      
    	  //System.out.println("----------------------------------------- CREATE ONETOONE 45");
     
      
    daoo.append("package com.popultrade.dao;\r\n\r\n");

    daoo.append("import java.util.List;\r\n");
    daoo.append("import java.sql.Connection;\r\n");
    daoo.append("import com.popultrade.model."+imecl+";\r\n\r\n");
    daoo.append("import org.hibernate.Session;\r\n");
    daoo.append("public interface "+imecl+"DAO extends DAO {\r\n\r\n\r\n");

	daoo.append("public List get"+imecl+"s(final "+imecl+" "+imecl.toLowerCase()+",final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);\r\n");
	daoo.append("public int getSt"+imecl+"(final "+imecl+" "+imecl.toLowerCase()+",String dodatni_sql_pogoji);\r\n");
//	daoo.append("public Connection pridobiConnectionZaProceduro();\r\n");
	//daoo.append("public "+imecl+" get"+imecl+"ByVezaId(final Long id);\r\n");
	daoo.append("public List get"+imecl+"s2(final "+imecl+" "+imecl.toLowerCase()+",final String orderby,final String orderby_smer,final String dodaten_hql);\r\n");
	daoo.append("public List get"+imecl+"s(final "+imecl+" "+imecl.toLowerCase()+",final String orderby,final String orderby_smer);\r\n");
	daoo.append("public Session getSessionProcedura();\r\n");
 
	daoo.append("public List get"+imecl+"s("+imecl+" "+imecl.toLowerCase()+");\r\n");


    daoo.append("public "+imecl+" get"+imecl+"(final Long id);\r\n");


    daoo.append("public void save"+imecl+"("+imecl+" "+imecl.toLowerCase()+");\r\n");


    daoo.append("public void remove"+imecl+"(final Long id);\r\n\r\n\r\n");
    daoo.append("}\r\n\r\n");
    //System.out.println("----------------------------------------- CREATE ONETOONE 46");
  //// zapisem dao
  
  	try {
  		
  		 //System.out.println("----------------------------------------- CREATE ONETOONE 47");
		File filex = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/");
	  	   if (!filex.exists()) {
	  	        filex.mkdirs();
	  	   }
	  	   
	 		String fim = imefile.substring(0,imefile.indexOf("."));
	 		 //System.out.println("----------------------------------------- CREATE ONETOONE 48");
			fim = fim + "DAO.java";
	  	   
	  	   
        File file = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/"+fim);
        
        if (!file.exists()) {
        file.createNewFile();
        }
        
        //System.out.println("----------------------------------------- CREATE ONETOONE 49");
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(daoo.toString().replaceAll("////", ""));
        output.close();
      } catch ( IOException e ) {
         e.printStackTrace();
      }
      
      }
      
      
      
      //System.out.println("----------------------------------------- CREATE ONETOONE 410");
      
       ///////////////////////////////////////
      ////////////////// END NAREDIM DAO
      ///////////////////////////////////////     
      
      
         ///////////////////////////////////////
      ////////////////// NAREDIM DAO ZA NoSQL
      ///////////////////////////////////////
      
       if ((nul.jeN(vseb.getTable_type()).equals("1"))) {
    	   
    	  System.out.println("-------------------------------------------------------------------------------------- 1");
    	   createNoSqlDAO( imecl, nosql, imefile.substring(0,imefile.indexOf(".")), control);
    	   
    	   System.out.println("-------------------------------------------------------------------------------------- 2");
    	   if (vseb.getTemplatetables().size()>0) {
    		   
    		   Iterator itom = vseb.getTemplatetables().iterator();
    		   
    		   while (itom.hasNext()) {
    		   
    		   com.popultrade.model.TemplateTables vsebt = (com.popultrade.model.TemplateTables)itom.next();
    		   
    		   String imm = (vsebt.getTable_name_hibernate().substring(0,1).toUpperCase()+vsebt.getTable_name_hibernate().substring(1));
    		   String imefilex = (vsebt.getTable_name_hibernate().substring(0,1).toUpperCase()+vsebt.getTable_name_hibernate().substring(1));
    		   createNoSqlDAO( imm, nosql, imefilex, control);
    		   
    		   if (vsebt.getTemplatetables().size()>0) {
        		   
        		   Iterator itomt = vsebt.getTemplatetables().iterator();
        		   
        		   while (itomt.hasNext()) {
        		   
        		   com.popultrade.model.TemplateTables vsebtt = (com.popultrade.model.TemplateTables)itomt.next();
        		   
        		   String immt = (vsebtt.getTable_name_hibernate().substring(0,1).toUpperCase()+vsebtt.getTable_name_hibernate().substring(1));
        		   String imefilext = (vsebtt.getTable_name_hibernate().substring(0,1).toUpperCase()+vsebtt.getTable_name_hibernate().substring(1));
        		   createNoSqlDAO( immt, nosql, imefilext, control);
        		   
        		   
        		   
        		   
        		   
        		   
        		   }
        	   }
    		   
    		   
    		   
    		   
    		   }
    	   }
    	   
    	   
    	   
    	   
       }
      
      
      
      ///////////////////////////////////////
      ////////////////// NAREDIM DAO ZA NoSQL END
      /////////////////////////////////////
      
      
      
    ///////////////////////////////////////
    ////////////////// NAREDIM HIBERNATE
    ///////////////////////////////////////
    if ((!nul.jeN(vseb.getTable_type()).equals("1"))) {
 daoo = new StringBuffer();
      
    
 //System.out.println("----------------------------------------- CREATE ONETOONE 411");

  daoo.append("package com.popultrade.dao.hibernate;\r\n\r\n");

daoo.append("import java.util.List;\r\n");

daoo.append("import com.popultrade.model."+imecl+";\r\n");

daoo.append("import com.popultrade.dao."+imecl+"DAO;\r\n");
daoo.append("import org.springframework.orm.ObjectRetrievalFailureException;\r\n");

daoo.append("import java.sql.Connection;\r\n");
daoo.append("import java.sql.SQLException;\r\n");

daoo.append("import org.hibernate.Criteria;\r\n");
daoo.append("import org.hibernate.HibernateException;\r\n");
daoo.append("import org.hibernate.Session;\r\n");
daoo.append("import org.hibernate.criterion.Example;\r\n");
daoo.append("import org.hibernate.criterion.MatchMode;\r\n");
daoo.append("import org.hibernate.criterion.Order;\r\n");
daoo.append("import org.hibernate.criterion.Projections;\r\n");
daoo.append("import org.hibernate.criterion.Restrictions;\r\n");
daoo.append("import org.hibernate.engine.spi.SessionFactoryImplementor;\r\n");
//daoo.append("import org.hibernate.service.jdbc.connections.spi.ConnectionProvider;\r\n");

daoo.append("import org.springframework.orm.hibernate4.HibernateCallback;\r\n\r\n\r\n");

daoo.append("public class "+imecl+"DAOHibernate extends BaseDAOHibernate implements "+imecl+"DAO {\r\n\r\n\r\n");
	

    
    
daoo.append("public List get"+imecl+"s(final "+imecl+" "+imecl.toLowerCase()+",final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {\r\n");
        //return getHibernateTemplate().find("from "+imecl+" order by datum_"+imecl+"a");

daoo.append("Example ex = Example.create("+imecl.toLowerCase()+").ignoreCase().excludeZeroes();   \r\n");  
      daoo.append("Criteria cri = currentSession().createCriteria("+imecl+".class).add(ex);\r\n");
      
      daoo.append(criteriaa.toString().replaceAll("criteria","cri"));

      
        daoo.append("if ("+imecl.toLowerCase()+".getId()!=null) {\r\n");
        	daoo.append("cri.add(Restrictions.eq(\"id\","+imecl.toLowerCase()+".getId()));\r\n");
        	daoo.append("}\r\n");

        daoo.append("if (!orderby.equals(\"\")) {\r\n");

        	daoo.append("if (orderby.indexOf(\",\")!=-1) {\r\n");
        		daoo.append("String[] yum = orderby.split(\",\");\r\n");
        	daoo.append("for (int i=0;i<yum.length;i++) {\r\n");
        		daoo.append("if (yum[i].indexOf(\" \")!=-1) {\r\n");
        			daoo.append("if (yum[i].indexOf(\"asc\")!=-1) {\r\n");
        				daoo.append("cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(\" \"))));	\r\n");
        				daoo.append("}\r\n");
        			daoo.append("else {\r\n");
        				daoo.append("cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(\" \"))));	\r\n");
        				daoo.append("}\r\n");
        			daoo.append("}\r\n");
        		daoo.append("else {\r\n");
        			daoo.append("cri.addOrder(Order.desc(yum[i].trim()));	\r\n");
        			daoo.append("}\r\n");
        		daoo.append("}\r\n");

        	daoo.append("}\r\n");
        	daoo.append("else {\r\n");
        		daoo.append("if (orderby_smer.equals(\"asc\")) {\r\n");
        		daoo.append("cri.addOrder(Order.asc(orderby));\r\n");
        daoo.append("}\r\n");
        	daoo.append("else {\r\n");
        		daoo.append("cri.addOrder(Order.desc(orderby));	\r\n");
        		daoo.append("}\r\n");
        	daoo.append("}\r\n");

        	daoo.append("}\r\n");
        daoo.append("if (!dodatni_sql_pogoji.equals(\"\")) {\r\n");
        	daoo.append("cri.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));\r\n");
        	daoo.append("}\r\n");

        daoo.append("return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();\r\n");

        daoo.append("}\r\n\r\n\r\n");

  daoo.append("public int getSt"+imecl+"(final "+imecl+" "+imecl.toLowerCase()+",String dodatni_sql_pogoji) {\r\n");
		daoo.append("try {\r\n");
			daoo.append("Example ex = Example.create("+imecl.toLowerCase()+").excludeZeroes();\r\n");
			daoo.append("Criteria criteria = currentSession().createCriteria("+imecl+".class).add(ex) ; \r\n");

			daoo.append(criteriaa.toString());
			
			daoo.append("if ("+imecl.toLowerCase()+".getId()!=null) {\r\n");
				  daoo.append(" criteria.add(Restrictions.eq(\"id\","+imecl.toLowerCase()+".getId()));\r\n");
				  daoo.append("}\r\n");
			  daoo.append("criteria.setProjection(Projections.rowCount()); \r\n");
			daoo.append("if (!dodatni_sql_pogoji.equals(\"\")) {\r\n");
				   daoo.append(" criteria.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));\r\n");
				   daoo.append("}\r\n");
			   daoo.append("return ((Long)criteria.list().get(0)).intValue(); \r\n");
			daoo.append("}\r\n");
		daoo.append("catch (Exception ex) {\r\n");
			daoo.append("org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());\r\n");
			daoo.append("log.error(ex.toString());\r\n");
			daoo.append("}\r\n");
		daoo.append("return 0;\r\n");
		daoo.append("}\r\n\r\n\r\n");

		
		
		daoo.append("public Session getSessionProcedura() {\r\n");
			
		daoo.append("return this.currentSession();\r\n");
		daoo.append("}\r\n");
		
		  //System.out.println("----------------------------------------- CREATE ONETOONE 412");
		/*
	daoo.append("public Connection pridobiConnectionZaProceduro() {\r\n");
		daoo.append("Session session = this.currentSession();\r\n");
		   daoo.append("SessionFactoryImplementor sessionFactoryImplementor = null;\r\n");
		    daoo.append(" ConnectionProvider connectionProvider = null;\r\n");
		    daoo.append("java.sql.Connection connection = null;\r\n");
		    daoo.append("try {\r\n");
		    	daoo.append("sessionFactoryImplementor = (SessionFactoryImplementor) session.getSessionFactory();\r\n");
		        daoo.append("connectionProvider = (ConnectionProvider) sessionFactoryImplementor.getConnectionProvider().getConnection();\r\n");
		        daoo.append("connection = connectionProvider.getConnection();\r\n");
		        daoo.append("} catch (SQLException e) {\r\n");
		    	daoo.append("e.printStackTrace();\r\n");
		        daoo.append("}\r\n");
		    daoo.append("return connection;\r\n");
		    daoo.append("}\r\n\r\n\r\n");
		    */
		    
	daoo.append("public List get"+imecl+"s(final "+imecl+" "+imecl.toLowerCase()+",final String orderby,final String orderby_smer) {\r\n");
    //  return getHibernateTemplate().find("from "+imecl+"");
daoo.append("if ("+imecl.toLowerCase()+" == null) {\r\n");
		daoo.append("return getHibernateTemplate().find(\"from "+imecl+"\");\r\n");
				daoo.append("} else {\r\n");
          // filter on properties set in the "+imecl.toLowerCase()+"
daoo.append("HibernateCallback callback = new HibernateCallback() {\r\n");
		daoo.append("public Object doInHibernate(Session session) throws HibernateException {\r\n");
             // System.out.println("Sifrant opis:::::::::::::::: "+"+imecl.toLowerCase()+".getSFT_SIFRA());
daoo.append("Example ex = Example.create("+imecl.toLowerCase()+").ignoreCase().enableLike(MatchMode.START);\r\n");
		daoo.append(" Criteria cri= session.createCriteria("+imecl+".class).add(ex);\r\n");
daoo.append("if (!orderby.equals(\"\")) {\r\n");
		daoo.append("if (orderby.indexOf(\",\")!=-1) {\r\n");
				daoo.append("String[] yum = orderby.split(\",\");\r\n");
    	daoo.append("for (int i=0;i<yum.length;i++) {\r\n");
    		daoo.append("if (yum[i].indexOf(\" \")!=-1) {\r\n");
    			daoo.append("if (yum[i].indexOf(\"asc\")!=-1) {\r\n");
		daoo.append("cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(\" \"))));	\r\n");
		daoo.append("}\r\n");
	daoo.append("else {\r\n");
		daoo.append("cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(\" \"))));	\r\n");
		daoo.append("}\r\n");
	daoo.append("}\r\n");
daoo.append("else {\r\n");
	daoo.append("cri.addOrder(Order.desc(yum[i].trim()));	\r\n");
	daoo.append("}\r\n");
    		daoo.append("}\r\n");
    	daoo.append("}\r\n");
    	daoo.append("else {\r\n");
    		daoo.append("if (orderby_smer.equals(\"asc\")) {\r\n");
    		daoo.append("cri.addOrder(Order.asc(orderby));\r\n");
    daoo.append("}\r\n");
    	daoo.append("else {\r\n");
    		daoo.append("cri.addOrder(Order.desc(orderby));	\r\n");
    		daoo.append("}\r\n");
    	daoo.append("}\r\n");
    	daoo.append("}\r\n");
    daoo.append("return cri.list();\r\n");
   daoo.append(" }\r\n");
daoo.append("};\r\n");
          daoo.append("return (List) getHibernateTemplate().execute(callback);\r\n");
          daoo.append("}\r\n");
      daoo.append("}\r\n\r\n\r\n");
    
    
      
      
    daoo.append("public List get"+imecl+"s2(final "+imecl+" "+imecl.toLowerCase()+",final String orderby,final String orderby_smer,final String dodaten_hql) {\r\n");
        //  return getHibernateTemplate().find("from "+imecl+"");

daoo.append("if ("+imecl.toLowerCase()+" == null) {\r\n");
daoo.append("return getHibernateTemplate().find(\"from "+imecl+"\");\r\n");
daoo.append("} else {\r\n");
              // filter on properties set in the "+imecl.toLowerCase()+"
daoo.append("HibernateCallback callback = new HibernateCallback() {\r\n");
daoo.append("public Object doInHibernate(Session session) throws HibernateException {\r\n");
                 // System.out.println("Sifrant opis:::::::::::::::: "+"+imecl.toLowerCase()+".getSFT_SIFRA());
daoo.append("Example ex = Example.create("+imecl.toLowerCase()+").ignoreCase().enableLike(MatchMode.START);\r\n");
daoo.append("Criteria cri= session.createCriteria("+imecl+".class).add(ex);\r\n");

daoo.append(criteriaa.toString().replaceAll("criteria","cri"));


daoo.append("if ("+imecl.toLowerCase()+".getId()!=null) {\r\n");
 daoo.append("cri.add(Restrictions.eq(\"id\","+imecl.toLowerCase()+".getId()));\r\n");
 daoo.append("}\r\n");
daoo.append("if (!orderby.equals(\"\")) {\r\n");
daoo.append("if (orderby.indexOf(\",\")!=-1) {\r\n");
daoo.append("String[] yum = orderby.split(\",\");\r\n");
   	daoo.append("for (int i=0;i<yum.length;i++) {\r\n");
daoo.append("if (yum[i].indexOf(\" \")!=-1) {\r\n");
daoo.append("if (yum[i].indexOf(\"asc\")!=-1) {\r\n");
daoo.append("cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(\" \"))));	\r\n");
daoo.append("}\r\n");
daoo.append("else {\r\n");
daoo.append("cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(\" \"))));\r\n");	
daoo.append("}\r\n");
daoo.append("}\r\n");
daoo.append("else {\r\n");
 daoo.append("cri.addOrder(Order.desc(yum[i].trim()));	\r\n");
 daoo.append("}\r\n");
daoo.append("}\r\n");
daoo.append("}\r\n");
daoo.append("else {\r\n");
daoo.append("if (orderby_smer.equals(\"asc\")) {\r\n");
daoo.append("cri.addOrder(Order.asc(orderby));\r\n");
daoo.append("}\r\n");
daoo.append("else {\r\n");
daoo.append("cri.addOrder(Order.desc(orderby));	\r\n");
daoo.append("}\r\n");
daoo.append("}\r\n");
daoo.append("}\r\n");
 daoo.append("if (!dodaten_hql.equals(\"\")) {\r\n");
daoo.append("cri.add(Restrictions.sqlRestriction(dodaten_hql));\r\n");
daoo.append("}\r\n");
daoo.append("return cri.list();\r\n");
daoo.append("}\r\n");
daoo.append("};\r\n");
daoo.append(" return (List) getHibernateTemplate().execute(callback);\r\n");
daoo.append("}\r\n");
daoo.append("}\r\n\r\n\r\n");


   daoo.append("public List get"+imecl+"s(final "+imecl+" "+imecl.toLowerCase()+") {\r\n");
   daoo.append("if ("+imecl.toLowerCase()+" == null) {\r\n");
   daoo.append("return getHibernateTemplate().find(\"from "+imecl+"\");\r\n");
   daoo.append("} else {\r\n");
            // filter on properties set in the "+imecl.toLowerCase()+"
daoo.append("HibernateCallback callback = new HibernateCallback() {\r\n");
   daoo.append("public Object doInHibernate(Session session) throws HibernateException {\r\n");
   daoo.append("Example ex = Example.create("+imecl.toLowerCase()+").ignoreCase().enableLike(MatchMode.START);\r\n");
   daoo.append("Criteria cri = session.createCriteria("+imecl+".class).add(ex);\r\n");
   daoo.append("if ("+imecl.toLowerCase()+".getId()!=null) {\r\n");
   daoo.append("cri.add(Restrictions.eq(\"id\","+imecl.toLowerCase()+".getId()));	\r\n");
   daoo.append("}\r\n");
   daoo.append("return cri.list();\r\n");
   daoo.append("}\r\n");
   daoo.append("};\r\n");
   daoo.append("return (List) getHibernateTemplate().execute(callback);\r\n");
   daoo.append("}\r\n");
       daoo.append("}\r\n\r\n\r\n");


     daoo.append("public "+imecl+" get"+imecl+"(final Long id) {\r\n");
    	daoo.append(imecl+" "+imecl.toLowerCase()+" = ("+imecl+") getHibernateTemplate().get("+imecl+".class, id);\r\n");
        daoo.append("if ("+imecl.toLowerCase()+" == null) {\r\n");
        	daoo.append("log.warn(\"uh oh, "+imecl.toLowerCase()+" with id '\" + id + \"' not found...\");\r\n");
            daoo.append("throw new ObjectRetrievalFailureException("+imecl+".class, id);\r\n");
            daoo.append("}\r\n");

        daoo.append("return "+imecl.toLowerCase()+";\r\n");
        daoo.append("}\r\n\r\n\r\n");

   
     daoo.append("public void save"+imecl+"(final "+imecl+" "+imecl.toLowerCase()+") {\r\n");
    	daoo.append("getHibernateTemplate().saveOrUpdate("+imecl.toLowerCase()+");\r\n");
        daoo.append("getHibernateTemplate().flush();\r\n");
        daoo.append("}\r\n\r\n\r\n");


     daoo.append("public void remove"+imecl+"(final Long id) {\r\n");
    	daoo.append("getHibernateTemplate().delete(get"+imecl+"(id));\r\n");
        daoo.append("getHibernateTemplate().flush();\r\n");
        daoo.append("}\r\n\r\n\r\n");
    daoo.append("}\r\n");
   
       
    //System.out.println("----------------------------------------- CREATE ONETOONE 413");
  	try {
  		
  		File filex = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/hibernate/");
  	   if (!filex.exists()) {
  	        filex.mkdirs();
  	   }
  	  //System.out.println("----------------------------------------- CREATE ONETOONE 414");
  	   
  		String fim = imefile.substring(0,imefile.indexOf("."));
		
		fim = fim + "DAOHibernate.java";
  	   
		  //System.out.println("----------------------------------------- CREATE ONETOONE 415");
        File file = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/hibernate/"+fim);
        
        
        if (!file.exists()) {
        file.createNewFile();
        }
        
        //System.out.println("----------------------------------------- CREATE ONETOONE 416");
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(daoo.toString().replaceAll("////", ""));
        output.close();
        //System.out.println("----------------------------------------- CREATE ONETOONE 417");
      } catch ( IOException e ) {
         e.printStackTrace();
      }
       
       
}
       
      
      
      
  ///////////////////////////////////////
  ////////////////// END NAREDIM HIBERNATE
  ///////////////////////////////////////  
      
	
  
  
    //System.out.println("----------------------------------------- CREATE ONETOONE 418");
	
	
	
}


//// dodam se onetoone reverse, ce je
  //System.out.println("----------------------------------------- CREATE ONETOONE 419");
Enumeration en = onetoone.keys();

while (en.hasMoreElements()) {
	
	String key = (String)en.nextElement();
	String celfile = "";
	 FileInputStream stream = new FileInputStream(control.hibernate_classes+key);
	    try {
	        Reader reader = new BufferedReader(new InputStreamReader(stream));
	        StringBuilder builder = new StringBuilder();
	        char[] buffer = new char[8192];
	        int read;
	        while ((read = reader.read(buffer, 0, buffer.length)) > 0) {
	            builder.append(buffer, 0, read);
	        }
	       celfile =  builder.toString();
	    } finally {
	        // Potential issue here: if this throws an IOException,
	        // it will mask any others. Normally I'd use a utility
	        // method which would log exceptions and swallow them
	        stream.close();
	    } 
	    
	    //System.out.println("----------------------------------------- CREATE ONETOONE 420 "+key);
	    //// dodam in shranim
	    	try {
        File file = new File(control.hibernate_classes+key);
        //System.out.println("----------------------------------------- CREATE ONETOONE 421 "+((Hashtable)onetoone.get(key)));
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(celfile.substring(0,celfile.lastIndexOf("}")));
        //System.out.println("----------------------------------------- CREATE ONETOONE 4211");
        
        Hashtable hlod = (Hashtable)onetoone.get(key);
        Enumeration enn = hlod.keys();
        
        while (enn.hasMoreElements()) {
        	
        String vrx = (String)enn.nextElement();
        
        output.write(hlod.get(vrx).toString());
        }
        
        //System.out.println("----------------------------------------- CREATE ONETOONE 4212");
        output.write("}\r\n");
        output.close();
        //System.out.println("----------------------------------------- CREATE ONETOONE 422");
      } catch ( IOException e ) {
         e.printStackTrace();
      }
	    
	    
	    
	
	
}

///////////////////////////////////////
//////////////////NAREDIM persistence.xml
///////////////////////////////////////  




if (nosql.size()>0) {
	
	StringBuffer daox = new StringBuffer();
	
daox.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?> <persistence version=\"2.0\" ");
daox.append("xmlns=\"http://java.sun.com/xml/ns/persistence\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" ");
daox.append("xsi:schemaLocation=\"http://java.sun.com/xml/ns/persistence  http://java.sun.com/xml/ns/persistence/persistence_2_0.xsd\"> \r\n");


daox.append("<persistence-unit name=\"com.popultrade.pers\" transaction-type=\"RESOURCE_LOCAL\">\r\n");
daox.append("<description>\r\n");

daox.append("Persistence unit for the JPA MongoDB \r\n");

daox.append("</description>  \r\n");
	
	
daox.append("<provider>org.hibernate.ogm.jpa.HibernateOgmPersistence</provider>\r\n");


Enumeration enx = nosql.keys();

while (enx.hasMoreElements()) {
	
	String nec = (String)enx.nextElement();
	
	daox.append("<class>"+nec+"</class>\r\n");
	
}

		

daox.append("<properties>\r\n");
         
            
            
daox.append("<property name=\"hibernate.ogm.datastore.provider\" value=\"mongodb\"/>\r\n");
daox.append("<property name=\"hibernate.ogm.datastore.database\" value=\""+request.getParameter("ns_database")+"\"/>\r\n");
daox.append("<property name=\"hibernate.ogm.mongodb.database\" value=\""+request.getParameter("ns_database")+"\"/>\r\n");
daox.append("<property name=\"hibernate.ogm.mongodb.host\" value=\""+request.getParameter("ns_host")+"\"/>\r\n");
daox.append("<property name=\"hibernate.ogm.mongodb.port\" value=\""+request.getParameter("ns_port")+"\"/>\r\n");

daox.append("<property name=\"hibernate.ogm.datastore.create_database\" value=\"true\"/>\r\n");
daox.append("<property name=\"hibernate.ogm.datastore.username\" value=\"todefine\"/>\r\n");
daox.append("<property name=\"hibernate.ogm.datastore.password\" value=\"todefine\"/>\r\n");

daox.append("<property name=\"hibernate.search.default.directory_provider\" value=\"filesystem\"/>\r\n");
if (request.getParameter("ns_auto")!=null) {
daox.append("<property name=\"hibernate.hbm2ddl.auto\" value=\"create\" />\r\n");
}
daox.append("<property name=\"hibernate.connection.provider_class\" value=\"org.hibernate.connection.C3P0ConnectionProvider\" />\r\n");

daox.append("<property name=\"hibernate.c3p0.max_size\" value=\"100\" />\r\n");
daox.append("<property name=\"hibernate.c3p0.min_size\" value=\"0\" />\r\n");
daox.append("<property name=\"hibernate.c3p0.acquire_increment\" value=\"1\" />\r\n");
daox.append("<property name=\"hibernate.c3p0.idle_test_period\" value=\"300\" />\r\n");
daox.append("<property name=\"hibernate.c3p0.max_statements\" value=\"0\" />\r\n");
daox.append("<property name=\"hibernate.c3p0.timeout\" value=\"100\" />\r\n");
  

daox.append("</properties>\r\n");
daox.append("</persistence-unit>\r\n");
daox.append("</persistence>\r\n");



  	try {
  		
  	
  	   
  	   
        File file = new File(control.lokacija_gen_hibernate+"persistence.xml");
        
        
        
        
        if (!file.exists()) {
        file.createNewFile();
        }
        
        
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(daox.toString().replaceAll("////", ""));
        output.close();
      } catch ( IOException e ) {
         e.printStackTrace();
      }

	
}








///////////////////////////////////////
//////////////////END NAREDIM persistence.xml
///////////////////////////////////////  








///////////////////////////////////////
////////////////// NAREDIM applicationContext-hibernate.xml
///////////////////////////////////////  

    
StringBuffer daox = new StringBuffer();
    



daox.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
daox.append("<!DOCTYPE beans PUBLIC \"-//SPRING//DTD BEAN//EN\" \"http://www.springframework.org/dtd/spring-beans.dtd\">\r\n");

daox.append("<beans>\r\n");
daox.append("<bean id=\"sessionFactory\"  class=\"org.springframework.orm.hibernate4.LocalSessionFactoryBean\">\r\n");
daox.append("<property name=\"dataSource\">\r\n");
daox.append("<ref bean=\"dataSource\"/>\r\n");
daox.append("</property>\r\n");
daox.append("<property name=\"hibernateProperties\">\r\n");
daox.append("<props>\r\n");
daox.append("<prop key=\"hibernate.dialect\">@HIBERNATE-DIALECT@</prop>\r\n");
             
if (!nul.jeNull(request.getParameter("akcijab")).equals("")) {
daox.append("<prop key=\"hibernate.hbm2ddl.auto\">"+nul.jeNull(request.getParameter("akcijab"))+"</prop> \r\n");
}


daox.append("<!-- Turn batching off for better error messages under PostgreSQL -->\r\n");
daox.append("<prop key=\"hibernate.jdbc.batch_size\">0</prop> \r\n");
		
		
if (nul.jeNull(request.getParameter("selecti")).equals("1")) {
daox.append("<prop key=\"hibernate.show_sql\">true</prop> \r\n");
}
else {
	daox.append("<prop key=\"hibernate.show_sql\">false</prop> \r\n");	
}


daox.append("<prop key=\"hibernate.use_outer_join\">true</prop> \r\n");
daox.append("<prop key=\"hibernate.cglib.use_reflection_optimizer\">false</prop> \r\n");

daox.append("</props>\r\n");
daox.append("</property>\r\n");
daox.append("<property name=\"annotatedClasses\">\r\n");
daox.append("<list>\r\n");
daox.append(valuee.toString());

daox.append("</list>\r\n");
daox.append("</property>\r\n");
daox.append("</bean>\r\n");


daox.append(beann.toString());

daox.append("</beans>\r\n");


  	try {
  		
  		File filex = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/hibernate/");
  	   if (!filex.exists()) {
  	        filex.mkdirs();
  	   }
  	   
 
  	   
  	   
  	   
        File file = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("model"))+"dao/hibernate/applicationContext-hibernate.xml");
        
        
        if (!file.exists()) {
        file.createNewFile();
        }
        
        
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(daox.toString().replaceAll("////", ""));
        output.close();
      } catch ( IOException e ) {
         e.printStackTrace();
      }

        
///////////////////////////////////////
////////////////// END NAREDIM applicationContext-hibernate.xml
///////////////////////////////////////  




//// spremenim datum generacije na glavi


com.popultrade.dao.TemplateTablesGenDAO daog = (com.popultrade.dao.TemplateTablesGenDAO)contextUtil.getBeanDao("templateTablesGenDAO",pageContext.getServletContext());
com.popultrade.model.TemplateTablesGen sifg = new com.popultrade.model.TemplateTablesGen();


sifg = daog.getTemplateTablesGen(new Long(request.getParameter("idg")));


sifg.setLast_build(new Date());

daog.saveTemplateTablesGen(sifg);



System.out.println("KLICEM ANTTTTTTTTTTTT");







%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {


parent.frames[3].location="nic.jsp";
}




</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" >

<table border="0" width="100%" cellspacing=9 id="table1" height="100%"  bgcolor=#C3E1FC	>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="0" width="100%" id="table2" height="100%" cellspacing=3 cellpadding=5  >
			
			
			
			<tr>
				<td bgcolor="#E3F1FE" align="left" valign="middle" width="99%">
				
				
		<%=antexecutor.executeAnt(control).replaceAll("\n","<br>")%>
<%




/// kopiram narejene datoteke

File diro = new File(control.lokacija_gen_hibernate+"");
if (!diro.exists()) {
	diro.mkdirs();
}

File fijar = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("src"))+"/dist/popultrade-dao.jar");

File djar = new File(control.lokacija_gen_hibernate+"popultrade-dao.jar");
if (djar.exists()) {
djar.delete();
}

fijar.renameTo(new File(control.lokacija_gen_hibernate+"popultrade-dao.jar"));

File fijarx = new File(control.hibernate_classes.substring(0,control.hibernate_classes.indexOf("src"))+"/build/dao/gen/META-INF/applicationContext-hibernate.xml");

 djar = new File(control.lokacija_gen_hibernate+"applicationContext-hibernate.xml");
if (djar.exists()) {
djar.delete();
}

fijarx.renameTo(new File(control.lokacija_gen_hibernate+"applicationContext-hibernate.xml"));





}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
	
	%><%=ex.toString()%><br><%
}

%>
			</td>
		
				</tr>
				<tr>
				<td bgcolor="#E3F1FE" align="left" valign="middle" width="99%">
				Generiran jar je znotraj direktorija (<%=control.lokacija_gen_hibernate%>).<br>
				Jar je treba kopirat v tomcat/webapps/|ime aplikacije|/WEB-INF/lib<br>
				Generiran applicationContext-hibernate.xml je znotraj direktorija (<%=control.lokacija_gen_hibernate %>).<br>
				applicationContext-hibernate.xml je treba kopirat v tomcat/webapps/|ime aplikacije|/WEB-INF/<br>&nbsp;<Br>
				Za NoSQL<br>
				Generiran persistence.xml je znotraj direktorija (<%=control.lokacija_gen_hibernate %>).<br>
				applicationContext-hibernate.xml je treba kopirat v tomcat/webapps/|ime aplikacije|/WEB-INF/classes/META-INF/<br>
				<br><b>Za kopiranje datotek mora biti tomcat ugasnjen!!!!</b>
					</td>
		
				</tr>
							<tr>
				<td bgcolor="#E3F1FE" align="left" valign="middle" width="99%">
				V primer da generacija hibernate ne dela - copiraj tools.jar iz jdk/lib v direktorij jdk/jre/lib (java mora biti vsaj 1.7)
				ali kopiraj tools.jar v tomcat/lib dir
					</td>
		
				</tr>
			
		</table>
		</td>
	</tr>
	
		<tr>
		<td align="center" valign="middle">
		</td>
		</tr>
	
	
</table>

</body>

</html>





