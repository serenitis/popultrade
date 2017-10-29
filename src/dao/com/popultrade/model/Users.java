package com.popultrade.model;

import javax.net.ssl.HttpsURLConnection;
import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Entity
@Table (name="uporabniki")


public class Users extends BaseObject implements Serializable {
	
	private static final long serialVersionUID = 9051055300691532947L;
	private Long id; /// id
	private String username; /// username
	private String geslo;
	private String status; /// status 1-ok, ostalo ne ok
	
	private String ime;
	private String priimek;
	

private String hub;
private Integer kupec;
private String skupina;

	
	
	private String jezik;
	
	private String privilegij;



	
	private Integer frame1;
	private Integer frame2;
	private Integer frame3;
	

	
	private String parameter01;
	
	private String parameter02;
	private String parameter03;
	private String parameter04;
	private String parameter05;
	private String parameter06;
	private String parameter07; /// dropdawn data iz javascript DB (pazi da je tabela izbrana za JS DB)
	private String parameter08; /// certifikat rabi
	private String parameter09; /// rabi load iz sifranta po kliku na potrdi
	private String parameter10;
	
	private Integer kontakti;
	private String e_mail;
	

	
	
	/// certifikati
	
	private String cserial; /// serial number of certifikate
	private Date cdateto; /// expiration date
	private String cinfo; /// info certifikata - CN,C,...
	private String ccert; /// ime certifikata ki kreiram z custom CA
	private String cgeslo; /// geslo za certifikat - public
	
	

	
	
	
	
	
	
	private String pje_sifra;// varchar2(35)


	private String tip;// varchar2(1)
	private String operkre;// varchar2(30) not null
	private Date datkre;// date not null
	private String operspre;// varchar2(30) not null
	private Date datspre;// date not null
	private Integer stevilo_zapisov;// number(3)
	private String tip_detajl;// varchar2(3)
	private String export_format;// varchar2(1)
	private String export_format_desadv;// varchar2(1)
	private String export_format_recadv;// varchar2(1)
	private String export_format_invrpt;// varchar2(1)
	private String export_format_invoic;// varchar2(1)
	private String export_format_vracila;// varchar2(1)
	private String tip_embalaze;// varchar2(21)
	private String pogoj_01;// varchar2(1)
	private String pogoj_02;// varchar2(1)
	private String pogoj_03;// varchar2(1)
	private String pogoj_04;// varchar2(1)
	private String pogoj_05;// varchar2(1)
	private String pogoj_06;// varchar2(1)
	private String pogoj_07;// varchar2(1)
	private String pogoj_08;// varchar2(1)
	private String pogoj_09;// varchar2(1)
	private String pogoj_10;// varchar2(1)
	private String pogoj_11;// varchar2(1)
	private String pogoj_12;// varchar2(1)
	private String pogoj_13;// varchar2(1)
	private String pogoj_14;// varchar2(1)
	private String pogoj_15;// varchar2(1)
	private String pogoj_16;// varchar2(1)
	private String pogoj_17;// varchar2(1)
	private String pogoj_18;// varchar2(1)
	private String pogoj_19;// varchar2(1)
	private String pogoj_20;// varchar2(1)
	private String pogoj_21;// varchar2(1)
	private String pogoj_22;// varchar2(1)
	private String pogoj_23;// varchar2(1)
	private String pogoj_24;// varchar2(1)
	private String pogoj_25;// varchar2(1)
	private String pogoj_26;// varchar2(1)
	private String pogoj_27;// varchar2(1)
	private String pogoj_28;// varchar2(1)
	private String pogoj_29;// varchar2(1)
	private String pogoj_30;// varchar2(1)
	private String pogoj_31;// varchar2(1)
	private String pogoj_32;// varchar2(1)
	private String pogoj_33;// varchar2(1)
	private String pogoj_34;// varchar2(1)
	private String pogoj_35;// varchar2(1)
	private String pogoj_36;// varchar2(1)
	private String pogoj_37;// varchar2(1)
	private String pogoj_38;// varchar2(1)
	private String pogoj_39;// varchar2(1)
	private String pogoj_40;// varchar2(1)


	

	
	
	
	
	
	
	
	
	
	
	


	@Column(name="pje_sifra")
	
	public String getPje_sifra() {
		return pje_sifra;
	}

	public void setPje_sifra(String pje_sifra) {
		this.pje_sifra = pje_sifra;
	}
	

	

	@Column(name="tip")
	
	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}
	

	@Column(name="operkre")
	
	public String getOperkre() {
	
		return operkre;
	}

	public void setOperkre(String operkre) {
		this.operkre = operkre;
	}
	

	@Column(name="datkre")
	
	public Date getDatkre() {
		return datkre;
	}

	public void setDatkre(Date datkre) {
		this.datkre = datkre;
	}
	

	@Column(name="operspre")
	
	public String getOperspre() {
		return operspre;
	}

	public void setOperspre(String operspre) {
		this.operspre = operspre;
	}
	

	@Column(name="datspre")
	
	public Date getDatspre() {
		return datspre;
	}

	public void setDatspre(Date datspre) {
		this.datspre = datspre;
	}
	

	@Column(name="stevilo_zapisov")
	
	public Integer getStevilo_zapisov() {
		return stevilo_zapisov;
	}

	public void setStevilo_zapisov(Integer stevilo_zapisov) {
		this.stevilo_zapisov = stevilo_zapisov;
	}
	

	@Column(name="tip_detajl")
	
	public String getTip_detajl() {
		return tip_detajl;
	}

	public void setTip_detajl(String tip_detajl) {
		this.tip_detajl = tip_detajl;
	}
	

	@Column(name="export_format")
	
	public String getExport_format() {
		return export_format;
	}

	public void setExport_format(String export_format) {
		this.export_format = export_format;
	}
	

	@Column(name="export_format_desadv")
	
	public String getExport_format_desadv() {
		return export_format_desadv;
	}

	public void setExport_format_desadv(String export_format_desadv) {
		this.export_format_desadv = export_format_desadv;
	}
	

	@Column(name="export_format_recadv")
	
	public String getExport_format_recadv() {
		return export_format_recadv;
	}

	public void setExport_format_recadv(String export_format_recadv) {
		this.export_format_recadv = export_format_recadv;
	}
	

	@Column(name="export_format_invrpt")
	
	public String getExport_format_invrpt() {
		return export_format_invrpt;
	}

	public void setExport_format_invrpt(String export_format_invrpt) {
		this.export_format_invrpt = export_format_invrpt;
	}
	

	@Column(name="export_format_invoic")
	
	public String getExport_format_invoic() {
		return export_format_invoic;
	}

	public void setExport_format_invoic(String export_format_invoic) {
		this.export_format_invoic = export_format_invoic;
	}
	

	@Column(name="export_format_vracila")
	
	public String getExport_format_vracila() {
		return export_format_vracila;
	}

	public void setExport_format_vracila(String export_format_vracila) {
		this.export_format_vracila = export_format_vracila;
	}
	

	@Column(name="tip_embalaze")
	
	public String getTip_embalaze() {
		return tip_embalaze;
	}

	public void setTip_embalaze(String tip_embalaze) {
		this.tip_embalaze = tip_embalaze;
	}
	

	@Column(name="pogoj_01")
	
	public String getPogoj_01() {
		return pogoj_01;
	}

	public void setPogoj_01(String pogoj_01) {
		this.pogoj_01 = pogoj_01;
	}
	

	@Column(name="pogoj_02")
	
	public String getPogoj_02() {
		return pogoj_02;
	}

	public void setPogoj_02(String pogoj_02) {
		this.pogoj_02 = pogoj_02;
	}
	

	@Column(name="pogoj_03")
	
	public String getPogoj_03() {
		return pogoj_03;
	}

	public void setPogoj_03(String pogoj_03) {
		this.pogoj_03 = pogoj_03;
	}
	

	@Column(name="pogoj_04")
	
	public String getPogoj_04() {
		return pogoj_04;
	}

	public void setPogoj_04(String pogoj_04) {
		this.pogoj_04 = pogoj_04;
	}
	

	@Column(name="pogoj_05")
	
	public String getPogoj_05() {
		return pogoj_05;
	}

	public void setPogoj_05(String pogoj_05) {
		this.pogoj_05 = pogoj_05;
	}
	

	@Column(name="pogoj_06")
	
	public String getPogoj_06() {
		return pogoj_06;
	}

	public void setPogoj_06(String pogoj_06) {
		this.pogoj_06 = pogoj_06;
	}
	

	@Column(name="pogoj_07")
	
	public String getPogoj_07() {
		return pogoj_07;
	}

	public void setPogoj_07(String pogoj_07) {
		this.pogoj_07 = pogoj_07;
	}
	

	@Column(name="pogoj_08")
	
	public String getPogoj_08() {
		return pogoj_08;
	}

	public void setPogoj_08(String pogoj_08) {
		this.pogoj_08 = pogoj_08;
	}
	

	@Column(name="pogoj_09")
	
	public String getPogoj_09() {
		return pogoj_09;
	}

	public void setPogoj_09(String pogoj_09) {
		this.pogoj_09 = pogoj_09;
	}
	

	@Column(name="pogoj_10")
	
	public String getPogoj_10() {
		return pogoj_10;
	}

	public void setPogoj_10(String pogoj_10) {
		this.pogoj_10 = pogoj_10;
	}
	

	@Column(name="pogoj_11")
	
	public String getPogoj_11() {
		return pogoj_11;
	}

	public void setPogoj_11(String pogoj_11) {
		this.pogoj_11 = pogoj_11;
	}
	

	@Column(name="pogoj_12")
	
	public String getPogoj_12() {
		return pogoj_12;
	}

	public void setPogoj_12(String pogoj_12) {
		this.pogoj_12 = pogoj_12;
	}
	

	@Column(name="pogoj_13")
	
	public String getPogoj_13() {
		return pogoj_13;
	}

	public void setPogoj_13(String pogoj_13) {
		this.pogoj_13 = pogoj_13;
	}
	

	@Column(name="pogoj_14")
	
	public String getPogoj_14() {
		return pogoj_14;
	}

	public void setPogoj_14(String pogoj_14) {
		this.pogoj_14 = pogoj_14;
	}
	

	@Column(name="pogoj_15")
	
	public String getPogoj_15() {
		return pogoj_15;
	}

	public void setPogoj_15(String pogoj_15) {
		this.pogoj_15 = pogoj_15;
	}
	

	@Column(name="pogoj_16")
	
	public String getPogoj_16() {
		return pogoj_16;
	}

	public void setPogoj_16(String pogoj_16) {
		this.pogoj_16 = pogoj_16;
	}
	

	@Column(name="pogoj_17")
	
	public String getPogoj_17() {
		return pogoj_17;
	}

	public void setPogoj_17(String pogoj_17) {
		this.pogoj_17 = pogoj_17;
	}
	

	@Column(name="pogoj_18")
	
	public String getPogoj_18() {
		return pogoj_18;
	}

	public void setPogoj_18(String pogoj_18) {
		this.pogoj_18 = pogoj_18;
	}
	

	@Column(name="pogoj_19")
	
	public String getPogoj_19() {
		return pogoj_19;
	}

	public void setPogoj_19(String pogoj_19) {
		this.pogoj_19 = pogoj_19;
	}
	

	@Column(name="pogoj_20")
	
	public String getPogoj_20() {
		return pogoj_20;
	}

	public void setPogoj_20(String pogoj_20) {
		this.pogoj_20 = pogoj_20;
	}
	

	@Column(name="pogoj_21")
	
	public String getPogoj_21() {
		return pogoj_21;
	}

	public void setPogoj_21(String pogoj_21) {
		this.pogoj_21 = pogoj_21;
	}
	

	@Column(name="pogoj_22")
	
	public String getPogoj_22() {
		return pogoj_22;
	}

	public void setPogoj_22(String pogoj_22) {
		this.pogoj_22 = pogoj_22;
	}
	

	@Column(name="pogoj_23")
	
	public String getPogoj_23() {
		return pogoj_23;
	}

	public void setPogoj_23(String pogoj_23) {
		this.pogoj_23 = pogoj_23;
	}
	

	@Column(name="pogoj_24")
	
	public String getPogoj_24() {
		return pogoj_24;
	}

	public void setPogoj_24(String pogoj_24) {
		this.pogoj_24 = pogoj_24;
	}
	

	@Column(name="pogoj_25")
	
	public String getPogoj_25() {
		return pogoj_25;
	}

	public void setPogoj_25(String pogoj_25) {
		this.pogoj_25 = pogoj_25;
	}
	

	@Column(name="pogoj_26")
	
	public String getPogoj_26() {
		return pogoj_26;
	}

	public void setPogoj_26(String pogoj_26) {
		this.pogoj_26 = pogoj_26;
	}
	

	@Column(name="pogoj_27")
	
	public String getPogoj_27() {
		return pogoj_27;
	}

	public void setPogoj_27(String pogoj_27) {
		this.pogoj_27 = pogoj_27;
	}
	

	@Column(name="pogoj_28")
	
	public String getPogoj_28() {
		return pogoj_28;
	}

	public void setPogoj_28(String pogoj_28) {
		this.pogoj_28 = pogoj_28;
	}
	

	@Column(name="pogoj_29")
	
	public String getPogoj_29() {
		return pogoj_29;
	}

	public void setPogoj_29(String pogoj_29) {
		this.pogoj_29 = pogoj_29;
	}
	

	@Column(name="pogoj_30")
	
	public String getPogoj_30() {
		return pogoj_30;
	}

	public void setPogoj_30(String pogoj_30) {
		this.pogoj_30 = pogoj_30;
	}
	

	@Column(name="pogoj_31")
	
	public String getPogoj_31() {
		return pogoj_31;
	}

	public void setPogoj_31(String pogoj_31) {
		this.pogoj_31 = pogoj_31;
	}
	

	@Column(name="pogoj_32")
	
	public String getPogoj_32() {
		return pogoj_32;
	}

	public void setPogoj_32(String pogoj_32) {
		this.pogoj_32 = pogoj_32;
	}
	

	@Column(name="pogoj_33")
	
	public String getPogoj_33() {
		return pogoj_33;
	}

	public void setPogoj_33(String pogoj_33) {
		this.pogoj_33 = pogoj_33;
	}
	

	@Column(name="pogoj_34")
	
	public String getPogoj_34() {
		return pogoj_34;
	}

	public void setPogoj_34(String pogoj_34) {
		this.pogoj_34 = pogoj_34;
	}
	

	@Column(name="pogoj_35")
	
	public String getPogoj_35() {
		return pogoj_35;
	}

	public void setPogoj_35(String pogoj_35) {
		this.pogoj_35 = pogoj_35;
	}
	

	@Column(name="pogoj_36")
	
	public String getPogoj_36() {
		return pogoj_36;
	}

	public void setPogoj_36(String pogoj_36) {
		this.pogoj_36 = pogoj_36;
	}
	

	@Column(name="pogoj_37")
	
	public String getPogoj_37() {
		return pogoj_37;
	}

	public void setPogoj_37(String pogoj_37) {
		this.pogoj_37 = pogoj_37;
	}
	

	@Column(name="pogoj_38")
	
	public String getPogoj_38() {
		return pogoj_38;
	}

	public void setPogoj_38(String pogoj_38) {
		this.pogoj_38 = pogoj_38;
	}
	

	@Column(name="pogoj_39")
	
	public String getPogoj_39() {
		return pogoj_39;
	}

	public void setPogoj_39(String pogoj_39) {
		this.pogoj_39 = pogoj_39;
	}
	

	@Column(name="pogoj_40")
	
	public String getPogoj_40() {
		return pogoj_40;
	}

	public void setPogoj_40(String pogoj_40) {
		this.pogoj_40 = pogoj_40;
	}

	
	
	

	@Column(name="cgeslo",length=30)
	
	
	public String getCgeslo() {
		return cgeslo;
	}

	public void setCgeslo(String cgeslo) {
		this.cgeslo = cgeslo;
	}

	@Column(name="ccert",length=30)
	
	
	
	public String getCcert() {
		return ccert;
	}

	public void setCcert(String ccert) {
		this.ccert = ccert;
	}

	@Column(name="cserial",length=50)
	

public String getCserial() {
		return cserial;
	}

	public void setCserial(String cserial) {
		this.cserial = cserial;
	}

	
	@Column(name="cdateto")
	public Date getCdateto() {
		return cdateto;
	}

	public void setCdateto(Date cdateto) {
		this.cdateto = cdateto;
	}

	
	@Column(name="cinfo",length=250)
	public String getCinfo() {
		return cinfo;
	}

	public void setCinfo(String cinfo) {
		this.cinfo = cinfo;
	}



@Column(name="kontakti")


	public Integer getKontakti() {
		return kontakti;
	}

	public void setKontakti(Integer kontakti) {
		this.kontakti = kontakti;
	}
@Column(name="e_mail",length=65)

	public String getE_mail() {
		return e_mail;
	}

	public void setE_mail(String e_mail) {
		this.e_mail = e_mail;
	}

@Column(name="hub",length=13)

	
	public String getHub() {
		return hub;
	}

	public void setHub(String hub) {
		this.hub = hub;
	}
@Column(name="kupec",length=1)

	public Integer getKupec() {
		return kupec;
	}

	
	public void setKupec(Integer kupec) {
		this.kupec = kupec;
	}
@Column(name="skupina",length=3)

	public String getSkupina() {
		return skupina;
	}

	public void setSkupina(String skupina) {
		this.skupina = skupina;
	}
	private List usersprivilegijes = new ArrayList();
	
	
	
	private String uporabi_hint_pomoc; /// tekst za pomoc vidi user, 1-ja , 0-ne


@Column(name="uporabi_hint_pomoc",length=1)




	public String getUporabi_hint_pomoc() {
		return uporabi_hint_pomoc;
	}

	public void setUporabi_hint_pomoc(String uporabi_hint_pomoc) {
		this.uporabi_hint_pomoc = uporabi_hint_pomoc;
	}
	
	
	


	



@Column(name="parameter01",length=1)

	public String getParameter01() {
		return parameter01;
	}

	public void setParameter01(String parameter01) {
		this.parameter01 = parameter01;
	}
@Column(name="parameter02",length=1)

	public String getParameter02() {
		return parameter02;
	}

	public void setParameter02(String parameter02) {
		this.parameter02 = parameter02;
	}
@Column(name="parameter03",length=1)

	public String getParameter03() {
		return parameter03;
	}

	public void setParameter03(String parameter03) {
		this.parameter03 = parameter03;
	}
@Column(name="parameter04",length=1)

	public String getParameter04() {
		return parameter04;
	}

	public void setParameter04(String parameter04) {
		this.parameter04 = parameter04;
	}
@Column(name="parameter05",length=1)

	public String getParameter05() {
		return parameter05;
	}

	public void setParameter05(String parameter05) {
		this.parameter05 = parameter05;
	}
@Column(name="parameter06",length=1)

	public String getParameter06() {
		return parameter06;
	}

	public void setParameter06(String parameter06) {
		this.parameter06 = parameter06;
	}
@Column(name="parameter07",length=1)

	public String getParameter07() {
		return parameter07;
	}

	public void setParameter07(String parameter07) {
		this.parameter07 = parameter07;
	}
@Column(name="parameter08",length=1)

	public String getParameter08() {
		return parameter08;
	}

	public void setParameter08(String parameter08) {
		this.parameter08 = parameter08;
	}
@Column(name="parameter09",length=1)

	public String getParameter09() {
		return parameter09;
	}

	public void setParameter09(String parameter09) {
		this.parameter09 = parameter09;
	}
@Column(name="parameter10",length=1)

	public String getParameter10() {
		return parameter10;
	}

	public void setParameter10(String parameter10) {
		this.parameter10 = parameter10;
	}



	
	
	
@Column(name="frame1")

	
	public Integer getFrame1() {
		return frame1;
	}
	public void setFrame1(Integer frame1) {
		this.frame1 = frame1;
	}
	
@Column(name="frame2")

	public Integer getFrame2() {
		return frame2;
	}
	public void setFrame2(Integer frame2) {
		this.frame2 = frame2;
	}
	
@Column(name="frame3")

	public Integer getFrame3() {
		return frame3;
	}
	public void setFrame3(Integer frame3) {
		this.frame3 = frame3;
	}
@Column(name="ime",length=35)

	
	public String getIme() {
		return ime;
	}
	public void setIme(String ime) {
		this.ime = ime;
	}
	
@Column(name="priimek",length=35)

	public String getPriimek() {
		return priimek;
	}
	public void setPriimek(String priimek) {
		this.priimek = priimek;
	}
	
	


	

@Column(name="privilegij",length=1,nullable=true)

	public String getPrivilegij() {
		return privilegij;
	}
	public void setPrivilegij(String privilegij) {
		this.privilegij = privilegij;
	}
	
	
@Index(name="jezik")
@Column(name="jezik",length=2,nullable=true)

	
	public String getJezik() {
		return jezik;
	}
	public void setJezik(String jezik) {
		this.jezik = jezik;
	}
	
@Id
@Column(name="id")
@SequenceGenerator(name="template_seq",allocationSize=1, sequenceName="template_seq")
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="template_seq")


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
@Index(name="uporabnik")
@Column(name="uporabnik",length=15,nullable=true)

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
@Index(name="geslo")
@Column(name="geslo",length=12,nullable=true)

	public String getGeslo() {
		return geslo;
	}
	public void setGeslo(String geslo) {
		this.geslo = geslo;
	}
	
@Index(name="status")
@Column(name="status",length=1)

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((geslo == null) ? 0 : geslo.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((jezik == null) ? 0 : jezik.hashCode());
		result = prime * result
				+ ((privilegij == null) ? 0 : privilegij.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		Users other = (Users) obj;
	
		if (geslo == null) {
			if (other.geslo != null)
				return false;
		} else if (!geslo.equals(other.geslo))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (jezik == null) {
			if (other.jezik != null)
				return false;
		} else if (!jezik.equals(other.jezik))
			return false;
		if (privilegij == null) {
			if (other.privilegij != null)
				return false;
		} else if (!privilegij.equals(other.privilegij))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}
	
	
	
	
	

}
