<%@ page contentType="text/html; " import="org.apache.commons.lang.StringUtils,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,net.sf.beanlib.api.BeanMethodCollector,java.lang.reflect.Method"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" /><%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") )) {
%><jdsp:forward page="m_loginu.html"/><%
}%><%!


public String narediTR(com.popultrade.model.TemplateXmlapp	vseb,int zapox,String kaj,int stopnja) {
	
	StringBuffer sbu = new StringBuffer();

	if (vseb!=null) {

		
		/*com.popultrade.model.TemplateXmlelements vsebe =new com.popultrade.model.TemplateXmlelements();
		vsebe.setId_nad(vseb.getId());
		List naje = daoe.getTemplateXmlelementss(vsebe, 1, 2500, "","position_start", "asc");
		*/
		com.popultrade.model.TemplateXmlelements vsebe =new com.popultrade.model.TemplateXmlelements();
		List naje = vseb.getTemplatexmlelements();
		Iterator iom = naje.iterator();
		Hashtable elem = new Hashtable();
		Hashtable elem2 = new Hashtable();
		while (iom.hasNext()) {
			vsebe = (com.popultrade.model.TemplateXmlelements)iom.next();
			elem.put(vsebe.getPosition_start()+"", vsebe);
			elem2.put(vsebe.getPosition_start()+"", vsebe.getLegth()+"");
		}
		zapox++;
		
		if (kaj.equals("1")) {
		//sbu.append("<td colspan=\""+maxdol+4+"\"><font size=1>&nbsp;</font></td></tr>");
		
		
		//sbu.append("<tr id=\"tr1_"+vseb.getId()+"\" style=\"background-color:'#f1f0f0'\" >");
		//sbu.append("<td ><div draggable=\"true\" >&nbsp;</div></td><td ><div draggable=\"true\" >&nbsp;</div></td><td ><div draggable=\"true\" >&nbsp;</div></td>");
		
		
		/// max 4 stopnj
		int prx = 4-stopnja;
		
		if (prx>=1) {
			
			sbu.append("<td colspan='"+prx+"' style='background-color:white'>&nbsp;</td>");		
		}
		
		for (int h=1;h<=stopnja;h++) {
		sbu.append("<td >");
		
		
		sbu.append("<div draggable=\"true\" >&nbsp;</div></td>");
		
		
		sbu.append("</td>");
		}
		
		
		if (stopnja>=0) {
			sbu.append("<td style=\"width:20px\"  title=\"Drag row here to associate with this row, drag it to X to remove or drag it to C to copy.\" draggable='true'  ondrop=\"setStopnice('"+vseb.getId()+"');\" ondragover=\"allowDrop(event)\" ondragstart=\"setStopniceSource('"+vseb.getId()+"');\"  class=\"dragfont\" align=center >D</td>");
			}
			else {
				sbu.append("<td style=\"width:20px\" >&nbsp;</td>");
					
			}	
		
		int dol=0;
		/// div za oznacit od-do
		for (int i=0;i<vseb.getLength();i++) {
		
			String colo = "white";
			int oj = i+1;
			if (elem2.containsKey((oj)+"")) {
				dol=Integer.parseInt((String)elem2.get((oj)+""));
			}
			if (dol>0) {
				dol--;
				colo="ghostwhite";
			}
		
		sbu.append("<td>");
		sbu.append("<div class=\"divcrke\" style=\"background-color:"+colo+"\" onmousedown=\"startSelect(event,'"+zapox+"',"+i+")\" onmouseup=\"stopSelect("+i+",'"+zapox+"','"+vseb.getId()+"')\" id=\"I_"+zapox+"_"+i+"\"  onmouseover=\"showDistance('"+(i+1)+"',event,this)\" onmouseout=\"showDistance('',event,this)\">"+vseb.getRow().substring(i, i+1).replaceAll(" ", "&nbsp;") +"</div>");
		sbu.append("</td>");
		
		}
		
//	sbu.append("</tr>");
		}
	
	
		if (kaj.equals("2")) {
			
			
//	sbu.append("<tr id=\"tr2_"+vseb.getId()+"\">");
//	sbu.append("<td ><div draggable=\"true\" >&nbsp;</div></td><td ><div draggable=\"true\" >&nbsp;</div></td><td ><div draggable=\"true\" >&nbsp;</div></td>");
	
		
		/// max 4 stopnj
		int prx = 4-stopnja;
		
		if (prx>=1) {
			
			sbu.append("<td colspan='4' style='background-color:white' align=right><a title='Create association/connection logic with the upper row' class=\"btnblueb\" onclick=\"return goDown2('"+vseb.getId()+"')\">A</a></td>");		
		}
		else {
			sbu.append("<td colspan='4' style='background-color:white'>&nbsp;</td>");	
		}
		
	
	
	
	sbu.append("<td style=\"width:20px\"><a class=\"btnsilverb\" onclick=\"return goDown('"+vseb.getId()+"')\">U</a></td>");
		int dol=0;
		int barve=0;
		/// div z imeni in editi kot tudi dragdrop v xml ali iz xml, tukaj pride zapisano od-do iz templatexmlelements, span odvisen od dolzine
		for (int i=0;i<vseb.getLength();i++) {
	
	String dolk="";
	String ime="&nbsp;";
	String imecelo ="";
	String idelement="";
	
	
	int oj = i+1;
	boolean prvi=false;
	int start = 0;
	if (elem.containsKey((oj)+"")) {
		com.popultrade.model.TemplateXmlelements vset = (com.popultrade.model.TemplateXmlelements)elem.get(oj+"");
		dolk=" colspan='"+vset.getLegth()+"' ";
		ime=vset.getElement_name();
		imecelo=vset.getElement_name();
		dol=Integer.parseInt(vset.getLegth()+"")-1;
		start = vset.getPosition_start();
		idelement=vset.getId()+"";
		prvi=true;
	}

	if (dol==0 || prvi) {
		if (prvi) {
			if (dol==0) {
				ime = ime.substring(0,1);	
			}
			else if (ime.length()>dol+1){
			ime = ime.substring(0,dol+1);
			}
		}

sbu.append("<td "+dolk+">");
sbu.append("<div draggable=\"true\"  ondragstart=\"dragStartE('"+idelement +"','"+vseb.getId()+"')\" class=\""+(dolk.equals("")?"":"divcrkeelements"+barve) +"\" title=\""+imecelo+"\">"+ime+"</div>");
sbu.append("</td>");


if (!dolk.equals("")) {
if (barve==0) {
	barve=1;
}
else {
	barve=0;
}
	}
	}
	else {
		dol--;
	}
}
	
		//sbu.append("</tr>");
		}
		}
	
	return sbu.toString();
	
}









%><%

try {
	
	com.popultrade.dao.TemplateXmlappDAO daog = (com.popultrade.dao.TemplateXmlappDAO)contextUtil.getBeanDao("templateXmlappDAO",pageContext.getServletContext());
	
	com.popultrade.model.TemplateXmlapp vseb =new com.popultrade.model.TemplateXmlapp();
	
	
	vseb = daog.getTemplateXmlapp(new Long(request.getParameter("idg")));
	
	
	int zapox = 0; /// logika selecta za vsako vrstico
	//com.popultrade.dao.TemplateXmlelementsDAO daoe = (com.popultrade.dao.TemplateXmlelementsDAO)contextUtil.getBeanDao("templateXmlelementsDAO",pageContext.getServletContext());
	

	
	
	
	if (vseb!=null) {
		%><%=this.narediTR(vseb,zapox,request.getParameter("kaj"),Integer.parseInt(request.getParameter("stopnica")))%><%
	}
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>