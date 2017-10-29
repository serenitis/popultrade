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
@Table (name="templatelist")


public class TemplateList extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = 1432534265462463388L;
	private Long id;
	private Long templatehead_id;
	private String stolpec_naziv; /// naziv, samo za pregled
	private String stolpec_width; /// sirina stolpca lahko v % ali px
	private String stolpec_align; /// align: center,left, right
	private Integer zaporedje; /// zaporedje prikaza stolpcev
	private String stolpec_metoda; /// metoda v model classi
	private String format_stolpca; /// format za datum ali numeric
	
	
	private String stolpec_max_width;
	private String stolpec_max_width_uporabi;
	
	
	private String stolpec_checkbox; /// v primeru, da uporabim checkboxe za stolpec (multi izbira), v tem primeru je stolpec_metoda vrednost podana kot multi izbira
	
	
	
	private String jeslika; /// ce je slika polje
	private Integer slika_width; //// sizrina slike
	private Integer slika_height; /// visina slike
	
	private String uporabi_onmouseover_prikaz; /// prikaze vrednost v obliki hinta, v polje za hint da vrednosti stolpec_metoda v bolje hint da vrdnost iz gumba pp value iz druge clase
	private String tip_sestevka;
	
	
	
	private String hint_pomoc; /// tekst za pomoc, 1-je , 0-ni

	
	
	private String stolpec_primaren; /// primaren stolpec, ki prikaze vedno
	private String stolpec_sekundaren; /// sekundaren stolpec ki prikaze le ko ga zberes
	private String stolpec_order; /// order kliknes gor in prikaze order by po tem stolpcu, najprej asc, potem desc
	private String stolpec_fiksen; /// stolpec ne moras odstraniti
	
	

	    private String uporabi_div_vrednost;
	    private String uporabi_div_ime;

	private String stolpec_prikazi_mail;
	
	private String pogoj_prikaz_stolpec; /// if pogoj za prikaz stolpca
	
	private String jeslikaizbaze;/// ce je slika iz baze
	private Long templateprikazslike; /// template ki klicem z idjem za prikaz slike, tipa OB
	private String navodila_obdelana; /// navodila opravljena, da ne
	private String navodila; /// navodila tekst

	private List prevodis = new ArrayList();


	
	
	private String css_value; /// css for value field

	@Column(name="css_value",length=35)


	public String getCss_value() {
		return css_value;
	}

	public void setCss_value(String css_value) {
		this.css_value = css_value;
	}


	
	
	
	
	private List templatepdfparametris = new ArrayList();


	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplatePdfParametri.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="veza_id",referencedColumnName="id")

	

	public List getTemplatepdfparametris() {
		return templatepdfparametris;
	}

	public void setTemplatepdfparametris(List templatepdfparametris) {
		this.templatepdfparametris = templatepdfparametris;
	}

	
	


	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="prevod_id",referencedColumnName="id")


	public List getPrevodis() {
		return prevodis;
	}

	public void setPrevodis(List prevodis) {
		this.prevodis = prevodis;
	}


@Column(name="navodila_obdelana",length=1)



	public String getNavodila_obdelana() {
		return navodila_obdelana;
	}
	public void setNavodila_obdelana(String navodila_obdelana) {
		this.navodila_obdelana = navodila_obdelana;
	}

@Column(name="navodila",length=4000)


	public String getNavodila() {
		return navodila;
	}
	public void setNavodila(String navodila) {
		this.navodila = navodila;
	}

@Column(name="jeslikaizbaze",length=1)



	public String getJeslikaizbaze() {
		return jeslikaizbaze;
	}
	public void setJeslikaizbaze(String jeslikaizbaze) {
		this.jeslikaizbaze = jeslikaizbaze;
	}

@Column(name="templateprikazslike")

	public Long getTemplateprikazslike() {
		return templateprikazslike;
	}
	public void setTemplateprikazslike(Long templateprikazslike) {
		this.templateprikazslike = templateprikazslike;
	}
	
	
@Column(name="pogoj_prikaz_stolpec",length=500)

	
	
	public String getPogoj_prikaz_stolpec() {
		return pogoj_prikaz_stolpec;
	}


	public void setPogoj_prikaz_stolpec(String pogojPrikazStolpec) {
		pogoj_prikaz_stolpec = pogojPrikazStolpec;
	}


@Column(name="stolpec_prikazi_mail",length=1)

	
		public String getStolpec_prikazi_mail() {
		return stolpec_prikazi_mail;
	}


	public void setStolpec_prikazi_mail(String stolpecPrikaziMail) {
		stolpec_prikazi_mail = stolpecPrikaziMail;
	}


@Column(name="uporabi_div_vrednost",length=1)

	
	
	public String getUporabi_div_vrednost() {
			return uporabi_div_vrednost;
		}


		public void setUporabi_div_vrednost(String uporabiDivVrednost) {
			uporabi_div_vrednost = uporabiDivVrednost;
		}

@Column(name="uporabi_div_ime",length=55)

		public String getUporabi_div_ime() {
			return uporabi_div_ime;
		}


		public void setUporabi_div_ime(String uporabiDivIme) {
			uporabi_div_ime = uporabiDivIme;
		}


@Column(name="stolpec_fiksen",length=1)

	
	public String getStolpec_fiksen() {
		return stolpec_fiksen;
	}


	public void setStolpec_fiksen(String stolpec_fiksen) {
		this.stolpec_fiksen = stolpec_fiksen;
	}


@Column(name="stolpec_primaren",length=1)


	public String getStolpec_primaren() {
		return stolpec_primaren;
	}


	public void setStolpec_primaren(String stolpec_primaren) {
		this.stolpec_primaren = stolpec_primaren;
	}

@Column(name="stolpec_sekundaren",length=1)

	public String getStolpec_sekundaren() {
		return stolpec_sekundaren;
	}


	public void setStolpec_sekundaren(String stolpec_sekundaren) {
		this.stolpec_sekundaren = stolpec_sekundaren;
	}

@Column(name="stolpec_order",length=1)

	public String getStolpec_order() {
		return stolpec_order;
	}


	public void setStolpec_order(String stolpec_order) {
		this.stolpec_order = stolpec_order;
	}


@Column(name="hint_pomoc",length=1)




	public String getHint_pomoc() {
		return hint_pomoc;
	}


	public void setHint_pomoc(String hint_pomoc) {
		this.hint_pomoc = hint_pomoc;
	}
	
	
	
	
	
@Column(name="tip_sestevka",length=10)

	
	public String getTip_sestevka() {
		return tip_sestevka;
	}


	public void setTip_sestevka(String tip_sestevka) {
		this.tip_sestevka = tip_sestevka;
	}


@Column(name="uporabi_onmouseover_prikaz",length=1)

	
	public String getUporabi_onmouseover_prikaz() {
		return uporabi_onmouseover_prikaz;
	}


	public void setUporabi_onmouseover_prikaz(String uporabi_onmouseover_prikaz) {
		this.uporabi_onmouseover_prikaz = uporabi_onmouseover_prikaz;
	}


@Column(name="jeslika",length=1)

	
	
	public String getJeslika() {
		return jeslika;
	}


	public void setJeslika(String jeslika) {
		this.jeslika = jeslika;
	}

@Column(name="slika_width")

	public Integer getSlika_width() {
		return slika_width;
	}


	public void setSlika_width(Integer slika_width) {
		this.slika_width = slika_width;
	}

@Column(name="slika_height")

	public Integer getSlika_height() {
		return slika_height;
	}


	public void setSlika_height(Integer slika_height) {
		this.slika_height = slika_height;
	}


@Column(name="stolpec_checkbox",length=1)

	
	public String getStolpec_checkbox() {
		return stolpec_checkbox;
	}


	public void setStolpec_checkbox(String stolpec_checkbox) {
		this.stolpec_checkbox = stolpec_checkbox;
	}


	/// vezava na TemplateClass, ce jo ima
@Column(name="stolpec_max_width",length=3)

	public String getStolpec_max_width() {
		return stolpec_max_width;
	}


	public void setStolpec_max_width(String stolpec_max_width) {
		this.stolpec_max_width = stolpec_max_width;
	}

@Column(name="stolpec_max_width_uporabi",length=1)

	public String getStolpec_max_width_uporabi() {
		return stolpec_max_width_uporabi;
	}


	public void setStolpec_max_width_uporabi(String stolpec_max_width_uporabi) {
		this.stolpec_max_width_uporabi = stolpec_max_width_uporabi;
	}


	private List templateClasses = new ArrayList();
	
	
	private TemplateClassClass templateClassClass = new TemplateClassClass();
	
	

@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templatelist")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateClassClass getTemplateClassClass() {
		return templateClassClass;
	}


	public void setTemplateClassClass(TemplateClassClass templateClassClass) {
		this.templateClassClass = templateClassClass;
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


	
@Index(name="templatehead_id")
@Column(name="templatehead_id")

	public Long getTemplatehead_id() {
		return templatehead_id;
	}


	public void setTemplatehead_id(Long templatehead_id) {
		this.templatehead_id = templatehead_id;
	}

@Column(name="stolpec_naziv",length=70)

	public String getStolpec_naziv() {
		return stolpec_naziv;
	}


	public void setStolpec_naziv(String stolpec_naziv) {
		this.stolpec_naziv = stolpec_naziv;
	}

@Column(name="stolpec_width",length=10)

	public String getStolpec_width() {
		return stolpec_width;
	}


	public void setStolpec_width(String stolpec_width) {
		this.stolpec_width = stolpec_width;
	}

@Column(name="stolpec_align",length=10)

	public String getStolpec_align() {
		return stolpec_align;
	}


	public void setStolpec_align(String stolpec_align) {
		this.stolpec_align = stolpec_align;
	}

@Column(name="zaporedje",length=4)

	public Integer getZaporedje() {
		return zaporedje;
	}


	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
	}

@Column(name="stolpec_metoda",length=55)

	public String getStolpec_metoda() {
		return stolpec_metoda;
	}


	public void setStolpec_metoda(String stolpec_metoda) {
		this.stolpec_metoda = stolpec_metoda;
	}


	
@Column(name="format_stolpca",length=20)

	public String getFormat_stolpca() {
		return format_stolpca;
	}


	public void setFormat_stolpca(String format_stolpca) {
		this.format_stolpca = format_stolpca;
	}

	
	
	



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((format_stolpca == null) ? 0 : format_stolpca.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((stolpec_align == null) ? 0 : stolpec_align.hashCode());
		result = prime * result
				+ ((stolpec_metoda == null) ? 0 : stolpec_metoda.hashCode());
		result = prime * result
				+ ((stolpec_naziv == null) ? 0 : stolpec_naziv.hashCode());
		result = prime * result
				+ ((stolpec_width == null) ? 0 : stolpec_width.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
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
		TemplateList other = (TemplateList) obj;
		if (format_stolpca == null) {
			if (other.format_stolpca != null)
				return false;
		} else if (!format_stolpca.equals(other.format_stolpca))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (stolpec_align == null) {
			if (other.stolpec_align != null)
				return false;
		} else if (!stolpec_align.equals(other.stolpec_align))
			return false;
		if (stolpec_metoda == null) {
			if (other.stolpec_metoda != null)
				return false;
		} else if (!stolpec_metoda.equals(other.stolpec_metoda))
			return false;
		if (stolpec_naziv == null) {
			if (other.stolpec_naziv != null)
				return false;
		} else if (!stolpec_naziv.equals(other.stolpec_naziv))
			return false;
		if (stolpec_width == null) {
			if (other.stolpec_width != null)
				return false;
		} else if (!stolpec_width.equals(other.stolpec_width))
			return false;
		if (templatehead_id == null) {
			if (other.templatehead_id != null)
				return false;
		} else if (!templatehead_id.equals(other.templatehead_id))
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
