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

if (!nul.jeNull(request.getParameter("jezikp")).equals("") && !nul.jeNull(request.getParameter("jezikv")).equals("")) {
session.setAttribute("jezikp",request.getParameter("jezikp"));
session.setAttribute("jezikv",request.getParameter("jezikv"));
session.setAttribute("menut",request.getParameter("menut"));
}
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
com.popultrade.dao.TemplateMenuDAO dao = (com.popultrade.dao.TemplateMenuDAO)contextUtil.getBeanDao("templateMenuDAO",pageContext.getServletContext());

if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("prevod"))  {
	
	
	Enumeration enn = request.getParameterNames();
	
	while (enn.hasMoreElements()) {
		
		String str = (String)enn.nextElement();
		
		if (str!=null && str.startsWith("prevod_")) {
			
			String[] stru = str.split("_");
			com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
			com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
			
			
			prevo.setPrevod_id(new Long(stru[1]));
			prevo.setSifra_jez(session.getAttribute("jezikv")+"");
			prevo.setVrsta(stru[2]);
			if (stru.length==4 && !stru[3].equals("")) {
			//	prevo.setId(new Long(stru[3]));
				
			}
			prevo = daop.getPrevodiCopy(prevo);
			
			if (prevo==null) {
				prevo = new com.popultrade.model.Prevodi();
				prevo.setPrevod(nul.jeNull(request.getParameter(str)));
				prevo.setPrevod_id(new Long(stru[1]));
				prevo.setSifra_jez(session.getAttribute("jezikv")+"");
				prevo.setVrsta(stru[2]);
				
			}
			prevo.setPrevod(nul.jeNull(request.getParameter(str)));
			
			daop.savePrevodi(prevo);
			ConPool.setPrevod_admin(stru[1],stru[2],session.getAttribute("jezikv")+"",nul.jeNull(request.getParameter(str)),prevo.getId()+"");
			
			
		}
		
		
		
	}
	
	
	
}
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateMenu(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateMenu",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateMenu")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateMenu")+"");
	}
	}



/*

Hashtable prep = new Hashtable();

/// prevod vnosa
Hashtable prev = new Hashtable();


/// id prevoda_ce obstaja
Hashtable previd = new Hashtable();

/// dobim vse prevode
com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
prevo.setSifra_jez(session.getAttribute("jezikp")+"");
List limo = daop.getPrevodis(prevo);

Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodis(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	previd.put(prv.getPrevod_id()+"",prv.getId()+"");
}


*/

com.popultrade.model.TemplateMenu sif = new com.popultrade.model.TemplateMenu();

sif.setMenu(new Long(session.getAttribute("menut")+""));	

int strec = dao.getStTemplateMenu(sif);


List lis =null;

lis = dao.getTemplateMenus(sif,pagenum,stizpisov);







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
<script type="text/javascript" language="JavaScript" src="tooltip.js"></script>

<script language=javascript>

// potrditev brisanja
function vprasaj() {
  var a = window.confirm("Potrdis brisanje?");
  if (a==true) {

    return true;
  }
  else {
    return false;
  }
}


function chg() {


    


  <%
if (request.getParameter("idback")!=null && !request.getParameter("idback").equals("null") && !request.getParameter("idback").equals("")) {
  %>

  <%
}
  %>

parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


                	   p1="Menu";
                	   
                
                	   
                	
                	   
                	   p7="Prevod";
                	   
       	p8="Zaporedje";
                	   
                	   
                	   

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">



            
            	   
            	   <td width=25% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p1)">Naziv menija</td>
               
            	   
            	   <td width=65% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p7)">Prevod</td>
               
            	     <td width=5% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p8)">Zap</td>
               
          
               
            	   

              
                 <td  bgcolor="ADD9FF" align=center><a onClick="return godown('m_templatemenu_edit.jsp?opcija=new&siframm=new&sifrant=null')" href="Javascript: PGAPP()"><img title="Dodaj nov Head Menuja" border="0" src="vnos.gif" /></a></td>
        </tr>
 

</table>
</div>




<form name="dod" action="m_templatemenu.jsp?akcija=prevod" method="post">


<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
<tr><td colspan=3>&nbsp</td></tr>
<%

/// menja barvo
int br = 0;
String oe_kup_nap = "";


Iterator it = lis.iterator();


while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplateMenu vseb = (com.popultrade.model.TemplateMenu)(it.next());
		stvrstic++;

if (br==2){
  br=0;
}

if (vseb.getId().toString().equals(nul.jeNull(request.getParameter("idback")))) {
%>
<tr class="<%=colors[br]%>" id=sprememba onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}
else {
%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}

%>


	
	<td width="25%" align="left"><%=nul.jeNull(vseb.getMenu_naziv())%></td>
	
	<td width="65%" align="left">	<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%>
<input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(vseb.getId()+""))%>" size="35" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
	</td>
	
	<td width="5%" align="center"><%=nul.jeNull(vseb.getZaporedje()+"")%></td>
	

	


<td  align="center">

 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>&idt=<%=request.getParameter("idt")%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>
<a onClick="return godown('m_templatemenu_edit.jsp?opcija=new&siframm=new&sifrant=null&idd=<%=vseb.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj novi pod meni" border="0" src="vnos.gif" /></a>

 <a onClick="return vprasaj()" href="m_templatemenu.jsp?akcija=DELETE&id=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>&idt=<%=request.getParameter("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>



</td>
</tr>



<%

//// podmeniji


if  (vseb.getTemplatemenus()!=null && vseb.getTemplatemenus().size()>0) {
	
	Iterator itmo = vseb.getTemplatemenus().iterator();
	
	%>
	<tr><td colspan="4">
	<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	<%
	
	while (itmo.hasNext()) {
		com.popultrade.model.TemplateMenu tmen = (com.popultrade.model.TemplateMenu)itmo.next();
		%>
		<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
	<td width="5%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td width="25%" align="left"><%=nul.jeNull(tmen.getMenu_naziv())%></td>
			
			<td width="60%" align="left">	<%=nul.jeNull(ConPool.getPrevod_admin(tmen.getId()+"","P",session.getAttribute("jezikp")+""))%>
		<input type="text" name="prevod_<%=tmen.getId()%>_P_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(tmen.getId()+""))%>" size="35" value="<%=nul.jeNull(ConPool.getPrevod_admin(tmen.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
			</td>
			
			<td width="5%" align="center"><%=nul.jeNull(tmen.getZaporedje()+"")%></td>

		<td  align="center">

		 <a href="Javascript:PGAPP()" onCLick="return go('<%=tmen.getId()%>&opcija=spremeni&siframm=new&idd=<%=vseb.getId()%>&idback=<%=tmen.getId()%>&idt=<%=request.getParameter("idt")%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>

<a onClick="return godown('m_templatemenu_edit.jsp?opcija=new&siframm=new&sifrant=null&idd=<%=tmen.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj novi pod meni" border="0" src="vnos.gif" /></a>

		 <a onClick="return vprasaj()" href="m_templatemenu.jsp?akcija=DELETE&id=<%=tmen.getId()%>&sifrant=<%=request.getParameter("sifrant")%>"><img src="x.gif" border=0 title="Brisi"></a>



		</td>
		</tr>
		
		
		
		
		
		<%

//// podmeniji


if  (tmen.getTemplatemenus()!=null && tmen.getTemplatemenus().size()>0) {
	
	Iterator itmo2 = tmen.getTemplatemenus().iterator();
	
	%>
	<tr><td colspan="5">
	<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	<%
	
	while (itmo2.hasNext()) {
		com.popultrade.model.TemplateMenu tmenn = (com.popultrade.model.TemplateMenu)itmo2.next();
		%>
		<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
	<td width="8%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td width="25%" align="left"><%=nul.jeNull(tmenn.getMenu_naziv())%></td>
			
			<td width="57%" align="left">	<%=nul.jeNull(ConPool.getPrevod_admin(tmenn.getId()+"","P",session.getAttribute("jezikp")+""))%>
		<input type="text" name="prevod_<%=tmenn.getId()%>_P_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(tmenn.getId()+""))%>" size="35" value="<%=nul.jeNull(ConPool.getPrevod_admin(tmenn.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
			</td>
			
			<td width="5%" align="center"><%=nul.jeNull(tmenn.getZaporedje()+"")%></td>

		<td  align="center">

		 <a href="Javascript:PGAPP()" onCLick="return go('<%=tmenn.getId()%>&idd=<%=tmen.getId()%>&opcija=spremeni&siframm=new&idback=<%=tmenn.getId()%>&idt=<%=request.getParameter("idt")%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>


		 <a onClick="return vprasaj()" href="m_templatemenu.jsp?akcija=DELETE&id=<%=tmenn.getId()%>&sifrant=<%=request.getParameter("sifrant")%>"><img src="x.gif" border=0 title="Brisi"></a>



		</td>
		</tr>
		<%
		
		
		
	}
	
	
	%>
	</table>
	</td></tr>
	<%
	
}


%>
		
		
		
		
		
		
		
		
		
		
		
		
		
		<%
		
		
		
	}
	
	
	%>
	</table>
	</td></tr>
	<%
	
}


%>






<%
br++;

}/// while end


 %>
  
  
  
   <tr><td colspan=4 align=right bgcolor=silver height=32>
 
  
 <input type="submit" value="Shrani prevode"  style="font-family: Verdana; font-size: 8pt">
  </td></tr>
  
  
  
  
  
  
  
  
</table>
</form>

<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatemenu_edit.jsp?id="+asd;
    parent.frames[2].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[2].location = asd;
return false;
}
function PGAPP(){
}

</script>


<%
// st izpisov
if (strec>stizpisov) {
	String iskk="";
	if (iskanje) {
		iskk="&isk=1";
		}
%><p align=center>
<table  border="0" cellpadding="7" cellspacing="1" style="border-collapse: collapse; font-family:Verdana; font-size:8pt;">
<tr bgcolor="ededed">
<td align=center >
Browse page: </td><td>
 <a style="text-decoration:none;color:black"  href="m_templatemenu.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateMenu")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateMenu")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatemenu.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

<td>|</td>
<%
}
%>
<%

for (int y=0;y<strec;y++) {
vse++;
if (vse==stizpisov) {
vse=0;

ststr++;
if ((prvii-5)<ststr && ststr<(prvii+5)) {
%>
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateMenu")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatemenu.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateMenu")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatemenu.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatemenu.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templatemenu.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateMenu")+"").equals("")?"1":session.getValue("pagenumberTemplateMenu")%> of <%=ststr+1%> </td>
<td>|</td>
<td>
records: <%=strec%></td>
</tr>
</table></p>
<%
}
%>

</body></html>
 <%

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>



