<%@ page contentType="text/html; " import="java.net.*,javax.net.ssl.HttpsURLConnection,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.util.regex.*"%>

<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />

<%
com.popultrade.model.PgnClientsSendFrom vsebx =new com.popultrade.model.PgnClientsSendFrom();
com.popultrade.dao.PgnClientsSendFromDAO daosf = (com.popultrade.dao.PgnClientsSendFromDAO)contextUtil.getBeanDao("pgnClientsSendFromDAO",pageContext.getServletContext());
com.popultrade.dao.PgnClientsReceiveFromDAO daorf = (com.popultrade.dao.PgnClientsReceiveFromDAO)contextUtil.getBeanDao("pgnClientsReceiveFromDAO",pageContext.getServletContext());

com.popultrade.dao.PgnClientsReceiveFromSrcDAO daorfs = (com.popultrade.dao.PgnClientsReceiveFromSrcDAO)contextUtil.getBeanDao("pgnClientsReceiveFromSrcDAO",pageContext.getServletContext());


vsebx.setId(new Long(request.getParameter("idcop")));
List all = daosf.getPgnClientsSendFroms(vsebx, 1, 10000,"","","");




if (all.size()>0) {
	
	for (int m=0;m<all.size();m++) {
		
		com.popultrade.model.PgnClientsSendFrom vsebc =(com.popultrade.model.PgnClientsSendFrom)all.get(m);
		
		
		/// copy to receivefrom
		com.popultrade.model.PgnClientsReceiveFrom vsebr =new com.popultrade.model.PgnClientsReceiveFrom();
		
		
		
		vsebr.setCreated(new Date());
		vsebr.setFor_client(nul.jeN(vsebc.getFor_client()).equals("1")?"0":"1");
		vsebr.setId_pgnclients(vsebc.getId_pgnclients());
		vsebr.setSender_enccode(vsebc.getReceiver_enccode());
		vsebr.setStatus("1");
		vsebr.setSender_id(vsebc.getReceiver_client());
		vsebr.setTitle("Receive from: "+vsebc.getTitle());
		
		
		daorf.savePgnClientsReceiveFrom(vsebr);
		

		
		///
		
		
	List lik=	vsebc.getPgnClientsSendFromSrc();
		
		if (lik.size()>0) {
			
			for (int b=0;b<lik.size();b++) {
			com.popultrade.model.PgnClientsSendFromSrc vssr = (com.popultrade.model.PgnClientsSendFromSrc)lik.get(b);
			
			/// copy to receivefromsrc
			com.popultrade.model.PgnClientsReceiveFromSrc vsre =new com.popultrade.model.PgnClientsReceiveFromSrc();
			
			vsre.setCreated(new Date());
			vsre.setFile_extension(vssr.getFile_extension());
			vsre.setId_pgnclientsreceivefrom(vsebr.getId());
			vsre.setId_user(vssr.getId_user());
			vsre.setMsg_class(vssr.getMsg_class());
			vsre.setMsg_type(vssr.getMsg_type());
			vsre.setSave_file_to(".");
			
			
			daorfs.savePgnClientsReceiveFromSrc(vsre);
			
			}
			
		}
		
		
		
		
		
		
	}
	
	
	
}



%>




<body>
</body>




