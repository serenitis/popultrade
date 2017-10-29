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
@Table (name="templatefunkcijastart")


public class TemplateFunkcijaStart extends BaseObject implements Serializable {
	
	
	
	private static final long serialVersionUID = 987654321765432771L;
	private Long id;
	private String class_name;
	private String ime_funkcije;
	private String opis;
	private Long veza_id;
	private Integer zaporedje;
	
	
	private String predpogoj; /// prepogoj z oklepaji , lahko le request.getParameter
	
	
	
	
	
	private String vrednosti_preko_checkbox; /// ce vrednosti pridejo preko checkboxa
	private String stolpec_metoda_checkbox; /// ime vrednosti, ki dobim preko checkboxa
	

	
	private TemplateTag templatetag = new TemplateTag();
	
	
	private TemplatePdfParametri templatepdfparametri = new TemplatePdfParametri();
	
	
	
	@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templatefunkcijastart")
	//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)


	public TemplatePdfParametri getTemplatepdfparametri() {
		return templatepdfparametri;
	}


	public void setTemplatepdfparametri(TemplatePdfParametri templatepdfparametri) {
		this.templatepdfparametri = templatepdfparametri;
	}
	
	
	
	
	
@Column(name="predpogoj",length=150)

	
	public String getPredpogoj() {
		return predpogoj;
	}



	public void setPredpogoj(String predpogoj) {
		this.predpogoj = predpogoj;
	}



@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templatefunkcijastart")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	public TemplateTag getTemplatetag() {
		return templatetag;
	}


	public void setTemplatetag(TemplateTag templatetag) {
		this.templatetag = templatetag;
	}


@Column(name="vrednosti_preko_checkbox",length=1)

	
	public String getVrednosti_preko_checkbox() {
		return vrednosti_preko_checkbox;
	}


	public void setVrednosti_preko_checkbox(String vrednosti_preko_checkbox) {
		this.vrednosti_preko_checkbox = vrednosti_preko_checkbox;
	}

@Column(name="stolpec_metoda_checkbox",length=55)

	public String getStolpec_metoda_checkbox() {
		return stolpec_metoda_checkbox;
	}


	public void setStolpec_metoda_checkbox(String stolpec_metoda_checkbox) {
		this.stolpec_metoda_checkbox = stolpec_metoda_checkbox;
	}


@Index(name="zaporedje")
@Column(name="zaporedje")

	
	
	
	public Integer getZaporedje() {
		return zaporedje;
	}


	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
	}



	private List templatelists = new ArrayList(); /// list vseh templateviews
	
	private List templateviews = new ArrayList(); /// list vseh templateviews


@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateView.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
@OrderBy("zaporedje asc")


	public List getTemplateviews() {
		return templateviews;
	}


	public void setTemplateviews(List templateviews) {
		this.templateviews = templateviews;
	}

	

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateList.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
@OrderBy("zaporedje asc")
	
	
	public List getTemplatelists() {
		return templatelists;
	}


	public void setTemplatelists(List templatelists) {
		this.templatelists = templatelists;
	}


@Index(name="veza_id")
@Column(name="veza_id")

	
	public Long getVeza_id() {
		return veza_id;
	}
	public void setVeza_id(Long veza_id) {
		this.veza_id = veza_id;
	}
	
	
	
	private TemplateClassClass templateClassClass = new TemplateClassClass();
	
	

@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templatefunkcijastart")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
	
@NotFound(action = NotFoundAction.IGNORE)
	public TemplateClassClass getTemplateClassClass() {
		return templateClassClass;
	}
	public void setTemplateClassClass(TemplateClassClass templateClassClass) {
		this.templateClassClass = templateClassClass;
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
	
	
	
	
@Column(name="class_name",length=55,nullable=true)

	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	
	
	
	
	
@Column(name="ime_funkcije",length=150,nullable=true)

	public String getIme_funkcije() {
		return ime_funkcije;
	}
	public void setIme_funkcije(String ime_funkcije) {
		this.ime_funkcije = ime_funkcije;
	}
	
	
@Column(name="opis",length=250)

	public String getOpis() {
		return opis;
	}
	public void setOpis(String opis) {
		this.opis = opis;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((class_name == null) ? 0 : class_name.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((ime_funkcije == null) ? 0 : ime_funkcije.hashCode());
		result = prime * result + ((opis == null) ? 0 : opis.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateFunkcijaStart other = (TemplateFunkcijaStart) obj;
		if (class_name == null) {
			if (other.class_name != null)
				return false;
		} else if (!class_name.equals(other.class_name))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (ime_funkcije == null) {
			if (other.ime_funkcije != null)
				return false;
		} else if (!ime_funkcije.equals(other.ime_funkcije))
			return false;
		if (opis == null) {
			if (other.opis != null)
				return false;
		} else if (!opis.equals(other.opis))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	

}
