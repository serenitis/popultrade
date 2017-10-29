<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,sun.net.ftp.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
 
 
 <%

/////// load prvodov, ce jih se ni

if (!ConPool.soPrevodi) {
ConPool.setPrevode(contextUtil,pageContext.getServletContext());
ConPool.soPrevodi=true;
}
 boolean bok=false;
 com.popultrade.model.Jeziki vseb =new com.popultrade.model.Jeziki();
 com.popultrade.dao.JezikiDAO dao = (com.popultrade.dao.JezikiDAO)contextUtil.getBeanDao("jezikiDAO",pageContext.getServletContext());
 
 
 
 
 
 
 %>
 
 
 <html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Admin</title>
</head>

    <!-- SmartMenus jQuery plugin -->


<!-- SmartMenus core CSS (required) -->
<link href='js/css/sm-core-css.css' rel='stylesheet' type='text/css' />
<!-- "sm-blue" menu theme (optional, you can use your own CSS, too) -->
<link href='js/css/sm-simple/sm-simple.css' rel='stylesheet' type='text/css' />



  <link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="scripts/jquery.min.js"></script> <script type="text/javascript" src="scripts/jquery-migrate.min.js"></script>
    <script type="text/javascript" src="js/jqxcore.js"></script>
    <script type="text/javascript" src="js/jqxsplitter.js"></script>
<link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />

<script src="js/jquery.smartmenus.js" type="text/javascript"></script>

    
<!-- #main-menu config - instance specific stuff not covered in the theme -->
<style type="text/css">
	#main-menu {
		position:relative;
		z-index:9999;
		width:auto;
	}
	#main-menu ul {
		width:12em; /* fixed width only please - you can use the "subMenusMinWidth"/"subMenusMaxWidth" script options to override this if you like */
	}
	
	
	
</style>


    
    <style type="text/css">

html, body
{
	margin: 0;			/* Remove body margin/padding */
	padding: 0;
	overflow: hidden;	/* Remove scroll bars on browser window */
}

</style>



<script language="javascript">

function go(lok,kje) {

	parent.frames[1].location = lok;
	return false;
	}


function dom(lok) {

parent.frames[1].location = lok;
return false;
}

function doma(lok) {

if (document.getElementById("jezikp").value=="") {
alert("Napaka: potrebno je izbrati jezik pregleda!");
return false;
}
if (document.getElementById("jezikv").value=="") {
alert("Napaka: potrebno je izbrati jezik vnosa!");
return false;
}

if (lok.indexOf("?")!=-1) {
parent.frames[1].location = lok+"&jezikv="+document.getElementById("jezikv").value+"&jezikp="+document.getElementById("jezikp").value+"&menut="+document.getElementById("menut").value;
}
else {
parent.frames[1].location = lok+"?jezikv="+document.getElementById("jezikv").value+"&jezikp="+document.getElementById("jezikp").value+"&menut="+document.getElementById("menut").value;
}
return false;
}

</script>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table1">
	<tr>
		<td bgcolor="#ADD9FF" align="center"><font size="1" color="#ADD9FF">.</font><font size="1"  face="verdana"> 
		VERSION 0.61</font></td>
	</tr>
	<tr>
		<td bgcolor="#C4E1FD" align="center">
		<table border="0" cellspacing="3" width="100%" id="table2" style="font-family: Verdana; font-size: 8pt">
	 		<tr>
				<td bgcolor="#E3F1FE" align="center" width="233">
				
				<ul id="main-menu" class="sm sm-simple">
 

 

	<li><a href="#">popultrade/ECS</a>
<ul>

		 <li>
        				<a href="#">popultrade</a>
        				<ul>
        				<li><a href="Javascript:go('nic_preskok.jsp?lokacijaa=esd10.jsp','<b>popultrade</b> - VSD')">VSD</a></li>
        					<li><a href="Javascript:go('nic_preskok.jsp?lokacijaa=esd60.jsp','<b>popultrade</b> - Preusmeritve')">Preusmeritve</a></li>
        					<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=esd50.jsp','<b>popultrade</b> - Predlozitev - Prvi urad')">Predlozitev - Prvi urad</a></li>
        					
        		

<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=esd50_2.jsp','<b>popultrade</b> - Predlozitev - Naslednji urad')">Predlozitev - Naslednji urad</a></li>



		</ul>
        			 </li>


	
		 <li>
        				<a href="#">ECS</a>
        				<ul>
        				<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=esd70.jsp','<b>ECS</b> - Prispetje na Izstop')">Prispetje na Izstop</a></li>
        					<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=esd80.jsp','<b>ECS</b> - Potrditev Izhoda')">Potrditev Izhoda</a></li>
        					<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=esd90.jsp','<b>ECS</b> - ISD')">ISD</a></li>
        				</ul>
        			 </li>

	
	  		 <li>
        				<a href="#">Sifranti</a>
        				<ul>
        				<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=plan.jsp','<b>Sifranti</b> - Plan prihodov ladij')">Plan prihodov ladij</a></li>
        					<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=stranke.jsp','<b>Sifranti</b> - Stranke')">Stranke</a></li>
        					<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=prevozniki.jsp','<b>Sifranti</b> - Prevozniki')">Prevozniki</a></li>
        				</ul>
        			 </li>

	
 		 <li>
        				<a href="#">VLM</a>
        				<ul>
        				<li><a href="Javascript:  go('nic_preskok.jsp?lokacijaa=manifestnajavaladje_list36688.jsp','<b>VLM</b> - Najava ladje')">Najava ladje</a></li>
        					<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=manifestnajavatovoragl_list37276.jsp','<b>VLM</b> - Najava tovora')">Najava tovora</a></li>
        				</ul>
        			 </li>

</ul></li>
			
				<!--  
				<b>
				<a href="m_users.jsp" onclick="return dom('m_users.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"> UPORABNIKI</span></font></a></b>
				
				<b>
				</b>
				
				-->
				
				</td>
				<td bgcolor="#E3F1FE" align="center" width="233">
				<a href="m_css_edit.jsp?slik=splosne" onclick="return dom('m_css_edit.jsp?slik=css')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Custom CSS </b></span></font></a> |
			<a href="m_upload.jsp?slik=splosne" onclick="return dom('m_upload.jsp?slik=css')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Upload CSS slike </b></span></font></a> |
				<a href="m_upload.jsp?slik=splosne" onclick="return dom('m_upload_d.jsp?slik=css')">
				<font color="#800000">
				<span style="text-decoration: none"><b>CSS Slike </b></span></font></a> 
				
				
				
				
				
				
			</td>
				<td bgcolor="#E3F1FE" align="center" width="233">
					<a href="m_upload.jsp" onclick="return dom('m_upload.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Upload slike gumbe</b></span></font></a> |
				<a href="m_upload.jsp" onclick="return dom('m_upload_d.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Slike gumbe</b></span></font></a> 
		
				</td>
				<td bgcolor="#E3F1FE" align="center" width="234">
				
						<a href="m_upload.jsp?slik=splosne" onclick="return dom('m_upload.jsp?slik=splosne')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Upload slike </b></span></font></a> |
				<a href="m_upload.jsp?slik=splosne" onclick="return dom('m_upload_d.jsp?slik=splosne')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Slike </b></span></font></a> 
				</td>
				<td bgcolor="#E3F1FE" align="center" width="234" >
					<a href="m_log_user.jsp" onclick="return dom('m_log_user.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"> <b>LOG USER</b></span></font></a> | 
			<a href="m_wse_log.jsp" onclick="return dom('m_wse_log.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"> <b>LOG popultrade</b></span></font></a> 
				</td>
			</tr>
			<tr>
				<td bgcolor="#E3F1FE" align="center" colspan=2>
				
					<a href="m_templatemenu.jsp" onclick="return doma('m_templatemenu.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"> <b>MENU</b></span></font></a> | 
				
					<a href="m_templatemenu.jsp" onclick="return doma('m_templatemenun.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"> <b>MN</b></span></font></a>
						
            			<select name="menut" id="menut" style="font-family: Verdana; font-size: 8pt" >
            			<option value="0">Default</option>
            			<%
            				com.popultrade.dao.TemplateMenunDAO daosii = (com.popultrade.dao.TemplateMenunDAO)contextUtil.getBeanDao("templateMenunDAO",pageContext.getServletContext());
					List lili = daosii.getTemplateMenuns(new com.popultrade.model.TemplateMenun(),"name","desc");

					Iterator ittii = lili.iterator();

					while (ittii.hasNext()) {
						com.popultrade.model.TemplateMenun sifr = (com.popultrade.model.TemplateMenun)ittii.next();
			
							%>
							<option  value="<%=nul.jeNull(sifr.getId())%>" <%=nul.jeNull(sifr.getId()).equals(nul.jeNull(session.getAttribute("menut")+""))?"selected":""%>><%=nul.jeNull(sifr.getName())%></option>
							<%
						
					}
					%>
					
					
					</select>
				
				 | 
				
					<a href="m_template_framein.jsp" onclick="return doma('m_template_framein.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"> <b>TEMPLATE</b></span></font></a> 
				
				
				
				
				
				
						 Jeziki: pregled:
            			<select name="jezikp" id="jezikp" style="font-family: Verdana; font-size: 8pt" >
            			<option value=""></option>
            			<%
            				com.popultrade.dao.JezikiDAO daosi = (com.popultrade.dao.JezikiDAO)contextUtil.getBeanDao("jezikiDAO",pageContext.getServletContext());
					List lil = daosi.getJezikis(new com.popultrade.model.Jeziki());

					Iterator itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Jeziki sifr = (com.popultrade.model.Jeziki)itti.next();
			
							%>
							<option  value="<%=nul.jeNull(sifr.getSIFRA_JEZ())%>" <%=nul.jeNull(sifr.getSIFRA_JEZ()).equals("SL")?"selected":""%>><%=nul.jeNull(sifr.getOPIS_JEZ())%></option>
							<%
						
					}
					%>
					
					
					</select>
				
				
						 Vnos:
            			<select name="jezikv" id="jezikv" style="font-family: Verdana; font-size: 8pt" >
            			<option value=""></option>
            			<%
           
				 itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Jeziki sifr = (com.popultrade.model.Jeziki)itti.next();
				
							%>
							<option  value="<%=nul.jeNull(sifr.getSIFRA_JEZ())%>" <%=nul.jeNull(sifr.getSIFRA_JEZ()).equals("SL")?"selected":""%>><%=nul.jeNull(sifr.getOPIS_JEZ())%></option>
							<%
						
					}
					%>
					
					
					</select>
				
				
			</td>
			
				<td bgcolor="#E3F1FE" align="center" width="233">

			<a href="m_dodatniprevodi.jsp" onclick="return doma('m_dodatniprevodi.jsp?idt=0')">
				<font color="#800000">
				<span style="text-decoration: none">DODATNI PREVODI</span></font></a> |
						<a href="m_reload_prevod.jsp"  onclick="return dom('m_reload_prevod.jsp')">
				<font color="#800000">
				<span style="text-decoration: none">RELOAD PREVOD</span></font></a>

</td>
				<td bgcolor="#E3F1FE" align="center" width="234">
				
						<a href="m_customclass.jsp"  onclick="return dom('m_customclass.jsp')">
				<font color="#800000">
				<span style="text-decoration: none">Custom class</span></font></a> |
					<!-- 	<a href="m_hibernate_list.jsp"  onclick="return dom('m_hibernate_list.jsp')"> -->
					<a href="m_template_tables_framein.jsp"  onclick="return dom('m_template_tables_framein.jsp')">
				<font color="#800000">
				<span style="text-decoration: none">Hibernate tables</span></font></a>
		
				
				
				</td>
				<td bgcolor="#E3F1FE" align="center" ><a href="m_logout.jsp" >
				<font color="#800000">
				<span style="text-decoration: none">LOGOUT</span></font></a></td>
				
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#ADD9FF"><font size="1" color="#ADD9FF">.</font></td>
	</tr>
</table>

</body>

</html>
