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
@Table (name="templatefunkcija")


public class TemplateFunkcija extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = -9086132786110266786L;
	private Long id;
	
	private String ime_pogoja; /// ime funkcije oz metode v model clasi
	private String vrednost_pogoja; /// vrednost metode, lahko dobim iz konstant pri logu ali vpise z roko
	private String opis_pogoja; /// kratek opis pogoja
	/////////// spodaj velja za izdelavo pogojev
	private String tip_pogoja; /// tip pogoja, vecje , manjse, enako, ni enako
	private Integer zaporedje;
	
	private String vezani_pogoj; /// ce gre za vezani pogoj (and ali or)
	private Long templatefunkcija_id; /// pogoj vezan na ze obstojeci templaye funkcija preko vezani pogoj
	private String predpona_pogoja; /// if , else if, else
	private String sestavljeni_pogoj; /// v primeru , ce se pogoj sestavi s pomocjo web template
	private String dodaten_hql_pogoj; /// vpisem pogoj v obliki HQL, doda se po where stavku
	
	
	
	private String tip_funkcije; /// tip funkcije , update, insert, list, ena-ena --- ne uporabljam za zdaj
	
	
	
@Column(name="tip_funkcije",length=2)

	public String getTip_funkcije() {
		return tip_funkcije;
	}
	public void setTip_funkcije(String tip_funkcije) {
		this.tip_funkcije = tip_funkcije;
	}
@Column(name="zaporedje")

	
	public Integer getZaporedje() {
		return zaporedje;
	}
	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
	}
@Column(name="dodaten_hql_pogoj",length=500)

	public String getDodaten_hql_pogoj() {
		return dodaten_hql_pogoj;
	}
	public void setDodaten_hql_pogoj(String dodaten_hql_pogoj) {
		this.dodaten_hql_pogoj = dodaten_hql_pogoj;
	}
@Column(name="predpona_pogoja",length=10)

	public String getPredpona_pogoja() {
		return predpona_pogoja;
	}
	public void setPredpona_pogoja(String predpona_pogoja) {
		this.predpona_pogoja = predpona_pogoja;
	}
	
@Column(name="sestavljeni_pogoj",length=250)

	public String getSestavljeni_pogoj() {
		return sestavljeni_pogoj;
	}
	public void setSestavljeni_pogoj(String sestavljeni_pogoj) {
		this.sestavljeni_pogoj = sestavljeni_pogoj;
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
	
	
	
	
	
@Column(name="ime_pogoja",length=55)

	public String getIme_pogoja() {
		return ime_pogoja;
	}
	public void setIme_pogoja(String ime_pogoja) {
		this.ime_pogoja = ime_pogoja;
	}
	
	
@Column(name="vrednost_pogoja",length=250)

	public String getVrednost_pogoja() {
		return vrednost_pogoja;
	}
	public void setVrednost_pogoja(String vrednost_pogoja) {
		this.vrednost_pogoja = vrednost_pogoja;
	}
	
	
	
@Column(name="opis_pogoja",length=70)

	public String getOpis_pogoja() {
		return opis_pogoja;
	}
	public void setOpis_pogoja(String opis_pogoja) {
		this.opis_pogoja = opis_pogoja;
	}
	
	
@Column(name="tip_pogoja",length=2)

	public String getTip_pogoja() {
		return tip_pogoja;
	}
	public void setTip_pogoja(String tip_pogoja) {
		this.tip_pogoja = tip_pogoja;
	}
	
@Column(name="vezani_pogoj",length=1)

	public String getVezani_pogoj() {
		return vezani_pogoj;
	}
	public void setVezani_pogoj(String vezani_pogoj) {
		this.vezani_pogoj = vezani_pogoj;
	}
	
	
@Index(name="templatefunkcija_id")
@Column(name="templatefunkcija_id")

	public Long getTemplatefunkcija_id() {
		return templatefunkcija_id;
	}
	public void setTemplatefunkcija_id(Long templatefunkcija_id) {
		this.templatefunkcija_id = templatefunkcija_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((ime_pogoja == null) ? 0 : ime_pogoja.hashCode());
		result = prime * result
				+ ((opis_pogoja == null) ? 0 : opis_pogoja.hashCode());
		result = prime * result
				+ ((predpona_pogoja == null) ? 0 : predpona_pogoja.hashCode());
	
		result = prime * result
				+ ((vezani_pogoj == null) ? 0 : vezani_pogoj.hashCode());
		result = prime * result
				+ ((vrednost_pogoja == null) ? 0 : vrednost_pogoja.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateFunkcija other = (TemplateFunkcija) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (ime_pogoja == null) {
			if (other.ime_pogoja != null)
				return false;
		} else if (!ime_pogoja.equals(other.ime_pogoja))
			return false;
		if (opis_pogoja == null) {
			if (other.opis_pogoja != null)
				return false;
		} else if (!opis_pogoja.equals(other.opis_pogoja))
			return false;
		if (predpona_pogoja == null) {
			if (other.predpona_pogoja != null)
				return false;
		} else if (!predpona_pogoja.equals(other.predpona_pogoja))
			return false;
		if (sestavljeni_pogoj == null) {
			if (other.sestavljeni_pogoj != null)
				return false;
		} else if (!sestavljeni_pogoj.equals(other.sestavljeni_pogoj))
			return false;
		if (tip_pogoja == null) {
			if (other.tip_pogoja != null)
				return false;
		} else if (!tip_pogoja.equals(other.tip_pogoja))
			return false;
		if (vezani_pogoj == null) {
			if (other.vezani_pogoj != null)
				return false;
		} else if (!vezani_pogoj.equals(other.vezani_pogoj))
			return false;
		if (vrednost_pogoja == null) {
			if (other.vrednost_pogoja != null)
				return false;
		} else if (!vrednost_pogoja.equals(other.vrednost_pogoja))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	

}
