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
@Table (name="templatexml")

 
public class TemplateXml  extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 583893148147367230L;
	private Long id;
	private String tag_name; /// ime elementa

	private int zaporedje; /// zaporedje prikaza zapisa na ekranu
	
	
	private String description; /// opis taga
	private Long id_nad; /// id nadrejenega
	private String path; /// celoten path od prvega elementa do tega elementa, zaporeje imenov tagov
	private List templatexmls = new ArrayList();
	

	private TemplateXml templatexml; /// nadrejen tag
	private List  templateattributes = new ArrayList();
	

	private Long id_conversion; /// id konverzije z indexom
	private String type; /// veja ali tag z vrednostjo (1-vrednost)
	
	
	
	
	@Column(name="type",length=1)

	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Index(name="id_conversionindex")
	@Column(name="id_conversion")
	

public Long getId_conversion() {
		return id_conversion;
	}

	public void setId_conversion(Long id_conversion) {
		this.id_conversion = id_conversion;
	}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateAttribute.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="id_nad",referencedColumnName="id")


public List getTemplateattributes() {
		return templateattributes;
	}

	public void setTemplateattributes(List templateattributes) {
		this.templateattributes = templateattributes;
	}
	

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateXml.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="id_nad",referencedColumnName="id")
@OrderBy("zaporedje")


public List getTemplatexmls() {
	return templatexmls;
}

public void setTemplatexmls(List templatexmls) {
	this.templatexmls = templatexmls;
}



@ManyToOne(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateXml.class)
@JoinColumn(name="id_nad",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)

public TemplateXml getTemplatexml() {
	return templatexml;
}

public void setTemplatexml(TemplateXml templatexml) {
	this.templatexml = templatexml;
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


@Column(name="tag_name",length=70)

public String getTag_name() {
	return tag_name;
}

public void setTag_name(String tag_name) {
	this.tag_name = tag_name;
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



@Column(name="id_nad")


public Long getId_nad() {
	return id_nad;
}

public void setId_nad(Long id_nad) {
	this.id_nad = id_nad;
}



@Column(name="path",length=600)


public String getPath() {
	return path;
}

public void setPath(String path) {
	this.path = path;
}

@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result
			+ ((description == null) ? 0 : description.hashCode());
	result = prime * result + ((id == null) ? 0 : id.hashCode());
	result = prime * result + ((id_nad == null) ? 0 : id_nad.hashCode());
	result = prime * result + ((path == null) ? 0 : path.hashCode());
	result = prime * result + ((tag_name == null) ? 0 : tag_name.hashCode());
	result = prime * result
			+ ((templatexml == null) ? 0 : templatexml.hashCode());
	result = prime * result
			+ ((templatexmls == null) ? 0 : templatexmls.hashCode());
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
	TemplateXml other = (TemplateXml) obj;
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
	if (path == null) {
		if (other.path != null)
			return false;
	} else if (!path.equals(other.path))
		return false;
	if (tag_name == null) {
		if (other.tag_name != null)
			return false;
	} else if (!tag_name.equals(other.tag_name))
		return false;
	if (templatexml == null) {
		if (other.templatexml != null)
			return false;
	} else if (!templatexml.equals(other.templatexml))
		return false;
	if (templatexmls == null) {
		if (other.templatexmls != null)
			return false;
	} else if (!templatexmls.equals(other.templatexmls))
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
