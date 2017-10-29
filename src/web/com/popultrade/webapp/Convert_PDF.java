package com.popultrade.webapp;


import java.io.File;

import java.io.OutputStream;



import javax.servlet.ServletContext;
 import javax.xml.transform.Result;

import javax.xml.transform.Source;

import javax.xml.transform.Transformer;

import javax.xml.transform.TransformerFactory;

 import javax.xml.transform.sax.SAXResult;

import javax.xml.transform.stream.StreamSource;

 

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.MimeConstants;

import org.apache.fop.apps.Fop;

import org.apache.fop.apps.FopFactory;




public class Convert_PDF implements java.io.Serializable 
{
	
	

  /**
	 * 
	 */
	private static final long serialVersionUID = 1678646436346346463L;


//  private split spp = new split();

    public void getPDF(ContextUtil contextUtil,ServletContext servletContext,control cont,String fofile,String xmlfile,String imefile)  {
        // set up a FOP driver
      /*  Driver driver = new Driver();
        // set up the logger for the driver
        Logger logger = new ConsoleLogger(ConsoleLogger.LEVEL_INFO);
        driver.setLogger(logger);

        try
        {
        	
          /////////// opcijski file za fonte
  Options op = new Options(new File(cont.lokacija_fo_congif()+"userconfig.xml"));
          





         /////////// naredim tmp xmlfile



 //System.out.println(""+XMLstr.toString());



        this.xmlf = new File(cont.getlokacija_pdf_file()+xmlfile);
        
     //   System.out.println("XXXXXXXXXXX 55555555555555555555555555555555555555 ");

         File xslf = new File(cont.lokacija_fo_file() +fofile+".fo");

         



            //set the renderer to be PDF
            driver.setRenderer(Driver.RENDER_PDF);
            

            //create the input from the XSLT transform
            XSLTInputHandler inputHandler = new XSLTInputHandler(xmlf,xslf);

            // now prepare the outputStrean
           // ByteArrayOutputStream outStream = new ByteArrayOutputStream();

            //set the driver outputStream
         //   driver.setOutputStream(outStream);
         String mcc = "";
        FileOutputStream fos = new FileOutputStream(cont.getlokacija_pdf_file()+""+imefile+"_"+cont.getUser().toLowerCase()+".pdf");
        driver.setOutputStream(fos);
            //do the XSLT
            driver.render(inputHandler.getParser(), inputHandler.getInputSource());

       fos.close();

       xmlf.delete();
System.out.println("KONEC IZPISA PDF file avtomatika");
       cont.izpisujePDF_esd10=false;
        } catch (Exception e)
        {
          if (xmlf!=null) {
            try {
           this.xmlf.delete();
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
            System.out.println(e.toString());
        }
        
        
        */
        
        
        
        
        
        
        
        
        

        
        try {

                System.out.println("FOP ExampleXML2PDF\n");

                 System.out.println("Preparing...");



                 // Setup directories

                 File baseDir = new File(".");

                File outDir = new File(baseDir, "out");

               outDir.mkdirs();



                // Setup input and output files

                 File xmlfilee = new File( cont.getlokacija_pdf_file()+xmlfile);

                 File xsltfile = new File(cont.lokacija_fo_file() +fofile+".fo");
                 File pdffile ;

                 if (imefile.indexOf("pdf")==-1) {
                	  pdffile = new File( cont.getlokacija_pdf_file()+""+imefile+"_"+cont.getUser().toLowerCase()+".pdf");
 
                 }
                 else {
                  pdffile = new File( cont.getlokacija_pdf_file()+""+imefile);
                 }


               System.out.println("Input: XML (" + xmlfilee + ")");

               System.out.println("Stylesheet: " + xsltfile);

               System.out.println("Output: PDF (" + pdffile + ")");

               System.out.println();

               System.out.println("Transforming...");



                // configure fopFactory as desired

                 FopFactory fopFactory = FopFactory.newInstance(new File(cont.lokacija_fo_congif()+"userconfig.xml"));
                                                  //C:\Tomcat7.0\webapps\ics\pdfconfig
                 //fopFactory.setUserConfig(new File(cont.lokacija_fo_congif()+"userconfig.xml"));

               FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

                // configure foUserAgent as desired



                // Setup output

               OutputStream out = new java.io.FileOutputStream(pdffile);

                out = new java.io.BufferedOutputStream(out);


                 try {

                  // Construct fop with desired output format

                   Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);



                   // Setup XSLT

                    TransformerFactory factory = TransformerFactory.newInstance();

                   Transformer transformer = factory.newTransformer(new StreamSource(xsltfile));



                 // Set the value of a <param> in the stylesheet

                 transformer.setParameter("versionParam", "2.0");



                   // Setup input for XSLT transformation

                  Source src = new StreamSource(xmlfilee);

 
                    // Resulting SAX events (the generated FO) must be piped through to FOP

                  Result res = new SAXResult(fop.getDefaultHandler());
 

                    // Start XSLT transformation and FOP processing

                   transformer.transform(src, res);
                   
                   xmlfilee.delete();

              } finally {

                   out.close();

               }



               System.out.println("Success!");

             } catch (Exception e) {

                e.printStackTrace(System.err);

            //   System.exit(-1);

            }


        
        System.out.println("KONEC IZPISA PDF file avtomatika");
               cont.izpisujePDF_esd10=false;
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

    }


    private String replaceXMLchar(String ch) {
   //   return ch.replaceAll("\"","\\\"").replaceAll("\'","&apos;").replaceAll("&","&amp;").replaceAll("<","&amp;").replaceAll(">","&gt;");

   ch = ch.replaceAll("\"","\\\"");
  // ch = ch.replaceAll("\'","&apos;");
   ch = ch.replaceAll("&","&amp;");
   ch = ch.replaceAll("<","&amp;");
   ch = ch.replaceAll(">","&gt;");

   return ch;
    }





}
