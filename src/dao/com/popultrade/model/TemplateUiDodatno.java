package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import java.io.Serializable;


@Entity
@Table (name="templateuidodatno")


public class TemplateUiDodatno extends BaseObject implements Serializable {

	private static final long serialVersionUID = 4325658679876463471L;
	private Long id;
	private Long templateui_id;
	private String dodatno_javascript;
	private String dodatno_java;
	private String dodatno_insert;
	private String dodatno_update;
	

	private String dodatno_delete;
	private String dodatno_java_default;
	
	
	private String dodatno_javascript_onload; /// dodatno javascrippt pri loadu oz body onload
	
	
	private String dodatno_javascript_funkcije; /// dodatne funkcije
	
	private String dodatno_java_test; /// dodatne funkcije
	
	
	
	private String dodatno_java_rocno; /// dodatno rocno java, za uporabo nepredvidenih izvajanj kod
	private String dodatno_java_rocno2; /// del 2
	
	private String dodatno_java_updateinsert; /// dodatno java po kliku na gumb potrdi, ko se konca vse pod update ali insert ali klicu funkcije
	
	
//	private String izklopi_insert_avtomaticno; /// ko kliknem na potrdi gumb se ne uporabi insert
//	private String izklopi_update_avtomaticno;
	
	
	private String dodatno_javascript2;
	
	
	private String dodatno_html; /// dodatno html pred potrdi gumb - pred tr-jem
	private String dodatno_html2; /// dodatno html2 pred potrdi gumb - pred tr-jem
	
	
	
	
	private String dodatno_css; /// dodatno css samo za novi del aplikacije

	

	private TemplateHead templatehead ;
	
	
	private TemplateUi templateui;
	
	
	private TemplateView templateview;
	
	
	
	
	@OneToOne
    @JoinColumn(name = "templateui_id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)

	
	
	public TemplateView getTemplateview() {
		return templateview;
	}
	public void setTemplateview(TemplateView templateview) {
		this.templateview = templateview;
	}
	
	
	
	@OneToOne
    @JoinColumn(name = "templateui_id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
	
	
	
	public TemplateUi getTemplateui() {
		return templateui;
	}
	public void setTemplateui(TemplateUi templateui) {
		this.templateui = templateui;
	}
	
	
	
	
	
	@OneToOne
    @JoinColumn(name = "templateui_id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
public TemplateHead getTemplatehead() {
		return templatehead;
	}
	public void setTemplatehead(TemplateHead templatehead) {
		this.templatehead = templatehead;
	}
	
	
	
	
	@Column(name="dodatno_html2",length=4000)

	
	
	public String getDodatno_html2() {
		return dodatno_html2;
	}
	public void setDodatno_html2(String dodatno_html2) {
		this.dodatno_html2 = dodatno_html2;
	}
	
	
	
	
	@Column(name="dodatno_html",length=4000)

	
	
	public String getDodatno_html() {
		return dodatno_html;
	}
	public void setDodatno_html(String dodatno_html) {
		this.dodatno_html = dodatno_html;
	}
	@Column(name="dodatno_css",length=4000)

	
	
public String getDodatno_css() {
		return dodatno_css;
	}
	public void setDodatno_css(String dodatno_css) {
		this.dodatno_css = dodatno_css;
	}
@Column(name="dodatno_javascript2")

	
	
	public String getDodatno_javascript2() {
		return dodatno_javascript2;
	}
	public void setDodatno_javascript2(String dodatnoJavascript2) {
		dodatno_javascript2 = dodatnoJavascript2;
	}
@Column(name="dodatno_java_updateinsert")

	
	
	
	public String getDodatno_java_updateinsert() {
		return dodatno_java_updateinsert;
	}
	public void setDodatno_java_updateinsert(String dodatno_java_updateinsert) {
		this.dodatno_java_updateinsert = dodatno_java_updateinsert;
	}
	
	
@Column(name="dodatno_java_rocno2")

	public String getDodatno_java_rocno2() {
		return dodatno_java_rocno2;
	}
	public void setDodatno_java_rocno2(String dodatno_java_rocno2) {
		this.dodatno_java_rocno2 = dodatno_java_rocno2;
	}
	
	
	
@Column(name="dodatno_java_rocno")

	public String getDodatno_java_rocno() {
		return dodatno_java_rocno;
	}
	public void setDodatno_java_rocno(String dodatno_java_rocno) {
		this.dodatno_java_rocno = dodatno_java_rocno;
	}
@Column(name="dodatno_java_test")

	
	
	public String getDodatno_java_test() {
		return dodatno_java_test;
	}
	public void setDodatno_java_test(String dodatno_java_test) {
		this.dodatno_java_test = dodatno_java_test;
	}
@Column(name="dodatno_javascript_funkcije")

	
	
	public String getDodatno_javascript_funkcije() {
		return dodatno_javascript_funkcije;
	}
	public void setDodatno_javascript_funkcije(String dodatno_javascript_funkcije) {
		this.dodatno_javascript_funkcije = dodatno_javascript_funkcije;
	}
@Column(name="dodatno_javascript_onload")

	
	
	public String getDodatno_javascript_onload() {
		return dodatno_javascript_onload;
	}
	public void setDodatno_javascript_onload(String dodatno_javascript_onload) {
		this.dodatno_javascript_onload = dodatno_javascript_onload;
	}
@Column(name="dodatno_java_default")

	
	public String getDodatno_java_default() {
		return dodatno_java_default;
	}
	public void setDodatno_java_default(String dodatno_java_default) {
		this.dodatno_java_default = dodatno_java_default;
	}
@Column(name="dodatno_delete")

	public String getDodatno_delete() {
		return dodatno_delete;
	}
	public void setDodatno_delete(String dodatno_delete) {
		this.dodatno_delete = dodatno_delete;
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
	
	
@Index(name="templateui_id")
@Column(name="templateui_id")

	public Long getTemplateui_id() {
		return templateui_id;
	}
	public void setTemplateui_id(Long templateui_id) {
		this.templateui_id = templateui_id;
	}
	
	
	
@Column(name="dodatno_javascript")

	public String getDodatno_javascript() {
		return dodatno_javascript;
	}
	public void setDodatno_javascript(String dodatno_javascript) {
		this.dodatno_javascript = dodatno_javascript;
	}
	
	
@Column(name="dodatno_java")

	public String getDodatno_java() {
		return dodatno_java;
	}
	public void setDodatno_java(String dodatno_java) {
		this.dodatno_java = dodatno_java;
	}
	
@Column(name="dodatno_insert")

	public String getDodatno_insert() {
		return dodatno_insert;
	}
	public void setDodatno_insert(String dodatno_insert) {
		this.dodatno_insert = dodatno_insert;
	}
	
	
@Column(name="dodatno_update")

	public String getDodatno_update() {
		return dodatno_update;
	}
	public void setDodatno_update(String dodatno_update) {
		this.dodatno_update = dodatno_update;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((dodatno_insert == null) ? 0 : dodatno_insert.hashCode());
		result = prime * result
				+ ((dodatno_java == null) ? 0 : dodatno_java.hashCode());
		result = prime
				+ ((dodatno_javascript == null) ? 0 : dodatno_javascript
						.hashCode());
		result = prime * result
				+ ((dodatno_update == null) ? 0 : dodatno_update.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		TemplateUiDodatno other = (TemplateUiDodatno) obj;
		if (dodatno_insert == null) {
			if (other.dodatno_insert != null)
				return false;
		} else if (!dodatno_insert.equals(other.dodatno_insert))
			return false;
		if (dodatno_java == null) {
			if (other.dodatno_java != null)
				return false;
		} else if (!dodatno_java.equals(other.dodatno_java))
			return false;
		if (dodatno_javascript == null) {
			if (other.dodatno_javascript != null)
				return false;
		} else if (!dodatno_javascript.equals(other.dodatno_javascript))
			return false;
		if (dodatno_update == null) {
			if (other.dodatno_update != null)
				return false;
		} else if (!dodatno_update.equals(other.dodatno_update))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
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
