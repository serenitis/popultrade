<%@ page contentType="text/html; " import="org.apache.commons.lang.StringUtils,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,net.sf.beanlib.api.BeanMethodCollector,java.lang.reflect.Method"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<%

%>


<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jdsp:forward page="m_loginu.html"/><%
}
%>

<%!


public String getDownStructure(com.popultrade.webapp.ContextUtil contextUtil, ServletContext servletContext,com.popultrade.model.TemplateXml temx) throws Exception {
	
	
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
			ret.append((""+getDownStructure(null,null,vs)+""));
			
			
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
	
	vseb.setId_conversion(new Long(request.getParameter("idg")));
	
	List naj = daog.getTemplateXmls(vseb, 1, 1, "id_nad is null","", "");
	
	
	if (naj.size()==1) {
	
	vseb = (com.popultrade.model.TemplateXml)naj.get(0);
	
	}
	%>
	<html>
	
	<style >


td.pado {
padding-left:4;
align:center;

}



 ul.tree, ul.tree ul {
     list-style-type: none;
     background: url(vline.png) repeat-y;
     margin: 0;
     padding: 0;
   }
   
   ul.tree ul {
     margin-left: 10px;
   }

   ul.tree li {
     margin: 0;
     padding: 0 12px;
     line-height: 25px;
     background: url(node.png) no-repeat;
    // color: #369;
   //  font-weight: bold;
   font-family:verdana;
   font-size:17px;
   }

   ul.tree li.last {
     background: #fff url(lastnode.png) no-repeat;
   }
   
   ul.tree li:last-child {
     background: #fff url(lastnode.png) no-repeat;
   }
   
   
   div.fixed-div {
    position:fixed !important;
    position: absolute; /*ie6 */
    top: 3px;
    right: 43px;
    background-color:#b50000;
    padding:6px;
    font-family:verdana;
    color:white;
    font-weight:bold;
    font-size:10px;
    text-align:center;
}
   
      div.fixed-div2 {
    position:fixed !important;
    position: absolute; /*ie6 */
    top: 3px;
    right: 3px;
    background-color:#04579f;
    padding:6px;
    font-family:verdana;
    color:white;
    font-weight:bold;
    font-size:10px;
    text-align:center;
}
			   
	</style>
	<script type="text/javascript" language="JavaScript" src="datum2.js"></script>
	   <script type="text/javascript">
	   
   function gor0(obje) {
		   
		   obje.style.background='white';
		   obje.innerHTML='';
	   }
	   
	   function gor1(obje) {
		   
		   obje.style.background='white';
		   
	   }
	   
	   function gor2(obje) {
		   obje.style.background='green';
		   obje.innerHTML='<font size=1> ATTACH HERE </font>';  
	   }
	   
	   function gor3(obje) {
		   obje.style.background='yellow';
		   obje.innerHTML='<font size=1> COPY HERE </font>';  
	   }
	   
	   function gor4(obje) {
		   
	   }
	   
	   
	   
	   
	   function odpriUL(idul) {


		   	xmlHttp=GetXmlHttpObject();
		   	if (xmlHttp==null) {
		   	alert ("Browser does not support HTTP Request");
		   	return false;
		   	}
		   var url="m_templatexml_list_in.jsp";
		   url=url+"?idg="+idul;
		   url=url+"&sid="+Math.random();
		   xmlHttp.open("GET",url,false);
		   xmlHttp.send(null);

//alert(xmlHttp.responseText);
		   document.getElementById("CL__"+idul).innerHTML=xmlHttp.responseText;
		  
		  


		   return false;
		   }
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
    function loade() {
      var tree = document.getElementById("tree");
      var lists = [ tree ];
     
      for (var i = 0; i < tree.getElementsByTagName("ul").length; i++)
        lists[lists.length] = tree.getElementsByTagName("ul")[i];

      for (var i = 0; i < lists.length; i++) {
        var item = lists[i].lastChild;
     	 
        while (!item.tagName || item.tagName.toLowerCase() != "li")
     	  item = item.previousSibling;

        item.className += ((item.className+"").indexOf("last")==-1)?" last":"";
      }
    };
    
    function closeThis(vhat) {
    	
    	if (document.getElementById(vhat)) {
    		var dis = document.getElementById(vhat);
    		if (dis.style.display=='none') {
    			dis.style.display='block';
    			document.getElementById("X"+vhat).src="minus.png";
    		}
    		else {
    			dis.style.display='none';
    			document.getElementById("X"+vhat).src="plus.png";
    		}
    		
    	}
    	
    }
    
    
    var sourceid = "";
    var veja="";
    function dragdropx(event,vejades,kaj,zaporedje) {
    	idulja = event.target.id;
    //	alert(event.target.id + " ::: "+sourceid);
    
  //alert(idulja + ":::"+sourceid);
  
  if (idulja!=sourceid) { /// da ne kopiram istega
	  setZaporedja(idulja,sourceid,kaj,vejades,zaporedje);
  copyModelA(idulja,sourceid,kaj,vejades);
  
    	odpriUL(vejades);
    	odpriUL(veja);
  }
    }
    
function setSource(sour,jeve) {
	sourceid = sour;
	veja=jeve;
}
    
    
function setZaporedja(zarepl,idsource,kaj,vejades,zaporedje) {
	
	xmlHttp=GetXmlHttpObject2();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	} 
	var url="m_templatexml_list_zaporedja.jsp";
	url=url+"?idn="+idsource+"&idnad="+vejades+"&kaj="+kaj+"&zaporedje="+zaporedje;

	url=url+"&sid="+Math.random();
	//alert(url);
xmlHttp.open("GET",url,false);
	xmlHttp.send(null);
	if (xmlHttp.responseText.indexOf("OKCOPY")!=-1) {

	}
	else {
	//return false;
	}
	return true;

}
    
    
function removeTag(event) {
	
	
	var jeokk = confirm("Please confirm the tag removal!");
	
	if (!jeokk) {
		
		return false;
	}
	
	
	xmlHttp=GetXmlHttpObject2();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	} 
	var url="m_templatexml_list_remove.jsp";
	url=url+"?idn="+sourceid+"";

	url=url+"&sid="+Math.random();
	//alert(url);
xmlHttp.open("GET",url,false);
	xmlHttp.send(null);
	if (xmlHttp.responseText.indexOf("REMOVE OK")!=-1) {
		
		
		odpriUL(veja);
		
		return true;
	}
	else {
		alert(xmlHttp.responseText);
	return false;
	}
	
	return true;

}
    
    
    
    
    
    
    
    
	function copyModelA(zarepl,idsource,kaj,vejades) {
		
		xmlHttp=GetXmlHttpObject2();
		if (xmlHttp==null) {
		alert ("Browser does not support HTTP Request");
		return false;
		} 
		var url="m_templategen_copy.jsp";
		url=url+"?modelname=TemplateXml&modelid=321&id="+idsource;
		
		if (kaj==2) {
			url=url+"&_ttTemplateXml_Lid_nad="+vejades;
		}
		else {
		url=url+"&_ttTemplateXml_Lid_nad="+zarepl;
		}
		
		if (kaj==1 || kaj==2) { /// move
			url=url+"&mmove=yes";
		}
		url=url+"&sid="+Math.random();
		//alert(url);
	xmlHttp.open("GET",url,false);
		xmlHttp.send(null);
		if (xmlHttp.responseText.indexOf("OKCOPY")!=-1) {

		}
		else {
		return false;
		}
		return true;

	}
    
    
	function showButtons(idob) {
		
		
		if (godown==1) {
	//	alert(document.getElementById('GU__'+idob).style.display);
		if (document.getElementById('GU__'+idob).style.display=='none') {
		
		
		document.getElementById('GU__'+idob).style.display='block';
		}
		else {
		document.getElementById('GU__'+idob).style.display='none';
		}
		}
		else {
			godown=1;
		}
	}
	
	
	var godown = 1;
	function goDown(idok,kam,ida) {
		
		if (kam==1) { /// update
			
			parent.frames[1].document.location = "m_templatexml_edit.jsp?opcija=spremeni&siframm=new&ida="+ida+"&id="+idok+"&idg=<%=request.getParameter("idg")%>";
			
		}
		else if (kam==2) { /// add tag
			
			parent.frames[1].document.location = "m_templatexml_edit.jsp?opcija=new&siframm=new&sifrant=null&ida="+ida+"&idg=<%=request.getParameter("idg")%>";
		}
		
	else if (kam==3) { /// add attribute
			
			parent.frames[1].document.location = "m_templatexml_att_framein.jsp?opcija=new&siframm=new&sifrant=null&ida="+ida+"&id_nad="+idok+"&idg=<%=request.getParameter("idg")%>";
		}
		
		
		//document.getElementById('GU__'+idok).style.display='block';
		godown=2;
		return false;
	}
	
	
	function PGAPP(){
	}

   </script>
	<body onload="loade()">
		<%
	StringBuffer sb = new StringBuffer();
	if (vseb!=null && vseb.getId()!=null) {
	%>
	<ul class="tree" id="tree"><li>
	
	
		<table cellspacing=1 border=0 cellpadding=0 draggable='true' onclick="showButtons('<%=vseb.getId() %>')" ondragstart="setSource('<%=vseb.getId()%>','<%=vseb.getId()%>')"><tr>
		<td><%=((vseb.getTemplatexmls().size()>0)?"<a  onclick=\"closeThis('CL__"+vseb.getId()+"')\"><img src=\"minus.png\" border=0 id='XCL__"+vseb.getId()+"'></a>":"")%></td>
		
		
		
		<td style='<%=((vseb.getTemplatexmls().size()>0)?"padding-left:3px;":"")%>'><span style="width:100%" id="ID__<%=vseb.getId()%>"><%=((vseb.getTemplatexmls().size()>0)?""+vseb.getTag_name():""+vseb.getTag_name()+"")%></span></td>
		<td ><span style="width:100%;display:none" id="GU__<%=vseb.getId()%>">&nbsp;
		<a onclick="return goDown('<%=vseb.getId() %>',1,'<%=vseb.getId() %>')"   href="Javascript: PGAPP()"><img src="u.gif" title="Update tag" border="0" ></a>
		<a onclick="return goDown('<%=vseb.getId() %>',2,'<%=vseb.getId() %>')"  href="Javascript: PGAPP()"><img src="t.gif" title="Add new tag" border="0" ></a>
		<a onclick="return goDown('<%=vseb.getId() %>',3,'<%=vseb.getId() %>')"  href="Javascript: PGAPP()"><img src="a.gif" title="Add attribute"  border="0" ></a>
		</span></td>
		
		<td style='padding-left:4' align=center><div id='<%=vseb.getId()%>' style='width:75px;height:15px' ondrop="dragdropx(event,'"+temx.getId()+"',0);this.style.background='white'" ondragover="this.style.background='yellow';allowDrop(event);this.innerHTML='<font size=1> COPY HERE </font>'" ondragleave="this.style.background='white';this.innerHTML=''"></div></td>
		</tr>
		
		
		<tr><td></td><td colspan='4'><div id='<%=vseb.getId()%>' style='width:100%;height:3px' ondrop="dragdropx(event,'<%=vseb.getId()%>',1);this.style.background='white'" ondragover="this.style.background='red';allowDrop(event);" ondragleave="this.style.background='white'"></div></td></tr>
		
		</table>
		

	
	
	
	</li>
	

	<%=getDownStructure(null,null,vseb) %>

	</ul>
	
		<%
	}
	%>
	
	<div id=fixm class="fixed-div"  title="Drag xml tag here to remove" ondrop="removeTag(event);this.style.background='b50000'" ondragover="allowDrop(event);this.style.background='red'"   ondragleave="this.style.background='b50000'"  >TAG REMOVE</div>
	<div id=fixm class="fixed-div2"  ><a href="m_templatexml.jsp?idconv=<%=request.getParameter("idg") %>" title="Upload XML" style="text-decoration:none"><font color="white">UP</font></a></div>
	
	</body>
	</html>
	<%

	

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>