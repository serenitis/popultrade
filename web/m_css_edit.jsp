<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 
 <%!
 
 
 	    public StringBuffer getCSS_file(String css_datoteka)
	    {
	        StringBuffer sb = new StringBuffer();
	        try
	        {
	            FileInputStream fstream = new FileInputStream(css_datoteka);
	            DataInputStream in = new DataInputStream(fstream);
	            BufferedReader br = new BufferedReader(new InputStreamReader(in));
	            String strLine;
	            while((strLine = br.readLine()) != null) 
	                sb.append((new StringBuilder()).append(strLine).append("\r\n").toString());
	            in.close();
	        }
	        catch(Exception ecm)
	        {
	            System.out.println((new StringBuilder()).append("Napaka pri branju css custom datoteke: ").append(ecm.toString()).toString());
	        }
	        return sb;
	    }
	    
	    
	  	    public StringBuffer setCSS_file(String css_datoteka,String vsebina)
	    {
	        StringBuffer sb = new StringBuffer();
	        try
	        {
	        
	        File juk = new File(css_datoteka);
	        
	        if (!juk.exists()) {
	        juk.createNewFile();
	        }
	        
	        Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(juk), "utf-8"));
    		writer.write(vsebina);
    		writer.close();
	        }
	        catch(Exception ecm)
	        {
	            System.out.println((new StringBuilder()).append("Napaka pri pisanju css custom datoteke: ").append(ecm.toString()).toString());
	        }
	        return sb;
	    }   
	   
	    
	    
 
 
  %>
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}


try {



//ServletContext scon=pageContext.getServletContext();
//System.out.println("SLIKKKKK "+session.getAttribute("slik"));
String path =request.getRealPath("")+"/"+control.lokacija_css_slik; ///// direktorij, kamor dam xls datoteke z mrnji
com.popultrade.model.TemplateCssDefault vseb =new com.popultrade.model.TemplateCssDefault();

com.popultrade.dao.TemplateCssDefaultDAO dao = (com.popultrade.dao.TemplateCssDefaultDAO)contextUtil.getBeanDao("templateCssDefaultDAO",pageContext.getServletContext());

if (nul.jeNull(request.getParameter("opt")).equals("submit")) {


this.setCSS_file(path+"/custom.css",request.getParameter("vsebina"));


/// shranim
/*if (!nul.jeNull(request.getParameter("id")).equals("")) {
vseb.setId(new Long(request.getParameter("id")));
}*/
vseb = (com.popultrade.model.TemplateCssDefault)contextUtil.getPopulatedObject(vseb,request);


dao.saveTemplateCssDefault(vseb);


}
else {

/// dobim default cssje

//com.popultrade.model.TemplateCssDefault vseb =new com.popultrade.model.TemplateCssDefault();
//if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {

List il = dao.getTemplateCssDefaults(new com.popultrade.model.TemplateCssDefault());

if (il.size()>0) {
vseb = (com.popultrade.model.TemplateCssDefault)il.get(0);

}
}


//}









%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {

//parent.frames[2].location="nic.jsp";
}
</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">
<form  METHOD="POST" ACTION="m_css_edit.jsp?opt=submit&id=<%=nul.jeNull(vseb.getId())%>">



<table border="0" width="100%" id="table1"   bgcolor=#C3E1FC cellspacing=8	>
	<tr>
		<td align="center" valign="top" colspan=2><font style="font-size: 4pt">&nbsp;
		</font>
		
				
		<table border="0" width="100%" id="table2" height="100%"  cellpadding=5>
			<tr>
				<td bgcolor="#E3F1FE" valign="top" >
				
					Custom CSS file (vnese se clase za custom formatacijo div elementov za touchscreen )<br>Za definicijo class uporabi (.t[ime] {) pazi na presledke v eni vrstici :
				
				</td>
				<td>
				
				<textarea name="vsebina" cols=230 rows=33 style="font-family: Verdana; font-size: 8pt"><%=this.getCSS_file(path+"/custom.css") %></textarea>
				
				
				</td>
			</tr>
			
			<tr><td colspan=2 align=center><input type="submit" value="Shrani"  style="font-family: Verdana; font-size: 8pt" ></td></tr>
		</table>
		
		
		
		
		
		</td>
	</tr>
	
		<tr>
		<td  valign="top" width=25%>
		Default CSS (frame) za container ki vsebuje vse osale containerje:
		</td>
		<td>
			 <select name="dfwcontainer" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             String patho =request.getRealPath("")+"/"+ control.lokacija_css_slik;
             
              Hashtable clase = control.getCSS_names(patho+"/custom.css");
             if (true) {
             Enumeration itn = clase.keys();
             
             if (vseb==null || vseb.getId()==null) {
             vseb.setDfwcontainer("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDfwcontainer()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
		</td>
		</tr>
	
	
			<tr>
		<td  valign="top" width=25%>
		Default CSS (frame) za container ki vsebuje vse elemente:
		</td>
		<td>
			 <select name="dfwdefcontainer" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
           if (true) {
             Enumeration itn = clase.keys();
             
             if (vseb==null || vseb.getId()==null) {
             vseb.setDfwdefcontainer("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDfwdefcontainer()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
		</td>
		</tr>
	
	
	
	
	
	
	
	
	
	
	
				<tr>
		<td valign="top" width=25%>
		Default CSS za div elementa:
		</td>
		<td>
			 <select name="ddivelement" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
           if (true) {
             Enumeration itn = clase.keys();
             
             if (vseb==null || vseb.getId()==null) {
             vseb.setDdivelement("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivelement()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
		</td>
		</tr>
	
	
	
	
	
					<tr>
		<td  valign="top" width=25%>
		Default CSS za 'td' elementa:
		</td>
		<td>
			 <select name="dtdelement" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
           if (true) {
             Enumeration itn = clase.keys();
             
             if (vseb==null || vseb.getId()==null) {
             vseb.setDtdelement("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDtdelement()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
		</td>
		</tr>
	
	
			<tr>
		<td  valign="top" width=25%>
		Default CSS za format input del element:
		</td>
		<td>
			 <select name="dinputelement" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
           if (true) {
             Enumeration itn = clase.keys();
             
             if (vseb==null || vseb.getId()==null) {
             vseb.setDinputelement("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDinputelement()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
		</td>
		</tr>
	
	
		<tr>
		<td  valign="top" width=25%>
		Default CSS za format font element:
		</td>
		<td>
			 <select name="dfonts" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
           if (true) {
             Enumeration itn = clase.keys();
             
             if (vseb==null || vseb.getId()==null) {
             vseb.setDfonts("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDfonts()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
		</td>
		</tr>
		
		
		
		
		
		
		
				<tr>
		<td  valign="top" width=25%>
		Default CSS za table element po td elementu:
		</td>
		<td>
			 <select name="dtable" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
           if (true) {
             Enumeration itn = clase.keys();
             
             if (vseb==null || vseb.getId()==null) {
             vseb.setDtable("tdefaulttablespace");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDtable()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
		</td>
		</tr>
		
		
		
		
		
		
		
		
		
		
</table>
</form>
</body>

</html>

 <%
 }
 catch (Exception exs) {
 	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(exs.toString());
	
	System.out.println(exs.toString());
	
 }
 
  %>
 
 

