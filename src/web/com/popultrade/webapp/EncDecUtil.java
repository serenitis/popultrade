package com.popultrade.webapp;


import javax.crypto.spec.SecretKeySpec;
import javax.crypto.Cipher;

import java.io.IOException;
import java.io.File;
import java.util.Scanner;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import java.io.StringReader;
import org.w3c.dom.NodeList;
import org.w3c.dom.Element;
import java.util.Iterator;
import org.w3c.dom.Node;
import java.util.Vector;
import java.security.MessageDigest;
import javax.crypto.spec.IvParameterSpec;
import java.util.zip.GZIPInputStream;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.zip.InflaterInputStream;
import java.io.ByteArrayOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.zip.Inflater;
import java.util.zip.DataFormatException;
import java.util.List;
import java.util.ArrayList;
import org.apache.commons.io.IOUtils;
import org.apache.xml.security.utils.Base64;

import java.util.zip.GZIPOutputStream;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2017</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class EncDecUtil {

    public EncDecUtil() {
    }

  /*  public static void main(String[] args) {
    	EncDecUtil deco = new EncDecUtil();

        try {
            
           deco.DecryptPass(deco.encrypt("PANTEON_GROUP","abc",true),"abc");
            
            String vseb  = deco.readFile("c:/adu/xml/20170727201024310.xml");
       
            
            byte[] comp = deco.compress(  deco.encrypt(vseb,"abc",true));
            
            //;
           byte[] comps= Base64.decode(Base64.encode(comp));
           String enco=  Base64.encode(comp);
     
            deco.Decrypt(enco,"abc");
           
            
        String fil = deco.readFile("e:/anime/20170728134533HJI14iuIWX.xml");

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
   DocumentBuilder builder;
   try
   {
       System.out.println("ECO --- 1");
      // String ddo =getBody(request);
       builder = factory.newDocumentBuilder();
       Document document = builder.parse( new InputSource( new StringReader( fil ) ) );

     NodeList ell=  document.getElementsByTagName("MESSAGE");

     System.out.println("ECO --- 12");

     Element elo = (Element)ell.item(0);

     String valtpass = deco.getElementvalue(deco.getXMLValue(elo,"HEADER/CRYPTTEXT"));
     String valt = deco.getElementvalue(deco.getXMLValue(elo,"BODY/CONTENT"));
     deco.DecryptPass(valtpass,"abc");
     System.out.println("ECO --- 122");
     deco.Decrypt(valt,"abc");
       System.out.println(valt);



   } catch (Exception e) {
       System.out.println("ERROR "+e.toString());
   }


        }
        catch (Exception ex) {
            System.out.println(ex.toString());
        }

    }*/

    public String readFile(String pathname) throws IOException {

    File file = new File(pathname);
    StringBuilder fileContents = new StringBuilder((int)file.length());
    Scanner scanner = new Scanner(file);
    String lineSeparator = System.getProperty("line.separator");

    try {
        while(scanner.hasNextLine()) {
            fileContents.append(scanner.nextLine() + lineSeparator);
        }
        return fileContents.toString();
    } finally {
        scanner.close();
    }
}
public static byte[] decompress(byte[] contentBytes){
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        try{
            IOUtils.copy(new GZIPInputStream(new ByteArrayInputStream(contentBytes)), out);
        } catch(IOException e){
            throw new RuntimeException(e);
        }
        return out.toByteArray();
    }


    public static byte[] compress(final String str) throws IOException {
    if ((str == null) || (str.length() == 0)) {
      return null;
    }
    ByteArrayOutputStream os = new ByteArrayOutputStream(str.length());
          GZIPOutputStream gos = new GZIPOutputStream(os);
          gos.write(str.getBytes("UTF-8"));
          gos.close();
          byte[] compressed = os.toByteArray();
          os.close();
          return compressed;

  }

    






public String encrypt(String toenc,String geso,boolean useBase64) {
    
    try {

        byte[] keyb = geso.getBytes("UTF-8");
        byte[] encrypted = toenc.getBytes(); //Base64.decode(pInput);




MessageDigest md = MessageDigest.getInstance("MD5");
byte[] thedigest = md.digest(keyb);
SecretKeySpec skey = new SecretKeySpec(thedigest, "AES");
Cipher dcipher = Cipher.getInstance("AES");
dcipher.init(Cipher.ENCRYPT_MODE, skey);

byte[] clearbyte = dcipher.doFinal(encrypted);

System.out.println(new String((clearbyte)));
        
        if (useBase64) {
return Base64.encode(clearbyte);
        }
        else {
         return new String(clearbyte);   
        }


    } catch (Exception e) {
        System.out.println("Error decrypting file: "+e.toString());
    }
      return null;
    
    
    
}



public byte[] encrypt(byte[] toenc,String geso) {
    
    try {

        byte[] keyb = geso.getBytes("UTF-8");
        byte[] encrypted = toenc; //Base64.decode(pInput);




MessageDigest md = MessageDigest.getInstance("MD5");
byte[] thedigest = md.digest(keyb);
SecretKeySpec skey = new SecretKeySpec(thedigest, "AES");
Cipher dcipher = Cipher.getInstance("AES");
dcipher.init(Cipher.ENCRYPT_MODE, skey);

byte[] clearbyte = dcipher.doFinal(encrypted);

System.out.println(new String((clearbyte)));
        
       
return clearbyte;
      
      


    } catch (Exception e) {
        System.out.println("Error decrypting file: "+e.toString());
    }
      return null;
    
    
    
}





    public String DecryptPass(String pInput,String geso) {

      try {

          byte[] keyb = geso.getBytes("UTF-8");
          byte[] encrypted = Base64.decode(pInput);




MessageDigest md = MessageDigest.getInstance("MD5");
byte[] thedigest = md.digest(keyb);
SecretKeySpec skey = new SecretKeySpec(thedigest, "AES");
Cipher dcipher = Cipher.getInstance("AES");
dcipher.init(Cipher.DECRYPT_MODE, skey);

byte[] clearbyte = dcipher.doFinal(encrypted);

System.out.println(new String((clearbyte)));
return new String(clearbyte);



      } catch (Exception e) {
          System.out.println("Error decrypting file: "+e.toString());
      }
      return pInput;
  }






    public byte[] Decrypt(String pInput,String geso) {

          try {

              byte[] keyb = geso.getBytes("UTF-8");
              byte[] encrypted = Base64.decode(pInput);


 

    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] thedigest = md.digest(keyb);
    SecretKeySpec skey = new SecretKeySpec(thedigest, "AES");
    Cipher dcipher = Cipher.getInstance("AES");
    dcipher.init(Cipher.DECRYPT_MODE, skey);

    byte[] clearbyte = dcipher.doFinal(Base64.decode(new String((decompress(encrypted)))));

    System.out.println(new String(clearbyte));
    return clearbyte;



          } catch (Exception e) {
              System.out.println("Error decrypting file: "+e.toString());
          }
          return null;
      }


      private  String getElementvalue(Element sov) {

                if (sov!=null && sov.getTextContent()!=null) {
                  return sov.getTextContent();
                }
                return "";

              }


            private  Element getXMLValue(Element sob,String pot) {

          try {
            return getXMLValue2(sob,pot);
          }
          catch(Exception ex) {
            System.out.println("Napaka: "+ex.toString());
          }

          return null;

        }






            private  Element getXMLValue2(Element sob,String pot) throws Exception {
            //  pot = "DataArea/PurchaseOrder/Header/Parties/SoldToParty/PartyId/Id";
            Iterator iy = null;
              NodeList it =null;
                  Node elo2 = null;
                //  Vector vec = new Vector();
            // vec  = (new split()).split(pot,"/");

           String[] vec=  pot.split("/");


              try {
              ////
              iy = null;
              it = sob.getChildNodes();
              boolean tes = false;
              for (int h=0;h<vec.length;h++) {
                tes = false;
                for (int m=0;m<it.getLength();m++) {
        //System.out.println("ADE");
                  elo2 = it.item(m);
                  //System.out.println("ADEw");
                  if (elo2.getNodeName().equalsIgnoreCase((String)vec[h])) {

                   // System.out.println("Elementi "+vec.get(h));
                    tes = true;
                    if ((vec.length-1)==h) {
                      return (Element)elo2;
                    }
                    break;
                    }
                }
                if (tes) {
                  it = elo2.getChildNodes();
                }
                else {
                  throw new Exception("Given path is not correct! Path: "+pot+" not found >" + vec[h]);
                 // return null;
                }
              }
              }
              catch (Exception ex) {
               // System.out.println("AC:"+ex.toString());
              }
              return null;
            }

            public String DecryptMsg(String pInput,String geso) {

                try {

                    byte[] keyb = geso.getBytes("UTF-8");
                    byte[] encrypted = Base64.decode(pInput);




          MessageDigest md = MessageDigest.getInstance("MD5");
          byte[] thedigest = md.digest(keyb);
          SecretKeySpec skey = new SecretKeySpec(thedigest, "AES");
          Cipher dcipher = Cipher.getInstance("AES");
          dcipher.init(Cipher.DECRYPT_MODE, skey);

          byte[] clearbyte = dcipher.doFinal(encrypted);

         String deco= new String(decompress(clearbyte));



     //     System.out.println(new String(deco)+ " ++++++++++++++++++++++++++");
          return new String(deco);



                } catch (Exception e) {
                    System.out.println("Error decrypting file: "+e.toString());
                }
                return pInput;
            }
}
