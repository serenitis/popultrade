package com.popultrade.webapp;


import java.util.Vector;

public class EDItools
 {

  private split splitt = new split();
  ////// zapolnem prazna polja za EDI format file
      public String getEDIFormat(String var,int size) {

        if (var!=null) {

          //// menjam sumnike


        if (var.length()<=size) {
          var = this.menjajSumnike(var);
          for (int g = var.length();g<size;g++) {
            var = var + " ";
          }
          return var;
        }
        else {
          var = this.menjajSumnike(var);
          return var.substring(0,size);
        }
      //  return var;
        }
        else {
          for (int g = var.length();g<size;g++) {
            var = var + " ";
          }
          return var;
        }
      }

/////////// menjam sumnike
      private String menjajSumnike(String postaa) {
    postaa = postaa.replace('š','s');
    postaa = postaa.replace('\u0111','d');
    postaa = postaa.replace('\u010D','c');
    postaa = postaa.replace('\u0107','c');
    postaa = postaa.replace('ž','z');

    postaa = postaa.replace('Š','S');
    postaa = postaa.replace('\u0110','D');
    postaa = postaa.replace('\u010C','C');
    postaa = postaa.replace('\u0106','C');
    postaa = postaa.replace('Ž','Z');
    if (postaa.length()>0) {
      if (postaa.substring(0, 1).equals("*") || postaa.substring(0, 1).equals("+") || postaa.substring(0, 1).equals("#")) {
        postaa = postaa.substring(1, postaa.length());
      }
    }
   // postaa = postaa.replaceAll("&#42","");


        return postaa.toUpperCase();
      }




      ////// formatiram kolicino

      public String getEDINumberFormat(String num) throws Exception {

        if (num!=null && !num.equals("")) {



        Vector vd = new Vector();

        if (num.indexOf(".")!=-1 || num.indexOf(",")!=-1) {
          if (num.indexOf(".")!=-1) {
          vd = splitt.split(num,".");
          }
          if (num.indexOf(",")!=-1) {
          vd = splitt.split(num,",");
          }

          String a="";
          String b="";
          for (int j=vd.get(0).toString().length();j<12;j++) {
            a="0"+a;
          }
          a = a+vd.get(0).toString();
          if (vd.get(1).toString().length()==2) {
            a = a + "."+vd.get(1).toString();
          }
          else if (vd.get(1).toString().length()>2) {
            a = a + "."+vd.get(1).toString().substring(0,2);
          }
          else if (vd.get(1).toString().length()<2) {
            for (int j=vd.get(1).toString().length();j<=2;j++) {
              b = "0"+b;
            }
            b=vd.get(1).toString()+b;
            a = a + "."+b;
          }
          //// v primeru da je kolicina - spremenim 0 z presledki
          if (a.indexOf("-")!=-1) {

            String sp = num.substring(0,num.indexOf("-")-1);
          String sd = num.substring(num.indexOf("-"),num.length());
          for (int g=0;g<=sp.length();g++) {
            sd = " " + sd;
          }
          return sd;
          }
          else {
          return a;
          }
        }

        else {

          for (int j=num.length();j<12;j++) {
            num="0"+num;
          }
          num = num + ".00";
        }
        //// v primeru da je kolicina - spremenim 0 z presledki
        if (num.indexOf("-")!=-1) {
          String sp = num.substring(0,num.indexOf("-")-1);
          String sd = num.substring(num.indexOf("-"),num.length());
          for (int g=0;g<=sp.length();g++) {
            sd = " " + sd;
          }

           return sd;
          }
          else {
          return num;
          }

        }
        else {
          return " ";
        }



      }



    ///// formatiram datum ki dobim iz xmlja za edi format HHMM
    public String getEDIDatum(String dtf,int stev) {
      ///2001-12-17 09:30:47
     if (dtf!=null) {
      Vector ve = splitt.split(dtf," ");
       if (!ve.isEmpty()) {
      Vector ve2 = splitt.split(ve.get(0).toString(),"-");
      String leto= ve2.get(0).toString();
      String mesec = ve2.get(1).toString();
      String dan = ve2.get(2).toString();


      Vector ve3 = splitt.split(ve.get(1).toString(),":");
      String ura1 = ve3.get(0).toString();
      if (ve3.get(0).toString().length()<2) {
        ura1 = "0"+ve3.get(0).toString();
      }
      String min1 = ve3.get(1).toString();
     if (ve3.get(1).toString().length()<2) {
       ura1 = "0"+ve3.get(1).toString();
     }


      return this.getEDIFormat(leto+mesec+dan+ura1+min1,stev);

       }
       else {
        return this.getEDIFormat("",stev);
     }
     }
     else {
       return this.getEDIFormat("",stev);
     }
     }



}
