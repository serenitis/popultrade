package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table (name="templatexmlelements")

 
public class TemplateXmlelements  extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 123893348147361130L;
	private Long id;
	private String element_name; /// ime elementa

	//private int zaporedje; /// zaporedje prikaza zapisa na ekranu
	
	
	private String description; /// opis taga
	private Long id_nad; /// id nadrejenega

	
	private Integer position_start; /// zacetna pozicija
	private Integer legth; /// dolzina elementa

	private TemplateXmlapp templatexmlapp; /// nadrejea vrstica
	
	private String connection_element; /// ce gre za vezni element z drugimi vrsticami , npr. da vem pod kateri H pasejo I-ij.


	
	
	
	
	
	@Column(name="connection_element",length=1)


public String getConnection_element() {
		return connection_element;
	}

	public void setConnection_element(String connection_element) {
		this.connection_element = connection_element;
	}

@ManyToOne(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateXmlapp.class)
@JoinColumn(name="id_nad",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)

public TemplateXmlapp getTemplatexmlapp() {
	return templatexmlapp;
}

public void setTemplatexmlapp(TemplateXmlapp templatexmlapp) {
	this.templatexmlapp = templatexmlapp;
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


@Index(name="templatexmlelemtsapp")
@Column(name="id_nad")


public Long getId_nad() {
	return id_nad;
}

public void setId_nad(Long id_nad) {
	this.id_nad = id_nad;
}



@Column(name="element_name",length=55)

public String getElement_name() {
	return element_name;
}

public void setElement_name(String element_name) {
	this.element_name = element_name;
}


@Column(name="position_start")

public Integer getPosition_start() {
	return position_start;
}

public void setPosition_start(Integer position_start) {
	this.position_start = position_start;
}


@Column(name="legth")

public Integer getLegth() {
	return legth;
}

public void setLegth(Integer legth) {
	this.legth = legth;
}

@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result
			+ ((description == null) ? 0 : description.hashCode());
	result = prime * result
			+ ((element_name == null) ? 0 : element_name.hashCode());
	result = prime * result + ((id == null) ? 0 : id.hashCode());
	result = prime * result + ((id_nad == null) ? 0 : id_nad.hashCode());
	result = prime * result + ((legth == null) ? 0 : legth.hashCode());
	result = prime * result
			+ ((position_start == null) ? 0 : position_start.hashCode());
	result = prime * result
			+ ((templatexmlapp == null) ? 0 : templatexmlapp.hashCode());
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
	TemplateXmlelements other = (TemplateXmlelements) obj;
	if (description == null) {
		if (other.description != null)
			return false;
	} else if (!description.equals(other.description))
		return false;
	if (element_name == null) {
		if (other.element_name != null)
			return false;
	} else if (!element_name.equals(other.element_name))
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
	if (legth == null) {
		if (other.legth != null)
			return false;
	} else if (!legth.equals(other.legth))
		return false;
	if (position_start == null) {
		if (other.position_start != null)
			return false;
	} else if (!position_start.equals(other.position_start))
		return false;
	if (templatexmlapp == null) {
		if (other.templatexmlapp != null)
			return false;
	} else if (!templatexmlapp.equals(other.templatexmlapp))
		return false;
	return true;
}

@Override
public String toString() {
	// TODO Auto-generated method stub
	return null;
}




	
	
	
	
	
	
	
	

}
