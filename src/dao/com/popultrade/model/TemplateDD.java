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
@Table (name="templatedd")


public class TemplateDD extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 4233565666556544441L;
	private Long id;
	private String class_name; /// ime clase iz katere dobim vrednost preko dropdown opcije ajax
	private String opis; /// opis 
	private Long templateui_id;
	private String status; /// uporabi ne uporabi dropdown
	private String head_select_dodatni_pogoji; /// lahko dodas order by
	private String order_by_smer; /// asc, desc order by
	
	
	private String dodaten_hql_pogoj;
	private String uporabi_dodaten_hql_pogoj;
	
	private String kontrola; /// ce gre za ajax kontrolo
	
	private Integer min_st_znakov; /// minimalno stevilo vnesenih znakov preden zacne iskat v bazi
	
	private String pogoj_za_uporabo_hql; /// if pogoj za uporabo hql pogoja
	
	
	private String uporabi_kontrolo_rocno; /// ce klicem js kontrolo rocno ali avtomaticno
	
	
	private String uporabi_kontrolo_vrednosti; /// prenesem vrednost v polje textbox le ce je prazno
	
	//private TemplatePP templatepp;
	//private TemplateUi templateui;
	
	
	private String uporabi_js_db;
	
	private List templateddpogojis = new ArrayList();

	private TemplatePP templatepp;
	
	
	@OneToOne
    @JoinColumn(name = "templateui_id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)

	public TemplatePP getTemplatepp() {
		return templatepp;
	}
	public void setTemplatepp(TemplatePP templatepp) {
		this.templatepp = templatepp;
	}
	
	
	
	
	
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateDDPogoji.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="templatedd_id",referencedColumnName="id")

	
	public List getTemplateddpogojis() {
		return templateddpogojis;
	}

	public void setTemplateddpogojis(List templateddpogojis) {
		this.templateddpogojis = templateddpogojis;
	}
	
	
	
	@Column(name="uporabi_js_db",length=1)

	
	
	public String getUporabi_js_db() {
		return uporabi_js_db;
	}

	public void setUporabi_js_db(String uporabi_js_db) {
		this.uporabi_js_db = uporabi_js_db;
	}
	
	
@Column(name="uporabi_kontrolo_vrednosti",length=1)

	
	public String getUporabi_kontrolo_vrednosti() {
		return uporabi_kontrolo_vrednosti;
	}
	public void setUporabi_kontrolo_vrednosti(String uporabi_kontrolo_vrednosti) {
		this.uporabi_kontrolo_vrednosti = uporabi_kontrolo_vrednosti;
	}
@Column(name="uporabi_kontrolo_rocno",length=1)

	
	public String getUporabi_kontrolo_rocno() {
		return uporabi_kontrolo_rocno;
	}
	public void setUporabi_kontrolo_rocno(String uporabi_kontrolo_rocno) {
		this.uporabi_kontrolo_rocno = uporabi_kontrolo_rocno;
	}
@Column(name="pogoj_za_uporabo_hql",length=350)

	
	public String getPogoj_za_uporabo_hql() {
		return pogoj_za_uporabo_hql;
	}
	public void setPogoj_za_uporabo_hql(String pogoj_za_uporabo_hql) {
		this.pogoj_za_uporabo_hql = pogoj_za_uporabo_hql;
	}
@Column(name="min_st_znakov")

	
	
	public Integer getMin_st_znakov() {
		return min_st_znakov;
	}
	public void setMin_st_znakov(Integer min_st_znakov) {
		this.min_st_znakov = min_st_znakov;
	}
@Column(name="kontrola",length=1)

	
	public String getKontrola() {
		return kontrola;
	}
	public void setKontrola(String kontrola) {
		this.kontrola = kontrola;
	}
@Column(name="dodaten_hql_pogoj",length=350)

	
	
	public String getDodaten_hql_pogoj() {
		return dodaten_hql_pogoj;
	}
	public void setDodaten_hql_pogoj(String dodaten_hql_pogoj) {
		this.dodaten_hql_pogoj = dodaten_hql_pogoj;
	}
	
@Column(name="uporabi_dodaten_hql_pogoj",length=1)

	public String getUporabi_dodaten_hql_pogoj() {
		return uporabi_dodaten_hql_pogoj;
	}
	public void setUporabi_dodaten_hql_pogoj(String uporabi_dodaten_hql_pogoj) {
		this.uporabi_dodaten_hql_pogoj = uporabi_dodaten_hql_pogoj;
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
@Column(name="status",length=1)

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	
	
@Column(name="class_name",length=55)

	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	
	
@Column(name="opis",length=250)

	public String getOpis() {
		return opis;
	}
	public void setOpis(String opis) {
		this.opis = opis;
	}
	
	
	
@Index(name="templateui_id")
@Column(name="templateui_id")

	public Long getTemplateui_id() {
		return templateui_id;
	}
	public void setTemplateui_id(Long templateui_id) {
		this.templateui_id = templateui_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((class_name == null) ? 0 : class_name.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((opis == null) ? 0 : opis.hashCode());
		result = prime * result
				+ ((templateui_id == null) ? 0 : templateui_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateDD other = (TemplateDD) obj;
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
		if (opis == null) {
			if (other.opis != null)
				return false;
		} else if (!opis.equals(other.opis))
			return false;
		if (templateui_id == null) {
			if (other.templateui_id != null)
				return false;
		} else if (!templateui_id.equals(other.templateui_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
