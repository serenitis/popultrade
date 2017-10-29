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


<%!




/// kreacija elementov
com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();

public String createElement(com.popultrade.model.TemplateUi templateui,com.popultrade.webapp.control control,javax.servlet.http.HttpServletRequest request,javax.servlet.http.HttpSession session,com.popultrade.webapp.conPool ConPool,boolean iseditable) {


StringBuffer sb = new StringBuffer();

/// ce gre za absolute pozicijo, se doda id na div, ki drzi vse
String absol = (nul.jeN(templateui.getDposition()).equals("absolute")?"id='"+templateui.getParameter_drugo_ime()+"_div'":"")+"";



if (templateui!=null) {

if (nul.jeNull(templateui.getTip_inserta()).equals("tbutton")) {


/// za dodat opcijo onclick
String olem = "";
if (!nul.jeNull(templateui.getDtarget()).equals("") && (!nul.jeNull(templateui.getDtargettemp()).equals("") || !nul.jeNull(templateui.getDtargetroc()).equals("") || !nul.jeNull(templateui.getDtargetrocjs()).equals(""))) {
String targett =nul.jeNull(templateui.getDtarget());

if (!nul.jeNull(templateui.getDtarget()).startsWith("parent")) {
 targett = "parent."+templateui.getDtarget()+".location";
}
olem = "onclick=\"";

if (!nul.jeNull(templateui.getDtargettemp()).equals("")) {

olem += targett+"='"+templateui.getDtargettemp()+"';return false;";

}
else if (!nul.jeNull(templateui.getDtargetroc()).equals("")) {
olem += targett+"='"+templateui.getDtargetroc()+"';return false;";

}
else if (!nul.jeNull(templateui.getDtargetrocjs()).equals("")) {
olem += templateui.getDtargetrocjs()+";return false;";

}



olem += "\"";


}


sb.append("<div "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"touchbutton":templateui.getDdivclasscus())+"\" style=\""+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+";\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='center' valign='middle'>");

if (!nul.jeNull(templateui.getDslikag()).equals("")) {
sb.append("<img src='"+control.lokacija_default_slik+templateui.getDslikag()+"' alt=\""+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"\" border='0'>");
}


if (!nul.jeNull(templateui.getDbuttontextvisible()).equals("1")) {

sb.append("<br><span  class=\""+(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf())+"\">");
if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinput' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinput' size=2>");

/// update - delete gumbi

sb.append("</span>");
}
sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}


sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");



sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templategumbiparametri_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idback="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&idt="+request.getParameter("idt")+"')\"><img src=\"v.gif\" border=0  title=\"Spremeni parametre\"></a>");
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templategumbi_edit2.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idback="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&idt="+request.getParameter("idt")+"')\"><img src=\"c.gif\" border=0  title=\"Pogoj prikaza\"></a>");

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}


sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}




else if (nul.jeNull(templateui.getTip_inserta()).equals("ttextarea")) {

sb.append("<div  "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"touchtextarea":templateui.getDdivclasscus())+"\" style=\""+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+";\"><table "+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?" width=100% height=100% border=0 cellspacing=0 cellpadding=0 ":"")+" "+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"":"class='"+templateui.getDdivfirsttable()+"'")+"><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='center' valign='middle'>");
sb.append("<span  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf()))+"\">");

//sb.append("<textarea  class='touchinputta' readonly='readonly'  cols='"+(templateui.getCols()!=null?templateui.getCols():"55")+"' rows='"+(templateui.getRows()!=null?templateui.getRows():"1")+"'>"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"</textarea>");

//sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinput' readonly='readonly' size=2><br>");

if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {
sb.append("<textarea name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"'  style=\"width:100%\" rows='4'>"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"</textarea>");
}

sb.append(""+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"");

/// update - delete gumbi

sb.append("</span><div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}


sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}
////////////////////////// list area
else if (nul.jeNull(templateui.getTip_inserta()).equals("tlistarea")) {

sb.append("<div  "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"touchlistarea":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table "+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?" width=100% height=100% border=0 cellspacing=0 cellpadding=0 ":"")+" "+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"":"class='"+templateui.getDdivfirsttable()+"'")+"><tr><td   noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\"  align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<iframe  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusin()).equals("")?"":templateui.getDdivclasscusin()))+"\"  "+(nul.jeNull(templateui.getDdivname()).equals("")?"":"id='"+templateui.getDdivname()+"'")+" "+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src='"+templateui.getDdivsrc()+"'")+" style=\"width:"+(nul.jeNull(templateui.getDwidth()).equals("")?"100%":templateui.getDwidth())+";height:"+(nul.jeNull(templateui.getDheight()).equals("")?"100%":templateui.getDheight())+";"+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"></iframe>");
/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}


sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}


////////////////////////// input text
else if (nul.jeNull(templateui.getTip_inserta()).equals("textbox") || nul.jeNull(templateui.getTip_inserta()).equals("password")) {

sb.append("<div  "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\"  ><tr><td  width='"+(nul.jeNull(templateui.getDinputsl()).equals("")?"50%":""+templateui.getDinputsl())+"' >");
sb.append("<span  class=\""+(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf())+"\">");
if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");
sb.append("</span></td><td width='"+(nul.jeNull(templateui.getDinputsd()).equals("")?"50%":""+templateui.getDinputsd())+"'  >\r\n");
sb.append("<input  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusin()).equals("")?"":templateui.getDdivclasscusin()))+"\"  placeholder='"+nul.jeNull(templateui.getStolpec_metoda())+"'  type='"+(nul.jeNull(templateui.getTip_inserta()).equals("password")?"password":"text")+"' "+(nul.jeNull(templateui.getStolpec_sirina()).equals("")?"":"size='"+templateui.getStolpec_sirina()+"'")+" "+(nul.jeNull(templateui.getStolpec_max_stevilo_znakov()).equals("")?"":"maxlength='"+templateui.getStolpec_max_stevilo_znakov()+"'")+" style=\"width:"+(nul.jeNull(templateui.getDwidth()).equals("")?"100%":templateui.getDwidth())+";height:"+(nul.jeNull(templateui.getDheight()).equals("")?"100%":templateui.getDheight())+";"+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"> \r\n");

sb.append("</td></tr></table>\r\n");


/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
	
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"dd.gif\" alt=\"DropDown izbira\" border=0>");
sb.append("</a>");
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}


sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}




////////////////////////// input text
else if (nul.jeNull(templateui.getTip_inserta()).equals("file") ) {

sb.append("<div "+absol+"  class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\"  ><tr><td  width='"+(nul.jeNull(templateui.getDinputsl()).equals("")?"50%":""+templateui.getDinputsl())+"' >");
sb.append("<span  class=\""+(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf())+"\">");
if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");
sb.append("</span></td><td width='"+(nul.jeNull(templateui.getDinputsd()).equals("")?"50%":""+templateui.getDinputsd())+"'  >\r\n");
sb.append("<input  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusin()).equals("")?"":templateui.getDdivclasscusin()))+"\"  placeholder='"+nul.jeNull(templateui.getStolpec_metoda())+"'  type='file' "+(nul.jeNull(templateui.getStolpec_sirina()).equals("")?"":"size='"+templateui.getStolpec_sirina()+"'")+" "+(nul.jeNull(templateui.getStolpec_max_stevilo_znakov()).equals("")?"":"maxlength='"+templateui.getStolpec_max_stevilo_znakov()+"'")+" style=\"width:"+(nul.jeNull(templateui.getDwidth()).equals("")?"100%":templateui.getDwidth())+";height:"+(nul.jeNull(templateui.getDheight()).equals("")?"100%":templateui.getDheight())+";"+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"> \r\n");

sb.append("</td></tr></table>\r\n");


/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {



sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}


sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}



////////////////////////// input checkbox
else if (nul.jeNull(templateui.getTip_inserta()).equals("checkbox")) {

sb.append("<div "+absol+"  class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\" ><tr><td width='"+(nul.jeNull(templateui.getDinputsl()).equals("")?"50%":""+templateui.getDinputsl())+"' >");
sb.append("<span  class=\""+(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf())+"\">");
if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");
sb.append("</span></td><td width='"+(nul.jeNull(templateui.getDinputsd()).equals("")?"50%":""+templateui.getDinputsd())+"'  >\r\n");
sb.append("<input  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusin()).equals("")?"":templateui.getDdivclasscusin()))+"\"  type='checkbox'  style=\"width:"+(nul.jeNull(templateui.getDwidth()).equals("")?"100%":templateui.getDwidth())+";height:"+(nul.jeNull(templateui.getDheight()).equals("")?"100%":templateui.getDheight())+";"+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"> \r\n");
sb.append(""+nul.jeNull(templateui.getStolpec_metoda())+"");
sb.append("</td></tr></table>\r\n");


/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}

}

sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}




////////////////////////// input hidden ali navaden view
else if (nul.jeNull(templateui.getTip_inserta()).equals("hidden") || nul.jeNull(templateui.getTip_inserta()).equals("view") ) {

sb.append("<div "+absol+"  class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0  ><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

/// view with description
if (!nul.jeNull(templateui.getTip_inserta_p()).equals("1")) {

sb.append("<table class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\" ><tr><td align='center' valign='middle'><tr><td  width='"+(nul.jeNull(templateui.getDinputsl()).equals("")?"50%":""+templateui.getDinputsl())+"' >");
sb.append("<span  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf()))+"\">");
if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");
sb.append("</span></td><td width='"+(nul.jeNull(templateui.getDinputsd()).equals("")?"50%":""+templateui.getDinputsd())+"'  >\r\n");

if (nul.jeNull(templateui.getTip_inserta()).equals("hidden") ) {
sb.append("<font color=red>"+nul.jeNull(templateui.getStolpec_metoda())+"</font>");
}
else {
sb.append(""+nul.jeNull(templateui.getStolpec_metoda())+"");
}
sb.append("</td></tr></table>\r\n");

}
else {

/// view without description


sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\" ><tr>");

sb.append("<td  width='"+(nul.jeNull(templateui.getDinputsd()).equals("")?"100%":""+templateui.getDinputsd())+"'  >\r\n");

sb.append("<span  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf()))+"\">");
if (nul.jeNull(templateui.getTip_inserta()).equals("hidden") ) {
sb.append("<font color=red>"+nul.jeNull(templateui.getStolpec_metoda())+"</font>");
}
else {
sb.append(""+nul.jeNull(templateui.getStolpec_metoda())+"");
}

sb.append("</span></td></tr></table>\r\n");
}

/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
	
	sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}
sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}






////////////////////////// input textarea
else if (nul.jeNull(templateui.getTip_inserta()).equals("textarea")) {

sb.append("<div  "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\" ><tr><td  width='"+(nul.jeNull(templateui.getDinputsl()).equals("")?"50%":""+templateui.getDinputsl())+"' >");
sb.append("<span  class=\""+(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf())+"\">");
if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");
sb.append("</span></td><td width='"+(nul.jeNull(templateui.getDinputsd()).equals("")?"50%":""+templateui.getDinputsd())+"'  >\r\n");
sb.append("<textarea  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusin()).equals("")?"":templateui.getDdivclasscusin()))+"\"  placeholder='"+nul.jeNull(templateui.getStolpec_metoda())+"'   "+(nul.jeNull(templateui.getRows()).equals("")?"":"rows='"+templateui.getRows()+"'")+" "+(nul.jeNull(templateui.getCols()).equals("")?"":"cols='"+templateui.getCols()+"'")+" style=\"width:"+(nul.jeNull(templateui.getDwidth()).equals("")?"100%":templateui.getDwidth())+";height:"+(nul.jeNull(templateui.getDheight()).equals("")?"100%":templateui.getDheight())+";"+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"></textarea> \r\n");

sb.append("</td></tr></table>\r\n");


/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&pozicija="+templateui.getPozicija()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&jelist="+nul.jeNull(request.getParameter("jelist"))+"&pozicija="+templateui.getPozicija()+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&jelist="+nul.jeNull(request.getParameter("jelist"))+"&pozicija="+templateui.getPozicija()+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}


sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}




////////////////////////// input select
else if (nul.jeNull(templateui.getTip_inserta()).equals("dropbox")) {

sb.append("<div  "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\" ><tr><td width='"+(nul.jeNull(templateui.getDinputsl()).equals("")?"50%":""+templateui.getDinputsl())+"' >");
sb.append("<span  class=\""+(nul.jeNull(templateui.getDdivclasscusf()).equals("")?"":templateui.getDdivclasscusf())+"\">");
if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");
sb.append("</span></td><td width='"+(nul.jeNull(templateui.getDinputsd()).equals("")?"50%":""+templateui.getDinputsd())+"'  >\r\n");
sb.append("<select  class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusin()).equals("")?"":templateui.getDdivclasscusin()))+"\"   style=\"width:"+(nul.jeNull(templateui.getDwidth()).equals("")?"100%":templateui.getDwidth())+";height:"+(nul.jeNull(templateui.getDheight()).equals("")?"100%":templateui.getDheight())+";"+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><option >"+nul.jeNull(templateui.getStolpec_metoda())+"</option></select> \r\n");

sb.append("</td></tr></table>\r\n");


/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");
if (nul.jeNull(templateui.getTip_inserta()).equals("dropbox")) {
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_class_framein_hint.jsp?idp="+templateui.getId()+"&predpona=LIST&glavno=1&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"db.gif\" alt=\"DropDown izbira SELECTBOX\" border=0>");
sb.append("</a>");
}




sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}


sb.append("</div>");

sb.append("</td>");

sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");


sb.append("</tr></table></div>");
}



////////////////////////// image
else if (nul.jeNull(templateui.getTip_inserta()).equals("timage")) {

sb.append("<div  "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\" ><tr><td  align='center' valign='middle'><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" >");

if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");

if (nul.jeNull(templateui.getStolpec_metoda()).equals("")) {
sb.append("<img class=\""+(!nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():"")+"\" "+(nul.jeNull(templateui.getDwidth()).equals("")?"":"width='"+templateui.getDwidth()+"'")+" "+(nul.jeNull(templateui.getDheight()).equals("")?"":"height='"+templateui.getDheight()+"'")+"  src='"+control.lokacija_splosno_slik+(nul.jeNull(templateui.getDimage()).equals("")?"noimage.jpg":templateui.getDimage())+"' style=\""+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"> \r\n");
}
else {

sb.append("Image from DB "+nul.jeNull(templateui.getStolpec_metoda())+"\r\n");
}
sb.append("</td></tr></table>\r\n");


/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}
sb.append("</div>");
sb.append("</td>");
sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");
sb.append("</tr></table></div>");
}






////////////////////////// button input
else if (nul.jeNull(templateui.getTip_inserta()).equals("buttoni")) {

sb.append("<div  "+absol+" class=\""+(nul.jeNull(templateui.getDdivclasscus()).equals("")?"ttextbox":templateui.getDdivclasscus())+"\"    style=\""+(nul.jeNull(templateui.getDdivsrc()).equals("")?"":"src="+templateui.getDdivsrc()+";")+nul.jeNull(templateui.getDstyle())+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0><tr><td  noclass=\""+(nul.jeNull(templateui.getDdivclasscustd()).equals("")?"touchbuttoninner":templateui.getDdivclasscustd())+"\" align='"+templateui.getStolpec_align()+"' valign='middle'>");

sb.append("<table  class=\""+(nul.jeNull(templateui.getDdivfirsttable()).equals("")?"tdefaulttable":templateui.getDdivfirsttable())+"\" ><tr><td class='touchbuttoninner' align='center' valign='middle'><tr><td  >");

if (nul.jeN(request.getParameter("tprevodi")).equals("da")) {

sb.append("<input type=text value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikp")+""))+"' class='touchinputtext' readonly='readonly' size=2><br>");
}

sb.append("<input type=text name='prevod_"+templateui.getId()+"_P_"+nul.jeNull(ConPool.getPrevod_admin_id(templateui.getId()+""))+"' value='"+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"' class='touchinputtext' size=2>");

sb.append("<input  class=\""+  ( !nul.jeN(templateui.getRocni_css()).equals("")?templateui.getRocni_css():(nul.jeNull(templateui.getDdivclasscusin()).equals("")?"":templateui.getDdivclasscusin()))+"\"  type=\"button\" value=\""+nul.jeNull(ConPool.getPrevod_admin(templateui.getId()+"","P",session.getAttribute("jezikv")+""))+"\" style=\""+(nul.jeNull(templateui.getDbarvag()).equals("")?"":"background-color:"+templateui.getDbarvag()+"")+"\"> \r\n");

sb.append("</td></tr></table>\r\n");


/// update - delete gumbi

sb.append("<div class='ugumbtouch'>");
if (iseditable) {
	if (nul.jeNull(templateui.getUporabi_ajax_kontrolo()).equals("1")) {

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_dd_framein.jsp?idg="+templateui.getId()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&kontrola=A&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"ak.gif\" alt=\"Ajax kontrola vkljucena v JS\" border=0>");
sb.append("</a>");
	
	
	}
sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return godown('m_templateclass_pogoj_framein.jsp?idg="+templateui.getId()+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&sifid="+request.getParameter("idt")+"&idt="+request.getParameter("idt")+"')\">");
sb.append("<img src=\"pp.gif\" alt=\"Pogoji prikaza vrednosti\" border=0>");
sb.append("</a>");

sb.append("<a href=\"Javascript:PGAPP()\" onCLick=\"return go('"+templateui.getId()+"&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&opcija=spremeni&siframm=new&idtf="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"',1)\"><img src=\"u.gif\" border=0  title=\"Spremeni podatke\"></a>");
sb.append("<a onClick=\"return vprasaj()\" href=\"m_templateui_t.jsp?akcija=DELETE&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&id="+templateui.getId()+"&idt="+request.getParameter("idt")+"&idn="+request.getParameter("idn")+"\"><img src=\"x.gif\" border=0 title=\"Brisi\"></a>");
if (nul.jeNull(templateui.getTemplateui_id()+"").equals("")  || nul.jeNull(templateui.getDnextto()).equals("1")) { /// za nextto gumb
sb.append("<a onClick=\"return godown('m_templateui_edit_t.jsp?opcija=new&pozicija="+templateui.getPozicija()+"&jelist="+nul.jeNull(request.getParameter("jelist"))+"&siframm=new&sifrant=null&idt="+request.getParameter("idt")+"&idn="+templateui.getId()+"')\" href=\"Javascript: PGAPP()\"><img title=\"Dodaj v isto polje\" border=\"0\" src=\"n.gif\" /></a>");
}
}
sb.append("</div>");
sb.append("</td>");
sb.append("<td rowspan='2' width=1><img src='tvert.png' width='1' "+(nul.jeNull(templateui.getDheight()).equals("")?"height='1'":"height='"+templateui.getDheight()+"'")+" id='tv"+templateui.getId()+"' border=0></td></tr><tr><td height=1><img height='1' id='th"+templateui.getId()+"' "+(nul.jeNull(templateui.getDwidth()).equals("")?"width=1":"width='"+templateui.getDwidth()+"'")+" src='thor.png' border=0></td>");
sb.append("</tr></table></div>");
}












}





return sb.toString();
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
com.popultrade.dao.TemplateUiDAO dao = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());

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
			
		//// setam prevod v memorji
			ConPool.setPrevod_admin(stru[1],stru[2],session.getAttribute("jezikv")+"",nul.jeNull(request.getParameter(str)),prevo.getId()+"");
			
		}
		
		
		
	}
	
	
	/// zapisem v head frame dimenzije
	
		com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
			com.popultrade.model.TemplateHead prth = daoth.getTemplateHead(new Long(request.getParameter("idt")));
		
			
	if (nul.jeNull(request.getParameter("ftopp")).equals("0px")) {
	prth.setFrameupsize("0%");
	}
	else {
	prth.setFrameupsize(request.getParameter("ftopp"));
	}
	
		if (nul.jeNull(request.getParameter("fleftt")).equals("0px")) {
	prth.setFrameleftsize("0%");
	}
	else {
	prth.setFrameleftsize(request.getParameter("fleftt"));
	}
	
	if (nul.jeNull(request.getParameter("fsredinaa")).equals("0px")) {
	prth.setFramecentersize("0%");
	}
	else {
	prth.setFramecentersize(request.getParameter("fsredinaa"));
	}
	
	if (nul.jeNull(request.getParameter("frightt")).equals("0px")) {
	prth.setFramerightsize("0%");
	}
	else {
	prth.setFramerightsize(request.getParameter("frightt"));
	}
	
	daoth.saveTemplateHead(prth);
	
	
	
}

if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateUi(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateUi",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateUi")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateUi")+"");
	}
	}






com.popultrade.model.TemplateUi sif = new com.popultrade.model.TemplateUi();
sif.setTemplatehead_id(new Long(request.getParameter("idt")));
int strec = 10;
//com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
/*

/// prevod pregleda
Hashtable prep = new Hashtable();
Hashtable preph = new Hashtable();
/// prevod vnosa
Hashtable prev = new Hashtable();
Hashtable prevh = new Hashtable();
/// prevod javascript errorja
Hashtable prejv = new Hashtable();
Hashtable prejh = new Hashtable();


/// prevod gumba shrani in reset
Hashtable presv = new Hashtable();
Hashtable presh = new Hashtable();

Hashtable prerv = new Hashtable();
Hashtable prerh = new Hashtable();
Hashtable prerx = new Hashtable();
Hashtable prervx = new Hashtable();
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

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodisHint(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prevh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikp")+"");
limo = daop.getPrevodisHint(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	preph.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}





limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","J");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","J");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}









limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","S");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	presv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","S");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	presh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}



limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","R");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prerv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","R");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prerh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","X");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prervx.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","X");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prerx.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}
*/

System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    1111");
com.popultrade.dao.TemplateFrameDAO daofw = (com.popultrade.dao.TemplateFrameDAO)contextUtil.getBeanDao("templateFrameDAO",pageContext.getServletContext());




 com.popultrade.model.TemplateFrame tmfz = daofw.getTemplateFrame(request.getParameter("idt"), "zgoraj");
 
 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    1111 0");
  com.popultrade.model.TemplateFrame tmfl = daofw.getTemplateFrame(request.getParameter("idt"), "levo");
  com.popultrade.model.TemplateFrame tmfs = daofw.getTemplateFrame(request.getParameter("idt"), "sredina");
  com.popultrade.model.TemplateFrame tmfd = daofw.getTemplateFrame(request.getParameter("idt"), "desno");
 
 
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    1111 1" );
 /// check if one of the position is inherited from another template
 
 Long idtz = null;
 Long idtl = null;
 Long idts = null;
 Long idtd = null;
 
 if (tmfz!=null && tmfz.getVeza_na_id()!=null) {
   com.popultrade.model.TemplateFrame tmt = daofw.getTemplateFrame(tmfz.getVeza_na_id());
   System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    1111 2121 "+tmt.getTemplateui_id());
  // com.popultrade.model.TemplateUi tmpu = dao.getTemplateUi(tmt.getTemplateui_id());
 	idtz = tmt.getTemplateui_id();
 }
 
 
System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    1111 2");
  if (tmfl!=null && tmfl.getVeza_na_id()!=null) {
  
   com.popultrade.model.TemplateFrame tmt = daofw.getTemplateFrame(tmfl.getVeza_na_id());
 //  com.popultrade.model.TemplateUi tmpu = dao.getTemplateUi(tmt.getTemplateui_id());
 	idtl =  tmt.getTemplateui_id();
 }
  if (tmfs!=null && tmfs.getVeza_na_id()!=null) {
   com.popultrade.model.TemplateFrame tmt = daofw.getTemplateFrame(tmfs.getVeza_na_id());
  // com.popultrade.model.TemplateUi tmpu = dao.getTemplateUi(tmt.getTemplateui_id());
 	idts =  tmt.getTemplateui_id();
 }
  if (tmfd!=null && tmfd.getVeza_na_id()!=null) {
   com.popultrade.model.TemplateFrame tmt = daofw.getTemplateFrame(tmfd.getVeza_na_id());
 //  com.popultrade.model.TemplateUi tmpu = dao.getTemplateUi(tmt.getTemplateui_id());
 	idtd =  tmt.getTemplateui_id();
 }


com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
com.popultrade.model.TemplateHead prth = daoth.getTemplateHead(new Long(request.getParameter("idt")));


String tz=((tmfz!=null && tmfz.getVisinasirina()!=null)?tmfz.getVisinasirina():(nul.jeNull(prth.getFrameupsize()).equals("")?"1":prth.getFrameupsize()));
String tl=((tmfl!=null && tmfl.getVisinasirina()!=null)?tmfl.getVisinasirina():(nul.jeNull(prth.getFrameleftsize()).equals("")?"1":prth.getFrameleftsize()));
String ts=((tmfs!=null && tmfs.getVisinasirina()!=null)?tmfs.getVisinasirina():(nul.jeNull(prth.getFramecentersize()).equals("")?"1":prth.getFramecentersize()));
String td=((tmfd!=null && tmfd.getVisinasirina()!=null)?tmfd.getVisinasirina():(nul.jeNull(prth.getFramerightsize()).equals("")?"1":prth.getFramerightsize()));


System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    2222");



List lis =null;






System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    3333");

 
%>
<html><head><title></title></head>
<style>

A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>
<style type=text/css>
@import "ccss/custom.css";
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


parent.frames[3].location = "nic.jsp";






}
</script>

  <link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="scripts/jquery.min.js"></script> <script type="text/javascript" src="scripts/jquery-migrate.min.js"></script>
    <script type="text/javascript" src="js/jqxcore.js"></script>
    <script type="text/javascript" src="js/jqxsplitter.js"></script>
<link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />

<style type="text/css" media="all">
html, body
{
	margin: 0;			/* Remove body margin/padding */
	padding: 0;
	overflow: hidden;	/* Remove scroll bars on browser window */
}
</style>

    <script type="text/javascript">
    
    
        <%
        
        if (nul.jeN(request.getParameter("jelist")).equals("")) {
         %>
        $(document).ready(function () {
            var theme = 'classic';
     
            $('#mainSplitter').jqxSplitter({ theme: theme, width: '100%', height: '100%', orientation: 'horizontal', panels: [{ size: '<%=(tz.equals("")?"20%":tz)%>' }, { size: '80%'}] });
 $('#firstNested').jqxSplitter({ theme: theme, orientation: 'vertical', panels: [{ size: '<%=(tl.equals("")?"25%":tl)%>' }, { size: '<%=(ts.equals("")?"75%":ts)%>' }] });
    $('#secondNested').jqxSplitter({ theme: theme, orientation: 'vertical', panels: [{ size: '<%=(ts.equals("")?"75%":ts)%>' }, { size: '<%=(tl.equals("")?"25%":tl)%>' }] });           
});


function pokazi() {

var tmo = document.getElementById('topp').style.height+"";
alert(tmo);
}


<%}%>

    </script>
    
    
 
    
    
    
</head>






<body class='default'>
<form name="dod" action="m_templateui_t.jsp?idt=<%=request.getParameter("idt")%>&akcija=prevod&jelist=<%=nul.jeNull(request.getParameter("jelist"))%>" method="post">
  
      <%
   
   
        if (nul.jeN(request.getParameter("jelist")).equals("")) {
         %>
    <div id="mainSplitter">
    <%
    }
   
   
   if (true) {
     %>
    
    
        <div id='topp' style="background-image:url('topb.gif');background-repeat:no-repeat;background-position: center center;position:relative;">
<table width=100% height=100% <%=(tmfz!=null && (!nul.jeNull(tmfz.getDspacing()).equals(""))?"cellspacing='"+tmfz.getDspacing()+"'":"")+" "+((tmfz!=null && !nul.jeNull(tmfz.getDpadding()).equals(""))?"cellpadding='"+tmfz.getDpadding()+"'":"")%>  style=" font-family: Verdana; font-size: 7pt"><tr><td style="vertical-align:<%=(tmfz!=null)?(nul.jeNull(tmfz.getDvalign()).equals("")?"top":tmfz.getDvalign()):"top" %>"  align="<%=(tmfz!=null)?(nul.jeNull(tmfz.getDalign()).equals("")?"left":tmfz.getDalign()):"left" %>">
 
 <%
 /// menu okence
 
 if (tmfz!=null && nul.jeNull(tmfz.getIsmenu()).equals("1")) {
 %>
 <div style="background-color:black; width:100%;height:40px"><font color=white>MENU</font></div>
 <%
 }
  %>
 
 
       
       <%
       
        
       if (tmfz!=null) {
        %>
       
       
        <table  <%=(nul.jeNull(tmfz.getDimenzija_tabele_h()).equals("")?"":"height='"+tmfz.getDimenzija_tabele_h()+"'") %>  <%=(nul.jeNull(tmfz.getDimenzija_tabele()).equals("")?"":"width='"+tmfz.getDimenzija_tabele()+"'") %>   <%=nul.jeNull(tmfz.getDstyle())%>   <%=(nul.jeNull(tmfz.getDdivclasscus()).equals("")?"":"class=\""+tmfz.getDdivclasscus()+"\"") %>  >
       <%
       }
        else if (tmfz!=null) {
       %>
          <table  <%=nul.jeNull(tmfz.getDstyle())%>   <%=(nul.jeNull(tmfz.getDdivclasscus()).equals("")?"":"class=\""+tmfz.getDdivclasscus()+"\"") %>>
    
       <%
       }
        
        %>
       
       <!--  <tr> -->
        <%
        
        int stev = 0;
        /////// logika glava
        /// get template from another template 
         Iterator it=null;
        if (idtz!=null) {
        com.popultrade.model.TemplateUi sif2 = new com.popultrade.model.TemplateUi();
		sif2.setTemplatehead_id(idtz);
		sif2.setPozicija("zgoraj");
		com.popultrade.dao.TemplateUiDAO daotz = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		List lik = daotz.getTemplateUis(sif2);
		
		it = lik.iterator();
		
		stev = lik.size();
		
        }
        else {
        sif.setPozicija("zgoraj");
        lis = dao.getTemplateUis(sif);
        it = lis.iterator();
        stev = lis.size();
        }
        
        
        
        if (tmfz!=null && tmfz.getDcolnums()!=null && !tmfz.getDcolnums().equals("") && !tmfz.getDcolnums().equals("0")) {
        	stev=Integer.parseInt(tmfz.getDcolnums());
        }
        
        
        

boolean prvi = false;

Hashtable objekti_absolute = new Hashtable(); /// dam notri objekte ki imajo pozicijo absolute in nato jih sprintam pod table


int proc = 100;
if (stev>0) {
proc = 100/stev;
}
int zapoo = 0;
String smer = "horizontal";
boolean jeprvi = true;

int stelementov=0;

int maxstelementov=1;
if (tmfz!=null) {

maxstelementov = (nul.jeNull(tmfz.getDcolnums()).equals("")?1:(Integer.parseInt(tmfz.getDcolnums())));
}





while (it.hasNext()){  // while start
	 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    4444 1");
	com.popultrade.model.TemplateUi vseb = (com.popultrade.model.TemplateUi)(it.next());
        System.out.println("POZICIJE");
        if (nul.jeNull(vseb.getPozicija()).equals("zgoraj") && vseb.getTemplateui_id()==null) {
        
        /// ce gre za pozicijo absolute ne dam v table
        
        if (nul.jeNull(vseb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vseb);
        zapoo++;
        }
        else {
        
        /// ce zavzame element vec kot en stolpec
        int colspan=1;
        String colspano="";
        if (!nul.jeNull(vseb.getDspan()).equals("")) {
        colspan=Integer.parseInt(nul.jeNull(vseb.getDspan()).trim());
        colspano = " colspan='"+colspan+"' ";
        }
        
        
     //    stelementov++;
      	if (nul.jeNull(vseb.getDnexttodir()).equals("2")) {
      //	jeprvi=false;
      	smer="horizontal";
      
      	}
      	else {
      	smer="vertical";
      	
      	}
        
        //// prvi je original
         %>
         
         
               <%
             if (jeprvi || maxstelementov==1 || maxstelementov<=stelementov) {
         if (jeprvi) {
          %>
        <tr <%= (nul.jeNull(tmfz.getDdefaultcont()).equals("")?"":"class='"+tmfz.getDdefaultcont()+"'")+"  "+nul.jeN(tmfz.getTrcontent()) %>>
        <%
        }
        else {
        stelementov=0;
           %>
        </tr><tr <%= (nul.jeNull(tmfz.getDdefaultcont()).equals("")?"":"class='"+tmfz.getDdefaultcont()+"'")+"  "+nul.jeN(tmfz.getTrcontent()) %>>
        <%
        }
        
        jeprvi=false;
        }
         %>
         
         
        <td class="<%=(nul.jeNull(vseb.getDdivclasscustd()).equals("")?"":vseb.getDdivclasscustd())%>" valign=top <%=colspano %> align='<%=(nul.jeNull(vseb.getStolpec_align()))%>' <%=(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") %>   width="<%=(nul.jeNull(vseb.getDtablewidth()).equals("")?(""+proc+"%"):vseb.getDtablewidth()+"") %>">
         <table  <%=(!nul.jeNull(vseb.getDdivcontainer()).equals("")?"class='"+vseb.getDdivcontainer()+"'":(" "+(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") +" width=100% cellspacing=0 cellpadding=0")) %> >
         
   <tr>
        
        <td  align='<%=(nul.jeNull(vseb.getStolpec_align()))%>' >
        <%=createElement(vseb,control,request,session,ConPool,(idtz!=null?false:true)) %>
        </td>
          <%
       
        if (vseb.getSo_childi()>0) {
         if (smer.equals("vertical")) {
        %>
       </tr>
        <%
        }
        
         List liu = vseb.getTemplateuis();
	 Iterator imn = liu.iterator();
	
	while (imn.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb = (com.popultrade.model.TemplateUi)(imn.next());
		
		String smer2 = smer;
		
		if (nul.jeNull(vsebb.getDnexttodir()).equals("2")) {
		smer2 = "horizontal";
		}
		else if (nul.jeNull(vsebb.getDnexttodir()).equals("1")) {
		smer2 = "vertical";
		}
		
		  if (nul.jeNull(vsebb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vsebb);
        zapoo++;
        }
        else {
		%>
		   <%
         if (smer.equals("vertical")) {
          %>
      <tr>
      <%
      } %>
      <!--   <td <%=((smer.equals("vertical") && nul.jeN(request.getParameter("jelist")).equals(""))?"style=\"padding-top:9px\"":"")%>> -->
        
           <td class="<%=(nul.jeNull(vsebb.getDdivclasscustd()).equals("")?"":vsebb.getDdivclasscustd())%>"  align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'>
       
        
     <table <%=(nul.jeNull(vsebb.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb.getDdivcontainer()+"'") %> >
     
        <tr>
        <td <%=(nul.jeN(vsebb.getDim_zgoraj()).equals("")?"":"height='"+vsebb.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'  width="<%=(nul.jeNull(vsebb.getDtablewidth()).equals("")?(""+proc+"%"):vsebb.getDtablewidth()+"") %>">
        <%=createElement(vsebb,control,request,session,ConPool,(idtz!=null?false:true)) %>
        </td>
            <%
         if (smer2.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        <%
        if (vsebb.getSo_childi()>0) {
        
           List liut = vsebb.getTemplateuis();
	 Iterator imnb = liut.iterator();
	
	while (imnb.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb2 = (com.popultrade.model.TemplateUi)(imnb.next());
        
        	String smer3 = smer2;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer3 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer3 = "vertical";
		}
         %>
          <%
         if (smer2.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb2.getDdivclasscustd()).equals("")?"":vsebb2.getDdivclasscustd())%>"  align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb2.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb2.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td  <%=(nul.jeN(vsebb2.getDim_zgoraj()).equals("")?"":"height='"+vsebb2.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'  width="<%=(nul.jeNull(vsebb2.getDtablewidth()).equals("")?(""+proc+"%"):vsebb2.getDtablewidth()+"") %>">
        <%=createElement(vsebb2,control,request,session,ConPool,((idtz!=null?false:true))) %>
        </td>
        
        
           <%
         if (smer3.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        
        
        
        
           <%
        if (vsebb2.getSo_childi()>0) {
        
           List liutt = vsebb2.getTemplateuis();
	 Iterator imnbt = liutt.iterator();
	
	while (imnbt.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb3 = (com.popultrade.model.TemplateUi)(imnbt.next());
        
        	String smer4 = smer3;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer4 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer4 = "vertical";
		}
         %>
          <%
         if (smer3.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb3.getDdivclasscustd()).equals("")?"":vsebb3.getDdivclasscustd())%>"  align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb3.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb3.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td  <%=(nul.jeN(vsebb3.getDim_zgoraj()).equals("")?"":"height='"+vsebb3.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>'  width="<%=(nul.jeNull(vsebb3.getDtablewidth()).equals("")?(""+proc+"%"):vsebb3.getDtablewidth()+"") %>">
        <%=createElement(vsebb3,control,request,session,ConPool,(idtz!=null?false:true)) %>
        </td>
           <%
         if (smer4.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        </table>
        
        </td>
        
          <%
         if (smer4.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
        
        
 
        
        </table>
        
        </td>
        
          <%
         if (smer2.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
             <%
         if (smer2.equals("horizontal")) {
          %>
        </tr>
        <%} %>
        </table>
        
        
        
        </td>
           <%
         if (smer.equals("vertical")) {
          %>
         </tr>
        <%} %>
        <%
        }
        }
        
        %>
      
        <%
        
        }


         %>
          </tr>
        </table>
         
         
        
        </td>
        
        
        
        <%
         stelementov+=colspan;
       
        
        
        }//// end else
        
        
        }
        }
         System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    5555");
        %>
         <%
       
        
       if (tmfz!=null && tmfz.getId()!=null) {
       if (!jeprvi) {
           %></tr>
           <%
           } 
        %>
         
        
        </table>
        
        <%
        }
        /// sprint absolute objektov
        
        for (int k=0;k<zapoo;k++) {
        %>
        <%=createElement((com.popultrade.model.TemplateUi)objekti_absolute.get(k+""),control,request,session,ConPool,(idtz!=null?false:true)) %>
        <%
        }
        
         %>
        
        
        
        
        
             <div  style=" left:2; margin-top:5; margin-right:5;<%=(nul.jeN(request.getParameter("jelist")).equals("")?"bottom:2":"top:2")%>; position:absolute;">
        
            <%
       
       if (daofw.obstajaTemplateFrame(request.getParameter("idt"), "zgoraj")) {
        %>
         <a onClick="return godown('m_templateui_edit_t.jsp?opcija=new&siframm=new&sifrant=null&pozicija=zgoraj&idt=<%=request.getParameter("idt")%>&jelist=<%=nul.jeNull(request.getParameter("jelist"))%>')" href="Javascript: PGAPP()">
        <img src='plust.gif' border=0></a><br>
         <%
        }
         %>
          <a onClick="return godown2('m_templateui_edit_fw.jsp?opcija=new&siframm=new&sifrant=null&pozicija=zgoraj&idt=<%=request.getParameter("idt")%>&jelist=<%=nul.jeNull(request.getParameter("jelist"))%>&vis='+(document.getElementById('topp').style.height+'').replace('%','PX'),'topp')" href="Javascript: PGAPP()">
       <img src='updatetouch.gif' border=0></a>
        </div>
        
        </td></tr></table>
        
        </div>
        
        
        <%
        } /// konec if true
         %>
        
        
        
        
        
        
        
        
        
        
        
        
           
        <%
        ////////////////////// levo
        if (nul.jeN(request.getParameter("jelist")).equals("")) {
         %>
        
<div>



        <div id="firstNested">
            <div id='leftt' style="background-image:url('leftb.gif');background-repeat:no-repeat;background-position: center center;">
            
     <table width=100% height=100% <%=(tmfl!=null && (!nul.jeNull(tmfl.getDspacing()).equals(""))?"cellspacing='"+tmfl.getDspacing()+"'":"")+" "+((tmfl!=null && !nul.jeNull(tmfl.getDpadding()).equals(""))?"cellpadding='"+tmfl.getDpadding()+"'":"")%>  style=" font-family: Verdana; font-size: 7pt"><tr><td style="vertical-align:<%=(tmfl!=null)?(nul.jeNull(tmfl.getDvalign()).equals("")?"top":tmfl.getDvalign()):"top" %>" align="<%=(tmfl!=null)?(nul.jeNull(tmfl.getDalign()).equals("")?"left":tmfl.getDalign()):"left" %>" >
        
            
            
            
            <%
            
            if (true) {
             %>
            
            
            
               
       <%
       
        
       if (tmfl!=null) {
        %>
       
       
        <table  <%=(nul.jeNull(tmfl.getDimenzija_tabele_h()).equals("")?"":"height='"+tmfl.getDimenzija_tabele_h()+"'") %>  <%=(nul.jeNull(tmfl.getDimenzija_tabele()).equals("")?"":"width='"+tmfl.getDimenzija_tabele()+"'") %> style="<%=nul.jeNull(tmfl.getDstyle())%>"  <%=(nul.jeNull(tmfl.getDdivclasscus()).equals("")?"":"class=\""+tmfl.getDdivclasscus()+"\"") %>>
       <%
       }
         else if (tmfl!=null) {
       %>
          <table   <%=nul.jeNull(tmfl.getDstyle())%>"   <%=(nul.jeNull(tmfl.getDdivclasscus()).equals("")?"":"class=\""+tmfl.getDdivclasscus()+"\"") %>>
    
       <%
       }
        
        %>
       
       <!--  <tr> -->
        <%
        
        int stev = 0;
        /////// logika glava
        /// get template from another template 
         Iterator it=null;
        if (idtl!=null) {
        com.popultrade.model.TemplateUi sif2 = new com.popultrade.model.TemplateUi();
		sif2.setTemplatehead_id(idtl);
		sif2.setPozicija("levo");
		com.popultrade.dao.TemplateUiDAO daotl = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		List lik = daotl.getTemplateUis(sif2);
		
		it = lik.iterator();
		
		stev = lik.size();
		
        }
        else {
        sif.setPozicija("levo");
        lis = dao.getTemplateUis(sif);
        it = lis.iterator();
        stev = lis.size();
        }
        
        
        if (tmfl!=null && tmfl.getDcolnums()!=null && !tmfl.getDcolnums().equals("") && !tmfl.getDcolnums().equals("0")) {
        	stev=Integer.parseInt(tmfl.getDcolnums());
        }

boolean prvi = false;

Hashtable objekti_absolute = new Hashtable(); /// dam notri objekte ki imajo pozicijo absolute in nato jih sprintam pod table


int proc = 100;
if (stev>0) {
proc = 100/stev;
}
int zapoo = 0;
String smer = "vertical";
boolean jeprvi = true;

int stelementov=0;

int maxstelementov=1;
if (tmfl!=null) {

maxstelementov = (nul.jeNull(tmfl.getDcolnums()).equals("")?1:(Integer.parseInt(tmfl.getDcolnums())));
}


while (it.hasNext()){  // while start
	 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    4444 1  MAX STV ELEMENTOV "+maxstelementov);
	com.popultrade.model.TemplateUi vseb = (com.popultrade.model.TemplateUi)(it.next());
        System.out.println("POZICIJE");
        if (nul.jeNull(vseb.getPozicija()).equals("levo") && vseb.getTemplateui_id()==null) {
        
        /// ce gre za pozicijo absolute ne dam v table
        
        if (nul.jeNull(vseb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vseb);
        zapoo++;
        }
        else {
        
        
           /// ce zavzame element vec kot en stolpec
        int colspan=1;
        String colspano="";
        if (!nul.jeNull(vseb.getDspan()).equals("")) {
        colspan=Integer.parseInt(nul.jeNull(vseb.getDspan()).trim());
        colspano = " colspan='"+colspan+"' ";
        }
        
        
        
      	if (nul.jeNull(vseb.getDnexttodir()).equals("2")) {
      //	jeprvi=false;
      	smer="horizontal";
      
      	}
      	else  {
      	smer="vertical";
      	
      	}
      
        
        //// prvi je original
         %>
         
             <%
         if (jeprvi || maxstelementov==1 || maxstelementov<=stelementov) {
         if (jeprvi) {
          %>
        <tr <%= (nul.jeNull(tmfl.getDdefaultcont()).equals("")?"":"class='"+tmfl.getDdefaultcont()+"'")+"  "+nul.jeN(tmfl.getTrcontent()) %>>
        <%
        }
        else {
        stelementov=0;
           %>
        </tr><tr <%= (nul.jeNull(tmfl.getDdefaultcont()).equals("")?"":"class='"+tmfl.getDdefaultcont()+"'")+"  "+nul.jeN(tmfl.getTrcontent()) %>>
        <%
        }
        
        jeprvi=false;
        }
         
         %>
        <td class="<%=(nul.jeNull(vseb.getDdivclasscustd()).equals("")?"":vseb.getDdivclasscustd())%>"  <%=colspano %> align='<%=(nul.jeNull(vseb.getStolpec_align()))%>' valign=top width="<%=(nul.jeNull(vseb.getDtablewidth()).equals("")?(""+proc+"%"):vseb.getDtablewidth()+"") %>">
         <table  <%=(!nul.jeNull(vseb.getDdivcontainer()).equals("")?"class='"+vseb.getDdivcontainer()+"'":(" "+(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") +" width=100% cellspacing=0 cellpadding=0")) %> >
         
       
        <tr>
        
        <td <%=(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") %>  valign=top align='<%=(nul.jeNull(vseb.getStolpec_align()))%>' >
        <%=createElement(vseb,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
      
        <%
        
        if (vseb.getSo_childi()>0) {
        
           if (smer.equals("vertical")) {
        %>
       </tr>
        <%
        }
        
        
         List liu = vseb.getTemplateuis();
	 Iterator imn = liu.iterator();
	
	while (imn.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb = (com.popultrade.model.TemplateUi)(imn.next());
		
		String smer2 = smer;
		
		if (nul.jeNull(vsebb.getDnexttodir()).equals("2")) {
		smer2 = "horizontal";
		}
		else if (nul.jeNull(vsebb.getDnexttodir()).equals("1")) {
		smer2 = "vertical";
		}
		
		  if (nul.jeNull(vsebb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vsebb);
        zapoo++;
        }
        else {
		%>
		   <%
         if (smer.equals("vertical")) {
          %>
      <tr>
      <%
      } %>
       <!--  <td <%=((smer.equals("vertical") && nul.jeN(request.getParameter("jelist")).equals(""))?"style=\"padding-top:9px\"":"")%>>
         -->
         <td class="<%=(nul.jeNull(vsebb.getDdivclasscustd()).equals("")?"":vsebb.getDdivclasscustd())%>"  align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'>
        
       
        
     <table <%=(nul.jeNull(vsebb.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td  <%=(nul.jeN(vsebb.getDim_zgoraj()).equals("")?"":"height='"+vsebb.getDim_zgoraj()+"'") %>  align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'  width="<%=(nul.jeNull(vsebb.getDtablewidth()).equals("")?(""+proc+"%"):vsebb.getDtablewidth()+"") %>">
        <%=createElement(vsebb,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
            <%
         if (smer2.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        <%
        if (vsebb.getSo_childi()>0) {
        
           List liut = vsebb.getTemplateuis();
	 Iterator imnb = liut.iterator();
	
	while (imnb.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb2 = (com.popultrade.model.TemplateUi)(imnb.next());
        
        	String smer3 = smer2;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer3 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer3 = "vertical";
		}
         %>
          <%
         if (smer2.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb2.getDdivclasscustd()).equals("")?"":vsebb2.getDdivclasscustd())%>"  valign=top align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb2.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb2.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td <%=(nul.jeN(vsebb2.getDim_zgoraj()).equals("")?"":"height='"+vsebb2.getDim_zgoraj()+"'") %>  align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'  valign=top width="<%=(nul.jeNull(vsebb2.getDtablewidth()).equals("")?(""+proc+"%"):vsebb2.getDtablewidth()+"") %>">
        <%=createElement(vsebb2,control,request,session,ConPool,((idtl!=null?false:true))) %>
        </td>
        
        
           <%
         if (smer3.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        
        
        
        
           <%
        if (vsebb2.getSo_childi()>0) {
        
           List liutt = vsebb2.getTemplateuis();
	 Iterator imnbt = liutt.iterator();
	
	while (imnbt.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb3 = (com.popultrade.model.TemplateUi)(imnbt.next());
        
        	String smer4 = smer3;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer4 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer4 = "vertical";
		}
         %>
          <%
         if (smer3.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb3.getDdivclasscustd()).equals("")?"":vsebb3.getDdivclasscustd())%>"  valign=top align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb3.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb3.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td <%=(nul.jeN(vsebb3.getDim_zgoraj()).equals("")?"":"height='"+vsebb3.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>'  valign=top width="<%=(nul.jeNull(vsebb3.getDtablewidth()).equals("")?(""+proc+"%"):vsebb3.getDtablewidth()+"") %>">
        <%=createElement(vsebb3,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
           <%
         if (smer4.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        </table>
        
        </td>
        
          <%
         if (smer4.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
        
        
 
        
        </table>
        
        </td>
        
          <%
         if (smer2.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
             <%
         if (smer2.equals("horizontal")) {
          %>
        </tr>
        <%} %>
        </table>
        
        
        
        </td>
           <%
         if (smer.equals("vertical")) {
          %>
         </tr>
        <%} %>
        <%
        }
        }
        
        %>
      
        <%
        
        }


         %>
              <%
         if (smer.equals("vertical")) {
          %>
        </tr>
        <%
        }
        %>
        </table>
         
         
        
        </td>
        
        
        
        <%
      
        stelementov+=colspan;
        
        }//// end else
        
        
        }
        }
         System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    5555");
        %>
         <%
       
        
       if (tmfl!=null && tmfl.getId()!=null) {
           if (!jeprvi) {
           %></tr>
           <%
           } 
   
        %>
        
        
        </table>
        
        <%
        }
        /// sprint absolute objektov
        
        for (int k=0;k<zapoo;k++) {
        %>
        <%=createElement((com.popultrade.model.TemplateUi)objekti_absolute.get(k+""),control,request,session,ConPool,(idtl!=null?false:true)) %>
        <%
        }
              System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    552255");
   
         %>
        
        
            
            
            
            
            
            
            
            
            <%
            } /// end if true left
             %>
            
            
         <div  style=" left:2; margin-top:5; margin-right:5;bottom:2; position:absolute;">
        
            <%
             System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    553355");
   
       if (daofw.obstajaTemplateFrame(request.getParameter("idt"), "levo")) {
        %>
         <a onClick="return godown('m_templateui_edit_t.jsp?opcija=new&siframm=new&sifrant=null&pozicija=levo&idt=<%=request.getParameter("idt")%>')" href="Javascript: PGAPP()">
        <img src='plust.gif' border=0></a><br>
         <%
        }
         %>
          <a onClick="return godown2('m_templateui_edit_fw.jsp?opcija=new&siframm=new&sifrant=null&pozicija=levo&idt=<%=request.getParameter("idt")%>&vis='+(document.getElementById('leftt').style.width+'').replace('%','PX'),'leftt')" href="Javascript: PGAPP()">
       <img src='updatetouch.gif' border=0></a>
        </div>
        
        </td>
        
        </tr>
            </table>
             
            </div>
          
 <div>     
 
 <div id="secondNested">
            <div id='sredinaa' style="background-image:url('centerb.gif');background-repeat:no-repeat;background-position: center center;">
            
            
            
           <table  width=100% height=100% <%=(tmfs!=null && (!nul.jeNull(tmfs.getDspacing()).equals(""))?"cellspacing='"+tmfs.getDspacing()+"'":"")+" "+((tmfs!=null && !nul.jeNull(tmfs.getDpadding()).equals(""))?"cellpadding='"+tmfs.getDpadding()+"'":"")%>  style=" font-family: Verdana; font-size: 7pt"><tr><td style="vertical-align:<%=(tmfs!=null)?(nul.jeNull(tmfs.getDvalign()).equals("")?"top":tmfs.getDvalign()):"top" %>" align="<%=(tmfs!=null)?(nul.jeNull(tmfs.getDalign()).equals("")?"left":tmfs.getDalign()):"left" %>" >
        
          
            
            
            
            
            
            
            
            
            
                      
            
            
            
            <%
                  System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    556655");
   
            if (true) {
             %>
            
            
            
               
       <%
       
        
       if (tmfs!=null) {
        %>
        
       
        <table <%=(nul.jeNull(tmfs.getDimenzija_tabele_h()).equals("")?"":"height='"+tmfs.getDimenzija_tabele_h()+"'") %>  <%=(nul.jeNull(tmfs.getDimenzija_tabele()).equals("")?"":"width='"+tmfs.getDimenzija_tabele()+"'") %> <%=nul.jeNull(tmfs.getDstyle())%>   <%=(nul.jeNull(tmfs.getDdivclasscus()).equals("")?"":"class=\""+tmfs.getDdivclasscus()+"\"") %>>
       <%
       }
         else if (tmfs!=null) {
       %>
          <table   <%=nul.jeNull(tmfs.getDstyle())%>    <%=(nul.jeNull(tmfs.getDdivclasscus()).equals("")?"":"class=\""+tmfs.getDdivclasscus()+"\"") %>>
    
       <%
       }
        
        %>
       
       <!--  <tr> -->
        <%
        
        int stev = 0;
        /////// logika glava
        /// get template from another template 
         Iterator it=null;
        if (idtl!=null) {
        com.popultrade.model.TemplateUi sif2 = new com.popultrade.model.TemplateUi();
		sif2.setTemplatehead_id(idtl);
		sif2.setPozicija("sredina");
		com.popultrade.dao.TemplateUiDAO daotl = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		List lik = daotl.getTemplateUis(sif2);
		
		it = lik.iterator();
		
		stev = lik.size();
		
        }
        else {
        sif.setPozicija("sredina");
        lis = dao.getTemplateUis(sif);
        it = lis.iterator();
        stev = lis.size();
        }
        
        if (tmfs!=null && tmfs.getDcolnums()!=null && !tmfs.getDcolnums().equals("") && !tmfs.getDcolnums().equals("0")) {
        	stev=Integer.parseInt(tmfs.getDcolnums());
        }
        
        
        
        
  System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    557755");
   
boolean prvi = false;

Hashtable objekti_absolute = new Hashtable(); /// dam notri objekte ki imajo pozicijo absolute in nato jih sprintam pod table


int proc = 100;
if (stev>0) {
proc = 100/stev;
}
int zapoo = 0;
String smer = "vertical";
boolean jeprvi = true;

int stelementov=0;
  System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    558855");
   
int maxstelementov=1;
if (tmfs!=null) {
maxstelementov = (nul.jeNull(tmfs.getDcolnums()).equals("")?1:(Integer.parseInt(tmfs.getDcolnums())));
}
  System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    559955");
   
if (maxstelementov==1) {
%>
<tr>
<%

}



while (it.hasNext()){  // while start
	 System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  yy  4444 1");
	com.popultrade.model.TemplateUi vseb = (com.popultrade.model.TemplateUi)(it.next());
        System.out.println("POZICIJE");
        if (nul.jeNull(vseb.getPozicija()).equals("sredina") && vseb.getTemplateui_id()==null) {
        
        /// ce gre za pozicijo absolute ne dam v table
        
        if (nul.jeNull(vseb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vseb);
        zapoo++;
        }
        else {
        
      //  stelementov++;
           /// ce zavzame element vec kot en stolpec
        int colspan=1;
        String colspano="";
        if (!nul.jeNull(vseb.getDspan()).equals("")) {
        colspan=Integer.parseInt(nul.jeNull(vseb.getDspan()).trim());
        colspano = " colspan='"+colspan+"' ";
        }
        
        
      	if (nul.jeNull(vseb.getDnexttodir()).equals("2")) {
      //	jeprvi=false;
      	smer="horizontal";
      
      	}
      	else  {
      	smer="vertical";
      	
      	}
      
        
        //// prvi je original
         %>
         
             <%
         if (jeprvi || maxstelementov==1 || maxstelementov<=stelementov) {
         if (jeprvi) {
          %>
        <tr <%= (nul.jeNull(tmfs.getDdefaultcont()).equals("")?"":"class='"+tmfs.getDdefaultcont()+"'")+"  "+nul.jeN(tmfs.getTrcontent()) %>>
        <%
        }
        else {
        stelementov=0;
           %>
        </tr><tr <%= (nul.jeNull(tmfs.getDdefaultcont()).equals("")?"":"class='"+tmfs.getDdefaultcont()+"'")+"  "+nul.jeN(tmfs.getTrcontent()) %>>
        <%
        }
        
        jeprvi=false;
        }
         
         %>
        <td  class="<%=(nul.jeNull(vseb.getDdivclasscustd()).equals("")?"":vseb.getDdivclasscustd())%>" valign=top <%=colspano %> align='<%=(nul.jeNull(vseb.getStolpec_align()))%>' width="<%=(nul.jeNull(vseb.getDtablewidth()).equals("")?(""+proc+"%"):vseb.getDtablewidth()+"") %>">
         <table  <%=(!nul.jeNull(vseb.getDdivcontainer()).equals("")?"class='"+vseb.getDdivcontainer()+"'":(" "+(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") +" width=100% cellspacing=0 cellpadding=0")) %> >
         
       
        <tr>
        
        <td <%=(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vseb.getStolpec_align()))%>'   valign=top>
        <%=createElement(vseb,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
      
        <%
        
        if (vseb.getSo_childi()>0) {
        
            if (smer.equals("vertical")) {
        %>
       </tr>
        <%
        }
        
        
         List liu = vseb.getTemplateuis();
	 Iterator imn = liu.iterator();
	
	while (imn.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb = (com.popultrade.model.TemplateUi)(imn.next());
		
		String smer2 = smer;
		
		if (nul.jeNull(vsebb.getDnexttodir()).equals("2")) {
		smer2 = "horizontal";
		}
		else if (nul.jeNull(vsebb.getDnexttodir()).equals("1")) {
		smer2 = "vertical";
		}
		
		  if (nul.jeNull(vsebb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vsebb);
        zapoo++;
        }
        else {
		%>
		   <%
         if (smer.equals("vertical")) {
          %>
      <tr>
      <%
      } %>
    <!--     <td <%=((smer.equals("vertical") && nul.jeN(request.getParameter("jelist")).equals(""))?"style=\"padding-top:9px\"":"")%>>
         -->
          <td class="<%=(nul.jeNull(vsebb.getDdivclasscustd()).equals("")?"":vsebb.getDdivclasscustd())%>"  align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'>
        
        
        
     <table <%=(nul.jeNull(vsebb.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td  <%=(nul.jeN(vsebb.getDim_zgoraj()).equals("")?"":"height='"+vsebb.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'  width="<%=(nul.jeNull(vsebb.getDtablewidth()).equals("")?(""+proc+"%"):vsebb.getDtablewidth()+"") %>">
        <%=createElement(vsebb,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
            <%
         if (smer2.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        <%
        if (vsebb.getSo_childi()>0) {
        
           List liut = vsebb.getTemplateuis();
	 Iterator imnb = liut.iterator();
	
	while (imnb.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb2 = (com.popultrade.model.TemplateUi)(imnb.next());
        
        	String smer3 = smer2;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer3 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer3 = "vertical";
		}
         %>
          <%
         if (smer2.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb2.getDdivclasscustd()).equals("")?"":vsebb2.getDdivclasscustd())%>"  valign=top align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb2.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb2.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td <%=(nul.jeN(vsebb2.getDim_zgoraj()).equals("")?"":"height='"+vsebb2.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'  valign=top width="<%=(nul.jeNull(vsebb2.getDtablewidth()).equals("")?(""+proc+"%"):vsebb2.getDtablewidth()+"") %>">
        <%=createElement(vsebb2,control,request,session,ConPool,((idtl!=null?false:true))) %>
        </td>
        
        
           <%
         if (smer3.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        
        
        
        
           <%
        if (vsebb2.getSo_childi()>0) {
        
           List liutt = vsebb2.getTemplateuis();
	 Iterator imnbt = liutt.iterator();
	
	while (imnbt.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb3 = (com.popultrade.model.TemplateUi)(imnbt.next());
        
        	String smer4 = smer3;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer4 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer4 = "vertical";
		}
         %>
          <%
         if (smer3.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb3.getDdivclasscustd()).equals("")?"":vsebb3.getDdivclasscustd())%>"  valign=top align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb3.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb3.getDdivcontainer()+"'") %> >
     
        <tr>
        <td  <%=(nul.jeN(vsebb3.getDim_zgoraj()).equals("")?"":"height='"+vsebb3.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>' valign=top width="<%=(nul.jeNull(vsebb3.getDtablewidth()).equals("")?(""+proc+"%"):vsebb3.getDtablewidth()+"") %>">
        <%=createElement(vsebb3,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
           <%
         if (smer4.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        </table>
        
        </td>
        
          <%
         if (smer4.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
        
        
 
        
        </table>
        
        </td>
        
          <%
         if (smer2.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
             <%
         if (smer2.equals("horizontal")) {
          %>
        </tr>
        <%} %>
        </table>
        
        
        
        </td>
           <%
         if (smer.equals("vertical")) {
          %>
         </tr>
        <%} %>
        <%
        }
        }
        
        %>
      
        <%
        
        }


         %>
              <%
         if (smer.equals("vertical")) {
         
        
          %>
        
        <%
        }
        %>
        </table>
         
         
        
        </td>
        
        
        
        <%
       stelementov+=colspan;
        
        
        }//// end else
        
        
        }
        }
         System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    5555");
        %>
         <%
       
        
       if (tmfs!=null && tmfs.getId()!=null) {
             if (!jeprvi) {
           %></tr>
           <%
           } 
 
       
        %>
        
        
        </table>
        
        <%
        }
        /// sprint absolute objektov
        
        for (int k=0;k<zapoo;k++) {
        %>
        <%=createElement((com.popultrade.model.TemplateUi)objekti_absolute.get(k+""),control,request,session,ConPool,(idtl!=null?false:true)) %>
        <%
        }
        
         %>
        
        
            
            
            
            
            
            
            
            
            <%
            } /// end if true sredina
             %>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
       <div  style=" left:2; margin-top:5; margin-right:5;bottom:2; position:absolute;">
        
            <%
       
       if (daofw.obstajaTemplateFrame(request.getParameter("idt"), "sredina")) {
        %>
         <a onClick="return godown('m_templateui_edit_t.jsp?opcija=new&siframm=new&sifrant=null&pozicija=sredina&idt=<%=request.getParameter("idt")%>')" href="Javascript: PGAPP()">
        <img src='plust.gif' border=0></a><br>
         <%
        }
         %>
          <a onClick="return godown2('m_templateui_edit_fw.jsp?opcija=new&siframm=new&sifrant=null&pozicija=sredina&idt=<%=request.getParameter("idt")%>&vis='+(document.getElementById('sredinaa').style.width+'').replace('%','PX'),'sredinaa')" href="Javascript: PGAPP()">
       <img src='updatetouch.gif' border=0></a>
        </div>    
       
       </td></tr></table>
            </div>
            
<div id='rightt' style="background-image:url('rightb.gif');background-repeat:no-repeat;background-position: center center;">

       
        
        
         <table  width=100% height=100% <%=(tmfd!=null && (!nul.jeNull(tmfd.getDspacing()).equals(""))?"cellspacing='"+tmfd.getDspacing()+"'":"")+" "+((tmfd!=null && !nul.jeNull(tmfd.getDpadding()).equals(""))?"cellpadding='"+tmfd.getDpadding()+"'":"")%>  style=" font-family: Verdana; font-size: 7pt"><tr><td style="vertical-align:<%=(tmfd!=null)?(nul.jeNull(tmfd.getDvalign()).equals("")?"top":tmfd.getDvalign()):"top" %>" align="<%=(tmfd!=null)?(nul.jeNull(tmfd.getDalign()).equals("")?"left":tmfd.getDalign()):"left" %>">
        
            
            
            <%
             System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  yyxx  4444 1");
            if (true) {
             %>
            
            
            
               
       <%
       
        
       if (tmfd!=null && tmfd.getId()!=null) {
        %>
       
       
        <table  <%=(nul.jeNull(tmfd.getDimenzija_tabele_h()).equals("")?"":"height='"+tmfd.getDimenzija_tabele_h()+"'") %>  <%=(nul.jeNull(tmfd.getDimenzija_tabele()).equals("")?"":"width='"+tmfd.getDimenzija_tabele()+"'") %> <%=nul.jeNull(tmfd.getDstyle())%>   <%=(nul.jeNull(tmfd.getDdivclasscus()).equals("")?"":"class=\""+tmfd.getDdivclasscus()+"\"") %>>
       <%
       }
       else if (tmfd!=null) {
       %>
          <table  <%=nul.jeNull(tmfd.getDstyle())%>   <%=(nul.jeNull(tmfd.getDdivclasscus()).equals("")?"":"class=\""+tmfd.getDdivclasscus()+"\"") %>>
    
       <%
       }
        
        %>
       
       <!--  <tr> -->
        <%
              System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  yyxx  4444 2");
       
        int stev = 0;
        /////// logika glava
        /// get template from another template 
         Iterator it=null;
        if (idtl!=null) {
        com.popultrade.model.TemplateUi sif2 = new com.popultrade.model.TemplateUi();
		sif2.setTemplatehead_id(idtl);
		sif2.setPozicija("desno");
		com.popultrade.dao.TemplateUiDAO daotl = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		List lik = daotl.getTemplateUis(sif2);
		
		it = lik.iterator();
		
		stev = lik.size();
		
        }
        else {
        sif.setPozicija("desno");
        lis = dao.getTemplateUis(sif);
        it = lis.iterator();
        stev = lis.size();
        }
        
        
        if (tmfd!=null && tmfd.getDcolnums()!=null && !tmfd.getDcolnums().equals("") && !tmfd.getDcolnums().equals("0")) {
        	stev=Integer.parseInt(tmfd.getDcolnums());
        }
      System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  yyxx  4444 3");
       
boolean prvi = false;

Hashtable objekti_absolute = new Hashtable(); /// dam notri objekte ki imajo pozicijo absolute in nato jih sprintam pod table


int proc = 100;
if (stev>0) {
proc = 100/stev;
}
int zapoo = 0;
String smer = "vertical";
boolean jeprvi = true;

int stelementov=0;
int maxstelementov=1;
if (tmfd!=null) {
maxstelementov = (nul.jeNull(tmfd.getDcolnums()).equals("")?1:(Integer.parseInt(tmfd.getDcolnums())));
}



if (maxstelementov==1) {
%>
<tr>
<%

}
while (it.hasNext()){  // while start
	// System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    4444 1");
	com.popultrade.model.TemplateUi vseb = (com.popultrade.model.TemplateUi)(it.next());
        System.out.println("POZICIJE");
        if (nul.jeNull(vseb.getPozicija()).equals("desno") && vseb.getTemplateui_id()==null) {
        
        /// ce gre za pozicijo absolute ne dam v table
        
        if (nul.jeNull(vseb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vseb);
        zapoo++;
        }
        else {
        
           /// ce zavzame element vec kot en stolpec
        int colspan=1;
        String colspano="";
        if (!nul.jeNull(vseb.getDspan()).equals("")) {
        colspan=Integer.parseInt(nul.jeNull(vseb.getDspan()).trim());
        colspano = " colspan='"+colspan+"' ";
        }
        
        
      //  stelementov++;
        
      	if (nul.jeNull(vseb.getDnexttodir()).equals("2")) {
      //	jeprvi=false;
      	smer="horizontal";
      
      	}
      	else  {
      	smer="vertical";
      	
      	}
      
        
        //// prvi je original
         %>
         
             <%
           if (jeprvi || maxstelementov==1 || maxstelementov<=stelementov) {
         if (jeprvi) {
          %>
        <tr <%= (nul.jeNull(tmfd.getDdefaultcont()).equals("")?"":"class='"+tmfd.getDdefaultcont()+"'")+"  "+nul.jeN(tmfd.getTrcontent()) %>>
        <%
        }
        else {
        stelementov=0;
           %>
        </tr><tr <%= (nul.jeNull(tmfd.getDdefaultcont()).equals("")?"":"class='"+tmfd.getDdefaultcont()+"'")+"  "+nul.jeN(tmfd.getTrcontent()) %>>
        <%
        }
        
        jeprvi=false;
        }
         
         %>
        <td class="<%=(nul.jeNull(vseb.getDdivclasscustd()).equals("")?"":vseb.getDdivclasscustd())%>"  valign=top   align='<%=(nul.jeNull(vseb.getStolpec_align()))%>' <%=colspano %> width="<%=(nul.jeNull(vseb.getDtablewidth()).equals("")?(""+proc+"%"):vseb.getDtablewidth()+"") %>">
         <table  <%=(!nul.jeNull(vseb.getDdivcontainer()).equals("")?"class='"+vseb.getDdivcontainer()+"'":(" "+(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") +" width=100% cellspacing=0 cellpadding=0")) %> >
         
       
        <tr>
        
        <td <%=(nul.jeN(vseb.getDim_zgoraj()).equals("")?"":"height='"+vseb.getDim_zgoraj()+"'") %> valign=top align='<%=(nul.jeNull(vseb.getStolpec_align()))%>' >
        <%=createElement(vseb,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
      
        <%
        
        if (vseb.getSo_childi()>0) {
          if (smer.equals("vertical")) {
        %>
       </tr>
        <%
        }
        
        
         List liu = vseb.getTemplateuis();
	 Iterator imn = liu.iterator();
	
	while (imn.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb = (com.popultrade.model.TemplateUi)(imn.next());
		
		String smer2 = smer;
		
		if (nul.jeNull(vsebb.getDnexttodir()).equals("2")) {
		smer2 = "horizontal";
		}
		else if (nul.jeNull(vsebb.getDnexttodir()).equals("1")) {
		smer2 = "vertical";
		}
		
		  if (nul.jeNull(vsebb.getDposition()).equals("absolute")) {
        
        objekti_absolute.put(zapoo+"",vsebb);
        zapoo++;
        }
        else {
		%>
		   <%
         if (smer.equals("vertical")) {
          %>
      <tr>
      <%
      } %>
     <!--    <td <%=((smer.equals("vertical") && nul.jeN(request.getParameter("jelist")).equals(""))?"style=\"padding-top:9px\"":"")%>>
         -->
             <td class="<%=(nul.jeNull(vsebb.getDdivclasscustd()).equals("")?"":vsebb.getDdivclasscustd())%>"  align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'>
    
        
     <table <%=(nul.jeNull(vsebb.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb.getDdivcontainer()+"'") %> >
     
        <tr>
        <td <%=(nul.jeN(vsebb.getDim_zgoraj()).equals("")?"":"height='"+vsebb.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb.getStolpec_align()))%>'  width="<%=(nul.jeNull(vsebb.getDtablewidth()).equals("")?(""+proc+"%"):vsebb.getDtablewidth()+"") %>">
        <%=createElement(vsebb,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
            <%
         if (smer2.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        <%
        if (vsebb.getSo_childi()>0) {
        
           List liut = vsebb.getTemplateuis();
	 Iterator imnb = liut.iterator();
	
	while (imnb.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb2 = (com.popultrade.model.TemplateUi)(imnb.next());
        
        	String smer3 = smer2;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer3 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer3 = "vertical";
		}
         %>
          <%
         if (smer2.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb2.getDdivclasscustd()).equals("")?"":vsebb2.getDdivclasscustd())%>"  valign=top align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb2.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb2.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td <%=(nul.jeN(vsebb2.getDim_zgoraj()).equals("")?"":"height='"+vsebb2.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb2.getStolpec_align()))%>'  valign=top width="<%=(nul.jeNull(vsebb2.getDtablewidth()).equals("")?(""+proc+"%"):vsebb2.getDtablewidth()+"") %>">
        <%=createElement(vsebb2,control,request,session,ConPool,((idtl!=null?false:true))) %>
        </td>
        
        
           <%
         if (smer3.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        
        
        
        
        
           <%
        if (vsebb2.getSo_childi()>0) {
        
           List liutt = vsebb2.getTemplateuis();
	 Iterator imnbt = liutt.iterator();
	
	while (imnbt.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb3 = (com.popultrade.model.TemplateUi)(imnbt.next());
        
        	String smer4 = smer3;
		
		if (nul.jeNull(vsebb2.getDnexttodir()).equals("2")) {
		smer4 = "horizontal";
		}
		else if (nul.jeNull(vsebb2.getDnexttodir()).equals("1")) {
		smer4 = "vertical";
		}
         %>
          <%
         if (smer3.equals("vertical")) {
          %>
        <tr>
        <%} %>
        
          <td class="<%=(nul.jeNull(vsebb3.getDdivclasscustd()).equals("")?"":vsebb3.getDdivclasscustd())%>"  valign=top align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>'>
              <table <%=(nul.jeNull(vsebb3.getDdivcontainer()).equals("")?" cellspacing=0 cellpadding=0 border=0 width=100% height=100%0 ":"class='"+vsebb3.getDdivcontainer()+"'") %>  >
     
        <tr>
        <td <%=(nul.jeN(vsebb3.getDim_zgoraj()).equals("")?"":"height='"+vsebb3.getDim_zgoraj()+"'") %> align='<%=(nul.jeNull(vsebb3.getStolpec_align()))%>'  valign=top width="<%=(nul.jeNull(vsebb3.getDtablewidth()).equals("")?(""+proc+"%"):vsebb3.getDtablewidth()+"") %>">
        <%=createElement(vsebb3,control,request,session,ConPool,(idtl!=null?false:true)) %>
        </td>
           <%
         if (smer4.equals("vertical")) {
          %>
          </tr>
          <%
          }
           %>
        </table>
        
        </td>
        
          <%
         if (smer4.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
        
        
 
        
        </table>
        
        </td>
        
          <%
         if (smer2.equals("vertical")) {
          %>
        </tr>
        <%} %>
        
        <%
        }
        }
        
         %>
             <%
         if (smer2.equals("horizontal")) {
          %>
        </tr>
        <%} %>
        </table>
        
        
        
        </td>
           <%
         if (smer.equals("vertical")) {
          %>
         </tr>
        <%} %>
        <%
        }
        }
        
        %>
      
        <%
        
        }


         %>
              <%
         if (smer.equals("vertical")) {
          %>
        </tr>
        <%
        }
        %>
        </table>
         
         
        
        </td>
        
        
        
        <%
       
stelementov+=colspan;
        
        
        
        
        }//// end else
        
        
        }
        }
         System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    5555");
        %>
         <%
       
        
       if (tmfd!=null && tmfd.getId()!=null) {
      if (!jeprvi) {
           %></tr>
           <%
           } 
        %>
         
        
        </table>
        
        <%
        }
        /// sprint absolute objektov
        
        for (int k=0;k<zapoo;k++) {
        %>
        <%=createElement((com.popultrade.model.TemplateUi)objekti_absolute.get(k+""),control,request,session,ConPool,(idtl!=null?false:true)) %>
        <%
        }
        
         %>
        
        
            
            
            
            
            
            
            
            
            <%
            } /// end if true desno
             %>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        <div  style=" left:2; margin-top:5; margin-right:5;bottom:2; position:absolute;">
          
        
        
        
        
            <%
       
       if (daofw.obstajaTemplateFrame(request.getParameter("idt"), "desno")) {
        %>
         <a onClick="return godown('m_templateui_edit_t.jsp?opcija=new&siframm=new&sifrant=null&pozicija=desno&idt=<%=request.getParameter("idt")%>')" href="Javascript: PGAPP()">
        <img src='plust.gif' border=0></a><br>
         <%
        }
         %>
          <a onClick="return godown2('m_templateui_edit_fw.jsp?opcija=new&siframm=new&sifrant=null&pozicija=desno&idt=<%=request.getParameter("idt")%>&vis='+(document.getElementById('rightt').style.width+'').replace('%','PX'),'rightt')" href="Javascript: PGAPP()">
       <img src='updatetouch.gif' border=0></a>
        </div>
        </td></tr>
        </table>
        
</div>
</div>
            
     </div>
        </div>
        </div>

        
            <%
        } //// end 
         %>
        
         <%
        
        if (nul.jeN(request.getParameter("jelist")).equals("")) {
         %>
          
    </div>
    
                  <%
        } //// end 
         %>
    
    
    
    
    
    
    
        <div  style=" right:2; bottom:2; margin-top:5; margin-right:5; position:absolute;">
        
        
          
       
       <a onClick="return godown('m_templateuidodatno_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>&jelist=<%=nul.jeNull(request.getParameter("jelist"))%>')" href="Javascript: PGAPP()"><img src='dddt.gif' border=0></a><br>
       <a href="m_templateui_t.jsp?idt=<%=request.getParameter("idt")%>&tprevodi=da&jelist=<%=nul.jeNull(request.getParameter("jelist"))%>"><img src='tprevodi.gif' border=0></a><br>
       
       <a onClick="return ssubmit()" href="Javascript: PGAPP()">
       <img src='tsave.gif' border=0></a>
        </div>
    
    
    <input type="hidden" name="ftopp" >
   <input type="hidden" name="fleftt" >
<input type="hidden" name="fsredinaa" >
<input type="hidden" name="frightt" >
    </form>
</body>
<script language=javascript>


function ssubmit() {

document.dod.ftopp.value = document.getElementById('topp').style.height;

   <%
        
        if (nul.jeN(request.getParameter("jelist")).equals("")) {
         %>

document.dod.fleftt.value = document.getElementById('leftt').style.width;
document.dod.fsredinaa.value = document.getElementById('sredinaa').style.width;
document.dod.frightt.value = document.getElementById('rightt').style.width;

<%
}
%>
document.dod.submit();
//return false;
}



function go(asd,vv){
  if (vv == 1){
    aaa = "m_templateui_edit_t.jsp?id="+asd;
    parent.frames[3].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[3].location = asd;
return false;
}
function godown2(asd,kje){
//alert(asd);
parent.frames[3].location = asd;
return false;
}
function PGAPP(){
}

</script>
</html>
 <%

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

System.out.println(request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1,request.getRequestURI().length())+"?"+ request.getQueryString());

if (request.getQueryString().indexOf("#")==-1 && request.getQueryString().indexOf("DELETE")==-1) {
	session.setAttribute("retuu",request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1,request.getRequestURI().length())+"?"+ request.getQueryString());
}


%>



