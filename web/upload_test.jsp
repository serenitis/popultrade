<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.net.URLDecoder"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);

%><!DOCTYPE html>
<html>
<head>
<title>Ajax File Upload with Progress Bar</title>
<!-- Include jQuery form & jQuery script file. -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.js" ></script>
<script src="http://malsup.github.com/jquery.form.js" ></script>
<script src="js/fileUploadScript.js" ></script>
<!-- Include css styles here -->
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>


<link rel="stylesheet" href="app.css">
<script src="jquery-1.11.1.min.js"></script>
<script src="js/jquery.form.js"></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>

<script language='javascript'>

$(document).ready(function() {
	var options = {
	        beforeSend : function() {
	                $("#progressbox").show();
	                // clear everything
	                $("#progressbar").width('0%');
	                $("#message").empty();
	                $("#percent").html("0%");
	        },
	        uploadProgress : function(event, position, total, percentComplete) {
	                $("#progressbar").width(percentComplete + '%');
	                $("#percent").html(percentComplete + '%');

	                // change message text to red after 50%
	                if (percentComplete > 50) {
	                $("#message").html("<font color='red'>File Upload is in progress</font>");
	                }
	        },
	        success : function() {
	                $("#progressbar").width('100%');
	                $("#percent").html('100%');
	        },
	        complete : function(response) {
	        $("#message").html("<font color='blue'>Your file has been uploaded!</font>");
	        },
	        error : function() {
	        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
	        }
	};
	$("#UploadForm").ajaxForm(options);
	});
</script>


<body>
<h3>Ajax File Upload with Progress Bar</h3>
 <form id="UploadForm" action="servlet/UploadServlet?idpfp=I_f25f9e87-75a2-4b01-803e-a04d910256f0" method="post" enctype="multipart/form-data">
    <input type="file" size="160" id="myfile" name="myfile"> 
     <input type="submit" value="Ajax File Upload">
       <div id="progressbox">
         <div id="progressbar"></div>
         <div id="percent">0%</div>
       </div>
 <br />
<div id="message"></div>
</form>
</body>
</html>






