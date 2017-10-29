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
@Table (name="templategumbi")


public class TemplateGumbi extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 1098765432345346566L;
	private Long id;
	private Long templatehead_id;
	private String opis_gumba;
	private String lokacija_gumba; /// ali v hint vrstici ali na vsakem elementu
	private String url_gumba;/// gif gumba
	private Integer zaporedje; /// zaporedje gumbov
	private String target_gumba; /// v katerem frame se odpre vsebina po pritisku na gumb 
	private String klici_funkcijo; /// klicem funkcijo, npr brisi
	private Long veza_template; /// veza na id gumba
	
	private String vrednosti_iz_checkbox; /// v primeru, da vrednosti dobim iz checkboxa
	
	private String uporabi_alert; /// uporaba alerta oz. js prompta po kliku na gumb
	
	private String hint_pomoc; /// tekst za pomoc, 1-je , 0-ni
 
	private String onemogoci_gumbe; /// onemogocim ostale gumbe ko klikne gumb in potrdi potrditveno okno
	
	
	private String zamenjaj_url_gumba;/// url gumba , ki se zamenja ob kliku na gumb
	
	private String zamenjaj_uporabi_pogoj; /// uporabim gumb iz zamenjaj_url_gumba namesto url_gumba , ce pogoj ustreza
	
	
	private String rocni_url; /// url, ki vnesem rocno
	

    private String prikazi_gumb_z_js;
    private String prikazi_gumb_ime;

	private String uporabi_alert_fun; /// funkcija pri uporabi alerta, klice se to funkcijo ko klikne na gumb, dela le ce je oznaceno uporabi_alert
	
	
	
	private String style_gumb; /// barva gumba, iz stylov v js
	private String tekst_gumb; /// tekst na gumbu
	
	
	private String style_gumb_p; /// barva gumba po kliku na gumb, iz stylov v js
	private String tekst_gumb_p; /// tekst na gumbu po kliku na gumb

	
	private String size_left; /// sirina levega frameta ce razdeli na dva
	private String size_right; /// sirina desnega frameta ce razdeli na dva
	
	private String target_rocni; /// rocni target (parent.frame opcija)
	
	
	
	private String dodaten_js_function; /// javascript funkcija ki klices po confirmu, ce je, v primeru submita se klice pred submiton, submit form se naredi le za prvi getVrednosti_iz_checkbox=1 
											/// iz kjer se vzame action lokacijo
	@Column(name="dodaten_js_function",length=70)
	
	
	public String getDodaten_js_function() {
		return dodaten_js_function;
	}

	public void setDodaten_js_function(String dodaten_js_function) {
		this.dodaten_js_function = dodaten_js_function;
	}

	
	
	@Column(name="target_rocni",length=90)

	
	
	public String getTarget_rocni() {
		return target_rocni;
	}

	public void setTarget_rocni(String target_rocni) {
		this.target_rocni = target_rocni;
	}

	@Column(name="size_left",length=4)

	public String getSize_left() {
		return size_left;
	}

	public void setSize_left(String size_left) {
		this.size_left = size_left;
	}

	
	@Column(name="size_right",length=4)
	public String getSize_right() {
		return size_right;
	}

	public void setSize_right(String size_right) {
		this.size_right = size_right;
	}


	private List prevodis = new ArrayList();




	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="prevod_id",referencedColumnName="id")


	public List getPrevodis() {
		return prevodis;
	}

	public void setPrevodis(List prevodis) {
		this.prevodis = prevodis;
	}
	
	
	
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


@Column(name="uporabi_alert_fun",length=500)

	
	public String getUporabi_alert_fun() {
		return uporabi_alert_fun;
	}


	public void setUporabi_alert_fun(String uporabiAlertFun) {
		uporabi_alert_fun = uporabiAlertFun;
	}


@Column(name="prikazi_gumb_z_js",length=1)


	public String getPrikazi_gumb_z_js() {
		return prikazi_gumb_z_js;
	}


	public void setPrikazi_gumb_z_js(String prikaziGumbZJs) {
		prikazi_gumb_z_js = prikaziGumbZJs;
	}

@Column(name="prikazi_gumb_ime",length=50)

	public String getPrikazi_gumb_ime() {
		return prikazi_gumb_ime;
	}


	public void setPrikazi_gumb_ime(String prikaziGumbIme) {
		prikazi_gumb_ime = prikaziGumbIme;
	}


@Column(name="rocni_url",length=250)

	
	
	
	public String getRocni_url() {
		return rocni_url;
	}


	public void setRocni_url(String rocni_url) {
		this.rocni_url = rocni_url;
	}
	
@Column(name="zamenjaj_uporabi_pogoj",length=400)

	
	public String getZamenjaj_uporabi_pogoj() {
		return zamenjaj_uporabi_pogoj;
	}


	public void setZamenjaj_uporabi_pogoj(String zamenjaj_uporabi_pogoj) {
		this.zamenjaj_uporabi_pogoj = zamenjaj_uporabi_pogoj;
	}


@Column(name="zamenjaj_url_gumba",length=200)

	
	public String getZamenjaj_url_gumba() {
		return zamenjaj_url_gumba;
	}


	public void setZamenjaj_url_gumba(String zamenjaj_url_gumba) {
		this.zamenjaj_url_gumba = zamenjaj_url_gumba;
	}


@Column(name="onemogoci_gumbe",length=1)


	public String getOnemogoci_gumbe() {
		return onemogoci_gumbe;
	}


	public void setOnemogoci_gumbe(String onemogoci_gumbe) {
		this.onemogoci_gumbe = onemogoci_gumbe;
	}


@Column(name="hint_pomoc",length=1)




	public String getHint_pomoc() {
		return hint_pomoc;
	}


	public void setHint_pomoc(String hint_pomoc) {
		this.hint_pomoc = hint_pomoc;
	}
	
@Column(name="uporabi_alert",length=1)

	
	public String getUporabi_alert() {
		return uporabi_alert;
	}
	public void setUporabi_alert(String uporabi_alert) {
		this.uporabi_alert = uporabi_alert;
	}
@Column(name="vrednosti_iz_checkbox",length=1)

	
	
	public String getVrednosti_iz_checkbox() {
		return vrednosti_iz_checkbox;
	}
	public void setVrednosti_iz_checkbox(String vrednosti_iz_checkbox) {
		this.vrednosti_iz_checkbox = vrednosti_iz_checkbox;
	}

	
	private TemplateHead templateHead = new TemplateHead();
	
	
	
	@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.LAZY,mappedBy="templategumbi")
	//@JoinColumn(name="templatehead_id",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	

	public TemplateHead getTemplateHead() {
		return templateHead;
	}


	public void setTemplateHead(TemplateHead templateHead) {
		this.templateHead = templateHead;
	}


	private TemplateClass templateClass = new TemplateClass();
	
	
	

@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.LAZY,mappedBy="templategumbi")
//@JoinColumn(name="templatehead_id",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateClass getTemplateClass() {
		return templateClass;
	}
	public void setTemplateClass(TemplateClass templateClass) {
		this.templateClass = templateClass;
	}
	



	private List templateGumbiParametris= new ArrayList();
	

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateGumbiParametri.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templategumb_id",referencedColumnName="id")

	
	public List getTemplateGumbiParametris() {
		return templateGumbiParametris;
	}
	public void setTemplateGumbiParametris(List templateGumbiParametris) {
		this.templateGumbiParametris = templateGumbiParametris;
	}
@Index(name="veza_template")
@Column(name="veza_template")

	
	public Long getVeza_template() {
		return veza_template;
	}
	public void setVeza_template(Long veza_template) {
		this.veza_template = veza_template;
	}
@Column(name="klici_funkcijo",length=35)

	public String getKlici_funkcijo() {
		return klici_funkcijo;
	}
	public void setKlici_funkcijo(String klici_funkcijo) {
		this.klici_funkcijo = klici_funkcijo;
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
	
	
@Column(name="opis_gumba",length=350)

	public String getOpis_gumba() {
		return opis_gumba;
	}
	public void setOpis_gumba(String opis_gumba) {
		this.opis_gumba = opis_gumba;
	}
	
@Column(name="lokacija_gumba",length=2)

	public String getLokacija_gumba() {
		return lokacija_gumba;
	}
	public void setLokacija_gumba(String lokacija_gumba) {
		this.lokacija_gumba = lokacija_gumba;
	}
	
@Column(name="url_gumba",length=200)

	public String getUrl_gumba() {
		return url_gumba;
	}
	public void setUrl_gumba(String url_gumba) {
		this.url_gumba = url_gumba;
	}
	
@Column(name="zaporedje")

	public Integer getZaporedje() {
		return zaporedje;
	}
	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
	}
	
@Column(name="target_gumba",length=70)

	public String getTarget_gumba() {
		return target_gumba;
	}
	public void setTarget_gumba(String target_gumba) {
		this.target_gumba = target_gumba;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((lokacija_gumba == null) ? 0 : lokacija_gumba.hashCode());
		result = prime * result
				+ ((opis_gumba == null) ? 0 : opis_gumba.hashCode());
		result = prime * result
				+ ((target_gumba == null) ? 0 : target_gumba.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
		result = prime * result
				+ ((url_gumba == null) ? 0 : url_gumba.hashCode());
		result = prime * result
				+ ((zaporedje == null) ? 0 : zaporedje.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateGumbi other = (TemplateGumbi) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (lokacija_gumba == null) {
			if (other.lokacija_gumba != null)
				return false;
		} else if (!lokacija_gumba.equals(other.lokacija_gumba))
			return false;
		if (opis_gumba == null) {
			if (other.opis_gumba != null)
				return false;
		} else if (!opis_gumba.equals(other.opis_gumba))
			return false;
		if (target_gumba == null) {
			if (other.target_gumba != null)
				return false;
		} else if (!target_gumba.equals(other.target_gumba))
			return false;
		if (templatehead_id == null) {
			if (other.templatehead_id != null)
				return false;
		} else if (!templatehead_id.equals(other.templatehead_id))
			return false;
		if (url_gumba == null) {
			if (other.url_gumba != null)
				return false;
		} else if (!url_gumba.equals(other.url_gumba))
			return false;
		if (zaporedje == null) {
			if (other.zaporedje != null)
				return false;
		} else if (!zaporedje.equals(other.zaporedje))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	

}
