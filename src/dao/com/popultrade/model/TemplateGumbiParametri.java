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
@Table (name="templategumbiparametri")


public class TemplateGumbiParametri extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 1098735432345346566L;
	private Long id;
	private Long templategumb_id;
	private String stolpec_metoda; /// metoda, ki vrne parameter, ki se poslje v novi fame s pritiskom na gumb
	private String dugacno_ime_parametra; /// drugacno ime parametra, npr, ce posljem id parenta na child in child ima tudi isto ime parametra
	
	
	
@Column(name="dugacno_ime_parametra",length=55)

	public String getDugacno_ime_parametra() {
		return dugacno_ime_parametra;
	}
	public void setDugacno_ime_parametra(String dugacno_ime_parametra) {
		this.dugacno_ime_parametra = dugacno_ime_parametra;
	}
@Index(name="templategumb_id")
@Column(name="templategumb_id")

	
	public Long getTemplategumb_id() {
		return templategumb_id;
	}
	public void setTemplategumb_id(Long templategumb_id) {
		this.templategumb_id = templategumb_id;
	}
	
@Column(name="stolpec_metoda",length=155)

	public String getStolpec_metoda() {
		return stolpec_metoda;
	}
	public void setStolpec_metoda(String stolpec_metoda) {
		this.stolpec_metoda = stolpec_metoda;
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((stolpec_metoda == null) ? 0 : stolpec_metoda.hashCode());
		result = prime * result
				+ ((templategumb_id == null) ? 0 : templategumb_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateGumbiParametri other = (TemplateGumbiParametri) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (stolpec_metoda == null) {
			if (other.stolpec_metoda != null)
				return false;
		} else if (!stolpec_metoda.equals(other.stolpec_metoda))
			return false;
		if (templategumb_id == null) {
			if (other.templategumb_id != null)
				return false;
		} else if (!templategumb_id.equals(other.templategumb_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	

	
	

}
