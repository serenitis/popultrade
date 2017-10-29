<%@ page contentType="text/html;charset=utf8" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>


<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />

<%



/////// load prvodov, ce jih se ni

if (!ConPool.soPrevodi) {
	ConPool.setPrevode(contextUtil,pageContext.getServletContext());
	ConPool.soPrevodi=true;
}







try {
%>

 <style type="text/css" title="stylesheet.css">

@import "menu_script/menu.css";

</style>


<script src="menu_script/menubarAPI4.js" type="text/javascript"></script>


 
 <script language="javascript">
 
 



 <%

if (!control.getUser().equals("anonymous") ) {
	
	/// zaporedje prikaza
	
	int z = 0;
	
	
%>   







function inito(){

if(!window.standards) return;

if(window.inited) return;
//////////////////////////////////  GLOBAL OFFSET VARIABLES //////////////////////////////	
	if(bw.wIE || bw.ns){
		menuOffsetTop = 3; // first level menu. smaller number is more up
		menuOffsetLeft = 2; // first level menu. smaller number is more right.
	}
	else if(bw.mIE){
		menuOffsetTop = -1; // first level menu. smaller number is more right
		menuOffsetLeft = -6; // first level menu. smaller number is more right
	}
	submenuOffsetTop = -28 ;// smaller number is closer to top

	if(bw.wIE) submenuOffsetLeft = -12; // left-side menu. smaller number is closer to menu
	else if(bw.mIE) submenuOffsetLeft = -4; // left-side menu. smaller number is closer to menu

	submenuOffsetRight = 0;// right-side menu.  smaller number is closer to menu.
//////////////////////////////////  GLOBAL OFFSET VARIABLES //////////////////////////////	


	var uiMenubar = new Menubar();

<%
if (nul.jeNull(control.getMODUL02()).equals("1") || nul.jeNull(control.getMODUL01()).equals("1") || nul.jeNull(control.getMODUL03()).equals("1")) {
%>

	var stbMenux = new Menu('popultrade/ECS/VLM');
	uiMenubar.add(stbMenux);
	
	//stbMenux.addSeparator("#000388");

<%
}
	if (nul.jeNull(control.getMODUL01()).equals("1")) {
	%>
		
		stbDHTMLMenui = new Menu('popultrade');
		stbDHTMLMenui.add(new MenuItem("VSD","Javascript:go('nic_preskok.jsp?lokacijaa=esd10.jsp','<b>popultrade</b> - VSD')"));
		stbDHTMLMenui.add(new MenuItem("Preusmeritve","Javascript:go('nic_preskok.jsp?lokacijaa=esd60.jsp','<b>popultrade</b> - Preusmeritve')"));
		stbDHTMLMenui.add(new MenuItem("Predložitev - Prvi urad","Javascript: go('nic_preskok.jsp?lokacijaa=esd50.jsp','<b>popultrade</b> - Predložitev - Prvi urad')"));


	<%
	if (nul.jeNull(control.getParameter01()).equals("1")) {
	%>

	stbDHTMLMenui.add(new MenuItem("Predložitev - Naslednji urad","Javascript: go('nic_preskok.jsp?lokacijaa=esd50_2.jsp','<b>popultrade</b> - Predložitev - Naslednji urad')"));

	<%
	}
%>
stbMenux.add(stbDHTMLMenui);
stbMenux.addSeparator("#e8e8e8");
<%

	}
%>



<%
if (nul.jeNull(control.getMODUL02()).equals("1")) {
%>
	
	stbDHTMLMenue = new Menu('ECS');
	stbDHTMLMenue.add(new MenuItem("Prispetje na Izstop","Javascript: go('nic_preskok.jsp?lokacijaa=esd70.jsp','<b>ECS</b> - Prispetje na Izstop')"));
	stbDHTMLMenue.add(new MenuItem("Potrditev Izhoda","Javascript: go('nic_preskok.jsp?lokacijaa=esd80.jsp','<b>ECS</b> - Potrditev Izhoda')"));
	stbDHTMLMenue.add(new MenuItem("ISD","Javascript: go('nic_preskok.jsp?lokacijaa=esd90.jsp','<b>ECS</b> - ISD')"));


stbMenux.add(stbDHTMLMenue);
stbMenux.addSeparator("#e8e8e8");
<%

}


%>



<%
if (nul.jeNull(control.getMODUL03()).equals("1")) {
%>
	
	stbDHTMLMenus = new Menu('Sifranti');
	stbDHTMLMenus.add(new MenuItem("Plan prihodov ladij","Javascript: go('nic_preskok.jsp?lokacijaa=plan.jsp','<b>Sifranti</b> - Plan prihodov ladij')"));
	stbDHTMLMenus.add(new MenuItem("Stranke","Javascript: go('nic_preskok.jsp?lokacijaa=stranke.jsp','<b>Sifranti</b> - Stranke')"));
	stbDHTMLMenus.add(new MenuItem("Prevozniki","Javascript: go('nic_preskok.jsp?lokacijaa=prevozniki.jsp','<b>Sifranti</b> - Prevozniki')"));

stbMenux.add(stbDHTMLMenus);
stbMenux.addSeparator("#e8e8e8");
<%

}
if (nul.jeNull(control.getMODUL05()).equals("1")) {
%>
	
	stbDHTMLMenus = new Menu('VLM');
	stbDHTMLMenus.add(new MenuItem("Najava ladje","Javascript: go('nic_preskok.jsp?lokacijaa=manifestnajavaladje_list36688.jsp','<b>VLM</b> - Najava ladje')"));
	stbDHTMLMenus.add(new MenuItem("Najava tovora","Javascript: go('nic_preskok.jsp?lokacijaa=manifestnajavatovoragl_list37276.jsp','<b>VLM</b> - Najava tovora')"));
	

stbMenux.add(stbDHTMLMenus);
//stbMenux.addSeparator("#000388");
<%

}
z++;
%>








	
<%

	if (nul.jeNull(control.getMODUL01()).equals("1")) {
		
		//nul.
%>



/*	var stbMenu = new Menu('popultrade');
	uiMenubar.add(stbMenu);
	stbMenu.add(new MenuItem("VSD","Javascript:go('nic_preskok.jsp?lokacijaa=esd10.jsp','<b>popultrade</b> - VSD')"));
	stbMenu.add(new MenuItem("Preusmeritve","Javascript:go('nic_preskok.jsp?lokacijaa=esd60.jsp','<b>popultrade</b> - Preusmeritve')"));
	stbMenu.add(new MenuItem("Predložitev - Prvi urad","Javascript: go('nic_preskok.jsp?lokacijaa=esd50.jsp','<b>popultrade</b> - Predložitev - Prvi urad')"));
*/

<%
if (nul.jeNull(control.getParameter01()).equals("1")) {
%>

//stbMenu.add(new MenuItem("Predložitev - Naslednji urad","Javascript: go('nic_preskok.jsp?lokacijaa=esd50_2.jsp','<b>popultrade</b> - Predložitev - Naslednji urad')"));

<%
}
//z++;
	}
	if (nul.jeNull(control.getMODUL02()).equals("1")) {

%>
/*
uiMenubar.add(plmMenu = new Menu('ECS'));
plmMenu.add(new MenuItem("Prispetje na Izstop","Javascript: go('nic_preskok.jsp?lokacijaa=esd70.jsp','<b>ECS</b> - Prispetje na Izstop')"));
plmMenu.add(new MenuItem("Potrditev Izhoda","Javascript: go('nic_preskok.jsp?lokacijaa=esd80.jsp','<b>ECS</b> - Potrditev Izhoda')"));
plmMenu.add(new MenuItem("ISD","Javascript: go('nic_preskok.jsp?lokacijaa=esd90.jsp','<b>ECS</b> - ISD')"));
	*/

<%
//z++;
	}
	if (nul.jeNull(control.getMODUL03()).equals("1")) {

%>

/*
uiMenubar.add(plmMenu2 = new Menu('Sifranti'));
plmMenu2.add(new MenuItem("Plan prihodov ladij","Javascript: go('nic_preskok.jsp?lokacijaa=plan.jsp','<b>Sifranti</b> - Plan prihodov ladij')"));
plmMenu2.add(new MenuItem("Stranke","Javascript: go('nic_preskok.jsp?lokacijaa=stranke.jsp','<b>Sifranti</b> - Stranke')"));
plmMenu2.add(new MenuItem("Prevozniki","Javascript: go('nic_preskok.jsp?lokacijaa=prevozniki.jsp','<b>Sifranti</b> - Prevozniki')"));
*/
<%
//z++;
	}
	if (nul.jeNull(control.getMODUL04()).equals("1")) {

%>
/*
uiMenubar.add(plmMenu22 = new Menu('Sifranti'));
plmMenu22.add(new MenuItem("Plan prihodov ladij","Javascript: go('nic_preskok.jsp?lokacijaa=plan.jsp','<b>Sifranti</b> - Plan prihodov ladij')"));
plmMenu22.add(new MenuItem("Stranke","Javascript: go('nic_preskok.jsp?lokacijaa=stranke.jsp','<b>Sifranti</b> - Stranke')"));
plmMenu22.add(new MenuItem("Prevozniki","Javascript: go('nic_preskok.jsp?lokacijaa=prevozniki.jsp','<b>Sifranti</b> - Prevozniki')"));
*/
<%
//z++;
	}
	if (nul.jeNull(control.getMODUL05()).equals("1")) {

%>
   
/*
uiMenubar.add(plmMenu23 = new Menu('Sifranti'));
plmMenu23.add(new MenuItem("Plan prihodov ladij","Javascript: go('nic_preskok.jsp?lokacijaa=plan.jsp','<b>Sifranti</b> - Plan prihodov ladij')"));
plmMenu23.add(new MenuItem("Stranke","Javascript: go('nic_preskok.jsp?lokacijaa=stranke.jsp','<b>Sifranti</b> - Stranke')"));
plmMenu23.add(new MenuItem("Prevozniki","Javascript: go('nic_preskok.jsp?lokacijaa=prevozniki.jsp','<b>Sifranti</b> - Prevozniki')"));
 */
   
<%
//z++;
	}
	
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
		%>

		uiMenubar.add(plmMenu<%=tmenu.getId()%> = new Menu('<%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>'));


		
		

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
				
				
				
				
				
			}
			
			%>

		


<%

if (tmenu2.getTemplatemenus().size()>0) {

			Iterator ihni = tmenu2.getTemplatemenus().iterator();
			if (priv.containsKey(tmenu2.getId()+"") && priv.containsKey(tmenu.getId()+"")) {	
%>
plmMenu<%=tmenu.getId()%>.addSeparator("#e8e8e8");
stbDHTMLMenu<%=tmenu2.getId()%> = new Menu('<%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>');
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
				}
				if (priv.containsKey(tmenu3.getId()+"")  && priv.containsKey(tmenu2.getId()+"")) {
				%>

				stbDHTMLMenu<%=tmenu2.getId()%>.add(new MenuItem("<%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>","Javascript: go('nic_preskok.jsp?lokacijaa=<%=koloi+nul.jeNull(tmenu3.getDodatni_pogoji())%>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%> - <a href=XXXJavascript: goo(YYYnic_preskok.jsp?lokacijaa=<%=koloi+nul.jeNull(tmenu3.getDodatni_pogoji())%>YYY)XXX><%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"));
				 
				<%
				}
			}
if (priv.containsKey(tmenu2.getId()+"")  && priv.containsKey(tmenu.getId()+"")) {
%>

plmMenu<%=tmenu.getId()%>.add(stbDHTMLMenu<%=tmenu2.getId()%>);
plmMenu<%=tmenu.getId()%>.addSeparator("#e8e8e8");
<%
}
}
else {
	if (priv.containsKey(tmenu2.getId()+"")  && priv.containsKey(tmenu.getId()+"")) {
	%>
	plmMenu<%=tmenu.getId()%>.add(new MenuItem("<%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>","Javascript: go('nic_preskok.jsp?lokacijaa=<%=kolo+nul.jeNull(tmenu2.getDodatni_pogoji())%>','<b><%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></b> - <a href=XXXJavascript: goo(YYYnic_preskok.jsp?lokacijaa=<%=kolo+nul.jeNull(tmenu2.getDodatni_pogoji())%>YYY)XXX><%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%></a>')"));
	
	<%
	}
}


			 
	
			
		}
		
		
		
		
	}
	
	
	

%>
















/*



	stbMenu.addSeparator("#000388");
	stbDHTMLMenu = new Menu('DHTML scripts');
	stbDHTMLMenu.add(new MenuItem('Main index','http://simplythebest.net/scripts/DHTML_scripts/'));
	stbDHTMLMenu.add(new MenuItem('Animation','http://simplythebest.net/scripts/DHTML_scripts/dhtml_animation.html'));
	stbDHTMLMenu.add(new MenuItem('Background scripts','http://simplythebest.net/scripts/DHTML_scripts/dhtml_background.html'));
	stbDHTMLMenu.add(new MenuItem('Buttons','http://simplythebest.net/scripts/DHTML_scripts/dhtml_buttons.html'));
	stbDHTMLMenu.add(new MenuItem('Calculators','http://simplythebest.net/scripts/DHTML_scripts/dhtml_calculators.html'));
	stbDHTMLMenu.add(new MenuItem('E-mail scripts','http://simplythebest.net/scripts/DHTML_scripts/dhtml_email.html'));
	stbDHTMLMenu.add(new MenuItem('Enhancements','http://simplythebest.net/scripts/DHTML_scripts/dhtml_enhancements.html'));
	stbDHTMLMenu.add(new MenuItem('Forms','http://simplythebest.net/scripts/DHTML_scripts/dhtml_forms.html'));
	stbDHTMLMenu.add(new MenuItem('Image rotations','http://simplythebest.net/scripts/DHTML_scripts/dhtml_images.html'));
	stbDHTMLMenu.add(new MenuItem('Menus','http://simplythebest.net/scripts/DHTML_scripts/dhtml_menu_scripts.html'));
	stbDHTMLMenu.add(new MenuItem('Messages','http://simplythebest.net/scripts/DHTML_scripts/dhtml_messages.html'));
	stbDHTMLMenu.add(new MenuItem('Password protection','http://simplythebest.net/scripts/DHTML_scripts/dhtml_passwords.html'));
	stbDHTMLMenu.add(new MenuItem('Scrollers','http://simplythebest.net/scripts/DHTML_scripts/dhtml_scroller_scripts.html'));
	stbMenu.add(stbDHTMLMenu);
	stbMenu.addSeparator("#000388");

	stbMenu.add(new MenuItem("Free fonts",'http://simplythebest.net/fonts/'));
	stbMenu.add(new MenuItem("Hosting providers",'http://simplythebest.net/hosting/'));
	stbMenu.add(new MenuItem("Information library",'http://simplythebest.net/info/'));
	stbMenu.add(new MenuItem("Music directory",'http://simplythebest.net/music/'));
	stbMenu.add(new MenuItem("Shareware",'http://simplythebest.net/shareware/'));
	stbMenu.add(new MenuItem("Shopping",'http://simplythebest.net/shop/'));
	stbMenu.add(new MenuItem("Metasearch",'http://simplythebest.net/search/'));

	uiMenubar.add(plmMenu = new Menu('PlanMagic'));
	plmMenu.add(new MenuItem('Main business page','http://planmagic.com'));
	
	plmMenu.addSeparator("#000388");
	plmProdMenu = new Menu('Business software');
	plmProdMenu.help="Windows, Menus, Tabs, Scrollers";//appears in statusbar

	plmProdMenu.add(new MenuItem('Business plan','http://planmagic.com/business_planning.html'));
	plmProdMenu.add(new MenuItem('Marketing plan','http://planmagic.com/marketing_planning.html'));
	plmProdMenu.add(new MenuItem('Financial plan','http://planmagic.com/finance.html'));
	plmProdMenu.add(new MenuItem('Web marketing plan','http://planmagic.com/webquest.html'));
	plmProdMenu.add(new MenuItem('Restaurant plan','http://plan-a-restaurant.com'));
	plmMenu.add(plmProdMenu);
	plmMenu.addSeparator("#000388");
	
	plmMenu.add(new MenuItem('Download page','http://planmagic.com/download.html'));
	plmMenu.add(new MenuItem('Register','http://planmagic.com/register.html'));
	plmMenu.add(new MenuItem('Contact us','http://planmagic.com/contact.html'));	

	webMenu = new Menu('Web Designs');
	webMenu.add(new MenuItem('Main index','http://simplythebest.net/web_builder/'));
	webMenu.add(new MenuItem('Design','http://simplythebest.net/web_builder/design.htm'));
	webMenu.add(new MenuItem('Marketing','http://simplythebest.net/web_builder/marketing.htm'));
	webMenu.add(new MenuItem('Promotion','http://simplythebest.net/web_builder/promotion.htm'));
	webMenu.add(new MenuItem('E-commerce','http://simplythebest.net/web_builder/ecommerce.htm'));
	webMenu.add(new MenuItem('Programming','http://simplythebest.net/web_builder/programming.htm'));
	webMenu.add(new MenuItem('Portfolio','http://simplythebest.net/web_builder/portfolio.htm'));
	uiMenubar.add(webMenu);

	wqpMenu = new Menu('WebQuestPro');
	wqpMenu.add(new MenuItem('Web marketing plan','http://webquestpro.com/web_marketing.html'));
	wqpMenu.add(new MenuItem('Targeted design','http://webquestpro.com/mdesign.htm'));
	wqpMenu.add(new MenuItem('Online marketing','http://webquestpro.com/mmarketing.htm'));
	wqpMenu.add(new MenuItem('Online success','http://webquestpro.com/msuccess.htm'));
	uiMenubar.add(wqpMenu);
	*/
	
	
	
	uiMenubar.useMouseOver();

//document.getElementById("menu").appendChild(uiMenubar);
	
	document.body.appendChild(uiMenubar);
	
	
	uiMenubar.setWidth("auto",0);
	
	window.inited = true;
	
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
<form method=post action="kontrola2.jsp" onSubmsit="return chkk()" name=log><tr><td background="upb.gif"><img src="up1t.jpg" ></td><td align="right" background="upb.gif">
	
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
   <tr><td height=33 width=400> <%

if (!control.getUser().equals("anonymous") ) {
%>
	<script type="text/javascript" language="JavaScript">
//function showme() {
//showMenus(1,'Horizontal')
//}
</script>
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
	<a href="Javascript:goSize('nic_preskok.jsp?lokacijaa=.jsp')" style="text-decoration:none">
	<font color="red">&nbsp; </font>
	</a>
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