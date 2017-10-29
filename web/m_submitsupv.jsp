<%@ page contentType="text/html; " import="org.apache.commons.fileupload.FileItem,java.util.*,org.apache.commons.fileupload.disk.DiskFileItemFactory,java.util.Date,org.apache.commons.fileupload.servlet.*,java.io.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />

<jsp:useBean id="generator" scope="page" class="com.popultrade.webapp.generator" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="ImageUtil" scope="request" class="com.popultrade.webapp.ImageResize" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous")) {

%><jsp:include page="login.jsp?login=0"/><%

}
else {
try {
String napaka="";
boolean jeok = false;
System.out.println("JE MULTIPART: "+ServletFileUpload.isMultipartContent(request));
if (ServletFileUpload.isMultipartContent(request)){
/*if (nul.jeNull(request.getParameter("um")).equals("Video")) {
com.popultrade.model.Users vseb =new com.popultrade.model.Users();
com.popultrade.dao.UsersDAO dao = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
vseb = dao.getUsers(control.idUporabnika);
vseb = (com.popultrade.model.Users)contextUtil.getPopulatedObject(vseb,request);
vseb.setId(control.idUporabnika);
dao.saveUsers(vseb); 
jeok=true;
}*/
try {
//ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
diskFileItemFactory.setSizeThreshold(440960); /* the unit is bytes */


/*
File repositoryPath = new File("/video");
diskFileItemFactory.setRepository(repositoryPath);*/


System.out.println("aasss "+request.getContextPath());
ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
System.out.println("aasss2");
servletFileUpload.setSizeMax(385581920); /* the unit is bytes */
System.out.println("aasss3");

  List fileItemsList = servletFileUpload.parseRequest(request);
  System.out.println(fileItemsList.size() + "  :: sie");
Iterator it = fileItemsList.iterator();
while (it.hasNext()){
System.out.println("aasss3wwww");
  FileItem fileItem = (FileItem)it.next();
  if (fileItem.isFormField()){
    /* The file item contains a simple name-value pair of a form field */
    System.out.println(fileItem.getFieldName() + " ::Field name ");
  }
  else{
    /* The file item contains an uploaded file */
    
    /// filename
    String filename=fileItem.getName();
    if (filename.indexOf("/")!=-1) {
    filename =filename.substring(filename.lastIndexOf("/")+1,filename.length());
    }
    else if (filename.indexOf("\\")!=-1) {
    filename =filename.substring(filename.lastIndexOf("\\")+1,filename.length());
    }
    
    //// kreiram dir na podlagi userja
  ServletContext context = session.getServletContext();
String realContextPath = context.getRealPath(request.getContextPath()); 



     realContextPath = realContextPath.substring(0,realContextPath.length()-nul.jeNull(request.getContextPath()).length());
    
    System.out.println(request.getContextPath()+ " realContextPath: :::"+realContextPath);
    
    /// kontrola, ce obstaja dir za userja
    
    
    
    File fim = new File(realContextPath+"/video/s"+control.okolica);
    if (!fim.exists()) {
    fim.mkdir();
    }
        File fimi = new File(realContextPath+"/video/sp"+control.okolica);
    if (!fimi.exists()) {
    fimi.mkdir();
    }
    //// pred konverzijo
    String diruserjapk=realContextPath+"/video/sp"+control.okolica+"/";
    
    String diruserja=realContextPath+"/video/s"+control.okolica+"/";
   
  
    fileItem.write(new File(diruserjapk+filename));
    
   // ImageUtil.resize(diruserja+filename,diruserja+"resized_"+filename,100,70);
    
   // ImageUtil.cropImage(diruserja+filename,50,50,50,50,"jpg",diruserja+"croped_"+filename);
    
    
    System.out.println("File name: " +fileItem.getName());
    
//// ime thumbnaila

String imn = "";
String flv="";
if (filename.indexOf(".")!=-1) {

imn = filename.substring(0,filename.lastIndexOf("."))+".jpg";
flv = filename.substring(0,filename.lastIndexOf("."))+".flv";
}




String imagename = diruserja +imn;
	
	/// konvertiram video v flv
	String outputfile = diruserja+flv;
	
	Runtime run = Runtime.getRuntime();
	boolean exception = false;
	try {
	System.out.println("START CONVERTIRANJA");
	
	 File imde = new File(outputfile);
	    
	    if (imde.exists()) {
	    imde.delete();
	    }
	
//	    Process ffmpeg = run.exec("c:/mencoder/mencoder.exe "+diruserjapk+filename+" -o "+outputfile+" -of lavf -oac mp3lame -lameopts abr:br=56 -ovc lavc -lavcopts vcodec=flv:vbitrate=9600:mbd=2:mv0:trell:v4mv:cbp:last_pred=3  -srate 22050");
	  //  Process ffmpeg = run.exec("C:/mencoder/mencoder.exe "+diruserjapk+filename+" -o "+outputfile+" -of lavf -oac mp3lame -ovc lavc -lameopts abr:br=56 -ovc lavc -lavcopts vcodec=flv:vbitrate=9600:mbd=2:mv0:trell:v4mv:cbp:last_pred=3  -srate 22050");
	  //  ffmpeg.getOutputStream()
	    Process ffmpeg = run.exec("c:/ffmpeg/bin/ffmpeg.exe -i "+diruserjapk+filename+" -y -f flv -b 1200k -s 640x480 -r 29 -g 12 -qmin 3 -qmax 13 -ab 256 -ar 44100 -ac 2  "+outputfile);
	
	    
	    //   ffmpeg.waitFor();
//System.out.println("EXIT::: "+	 ffmpeg.exitValue());
	    BufferedReader in = new BufferedReader
		( new InputStreamReader(ffmpeg.getErrorStream()) );
	    String line;
	    
	    while ((line = in.readLine()) != null) {
	    
		System.out.println(line);
	    if (line.indexOf("Unknown format is")!=-1) {
	    exception =true;
	    }
	    }
	    in.close();
	    if (exception) {
	    File fi = new File(outputfile);
	    if (fi.exists()) {
	    fi.delete();
	    }
	    }
	    else {
	    //// naredim thumbnail
	    
	    File imd = new File(imagename);
	    
	    if (imd.exists()) {
	    imd.delete();
	    }
	    
	    Process ffmpegi = run.exec("C:/ffmpeg/bin/ffmpeg.exe -i "+outputfile+" -vcodec mjpeg -vframes 1 -an -f rawvideo -s 100x70 "+imagename);
	    in = new BufferedReader
		( new InputStreamReader(ffmpegi.getErrorStream()) );
	    
	    
	    while ((line = in.readLine()) != null) {
	    
		System.out.println(line);
	    if (line.indexOf("Unknown format is")!=-1) {
	    exception =true;
	    }
	    }
	    in.close();
	    //// brisem file
	    
	      File fi = new File(diruserjapk+filename);
	    if (fi.exists()) {
	    fi.delete();
	    }
	    
	    }
	    
	   System.out.println("konec CONVERTIRANJA");
	} catch (Exception e) {
	    System.out.println(e.getMessage());
	    	      File fi = new File(diruserjapk+filename);
	    if (fi.exists()) {
	    fi.delete();
	    }
	}
	
	if (exception) {
	System.out.println("-----------------------");
	System.out.println("--NAPAKA VIDO ENCODE---");
	System.out.println("-----------------------");
	
	}
	
	else {
	
	    /// zapisem objekt
    com.popultrade.model.Uploads vseb =new com.popultrade.model.Uploads();
	com.popultrade.dao.UploadsDAO dao = (com.popultrade.dao.UploadsDAO)contextUtil.getBeanDao("uploadsDAO",pageContext.getServletContext());
	
	vseb.setSifra(control.okolica);
	
	//vseb.setUser_id(control.idUporabnika);
	//vseb.setVideo_lokacija_mala("resized_"+filename);
	vseb.setSlika1(flv);
	
	vseb.setSlika2(imn);

	dao.saveUploads(vseb); 

}

    
  }
}
}
catch (Exception emo) {
System.out.println("Exception upload: "+emo.toString());
//if (emo.toString().indexOf("maximum")!=-1) {
napaka = ""+emo.toString();
//}
//else {
//napaka = "?imo=3";
//}
}


}

if (jeok) {

}

%>
<script language="javascript">

function populatePageI() {
document.location = "m_upload_1v.jsp?sifra=<%=control.okolica%>";
return false;
}
</script>
<body onload="populatePageI()">

</body>
<%
}
catch (Exception ex) {
System.out.println(ex.toString() + " napaka upload video");

}
}
 %>