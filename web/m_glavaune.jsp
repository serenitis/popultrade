<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,sun.net.ftp.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
 
  <%
 request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
 
 if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}



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
<title>AppBuilder Admin Module</title>
<!-- SmartMenus core CSS (required) -->
<link href='js/css/sm-core-css.css' rel='stylesheet' type='text/css' />
<!-- "sm-blue" menu theme (optional, you can use your own CSS, too) -->
<link href='js/css/sm-simple/sm-simple.css' rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="js/jqueryui/jquery-ui.css">


  <link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="scripts/jquery.min.js"></script> 
    <script type="text/javascript" src="scripts/jquery-migrate.min.js"></script>
     <script type="text/javascript" src="js/jqueryui/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jqxcore.js"></script>
    <script type="text/javascript" src="js/jqxsplitter.js"></script>
<link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />

<script src="js/jquery.smartmenus.js" type="text/javascript"></script>


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







</head>

<script language="javascript">






<%
if (!control.getUser().equals("anonymous") ) {
	/// zaporedje prikaza
	int z = 0;
%>   
function inito() {
	 $(function() {
 $('#main-menu').smartmenus();
});
}

<%
}
else {
	%>
	function inito() {
	}
	<%
}
%>


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

parent.frames[2].location='nic.jsp';
parent.frames[3].location='nic.jsp';


return false;
}



function openrep() {
	
	$( "#dialog" ).dialog({
		
		width: 900,
		height: 400
		
	});
	
	return false;
}


</script>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="inito();">



<table border="0" cellpadding="0" cellspacing="0" width="100%" height=100% id="table1">
	<tr height=15>
		<td bgcolor="#ADD9FF" align="center"><font size="1" color="#ADD9FF">.</font><font size="1"  face="verdana"> 
		VERSION 0.61</font><iframe name=ifrprvi style="width:1;height:1"></iframe></td>
	</tr>
	<tr height=50>
		<td bgcolor="#C4E1FD" align="center">
		<table border="0" cellspacing="3" width="100%" id="table2" style="font-family: Verdana; font-size: 8pt">
	 		<tr>
				<td bgcolor="#E3F1FE" width="233">



				<ul id="main-menu" class="sm sm-simple">
 

 

	<li><a href="#">Menu</a>
<ul>

		 <li>
        				<a href="#">CSS</a>
        				<ul>
        				<li><a  href="#" onclick="return  go('m_css_edit.jsp?slik=splosne','<b>popultrade</b> - Custom CSS')">Custom CSS</a></li>
        					<li><a  href="#" onclick="return  go('m_upload.jsp?slik=css','<b>popultrade</b> - CSS Images Upload')">CSS Images Upload</a></li>
        					<li><a  href="#" onclick="return  go('m_upload.jsp?slik=splosne','<b>popultrade</b> - CSS Images')">CSS Images</a></li>
        					<li><a  href="#" onclick="return  go('m_css_list.jsp','<b>popultrade</b> - CSS Graphics (default blue)')">CSS Graphics (default blue)</a></li>
        					
        					



		</ul>
        			 </li>


	
		 <li>
        				<a href="#">Hibernate classes</a>
        				<ul>
        				<li><a  href="#" onclick="return go('m_template_tables_framein.jsp','<b>popultrade</b> - Hibernate Classes')">Hibernate Classes</a></li>
        					<li><a  href="#" onclick="return  go('m_customclass.jsp','<b>popultrade</b> - Custom class')">Custom class (in development)</a></li>
        					
        				</ul>
        			 </li>

	
	  		 <li>
        				<a href="#">Images for buttons</a>
        				<ul>
        				<li><a  href="#" onclick="return   go('m_upload_d.jsp','<b>popultrade</b> - Button Images')">Button Images</a></li>
        					<li><a  href="#" onclick="return  go('m_upload.jsp','<b>popultrade</b> - Upload Button Images')">Upload Button Images</a></li>
        					
        				</ul>
        			 </li>

	
 		 <li>
        				<a href="#">Images</a>
        				<ul>
        				<li><a href="#" onclick="return  go('m_upload.jsp?slik=splosne','<b>popultrade</b> - Images')">Images</a></li>
        					<li><a  href="#" onclick="return  go('m_upload_d.jsp?slik=splosne','<b>popultrade</b> - Upload Images')">Upload Images</a></li>
        				</ul>
        			 </li>
        			 
   		 <li>
        				<a href="#">Users</a>
        				<ul>
        				<li><a href="#" onclick="return  go('m_users.jsp','<b>popultrade</b> - Users')">Users</a></li>
        					
        				</ul>
        			 </li>      			 
        			 
        			 
        			 	 <li>
        				<a href="#">Javascript DB</a>
        				<ul>
        				<li><a href="#" onclick="return  go('m_javascript_db.jsp','<b>popultrade</b> - Javascript DB tables')">Javascript DB tables</a></li>
        					
        				</ul>
        			 </li>   
        			 
        			 
        			 	 	 <li>
        				<a href="#">Custom pages</a>
        				<ul>
        				<li><a href="#" onclick="return  go('m_custompages.jsp','<b>popultrade</b> - Custom pages')">Custom pages (inside application)</a></li>
        					
        				</ul>
        			 </li>  
        			 
        			 
        			 
        				 <li>
        				<a href="#">Conversions</a>
        				<ul>
        				<li><a href="#" onclick="return  go('m_conversion_framein.jsp','<b>popultrade</b> - Conversions')">Conversions</a></li>
        					
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
				<td bgcolor="#E3F1FE" align="center" width="233"><!-- 
				<a href="m_css_edit.jsp?slik=splosne" onclick="return dom('m_css_edit.jsp?slik=css')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Custom CSS </b></span></font></a> |
			<a href="m_upload.jsp?slik=splosne" onclick="return dom('m_upload.jsp?slik=css')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Upload CSS slike </b></span></font></a> |
				<a href="m_upload.jsp?slik=splosne" onclick="return dom('m_upload_d.jsp?slik=css')">
				<font color="#800000">
				<span style="text-decoration: none"><b>CSS Slike </b></span></font></a> 
				
				
				-->
				
				
				
			</td>
				<td bgcolor="#E3F1FE" align="center" width="233">
				
			<a href="m_templatecodes.jsp" onclick="return doma('m_templatecodes.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Codes (Sifranti)</b></span></font></a>
				</td>
				<td bgcolor="#E3F1FE" align="center" width="234">
			<!-- 
			<a href="m_templaterepository.jsp" onclick="return doma('m_templaterepository.jsp')">
				<font color="#800000">
				<span style="text-decoration: none"><b>Repository</b></span></font></a>-->
			
				<a href="m_templaterepository.jsp" onclick="return openrep()">
				<font color="#800000">
				<span style="text-decoration: none"><b>Repository</b></span></font></a>
			
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
				<td bgcolor="#E3F1FE" align="center" colspan=2 width=234>
				
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
				<!-- 
						<a href="m_customclass.jsp"  onclick="return dom('m_customclass.jsp')">
				<font color="#800000">
				<span style="text-decoration: none">Custom class</span></font></a> |
					
					<a href="m_template_tables_framein.jsp"  onclick="return dom('m_template_tables_framein.jsp')">
				<font color="#800000">
				<span style="text-decoration: none">Hibernate tables</span></font></a>
		 |
				
					<a href="m_css_list.jsp"  onclick="return dom('m_css_list.jsp')">
				<font color="#800000">
				<span style="text-decoration: none">Css grafika</span></font></a>-->
				
				
				<a href="m_users_disabled.jsp"  onclick="return dom('m_users_disabled.jsp')">
				<font color="#800000">
				<span style="text-decoration: none">RESET DISABLED USERS</span></font></a>
				
				
				
				</td>
				<td bgcolor="#E3F1FE" align="center" ><a href="m_logout.jsp" >
				<font color="#800000">
				<span style="text-decoration: none">LOGOUT</span></font></a></td>
				
			</tr>
		</table>
		</td>
	</tr>
	<tr height=15>
		<td bgcolor="silver"><font size="1" color="silver">.</font></td>
	</tr>
	
	
	
	
	<tr><td>

    <div id="mainSplitter">
        <div id='topp' style="background-image:url('podlaga.jpg');">
       
<iframe noresize="noresize"  id="ifr2" name="prva" scrolling="yes" frameborder="0"  style="width:100%;height:100%"  >b</iframe>
        </div>
<div>
        <div id="firstNested">
            <div  >


<iframe noresize="noresize" id="ifr3" name="druga" src="nic.jsp" scrolling="yes" frameborder="0" style="width:100%;height:100%"  >b</iframe>

            </div>
          
 <div >   

<iframe noresize="noresize"  id="ifr4" scrolling="yes" name="tretja" src="nic.jsp" frameborder="0" style="width:100%;height:100%" onload="collapseL(this.contentWindow.location)" >b</iframe>

     </div>




        </div>
    </div>
</td></tr>


</table>


	<div id="dialog" title="Repository" style="display:none">

<iframe noresize="noresize"  id="ifr5" scrolling="yes" name="cetrta" src="m_repository_framein.jsp" frameborder="0" style="width:100%;height:100%" >b</iframe>

</div>
	
	<script language="javascript">

     $(document).ready(function () {
         var theme = 'classic';
  
         $('#mainSplitter').jqxSplitter({ theme: theme, width: '100%', height: '100%', orientation: 'horizontal', panels: [{ size: '20%' }, { size: '80%'}] });
$('#firstNested').jqxSplitter({ theme: theme, orientation: 'horizontal', panels: [{ size: '60%',collapsible:false}, { size: '40%',collapsible:true}] });
});


     var prej = "";
     function collapseL(kajj) {
    	 
    	// panels[0][1].collapsible = true;

       // panels[0][2].collapsible = false;

     //    $('#firstNested').jqxSplitter({ panels: panels });         

     kaj = kajj+"";
     if (kaj.indexOf("nic.jsp")==-1) {
     
    //	 if (prej!=kaj) {
    	 
    //	 prej = kaj;
         $('#firstNested').jqxSplitter('expand');
   // 	 }
    	 
    	 
    	 
     }
     
     if (kaj.indexOf("nic.jsp")!=-1) {
    	  $('#firstNested').jqxSplitter('collapse');
    	 
     }
         
         
     }
     
     
     
     
     
</script>

</body>

</html>
