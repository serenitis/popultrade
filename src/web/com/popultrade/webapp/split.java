package com.popultrade.webapp;



import java.util.*;

public class split  implements java.io.Serializable {

/**
	 * 
	 */
	private static final long serialVersionUID = 3256658754354354551L;

// Strsp = stringa ki jo splita
// sp = string splitter
public synchronized Vector split(String strsp, String sp) {
String chk = "";
String cck = "";
String spp;
Vector vse = new Vector();
//private String[] vse2;
String rez;
int len;
int go = 1;
int ee = 1;
while(ee == 1) {
if (strsp.startsWith(" ")) {
strsp = strsp.substring(1,strsp.length());
}
else {
ee = 2;
}
}

len = strsp.length();

for (int aa = 0; aa < len; aa++) {
int ff = aa + 1;

spp = strsp.substring(aa,ff);

chk = chk + spp;

if (sp.indexOf(spp) != -1) {
cck = cck + spp;
//System.out.println(cck);
if (cck.equals(sp)) {
int gof = 0;
while(gof == 0) {
if (chk.startsWith(" ")) {
chk = chk.substring(1,chk.length());
}
else {
gof =2;
}
}

int dd = chk.indexOf(cck);

rez = chk.substring(0,dd);

vse.add(rez);

chk="";
}
}
else {
cck = "";
}

}
if (chk != "") {
int gof = 0;
while(gof == 0) {
if (chk.startsWith(" ")) {
chk = chk.substring(1,chk.length());
}
else {
gof =2;
}
}
vse.add(chk);
}

//Enumeration vse2 = vse.elements();





return vse;


}



}

