<%@ page contentType="text/html;charset=utf8" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>


<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<!-- jQuery -->




<%



/////// load prvodov, ce jih se ni

if (!ConPool.soPrevodi) {
	ConPool.setPrevode(contextUtil,pageContext.getServletContext());
	ConPool.soPrevodi=true;
}







try {
%>


 
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
 
 function go(semo,loka) {
parent.frames[0].document.location = semo;

//alert(loka.replace("YYY","\"").replace("XXX","'"));
document.getElementById("loka").innerHTML=loka.replace(/YYY/g,"\"").replace(/XXX/g,"'");

 }


 function goo(semo) {
	 parent.frames[0].document.location = semo;
 }

  function goSize(semo) {
  
  
parent.frames[0].document.location = semo;

 }
 
 
 
 
 
 
 var jezik = "<%=control.getJezik()%>";
 var jelog = "<%=control.getUser()%>";

 
 

 
 
 
 </script>
 <%
 
 
/// <!-- NAVODILA FILE SE DODAJA LOKACIJE NAVODIL NA PODLAGI IMENA STRANI V PRVEM FRAME-->
 %>
 <script language='javascript' src='navodila.js' ></script>
 



 <table border="0" width="100%" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">
<form method=post action="kontrola2.jsp" onSubmit="return WebSocketTest()" name=log><tr><td background="upb.gif"><img src="up1t.jpg" ></td><td align="right" background="upb.gif">
	
	<div id="toggleText" style="display: none;position:absolute;top:25">
	
	<table  border="0" bgcolor="e8e8e8"  cellspacing="3" cellpadding="1" border="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="silver"  id="AutoNumber1">
	<tr>
	<td bgcolor="f5f5f5"> F1:&nbsp;
	<input type="text" size=3 maxlength=3 style="font-family: Verdana; font-size: 7pt" id="fr1">
&nbsp;
	</td>
	<td bgcolor="f5f5f5"> F2:&nbsp;
	<input type="text" size=3 maxlength=3 style="font-family: Verdana; font-size: 7pt" id="fr2">
&nbsp;
	</td>
	<td bgcolor="f5f5f5"> F3:&nbsp;
	<input type="text" size=3 maxlength=3 style="font-family: Verdana; font-size: 7pt" id="fr3">
&nbsp;
	</td>
	<td bgcolor="f5f5f5">&nbsp;
	<input type="button" onclick="setAll()" style="font-family: Verdana; font-size: 7pt" value=" Shrani ">&nbsp;
	</td>
	</tr>

	</table>
	
	</div>
	
		<div id="toggleText2" style="display: none;position:absolute;top:25">
	
	<table  border="0" bgcolor="e8e8e8"  cellspacing="3" cellpadding="1" border="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="silver"  id="AutoNumber1">
	<tr>
	<td bgcolor="f5f5f5" align="center"> <%=nul.jeNull(ConPool.getPrevod_admin("1000008","Y",control.getJezik()+""))%>

	</td>

	</tr>

	</table>
	
	</div>
	
	
	<map name="FPMap0" id="FPMap0">
	   <%

if (!control.getUser().equals("anonymous") ) {
%>
	<area href="view.jsp" onclick="return toggle()" shape="rect" coords="189, 33, 252, 51">
	<%
}
	%>
	<area href="help.jsp"  onclick="return navod()" shape="rect" coords="256, 32, 336, 49">
	</map><img src="up2t.jpg" border="0" usemap="#FPMap0" ></td></tr>

	

<tr><td colspan="2">

 <table border="0" width="100%" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">
<tr><td width="16"><img src="upm1.gif" width="43" height="59"></td><td background="upmb.gif"  valign="bottom">

 <table border="0"  cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" cellpadding="0">
   <tr><td height=33 > <%

if (!control.getUser().equals("anonymous") ) {
	
	int z = 0;
	boolean prvii = false;
	
%>   

<ul id="main-menu" class="sm sm-simple">
 








	
<%


	
	 com.popultrade.dao.UsersPrivilegijeDAO daoup = (com.popultrade.dao.UsersPrivilegijeDAO)contextUtil.getBeanDao("usersPrivilegijeDAO",pageContext.getServletContext());

	 List lico = daoup.getUsersPrivilegijeByUserid(control.idUporabnika+"");
	 
	 Iterator ito = lico.iterator();
	 
	 Hashtable priv = new Hashtable();
	 
	 int stevilo = 0;
	 while (ito.hasNext()) {
		 
		 com.popultrade.model.UsersPrivilegije uprr = (com.popultrade.model.UsersPrivilegije)ito.next();
		 
		 
		 priv.put(uprr.getId_menija()+"","1");
	 
		 
	 }
	 

	 
	/////// dodatno iz template
	
	com.popultrade.dao.TemplateMenuDAO daotm = (com.popultrade.dao.TemplateMenuDAO)contextUtil.getBeanDao("templateMenuDAO",pageContext.getServletContext());

	
	
	
	
	com.popultrade.model.TemplateMenu sif = new com.popultrade.model.TemplateMenu();



	int strec = daotm.getStTemplateMenu(sif);


	 
	List lisi =null;

	lisi = daotm.getTemplateMenus(sif,1,1000);
	
	
	Iterator itf = lisi.iterator();
	while (itf.hasNext()) {
		com.popultrade.model.TemplateMenu tmenu = (com.popultrade.model.TemplateMenu)itf.next();
		if (priv.containsKey(tmenu.getId()+"")) {
		
		
		if (prvii) {
		%>
</ul></li>
<%
		}
		else {
		prvii=true;
		}
		
		
		%>

	
          	<li><a href="#"><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>
        		<ul class="sub_menu">
		
		

		<%
		}
		Iterator ihn = tmenu.getTemplatemenus().iterator();
		
		while (ihn.hasNext()) {
			com.popultrade.model.TemplateMenu tmenu2 = (com.popultrade.model.TemplateMenu)ihn.next();
			
			String kolo = "";
			
			if (tmenu2.getTemplatehead_id()!=null) {
				
				com.popultrade.dao.TemplateHeadDAO daoh = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

				com.popultrade.model.TemplateHead thed = daoh.getTemplateHead(tmenu2.getTemplatehead_id());
				
				if (nul.jeNull(thed.getHead_tip()).equals("UI")) {
					
					if (thed.getTemplatePPs()!=null && thed.getTemplatePPs().size()>0) {
					
					kolo = thed.getHead_class_name().toLowerCase()+ "_edit"+thed.getId()+"_p.jsp";
					}
					else {
						kolo = thed.getHead_class_name().toLowerCase()+ "_edit"+thed.getId()+".jsp";	
					}
					
					
				}
				else 	if (nul.jeNull(thed.getHead_tip()).equals("PR")) {
					
					if (thed.getTemplatePPs()!=null && thed.getTemplatePPs().size()>0) {
					
					kolo = thed.getHead_class_name().toLowerCase()+ "_proc"+thed.getId()+"_p.jsp";
					}
					else {
						kolo = thed.getHead_class_name().toLowerCase()+ "_proc"+thed.getId()+".jsp";	
					}
					
					
				}
				else if (nul.jeNull(thed.getHead_tip()).equals("HE")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_view.jsp";
				}
			//	else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
			//		kolo = thed.getHead_class_name().toLowerCase()+ ".jsp";
			//	}
				else if (nul.jeNull(thed.getHead_tip()).equals("SE")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_isci"+thed.getId()+".jsp";
				}
				else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_list"+thed.getId()+".jsp";
				}
				else if (nul.jeNull(thed.getHead_tip()).equals("LT")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_list"+thed.getId()+".jsp";
				}
				else if (nul.jeNull(thed.getHead_tip()).equals("HT")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_edit"+thed.getId()+".jsp";
				}
				
				
				
			}
			
			%>

		


<%

if (tmenu2.getTemplatemenus().size()>0) {

			Iterator ihni = tmenu2.getTemplatemenus().iterator();
			if (priv.containsKey(tmenu2.getId()+"") && priv.containsKey(tmenu.getId()+"")) {	
%>

	 <li>
     <a href="#"><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>
     <ul>


<%
			}
			while (ihni.hasNext()) {
				com.popultrade.model.TemplateMenu tmenu3 = (com.popultrade.model.TemplateMenu)ihni.next();
				
				String koloi = "";
				
				if (tmenu3.getTemplatehead_id()!=null) {
					
					com.popultrade.dao.TemplateHeadDAO daoh = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

					com.popultrade.model.TemplateHead thed = daoh.getTemplateHead(tmenu3.getTemplatehead_id());
					
					if (nul.jeNull(thed.getHead_tip()).equals("UI")) {
						
						if (thed.getTemplatePPs()!=null && thed.getTemplatePPs().size()>0) {
								
						koloi = thed.getHead_class_name().toLowerCase()+ "_edit"+thed.getId()+"_p.jsp";
						}
						else {
							koloi = thed.getHead_class_name().toLowerCase()+ "_edit"+thed.getId()+".jsp";
						}
					}
					else 	if (nul.jeNull(thed.getHead_tip()).equals("PR")) {
						
						if (thed.getTemplatePPs()!=null && thed.getTemplatePPs().size()>0) {
								
						koloi = thed.getHead_class_name().toLowerCase()+ "_proc"+thed.getId()+"_p.jsp";
						}
						else {
							koloi = thed.getHead_class_name().toLowerCase()+ "_proc"+thed.getId()+".jsp";
						}
					}
					else if (nul.jeNull(thed.getHead_tip()).equals("HE")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_view.jsp";
					}
					//else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
					//	koloi = thed.getHead_class_name().toLowerCase()+ ".jsp";
				//	}
					else if (nul.jeNull(thed.getHead_tip()).equals("SE")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_isci"+thed.getId()+".jsp";
					}
					else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_list"+thed.getId()+".jsp";
					}
					else if (nul.jeNull(thed.getHead_tip()).equals("LT")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_list"+thed.getId()+".jsp";
					}
					else if (nul.jeNull(thed.getHead_tip()).equals("HT")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_edit"+thed.getId()+".jsp";
					}
				}
				if (priv.containsKey(tmenu3.getId()+"")  && priv.containsKey(tmenu2.getId()+"")) {
					
					
					
					
					
				%>
				<%
				String frama = "";
				String sirdol="";
				if (nul.jeN(tmenu3.getSplit_frame_v()).equals("1")) {
					frama = "_framein_v";
					sirdol="||"+tmenu3.getOkno11()+":"+tmenu3.getOkno22();
				}
				else if (nul.jeN(tmenu3.getSplit_frame_h()).equals("1")) {
					frama = "_framein_h";
					sirdol="||"+tmenu3.getOkno11()+":"+tmenu3.getOkno22();
				}
					
				System.out.println("---------------ddd--------------------- "+tmenu3.getRocen_url());
				if (!nul.jeN(tmenu3.getRocen_url()).equals("")) {
					%>
					<li><a href="Javascript: go('nic_preskok<%=frama %>.jsp?lokacijaa=<%=tmenu3.getRocen_url()+nul.jeNull(tmenu3.getDodatni_pogoji())%><%=sirdol %>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%> - <a href=XXXJavascript: goo(YYYnic_preskok<%=frama %>.jsp?lokacijaa=<%=tmenu3.getRocen_url()+nul.jeNull(tmenu3.getDodatni_pogoji())%><%=sirdol %>YYY)XXX><%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"><%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a></li>
		 
					<%
				}
				else {
				
					%>
				<li><a href="Javascript: go('nic_preskok<%=frama %>.jsp?lokacijaa=<%=koloi+nul.jeNull(tmenu3.getDodatni_pogoji())%><%=sirdol %>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%> - <a href=XXXJavascript: goo(YYYnic_preskok<%=frama %>.jsp?lokacijaa=<%=koloi+nul.jeNull(tmenu3.getDodatni_pogoji())%><%=sirdol %>YYY)XXX><%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"><%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a></li>
	 
				<%
				}
				}
			}
if (priv.containsKey(tmenu2.getId()+"")  && priv.containsKey(tmenu.getId()+"")) {
%>
</ul></li>

<%
}
}
else {
	if (priv.containsKey(tmenu2.getId()+"")  && priv.containsKey(tmenu.getId()+"")) {
		
		
		String frama = "";
		String sirdol="";
		if (nul.jeN(tmenu2.getSplit_frame_v()).equals("1")) {
			frama = "_framein_v";
			sirdol="||"+tmenu2.getOkno11()+":"+tmenu2.getOkno22();
		}
		else if (nul.jeN(tmenu2.getSplit_frame_h()).equals("1")) {
			frama = "_framein_h";
			sirdol="||"+tmenu2.getOkno11()+":"+tmenu2.getOkno22();
		}
		
		System.out.println("---------------ddd--------------------- "+tmenu2.getRocen_url());
		if (!nul.jeN(tmenu2.getRocen_url()).equals("")) {
			%>
<li><a href="Javascript: go('nic_preskok<%=frama %>.jsp?lokacijaa=<%=tmenu2.getRocen_url()+nul.jeNull(tmenu2.getDodatni_pogoji())%><%=sirdol %>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <a href=XXXJavascript: goo(YYYnic_preskok<%=frama %>.jsp?lokacijaa=<%=tmenu2.getRocen_url()+nul.jeNull(tmenu2.getDodatni_pogoji())%><%=sirdol %>YYY)XXX><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a></li>
	
			<%
		}
		else {
	%>
	
	<li><a href="Javascript: go('nic_preskok<%=frama %>.jsp?lokacijaa=<%=kolo+nul.jeNull(tmenu2.getDodatni_pogoji())%><%=sirdol %>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <a href=XXXJavascript: goo(YYYnic_preskok<%=frama %>.jsp?lokacijaa=<%=kolo+nul.jeNull(tmenu2.getDodatni_pogoji())%><%=sirdol %>YYY)XXX><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a></li>
	
	
	<%
		}
	}
}


	//////		 
	
			
		}
		
		
		
		
	}
	
	if (prvii) {
		%>
</ul>
<%
}
	

%>


<%
}
   %>
   </td></tr><tr><td valign="bottom" width="100%" >
   <font size="1">&nbsp;<span id="loka"></span></font>
</td></tr></table>   
</td><td  background="upmb.gif" align="right">


<table border="0" width="300" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" height="59" id="AutoNumber1" cellpadding="0">
<tr><td background="upmm1.gif" width="13">


<img src="updel.gif"  height="59"></td><td background="upmm1.gif" width="250">

<table border="0" width="250" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111"  id="AutoNumber13" >
<tr><td>

   <%

if (control.getUser().equals("anonymous") ) {
%>
<%=nul.jeNull(ConPool.getPrevod_admin("1100004","Y",control.getJezik()+""))%>
<%
}
else {
	%>
	<%=control.getUser_naziv() %>
	<%
}
%>

</td><td>
   <%

if (control.getUser().equals("anonymous") ) {
%>
<input type=text name=user size="20" style="width:100; height:14; margin:0; padding:1; font-size: 7pt; font-family: Verdana; border-style: solid; border-width: 1; word-spacing:0; text-indent:0; line-height:100%">
<%
}
%>

</td></tr>
<tr><td colspan="2" height="1"><font style="font-size:3pt">&nbsp;</font></td></tr>
<tr><td>
   <%

if (control.getUser().equals("anonymous") ) {
%>
<%=nul.jeNull(ConPool.getPrevod_admin("1000005","Y",control.getJezik()+""))%>
<%
}
else { 
	%>

	<font color="red"><span id="errore"></span>&nbsp; </font>
	<%
}
%>
</td><td>
   <%

if (control.getUser().equals("anonymous") ) {
%>
<input type=password name=password size="20" style="width:100; height:14; padding:1; font-size: 7pt; font-family: Verdana; border-style: solid; border-width: 1">
 <%
}
 %>
</td></tr>
</table>
</td><td background="upmm2.gif"  align="center" width="120">
<table border="0" width="100" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111"  id="AutoNumber1" cellpadding="4">
<tr><td bgcolor="#D8D8D8" align="center">
   <%

if (!control.getUser().equals("anonymous") ) {
%>
<input type=button value="<%=nul.jeNull(ConPool.getPrevod_admin("1000007","Y",control.getJezik()+""))%>" onclick="document.location='logout.jsp'" style=" height:15;  font-size: 7pt; font-family: Verdana; border-style: solid; border-width: 1; padding-top:0; padding-bottom:0">
<!-- <a href="logout.jsp" style="text-decoration:none">LOGOUT</a> -->
<%
}
else {
%>
<input type=submit value="<%=nul.jeNull(ConPool.getPrevod_admin("1000006","Y",control.getJezik()+""))%>" style=" height:15;  font-size: 7pt; font-family: Verdana; border-style: solid; border-width: 1; padding-top:0; padding-bottom:0">
<%

}%>

</td></tr>
</table>
</td></tr>
</table>
</td><td  background="upmb.gif" align="right" width="16">
	<img src="upm3.gif" width="44" height="59"></td></tr>
</table>
</td></tr>
</form>

</table>


<%
}
catch (Exception ex) {
	
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
	
}
%>