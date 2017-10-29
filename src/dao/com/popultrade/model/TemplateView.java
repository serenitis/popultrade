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
@Table (name="templateview")


public class TemplateView extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = 1432534265462463388L;
	private Long id;
	private Long templatehead_id;
	private String stolpec_naziv; /// naziv, samo za pregled
	
	private String stolpec_align; /// align: center,left, right
	private Integer zaporedje; /// zaporedje prikaza stolpcev
	private String stolpec_metoda; /// metoda v model classi
	private String format_stolpca; /// format za datum ali numeric
	private Long templateview_id; /// veza na template view nad njim, za logiko prikaza v istem polju

	
	private String tip_polja; /// tip polja lahko je vrednost ali pa prazno (za izdelavo izgleda)
	private List templateClasses = new ArrayList();
	 
	
	

	private String pdf_header; /// ce gre za header , velja le na zacetku

	
	private String tip_sestevka;
	
	
	
	
	
	private String jeslika; /// ce je slika polje
	private Integer slika_width; //// sizrina slike
	private Integer slika_height; /// visina slike
	
	private TemplateUiDodatno templateuidodatno = new TemplateUiDodatno();
	private String hint_pomoc; /// tekst za pomoc, 1-je , 0-ni


	
	private String jeslikaizbaze;/// ce je slika iz baze
	private Long templateprikazslike; /// template ki klicem z idjem za prikaz slike, tipa OB
	private String navodila_obdelana; /// navodila opravljena, da ne
	private String navodila; /// navodila tekst

	private List prevodis = new ArrayList();
private List templateclasspps = new ArrayList();


private String css_value; /// css for value field
private String css_translation; /// css for translation field


@Column(name="css_value",length=35)


public String getCss_value() {
	return css_value;
}

public void setCss_value(String css_value) {
	this.css_value = css_value;
}

@Column(name="css_translation",length=35)

public String getCss_translation() {
	return css_translation;
}

public void setCss_translation(String css_translation) {
	this.css_translation = css_translation;
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








@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateClassPP.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templateclass_id",referencedColumnName="id")





	public List getTemplateclasspps() {
	return templateclasspps;
}

public void setTemplateclasspps(List templateclasspps) {
	this.templateclasspps = templateclasspps;
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
	
	
	
	
@Column(name="hint_pomoc",length=1)




	public String getHint_pomoc() {
		return hint_pomoc;
	}


	public void setHint_pomoc(String hint_pomoc) {
		this.hint_pomoc = hint_pomoc;
	}

	
	
@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.LAZY,mappedBy="templateview")
//@JoinColumn(name="templateui_id",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)

	public TemplateUiDodatno getTemplateuidodatno() {
		return templateuidodatno;
	}


	public void setTemplateuidodatno(TemplateUiDodatno templateuidodatno) {
		this.templateuidodatno = templateuidodatno;
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
	
	
	
@Column(name="tip_sestevka",length=10)

	

	public String getTip_sestevka() {
		return tip_sestevka;
	}


	public void setTip_sestevka(String tip_sestevka) {
		this.tip_sestevka = tip_sestevka;
	}


@Column(name="pdf_header",length=1)

	public String getPdf_header() {
		return pdf_header;
	}


	public void setPdf_header(String pdf_header) {
		this.pdf_header = pdf_header;
	}

	

	private List templateviews = new ArrayList(); /// list vseh templateui pod template ui


@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateView.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templateview_id",referencedColumnName="id")
@OrderBy("zaporedje")


	public List getTemplateviews() {
		return templateviews;
	}


	public void setTemplateviews(List templateviews) {
		this.templateviews = templateviews;
	}
	
	
	
	
	
	
	
@Column(name="templateview_id")



	public Long getTemplateview_id() {
		return templateview_id;
	}


	public void setTemplateview_id(Long templateview_id) {
		this.templateview_id = templateview_id;
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
	/// vezava na TemplateClass, ce jo ima
	
	
	private TemplateClass templateClass  = new TemplateClass();


@Column(name="tip_polja",length=2)

	public String getTip_polja() {
		return tip_polja;
	}


	public void setTip_polja(String tip_polja) {
		this.tip_polja = tip_polja;
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

	
	
	

//@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.LAZY,mappedBy="templateview")
//@JoinColumn(name="id")
//@NotFound(action = NotFoundAction.IGNORE)

/*	public TemplateClass getTemplateClass() {
		return templateClass;
	}


	public void setTemplateClass(TemplateClass templateClass) {
		this.templateClass = templateClass;
	}*/


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
			
				+ ((templateClass == null) ? 0 : templateClass.hashCode());
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
		TemplateView other = (TemplateView) obj;
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
		if (templateClass == null) {
			if (other.templateClass != null)
				return false;
		} else if (!templateClass.equals(other.templateClass))
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
