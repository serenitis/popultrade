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

<link rel="stylesheet" href="css/stylemobilemenu.css">
<link rel="stylesheet" href="css/slicknav.css">
 
 <script language="javascript">
 
 




 
 function go(semo,loka) {
document.location = semo;

//alert(loka.replace("YYY","\"").replace("XXX","'"));
//document.getElementById("loka").innerHTML=loka.replace(/YYY/g,"\"").replace(/XXX/g,"'");

 }


 function goo(semo) {
	 parent.frames[0].document.location = semo;
 }

  function goSize(semo) {
  
  
parent.frames[0].document.location = semo;

 }
 
 
 

 /// module init
 
$(document).ready(function(){
	$('#menu').slicknav({
	
	prependTo:"#floatMenu"
	
	});
});
 
 
 
 </script>
 <script src="js/modernizr.min.js"></script>
 <script src="js/jquery.slicknav.min.js"></script>
 <%
 
 
/// <!-- NAVODILA FILE SE DODAJA LOKACIJE NAVODIL NA PODLAGI IMENA STRANI V PRVEM FRAME-->
 %>
 <script language='javascript' src='navodila.js' ></script>
 



 <table border="0" width="100%" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">
<tr><td align="right" >
	<ul id="menu">
 <%

	
	int z = 0;
	boolean prvii = false;



//z++;



	
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


if (!nul.jeNull(request.getParameter("idmen")).equals("") && !nul.jeNull(request.getParameter("idmen")).equals("0")) {
sif.setMenu(new Long(request.getParameter("idmen")));
}

	//int strec = daotm.getStTemplateMenu(sif);


	 
	List lisi =null;

	lisi = daotm.getTemplateMenus(sif,1,1000);
	
	
	Iterator itf = lisi.iterator();
	while (itf.hasNext()) {
		com.popultrade.model.TemplateMenu tmenu = (com.popultrade.model.TemplateMenu)itf.next();
		if (priv.containsKey(tmenu.getId()+"") || (nul.jeNull(tmenu.getShow_wo_login()).equals("1"))) {
		
		
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
        		<ul >
		
		

		<%
		}
		Iterator ihn = tmenu.getTemplatemenus().iterator();
		
		while (ihn.hasNext()) {
			com.popultrade.model.TemplateMenu tmenu2 = (com.popultrade.model.TemplateMenu)ihn.next();
			
			String kolo = "";
			
			if (tmenu2.getTemplatehead_id()!=null) {
				
				com.popultrade.dao.TemplateHeadDAO daoh = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

				com.popultrade.model.TemplateHead thed = daoh.getTemplateHead(tmenu2.getTemplatehead_id());
				
					if (!nul.jeNull(thed.getGennamefile()).equals("")) {
					kolo = thed.getGennamefile().toLowerCase()+ ".jsp";
					}
				else if (nul.jeNull(thed.getHead_tip()).equals("UI")) {
					
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
			if ((priv.containsKey(tmenu2.getId()+"") && priv.containsKey(tmenu.getId()+"")) || (nul.jeNull(tmenu.getShow_wo_login()).equals("1") && nul.jeNull(tmenu2.getShow_wo_login()).equals("1"))) {	
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
					
					if (!nul.jeNull(thed.getGennamefile()).equals("")) {
					koloi = thed.getGennamefile().toLowerCase()+ ".jsp";
					}
					
					
					else if (nul.jeNull(thed.getHead_tip()).equals("UI")) {
						
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

				<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=<%=koloi+nul.jeNull(tmenu3.getDodatni_pogoji())%>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%> - <a href=XXXJavascript: goo(YYYnic_preskok.jsp?lokacijaa=<%=koloi+nul.jeNull(tmenu3.getDodatni_pogoji())%>YYY)XXX><%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"><%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a></li>
	 
				<%
				}
			}
if ((priv.containsKey(tmenu2.getId()+"")  && priv.containsKey(tmenu.getId()+"")) || (nul.jeNull(tmenu.getShow_wo_login()).equals("1") && nul.jeNull(tmenu2.getShow_wo_login()).equals("1"))) {
%>
</ul></li>

<%
}
}
else {
	if ((priv.containsKey(tmenu2.getId()+"")  && priv.containsKey(tmenu.getId()+"")) || (nul.jeNull(tmenu.getShow_wo_login()).equals("1") && nul.jeNull(tmenu2.getShow_wo_login()).equals("1"))) {
	%>
	
	<li><a href="Javascript: go('nic_preskok.jsp?lokacijaa=<%=kolo+nul.jeNull(tmenu2.getDodatni_pogoji())%>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <a href=XXXJavascript: goo(YYYnic_preskok.jsp?lokacijaa=<%=kolo+nul.jeNull(tmenu2.getDodatni_pogoji())%>YYY)XXX><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a></li>
	
	
	<%
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

   %>
   </td></tr>






</table>


<%
}
catch (Exception ex) {
	
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
	
}
%>