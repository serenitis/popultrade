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
@Table (name="templateclassclass")


public class TemplateClassClass extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 2234776400987654531L;
	private Long id;
	private Long id_veza; /// id clase ki se veze na to, se vpise id po katerem najdem vezavo
	private String class_name;
	private String tip_funkcije;/// tip funkcije , update, insert, list, ena-ena
	private String brisi; /// klicem brisanje na zadetke 
	private String head_select_dodatni_pogoji; /// lahko dodas order by
	private String order_by_smer; /// asc, desc order by
	private Integer max_st_izpisov; /// maximalno stevilo recordov, ki izpise na PDF
	private String dodatni_hql_pogoji; /// dodaten hql pogoj

	
	
	
	

	private List templateClassClass_vrednostis = new ArrayList();
	
	
	private List templateClasss= new ArrayList();
	

	private List templatelists = new ArrayList(); /// list vseh templateviews
	
	private List templateviews = new ArrayList(); /// list vseh templateviews

	
	private TemplateClass templateclass;
	
	private TemplateClassClass_vrednosti templateclassclass_vrednosti;
	private TemplateFunkcijaStart templatefunkcijastart;
	private TemplateClass templatelist;
	private TemplatePP templatepp;
	
	private TemplateUi templateui;
	
	

	@OneToOne
    @JoinColumn(name = "id_veza",insertable=false,updatable=false,nullable=true)

	@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateUi getTemplateui() {
		return templateui;
	}
	public void setTemplateui(TemplateUi templateui) {
		this.templateui = templateui;
	}
	
	
	@OneToOne
    @JoinColumn(name = "id_veza",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
	
	public TemplatePP getTemplatepp() {
		return templatepp;
	}
	public void setTemplatepp(TemplatePP templatepp) {
		this.templatepp = templatepp;
	}
	
	
	
	@OneToOne
    @JoinColumn(name = "id_veza",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateClass getTemplatelist() {
		return templatelist;
	}
	public void setTemplatelist(TemplateClass templatelist) {
		this.templatelist = templatelist;
	}
	
	
	
	
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
	
	@OneToOne
    @JoinColumn(name = "id_veza",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateClass getTemplateclass() {
		return templateclass;
	}
	public void setTemplateclass(TemplateClass templateclass) {
		this.templateclass = templateclass;
	}
	

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


@Column(name="dodatni_hql_pogoji",length=350)

	
	
	public String getDodatni_hql_pogoji() {
		return dodatni_hql_pogoji;
	}


	public void setDodatni_hql_pogoji(String dodatni_hql_pogoji) {
		this.dodatni_hql_pogoji = dodatni_hql_pogoji;
	}


@Column(name="max_st_izpisov")

	
	
	public Integer getMax_st_izpisov() {
		return max_st_izpisov;
	}


	public void setMax_st_izpisov(Integer max_st_izpisov) {
		this.max_st_izpisov = max_st_izpisov;
	}


@Column(name="head_select_dodatni_pogoji",length=55)

	public String getHead_select_dodatni_pogoji() {
		return head_select_dodatni_pogoji;
	}


	public void setHead_select_dodatni_pogoji(String head_select_dodatni_pogoji) {
		this.head_select_dodatni_pogoji = head_select_dodatni_pogoji;
	}

@Column(name="order_by_smer",length=4)

	public String getOrder_by_smer() {
		return order_by_smer;
	}


	public void setOrder_by_smer(String order_by_smer) {
		this.order_by_smer = order_by_smer;
	}


@Column(name="brisi",length=2)

	
	
	public String getBrisi() {
		return brisi;
	}


	public void setBrisi(String brisi) {
		this.brisi = brisi;
	}


@Column(name="tip_funkcije",length=2)

	
	public String getTip_funkcije() {
		return tip_funkcije;
	}
	public void setTip_funkcije(String tip_funkcije) {
		this.tip_funkcije = tip_funkcije;
	}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateClass.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
@OrderBy("id")
	
	public List getTemplateClasss() {
		return templateClasss;
	}
	public void setTemplateClasss(List templateClasss) {
		this.templateClasss = templateClasss;
	}
	
	
	

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateClassClass_vrednosti.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templateclassclass_id",referencedColumnName="id")
@OrderBy("zaporedje")
	
	public List getTemplateClassClass_vrednostis() {
		return templateClassClass_vrednostis;
	}
	public void setTemplateClassClass_vrednostis(List templateClassClass_vrednostis) {
		this.templateClassClass_vrednostis = templateClassClass_vrednostis;
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
	
@Index(name="id_veza")
@Column(name="id_veza")

	public Long getId_veza() {
		return id_veza;
	}
	public void setId_veza(Long id_veza) {
		this.id_veza = id_veza;
	}
	
	
	
@Column(name="class_name",length=55)

	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((class_name == null) ? 0 : class_name.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((id_veza == null) ? 0 : id_veza.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateClassClass other = (TemplateClassClass) obj;
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
		if (id_veza == null) {
			if (other.id_veza != null)
				return false;
		} else if (!id_veza.equals(other.id_veza))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	

}
