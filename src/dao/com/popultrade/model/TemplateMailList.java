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
@Table (name="templatemaillist")


public class TemplateMailList extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 4233565612356544441L;
	private Long id;

	private Long templatehead_id;

	
	private Integer max_st_izpisov; /// maximalno stevilo izpisov oz. recordov
	private Integer font_size_head; /// font velikost v glavi
	private Integer font_size_list; /// font velikost vsebina
	private String uporabi; /// uporabim funkcionalnost posiljanja
	private String url_gumb; /// url gumba za izpis
	
	private String target_frame; /// v kateremu frame se izvede
	
	
	private String update_polje_uporabi; /// update uporabi polje
	private String update_polje; /// update polja
	private String update_polje_vrednost; /// vrednost ki vnesem v update
	
	private String upload_pogoj; /// pogoj za upload
	
	
	private Long target_funkcija_url; /// kam refresham
	private String target_funkcija;
	
	private String uporabi_excel; /// uporabim funkcionalnost posiljanja za excel

	
	private String style_gumb; /// barva gumba, iz stylov v js
	private String tekst_gumb; /// tekst na gumbu
	
	
	private String style_gumb_p; /// barva gumba po kliku na gumb, iz stylov v js
	private String tekst_gumb_p; /// tekst na gumbu po kliku na gumb
	
	
	//private TemplateHead templatehead ;
	
	private List prevodis = new ArrayList();




	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="prevod_id",referencedColumnName="id")


	public List getPrevodis() {
		return prevodis;
	}

	public void setPrevodis(List prevodis) {
		this.prevodis = prevodis;
	}
	
	/*
	@OneToOne
    @JoinColumn(name = "templatehead_id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
public TemplateHead getTemplatehead() {
		return templatehead;
	}
	public void setTemplatehead(TemplateHead templatehead) {
		this.templatehead = templatehead;
	}
	*/
	
	
@Column(name="style_gumb_p",length=10)

	
	
	public String getStyle_gumb_p() {
		return style_gumb_p;
	}


	public void setStyle_gumb_p(String style_gumb_p) {
		this.style_gumb_p = style_gumb_p;
	}

@Column(name="tekst_gumb_p",length=15)

	public String getTekst_gumb_p() {
		return tekst_gumb_p;
	}


	public void setTekst_gumb_p(String tekst_gumb_p) {
		this.tekst_gumb_p = tekst_gumb_p;
	}
	
@Column(name="style_gumb",length=10)

	
	public String getStyle_gumb() {
		return style_gumb;
	}


	public void setStyle_gumb(String style_gumb) {
		this.style_gumb = style_gumb;
	}

@Column(name="tekst_gumb",length=15)

	public String getTekst_gumb() {
		return tekst_gumb;
	}


	public void setTekst_gumb(String tekst_gumb) {
		this.tekst_gumb = tekst_gumb;
	}
@Column(name="uporabi_excel",length=1)

	
	
	public String getUporabi_excel() {
		return uporabi_excel;
	}
	public void setUporabi_excel(String uporabi_excel) {
		this.uporabi_excel = uporabi_excel;
	}
	
	
@Column(name="target_funkcija",length=55)

	
	public String getTarget_funkcija() {
		return target_funkcija;
	}
	public void setTarget_funkcija(String target_funkcija) {
		this.target_funkcija = target_funkcija;
	}
	
	
@Index(name="target_funkcija_url")
@Column(name="target_funkcija_url")

	public Long getTarget_funkcija_url() {
		return target_funkcija_url;
	}
	public void setTarget_funkcija_url(Long target_funkcija_url) {
		this.target_funkcija_url = target_funkcija_url;
	}
	
	
	
	
@Column(name="upload_pogoj",length=100)

	
	
	public String getUpload_pogoj() {
		return upload_pogoj;
	}
	public void setUpload_pogoj(String uploadPogoj) {
		upload_pogoj = uploadPogoj;
	}
@Column(name="update_polje_uporabi",length=1)

	
	public String getUpdate_polje_uporabi() {
		return update_polje_uporabi;
	}
	public void setUpdate_polje_uporabi(String updatePoljeUporabi) {
		update_polje_uporabi = updatePoljeUporabi;
	}
	
@Column(name="update_polje",length=35)

	public String getUpdate_polje() {
		return update_polje;
	}
	public void setUpdate_polje(String updatePolje) {
		update_polje = updatePolje;
	}
	
@Column(name="update_polje_vrednost",length=70)

	public String getUpdate_polje_vrednost() {
		return update_polje_vrednost;
	}
	public void setUpdate_polje_vrednost(String updatePoljeVrednost) {
		update_polje_vrednost = updatePoljeVrednost;
	}
@Column(name="target_frame",length=70)

	
	public String getTarget_frame() {
		return target_frame;
	}
	public void setTarget_frame(String target_frame) {
		this.target_frame = target_frame;
	}
@Column(name="url_gumb",length=70)

	
	public String getUrl_gumb() {
		return url_gumb;
	}
	public void setUrl_gumb(String url_gumb) {
		this.url_gumb = url_gumb;
	}
@Column(name="uporabi",length=1)

	
	public String getUporabi() {
		return uporabi;
	}
	public void setUporabi(String uporabi) {
		this.uporabi = uporabi;
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
	
@Index(name="templatehead_id")
@Column(name="templatehead_id")

	public Long getTemplatehead_id() {
		return templatehead_id;
	}
	public void setTemplatehead_id(Long templatehead_id) {
		this.templatehead_id = templatehead_id;
	}
	
	
@Column(name="max_st_izpisov")

	public Integer getMax_st_izpisov() {
		return max_st_izpisov;
	}
	public void setMax_st_izpisov(Integer max_st_izpisov) {
		this.max_st_izpisov = max_st_izpisov;
	}
	
@Column(name="font_size_head")

	public Integer getFont_size_head() {
		return font_size_head;
	}
	public void setFont_size_head(Integer font_size_head) {
		this.font_size_head = font_size_head;
	}
	
@Column(name="font_size_list")

	public Integer getFont_size_list() {
		return font_size_list;
	}
	public void setFont_size_list(Integer font_size_list) {
		this.font_size_list = font_size_list;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((font_size_head == null) ? 0 : font_size_head.hashCode());
		result = prime * result
				+ ((font_size_list == null) ? 0 : font_size_list.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((max_st_izpisov == null) ? 0 : max_st_izpisov.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateMailList other = (TemplateMailList) obj;
		if (font_size_head == null) {
			if (other.font_size_head != null)
				return false;
		} else if (!font_size_head.equals(other.font_size_head))
			return false;
		if (font_size_list == null) {
			if (other.font_size_list != null)
				return false;
		} else if (!font_size_list.equals(other.font_size_list))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (max_st_izpisov == null) {
			if (other.max_st_izpisov != null)
				return false;
		} else if (!max_st_izpisov.equals(other.max_st_izpisov))
			return false;
		if (templatehead_id == null) {
			if (other.templatehead_id != null)
				return false;
		} else if (!templatehead_id.equals(other.templatehead_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	




	

	
	
	
	
	
	
	
	
	
	
	
	

}
