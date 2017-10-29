<%@ page language="java" import="java.util.*,java.util.Date,java.sql.*,java.text.*"  contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%
request.setCharacterEncoding("utf-8");
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>HTML Editor</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0"><center>
<link href="sample.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="fckeditor.js"></script>
		
		<script language=javascript>
		function sendd() {

		 window.opener.document.dod.<%=request.getParameter("ime_polja")%>.value=document.aaa.EditorDefault.value;

 		 this.window.close();
		}
		function nicc() {
		document.dod.jprenos.value!=''?eval('document.dod.'+document.dod.jprenos.value).value=document.aaa.EditorDefault.value:''
		}
		
		</script>
		
	<form action="Javascript: sendd()" name=aaa method="post"  onsubmit="">
			<FCK:editor id="EditorDefault" basePath=""
				fullPage="false" width="800" height="700"
				imageBrowserURL="editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
				linkBrowserURL="editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
				flashBrowserURL="editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
				imageUploadURL="editor/filemanager/upload/simpleuploader?Type=Image"
				linkUploadURL="editor/filemanager/upload/simpleuploader?Type=File"
				flashUploadURL="editor/filemanager/upload/simpleuploader?Type=Flash">
				<%=request.getParameter("vrednost").replaceAll("<ginoooooooooooooooo>","</textarea>")%>
			</FCK:editor>
			</form></center>
</body>

</html>
