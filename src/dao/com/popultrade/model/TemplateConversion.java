package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/// podjetja, za katera se dela konverzijo
@Entity
@Table (name="templateconversion")

 
public class TemplateConversion  extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 583893145690167230L;
	private Long id;


	private String description; /// opis podjetja
	private String name; /// ime podjetja
	
	private String company_id; /// id podjetja (identifikacija pri konverziji, parameter ) npr. ean koda
	private String status; /// status podjetja, konverzijo naredi ali ne pri requestu
	private Long user_id; /// id userja, vezanega na konverzijo
	


	//private TemplateConversions templateconversions; /// nadrejen tag
	private List  templateconversions = new ArrayList();
	




@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateConversions.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="id_nad",referencedColumnName="id")


public List getTemplateconversions() {
		return templateconversions;
	}

	public void setTemplateconversions(List templateconversions) {
		this.templateconversions = templateconversions;
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




@Column(name="description",length=400)

public String getDescription() {
	return description;
}

public void setDescription(String description) {
	this.description = description;
}




@Column(name="name",length=50)

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}


@Column(name="company_id",length=30)
public String getCompany_id() {
	return company_id;
}

public void setCompany_id(String company_id) {
	this.company_id = company_id;
}


@Column(name="status",length=1)
public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}


@Column(name="user_id")
public Long getUser_id() {
	return user_id;
}

public void setUser_id(Long user_id) {
	this.user_id = user_id;
}

@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result
			+ ((company_id == null) ? 0 : company_id.hashCode());
	result = prime * result
			+ ((description == null) ? 0 : description.hashCode());
	result = prime * result + ((id == null) ? 0 : id.hashCode());
	result = prime * result + ((name == null) ? 0 : name.hashCode());
	result = prime * result + ((status == null) ? 0 : status.hashCode());
	result = prime
			* result
			+ ((templateconversions == null) ? 0 : templateconversions
					.hashCode());
	result = prime * result + ((user_id == null) ? 0 : user_id.hashCode());
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
	TemplateConversion other = (TemplateConversion) obj;
	if (company_id == null) {
		if (other.company_id != null)
			return false;
	} else if (!company_id.equals(other.company_id))
		return false;
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
	if (status == null) {
		if (other.status != null)
			return false;
	} else if (!status.equals(other.status))
		return false;
	if (templateconversions == null) {
		if (other.templateconversions != null)
			return false;
	} else if (!templateconversions.equals(other.templateconversions))
		return false;
	if (user_id == null) {
		if (other.user_id != null)
			return false;
	} else if (!user_id.equals(other.user_id))
		return false;
	return true;
}

@Override
public String toString() {
	// TODO Auto-generated method stub
	return null;
}



	
	
	
	
	
	

}
