<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 
 <%!
 
 
 	    public StringBuffer getClass_file(String css_datoteka)
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
	            System.out.println((new StringBuilder()).append("Napaka pri branju hibernate class  datoteke: ").append(ecm.toString()).toString());
	        }
	        return sb;
	    }
	    
	    
	  	    public StringBuffer setClass_file(String css_datoteka,String vsebina)
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
String path =control.hibernate_classes; ///// direktorij, kamor dam xls datoteke z mrnji


if (nul.jeNull(request.getParameter("opt")).equals("submit")) {


this.setClass_file(path+request.getParameter("name"),request.getParameter("vsebina"));
}


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

<table border="0" width="100%" id="table1"   bgcolor=#C3E1FC cellspacing=8	>
	<tr>
		<td align="center" valign="top"><font style="font-size: 4pt">&nbsp;
		</font>
		<form  METHOD="POST" ACTION="m_hibernate_class_edit.jsp?opt=submit">
				<input type="hidden" name="name" value="<%=request.getParameter("name")%>">
		<table border="0" width="100%" id="table2" height="100%"  cellpadding=5>
			<tr>
				<td bgcolor="#E3F1FE" valign="top" >
				
					 Hibernate Class file 
				
				</td>
				</tr>
				<tr>
				<td>
				
				<textarea name="vsebina"  rows=33 style="width:100%;font-family: Verdana; font-size: 8pt"><%=this.getClass_file(control.hibernate_classes+request.getParameter("name")) %></textarea>
				
				
				</td>
			</tr>
			
			<tr><td colspan=2 align=center><input type="submit" value="Shrani"  style="font-family: Verdana; font-size: 8pt" ></td></tr>
		</table>
		</form>
		</td>
	</tr>
</table>

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
 
 

