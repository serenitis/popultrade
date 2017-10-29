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
@Table (name="templateheadreset")


public class TemplateHeadReset  extends BaseObject implements Serializable { /// reset frameton na prazno stran
	
	private static final long serialVersionUID = 3546797865432456771L;
	private Long id;
	private String reset_lokacija; /// lokacija za reset parent frameti
	private Long templatehead_id;
	private String reset_page; /// resetiraj na page, ime jsp fileta, za zdaj je nic.jsp
	
	
	
	
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
	
	
@Column(name="reset_lokacija",length=55,nullable=true)

	public String getReset_lokacija() {
		return reset_lokacija;
	}
	public void setReset_lokacija(String reset_lokacija) {
		this.reset_lokacija = reset_lokacija;
	}
	
	
	
@Index(name="templatehead_id")
@Column(name="templatehead_id")

	public Long getTemplatehead_id() {
		return templatehead_id;
	}
	public void setTemplatehead_id(Long templatehead_id) {
		this.templatehead_id = templatehead_id;
	}
	
	
@Column(name="reset_page",length=255,nullable=true)

	public String getReset_page() {
		return reset_page;
	}
	public void setReset_page(String reset_page) {
		this.reset_page = reset_page;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((reset_lokacija == null) ? 0 : reset_lokacija.hashCode());
		result = prime * result
				+ ((reset_page == null) ? 0 : reset_page.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateHeadReset other = (TemplateHeadReset) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (reset_lokacija == null) {
			if (other.reset_lokacija != null)
				return false;
		} else if (!reset_lokacija.equals(other.reset_lokacija))
			return false;
		if (reset_page == null) {
			if (other.reset_page != null)
				return false;
		} else if (!reset_page.equals(other.reset_page))
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
