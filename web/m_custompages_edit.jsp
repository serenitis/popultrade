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
	        
	        /// add template
	        StringBuffer sbu = this.getCSS_file(css_datoteka.substring(0,css_datoteka.lastIndexOf("/"))+"/m_custompagetemplate.jsp");
	        
	        vsebina = sbu.toString().replace("|-----|-----|", vsebina);
	        
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
String path =request.getRealPath("")+"/"; ///// direktorij, kamor dam xls datoteke z mrnji
com.popultrade.model.TemplatePages vseb =new com.popultrade.model.TemplatePages();

com.popultrade.dao.TemplatePagesDAO dao = (com.popultrade.dao.TemplatePagesDAO)contextUtil.getBeanDao("templatePagesDAO",pageContext.getServletContext());

if (nul.jeNull(request.getParameter("opt")).equals("submit")) {

	

	System.out.println("------ "+path+""+request.getParameter("pagename"));

this.setCSS_file(path+""+request.getParameter("pagename"),request.getParameter("vsebina"));


/// shranim
/*if (!nul.jeNull(request.getParameter("id")).equals("")) {
vseb.setId(new Long(request.getParameter("id")));
}*/


if (!nul.jeN(request.getParameter("id")).equals("")) {
	vseb = dao.getTemplatePages(new Long(request.getParameter("id")));
}

vseb = (com.popultrade.model.TemplatePages)contextUtil.getPopulatedObject(vseb,request);
dao.saveTemplatePages(vseb);


}
else {

/// dobim default cssje

//com.popultrade.model.TemplatePages vseb =new com.popultrade.model.TemplatePages();
//if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
try {
vseb = dao.getTemplatePages(new Long(request.getParameter("id")));

}
catch (Exception exmo) {
	vseb = new com.popultrade.model.TemplatePages();
}
}


//}









%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">
<style type=text/css>
@import "barveold.css";
@import "tooltipcss.css";
@import "ccss/custom.css";
@import "barveblue.css";
</style>
</head>
<script src="src-min/ace.js" type="text/javascript" charset="utf-8"></script>
<script language="javascript">
<%
if (request.getParameter("pagename")!=null) {
	%>
	parent.frames[1].location=parent.frames[1].location;
	
	<%
}
%>
function gum() {

//parent.frames[2].location="nic.jsp";
}
</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">
<form  METHOD="POST" name="dod" id="dod" onsubmit="return chko()" ACTION="m_custompages_edit.jsp?opt=submit&id=<%=nul.jeNull(vseb.getId())%>">



<table border="0" width="100%" id="table1"   style="font-family: Verdana; font-size: 8pt"  cellspacing=1	>

<tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
	<tr>
		<td align="left" valign="top" colspan=1  class="opiscell" width="15%">Page name:</td>
		<td colspan=3 class="valuecell" >
		
		<%
		String rezu = nul.jeN(vseb.getPagename());
		
		%>
		
		<input type="text" id="pagename" name="pagename" value="<%=rezu %>" size=70 maxlength=70  style="font-family: Verdana; font-size: 8pt">
		</td>
		</tr>
				
	<tr><td class="opiscell">Vsebina datoteke po login delu, zacne se z html kodo:</td >
				<td colspan=3  class="valuecell">
				
				
				<textarea id="editor" style="font-size:25px" styddle="width:500px;height:300px;margin-top:55px;margin:auto"><%=(nul.jeN(vseb.getPagename()).equals("")?"":this.getCSS_file(path+""+vseb.getPagename())) %></textarea>
				
				<input type="hidden" name="vsebina" id="vsebina" value="">
				
				
				</td>
			</tr>

	
	
	<tr><td colspan="4" class="opiscell" align=center><input id="submitbutton"  type=submit value="Submit"  style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr>	
		
		
		
</table>
</form>

<script language='javascript'>

var editor = ace.edit("editor");
// editor.setTheme("ace/theme/twilight");
// editor.session.setMode("ace/mode/jsp");
	
	editor.setOptions({
enableBasicAutocompletion: true, // the editor completes the statement when you hit Ctrl + Space
enableLiveAutocompletion: true, // the editor completes the statement while you are typing
showPrintMargin: false, // hides the vertical limiting strip
maxLines: Infinity,
fontSize: "14pt"
});
	
	editor.setTheme("ace/theme/chrome");
	editor.renderer.setOption("showLineNumbers", true); 
	editor.getSession().setMode("ace/mode/jsp");
	
	




function chko() {
	
	if (document.getElementById("pagename").value=="") {
		alert("Napaka: page name ni vnesen!");
		return false;
	}
	
	document.getElementById("vsebina").value=editor.getValue();
	
	
	
	return true;
	
}

</script>


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
 
 

