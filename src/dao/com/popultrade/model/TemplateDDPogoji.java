package com.popultrade.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.*;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;


@Entity
@Table (name="templateddpogoji")


public class TemplateDDPogoji extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 2456789807654355441L;
	private Long id;
	private String ime_metode; /// ime metode
	private String vrednost_metode; /// vrednost metode 
	
	private String rezultat_metode; /// rezultat, ki dam v ime_metode ko zberem iz dropdown
	private Long templatedd_id;
	
	private String prikazi_vrednost; /// prikazem kot vrednost pri drop down opciji
	private Integer zaporedje;
	
	
	private String tip; /// tip metode , pogoji ali vrednosti (p,v)
	
	private String vrednost_fiksna; /// je vrednost fiksna ali jo dobim iz forme
	
	private String pogoj_uporabe; /// if pogoji za uporabo pogoja, napise se tudi if () razen zaklepaja }
	
	private String posreduj_vrednost; /// posredujem kot vrednost
	
	
	
	
	private String uporabi_format_vrednost; /// uporabim java format vrednosti
	private String format_vrednost; /// format vrednosti v javi metoda ima prefix (vsebx.[metoda ime])
	
	
	private String uporabi_kontrola_vrednost; /// uporabi kontrolo vrednosti, ce je obkljukano prenese vrednost le ce text field nima vrednosti
	
	
	private Long id_nad; /// veza na templatepppogoji id za or opcije
	
	
	
	
	
	
	
	
@Column(name="uporabi_kontrola_vrednost",length=1)

	
	
	
	
	public String getUporabi_kontrola_vrednost() {
		return uporabi_kontrola_vrednost;
	}
	public void setUporabi_kontrola_vrednost(String uporabi_kontrola_vrednost) {
		this.uporabi_kontrola_vrednost = uporabi_kontrola_vrednost;
	}
@Column(name="uporabi_format_vrednost",length=1)

	
	public String getUporabi_format_vrednost() {
		return uporabi_format_vrednost;
	}
	public void setUporabi_format_vrednost(String uporabi_format_vrednost) {
		this.uporabi_format_vrednost = uporabi_format_vrednost;
	}
	
@Column(name="format_vrednost")

	public String getFormat_vrednost() {
		return format_vrednost;
	}
	public void setFormat_vrednost(String format_vrednost) {
		this.format_vrednost = format_vrednost;
	}
@Column(name="posreduj_vrednost",length=1)

	
	public String getPosreduj_vrednost() {
		return posreduj_vrednost;
	}
	public void setPosreduj_vrednost(String posreduj_vrednost) {
		this.posreduj_vrednost = posreduj_vrednost;
	}
@Column(name="pogoj_uporabe",length=500)

	
	public String getPogoj_uporabe() {
		return pogoj_uporabe;
	}
	public void setPogoj_uporabe(String pogoj_uporabe) {
		this.pogoj_uporabe = pogoj_uporabe;
	}
@Column(name="vrednost_fiksna",length=1)

	public String getVrednost_fiksna() {
		return vrednost_fiksna;
	}
	public void setVrednost_fiksna(String vrednost_fiksna) {
		this.vrednost_fiksna = vrednost_fiksna;
	}
@Column(name="prikazi_vrednost",length=1)

	
	
	public String getPrikazi_vrednost() {
		return prikazi_vrednost;
	}
	public void setPrikazi_vrednost(String prikazi_vrednost) {
		this.prikazi_vrednost = prikazi_vrednost;
	}
	
@Column(name="zaporedje")

	public Integer getZaporedje() {
		return zaporedje;
	}
	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
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
	
	
	
@Column(name="ime_metode",length=55)

	public String getIme_metode() {
		return ime_metode;
	}
	public void setIme_metode(String ime_metode) {
		this.ime_metode = ime_metode;
	}
	
@Column(name="vrednost_metode",length=250)

	public String getVrednost_metode() {
		return vrednost_metode;
	}
	public void setVrednost_metode(String vrednost_metode) {
		this.vrednost_metode = vrednost_metode;
	}
	
	
@Column(name="rezultat_metode",length=55)

	public String getRezultat_metode() {
		return rezultat_metode;
	}
	public void setRezultat_metode(String rezultat_metode) {
		this.rezultat_metode = rezultat_metode;
	}
	
	
@Index(name="templatedd_id")
@Column(name="templatedd_id")

	public Long getTemplatedd_id() {
		return templatedd_id;
	}
	public void setTemplatedd_id(Long templatedd_id) {
		this.templatedd_id = templatedd_id;
	}
	
	
@Column(name="tip",length=1)

	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((ime_metode == null) ? 0 : ime_metode.hashCode());
		result = prime * result
				+ ((rezultat_metode == null) ? 0 : rezultat_metode.hashCode());
		result = prime * result
				+ ((templatedd_id == null) ? 0 : templatedd_id.hashCode());
		result = prime * result + ((tip == null) ? 0 : tip.hashCode());
		result = prime * result
				+ ((vrednost_metode == null) ? 0 : vrednost_metode.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateDDPogoji other = (TemplateDDPogoji) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (ime_metode == null) {
			if (other.ime_metode != null)
				return false;
		} else if (!ime_metode.equals(other.ime_metode))
			return false;
		if (rezultat_metode == null) {
			if (other.rezultat_metode != null)
				return false;
		} else if (!rezultat_metode.equals(other.rezultat_metode))
			return false;
		if (templatedd_id == null) {
			if (other.templatedd_id != null)
				return false;
		} else if (!templatedd_id.equals(other.templatedd_id))
			return false;
		if (tip == null) {
			if (other.tip != null)
				return false;
		} else if (!tip.equals(other.tip))
			return false;
		if (vrednost_metode == null) {
			if (other.vrednost_metode != null)
				return false;
		} else if (!vrednost_metode.equals(other.vrednost_metode))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
