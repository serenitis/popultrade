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
@Table (name="templateconversions")

 
public class TemplateConversions  extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 583819206390167230L;
	private Long id;


	private String description; /// opis podjetja
	private String name; /// ime konverzije
	
	private String conv_id; /// id konverzije za parameter preko requesta
	private String status; /// status konverzije, konverzijo naredi ali ne pri requestu
	private Long id_nad; /// id nad
	


	//private TemplateConversions templateconversions; /// nadrejen tag
	private List  templateXmls = new ArrayList();
	




@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateConversions.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="id_conversion",referencedColumnName="id")


public List getTemplateXmls() {
		return templateXmls;
	}

	public void setTemplateXmls(List templateXmls) {
		this.templateXmls = templateXmls;
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




@Column(name="status",length=1)
public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}



@Column(name="conv_id",length=30)
public String getConv_id() {
	return conv_id;
}

public void setConv_id(String conv_id) {
	this.conv_id = conv_id;
}


@Column(name="id_nad")
public Long getId_nad() {
	return id_nad;
}

public void setId_nad(Long id_nad) {
	this.id_nad = id_nad;
}

@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((conv_id == null) ? 0 : conv_id.hashCode());
	result = prime * result
			+ ((description == null) ? 0 : description.hashCode());
	result = prime * result + ((id == null) ? 0 : id.hashCode());
	result = prime * result + ((id_nad == null) ? 0 : id_nad.hashCode());
	result = prime * result + ((name == null) ? 0 : name.hashCode());
	result = prime * result + ((status == null) ? 0 : status.hashCode());
	result = prime * result
			+ ((templateXmls == null) ? 0 : templateXmls.hashCode());
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
	TemplateConversions other = (TemplateConversions) obj;
	if (conv_id == null) {
		if (other.conv_id != null)
			return false;
	} else if (!conv_id.equals(other.conv_id))
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
	if (id_nad == null) {
		if (other.id_nad != null)
			return false;
	} else if (!id_nad.equals(other.id_nad))
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
	if (templateXmls == null) {
		if (other.templateXmls != null)
			return false;
	} else if (!templateXmls.equals(other.templateXmls))
		return false;
	return true;
}

@Override
public String toString() {
	// TODO Auto-generated method stub
	return null;
}


	
	
	

}
