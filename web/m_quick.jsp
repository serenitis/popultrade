<%@page import="com.popultrade.dao.WsedogodkiDAO"%>
<%@page import="com.popultrade.dao.WseorganizacijskeenoteDAO"%>
<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<jsp:useBean id="parametrii" scope="session" class="com.popultrade.webapp.Parametri" />


<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="m_loginu.html"/><%
}



boolean bok = false;



try {












	com.popultrade.dao.WsepodjetjaDAO dao = (com.popultrade.dao.WsepodjetjaDAO)contextUtil.getBeanDao("wsepodjetjaDAO",pageContext.getServletContext());

////// dodatek novega userja
com.popultrade.model.Wsepodjetja wpod =new com.popultrade.model.Wsepodjetja();

if (request.getParameter("opcijai")!=null && request.getParameter("opcijai").equals("new")) {

wpod.setSifra(request.getParameter("ean"));

List lio = dao.getWsepodjetjas(wpod, 1, 1, "", "","");

if (lio.size()>0) {
	//wpod = (com.popultrade.model.Wsepodjetja)lio.get(0);

	throw new Exception("Error company found!");
}

  ////// controliram ce ye obstaja
//String chk = "select sifra from wse_podjetja where sifra='"+request.getParameter("ean")+"' ";
//sta = con.prepareStatement(chk);*/

//sta.setString(2,request.getParameter("low"));

//ResultSet rsd = sta.executeQuery();


if (true) {


/*	com.popultrade.dao.Wse_osebeDAO daoo = (com.popultrade.dao.Wse_osebeDAO)contextUtil.getBeanDao("wseosebeDAO",pageContext.getServletContext());

//////dodatek novega userja
com.popultrade.model.Wsepodjetja wpod =new com.popultrade.model.Wsepodjetja();
	
  String sels = "select max(id) from wse_osebe ";

rsd=dbConnect.queryString(sels, con);
int as = 1;
if (rsd.next()) {
as = rsd.getInt(1)+1;
}*/
//// controliram ce ye obstaja


	com.popultrade.dao.UsersDAO daou = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());

com.popultrade.model.Users user =new com.popultrade.model.Users();

List usere = daou.getUserss(user, 1, 1, "upper(username) like upper('"+request.getParameter("user")+"')","","");


/*

chk = "select * from wse_uporabniki where ime=?  ";
sta = con.prepareStatement(chk);
sta.setString(1,nul.jeNull(request.getParameter("user")));


  rsd = sta.executeQuery();*/
  
 
  if (usere.size()>0) {
	  throw new Exception("User with selected username already exists!");
  }
   
  
  if (true) {

  bok = false;



 // String inh = "insert into wse_podjetja (jik_sifra,tip,direktorij,direktorij_k,opis,popr_kolicin,sor_posilja,for_posilja,desadv_posilja,for_popravlja,recadv_posilja,
	//	  dostava_post,sifra,tekst,shrani_cene,vla_sifra,dza_sifra,papirnata_desadv,vpis_st_desadv) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'SIT',?,?,?)";
//System.out.println(inh);
//sta = con.prepareStatement(inh);


wpod.setJik_sifra(request.getParameter("jik_sifra"));
wpod.setTip("D");
wpod.setDirektorij("D:\\WEBSER\\"+request.getParameter("ean"));
wpod.setDirektorij_k("L:\\"+request.getParameter("ean"));
wpod.setOpis(request.getParameter("naziv"));
wpod.setPopr_kolicin("D");
wpod.setSor_posilja("N");
wpod.setFor_posilja("D");
wpod.setDesadv_posilja("N");
wpod.setFor_popravlja("N");
wpod.setRecadv_posilja("N");
wpod.setDostava_post("N");
wpod.setSifra(request.getParameter("ean"));
wpod.setTekst(request.getParameter("tekst"));
wpod.setShrani_cene("N");
wpod.setVla_sifra("SIT");
wpod.setDza_sifra(Integer.parseInt(request.getParameter("dza_sifra")));
wpod.setPapirnata_desadv("D");
wpod.setVpis_st_desadv("D");

dao.saveWsepodjetja(wpod);

/*
sta.setString(1,request.getParameter("jik_sifra"));
sta.setString(2,"D");

sta.setString(3,"D:\\WEBSER\\"+request.getParameter("ean"));
sta.setString(4,"L:\\"+request.getParameter("ean"));

sta.setString(5,request.getParameter("naziv"));

sta.setString(6,"D");
sta.setString(7,"N");
sta.setString(8,"D");
sta.setString(9,"N");
sta.setString(10,"N");
sta.setString(11,"N");
sta.setString(12,"N");
sta.setString(13,request.getParameter("ean"));
sta.setString(14,request.getParameter("tekst"));
sta.setString(15,"N");
sta.setString(16,request.getParameter("dza_sifra"));
sta.setString(17,"D"); 
sta.setString(18,"D"); 
sta.execute();
sta.close();*/

////////// insertam v wse_org_enote



	WseorganizacijskeenoteDAO daoorg = (com.popultrade.dao.WseorganizacijskeenoteDAO)contextUtil.getBeanDao("wseorganizacijskeenoteDAO",pageContext.getServletContext());
com.popultrade.model.Wseorganizacijskeenote worg =new com.popultrade.model.Wseorganizacijskeenote();
worg.setSifra(request.getParameter("ean"));
worg.setPje_sifra(request.getParameter("ean"));
worg.setOpis(request.getParameter("naziv"));
worg.setProgram_aktiven("D");
daoorg.saveWseorganizacijskeenote(worg);


//inh = "insert into wse_organizacijske_enote (sifra,pje_sifra,opis,program_aktiven) values (?,?,?,?)";



/*
sta = con.prepareStatement(inh);

sta.setString(1,request.getParameter("ean"));
sta.setString(2,request.getParameter("ean"));

sta.setString(3,request.getParameter("naziv"));
sta.setString(4,"D");





sta.execute();
sta.close();

*/


com.popultrade.dao.WsekupcidobaviteljiDAO daokup= (com.popultrade.dao.WsekupcidobaviteljiDAO)contextUtil.getBeanDao("wsekupcidobaviteljiDAO",pageContext.getServletContext());
com.popultrade.model.Wsekupcidobavitelji wkup =new com.popultrade.model.Wsekupcidobavitelji();

wkup.setPje_sifra_k("3838606900014");
wkup.setPje_sifra_d(request.getParameter("ean"));
wkup.setPopr_kolicin("D");

daokup.saveWsekupcidobavitelji(wkup);


/*
inh = "insert into wse_kupci_dobavitelji (pje_sifra_k,pje_sifra_d,popr_kolicin) values ('3838606900014','"+request.getParameter("ean")+"','D')";
sta = con.prepareStatement(inh);
sta.execute();
sta.close();
*/

///////////////// user vnos



/*
inh = "insert into wse_osebe (ime,priimek,id) values(?,?,?)";
sta = con.prepareStatement(inh);
sta.setString(1,request.getParameter("user") +" / " +request.getParameter("ean"));
sta.setString(2,request.getParameter("naziv"));
sta.setString(3,as+"");
sta.execute();
sta.close();*/


/*

inh = "insert into wse_uporabniki (ime,aja_ime,jik_sifra,geslo,tip,osa_id,stevilo_zapisov,pogoj_01, pogoj_02, pogoj_03, pogoj_04, pogoj_07, pogoj_11, pogoj_12, pogoj_13 ,pogoj_14,
pogoj_15,pogoj_16,pogoj_17,tip_detalj,export_format,pogoj_32,pogoj_33,pogoj_34,pogoj_35) values(?,?,?,?,?,?,25,'D','D','D','D','D','D','D','N','N','D','D','D','BT','1','D','N',
		'N','N')";
System.out.println(inh);
sta = con.prepareStatement(inh);

sta.setString(1,request.getParameter("user"));
sta.setString(2,"WSE");
sta.setString(3,request.getParameter("jik_sifra"));
sta.setString(4,request.getParameter("geslo"));
sta.setString(5,"M");
sta.setString(6,as+"");


sta.execute();
sta.close();
*/

com.popultrade.dao.UsersDAO daouse= (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
com.popultrade.model.Users wuse =new com.popultrade.model.Users();

wuse.setUsername(request.getParameter("user"));
wuse.setJezik(request.getParameter("jik_sifra"));
wuse.setGeslo(request.getParameter("geslo"));
wuse.setTip("M");
wuse.setStevilo_zapisov(25);
wuse.setPogoj_01("D");
wuse.setPogoj_02("D");
wuse.setPogoj_03("D");
wuse.setPogoj_04("D");
/*wuse.setPogoj_05("D");
wuse.setPogoj_06("D");*/
wuse.setPogoj_07("D");
//wuse.setPogoj_08("N");
//wuse.setPogoj_09("N");
//wuse.setPogoj_10("D");
wuse.setPogoj_11("D");
wuse.setPogoj_12("D");
wuse.setPogoj_13("N");
wuse.setPogoj_14("N");
wuse.setPogoj_15("D");
wuse.setPogoj_16("D");
wuse.setPogoj_17("D");
wuse.setTip_detajl("BT");
wuse.setExport_format("1");
wuse.setPogoj_32("D");
wuse.setPogoj_33("N");
wuse.setPogoj_34("N");
wuse.setPogoj_35("N");

daouse.saveUsers(wuse);




WsedogodkiDAO daodog= (com.popultrade.dao.WsedogodkiDAO)contextUtil.getBeanDao("wsedogodkiDAO",pageContext.getServletContext());
com.popultrade.model.Wsedogodki wdog =new com.popultrade.model.Wsedogodki();
com.popultrade.model.Wsedogodki wdog2 =new com.popultrade.model.Wsedogodki();

////////// vnos programa user
/*
inh = "insert into wse_uporabniki_org_enote (uik_ime,oea_sifra) values ('"+request.getParameter("user")+"','"+request.getParameter("ean")+"')";
System.out.println(inh);
sta = con.prepareStatement(inh);
sta.execute();
sta.close();*/

wdog.setVda_sifra("DESADV");
wdog.setAkcija("IZDELAVA DOBAVNICE");
wdog.setPje_sifra(request.getParameter("ean"));
daodog.saveWsedogodki(wdog);

///// vnos dokumentov
/*
inh = "insert into wse_dogodki (vda_sifra,akcija,pje_sifra) values(?,?,?)";
System.out.println(inh);
sta = con.prepareStatement(inh);

sta.setString(1,"DESADV");
sta.setString(2,"IZDELAVA DOBAVNICE");
sta.setString(3,request.getParameter("ean"));
sta.execute();
sta.close();*/

wdog2.setVda_sifra("ORDRSP");
wdog2.setAkcija("ODGOVOR NA NARO\u010CILO");
wdog2.setPje_sifra(request.getParameter("ean"));
daodog.saveWsedogodki(wdog2);
/*
sta = con.prepareStatement(inh);
sta.setString(1,"ORDRSP");
sta.setString(2,"ODGOVOR NA NARO\u010CILO");
sta.setString(3,request.getParameter("ean"));
sta.execute();
sta.close();*/

/*
com.popultrade.dao. daouse= (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
com.popultrade.model.Users wuse =new com.popultrade.model.Users();
*/
/*

String tes = "select * from wse_ean_podjetja where koda='"+request.getParameter("ean")+"' and rownum<2";
sta = con.prepareStatement(tes);
ResultSet rs3 = sta.executeQuery();
if (!rs3.next()) {
  rs3.close();
sta.close();

tes = "insert into wse_ean_podjetja (koda,opis) values (?,?)";
sta = con.prepareStatement(tes);

sta.setString(1,request.getParameter("ean"));
sta.setString(2,nul.jeNull(request.getParameter("naziv")));
sta.execute();

System.out.println("Insert new in wse_ean_podjetja");
sta.close();
}


  con.commit();
  con.setAutoCommit(true);*/

}
}
else {
bok=true;
}


}







%>

<%

  }
catch (Exception ex) {
  System.out.println(ex.toString());

bok=false;
}

%>
<html>
<head>
<title>
spreminjaj
</title>
</head>
<script language='javascript' src='popcalendar.js'></script>

<script language='javascript' src='datum2.js' ></script>
<script language=javascript>
<%
if (bok) {
%>


window.alert("Dodan uporabnik ali podjetje ze obstaja! Uporabnik ni bil dodan!");


<%
}
%>

function dow() {
  parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}

</script>


