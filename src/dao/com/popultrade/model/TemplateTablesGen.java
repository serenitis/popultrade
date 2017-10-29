package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/// hibernate tabele 



@Entity
@Table (name="templatetablesgen")


public class TemplateTablesGen extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 4231190666556544441L;
	private Long id;

	private String production_status; /// status, na produ ali ne
	private Date last_build; /// zadnji build datum
	private String description; /// opis 
	private String title; /// naziv  
	
	private List templatetabless = new ArrayList();
	

	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateTables.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_nad",referencedColumnName="id")
	
	
	
	
	public List getTemplatetabless() {
		return templatetabless;
	}
	public void setTemplatetabless(List templatetabless) {
		this.templatetabless = templatetabless;
	}
	
	
	@Column(name="title",length=70)
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Column(name="description",length=800)
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	

	/**
     * 
     * @hibernate.id column="id"
     */
	
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
	
	


@Column(name="production_status",length=1)

	public String getProduction_status() {
		return production_status;
	}
	public void setProduction_status(String production_status) {
		this.production_status = production_status;
	}
	
	
@Column(name="last_build")

	public Date getLast_build() {
		return last_build;
	}
	public void setLast_build(Date last_build) {
		this.last_build = last_build;
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
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((last_build == null) ? 0 : last_build.hashCode());
		result = prime
				* result
				+ ((production_status == null) ? 0 : production_status
						.hashCode());
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
		TemplateTablesGen other = (TemplateTablesGen) obj;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (last_build == null) {
			if (other.last_build != null)
				return false;
		} else if (!last_build.equals(other.last_build))
			return false;
		if (production_status == null) {
			if (other.production_status != null)
				return false;
		} else if (!production_status.equals(other.production_status))
			return false;

		return true;
	}
	

	
	
	
	
	
	
	
	
	
	
	
	

}
