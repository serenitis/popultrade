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

/// dolzine spredaj , za stopnice logiko pri refresh
public Hashtable dolfront = new Hashtable();

public String narediTR(List nol,int maxdol,int zapox,int stopnja) {
	
	StringBuffer sbu = new StringBuffer();

	Iterator ite = nol.iterator();
	while (ite.hasNext()) {

		com.popultrade.model.TemplateXmlapp	vseb = (com.popultrade.model.TemplateXmlapp)ite.next();
	
		
		dolfront.put(vseb.getId()+"", stopnja+"");
		
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
		
		sbu.append("<tr><td colspan=\""+maxdol+5+"\"><font size=1>&nbsp;</font></td></tr>");
		
		
		sbu.append("<tr id=\"tr1_"+vseb.getId()+"\" style=\"background-color:'#f1f0f0'\" >");
		
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
		
	sbu.append("</tr>");
	
	sbu.append("<tr id=\"tr2_"+vseb.getId()+"\">");
	
			/// max 4 stopnj
			
			if (prx>=1) {
			
				sbu.append("<td colspan='4' style='background-color:white' align=right><a title='Create association/connection logic with the upper row' class=\"btnblueb\" onclick=\"return goDown2('"+vseb.getId()+"')\">A</a></td>");		
				}
			else {
				sbu.append("<td colspan='4' style='background-color:white'>&nbsp;</td>");	
			}
	
	
		sbu.append("<td style=\"width:20px\"><a class=\"btnsilverb\" onclick=\"return goDown('"+vseb.getId()+"')\">U</a></td>");
		
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
	
		sbu.append("</tr>");
		
		
		//// spodaj 
		if (vseb.getTemplatexmlapps()!=null && vseb.getTemplatexmlapps().size()>0) {
			
			sbu.append(this.narediTR(vseb.getTemplatexmlapps(), maxdol, zapox,stopnja-1));
			
			
		}
		
		
		

		}
	
	return sbu.toString();
	
}









%>

<%
try {
	
	
	
	
	
	
	
	
	
	
	
	
	/// spremenim id_nad
	
	if (nul.jeNull(request.getParameter("men")).equals("1")) {
		com.popultrade.dao.TemplateXmlappDAO daogg = (com.popultrade.dao.TemplateXmlappDAO)contextUtil.getBeanDao("templateXmlappDAO",pageContext.getServletContext());
		
		com.popultrade.model.TemplateXmlapp vsebb =daogg.getTemplateXmlapp(new Long(request.getParameter("idsou")));
		
		
		if (nul.jeNull(request.getParameter("nid_nad")).equals("")) {
			vsebb.setId_nad(null);
		}
		else {
		vsebb.setId_nad(new Long(request.getParameter("nid_nad")));
		}
		
		daogg.saveTemplateXmlapp(vsebb);
		
		
	}
	
	else if (nul.jeNull(request.getParameter("rem")).equals("1")) {
		com.popultrade.dao.TemplateXmlappDAO daogg = (com.popultrade.dao.TemplateXmlappDAO)contextUtil.getBeanDao("templateXmlappDAO",pageContext.getServletContext());
		
	//	com.popultrade.model.TemplateXmlapp vsebb =daogg.getTemplateXmlapp(new Long(request.getParameter("idsou")));
	try {
		daogg.removeTemplateXmlapp(new Long(request.getParameter("idsou")));
	}
	catch (Exception no) {
		
	}
		
	}
	
	
	
	com.popultrade.dao.TemplateXmlappDAO daog = (com.popultrade.dao.TemplateXmlappDAO)contextUtil.getBeanDao("templateXmlappDAO",pageContext.getServletContext());
	
	
	
	
	com.popultrade.model.TemplateXmlapp vseb =new com.popultrade.model.TemplateXmlapp();
	
	vseb.setId_conversion(new Long(request.getParameter("idg")));
	
	List naj = daog.getTemplateXmlapps(vseb, 1, 250, " id_nad is null ","zaporedje", "asc");
	
	

	
	%>
	<html>
	
	<style >

@import "sbuttoni.css";
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
    right: 3px;
    background-color:#b50000;
    padding:4px;
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
    left: 2px;
    background-color:#b50000;
    padding:4px;
    font-family:verdana;
    color:white;
    font-weight:bold;
    font-size:10px;
    text-align:center;
}
   
      div.fixed-div3 {
    position:fixed !important;
    position: absolute; /*ie6 */
    top: 3px;
    left: 20px;
    background-color:#42c92c;
    padding:4px;
    font-family:verdana;
    color:white;
    font-weight:bold;
    font-size:10px;
    text-align:center;
}
   
   
   

   div.metermm {
   background-color:white;
   width:100%;
   color:silver;
   
   }

   div.metermv {
   background-color:white;
   width:100%;
   color:silver;
   font-size:12px;
   }
   
   
   div.meterms {
   background-color:white;
   width:1px;
   color:silver;
   }
   
   
   div.metermm2 {
background-color:silver;
width:2px;
height:18px;
   }
   
    div.metermv2 {
background-color:silver;
width:2px;
height:25px;
   }  
   
   div.meterms2 {
   background-color:silver;
   width:1px;
   }
   
   
      div.divcrkeelements0 {
   
   font-family:Verdana, Courier, monospace;
   font-size:13px;
     -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    cursor:default;
    padding:1px;
    border-left-style: solid;
    border-right-style: solid;
    border-color:silver;
    border-width:1px;
overflow: hidden;
white-space: nowrap; 
background-color:'#D8DEE5';
   }
   
   
         div.divcrkeelements1 {
   
   font-family:Verdana, Courier, monospace;
   font-size:13px;
     -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    cursor:default;
    padding:1px;
    border-left-style: solid;
    border-right-style: solid;
    border-color:silver;
    border-width:1px;
overflow: hidden;
white-space: nowrap; 
background-color:'#EFF7FF';
   }
   
   
   
   
   td.dragfont {
   color:white;
   font-family:Arial;
   font-weight:bold;
   align:center;
   font-size:12px;
      -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    cursor:default;
   }
   
   
   
   
   
   
   div.divcrke {
   
   font-family:"Courier New", Courier, monospace;
   font-size:16px;
     -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    cursor:default;
    padding:1px;
   }
			   
	</style>
	<script type="text/javascript" language="JavaScript" src="datum2.js"></script>
	   <script type="text/javascript">
	   

	   
	   
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
   



function addElementdb(id_nad,zod,dolzina) {
	
	
	var namo = prompt("Please enter a name for the new element from position: "+zod+" and a length of: "+dolzina,'');
	
	
	if (namo!="" && namo!=null && name!='undefined') {
	
	xmlHttp=GetXmlHttpObject2();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	} 
	
	
	
	
	var url="m_templatexml_elements_add.jsp";
	url=url+"?id_nad="+id_nad+"&zod="+zod+"&dol="+dolzina+"&nam="+encodeURI(namo);

	url=url+"&sid="+Math.random();
	
//	alert(url);
xmlHttp.open("GET",url,false);
	xmlHttp.send(null);
	if (xmlHttp.responseText.indexOf("OKCOPY")!=-1) {

	}
	else {
	return false;
	}
	return true;
	}
	else {
		return false;
	}
}



var sourceid="";
var trsource="";


function dragStartE(sou,trs) {
	
	sourceid=sou;
	trsource=trs;
	
	
	///reset row drag
	sourcesid="";
	
}




function removeElement(event) {
	
	
	var jeokk = confirm("Please confirm the dragged element removal!");
	
	if (!jeokk) {
		
		return false;
	}
	
	
	xmlHttp=GetXmlHttpObject2();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	} 
	var url="m_templatexml_app_remove.jsp";
	url=url+"?idn="+sourceid+"";

	url=url+"&sid="+Math.random();
	//alert(url);
xmlHttp.open("GET",url,false);
	xmlHttp.send(null);
	if (xmlHttp.responseText.indexOf("REMOVE OK")!=-1) {
		
		refreshTr(trsource,1);
		refreshTr(trsource,2);
		//odpriUL(veja);
		
		return true;
	}
	else {
		alert(xmlHttp.responseText);
	return false;
	}
	
	return true;

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
    

var selectcol = [];
    
    function showDistance(distance,event,kajoo) {
    	ev = document.getElementById("positi");
    	if (distance=="") {
    	
    		ev.style.visibility="hidden";
    	//	alert(kajoo.style.background);
    		if (kajoo.style.backgroundColor!='ghostwhite') {
    		kajoo.style.backgroundColor='white';
    		}
    		else if (startanselect==1) {
    			
    		}
    		else {
    		//	kajoo.style.border='none';
        	//	kajoo.style.borderWidth='0px';
        	}
    	}
    	else {
    	var x = event.clientX;     
    	var y = event.clientY; 
    	if (kajoo.style.backgroundColor!='ghostwhite' && startanselect!=1 ) {
    	kajoo.style.backgroundColor='silver';
    	}
    	else if (startanselect==1) {
    	//	kajoo.style.border='solid';
    	//	kajoo.style.borderWidth='2px';
    	
    	if (zapod>distance) {
    	}
    	else {
    		/// oznacim
    		for (var j=zapod;j<distance;j++) {
    			evx = document.getElementById("I_"+vrstica+"_"+j);
    			evx.style.backgroundColor='aliceblue';
    			selectcol.push(j);
    		}
    	}
    	
    	
    	
    	}
    	ev.style.visibility="visible";
    	
    //	alert(event.pageX);
    	
    	
    	ev.style.left=event.pageX+10;
    	ev.style.top=event.pageY+10;
    	
    	if (dolzina==1) {
    		
    		var celo = "&nbsp;"+distance+"&nbsp;";
    		
    		if ((Number(distance)-zapod)>0) {
    			
    			celo += "<br>W: "+(Number(distance)-zapod);
    		}
    		
    	ev.innerHTML=celo;
    	
    	
    	
    	}
    	else {
    		ev.innerHTML="&nbsp;"+distance+"&nbsp;";
    	}
    	
    	}
    }
    
    
    
    var dolzina=0;
    var zapod=0;
    var startanselect = 0;
    var vrstica = 0;
    function startSelect(event,vrsticaa,zapore) {
    	if (document.getElementById("I_"+vrsticaa+"_"+zapore).style.background!='ghostwhite') {
    	zapod = zapore;
    	vrstica = vrsticaa;
    	dolzina=1;
    	startanselect = 1;
    	}
    	
    }
    
    function stopSelect(zapore2,vrsticab,id_nad) {
    	
    	var jezai = 0;
    	var dolgo = 0;
    	if (startanselect==1 && vrstica==vrsticab) {
    	if (zapod>zapore2) {
    		
    		
    	}
    	else {
    		
    		/// oznacim
    		
    		for (var j=zapod;j<=zapore2;j++) {
    			
    			evx = document.getElementById("I_"+vrstica+"_"+j);
    			dolgo++;
    			evx.style.backgroundColor='ghostwhite';
    			jezai=1;
    		}
    		
    	}
    	
    }
    	
    	if (vrstica!=vrsticab && selectcol.length>0) {
    		//alert();
    		for (var c=0;c<selectcol.length;c++) {
    			evx = document.getElementById("I_"+vrstica+"_"+selectcol[c]);
    			if (evx.style.backgroundColor=='aliceblue') {
    			evx.style.backgroundColor='white';
    			}
    		}
    		while(selectcol.length > 0) {
    			selectcol.pop();
    		}
    		
    	//	alert(selectcol.length);
    	}
    	
    	if (jezai==1) {
    		/// add element
    		if (!addElementdb(id_nad,zapod+1,dolgo)) {
    			
    			for (var j=zapod;j<=zapore2;j++) {
        			evx = document.getElementById("I_"+vrstica+"_"+j);
        			evx.style.backgroundColor='white';
        		}
    		}
    		else {
    			
    			/// refresh trja
    			
    			refreshTr(id_nad,"2");
    			
    			
    			
    		}
    	}
    	startanselect=0;
    	dolzina=0;
    }
    
    /// refresh tr-ja, ki ima spremembo, kaj: 1-tr z izbiro 2-tr imena
    
       
function refreshTr(id_nad,kaj) {
	
	xmlHttp=GetXmlHttpObject2();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	} 
	var url="m_templatexml_app_ref.jsp";
	url=url+"?idg="+id_nad+"&kaj="+kaj+"&stopnica="+stopnice[(id_nad+"")];

	url=url+"&sid="+Math.random();
	alert(url);
xmlHttp.open("GET",url,false);
	xmlHttp.send(null);
	
		document.getElementById("tr"+kaj+"_"+id_nad).innerHTML=xmlHttp.responseText;
		
		
	return true;

}
    
    var sourcesid=0;
function setStopniceSource(sourcesidd) {
	
	sourcesid=sourcesidd;
	
	/// reset element drag
	
	sourceid="";
	trsource="";
	
}
    
    function setStopnice(destinationid) {
    	
    	if (sourcesid!=destinationid) {
    	
    	document.location = "m_templatexml_app_list.jsp?men=1&nid_nad="+destinationid+"&idsou="+sourcesid+"&idc=<%=nul.jeNull(request.getParameter("idc"))%>";
    	
    	}
    	
    }
    
    
    function removeElement2(event) {
    	
    	
    	var jeokk = confirm("Please confirm the dragged row removal!");
    	
    	if (!jeokk) {
    		
    		return false;
    	}
    	
    	
	if (sourcesid!="") {
    	document.location = "m_templatexml_app_list.jsp?rem=1&idsou="+sourcesid+"&idc=<%=nul.jeNull(request.getParameter("idc"))%>";
	}
    }

    
    
    
    
    
	function copyRow() {
		
		xmlHttp=GetXmlHttpObject2();
		if (xmlHttp==null) {
		alert ("Browser does not support HTTP Request");
		return false;
		} 
		var url="m_templategen_copy.jsp";
		url=url+"?modelname=TemplateXmlapp&modelid=3210&id="+sourcesid;
		
		/*if (kaj==2) {
			url=url+"&_ttTemplateXmlapp_Lid_nad="+vejades;
		}
		else {
		url=url+"&_ttTemplateXmlapp_Lid_nad="+zarepl;
		}*/
		
	/*	if (kaj==1 || kaj==2) { /// move
			url=url+"&mmove=yes";
		}*/
		url=url+"&sid="+Math.random();
		alert(url);
	xmlHttp.open("GET",url,false);
		xmlHttp.send(null);
		if (xmlHttp.responseText.indexOf("OKCOPY")!=-1) {
			
			
		 	document.location = "m_templatexml_app_list.jsp?idc=<%=nul.jeNull(request.getParameter("idc"))%>";
			

		}
		else {
		return false;
		}
		return true;

	}
    
   </script>
	<body onmouseup="stopSelect(0,'x0')" >
	
	
		<table cellspacing=1 border=0 cellpadding=1 style="font-family:Verdana; font-size:8pt"  >
		
		<%
	Iterator ite = naj.iterator();

		int maxdol = 0;
		
		
		
		while (ite.hasNext()) {
		vseb = (com.popultrade.model.TemplateXmlapp)ite.next();
		
		if (maxdol<vseb.getLength()) {
			maxdol = vseb.getLength();
		}
		
		}
		maxdol++;
		//// meter
		
		%>
				
	
		<tr ><td colspan=4 align=center>&nbsp;</td>
		<%
		//// set numbers
		int sredin=0;
		
		for (int i=0;i<maxdol;i++) {

		if (sredin==5) {
		%>
		<td align=center valign=bottom colspan=5>
		<div class="metermm"><%=i %></div>
		</td>
		<%
		}
		else if (i!=0 && (sredin==10 || sredin==0)) {
			sredin=0;
			%>
			<td align=center valign=bottom colspan=5>
			<div class="metermv"><b><%=i %></b></div>
			</td>
			<%
		}
		else {
			
			if (i==0) {
			%>
			<td  valign=bottom colspan=3 align=left>
			<div class="meterms" ><b><%=(i==0?"0":"&nbsp;") %></b></div>
			</td>
			<%
			}
		
			
		}
		sredin+=1;

		}
		%>
		</tr>
		
		
		<tr style="height:34;background-color:'#fbfbfb'" title="Drag row here to put row in front"><td class="dragfont" align=center colspan=4 ondrop="setStopnice('');" ondragover="allowDrop(event)">D</td>
		<%
		
		 sredin=0;
		
		for (int i=0;i<maxdol;i++) {
		
		%><td align=center valign=bottom  >
		<%
		if (sredin==5) {
		%>
		<div class="metermm2" >&nbsp;</div>
		<%
		}
		else if (sredin==10 || sredin==0) {
			sredin=0;
			%>
			<div class="metermv2" >&nbsp;</div>
			<%
		}
		else {
			%>
			<div class="meterms2" >&nbsp;</div>
			<%
		}
		sredin+=1;
		%>
		</td>
		<%
		}
		%>
		</tr>
		
		
		<tr><td colspan="<%=maxdol+5%>"><font size=1>&nbsp;</font></td></tr>
		
		 
		
		<%
		 
		int zapox = 0; /// logika selecta za vsako vrstico
		
		
		
		%>
		<%=this.narediTR(naj, maxdol, zapox,4)%>
		<%
	
		
		
		
		//	com.popultrade.dao.TemplateXmlelementsDAO daoe = (com.popultrade.dao.TemplateXmlelementsDAO)contextUtil.getBeanDao("templateXmlelementsDAO",pageContext.getServletContext());
		
	
	%>
	</table>
	<div id="positi" style="background-color:'#efefef';padding:5px;border:1px;visibility:hidden;position:absolute">&nbsp;</div>
		<div id=fixm class="fixed-div"  ondrop="removeElement(event);this.style.background='b50000'" ondragover="allowDrop(event);this.style.background='red'"   ondragleave="this.style.background='b50000'"  >DRAG ELEMENT HERE<br>TO REMOVE</div>
	<div id=fixm2 class="fixed-div2"  ondrop="removeElement2(event);this.style.background='b50000'" ondragover="allowDrop(event);this.style.background='red'"   ondragleave="this.style.background='b50000'" title="Drag row here to remove"  >X</div>
	<div id=fixm3 class="fixed-div3"  ondrop="copyRow();this.style.background='42c92c'" ondragover="allowDrop(event);this.style.background='green'"   ondragleave="this.style.background='42c92c'" title="Drag row here to copy"  >C</div>
	
	</body>
	
	
	<script language="javascript">
	var stopnice = new Object(); // or just {}

	<%
	Enumeration en  = this.dolfront.keys();
	
	while (en.hasMoreElements()) {
		String next = (String)en.nextElement();
		
		%>
		stopnice['<%=next%>']='<%=this.dolfront.get(next)%>';
		
		<%
	}
	
	%>
	
	</script>
	
	
	
	
	</html>
	<%

	

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>