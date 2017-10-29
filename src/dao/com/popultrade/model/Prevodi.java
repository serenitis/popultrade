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
@Table (name="prevodi")


public class Prevodi extends BaseObject implements Serializable {
	
	private static final long serialVersionUID = 7144204881323370353L;
	private Long id;
	private Long prevod_id; /// id od kjer koli iz template za prevod
	private String sifra_jez; /// sifra jezika
	private String prevod; /// prevod za izbrani jezik
	private String vrsta; /// H-hint, P- je navaden prevod
	
@Index(name="vrsta")
@Column(name="vrsta",length=1,nullable=true)

	public String getVrsta() {
		return vrsta;
	}
	public void setVrsta(String vrsta) {
		this.vrsta = vrsta;
	}
@Id
@Column(name="id")
@SequenceGenerator(name="prevodi_seq",allocationSize=1, sequenceName="prevodi_seq")
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="prevodi_seq")


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
@Index(name="prevod_id")
@Column(name="prevod_id")

	public Long getPrevod_id() {
		return prevod_id;
	}
	public void setPrevod_id(Long prevod_id) {
		this.prevod_id = prevod_id;
	}
	
	
@Index(name="sifra_jezik")
@Column(name="sifra_jezik",length=2,nullable=true)

	public String getSifra_jez() {
		return sifra_jez;
	}
	public void setSifra_jez(String sifra_jez) {
		this.sifra_jez = sifra_jez;
	}
	
	
@Column(name="prevod",length=250)

	public String getPrevod() {
		return prevod;
	}
	public void setPrevod(String prevod) {
		this.prevod = prevod;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((prevod == null) ? 0 : prevod.hashCode());
		result = prime * result
				+ ((prevod_id == null) ? 0 : prevod_id.hashCode());
		result = prime * result
				+ ((sifra_jez == null) ? 0 : sifra_jez.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		Prevodi other = (Prevodi) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (prevod == null) {
			if (other.prevod != null)
				return false;
		} else if (!prevod.equals(other.prevod))
			return false;
		if (prevod_id == null) {
			if (other.prevod_id != null)
				return false;
		} else if (!prevod_id.equals(other.prevod_id))
			return false;
		if (sifra_jez == null) {
			if (other.sifra_jez != null)
				return false;
		} else if (!sifra_jez.equals(other.sifra_jez))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	

}
