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
com.popultrade.dao.TemplateViewDAO dao = (com.popultrade.dao.TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO",pageContext.getServletContext());






int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("akcija")!=null)  {



com.popultrade.model.TemplateView vseb = dao.getTemplateView(new Long(nul.jeNullDefault(request.getParameter("idnav"))));



vseb = (com.popultrade.model.TemplateView)contextUtil.getPopulatedObject(vseb,request);
System.out.println("NNNNNNNNNNNNNNNNNNNNNNNN "+request.getParameter("narejeno"));
if (nul.jeNull(request.getParameter("narejeno")).equals("1")) {
vseb.setNavodila_obdelana("1");
}
else {
vseb.setNavodila_obdelana("0");
}

dao.saveTemplateView(vseb);


}


com.popultrade.model.TemplateView sif = new com.popultrade.model.TemplateView();
//sif.setId(new Long(request.getParameter("idnav")));
//int strec = 10;



sif = dao.getTemplateView(new Long(request.getParameter("idnav")));







%>
<html><head><title></title></head>
<style>

A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>
<style type=text/css>

@import "barve.css";
@import "tooltipcss.css";
</style>
<script language='javascript' src='colors.js' ></script>
 <link rel="stylesheet" href="js/jquery-ui.css">

<script language=javascript>

function zapriDialog() {

parent.zapriDialog();
}

function chg() {


 
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>

   

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"   >

 <%
 if (request.getParameter("akcija")==null) {
  %>

  <form name="dodi" method="post" action="m_navodila_set_he.jsp">
  <input type="hidden" name="idnav" value="<%=request.getParameter("idnav")%>">
    <input type="hidden" name="akcija" value="update">
  <table  width=100% height=100% cellspacing=1  style="font-family: Verdana; font-size: 9pt">
  <tr><td colspan=2  class="opiscell" height=90%>
  <textarea name="navodila" id="navodila" style="font-family: Verdana; font-size: 8pt;width:100%;height:100%" ><%=nul.jeNull(sif.getNavodila()) %></textarea>
  </td></tr>
  <tr><td  class="valuecell"><input type="radio" name="narejeno" value="1" <%=nul.jeNull(sif.getNavodila_obdelana()).equals("1")?"checked":"" %> style="font-family: Verdana; font-size: 8pt" > Navodila za TODO list<br>
  <input type="radio" name="narejeno"  value="0" <%=nul.jeNull(sif.getNavodila_obdelana()).equals("1")?"":"checked" %>  style="font-family: Verdana; font-size: 8pt" > TODO list narejena</td><td align=center class="valuecell">
  <input type=submit value="Shrani" style="font-family: Verdana; font-size: 8pt"> &nbsp; <input type=button value="Zapri" onClick="zapriDialog()" style=" font-family: Verdana; font-size: 8pt">
  </td></tr>
  
  
  </table>
   </form>
  <%
  }
  else {
  %>
  
  <script language="javascript">
parent.updateNav('<%=nul.jeNull(request.getParameter("idnav")) %>','<%=nul.jeNull(request.getParameter("narejeno")) %>');
  </script>
  
    <table  width=100% height=100% cellspacing=1  style="font-family: Verdana; font-size: 9pt">
  <tr><td   class="opiscell" align=center>
<p>  Navodila uspesno shranjena.</p>
  </td></tr>
  <tr><td  class="opiscell" align=center>
   <input type=button value="Nazaj" onclick="document.location='m_navodila_set.jsp?idnav=<%=request.getParameter("idnav") %>'" style="font-family: Verdana; font-size: 8pt"> 
  <input type=button value="Zapri" onClick="zapriDialog()" style=" font-family: Verdana; font-size: 8pt">
  </td></tr>
  
  
  </table>
  <%
  }
  
   %>
  
 


<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatese_edit.jsp?id="+asd;
    parent.frames[3].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[3].location = asd;
return false;
}
function PGAPP(){
}

</script>


</body></html>
 <%

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>



