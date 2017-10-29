package com.popultrade.model;

import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;





@Entity
@Table (name="templatemenun")


public class TemplateMenun extends BaseObject implements Serializable  {

	
	private static final long serialVersionUID = 1436789080908764543L;
	private Long id;
	private String name;
	private String description;
	private List templatemenu;

	private List prevodis = new ArrayList();




	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="prevod_id",referencedColumnName="id")


	public List getPrevodis() {
		return prevodis;
	}

	public void setPrevodis(List prevodis) {
		this.prevodis = prevodis;
	}
	

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateMenu.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="menu",referencedColumnName="id")

	
	
	
	
	public List getTemplatemenu() {
		return templatemenu;
	}
	public void setTemplatemenu(List templatemenu) {
		this.templatemenu = templatemenu;
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
	
	
@Column(name="name",length=70)

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
@Column(name="description",length=450)

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		TemplateMenun other = (TemplateMenun) obj;
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
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
}
