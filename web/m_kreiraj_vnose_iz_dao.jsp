<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />


<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
String imefile = "TemplateGumbi"; //// ime file mora biti isti kot ime class fileta zaradi kreacije insertov, prva crka velika, ce je tako ime class file ali hibernate file

try {
%>


<////%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%////>
<////jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<////jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<////jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<////jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<////jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />


<////%
////request.setCharacterEncoding(control.encoding);
////response.setContentType("text/html; charset="+control.encoding);
////response.addHeader("Pragma" , "No-cache") ;
////response.addHeader("Cache-Control", "no-cache") ;
////response.addDateHeader("Expires", 0);
////if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%////><jsp////:forward page="m_loginu.html"/><////%
////}
%////>

<////%
////try {
boolean bok=false;
com.popultrade.model.<%=imefile %> vseb =new com.popultrade.model.<%=imefile %>();
com.popultrade.dao.<%=imefile %>DAO dao = (com.popultrade.dao.<%=imefile %>DAO)contextUtil.getBeanDao("<%=imefile.toLowerCase() %>DAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.get<%=imefile %>(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.get<%=imefile %>(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}

vseb = (com.popultrade.model.<%=imefile %>)contextUtil.getPopulatedObject(vseb,request);
dao.save<%=imefile %>(vseb);

}
}

//Hashtable ht =new Hashtable();
//ht.put("id","id");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%////>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<!--%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %-->
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  onload="mom()">
<////%
////if (request.getParameter("akcija")==null) {
%////>

<form name=dod action="m_<%=imefile.toLowerCase() %>_edit.jsp" method="post" onSubmit="return check()">

<////%
////if (vseb.getId()!=null && !vseb.getId().equals("")) {
%////>
<input type=hidden name="akcija" value="UPDATE">
<////%
////}
////else {
	%////>
	<input type=hidden name="akcija" value="NEW">
	<////%	
////}
%////>

<input type=hidden name="id" value="<////%=nul.jeNull(vseb.getId()+"")%////>">

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>


<%
//// preberem file in naredim inserte

        BufferedReader  in = new BufferedReader(new InputStreamReader(new FileInputStream("c:/"+imefile+".txt"),"utf-8"));
         
          String linee="";
          String ime_polja="";
          String type_polja="";
          String length_polja="";
          //boolean jena=false;
          int stej=-1;
          
          Hashtable htdat = new Hashtable();
          int htdatst=0;
          Hashtable htdat2 = new Hashtable();
          int htdatst2=0;
          
          Hashtable checki = new Hashtable();
          int checkist=0;
          
          while ( (linee = in.readLine()) != null) {
          
if (linee.indexOf("@hibernate.property")!=-1) {
             // out.write(linee+"\r" +"\n");
              if (!ime_polja.equals("") && !type_polja.equals("")) {
            	  if (stej==-1) {
            		  stej++;
            		  %>
            		  <tr>
            		  <%
            		  
            	  }
            	  else if (stej==2) {
            		  %>
            		  </tr><tr>
            		  <%
            		  stej=0;
            		  
            	  }
            	  
            	  ///// polje
            	  
            	  if (type_polja.equals("string") && !length_polja.equals("3") && !length_polja.equals("2")) {
            		 %>
            		 <td class="opiscell" width="20%"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell" width="30%">
            		 <%
            		 if (!length_polja.equals("1")) {
            		 %>
            		 <input type="text" name="<%=ime_polja%>" <%=!length_polja.equals("")?"maxlength='"+length_polja+"'":""%> value="<////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////>" style="font-family: Verdana; font-size: 8pt">
            		 <%
            		 }
            		 else {
            		 %>
            		  <input type="checkbox" name="<%=ime_polja%>" value="1" <////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"").equals("1")?"checked":""%////> style="font-family: Verdana; font-size: 8pt">
            		  
            		 <% 
            		 
            		 /// dam v insert ali update
            		 String dodi = "vseb.set"+ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())+"(nul.jeNull(request.getParameter(\""+ime_polja+"\")).equals(\"1\")?\"1\":\"0\");";
            		 checki.put(checkist+"",dodi);
            		 checkist++;
            		 
            		 }
            		 %>
            		 
            		 </td>
            		 <% 
            	  }
            	  else if (type_polja.equals("string") && (length_polja.equals("3") || length_polja.equals("2"))  ) {
             		 %>
             		 <td class="opiscell" width="20%"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell" width="30%">
             		 
					<select name="<%=ime_polja %>" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					</select>
					
					</td>
             		 <% 
             	  }
            	  else if (type_polja.equals("text")) {
              		 %>
              		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
              		 
 					<textarea rows="6" cols="47"  name="<%=ime_polja %>"   style="font-family: Verdana; font-size: 8pt"><////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////></textarea>&nbsp;

 					
 					</td>
              		 <% 
              	  }
            	  else if (type_polja.equals("integer") || type_polja.equals("int") || type_polja.equals("Integer")) {
             		 %>
             		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
             		
             		 <input type="text" name="<%=ime_polja%>" <%=!length_polja.equals("")?"maxlength='"+length_polja+"'":""%> value="<////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 <% 
             		 String dodi = "htn.put(\""+ime_polja+"\",\""+ime_polja+"\");";
            		 checki.put(checkist+"",dodi);
            		 checkist++;
             	  }
             	  else if (type_polja.equals("double")) {
              		 %>
              		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
              		
              		 <input type="text" name="<%=ime_polja%>" <%=!length_polja.equals("")?"maxlength='"+length_polja+"'":""%> value="<////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////>" style="font-family: Verdana; font-size: 8pt">
              		
              		 
              		 </td>
              		 <% 
              		 String dodi = "htn.put(\""+ime_polja+"\",\""+ime_polja+"\");";
             		 checki.put(checkist+"",dodi);
             		 checkist++;
              	  }
            	  
            	  else if (type_polja.equals("timestamp")) {
              		 %>
              		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
            	  
            	  <input type="text" name="<%=ime_polja %>" readonly value="<////%=nul.getDatumFormatFromDateNoTime(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>())%////>" size="10"  style="font-family: Verdana; font-size: 8pt">
	 </td>
             		 <% 
             		 String kont = "if (document.dod."+ime_polja+".value!=\"\" && !checkdatum(document.dod."+ime_polja+".value)) {"+"\n"+"alert(\"Datum "+ime_polja+" je nepravilno vnesen! (Pravilen format datuma je: xx-xx-xxxx)\");"+"\n"+"return false;}";
             		 htdat.put(htdatst+"",kont);
             		htdatst++;
             		
             		kont = "dp_ca"+htdatst2+" = new Epoch('epoch_popup','popup',document.dod."+ime_polja+");";
            		 htdat2.put(htdatst2+"",kont);
            		htdatst2++;
             		
             		
             	  }
            	  
            	  ime_polja="";
            	  type_polja="";
            	  length_polja="";
            	  stej++;
              }
				//jena=true;

}

if (linee.indexOf("column=\"")!=-1) {
	ime_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
}
if (linee.indexOf("type=\"")!=-1) {
	
	type_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
	System.out.println("::::::::::::::: "+type_polja);
}
if (linee.indexOf("length=\"")!=-1) {
	length_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
}





          }
          
          
          
          
          
          
          
          
          if (!ime_polja.equals("") && !type_polja.equals("")) {
        	  if (stej==-1) {
        		  stej++;
        		  %>
        		  <tr>
        		  <%
        		  
        	  }
        	  else if (stej==2) {
        		  %>
        		  </tr><tr>
        		  <%
        		  stej=0;
        		  
        	  }
        	  
        	  ///// polje
        	  
        	  if (type_polja.equals("string") && !length_polja.equals("3")) {
        		 %>
        		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
        		 <%
        		 if (!length_polja.equals("1")) {
        		 %>
        		 <input type="text" name="<%=ime_polja%>" <%=!length_polja.equals("")?"maxlength='"+length_polja+"'":""%> value="<////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////>" style="font-family: Verdana; font-size: 8pt">
        		 <%
        		 }
        		 else {
        		 %>
        		  <input type="checkbox" name="<%=ime_polja%>" value="1" <////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"").equals("1")?"checked":""%////> style="font-family: Verdana; font-size: 8pt">
        		  
        		 <% 
        		 
        		 /// dam v insert ali update
        		 String dodi = "vseb.set"+ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())+"(nul.jeNull(request.getParameter(\""+ime_polja+"\")).equals(\"1\")?\"1\":\"0\");";
        		 checki.put(checkist+"",dodi);
        		 checkist++;
        		 
        		 }
        		 %>
        		 
        		 </td>
        		 <% 
        	  }
        	  else if (type_polja.equals("string") && length_polja.equals("3")) {
         		 %>
         		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
         		 
				<select name="<%=ime_polja %>" style="font-family: Verdana; font-size: 8pt" >
				<option value=""></option>
				</select>
				
				</td>
         		 <% 
         	  }
        	  else if (type_polja.equals("text")) {
          		 %>
          		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
          		 
					<textarea rows="6" cols="47"  name="<%=ime_polja %>"   style="font-family: Verdana; font-size: 8pt"><////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////></textarea>&nbsp;

					
					</td>
          		 <% 
          	  }
        	  else if (type_polja.equals("integer") || type_polja.equals("int") || type_polja.equals("Integer")) {
         		 %>
         		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
         		
         		 <input type="text" name="<%=ime_polja%>" <%=!length_polja.equals("")?"maxlength='"+length_polja+"'":""%> value="<////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////>" style="font-family: Verdana; font-size: 8pt">
         		
         		 
         		 </td>
         		 <% 
         		 String dodi = "htn.put(\""+ime_polja+"\",\""+ime_polja+"\");";
        		 checki.put(checkist+"",dodi);
        		 checkist++;
         	  }
         	  else if (type_polja.equals("double")) {
          		 %>
          		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
          		
          		 <input type="text" name="<%=ime_polja%>" <%=!length_polja.equals("")?"maxlength='"+length_polja+"'":""%> value="<////%=nul.jeNull(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>()+"")%////>" style="font-family: Verdana; font-size: 8pt">
          		
          		 
          		 </td>
          		 <% 
          		 String dodi = "htn.put(\""+ime_polja+"\",\""+ime_polja+"\");";
         		 checki.put(checkist+"",dodi);
         		 checkist++;
          	  }
        	  
        	  else if (type_polja.equals("timestamp")) {
          		 %>
          		 <td class="opiscell"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>: </td><td class="valuecell">
        	  
        	  <input type="text" name="<%=ime_polja %>" readonly value="<////%=nul.getDatumFormatFromDateNoTime(vseb.get<%=ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) %>())%////>" size="10"  style="font-family: Verdana; font-size: 8pt">
 </td>
         		 <% 
         		 String kont = "if (document.dod."+ime_polja+".value!=\"\" && !checkdatum(document.dod."+ime_polja+".value)) {"+"\n"+"alert(\"Datum "+ime_polja+" je nepravilno vnesen! (Pravilen format datuma je: xx-xx-xxxx)\");"+"\n"+"return false;}";
         		 htdat.put(htdatst+"",kont);
         		htdatst++;
         		
         		kont = "dp_ca"+htdatst2+" = new Epoch('epoch_popup','popup',document.dod."+ime_polja+");";
        		 htdat2.put(htdatst2+"",kont);
        		htdatst2++;
         		
         		
         	  }
        	  
        	  ime_polja="";
        	  type_polja="";
        	  length_polja="";
        	  stej++;
          }
          
          
          
          
          
          
          
          
          

%>




<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {

<%
Enumeration en = htdat.elements();

while (en.hasMoreElements()) {

%>
<%=en.nextElement()%>
<%
}

%>
////return true;
}
function mom() {

parent.frames[3].location = "nic.jsp";
<////%
////if (request.getParameter("akcija")==null) {
%////>

<%
en = htdat2.elements();

while (en.hasMoreElements()) {

%>
<%=en.nextElement()%>
<%
}

%>

<////%
////}
%////>
}
</script>
<////%
////}

////else {
%////>

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">PODATKI VNESENI/SPREMENJENI</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>

<script language=javascript>
var mon = parent.frames[1].document.location+"";

<////%
////if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%////>
if (mon.indexOf("idback")!=-1) {

  parent.frames[1].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<////%=request.getParameter("id")%////>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[1].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<////%=request.getParameter("id")%////>";
     
     }
     else {
parent.frames[1].document.location = parent.frames[1].document.location + "&idback=<////%=request.getParameter("id")%////>";
     }
     }
     else {
     parent.frames[1].document.location = parent.frames[1].document.location + "?idback=<////%=request.getParameter("id")%////>";

     }
}
<////%
////}
////else {
%////>
    if (mon.indexOf("id=")!=-1) {
    
     parent.frames[1].document.location = mon.substring(0,mon.indexOf("?"));
     }
     else {
    
parent.frames[1].document.location = parent.frames[1].document.location;
}
<////%
////}
%////>
</script>

<////%
////}

////}
////catch (Exception ex){
////	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
////	log.error(ex.toString());
////}
%////>
<%

Enumeration enu = checki.keys();

while (enu.hasMoreElements()) {

	%>
	<%=checki.get(enu.nextElement())%>
	<%
	}

	


}
catch (Exception ex){
System.out.println("Nastavitve: "+ex.toString());
}
%>