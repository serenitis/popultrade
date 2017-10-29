package com.popultrade.model;

import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import java.io.Serializable;


@Entity
@Table (name="templatetag")


public class TemplateTag  extends BaseObject implements Serializable {
	
	
	
	private static final long serialVersionUID = 1898989886565432423L;

	private Long id;
	
	/// za xml
	private String tag_name; /// ime xml taga ali attribute taga
	private String uporabi_tag; /// uporabi tag
	
	private String je_attribute_taga; /// , ce gre za attribute
	
	/// za ih
	private Integer dolzinapolja; /// dolzina polja

	
	private Long id_veza; /// veza na ostale tabele
	
	
	
	private String tag_ima_childe; /// v primeru da tag ima child elemente
	
	private String tag_name_parent; /// ime parent taga
	
	private TemplateClassClass_vrednosti templateclassclass_vrednosti;

	
	private TemplateFunkcijaStart templatefunkcijastart;
	
	
	
	
	
	
	
	@OneToOne
    @JoinColumn(name = "id_veza",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateFunkcijaStart getTemplatefunkcijastart() {
		return templatefunkcijastart;
	}
	public void setTemplatefunkcijastart(TemplateFunkcijaStart templatefunkcijastart) {
		this.templatefunkcijastart = templatefunkcijastart;
	}
	
	
	
	
	@OneToOne
    @JoinColumn(name = "id_veza",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	public TemplateClassClass_vrednosti getTemplateclassclass_vrednosti() {
		return templateclassclass_vrednosti;
	}
	public void setTemplateclassclass_vrednosti(
			TemplateClassClass_vrednosti templateclassclass_vrednosti) {
		this.templateclassclass_vrednosti = templateclassclass_vrednosti;
	}
	
	
@Column(name="tag_name_parent",length=120)

	
	
	public String getTag_name_parent() {
		return tag_name_parent;
	}

	public void setTag_name_parent(String tag_name_parent) {
		this.tag_name_parent = tag_name_parent;
	}

@Column(name="tag_ima_childe",length=1)

	
	
	public String getTag_ima_childe() {
		return tag_ima_childe;
	}

	public void setTag_ima_childe(String tag_ima_childe) {
		this.tag_ima_childe = tag_ima_childe;
	}

@Index(name="id_veza")
@Column(name="id_veza",nullable=true)

	
	public Long getId_veza() {
		return id_veza;
	}

	public void setId_veza(Long id_veza) {
		this.id_veza = id_veza;
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

@Column(name="tag_name",length=120,nullable=true)

	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}

	
	
@Column(name="uporabi_tag",length=1)

	public String getUporabi_tag() {
		return uporabi_tag;
	}

	public void setUporabi_tag(String uporabi_tag) {
		this.uporabi_tag = uporabi_tag;
	}
@Column(name="je_attribute_taga",length=1)

	public String getJe_attribute_taga() {
		return je_attribute_taga;
	}

	public void setJe_attribute_taga(String je_attribute_taga) {
		this.je_attribute_taga = je_attribute_taga;
	}

	
@Column(name="dolzinapolja")

	public Integer getDolzinapolja() {
		return dolzinapolja;
	}

	public void setDolzinapolja(Integer dolzinapolja) {
		this.dolzinapolja = dolzinapolja;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((dolzinapolja == null) ? 0 : dolzinapolja.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				+ ((je_attribute_taga == null) ? 0 : je_attribute_taga
						.hashCode());
		result = prime * result
				+ ((tag_name == null) ? 0 : tag_name.hashCode());
		result = prime * result
				+ ((uporabi_tag == null) ? 0 : uporabi_tag.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateTag other = (TemplateTag) obj;
		if (dolzinapolja == null) {
			if (other.dolzinapolja != null)
				return false;
		} else if (!dolzinapolja.equals(other.dolzinapolja))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (je_attribute_taga == null) {
			if (other.je_attribute_taga != null)
				return false;
		} else if (!je_attribute_taga.equals(other.je_attribute_taga))
			return false;
		if (tag_name == null) {
			if (other.tag_name != null)
				return false;
		} else if (!tag_name.equals(other.tag_name))
			return false;
		if (uporabi_tag == null) {
			if (other.uporabi_tag != null)
				return false;
		} else if (!uporabi_tag.equals(other.uporabi_tag))
			return false;
		return true;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
