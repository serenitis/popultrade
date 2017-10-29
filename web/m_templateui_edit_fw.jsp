<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}
%>

<%
try {
	
	
	
	
boolean bok=false;
com.popultrade.model.TemplateFrame vseb =new com.popultrade.model.TemplateFrame();
com.popultrade.dao.TemplateFrameDAO dao = (com.popultrade.dao.TemplateFrameDAO)contextUtil.getBeanDao("templateFrameDAO",pageContext.getServletContext());


if (nul.jeNull(request.getParameter("VSE")).equals("BRISIVSE") && !nul.jeNull(request.getParameter("id")).equals("")) {

     Iterator it=null;
        com.popultrade.model.TemplateUi sif2 = new com.popultrade.model.TemplateUi();
		sif2.setTemplatehead_id(new Long(request.getParameter("idt")));
		sif2.setPozicija(request.getParameter("pozicija"));
		com.popultrade.dao.TemplateUiDAO daotz = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		List lik = daotz.getTemplateUis(sif2);
		
		for (int k=0;k<lik.size();k++) {
		
		com.popultrade.model.TemplateUi ol = (com.popultrade.model.TemplateUi)lik.get(k);
		System.out.println("REMOVAM templateui za id ::: "+ol.getId());
		daotz.removeTemplateUi(ol.getId());
		
		
		
		}
		
		/// remove frame
		
		dao.removeTemplateFrame(new Long(request.getParameter("id")));
		
		
		

}

if (request.getParameter("idt")!=null && request.getParameter("pozicija")!=null  && request.getParameter("akcija")==null) {


vseb = dao.getTemplateFrame(request.getParameter("idt"),request.getParameter("pozicija"));
if (vseb==null) {
 vseb =new com.popultrade.model.TemplateFrame();
}

}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateFrame(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplateui_id(new Long(request.getParameter("idt")));
vseb.setPozicija(request.getParameter("pozicija"));
	}

vseb = (com.popultrade.model.TemplateFrame)contextUtil.getPopulatedObject(vseb,request);
vseb.setIsmenu(nul.jeNull(request.getParameter("ismenu")).equals("1")?"1":"0");

dao.saveTemplateFrame(vseb);

}
}


//// default cssji

com.popultrade.dao.TemplateCssDefaultDAO daok = (com.popultrade.dao.TemplateCssDefaultDAO)contextUtil.getBeanDao("templateCssDefaultDAO",pageContext.getServletContext());
com.popultrade.model.TemplateCssDefault vsedd =new com.popultrade.model.TemplateCssDefault();

List il = daok.getTemplateCssDefaults(new com.popultrade.model.TemplateCssDefault());

if (il.size()>0) {
vsedd = (com.popultrade.model.TemplateCssDefault)il.get(0);

}




Hashtable ht =new Hashtable();
ht.put("ime","ime");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0" <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null && !nul.jeNull(request.getParameter("VSE")).equals("BRISIVSE")) {
%>

<form name=dod action="m_templateui_edit_fw.jsp" method="post" onSubmit="return check()">

<%
if (vseb.getId()!=null && !vseb.getId().equals("")) {
%>
<input type=hidden name="akcija" value="UPDATE">
<%
}
else {
	%>
	<input type=hidden name="akcija" value="NEW">
	<%	
}
%>

<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">
<input type=hidden name="pozicija" value="<%=nul.jeNull(request.getParameter("pozicija"))%>">
<input type=hidden name="vis" value="<%=nul.jeNull(request.getParameter("vis"))%>">
<input type=hidden name="jelist" value="<%=nul.jeNull(request.getParameter("jelist"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Naziv frame: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="ime" maxlength='100' size='70' value="<%=nul.jeNull(vseb.getIme()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Frame pozicioniranja: </td><td class="valuecell" width="30%">
             		 
					 <select name="tip" style="font-family: Verdana; font-size: 8pt" >
             		 <option value="table" <%=nul.jeNull(vseb.getTip()).equals("table")?"selected":""%>>Table</option>
					<option value="relative" <%=nul.jeNull(vseb.getTip()).equals("relative")?"selected":""%>>Relativno/Absolutno</option>
					
					
					</select>
					
					
					</td>
             		 
            		  </tr>



            		  
            		  
            		  
   <tr>
            		  
            	
            		 
             		 <td class="opiscell" width="20%">Visina oz. sirina frame <Br>(odvisno od pozicije frame):</td><td class="valuecell" width="30%">
             		 <input type="text" name="visinasirina"   maxlength='6' size="6" value="<%=nul.jeNull(request.getParameter("vis")).replaceAll("PX","%")%>" style="font-family: Verdana; font-size: 8pt">
 
				 
				 </td>
            		 
						 <td class="opiscell" width="20%">Table sirina (samo, ce je frame pozicioniranje enako Table): </td><td class="valuecell" width="30%">
            		 
<input type="text" name="dimenzija_tabele"   maxlength='6' size="6" value="<%=nul.jeNull(vseb.getDimenzija_tabele())%>" style="font-family: Verdana; font-size: 8pt">
        		  	  
            		 </td>
				
             		 
            		  </tr>        
            		  
            		  
            		  
            		  
            		  
            		    <tr>
            		  
            	
            		 
             		 <td class="opiscell" width="20%">Ima menu (samo za zgornji frame):</td><td class="valuecell" width="30%">
             		
          <input type="checkbox" name="ismenu"  value="1" <%=nul.jeNull(vseb.getIsmenu()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
           
           Menu:
             		  		 <select name="idmenu" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value="0">Default</option>
					
            		
            		<%
            		if (true) {
            		com.popultrade.dao.TemplateMenunDAO daogo = (com.popultrade.dao.TemplateMenunDAO)contextUtil.getBeanDao("templateMenunDAO",pageContext.getServletContext());
            		
            		
            		List lisg = daogo.getTemplateMenuns(new com.popultrade.model.TemplateMenun(),1,1000,"","name","desc");
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateMenun vsebg = (com.popultrade.model.TemplateMenun)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getIdmenu()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getName())%></option>
            		<%
            		
            		
            		
            		}
            		}
            		%>
            		
            		
            		</select>
 
				 
				 </td>
            		 
						 <td class="opiscell" width="20%">Table visina (samo, ce je frame pozicioniranje enako Table): </td><td class="valuecell" width="30%">
            		 
<input type="text" name="dimenzija_tabele_h"   maxlength='6' size="6" value="<%=nul.jeNull(vseb.getDimenzija_tabele_h())%>" style="font-family: Verdana; font-size: 8pt">
        		  	  
            		 </td>
				
             		 
            		  </tr>   
            		  
            		     		  
                  		  
            		    <tr>
            		  
            	
            		 
             		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
             		
        
 
				 
				 </td>
            		 
						 <td class="opiscell" width="20%">Stevilo stolpcev oz. elementov v eni vrstici: </td><td class="valuecell" width="30%">
            		 
<input type="text" name="dcolnums"   maxlength='2' size="3" value="<%=nul.jeNull(vseb.getDcolnums())%>" style="font-family: Verdana; font-size: 8pt">
        		  	  
            		 </td>
				
             		 
            		  </tr>   		  
            		  
       <%
       
       if (nul.jeNull(request.getParameter("jelist")).equals("")) {
        %>     		  
           
  <tr>
            		  
            		 <td class="opiscell" width="20%">Veza na drugi tip frame: </td><td class="valuecell" colspan=3>
            		 
            		  <select name="veza_na_id" style="font-family: Verdana; font-size: 8pt" ><option></option>
            		 		<%
					
					
					//// dobim ime model clase iz headerja
					
			
					List li = dao.getTemplateFrameVeze(request.getParameter("pozicija"));
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
					com.popultrade.model.TemplateFrame vsebo = (com.popultrade.model.TemplateFrame)itti.next();
					%>
					
					
					<option value="<%=vsebo.getId()%>" <%=((vsebo.getId()+"").equals(vseb.getVeza_na_id()+"")?"selected":"")%>><%=nul.jeNull(vsebo.getIme())%></option>
					
					
					<%
            		 
            		 }
            		 
            		 %>
            		 
            		 
      		</select>	 	 
            		 </td>
            	
             		 
            		  </tr> 		  
            		  <%
            		  }
            		   %>
          
          
          
       <tr>
            		  
            		 <td class="opiscell" width="20%">Opis: </td><td class="valuecell" colspan=3>
          
          <textarea cols=70 rows=3 id="opis" name="opis" style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getOpis()) %></textarea> 		 
          
          	 </td>
            	
             		 
            		  </tr> 
                 
          
 
 
 
 
             		  
            		  
            		  
            		  		            <tr> 
            		  
            		 <td class="opiscell" width="20%">Samo za list znotraj prve tabele td: <br>Spacing:<br>Padding:<br>Align:<br>Vertical align: </td><td class="valuecell" width="30%">
&nbsp;<br>
<input type="text" name="dspacing"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getDspacing()+"")%>" style="font-family: Verdana; font-size: 8pt"><br>
<input type="text" name="dpadding"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getDpadding()+"")%>" style="font-family: Verdana; font-size: 8pt"><br>
 	 <select name="dalign" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
            
              %>
             
            		
             		 <option value="center" <%=nul.jeNull(vseb.getDalign()).equals("center")?"selected":""%>>Center</option>
					<option value="left" <%=nul.jeNull(vseb.getDalign()).equals("left")?"selected":""%>>Left</option>
					<option value="right" <%=nul.jeNull(vseb.getDalign()).equals("right")?"selected":""%>>Right</option>
				<%
				}
				
				 %>
					
					</select>	<br>
			            		 
      		 	  	 <select name="dvalign" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
            
              %>
             
            		
             		 <option value="top" <%=nul.jeNull(vseb.getDvalign()).equals("top")?"selected":""%>>Top</option>
					<option value="middle" <%=nul.jeNull(vseb.getDvalign()).equals("middle")?"selected":""%>>Middle</option>
					<option value="bottom" <%=nul.jeNull(vseb.getDvalign()).equals("bottom")?"selected":""%>>Bottom</option>
					<option value="baseline" <%=nul.jeNull(vseb.getDvalign()).equals("baseline")?"selected":""%>>Baseline</option>
				<%
				}
				
				 %>
					
					</select>	
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Style (CSS) rocno (glavna tabela oz. container, ce gre za style napisi tudi npr style='vsebina' isto za class) : </td><td class="valuecell" width="30%">
             

<textarea cols=80 rows=1  name="dstyle"   style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDstyle()+"")%></textarea>


 
					</td>
             		 
            		  </tr> 
            		  
            		  
            		  
            		        <tr> 
            		  
            		 <td class="opiscell" width="20%">Style (css) za vse container-je ( css za container ki vsebuje vse elemente - vsak tr po table):</td><td class="valuecell" width="30%">


			                         
	 <select name="ddefaultcont" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
             ServletContext scon=pageContext.getServletContext();

			 String path = request.getRealPath("")+"/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");
             
             Enumeration itn = clase.keys();
             
             if (vseb.getDdefaultcont()==null && vseb.getId()==null) {
             
              vseb.setDdefaultcont((vsedd!=null && vsedd.getId()!=null)?vsedd.getDfwdefcontainer():"ttal");
          //   vseb.setDdefaultcont("ttal");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdefaultcont()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>		 V primeru header/footer tip template je to class tabele, ki ima vsebino header/footerja.
      		 	 					<br>
					<textarea name="trcontent" style="font-family: Verdana; font-size: 8pt" cols=70 rows=2 ><%=nul.jeNull(vseb.getTrcontent())%></textarea> Vsebina znotraj tr-ja.

	
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Style (CSS) iz custom.css  (glavni container, ki vsebuje vse osale containerje - table): </td><td class="valuecell" width="30%">
             
	 <select name="ddivclasscus" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             ServletContext scon=pageContext.getServletContext();

			 String path = request.getRealPath("")+"/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");
             
             Enumeration itn = clase.keys();
             
             if (vseb.getDdivclasscus()==null && vseb.getId()==null) {
             
              vseb.setDdivclasscus((vsedd!=null && vsedd.getId()!=null)?vsedd.getDfwcontainer():"tnic");
          //   vseb.setDdivclasscus("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivclasscus()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				
				 %>
					
					</select>
					
					
					V primeru header/footer tip template je to class diva, ki ima vsebino header/footerja.
					
					
				
					
					</td>
             		 
            		  </tr> 
 
 
 
 <%
 
 if (vseb!=null && vseb.getId()!=null ){
  %>
 
 
 
             <tr> 
            		  
            		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
          		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%" style="background-color:red">Odstrani vse elemente znotraj frame (in frame): </td><td class="valuecell" width="30%">
             
             <input type="checkbox" id="vseec"  value="1" onclick="omogoci()">
             
<input type="button" name="vsee" id="vsee" disabled value="Odstrani vse elemente" onclick="viaall()">
 
					</td>
             		 
            		  </tr> 
 
 <%
 }
  %>
 
          
          
          
            		  
            		  


<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>

function omogoci() {

if (document.dod.vseec.checked) {

document.dod.vsee.disabled=false;

}
else {
document.dod.vsee.disabled=true;
}

}

function viaall() {


  var a = window.confirm("Potrdis brisanje vsega?");
  if (a==true) {

 <%
 
 if (vseb!=null && vseb.getId()!=null ){
  %>
document.location='m_templateui_edit_fw.jsp?VSE=BRISIVSE&idt=<%=nul.jeNull(request.getParameter("idt"))%>&pozicija=<%=nul.jeNull(request.getParameter("pozicija"))%>&id=<%=vseb.getId()%>';

<%

}

%>
}

}

function custom() {


return true;
}
function mom() {


<%
if (request.getParameter("akcija")==null) {
%>



<%
}
%>
}
</script>
<%
}

else {
%>

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">PODATKI VNESENI/SPREMENJENI</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>

<script language=javascript>



parent.frames[2].document.location = "<%=session.getAttribute("retuu")%>&sid="+Math.random()+"#bottomm<%=request.getParameter("id")%>";


</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>