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
 
String iskanje="";
 
try {
 
// get list from daoobject
com.popultrade.dao.UsersDAO dao = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
 

 
 
 
 
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
 
</style>
<script language='javascript' src='colors.js' ></script>
<script language="javascript">
function chg() {
 
  
 
parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}
</script>
 
 <body topmargin="0" leftmargin="0" background="podlaga.jpg" bgproperties="fixed" onLoad="chg()">
 
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">

  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>
    <tr>
    <td width="19%" bgcolor="#C3E1FC">Number of users:</td>
    <td align="left" bgcolor="#E3F1FE" width="35%">
    <%=dao.getStatistikaStevilke(" where user_type!='Y08' ") %></td>
    <td align="left" bgcolor="#C3E1FC" width="16%">Number of view users:
    &nbsp;</td>
    <td align="left" bgcolor="#E3F1FE">
            		 
     <%=dao.getStatistikaStevilke(" where user_type='Y08' ") %></td>
 
  </tr>

 <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>
    <tr>
    <td width="19%" bgcolor="#C3E1FC">Number of invalids:</td>
    <td align="left" bgcolor="#E3F1FE" width="35%" colspan="3">
    <%=dao.getStatistikaStevilke(" where user_type!='Y08' and invalid='1' ") %></td>
   
  </tr>

  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>
    <tr>
    <td width="19%" bgcolor="#C3E1FC" valign="top">Users by user type:</td>
    <td align="left" bgcolor="#E3F1FE" width="35%" valign="top">
    <table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" id="AutoNumber1" cellpadding="0">
        <%    
   
   Hashtable sifr = new Hashtable();
 com.popultrade.dao.SifrantiDAO daos = (com.popultrade.dao.SifrantiDAO)contextUtil.getBeanDao("sifrantiDAO",pageContext.getServletContext());
List li = daos.getSifrantiBySifra("STY",control.getJezik());

Iterator itt = li.iterator();

while (itt.hasNext()) {
	 com.popultrade.model.Sifranti siff = (com.popultrade.model.Sifranti)itt.next();

sifr.put(siff.getPod_sifra_sifranta(),siff.getPomen_sifre());
	
}

     %>  
    <%
    List lisi = dao.getStatistikaStevilkeGroup("user_type,"," where user_type!='Y08' group by user_type order by user_type  ");
  
    
    Iterator it = lisi.iterator();
 
 
while (it.hasNext()){
	
	Object[] ob = (Object[])it.next();
	%>
	
	
	<tr><td><%=sifr.get((String)ob[0]) %>: &nbsp;&nbsp;</td><td align=right><%=ob[1] %></td></tr>
	
	
	
	<%
}
    %>
    
    
  </table>
    
    
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="16%" valign="top">
    Sex:</td>
    <td align="left" bgcolor="#E3F1FE" valign="top">
               <table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" id="AutoNumber1" cellpadding="0">
    
    <%
    lisi = dao.getStatistikaStevilkeGroup("sex,"," where user_type!='Y08' group by sex order by sex  ");
  
    
  it = lisi.iterator();
 String[] mal = {"Male","Female"};
 
while (it.hasNext()){
	
	Object[] ob = (Object[])it.next();
	if (!nul.jeNull((String)ob[0]).equals("")) {
	%>
	
	
	
	<tr><td><%=mal[Integer.parseInt((String)ob[0])] %>: &nbsp;&nbsp;</td><td align=right><%=ob[1] %></td></tr>
	
	
	
	<%
	}
}
    %>
    
    
  </table>		 
  </td>
 
  </tr>
















  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>
    <tr>
    <td width="19%" bgcolor="#C3E1FC" valign="top">Users by country:</td>
    <td align="left" bgcolor="#E3F1FE" width="35%" valign="top">

                   <table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" id="AutoNumber1" cellpadding="0">
    
    <%
    
   sifr.clear();
   li = daos.getSifrantiBySifra("COU",control.getJezik());

   itt = li.iterator();

   while (itt.hasNext()) {
   	 com.popultrade.model.Sifranti siff = (com.popultrade.model.Sifranti)itt.next();

   sifr.put(siff.getPod_sifra_sifranta(),siff.getPomen_sifre());
   	
   }
    
    
    lisi = dao.getStatistikaStevilkeGroup("country,"," where user_type!='Y08' group by country order by country  ");
  
    
  it = lisi.iterator();

while (it.hasNext()){
	
	Object[] ob = (Object[])it.next();
	if (!nul.jeNull((String)ob[0]).equals("")) {
	%>
	
	
	
	<tr><td><%=sifr.get((String)ob[0]) %>: &nbsp;&nbsp;</td><td align=right><%=ob[1] %></td></tr>
	
	
	
	<%
	}
}
    %>
    
    
  </table>		
    
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="16%" valign="top">
    Users years:</td>
    <td align="left" bgcolor="#E3F1FE" valign="top">
               <table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" id="AutoNumber1" cellpadding="0">
    
    <%
    lisi = dao.getStatistikaStevilkeGroup("year(birthday),"," where user_type!='Y08' group by year(birthday) order by year(birthday) ");
  
    
  String dtm =  nul.getDatumFormatFromDate(new Date(),"yyyy");
    
  it = lisi.iterator();

while (it.hasNext()){
	
	Object[] ob = (Object[])it.next();
	if (!nul.jeNull(""+ob[0]).equals("")) {
	%>
	
	
	
	<tr><td><%=Integer.parseInt(dtm)- Integer.parseInt(ob[0]+"") %>: &nbsp;&nbsp;</td><td align=right><%=ob[1] %></td></tr>
	
	
	
	<%
	}
}
    %>
    
    
  </table>		 
  </td>
 
  </tr>









    <tr>
    <td width="19%" bgcolor="#C3E1FC" valign="top">Users by sports:</td>
    <td align="left" bgcolor="#E3F1FE" width="35%" valign="top">

                   <table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" id="AutoNumber1" cellpadding="0">
    
    <%
    
   sifr.clear();
   li = daos.getSifrantiBySifra("SPT",control.getJezik());

   itt = li.iterator();

   while (itt.hasNext()) {
   	 com.popultrade.model.Sifranti siff = (com.popultrade.model.Sifranti)itt.next();

   sifr.put(siff.getPod_sifra_sifranta(),siff.getPomen_sifre());
   	
   }
    
    
    lisi = dao.getStatistikaStevilkeGroupSport("tip_sporta,","  group by tip_sporta order by tip_sporta  ");
  
    
  it = lisi.iterator();

while (it.hasNext()){
	
	Object[] ob = (Object[])it.next();
	if (!nul.jeNull((String)ob[0]).equals("")) {
	%>
	
	
	
	<tr><td><%=sifr.get((String)ob[0]) %>: &nbsp;&nbsp;</td><td align=right><%=ob[1] %></td></tr>
	
	
	
	<%
	}
}
    %>
    
    
  </table>		
    
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="16%" valign="top">Hear about us:
</td>
    <td align="left" bgcolor="#E3F1FE" valign="top">
	                    <table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" id="AutoNumber1" cellpadding="0">
    
    <%
    
   sifr.clear();
   li = daos.getSifrantiBySifra("HAU",control.getJezik());

   itt = li.iterator();

   while (itt.hasNext()) {
   	 com.popultrade.model.Sifranti siff = (com.popultrade.model.Sifranti)itt.next();

   sifr.put(siff.getPod_sifra_sifranta(),siff.getPomen_sifre());
   	
   }
    
    
    lisi = dao.getStatistikaStevilkeGroup("hear_about_us,"," where user_type!='Y08' group by hear_about_us order by hear_about_us  ");
  
    
  it = lisi.iterator();

while (it.hasNext()){
	
	Object[] ob = (Object[])it.next();
	if (!nul.jeNull((String)ob[0]).equals("")) {
	%>
	
	
	
	<tr><td><%=sifr.get((String)ob[0]) %>: &nbsp;&nbsp;</td><td align=right><%=ob[1] %></td></tr>
	
	
	
	<%
	}
}
    %> </table>	
  </td>
 
  </tr>







  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>
  
    
</table> 
 

<%
}
catch (Exception ex) {
System.out.println(ex.toString());
}

%>