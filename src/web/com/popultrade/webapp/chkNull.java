package com.popultrade.webapp;


	import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.text.*;
import java.util.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;

import com.google.gson.Gson;

import com.google.gson.reflect.TypeToken;




	public class chkNull  implements java.io.Serializable {

		
		/// save inputstream
		public void copyInputStreamToFile( InputStream in, File file ) {
		    try {
		        OutputStream out = new FileOutputStream(file);
		        byte[] buf = new byte[1024];
		        int len;
		        while((len=in.read(buf))>0){
		            out.write(buf,0,len);
		        }
		        out.close();
		        in.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
		/// clone objekt
		
		public Object cloneObject(Object objSource) {
			Object objDest=null;
			try {
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				ObjectOutputStream oos = new ObjectOutputStream(bos);
				oos.writeObject(objSource);
				oos.flush();
				oos.close();
				bos.close();
				byte[] byteData = bos.toByteArray();
				ByteArrayInputStream bais = new ByteArrayInputStream(byteData);
				
				try {
					objDest = new ObjectInputStream(bais).readObject();
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return objDest;

		}
		
		
		
		
		
		
		
		
		
	//	private  AtomicLong idCounter = new AtomicLong();
		private SimpleDateFormat formatterx = new SimpleDateFormat ("yyyyMMddHHmmssSSS");
		public  String createID()
		{
			
		    return String.valueOf(formatterx.format(new Date()));
		}
		
		 /**
		 * 
		 */
		private static final long serialVersionUID = 3450876543354654551L;

		public  Byte[] bytetoByte(byte[] bytesPrim) {

			    Byte[] bytes = new Byte[bytesPrim.length];
			    int i = 0;
			    for (byte b : bytesPrim) bytes[i++] = b; //Autoboxing
			    return bytes;

			}
		
		
		
		  public synchronized String unscramble(String vred) {
			  
			  String[] vs = {"c","s","d"};
			  
			  String ret = "";
			  if (vred==null || vred.equals("")) {
				  return "";
			  }
			 try {
				 int zak = 0;
				 for (int t=0;t<vred.length()/2;t++) {
					 
					 ret+=vred.substring(t,t+1);
					 t++;
					 if (t==vred.length()) {
						 break;
					 }
					 
				 }
				 return ret;
				 
			 }
			 catch (Exception exo) {
				 System.out.println("error unscrambling "+exo.toString());
			 }
			 return null;
			  
			  
		  }
		
		
		
		
	private String pres = "";
	/// menjam javascripto dropdown menu v sumnike iz prevoda
	
	public String menjajVSumnike(String original,String prevodi) {
		
		try {
		
			original = original.replaceAll("_SLSS_",prevodi.substring(0,1))
					.replaceAll("_SLss_",prevodi.substring(1,2))
					.replaceAll("_SLDD_",prevodi.substring(2,3))
					.replaceAll("_SLdd_",prevodi.substring(3,4))
					.replaceAll("_SLCC_",prevodi.substring(4,5))
					.replaceAll("_SLcc_",prevodi.substring(5,6))
					.replaceAll("_SLCI_",prevodi.substring(6,7))
					.replaceAll("_SLci_",prevodi.substring(7,8))
					.replaceAll("_SLzz_",prevodi.substring(8,9))
					.replaceAll("_SLZZ_",prevodi.substring(9,10));
			
			return original;
		
			
			
		}
		catch (Exception ex) {
			System.out.println("Napaka pri menjavi v sumnike za oracle");
		}
		
		return original;
		
		
	}
	
	
	/// splitam vsakih n znakov
	public  List<String> getSplitNZnakov(String string, int nznak) {
        List<String> parts = new ArrayList<String>();
        int len = string.length();
        for (int i=0; i<len; i+=nznak)
        {
            parts.add(string.substring(i, Math.min(len, i + nznak)));
        }
        return parts;
    }
	
	
	
	  public String menjajSifrantZnake(String postaa) {
	
		  postaa = postaa.replace('*','_');
		  postaa = postaa.replace('/','_');
		  postaa = postaa.replace('-','_');
		  postaa = postaa.replace('\\','_');
		  postaa = postaa.replace('.','_');
		  postaa = postaa.replace('\'','_');
		  postaa = postaa.replace('\"','_');
		  postaa = postaa.replace('&','_');
		      return postaa;
		    }
	
	
	//// format za export edi
    public synchronized  String getEDIFormat(String var,int size,String smer) {
        if (var.length()<=size) {
        	
        	if (smer!=null && smer.equals("left")) {
          for (int g = var.length();g<size;g++) {
            var = var + " ";
          }
        	}
        	else if (smer!=null && smer.equals("right")) {
        		   for (int g = var.length();g<size;g++) {
        	            var = " "+var;
        	          }
        	}
        	else {
        	    for (int g = var.length();g<size;g++) {
                    var = var + " ";
                  }	
        	}
          
          
          return var;
        }
        else {
          return var.substring(0,size);
        }
      //  return var;
      }
	
	
    
    public boolean jeDatumXMed(Date dx,Date od,Date doo) {
    	
    	
    	try {
    		
    		
    		if (doo==null) {
    			
    			doo = new Date();
    			doo.setTime(1000*60*60*24*365*100);
    			
    		}
    		
    		
    		if (dx.getTime()>=od.getTime() && dx.getTime()<=doo.getTime()) {
    			return true;
    		}
    		
    		
    	}
    	catch (Exception ex) {
    	System.out.println("Error searching if the date is between two dates: "+ex.toString());	
    	return false;
    	}
    	
    	return false;
    	
    	
    }
    
    
    
    
    
    
    
    
	
	public boolean chkMrn(String mrn) {
		
		
	//// kontrola mrn
try {
		
	Hashtable mrns = new Hashtable();
	int[] arr = new int[17];
	
	
	mrns.put("0", 0);
	mrns.put("1", 1);
	mrns.put("2", 2);
	mrns.put("3", 3);
	mrns.put("4", 4);
	mrns.put("5", 5);
	mrns.put("6", 6);
	mrns.put("7", 7);
	mrns.put("8", 8);
	mrns.put("9", 9);
	mrns.put("A", 10);
	mrns.put("B", 12);
	mrns.put("C", 13);
	mrns.put("D", 14);
	mrns.put("E", 15);
	mrns.put("F", 16);
	mrns.put("G", 17);
	mrns.put("H", 18);
	mrns.put("I", 19);
	mrns.put("J", 20);
	mrns.put("K", 21);
	mrns.put("L", 23);
	mrns.put("M", 24);
	mrns.put("N", 25);
	mrns.put("O", 26);
	mrns.put("P", 27);
	mrns.put("Q", 28);
	mrns.put("R", 29);
	mrns.put("S", 30);
	mrns.put("T", 31);
	mrns.put("U", 32);
	mrns.put("V", 34);
	mrns.put("W", 35);
	mrns.put("X", 36);
	mrns.put("Y", 37);
	mrns.put("Z", 38);

	

		arr[0]=1;
		arr[1]=2;
		arr[2]=4;
		arr[3]=8;
		arr[4]=16;
		arr[5]=32;
		arr[6]=64;
		arr[7]=128;
		arr[8]=256;
		arr[9]=512;
		arr[10]=1024;
		arr[11]=2048;
		arr[12]=4096;
		arr[13]=8192;
		arr[14]=16384;
		arr[15]=32768;
		arr[16]=65536;



		//alert(1);
	int skupaj = 0;
	
//System.out.println("DDD123::: "+mrn);
			for (int i=0;i<mrn.length()-1;i++) {

				int j = i;
				
			skupaj = skupaj +(arr[i] *	Integer.parseInt(mrns.get(mrn.substring(j,j+1))+""));

			}

		String skupp = (skupaj%11)+"";
		//System.out.println("DDD::: "+mrn.substring(mrn.length()-1,mrn.length()) + " ::: "+skupp);
			if (skupp.equals("10")) {
			skupp = "0";
				}

			if (mrn.substring(mrn.length()-1,mrn.length()).equals(skupp)) {
			return true;
			}
			else {
			return false;
				}
			
			

			
}
catch (Exception ex) {
System.out.println("Napaka pri checkiranju mrnjev!!!! "+ex.toString());
	
	return false;
}
		
		
	}
	
	
	
	
	
	
	
	
	
	public String decimalFormat(double doub) {
		
		
		
		try {
		DecimalFormat df = new DecimalFormat("#################0.00");
		
		return df.format(doub);
		}
		catch (Exception ex) {
			System.out.println("napaka pri decimalkah:"+ex.toString());
		}
		return "0.0";
	}
	
	
	
	
	
	 public Date parseDatumUra(String datumm,String format) {
		    SimpleDateFormat formatter=null;
	       
	              formatter = new SimpleDateFormat (format);
	              try {
	                  //   formatter.setTimeZone(TimeZone.getTimeZone("GMT+01:00"));
	               Date dm = formatter.parse(datumm);
	               
	               return dm;
	               }
	               catch (Exception ex) {
	               ///   System.out.println(ex.toString() + " error when parsing data!");
	               }
	               
	               return null;
	 }
	
	
	
	
    public Date parseDatumUra(String datumm) {
        SimpleDateFormat formatter=null;
        if (datumm.length()>11) {
              formatter = new SimpleDateFormat ("dd-MM-yyyy HH:mm");
        }
        else if (datumm.length()==10) {
        formatter = new SimpleDateFormat ("dd-MM-yyyy");
        }
        else if (datumm.length()==11) {
            formatter = new SimpleDateFormat ("dd-MM-yyyy");
            datumm = datumm.substring(0,10);
            }
        else {
              return null;
        //    datumm = "00-00-0000 00:00";
        //    formatter = new SimpleDateFormat ("dd-MM-yyyy HH:mm");
        //    formatter.setTimeZone(TimeZone.getTimeZone("GMT+02:00"));
        }
        try {
           //   formatter.setTimeZone(TimeZone.getTimeZone("GMT+01:00"));
        Date dm = formatter.parse(datumm);
        
        return dm;
        }
        catch (Exception ex) {
        ///   System.out.println(ex.toString() + " error when parsing data!");
        }
        
        return null;
        
        
  }

	
	
	  public synchronized String jePraPre(String test,int pre) {

	   if (test==null || test.equals("null") || test.equals("")) {
	     for (int h=0;h<pre;h++) {
	       pres = pres + " ";
	     }

	     return pres;

	   }
	   else {
	     return test;
	   }


	  }

	  public synchronized String jeNullEscapeSQL(String test) {
		  
		  
		    if (test==null || test.equals("null")) {
			      return "";
			    }
			    else {
			    	
			    	 StringEscapeUtils d = new StringEscapeUtils();
			    	
			    	 if (test.indexOf(" or ")!=-1) {
			    		test= test.replace(" or ", "");
			    	 }
			    	 if (test.startsWith("or")) {
			    		 test=test.substring(2);
			    	 }
			    	 
			    	 if (test.indexOf("select")!=-1) {
				    		test= test.replace("select", "");
				    	 }
			    	 if (test.indexOf("update")!=-1) {
				    		test= test.replace("update", "");
				    	 }
			    	 if (test.indexOf("insert")!=-1) {
				    		test= test.replace("insert", "");
				    	 }
			    	 if (test.indexOf("delete")!=-1) {
				    		test= test.replace("delete", "");
				    	 }
			    	 if (test.indexOf("=")!=-1) {
				    		test= test.replace("=", "");
				    	 }
			    	 
			    	 test= test.replaceAll("_", "\\\\_");
			    	 
			    	 test = d.escapeSql(test);
			    	 
			      return test;
			    }
	 
	  
	  }

	  public synchronized String jeNull(String test) {

	    if (test==null || test.equals("null")) {
	      return "";
	    }
	    else {
	      return test;
	    }


	  }
	  public synchronized String jeNull(Long test) {

		  
		  try {
		  
		    if (test==null || test.equals("null")) {
		      return "";
		    }
		    else {
		      return test+"";
		    }
		  }
		  catch (Exception e) {
			  return "";
		  }


		  }
	  public synchronized String jeNull(Integer test) {

		  
		  try {
		    if (test==null || test.equals("null")) {
		      return "";
		    }
		    else {
		      return test+"";
		    }
		  }
		  catch (Exception e) {
			  return "";
		  }

		  }
	  
		public String dodajNavednico() {
			return "'";
		}
		
	
	  public synchronized String jeN(String test) {

		  
		  try {
		    if (test==null || test.equals("null")) {
		      return "";
		    }
		    else {
		      return replaceXMLcharPDF(test);
		    }
		  }
		  catch (Exception e) {
			  return "";
		  }

		  }
	  
	  
	  
	  
	  public synchronized String jeNullDefault(String test) {

		  try {
		    if (test==null || test.equals("null")) {
		      return ".";
		    }
		    else {
		      return test;
		    }
		  
	  }
	  catch (Exception e) {
		  return ".";
	  }


		  }

	  private boolean chkNull2(String te) {
		  
		  try {
	    if (te == null) {
	      return false;
	    }
	    else {
	      return true;
	    }
		  }
		  catch (Exception e) {
			  return false;
		  }

	  }
	  
	  public synchronized String cutStringAddPoints(String test,int size) {

		  if (!this.chkNull2(test)) {
		    return "";
		  }

		   if (test.length() > size) {
		     return test.substring(0,size) + " ...";
		   }
		   else {
		     return test;
		   }


		  }


	  public synchronized String cutString(String test,int size) {

	  if (!this.chkNull2(test)) {
	    return "";
	  }

	   if (test.length() > size) {
	     return test.substring(0,size);
	   }
	   else {
	     return test;
	   }


	  }

//////	 yamenjam crtico za javascript
	  public synchronized String subZnak(String stavek) {
	   String a ="";
	   String b="";
	   String c="";
	   int stlen = stavek.length();
	   boolean bol=true;
	   boolean chk=false;
	   stavek = stavek.replace('\'','`');

	    return stavek;
	  }


	  public synchronized String subZnakPraznopolje(String stavek) {


	    return replace(stavek,"\'","",true).toString();
	  }


//////	 replace


	  /////////////// replace char streing

	public StringBuffer replace(String ori, String o, String n,boolean all) {

	  StringBuffer orig = new StringBuffer(ori);
	    if (orig == null || o == null || o.length() == 0 || n == null)
	        throw new IllegalArgumentException("Null or zero-length String");
	    int i = 0;
	    while (i + o.length() <= orig.length()) {
	        if (orig.substring(i, i + o.length()).equals(o)) {
	            orig.replace(i, i + o.length(), n);
	            if (!all)
	                break;
	            else
	                i += n.length();
	        } else
	            i++;
	    }
	    return orig;
	}













//	String datd = "";
	public String nuleViaDatum(String dat) {

	if (dat.indexOf("00:00:00")!=-1) {

	dat = dat.substring(0,dat.indexOf("00:00:00"));

	}

	 else   if (dat.indexOf(" 00:00")!=-1) {

	    dat = dat.substring(0,dat.indexOf(" 00:00"));

	    }





	  return dat;
	}


//	String datd = "";
	public String uraizDatuma(String dat) {

	if (dat!=null && dat.indexOf(" ")!=-1) {
	  return dat.substring(dat.indexOf(" ")+1,dat.length());
	}

	  return "00:00";
	}

	public String viaUraizDatuma(String dat) {

	if (dat!=null && dat.indexOf(" ")!=-1) {
	  return dat.substring(0,dat.indexOf(" "));
	}

	  return dat;
	}



	public String viaNule(String nult) {

	  if (nult.equals("                 ,00") || nult.equals("                 .00")) {
	    return "";
	  }
	  else {
	    return nult;
	  }

	}

	private NumberFormat nf = NumberFormat.getNumberInstance(new Locale("de", "DE"));

	public String formatNule(double nula,int digits) {
//	System.out.println(nula);
 
	if (nula!=0) {

	nf.setMaximumFractionDigits(digits);
	nf.setMinimumFractionDigits(digits);
//	System.out.println(nf.format(nula));

	return nf.format(nula);
	}
	  else {
	    return "";
	  }
	}
	  public synchronized String jeNullCena(String test,int stdec) {

		    if (test==null || test.equals("null")) {
		      return "";
		    }
		    else {

		    	
		    	
		      test = test.replaceAll("\\.",",");
		      if (test.indexOf(",")!=-1) {


		        //test = test.substring(0,test.indexOf(","))+"."+test.substring(test.indexOf(",")+1,test.indexOf(",")+1+stdec);
		        int doldec= test.substring(test.indexOf(",")+1,test.length()).length();

		        if (doldec>stdec) {
		          test = test.substring(0,test.indexOf(","))+"."+test.substring(test.indexOf(",")+1,test.indexOf(",")+1+stdec);
		        }
		        else {
		          String stdem = "";
		        for (int i=doldec;i<stdec;i++) {
		          stdem = stdem+"0";
		         }
		         test = test + stdem;

		        }


		      }
		      else {
		        String stdem = "";
		        for (int i=1;i<=stdec;i++) {
		          stdem = stdem+"0";
		        }
		        test = test + "."+stdem;
		      }

		      if (test.startsWith(".") || test.startsWith(",")) {
		        test = "0"+test;
		      }

		      return test.replace(",",".");
		    }


		  }

	public String formatNuleStringa(String nula,int digits) {
//	System.out.println(nula);

	    if (nula==null) {
	      return "";
	    }

	    try {
	float flo = Float.parseFloat(nula);
	nf.setMaximumFractionDigits(digits);
	nf.setMinimumFractionDigits(digits);

//	System.out.println((nf.format(flo)).toString().replaceAll(".","")  + " ----------------------------");

	return nf.format(flo).replaceAll("\\.","");
	    }
	    catch (Exception ex){

	        System.out.println(ex.toString() + " napaka pri float converziji v chknull" );
	    return "";
	      }
	}

//////////////	 formatiram datum, ki dobim iz baze


	public String obrniDat(String datum)  {
	  if (datum!=null) {
		  
		  datum = datum.substring(0,datum.indexOf(" "));
		  
	  String en = "";
	  String dav = "";
	  String mev = "";
	  String lev = "";
	  if (datum.indexOf("-")!=-1) {
	    if (datum.indexOf(" ")!=-1) {

	      en = datum.substring(0,datum.indexOf(" "));

	      dav = en.substring(en.lastIndexOf("-")+1,en.length());
	      mev = en.substring(en.indexOf("-")+1,en.lastIndexOf("-"));
	      lev = en.substring(0,en.indexOf("-"));
	      en = datum.substring(datum.indexOf(" ")+1,datum.length());
	      datum = dav+"-"+mev+"-" +lev+ " " + en;
	    }
	    else {
	      en = datum;

	      dav = en.substring(en.lastIndexOf("-")+1,en.length());
	      mev = en.substring(en.indexOf("-")+1,en.lastIndexOf("-"));
	      lev = en.substring(0,en.indexOf("-"));
	      datum = dav + "-" + mev + "-" + lev;
	    }

	  }
	  else {
	    return "";
	  }

	  }


	  return datum;
	}

	public String getDatumFormatFromDate(Date dt) {
		if (dt!=null) {
		SimpleDateFormat formatter = new SimpleDateFormat ("dd-MM-yyyy HH:mm");

		

		return formatter.format(dt);
		}
		return "";
		}
	
	public String getDatumFormatFromDate(Date dt,String format) {
		if (dt!=null) {
		SimpleDateFormat formatter = new SimpleDateFormat (format);

		

		return formatter.format(dt);
		}
		return "";
		}
	
	
	

	public String getDatumFormatFromDateNoTime(Date dt) {
		if (dt!=null) {
		SimpleDateFormat formatter = new SimpleDateFormat ("dd-MM-yyyy");

		

		return formatter.format(dt);
		}
		return "";
		}
	public String getDatumFormat(String format) {
	SimpleDateFormat formatter = new SimpleDateFormat (format);

	Date dat = new Date();

	return formatter.format(dat);
	}


	
	
	
	public static String replaceNL(String nl) {
		
		if (nl!=null) {
			String rep1 = nl.replaceAll("__BR__", "<fo:block/>");
			System.out.println("====================== "+rep1);
			String rep = nl.replaceAll("__BR__", "<fo:block/>");
			System.out.println("====================== "+rep);
		return rep;
		}
		return "";
		
	}
	
	
	
	
////	/ dobim sedanji datum
	public String getDatumDanes() {
	SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd");

	Date dat = new Date();

	return formatter.format(dat);
	}
////	/ dobim sedanji datum
	public String getDatumDanesMin() {
	SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

	Date dat = new Date();

	return formatter.format(dat);
	}


////////	/ dobim select input vrednost za le dve moznosti

	public String getSelectInput(String vrednost,String pozitivna_vrednost,String negativna_vrednost,String opcija_poz_ok,String opcija_poz_ne,String ime_neznanke) {
	String vrni = "";
	  if (vrednost!=null) {
	if (vrednost.equals(pozitivna_vrednost)) {

	    vrni = vrni + "<select name=\""+ime_neznanke+"\" style=\"font-family: Verdana; font-size: 10px\">";
	    vrni = vrni + "<option value=\""+pozitivna_vrednost+"\" selected>"+opcija_poz_ok+"</option>";
	    vrni = vrni + "<option value=\""+negativna_vrednost+"\" >"+opcija_poz_ne+"</option>";
	    vrni = vrni +"</select>";
	  }
	else {
	    vrni = vrni + "<select name=\""+ime_neznanke+"\" style=\"font-family: Verdana; font-size: 10px\">";
	  vrni = vrni + "<option value=\""+pozitivna_vrednost+"\" >"+opcija_poz_ok+"</option>";
	  vrni = vrni + "<option value=\""+negativna_vrednost+"\" selected>"+opcija_poz_ne+"</option>";
	  vrni = vrni +"</select>";



	  }

	  }
	  else {
	    vrni = vrni + "<select name=\""+ime_neznanke+"\" style=\"font-family: Verdana; font-size: 10px\">";
	  vrni = vrni + "<option value=0 >"+opcija_poz_ok+"</option>";
	  vrni = vrni + "<option value=1 selected>"+opcija_poz_ne+"</option>";
	  vrni = vrni +"</select>";


	  }


	return vrni;


	}

////////////	 dobim checkbox

	public String getcheckBox(String vrednost,String ime_neznanke,String pozitivna_vrednost) {
	String vrni="";

	if (vrednost!=null) {
	    if (vrednost.equals(pozitivna_vrednost)) {
	vrni = vrni + "<input type=checkbox name=\""+ime_neznanke+"\" value=\""+pozitivna_vrednost+"\" checked  style=\"font-family: Verdana; font-size: 10px\">";
	    }
	    else {
	  vrni = vrni + "<input type=checkbox name=\""+ime_neznanke+"\" value=\""+pozitivna_vrednost+"\" style=\"font-family: Verdana; font-size: 10px\" >";
	    }
	  }
	else {
	    vrni = vrni + "<input type=checkbox name=\""+ime_neznanke+"\" value=\""+pozitivna_vrednost+"\" style=\"font-family: Verdana; font-size: 10px\">";
	  }



	return vrni;
	}


	public synchronized String jeNullSpremeni(String test,String vrednost) {

	  if (test==null || test.equals("null") || test.equals("")) {
	    return "";
	  }
	  else {
	    return test+vrednost;
	  }


	  }

	  public synchronized String jeNullSpremeni3(String test,String vrednost) {

	    if (test==null || test.equals("null") || test.equals("")) {
	      return "";
	    }
	    else {
	      return vrednost+test;
	    }


	    }


	  public synchronized String jeNullSpremeni2(String test,String vrednost) {

	    if (test==null || test.equals("null") || test.equals("")) {
	      return vrednost;
	    }
	    else {
	      return test;
	    }


	    }



	  ////// za search stavek
	  public String searchStavek(String vrednost) {
	    if (vrednost==null) {
	      return "%";
	    }
	    else {
	      return vrednost;
	    }

	  }
	  
	  public String addBlankeZadaj(String vred,int stnul) {
		  
		  if (vred!=null){
			  int len = stnul -vred.length() ;
			
			  String num = "";
			  
			  for (int n=1;n<=len;n++) {
				  num = num + "&nbsp;";
			  }
			  
			  return vred+num;
			  
			  
		  }
		  return vred;
		  
	  }
	  
	  
	  
	  public String addNuleSpredaj(String vred,int stnul) {
		  
		  if (vred!=null && vred.length()<=4){
			  int len = stnul -vred.length() ;
			
			  String num = "";
			  
			  for (int n=1;n<=len;n++) {
				  num = num + "0";
			  }
			  
			  return num + vred;
			  
			  
		  }
		  return vred;
		  
	  }
	  
	  
	  


	  public String addNule(String vred,int stnul) {
		  
		  if (vred!=null && !vred.equals("null")) {
			  String nul="";
			  for (int a=1;a<=(stnul-vred.length());a++) {
				  nul=nul+"0";
			  }
			  return nul+vred;
			  
		  }
		  else {
			  return "";
		  }
		  
		  
	  }

//////zapolnem prazna polja za EDI format file
	    public String getFormat(String var,int size) {
	      if (var.length()<=size) {
	        for (int g = var.length();g<size;g++) {
	          var = var + " ";
	        }
	        return var;
	      }
	      else {
	        return var.substring(0,size);
	      }
	    //  return var;
	    }

//////	zapolnem prazna polja za EDI format file align desno
	    public String getFormatDesno(String var,int size) {
	      if (var.length()<=size) {
	        for (int g = var.length();g<size;g++) {
	          var = " "+var;
	        }
	        return var;
	      }
	      else {
	        return var.substring(0,size);
	      }
	    //  return var;
	    }
	    
	    
	    
	    public String replaceTextFiled(String toReplace) {
	    	if (toReplace==null) {
	    		return "";
	    	}
	    	else {
	    	return toReplace;
	    }
	    	}
	    
	    
	    
	    
	    	    
	    
	    
 
	    
	    
	    public String getFormatted(String testo) {
	    	
	    	
	    	

	    	try {

	    	if (!this.jeNull(testo).equals("")) {
	    	//com.fidelia.model.Users vseb =new com.fidelia.model.Users();
	    	//com.fidelia.dao.UsersDAO dao = (com.fidelia.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
	    	//vseb = dao.getUsersbyUsername(request.getParameter("username"));
	    	/// via html
	    	 testo = testo.replaceAll("<.*?>","");

	    	
	    	 

	    
	    	    
	    	 String  patternStr = "\\[face\\](.*?)\\[/face\\]";
	    	 Pattern   pattern = Pattern.compile(patternStr);
	    	 Matcher  matcher = pattern.matcher("");
	    	 	matcher.reset(testo);
	    	    
	    	  while (matcher.find()) {
	    	    //for (int i=0;i<=matcher.groupCount();i++) {
	    	  //// dobim video in dam kot link
	    	  System.out.println("FACES ::: "+matcher.group(1));
	      if (matcher.group(1)!=null ) {
	    
	    	  String lino = "<img src='smile/"+matcher.group(1).toLowerCase()+".gif' border=0>";
	    	  testo = testo.replaceAll(matcher.group(1),lino);
	    	  }

	    	    }
	    	  
	
	    	    
	    	 
	    	    
	    	        patternStr = "\\[link ([^\\]]*)\\](.*?)\\[/link\\]";
	    	    pattern = Pattern.compile(patternStr);
	    	    matcher = pattern.matcher("");
	    	 	matcher.reset(testo);
	    	    
	    	  while (matcher.find()) {
	    	    //for (int i=0;i<=matcher.groupCount();i++) {
	    	  //// dobim video in dam kot link
	    	//  System.out.println("LINK ::::::::::::::::::::::::::::::::::::::::: "+matcher.group(0));
	      if (matcher.group(1)!=null && matcher.group(0)!=null && !matcher.group(0).trim().equals("")) {
	    	  
	    	  String vredo = "";
	    	  
	    	  if (matcher.group(1).indexOf("url=")!=-1) {
	    	  vredo = matcher.group(1).replaceAll("url=","");
	    	  vredo = vredo.trim();
	    	  }
	    	//  String linkkk = matcher.group(2).trim();
	    	  
	    	  if (vredo.indexOf("http://")==-1) {
	    	  vredo = "http://"+vredo; 
	    	  }
	    	  
	    	  String lino = "<a href=\""+vredo+"\">";
	    	  
	    	  lino = lino +matcher.group(2);
	    	  lino = lino +"</a>";
	    	  String agg = matcher.group(0).replaceAll("\\]","\\\\]").replaceAll("\\[","\\\\[");
	    	  //System.out.println(agg);
	    	  testo = testo.replaceAll(agg,lino);
	    	  }  
	    	  }

	    	    

	    	return testo.replaceAll("\\[b\\]","<b>").replaceAll("\\[/b\\]","</b>")
	    	.replaceAll("\\[i\\]","<i>").replaceAll("\\[/i\\]","</i>")
	    	.replaceAll("\\[u\\]","<u>").replaceAll("\\[/u\\]","</u>")
	    	.replaceAll("\\[video\\]","").replaceAll("\\[/video\\]","")
	    	.replaceAll("\\[pict\\]","").replaceAll("\\[/pict\\]","")
	    	.replaceAll("\\[user\\]","").replaceAll("\\[/user\\]","")
	    	.replaceAll("\\[face\\]","").replaceAll("\\[/face\\]","")
	    	.replaceAll("\\[respo\\]","<table  style=\"border-collapse: collapse; font-family:Verdana; font-size:8pt\"  ><tr><td bgcolor=\"white\">").replaceAll("\\[/respo\\]","</td></tr></table>")
	    	.replaceAll("\\[center\\]","<center>").replaceAll("\\[/center\\]","</center>")
	    	.replaceAll("\\[left\\]","<p align='left'>").replaceAll("\\[/left\\]","</p>")
	    	.replaceAll("\\[right\\]","<p align='right'>").replaceAll("\\[/right\\]","</p>")
	    	.replaceAll("\n","<br>");

	    	

	    	}
	    	}
	    	catch (Exception ex) {
	    	System.out.println("chknull napaka pri konvertiranju texta --------------------------------------"+ex.toString());
	    	
	    	}
	    	
	    	return "";
	    	
	    	
	    }
	    
	    public Date addDaysToDate(Date dt,int stdni) {
	    	
	    	
	    	
	    	Calendar cal = Calendar.getInstance();
	    	cal.setTime( dt);
	    	cal.add( Calendar.DATE, stdni );
	    	
	    	return cal.getTime();
	    	
	    	
	    	
	    	
	    }
	    
	    
	    
	    
	    
	    public String sestejDoubleVrednosti(String id,Double[] vrednosti,String format_rezultata) {
	    	
	    	
	    	try {
	    		Double rett = 0.00;
	    	for (int i=0;i<vrednosti.length;i++) {
	    		
	    		if (vrednosti[i]!=null) {
	    			rett = rett + vrednosti[i];
	    		//	System.out.println("::::x:::: "+vrednosti[i]);
	    		//	System.out.println("::::::::: "+rett);
	    		}
	    		
	    		
	    	}
	    	//if (rett!=0) {
	    	return this.formatNumberVrniNule(rett, format_rezultata);
	    	//}
	    	}
	    	catch (Exception ex) {
	    		System.out.println("Napaka pri sestevku double vrednosti "+ex.toString());
	    	}
	    	
	    	
	    	
	    	return "";
	    	
	    }
	    
	    
	    
	    
	    
	    public Double kontrolaDouble(Double ino) {
	    	
	    	if (ino!=null) {
	    		return ino;
	    	}
	    	else {
	    		return new Double("0.00");
	    	}
	    	
	    	
	    }
	    
	    
	    
	    public Integer kontrolaInteger(Integer ino) {
	    	
	    	if (ino!=null) {
	    		return ino;
	    	}
	    	else {
	    		return new Integer("0");
	    	}
	    	
	    	
	    }
	    
	    
	    
	    public String sestejIntegerVrednosti(String id,Integer[] vrednosti) {
	    	
	    	
	    	try {
	    		Integer rett = 0;
	    	for (int i=0;i<vrednosti.length;i++) {
	    		
	    		if (vrednosti[i]!=null) {
	    			rett = rett + vrednosti[i];
	    		}
	    		
	    		
	    	}
	    	//if (rett!=0) {
	    	return rett+"";
	    	//}
	    	}
	    	catch (Exception ex) {
	    		System.out.println("Napaka pri sestevku integer vrednosti "+ex.toString());
	    	}
	    	
	    	
	    	
	    	return "";
	    	
	    }
	    
	    public String formatNumberVrniNule(Double kolicina,String format) {
	    	try {
	    		 String bruto = "";
        		 if (kolicina!=null) {
        			 Locale currentLocale = new Locale("en", "US");

        			 DecimalFormatSymbols unusualSymbols = new DecimalFormatSymbols(currentLocale);

        			 DecimalFormat df = new DecimalFormat(format,unusualSymbols);
        			// DecimalFormat df = new DecimalFormat(format);
        				bruto = df.format(kolicina.doubleValue());

        				return bruto;
        		 }
	    	}
	    	catch (Exception ex) {
	    		System.out.println("Napaka pri formatNumber : "+ex.toString());
	    		
	    	}
	    	return "";
	    }
	    
	    public String formatNumber(Double kolicina,String format) {
	    	try {
	    		 String bruto = "";
        		 if (kolicina!=null) {
        			 Locale currentLocale = new Locale("en", "US");

        			 DecimalFormatSymbols unusualSymbols = new DecimalFormatSymbols(currentLocale);

        			 DecimalFormat df = new DecimalFormat(format,unusualSymbols);
        			// DecimalFormat df = new DecimalFormat(format);
        				bruto = df.format(kolicina.doubleValue());
        				
        				/*if (bruto.equals("0.00") || bruto.equals("0,00")) {
        					bruto="";
        				}*/
        				
        				return bruto;
        		 }
	    	}
	    	catch (Exception ex) {
	    		System.out.println("Napaka pri formatNumber : "+ex.toString());
	    		
	    	}
	    	return "0";
	    }
	    
	    
	    
	    
	    public String formatNumber(Integer kolicina2,String format) {
	    	try {
	    		 String bruto = "";
        		 if (kolicina2!=null) {
        			 Locale currentLocale = new Locale("en", "US");

        			 
        		//	 Double kolicina = (double) kolicina2; 
        			 
        			 DecimalFormatSymbols unusualSymbols = new DecimalFormatSymbols(currentLocale);

        			 DecimalFormat df = new DecimalFormat(format,unusualSymbols);
        			// DecimalFormat df = new DecimalFormat(format);
        				bruto = df.format(kolicina2.doubleValue());
        				
        				/*if (bruto.equals("0.00") || bruto.equals("0,00")) {
        					bruto="";
        				}*/
        				
        				return bruto;
        		 }
	    	}
	    	catch (Exception ex) {
	    		System.out.println("Napaka pri formatNumber : "+ex.toString());
	    		
	    	}
	    	return "0";
	    }
	    
	    
	    
	 	   public String toXMLchar(String ch) {
		 		
		 		ch = ch.replaceAll("\\\"","\"");
		 		ch = ch.replaceAll("&amp;","&");
		 		ch = ch.replaceAll("&lt;","<");
		 		ch = ch.replaceAll("&gt;",">");
		 		return ch;
		 		}	
	 	   
	 	   /// get properties from string for fo format fo:block, 
	 	   /// background-color => bgc
	 	   /// text-align => talign
	 	   /// color (font) => tcolor
	 	   /// font-weight => fweight
	 	   /// line-height => lheight
	 	   /// padding => padding
	 	   /// padding-top => tpadding
	 	/// padding-left => lpadding
	 	/// padding-right => rpadding
	 	/// padding-bottom => bpadding
	 	   /// font-size => fsize
	 	   /// font-family => ffamily
	 	   /// line-height => lheight
	 	   /// margin => margin
	 	/// margin-left => lmargin
	 	/// margin-top => tmargin
	 	/// margin-right => rmargin
	 	/// margin-bottom => bmargin
	 	   
	 	   /// example: bgc:::silver--X|X--talign:::left--X|X--vrednost
	 	   /// check if there are any properties
	 	  public String getIsPropFromFile(String ch) {
	 		  
	 		  if (ch==null || ch.indexOf("--X|X--")==-1 ) {
	 			  return "NO";
	 		  }
	 		  return "YES";
	 		  
	 		  
	 	  }
	 	   
	 	   public String getPropFromFile(String prop,String ch) {

	 		   System.out.println("::::::1:::::: "+prop);
	 		   
	 		   if (ch.indexOf("--X|X--")!=-1 && !prop.equals("")) {
	 			   
	 			   /// properties if exist
	 			   String rr = ch.substring(0,ch.lastIndexOf("--X|X--"));
	 			   
	 			   if (ch.indexOf(prop)!=-1) {
	 				   rr= rr.substring(rr.indexOf(prop)+prop.length()+3);
	 				   
	 				   if (rr.indexOf("--X|X--")!=-1) {
	 					  System.out.println("::::::2:::::: "+rr.substring(0,rr.indexOf("--X|X--")));
	 					   return rr.substring(0,rr.indexOf("--X|X--"));
	 				   }
	 				   else {
	 					  System.out.println("::::::2:::::: "+rr);
	 					   return rr;
	 				   }
	 				   
	 			   }
	 			   
	 			   return "";
	 		   }
		 	
	 		   if (prop.equals("") && ch.indexOf("--X|X--")!=-1) {
	 			   ch = ch.substring(ch.lastIndexOf("--X|X--")+7);
	 			   return ch.trim();
	 		   }
	 		  if (prop.equals("")) {
	 			 return ch.trim();
	 		  }
		 		
		 		return "";
		 		}		 	   
	 	   
	 	    public String stripNonValidXMLCharacters(String in) {
	 	        StringBuffer out = new StringBuffer(); // Used to hold the output.
	 	        char current; // Used to reference the current character.

	 	        if (in == null || ("".equals(in))) return ""; // vacancy test.
	 	        for (int i = 0; i < in.length(); i++) {
	 	            current = in.charAt(i); // NOTE: No IndexOutOfBoundsException caught here; it should not happen.
	 	            if ((current == 0x9) ||
	 	                (current == 0xA) ||
	 	                (current == 0xD) ||
	 	                ((current >= 0x20) && (current <= 0xD7FF)) ||
	 	                ((current >= 0xE000) && (current <= 0xFFFD)) ||
	 	                ((current >= 0x10000) && (current <= 0x10FFFF)))
	 	                out.append(current);
	 	        }
	 	        return out.toString();
	 	    }   
	    
	    private String replaceXMLcharPDF(String ch) {
	    	   //   return ch.replaceAll("\"","\\\"").replaceAll("\'","&apos;").replaceAll("&","&amp;").replaceAll("<","&amp;").replaceAll(">","&gt;");

	    	   ch = ch.replaceAll("\"","\\\"");
	    	   ch = ch.replaceAll("\'","&apos;");
	    	   ch = ch.replaceAll("&","&amp;");
	    	   ch = ch.replaceAll("<","&lt;");
	    	   ch = ch.replaceAll(">","&gt;");

	    	   return stripNonValidXMLCharacters(ch);
	    	    }
	    
	    public String replaceXMLchar(String ch) {
	    	   //   return ch.replaceAll("\"","\\\"").replaceAll("\'","&apos;").replaceAll("&","&amp;").replaceAll("<","&amp;").replaceAll(">","&gt;");

	    	   ch = ch.replaceAll("\"","\\\"");
	    	  // ch = ch.replaceAll("\'","&apos;");
	    	   ch = ch.replaceAll("&","&amp;");
	    	   ch = ch.replaceAll("<","&lt;");
	    	   ch = ch.replaceAll(">","&gt;");

	    	   return ch;
	    	    }
	    
	    
	    public List<Map<String, Object>> parseJsonArray(String jso) {
	    	try {
	    		/*if (jso.startsWith("[")) {
	    			jso = jso.substring(1);
	    		}
	    		if (jso.endsWith("]")) {
	    			jso = jso.substring(0,jso.length()-1);
	    		}*/
	    		/*JsonParser jsonParser = new JsonParser();
	            JsonObject jo = (JsonObject)jsonParser.parse(jso);*/
	          //  JsonArray jsonArr = jo.getAsJsonArray("servers");
	            //jsonArr.
	           /* Gson googleJson = new Gson();
	            ArrayList jsonObjList = googleJson.fromJson(jsonArr, ArrayList.class);
	            System.out.println("List size is : "+jsonObjList.size());
	                    System.out.println("List Elements are  : "+jsonObjList.toString());
	    		*/
	            Gson gson = new Gson();
	            List<Map<String, Object>> list = gson.fromJson(jso, new TypeToken<List<Map<String, Object>>>(){}.getType());
	       
	          //  list.forEach(x -> System.out.println(x));
	    	
	    	/*	System.out.println(jso);
	    		Gson gson = new Gson();
	    		
	    		Map<String, Object> map = gson.fromJson(jso, new TypeToken<Map<String, Object>>(){}.getType());*/
	    		
	    		return list;
	    	
	    	}
	    	catch (Exception omi) {
	    		System.out.println("Error: cant parse json array "+omi.toString());
	    		return null;
	    	}
	    
	    }
	    
	    public Map<String, Object> parseJson(String jso) {
	    	try {
	    		System.out.println(jso + " --------------- ");
	    		if (jso.startsWith("[")) {
	    			jso = jso.substring(1);
	    		}
	    		if (jso.endsWith("]")) {
	    			jso = jso.substring(0,jso.length()-1);
	    		}
	    		System.out.println( " ----rrr----------- ");
	    		Gson gson = new Gson();
	    		
	    		Map<String, Object> map = gson.fromJson(jso, new TypeToken<Map<String, Object>>(){}.getType());
	    		
	    		return map;
	    	
	    	}
	    	catch (Exception omi) {
	    		System.out.println("Error: cant parse json  "+omi.toString());
	    		return null;
	    	}
	    
	    }
	    
	    
	    

}
