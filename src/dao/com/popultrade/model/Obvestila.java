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
import java.util.Date;


@Entity
@Table (name="obvestila")


public class Obvestila extends BaseObject implements Serializable {

	private static final long serialVersionUID = -482846479696873717L;
	private Long id;
	private String naslov_tekst;
	private String vsebina_tekst;
	private Date datum_v_od;
	private Date datum_v_do;
	private String status;
	private String usp_oznnar; /// veza na podjetje
	private String dzv_ozndrz;
	private String jzk_sifra_jezik;
	
	private Date datkre;
	
	private byte[] blobb;
	
	
	
	
	
	
@Column(name="blobb")

	
	public byte[] getBlobb() {
		
		//byte[] b = new byte[]{1,2};
		
		
		return blobb;
	
	}
	public void setBlobb(byte[] blobb) {
		
		 
		this.blobb = blobb;
	
	}    
		    
		    
@Column(name="datkre")

	public Date getDatkre() {
		return datkre;
	}
	public void setDatkre(Date datkre) {
		this.datkre = datkre;
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
	
	
@Column(name="naslov_tekst",length=250,nullable=true)

	public String getNaslov_tekst() {
		return naslov_tekst;
	}
	public void setNaslov_tekst(String naslov_tekst) {
		this.naslov_tekst = naslov_tekst;
	}
	
@Column(name="vsebina_tekst",nullable=true)

	public String getVsebina_tekst() {
		return vsebina_tekst;
	}
	public void setVsebina_tekst(String vsebina_tekst) {
		this.vsebina_tekst = vsebina_tekst;
	}
	
@Column(name="datum_v_od")

	public Date getDatum_v_od() {
		return datum_v_od;
	}
	public void setDatum_v_od(Date datum_v_od) {
		this.datum_v_od = datum_v_od;
	}
	
@Column(name="datum_v_do")

	public Date getDatum_v_do() {
		return datum_v_do;
	}
	public void setDatum_v_do(Date datum_v_do) {
		this.datum_v_do = datum_v_do;
	}
	
@Column(name="status",length=1)

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
@Column(name="usp_oznnar",length=4)

	public String getUsp_oznnar() {
		return usp_oznnar;
	}
	public void setUsp_oznnar(String usp_oznnar) {
		this.usp_oznnar = usp_oznnar;
	}
	
@Column(name="dzv_ozndrz",length=3,nullable=true)

	public String getDzv_ozndrz() {
		return dzv_ozndrz;
	}
	public void setDzv_ozndrz(String dzv_ozndrz) {
		this.dzv_ozndrz = dzv_ozndrz;
	}
	
	
	
@Column(name="jzk_sifra_jezik",length=2,nullable=true)

	public String getJzk_sifra_jezik() {
		return jzk_sifra_jezik;
	}
	public void setJzk_sifra_jezik(String jzk_sifra_jezik) {
		this.jzk_sifra_jezik = jzk_sifra_jezik;
	}
	
	
	
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((datum_v_do == null) ? 0 : datum_v_do.hashCode());
		result = prime * result
				+ ((datum_v_od == null) ? 0 : datum_v_od.hashCode());
		result = prime * result
				+ ((dzv_ozndrz == null) ? 0 : dzv_ozndrz.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((jzk_sifra_jezik == null) ? 0 : jzk_sifra_jezik.hashCode());
		result = prime * result
				+ ((naslov_tekst == null) ? 0 : naslov_tekst.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result
				+ ((usp_oznnar == null) ? 0 : usp_oznnar.hashCode());
		result = prime * result
				+ ((vsebina_tekst == null) ? 0 : vsebina_tekst.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		Obvestila other = (Obvestila) obj;
		if (datum_v_do == null) {
			if (other.datum_v_do != null)
				return false;
		} else if (!datum_v_do.equals(other.datum_v_do))
			return false;
		if (datum_v_od == null) {
			if (other.datum_v_od != null)
				return false;
		} else if (!datum_v_od.equals(other.datum_v_od))
			return false;
		if (dzv_ozndrz == null) {
			if (other.dzv_ozndrz != null)
				return false;
		} else if (!dzv_ozndrz.equals(other.dzv_ozndrz))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (jzk_sifra_jezik == null) {
			if (other.jzk_sifra_jezik != null)
				return false;
		} else if (!jzk_sifra_jezik.equals(other.jzk_sifra_jezik))
			return false;
		if (naslov_tekst == null) {
			if (other.naslov_tekst != null)
				return false;
		} else if (!naslov_tekst.equals(other.naslov_tekst))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (usp_oznnar == null) {
			if (other.usp_oznnar != null)
				return false;
		} else if (!usp_oznnar.equals(other.usp_oznnar))
			return false;
		if (vsebina_tekst == null) {
			if (other.vsebina_tekst != null)
				return false;
		} else if (!vsebina_tekst.equals(other.vsebina_tekst))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
}
