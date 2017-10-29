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
@Table (name="templatehead")

 
public class TemplateHead  extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 583577992147367230L;
	private Long id;
	private String head_naziv;
	private int zaporedje; /// zaporedje prikaza zapisa na ekranu
	private String opis; /// opis
	private String head_tip; /// tip headerja, iz sifranta, tipi so lahko za zdaj insert, update, list, pregled
	private Long class_id; /// vezava na tabelo s pogoji clasami
	private String head_class_name; /// ime clase vezane na template
	private String head_select_dodatni_pogoji; /// lahko dodas order by
	private String order_by_smer; /// asc, desc order by
	private Long veza_gumb; /// veza na gumb, ce je vrednost ne prikazem pri pregledu v prvi stopnji
	private List templateHeadResets = new ArrayList();
	private String target_isci; /// kam naj odpre isci rezultate v primeru da gre za head_tip isci
	private List templatePPs = new ArrayList();
	private String parsaj_excel;
	
	private String target_funkcija;
	private Long target_funkcija_url;
	
	private String zacetek_procedure; /// procedura sestavljena iz treh delov, zacetek + parametri iz templateclass + konec procedure
	private String konec_procedure;
	
	
	
	private Integer sogumbi;
	
	private String custom_gen; /// generate custom list
	
	
	private List templateFunkcijaStarts = new ArrayList();


	
	
	//// za export
	
	private String lokacija_exporta; /// kam dam datoteko ko exportam
	
	private String tip_exporta; /// export na lokacijo ali export za download

	private String lokacija_exporta_web; /// lokacija exporta na webu
	
	private String uporabi_count;
	
	private String uporabi_count_ld; /// uporabim count po logiki je vecje od max st recordov za ena, premaknem levo 
	
	private Integer max_stevilo_recordov;
	
	
	private TemplateMailList templatemaillist = new TemplateMailList();
	

    private String upload_extension;
    private String upload_tabela;
    private String upload_tabela_stolpec;
    private String upload_lokacija;


    
    private String uporabi_cas_refresh;
    private String uporabi_cas_refresh_n;
    
    
    private String target_search_rocno; /// target ali gumbi css style
    
    
    //// rabi za proceduro v primeru chackboxa
    private String procedura_podatki_checkbox; /// da ne dobim podatke preko procedure
    private String procedura_zacetno_ime_cb; /// ime checkboxa parametra oz. zacetek imena npr id potem sestavim v id___
    private String procedura_ime_neznanke; /// ime neznanke katera vsebuje vrednost trenutnega checkboxa pri loopu
    
  //  private String procedura_zacetno_ime_so; /// ime neznanke ki dobim preko checkboxa za sort
    
    
    private String pdf_dolg; // ce je pdf dolg ga razdelim na vec funkcij, pdf ne mora vec dobiti podatkov preko vse vsebine
    
    private String posebna_funkcija; // posebna funkcija, ki kreiram v hibernate rocno, mora vrnit isto kot original funkcija
    private String posebna_funkcija_pogoj; // posebna funkcija, pogoj kdaj uporabimo
    
    
    private String struktura_tree; /// ce obkljukano se rabi tree strukturo, ki odpira v istem frameto pod kliknjeno vrstico
    private String struktura_tree_head; /// ko odpre list znotraj lista prikaze tudi head
    private String struktura_tree_gumbo; /// gumb odpri
    private String struktura_tree_gumbz; /// gumb zapri
    
    private String nologinneeded; /// ne rabi login za dostopat do strani
    
    
    private String pageisindependent; /// stran je neodvisna, ne doda se frametov in menujev
    
    
    private String alternativesubmit; /// alternativen submit oz. action na formi dod
    
    private String gennamefile; /// ime generirne datoteke (opcijsko)
    
    
    
    private String frameupsize; /// frames size for custom 
    private String frameleftsize; /// char 6
    private String framecentersize; /// char 6
    private String framerightsize; /// char 6
    
    
    
    private String page_title; /// char 70
    private String page_description; /// char 120
    private String page_keywords; /// char 120
    
    
    
    private Long header; /// id templateheaderja, ki se rabi kot header
    private Long footer;/// id templateheaderja, ki se rabi kot footer
    private Long response;/// id templateheaderja, ki se rabi kot response na commit
    private Long inwork; /// id templateheaderja, ki se rabi kot opozorilo, ce se dokument obdeluje
    
    
    private String tip_head_foot; /// ce je header ali footer ali nic
    
    
	private String uporabi_nove_gumbe; /// uporabim nov stil gumbov (css style)
	
	private String zakleni_record; /// polje , ki rabim za zaklenit record in testirat ce ga kdo obdeluje
	private String zakleni_vse; /// zaklenem tako da disablam celoten frame
	
	
	private String procedura_zacetno_ime_so;
	
	private String prisotnost_polje_kontrola; /// polje ki veze uporabnike za update in insert recordov, npr control.getPodjetje
	
	
	private String grafika_css; /// grafika preko cssja - ime datoteke, ce prazna default plava
	
	
	private String nosql; /// ce gre za class iz no sql baze
	private String logall; /// ce logiram vse, za zdaj gre v nosql
	
	private String head_class_name_nosql; /// ime ne embeddable classe, ki je vezana na head_class_name class ki je embeddable
	
	private String head_class_name_nosql2; /// ime ne embeddable - embeddable classe, ki je vezana na head_class_name_nosql2 class ki je embeddable
	
	private String head_class_name_nosql3; /// ime ne embeddable - embeddable classe, ki je vezana na head_class_name_nosql3 class ki je embeddable, ali ime fielda, ki rabim za kontrolo tree strukture in prikaz plusa 
	
	private String date_mobile; /// izbira datum za mobile naprave
	
	
	private String custom_css_hint_1; /// custom css za vsak drugi stolpec start prvi stolpec v hintu iz custom css datoteke
	private String custom_css_hint_2; /// custom css za vsak drugi stolpec start drugi stolpec v hintu iz custom css datoteke
	
	
	private String js_funkcija_tree; /// alternativna funkcija za tree strukturo, samo ime parametri isti kot default - id row
	
	
	private String cellspacing; /// cellspacing za hint vrstico in list tabelo
	
	private String overraid_update_default; /// overraidam default update pri submitu - ne upostevam avtomaticno idje za najdet zapis  
	
	

	@Column(name="overraid_update_default",length=1)

	
	public String getOverraid_update_default() {
		return overraid_update_default;
	}


	public void setOverraid_update_default(String overraid_update_default) {
		this.overraid_update_default = overraid_update_default;
	}


	@Column(name="cellspacing",length=1)

	
	
	public String getCellspacing() {
		return cellspacing;
	}


	public void setCellspacing(String cellspacing) {
		this.cellspacing = cellspacing;
	}


	@Column(name="custom_css_hint_1",length=50)

	public String getCustom_css_hint_1() {
		return custom_css_hint_1;
	}


	public void setCustom_css_hint_1(String custom_css_hint_1) {
		this.custom_css_hint_1 = custom_css_hint_1;
	}

	@Column(name="custom_css_hint_2",length=50)

	public String getCustom_css_hint_2() {
		return custom_css_hint_2;
	}


	public void setCustom_css_hint_2(String custom_css_hint_2) {
		this.custom_css_hint_2 = custom_css_hint_2;
	}


	@Column(name="js_funkcija_tree",length=50)

	
	public String getJs_funkcija_tree() {
		return js_funkcija_tree;
	}


	public void setJs_funkcija_tree(String js_funkcija_tree) {
		this.js_funkcija_tree = js_funkcija_tree;
	}


	@Column(name="date_mobile",length=1)

	
	
	public String getDate_mobile() {
		return date_mobile;
	}


	public void setDate_mobile(String date_mobile) {
		this.date_mobile = date_mobile;
	}


	@Column(name="head_class_name_nosql3",length=55)

	
	
	public String getHead_class_name_nosql3() {
		return head_class_name_nosql3;
	}


	public void setHead_class_name_nosql3(String head_class_name_nosql3) {
		this.head_class_name_nosql3 = head_class_name_nosql3;
	}


	@Column(name="head_class_name_nosql2",length=55)

	
	
	public String getHead_class_name_nosql2() {
		return head_class_name_nosql2;
	}


	public void setHead_class_name_nosql2(String head_class_name_nosql2) {
		this.head_class_name_nosql2 = head_class_name_nosql2;
	}


	@Column(name="head_class_name_nosql",length=55)

	
	
public String getHead_class_name_nosql() {
		return head_class_name_nosql;
	}


	public void setHead_class_name_nosql(String head_class_name_nosql) {
		this.head_class_name_nosql = head_class_name_nosql;
	}


private TemplateGumbi templategumbi;


private List templateUis = new ArrayList();
private List templateViews = new ArrayList();
private List templateLists = new ArrayList();

private List prevodis = new ArrayList();

private List templateframes = new ArrayList();


@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateFrame.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templateui_id",referencedColumnName="id")

public List getTemplateframes() {
	return templateframes;
}


public void setTemplateframes(List templateframes) {
	this.templateframes = templateframes;
}



@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="prevod_id",referencedColumnName="id")


public List getPrevodis() {
	return prevodis;
}

public void setPrevodis(List prevodis) {
	this.prevodis = prevodis;
}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateList.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")



public List getTemplateLists() {
	return templateLists;
}

public void setTemplateLists(List templateLists) {
	this.templateLists = templateLists;
}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateView.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")


public List getTemplateViews() {
	return templateViews;
}

public void setTemplateViews(List templateViews) {
	this.templateViews = templateViews;
}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateUi.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")


public List getTemplateUis() {
	return templateUis;
}

public void setTemplateUis(List templateUis) {
	this.templateUis = templateUis;
}

@OneToOne
@JoinColumn(name = "veza_gumb",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)


public TemplateGumbi getTemplategumbi() {
return templategumbi;
}

public void setTemplategumbi(TemplateGumbi templategumbi) {
this.templategumbi = templategumbi;
}





@Column(name="logall",length=1)



public String getLogall() {
	return logall;
}

public void setLogall(String logall) {
	this.logall = logall;
}



@Column(name="nosql",length=1)



	
public String getNosql() {
	return nosql;
}

public void setNosql(String nosql) {
	this.nosql = nosql;
}

@Column(name="grafika_css",length=35)

	
	public String getGrafika_css() {
	return grafika_css;
}

public void setGrafika_css(String grafika_css) {
	this.grafika_css = grafika_css;
}

	@Column(name="prisotnost_polje_kontrola",length=35)

		
	
public String getPrisotnost_polje_kontrola() {
		
		return prisotnost_polje_kontrola;
	}


	public void setPrisotnost_polje_kontrola(String prisotnost_polje_kontrola) {
		this.prisotnost_polje_kontrola = prisotnost_polje_kontrola;
	}
	
	
	
@Column(name="zakleni_vse",length=1)

	
	
	public String getZakleni_vse() {
		return zakleni_vse;
	}
	public void setZakleni_vse(String zakleni_vse) {
		this.zakleni_vse = zakleni_vse;
	}
@Column(name="zakleni_record",length=70)

	
	public String getZakleni_record() {
		return zakleni_record;
	}
	public void setZakleni_record(String zakleni_record) {
		this.zakleni_record = zakleni_record;
	}
	
	
	
@Column(name="uporabi_nove_gumbe",length=1)

	
	public String getUporabi_nove_gumbe() {
		return uporabi_nove_gumbe;
	}
	public void setUporabi_nove_gumbe(String uporabi_nove_gumbe) {
		this.uporabi_nove_gumbe = uporabi_nove_gumbe;
	}
    
    
    
@Column(name="inwork")

    
    
    
	public Long getInwork() {
		return inwork;
	}

	public void setInwork(Long inwork) {
		this.inwork = inwork;
	}

@Column(name="response")

    
    
	public Long getResponse() {
		return response;
	}

	public void setResponse(Long response) {
		this.response = response;
	}

@Column(name="tip_head_foot",length=1)

    
    
	public String getTip_head_foot() {
		return tip_head_foot;
	}

	public void setTip_head_foot(String tip_head_foot) {
		this.tip_head_foot = tip_head_foot;
	}

@Column(name="header")

    
    
	public Long getHeader() {
		return header;
	}

	public void setHeader(Long header) {
		this.header = header;
	}

	
@Column(name="footer")

	public Long getFooter() {
		return footer;
	}

	public void setFooter(Long footer) {
		this.footer = footer;
	}

@Column(name="page_title",length=70)

	public String getPage_title() {
		return page_title;
	}

	public void setPage_title(String page_title) {
		this.page_title = page_title;
	}

@Column(name="page_description",length=120)

	public String getPage_description() {
		return page_description;
	}

	public void setPage_description(String page_description) {
		this.page_description = page_description;
	}

@Column(name="page_keywords",length=120)

	public String getPage_keywords() {
		return page_keywords;
	}

	public void setPage_keywords(String page_keywords) {
		this.page_keywords = page_keywords;
	}

@Column(name="frameupsize",length=6)

	public String getFrameupsize() {
		return frameupsize;
	}

	public void setFrameupsize(String frameupsize) {
		this.frameupsize = frameupsize;
	}
@Column(name="frameleftsize",length=6)

	public String getFrameleftsize() {
		return frameleftsize;
	}

	public void setFrameleftsize(String frameleftsize) {
		this.frameleftsize = frameleftsize;
	}
@Column(name="framecentersize",length=6)

	public String getFramecentersize() {
		return framecentersize;
	}

	public void setFramecentersize(String framecentersize) {
		this.framecentersize = framecentersize;
	}
@Column(name="framerightsize",length=6)

	public String getFramerightsize() {
		return framerightsize;
	}

	public void setFramerightsize(String framerightsize) {
		this.framerightsize = framerightsize;
	}

@Column(name="gennamefile",length=25)

    
    
    
	public String getGennamefile() {
		return gennamefile;
	}

	public void setGennamefile(String gennamefile) {
		this.gennamefile = gennamefile;
	}

@Column(name="alternativesubmit",length=250)

	public String getAlternativesubmit() {
		return alternativesubmit;
	}

	public void setAlternativesubmit(String alternativesubmit) {
		this.alternativesubmit = alternativesubmit;
	}

@Column(name="nologinneeded",length=1)

    
	public String getNologinneeded() {
		return nologinneeded;
	}

	public void setNologinneeded(String nologinneeded) {
		this.nologinneeded = nologinneeded;
	}
@Column(name="pageisindependent",length=1)

	public String getPageisindependent() {
		return pageisindependent;
	}

	public void setPageisindependent(String pageisindependent) {
		this.pageisindependent = pageisindependent;
	}

@Column(name="custom_gen",length=1)

    
    
  	public String getCustom_gen() {
		return custom_gen;
	}

	public void setCustom_gen(String custom_gen) {
		this.custom_gen = custom_gen;
	}

@Column(name="struktura_tree_gumbo",length=45)

      
  	public String getStruktura_tree_gumbo() {
  		return struktura_tree_gumbo;
  	}

  	public void setStruktura_tree_gumbo(String struktura_tree_gumbo) {
  		this.struktura_tree_gumbo = struktura_tree_gumbo;
  	}




      
@Column(name="struktura_tree_gumbz",length=45)

  	public String getStruktura_tree_gumbz() {
  		return struktura_tree_gumbz;
  	}

  	public void setStruktura_tree_gumbz(String struktura_tree_gumbz) {
  		this.struktura_tree_gumbz = struktura_tree_gumbz;
  	}
      
      
      
      
      
      
      
      
      
      
      
      
      
@Column(name="struktura_tree",length=1)

  	public String getStruktura_tree() {
  		return struktura_tree;
  	}


  	public String getStruktura_tree_head() {
  		return struktura_tree_head;
  	}

@Column(name="struktura_tree_head",length=1)

  	public void setStruktura_tree_head(String struktura_tree_head) {
  		this.struktura_tree_head = struktura_tree_head;
  	}


  	public void setStruktura_tree(String struktura_tree) {
  		this.struktura_tree = struktura_tree;
  	}

    
    
    
    
    
@Column(name="procedura_zacetno_ime_so",length=35)
public String getProcedura_zacetno_ime_so() {
		return procedura_zacetno_ime_so;
	}


	public void setProcedura_zacetno_ime_so(String procedura_zacetno_ime_so) {
		this.procedura_zacetno_ime_so = procedura_zacetno_ime_so;
	}
    
@Column(name="posebna_funkcija_pogoj",length=250)

	public String getPosebna_funkcija_pogoj() {
		return posebna_funkcija_pogoj;
	}


	public void setPosebna_funkcija_pogoj(String posebna_funkcija_pogoj) {
		this.posebna_funkcija_pogoj = posebna_funkcija_pogoj;
	}


@Column(name="posebna_funkcija",length=35)

	public String getPosebna_funkcija() {
		return posebna_funkcija;
	}


	public void setPosebna_funkcija(String posebna_funkcija) {
		this.posebna_funkcija = posebna_funkcija;
	}


@Column(name="pdf_dolg",length=1)

    
    
	public String getPdf_dolg() {
		return pdf_dolg;
	}


	public void setPdf_dolg(String pdf_dolg) {
		this.pdf_dolg = pdf_dolg;
	}


@Column(name="parsaj_excel",length=1)

    
    
    
    
	public String getParsaj_excel() {
		return parsaj_excel;
	}


	public void setParsaj_excel(String parsaj_excel) {
		this.parsaj_excel = parsaj_excel;
	}


@Column(name="procedura_ime_neznanke",length=35)

    
	public String getProcedura_ime_neznanke() {
		return procedura_ime_neznanke;
	}


	public void setProcedura_ime_neznanke(String proceduraImeNeznanke) {
		procedura_ime_neznanke = proceduraImeNeznanke;
	}


@Column(name="procedura_podatki_checkbox",length=1)

	public String getProcedura_podatki_checkbox() {
		return procedura_podatki_checkbox;
	}


	public void setProcedura_podatki_checkbox(String proceduraPodatkiCheckbox) {
		procedura_podatki_checkbox = proceduraPodatkiCheckbox;
	}

@Column(name="procedura_zacetno_ime_cb",length=35)

	public String getProcedura_zacetno_ime_cb() {
		return procedura_zacetno_ime_cb;
	}


	public void setProcedura_zacetno_ime_cb(String proceduraZacetnoImeCb) {
		procedura_zacetno_ime_cb = proceduraZacetnoImeCb;
	}


@Column(name="target_search_rocno",length=70)  

    
	public String getTarget_search_rocno() {
		return target_search_rocno;
	}


	public void setTarget_search_rocno(String targetSearchRocno) {
		target_search_rocno = targetSearchRocno;
	}


@Column(name="uporabi_cas_refresh",length=1)

    
	public String getUporabi_cas_refresh() {
		return uporabi_cas_refresh;
	}


	public void setUporabi_cas_refresh(String uporabiCasRefresh) {
		uporabi_cas_refresh = uporabiCasRefresh;
	}

@Column(name="uporabi_cas_refresh_n",length=2)

	public String getUporabi_cas_refresh_n() {
		return uporabi_cas_refresh_n;
	}


	public void setUporabi_cas_refresh_n(String uporabiCasRefreshN) {
		uporabi_cas_refresh_n = uporabiCasRefreshN;
	}


@Column(name="uporabi_count_ld",length=1)

    
    
	public String getUporabi_count_ld() {
		return uporabi_count_ld;
	}


	public void setUporabi_count_ld(String uporabiCountLd) {
		uporabi_count_ld = uporabiCountLd;
	}


@Column(name="upload_extension",length=55)

	
	public String getUpload_extension() {
		return upload_extension;
	}


	public void setUpload_extension(String uploadExtension) {
		upload_extension = uploadExtension;
	}

@Column(name="upload_tabela",length=55)

	public String getUpload_tabela() {
		return upload_tabela;
	}


	public void setUpload_tabela(String uploadTabela) {
		upload_tabela = uploadTabela;
	}

@Column(name="upload_tabela_stolpec",length=55)

	public String getUpload_tabela_stolpec() {
		return upload_tabela_stolpec;
	}


	public void setUpload_tabela_stolpec(String uploadTabelaStolpec) {
		upload_tabela_stolpec = uploadTabelaStolpec;
	}

@Column(name="upload_lokacija",length=70)

	public String getUpload_lokacija() {
		return upload_lokacija;
	}


	public void setUpload_lokacija(String uploadLokacija) {
		upload_lokacija = uploadLokacija;
	}

/*
@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.LAZY,mappedBy="templatehead")
//@JoinColumn(name="id",referencedColumnName="templatehead_id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	
*/

@ManyToOne(fetch=FetchType.EAGER,targetEntity=com.popultrade.model.TemplateMailList.class)
@JoinColumn(name="id",referencedColumnName="templatehead_id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)


	
	public TemplateMailList getTemplatemaillist() {
		return templatemaillist;
	}


	public void setTemplatemaillist(TemplateMailList templatemaillist) {
		this.templatemaillist = templatemaillist;
	}


@Column(name="uporabi_count",length=1)

	
	public String getUporabi_count() {
		return uporabi_count;
	}


	public void setUporabi_count(String uporabi_count) {
		this.uporabi_count = uporabi_count;
	}

@Column(name="max_stevilo_recordov",length=5)

	public Integer getMax_stevilo_recordov() {
		return max_stevilo_recordov;
	}


	public void setMax_stevilo_recordov(Integer max_stevilo_recordov) {
		this.max_stevilo_recordov = max_stevilo_recordov;
	}
@Column(name="lokacija_exporta_web",length=250)


	public String getLokacija_exporta_web() {
		return lokacija_exporta_web;
	}


	public void setLokacija_exporta_web(String lokacija_exporta_web) {
		this.lokacija_exporta_web = lokacija_exporta_web;
	}


@Column(name="tip_exporta",length=2)

	
	
	
	public String getTip_exporta() {
		return tip_exporta;
	}


	public void setTip_exporta(String tip_exporta) {
		this.tip_exporta = tip_exporta;
	}


@Column(name="lokacija_exporta",length=250)

	
	
	

	public String getLokacija_exporta() {
		return lokacija_exporta;
	}


	public void setLokacija_exporta(String lokacija_exporta) {
		this.lokacija_exporta = lokacija_exporta;
	}


@Formula("(select count(*) from templategumbi us where us.templatehead_id=id) ")



	public Integer getSogumbi() {
		return sogumbi;
	}


	public void setSogumbi(Integer sogumbi) {
		this.sogumbi = sogumbi;
	}



@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateFunkcijaStart.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="veza_id",referencedColumnName="id")




	public List getTemplateFunkcijaStarts() {
		return templateFunkcijaStarts;
	}


	public void setTemplateFunkcijaStarts(List templateFunkcijaStarts) {
		this.templateFunkcijaStarts = templateFunkcijaStarts;
	}
	
	
	
	
	
	
@Column(name="zacetek_procedure",length=150)

	
	public String getZacetek_procedure() {
		return zacetek_procedure;
	}
	public void setZacetek_procedure(String zacetek_procedure) {
		this.zacetek_procedure = zacetek_procedure;
	}
	
	
@Column(name="konec_procedure",length=150)

	public String getKonec_procedure() {
		return konec_procedure;
	}
	public void setKonec_procedure(String konec_procedure) {
		this.konec_procedure = konec_procedure;
	}


	/// v primeru delete
	private TemplateUiDodatno templateUiDodatno = new TemplateUiDodatno();
	
	
	

@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER, mappedBy="templatehead") 
@NotFound(action = NotFoundAction.IGNORE)
//@JoinColumn(name="id",referencedColumnName="templateui_id",insertable=false,updatable=false,nullable=true)

	public TemplateUiDodatno getTemplateUiDodatno() {
		return templateUiDodatno;
	}
	public void setTemplateUiDodatno(TemplateUiDodatno templateUiDodatno) {
		this.templateUiDodatno = templateUiDodatno;
	}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplatePP.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")

	

	public List getTemplatePPs() {
		return templatePPs;
	}
	public void setTemplatePPs(List templatePPs) {
		this.templatePPs = templatePPs;
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
	
	
	
	private List templateClasss = new ArrayList(); /// veza na pogoje
	
	
	

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateClass.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
@OrderBy("zaporedje asc")
	
	public List getTemplateClasss() {
		return templateClasss;
	}
	public void setTemplateClasss(List templateClasss) {
		this.templateClasss = templateClasss;
	}
@Column(name="target_isci",length=55)

	
	public String getTarget_isci() {
		return target_isci;
	}
	public void setTarget_isci(String target_isci) {
		this.target_isci = target_isci;
	}

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateHeadReset.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
	
	public List getTemplateHeadResets() {
		return templateHeadResets;
	}
	public void setTemplateHeadResets(List templateHeadResets) {
		this.templateHeadResets = templateHeadResets;
	}
@Column(name="order_by_smer",length=4)

	
	public String getOrder_by_smer() {
		return order_by_smer;
	}
	public void setOrder_by_smer(String order_by_smer) {
		this.order_by_smer = order_by_smer;
	}
@Index(name="veza_gumb")
@Column(name="veza_gumb")

	
	
	
	public Long getVeza_gumb() {
		return veza_gumb;
	}
	public void setVeza_gumb(Long veza_gumb) {
		this.veza_gumb = veza_gumb;
	}
	private List templateGumbis = new ArrayList();
	


@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateGumbi.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
@OrderBy("zaporedje")
	
	public List getTemplateGumbis() {
		return templateGumbis;
	}
	public void setTemplateGumbis(List templateGumbis) {
		this.templateGumbis = templateGumbis;
	}
	
	
@Column(name="head_class_name",length=55,nullable=true)

	public String getHead_class_name() {
		return head_class_name;
	}

	public void setHead_class_name(String head_class_name) {
		this.head_class_name = head_class_name;
	}
	
	
@Column(name="head_select_dodatni_pogoji",length=55)

	public String getHead_select_dodatni_pogoji() {
		return head_select_dodatni_pogoji;
	}
	public void setHead_select_dodatni_pogoji(String head_select_dodatni_pogoji) {
		this.head_select_dodatni_pogoji = head_select_dodatni_pogoji;
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
	
	
	
@Column(name="head_naziv",length=35,nullable=true)

	public String getHead_naziv() {
		return head_naziv;
	}
	public void setHead_naziv(String head_naziv) {
		this.head_naziv = head_naziv;
	}
	
	
	
@Column(name="zaporedje")

	public int getZaporedje() {
		return zaporedje;
	}
	public void setZaporedje(int zaporedje) {
		this.zaporedje = zaporedje;
	}
	
	
@Column(name="opis",length=350)

	public String getOpis() {
		return opis;
	}
	public void setOpis(String opis) {
		this.opis = opis;
	}
	
	
@Column(name="head_tip",length=2,nullable=true)

	public String getHead_tip() {
		return head_tip;
	}
	public void setHead_tip(String head_tip) {
		this.head_tip = head_tip;
	}
	
@Column(name="class_id")

	public Long getClass_id() {
		return class_id;
	}
	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((class_id == null) ? 0 : class_id.hashCode());
		result = prime * result
				+ ((head_naziv == null) ? 0 : head_naziv.hashCode());
		result = prime * result
				+ ((head_tip == null) ? 0 : head_tip.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((opis == null) ? 0 : opis.hashCode());
		result = prime * result + zaporedje;
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateHead other = (TemplateHead) obj;
		if (class_id == null) {
			if (other.class_id != null)
				return false;
		} else if (!class_id.equals(other.class_id))
			return false;
		if (head_naziv == null) {
			if (other.head_naziv != null)
				return false;
		} else if (!head_naziv.equals(other.head_naziv))
			return false;
		if (head_tip == null) {
			if (other.head_tip != null)
				return false;
		} else if (!head_tip.equals(other.head_tip))
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
		if (zaporedje != other.zaporedje)
			return false;
		return true;
	}
	
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	

	
	
	
	
	
	
	
	
	
	

}
