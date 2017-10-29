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
@Table (name="templatexmlapp")

 /// samo pregled app datoteke, za naredit primerjavo
public class TemplateXmlapp  extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 5838931476653367230L;
	private Long id;
	
	private int zaporedje; /// zaporedje prikaza zapisa na ekranu
	
	
	private String description; /// opis taga
	
	private String row; /// row v app strukturi (G,I,S,...)
	
	private List  templatexmlelements = new ArrayList(); /// elementi (od-do v app strukturi)
	private List  templatexmlapps = new ArrayList(); /// elementi (od-do v app strukturi)
	

	private Long id_conversion; /// id konverzije z indexom
	
	private String row_type; /// tip vrstice , ki je kreirana: loop-se jih kreira vec preko loopa, head-le ena

	private Integer length; /// dolzina vrstice
	
	
	private String prefix; /// prefix vrstice s katerim identificiram tip vrstice (H,S,I,...)
	
	
	
	private Long id_nad; /// veza na nadrejenega
	
	
	@Index(name="templatexmlappid_nad")
	@Column(name="id_nad")
	
	
	public Long getId_nad() {
		return id_nad;
	}

	public void setId_nad(Long id_nad) {
		this.id_nad = id_nad;
	}

	@Column(name="prefix",length=35)
	

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	@Column(name="length")
	
	
	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	@Column(name="row_type",length=5)
	

	public String getRow_type() {
		return row_type;
	}

	public void setRow_type(String row_type) {
		this.row_type = row_type;
	}

	@Index(name="id_conversionindexapp")
	@Column(name="id_conversion")
	

public Long getId_conversion() {
		return id_conversion;
	}

	public void setId_conversion(Long id_conversion) {
		this.id_conversion = id_conversion;
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



@Column(name="zaporedje")

public int getZaporedje() {
	return zaporedje;
}

public void setZaporedje(int zaporedje) {
	this.zaporedje = zaporedje;
}


@Column(name="description",length=400)

public String getDescription() {
	return description;
}

public void setDescription(String description) {
	this.description = description;
}


@Column(name="row_",length=4000)

public String getRow() {
	return row;
}

public void setRow(String row) {
	this.row = row;
}








@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateXmlapp.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="id_nad",referencedColumnName="id")
@OrderBy("zaporedje")

public List getTemplatexmlapps() {
	return templatexmlapps;
}

public void setTemplatexmlapps(List templatexmlapps) {
	this.templatexmlapps = templatexmlapps;
}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateXmlelements.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="id_nad",referencedColumnName="id")


public List getTemplatexmlelements() {
	return templatexmlelements;
}

public void setTemplatexmlelements(List templatexmlelements) {
	this.templatexmlelements = templatexmlelements;
}

@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result
			+ ((description == null) ? 0 : description.hashCode());
	result = prime * result + ((id == null) ? 0 : id.hashCode());
	result = prime * result
			+ ((id_conversion == null) ? 0 : id_conversion.hashCode());
	result = prime * result + ((row == null) ? 0 : row.hashCode());
	result = prime
			* result
			+ ((templatexmlelements == null) ? 0 : templatexmlelements
					.hashCode());
	result = prime * result + zaporedje;
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
	TemplateXmlapp other = (TemplateXmlapp) obj;
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
	if (id_conversion == null) {
		if (other.id_conversion != null)
			return false;
	} else if (!id_conversion.equals(other.id_conversion))
		return false;
	if (row == null) {
		if (other.row != null)
			return false;
	} else if (!row.equals(other.row))
		return false;
	if (templatexmlelements == null) {
		if (other.templatexmlelements != null)
			return false;
	} else if (!templatexmlelements.equals(other.templatexmlelements))
		return false;
	if (zaporedje != other.zaporedje)
		return false;
	return true;
}

@Override
public String toString() {
	// TODO Auto-generated method stub
	return null;
}




	
	
	
	
	
	
	
	

}
