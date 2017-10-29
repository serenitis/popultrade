<%@ page contentType="text/html; " import="org.apache.commons.lang.StringUtils,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,net.sf.beanlib.api.BeanMethodCollector,java.lang.reflect.Method"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") )) {
%><jdsp:forward page="m_loginu.html"/><%
}
%>

<%!


public String getDownStructure(com.popultrade.webapp.ContextUtil contextUtil, ServletContext servletContext,com.popultrade.model.TemplateXml temx,boolean prvi) throws Exception {
	
	
	//com.popultrade.dao.TemplateXmlDAO daog = (com.popultrade.dao.TemplateXmlDAO)contextUtil.getBeanDao("templateXmlDAO",servletContext);
	
	//com.popultrade.model.TemplateXml vs =new com.popultrade.model.TemplateXml();
	StringBuffer ret = new StringBuffer();
	List lik = temx.getTemplatexmls();
	boolean vecje = false;
	if (lik.size()>0) {
		ret.append("<ul id='CL__"+temx.getId()+"'>");
		vecje=true;
	}
	
	Iterator it = lik.iterator();
	
	while (it.hasNext()) {
		
		com.popultrade.model.TemplateXml vs = (com.popultrade.model.TemplateXml)it.next();
		
		int stcol =3; /// stevilo spanov -1
		ret.append("<li   >");
		ret.append("<table onclick=\"showButtons('"+vs.getId() +"')\" cellspacing=1 border=0 cellpadding=0 draggable='true' ondragstart=\"setSource('"+vs.getId()+"','"+temx.getId()+"')\"><tr><td>"+((vs.getTemplatexmls().size()>0)?"<a  onclick=\"closeThis('CL__"+vs.getId()+"')\"><img src=\"minus.png\" border=0 id='XCL__"+vs.getId()+"'></a>":"")+"</td>");
		ret.append("<td style='"+((vs.getTemplatexmls().size()>0)?"padding-left:3px;":"")+"'  ><span style=\"width:100%\" id=\"ID__"+vs.getId()+"\">"+((vs.getTemplatexmls().size()>0)?""+vs.getTag_name():""+vs.getTag_name()+"")+"</span></td>");
		
		/// attributi
		if (vs.getTemplateattributes().size()>0) {
			
			List att = vs.getTemplateattributes();
			Iterator im = att.iterator();
			
			while (im.hasNext()) {
				
				com.popultrade.model.TemplateAttribute vsa = (com.popultrade.model.TemplateAttribute)im.next();
				
				ret.append("<td><span style=\"width:100%\" id=\"AT__"+vsa.getId()+"\">&nbsp;&nbsp;<i>@"+vsa.getTag_name()+"</i></span></td>");
				stcol++;
				
			}
			
		}
		
		
		//ret.append("<td style='"+((vs.getTemplatexmls().size()>0)?"padding-left:3px;":"")+"'><span style=\"width:100%\" id=\"ID__"+vs.getId()+"\">"+((vs.getTemplatexmls().size()>0)?""+vs.getTag_name():""+vs.getTag_name()+"")+"</span></td>");
		ret.append("<td ><span style=\"width:100%;display:none\" id=\"GU__"+vs.getId()+"\">&nbsp;"); 
		ret.append("<a onclick=\"return goDown('"+vs.getId()+"',1,'"+temx.getId() +"')\"   href=\"Javascript: PGAPP()\"><img src=\"u.gif\" title=\"Update tag\" border=\"0\" ></a>");
		
		
		ret.append("<a onclick=\"return goDown('"+vs.getId() +"',2,'"+temx.getId()+"')\"  href=\"Javascript: PGAPP()\"><img src=\"t.gif\" title=\"Add new tag\" border=\"0\" ></a>");
		ret.append("<a onclick=\"return goDown('"+vs.getId() +"',3,'"+temx.getId()+"')\"  href=\"Javascript: PGAPP()\"><img src=\"a.gif\" title=\"Add attribute\"  border=\"0\" ></a>");
		ret.append("</span></td>");
		
		
		
		
	/// attach
		ret.append("<td class='pado'><div id='"+vs.getId()+"' style='width:75px;height:15px' ondrop=\"dragdropx(event,'"+temx.getId()+"',1,'"+vs.getZaporedje()+"');gor1(this)\" ondragover=\"allowDrop(event);gor2(this)\" ondragleave=\"gor0(this)\"></div></td>");
			
	/// copy	
		ret.append("<td class='pado'><div id='"+vs.getId()+"' style='width:75px;height:15px' ondrop=\"dragdropx(event,'"+temx.getId()+"',0,'"+vs.getZaporedje()+"');gor1(this)\" ondragover=\"allowDrop(event);gor3(this)\" ondragleave=\"gor0(this)\"></div></td>");
		
		
		ret.append("</tr>");
		
		
		ret.append("<tr><td></td><td colspan='"+stcol+"'><div id='"+vs.getId()+"' style='width:100%;height:3px' ondrop=\"dragdropx(event,'"+temx.getId()+"',2,'"+vs.getZaporedje()+"');gor1(this)\" ondragover=\"this.style.background='red';allowDrop(event);\" ondragleave=\"gor1(this)\"></div></td></tr>");
		
		ret.append("</table>");
		
		if (vs.getTemplatexmls().size()>0) {
		//	ret+=;
			ret.append((""+getDownStructure(null,null,vs,false)+""));
			
			
		}
		else {
			
		}
		
		ret.append("</li>");
		
	}
	
	if (vecje) {
		ret.append(("</ul>"));
	}
	
	return ret.toString();
	
	
}


%>



<%
try {
	
	
	com.popultrade.dao.TemplateXmlDAO daog = (com.popultrade.dao.TemplateXmlDAO)contextUtil.getBeanDao("templateXmlDAO",pageContext.getServletContext());
	
	com.popultrade.model.TemplateXml vseb =new com.popultrade.model.TemplateXml();
	

	
	vseb = daog.getTemplateXml(new Long(request.getParameter("idg")));
	
	
	%>

	<%=getDownStructure(null,null,vseb,true) %>
	
	
	<%

	

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>