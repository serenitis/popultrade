package com.popultrade.webapp;


import java.io.File;
  import java.io.FileOutputStream;
  import java.io.FileInputStream;
  import java.security.*;
  import java.security.interfaces.*;
  import javax.xml.parsers.DocumentBuilderFactory;
  import javax.xml.parsers.DocumentBuilder;
  import org.apache.xml.security.keys.content.KeyName;
  import org.apache.xml.security.signature.SignedInfo;
  import org.apache.xml.security.signature.XMLSignature;
  import org.apache.xml.security.transforms.Transforms;
  import org.apache.xml.security.transforms.params.XPathContainer;
  import org.apache.xml.security.utils.Constants;
  import org.apache.xml.security.utils.XMLUtils;
  import org.apache.xml.security.samples.utils.resolver.OfflineResolver;
  import org.w3c.dom.Element;
  import org.w3c.dom.Document;
 import java.util.Enumeration;

 import java.security.KeyStore;
 import java.security.cert.CertificateFactory;
 import java.security.cert.CertificateException;
    import java.io.IOException;
import java.io.BufferedOutputStream;
import java.io.BufferedInputStream;

public class keystoreUtility implements java.io.Serializable 
    {


      /**
	 * 
	 */
	private static final long serialVersionUID = 5657890090909099781L;






	public boolean addCertificate(String keystorename,String keystorepass,String alias,String cert) {
        try {
       return insertCer(new File(keystorename),keystorepass.toCharArray(),alias,new File(cert));
        }
        catch (Exception ee) {
          return false;
        }


      }

      public boolean removeCertificate(String keystorename,String keystorepass,String alias) {
        try {
    return removeCer(new File(keystorename),keystorepass.toCharArray(),alias);
  }
       catch (Exception ee) {
         return false;
        }
  }


    /// odstranim certifikat iz keystore


      public boolean  removeCer(File keystoreFile, char[] keystorePassword,
           String alias) throws Exception {
        FileOutputStream out=null;
        FileInputStream in=null;
      try {

          KeyStore keystore = KeyStore.getInstance(KeyStore.getDefaultType());


           in = new FileInputStream(keystoreFile);
          keystore.load(in, keystorePassword);
          in.close();


          keystore.deleteEntry(alias);

           out = new FileOutputStream(keystoreFile);
          keystore.store(out, keystorePassword);
          out.close();
      }
      catch (Exception e) {
        try {
        if (out!=null) {
          out.close();
        }
        if (in!=null) {
          in.close();
        }
        }
        catch (Exception em) {

        }
          System.out.println(" sss keystore utility"+e.toString());
          throw new Exception(" sss keystore utility"+e.toString());
      }
      return true;
// }

    }

    //// dodam certifikat v keystore
        public boolean insertCer(File keystoreFile, char[] keystorePassword,
                 String alias, File cerl) throws Exception {
    FileInputStream in=null;
        FileOutputStream out =null;
        FileInputStream is=null;
            try {

            is = new FileInputStream(cerl);

CertificateFactory cf = CertificateFactory.getInstance("X.509");
java.security.cert.Certificate cert = cf.generateCertificate(is);


                KeyStore keystore = KeyStore.getInstance(KeyStore.getDefaultType());

          System.out.println(" 111111");
               in = new FileInputStream(keystoreFile);
                 System.out.println(" 111111222");
                keystore.load(in, keystorePassword);
                 System.out.println(" 1111113333");
                in.close();

    System.out.println(" 1111114444");
                keystore.setCertificateEntry(alias, cert);
     System.out.println(" 1111115555");

        is.close();
                out = new FileOutputStream(keystoreFile);
                keystore.store(out, keystorePassword);
                out.close();


            }
            catch (Exception e) {
              try {
 if (out!=null) {
   out.close();
 }
 if (is!=null) {
  is.close();
}

 if (in!=null) {
   in.close();
 }
 }
 catch (Exception em) {

 }

                System.out.println(" sss keystore utility insert cer"+e.toString());
                throw new Exception(" sss keystore utility"+e.toString());
            }
            return true;
       // }

        }

        public static java.security.cert.Certificate importCertificate(File file) {
          try {
              FileInputStream is = new FileInputStream(file);

              CertificateFactory cf = CertificateFactory.getInstance("X.509");
              java.security.cert.Certificate cert = cf.generateCertificate(is);
              //is.close();
              return cert;
          } catch (CertificateException e) {
          } catch (IOException e) {
          }
          return null;
  }






  ///////////// presnamem in rename datoteke
public boolean copyFile(String srcFile,String dstFile) {
 BufferedInputStream in=null;
 BufferedOutputStream out=null;
 try {
    in = new BufferedInputStream(new FileInputStream(new File(srcFile)));
    out = new BufferedOutputStream(new FileOutputStream(new File(dstFile)));
   byte buffer[] = new byte[1024];
   int count;

   while ( (count = in.read(buffer)) != -1) {
     out.write(buffer, 0, count);
   }

   in.close();
   out.close();
   System.out.println("Datoteka "+srcFile+" kopirana v datoteko "+dstFile);

 }
 catch (Exception ex) {
   if (in!=null) {
     try {
       in.close();
     }
     catch (Exception e) {

     }
   }
     if (out!=null) {
  try {
  out.close();
  }
  catch (Exception e) {

  }
return false;
   }
System.out.println("Ne morem kopirat datoteke: "+ex.toString());
 }
 //this.delFile(srcFile);
 return true;
}




}

