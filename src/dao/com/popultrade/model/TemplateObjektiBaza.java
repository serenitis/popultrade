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
@Table (name="templateobjektibaza")


public class TemplateObjektiBaza extends BaseObject implements Serializable {

	private static final long serialVersionUID = -112846479696873717L;
	private Long id;
	private String baza_polje_objekt; /// ime polja v bazi ki ima blob objekti
	private String baza_content_type; /// ime polja v bazi za content-type
	private Long templatehead_id;
	private String content_type_rocno; /// ce v bazi ni content type dam to rocno
	private String content_type_extension; /// extension datoteke ki se generira
	private String baza_ime_file; /// ime polja v bazi z ime datoteke 
	
	
	
	
	
	
@Column(name="baza_ime_file",length=80)

	
	

	public String getBaza_ime_file() {
		return baza_ime_file;
	}
	public void setBaza_ime_file(String baza_ime_file) {
		this.baza_ime_file = baza_ime_file;
	}
@Column(name="content_type_extension",length=8)

	
	public String getContent_type_extension() {
		return content_type_extension;
	}
	public void setContent_type_extension(String content_type_extension) {
		this.content_type_extension = content_type_extension;
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
	
	
	
	
@Column(name="baza_polje_objekt",length=80)

	public String getBaza_polje_objekt() {
		return baza_polje_objekt;
	}
	public void setBaza_polje_objekt(String baza_polje_objekt) {
		this.baza_polje_objekt = baza_polje_objekt;
	}
	
	
@Column(name="baza_content_type",length=80)

	public String getBaza_content_type() {
		return baza_content_type;
	}
	public void setBaza_content_type(String baza_content_type) {
		this.baza_content_type = baza_content_type;
	}
	
	
@Column(name="templatehead_id")

	public Long getTemplatehead_id() {
		return templatehead_id;
	}
	public void setTemplatehead_id(Long templatehead_id) {
		this.templatehead_id = templatehead_id;
	}
	
	
	
@Column(name="content_type_rocno",length=80)

	public String getContent_type_rocno() {
		return content_type_rocno;
	}
	public void setContent_type_rocno(String content_type_rocno) {
		this.content_type_rocno = content_type_rocno;
	}
	
	
	
	
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime
				+ ((baza_content_type == null) ? 0 : baza_content_type
						.hashCode());
		result = prime
				+ ((baza_polje_objekt == null) ? 0 : baza_polje_objekt
						.hashCode());
		result = prime
				+ ((content_type_rocno == null) ? 0 : content_type_rocno
						.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TemplateObjektiBaza other = (TemplateObjektiBaza) obj;
		if (baza_content_type == null) {
			if (other.baza_content_type != null)
				return false;
		} else if (!baza_content_type.equals(other.baza_content_type))
			return false;
		if (baza_polje_objekt == null) {
			if (other.baza_polje_objekt != null)
				return false;
		} else if (!baza_polje_objekt.equals(other.baza_polje_objekt))
			return false;
		if (content_type_rocno == null) {
			if (other.content_type_rocno != null)
				return false;
		} else if (!content_type_rocno.equals(other.content_type_rocno))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (templatehead_id == null) {
			if (other.templatehead_id != null)
				return false;
		} else if (!templatehead_id.equals(other.templatehead_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	

	

	
	
	
	
	
}
