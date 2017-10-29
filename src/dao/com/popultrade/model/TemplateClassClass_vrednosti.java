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
@Table (name="templateclassclass_vrednosti")


public class TemplateClassClass_vrednosti extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = 8678645234234234441L;
	private Long id;
	private Long templateclassclass_id;
	private String vrednost; /// metoda iz classe
	private String tip; /// rabim pri prikazu hinta, doloci se id oz sifro sifranta in vrednost
	private List templateClasses = new ArrayList();
	private String rabi_kot; /// kako rabim vrednost, kot parameter ali vrednost, 
	private String tip_sestevka; /// uporabim v primeru tip funkcije je count, za nacin sestevka 
	
	private Integer zaporedje;
	
	private TemplateClassClass templateClassClass = new TemplateClassClass();
	
	

@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templateclassclass_vrednosti")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateClassClass getTemplateClassClass() {
		return templateClassClass;
	}
	public void setTemplateClassClass(TemplateClassClass templateClassClass) {
		this.templateClassClass = templateClassClass;
	}
	
	
	
	
	
	
	@Column(name="zaporedje",length=4)

	
	
	public Integer getZaporedje() {
		return zaporedje;
	}
	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
	}









	private TemplateTag templatetag = new TemplateTag();

@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templateclassclass_vrednosti")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	public TemplateTag getTemplatetag() {
		return templatetag;
	}


	public void setTemplatetag(TemplateTag templatetag) {
		this.templatetag = templatetag;
	}
	
	
	
	
	
@Column(name="tip_sestevka",length=10)

	
	public String getTip_sestevka() {
		return tip_sestevka;
	}


	public void setTip_sestevka(String tip_sestevka) {
		this.tip_sestevka = tip_sestevka;
	}


@Column(name="rabi_kot",length=2)

	public String getRabi_kot() {
		return rabi_kot;
	}


	public void setRabi_kot(String rabi_kot) {
		this.rabi_kot = rabi_kot;
	}


@Column(name="tip",length=10)

	
	public String getTip() {
		return tip;
	}


	public void setTip(String tip) {
		this.tip = tip;
	}



@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateClass.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
@OrderBy("zaporedje")
	
	
	
	public List getTemplateClasses() {
		return templateClasses;
	}


	public void setTemplateClasses(List templateClasses) {
		this.templateClasses = templateClasses;
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
	
	
@Index(name="templateclassclass_id")
@Column(name="templateclassclass_id")

	public Long getTemplateclassclass_id() {
		return templateclassclass_id;
	}
	public void setTemplateclassclass_id(Long templateclassclass_id) {
		this.templateclassclass_id = templateclassclass_id;
	}
	
	
@Column(name="vrednost",length=100)

	public String getVrednost() {
		return vrednost;
	}
	public void setVrednost(String vrednost) {
		this.vrednost = vrednost;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				+ ((templateclassclass_id == null) ? 0 : templateclassclass_id
						.hashCode());
		result = prime * result
				+ ((vrednost == null) ? 0 : vrednost.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateClassClass_vrednosti other = (TemplateClassClass_vrednosti) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (templateclassclass_id == null) {
			if (other.templateclassclass_id != null)
				return false;
		} else if (!templateclassclass_id.equals(other.templateclassclass_id))
			return false;
		if (vrednost == null) {
			if (other.vrednost != null)
				return false;
		} else if (!vrednost.equals(other.vrednost))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
}
