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
@Table (name="templateui")


public class TemplateUi extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = 1432534265462463388L;
	private Long id;
	private Long templatehead_id;
	private String stolpec_naziv; /// naziv, samo za pregled
	
	private String stolpec_align; /// align: center,left, right
	private Integer zaporedje; /// zaporedje prikaza stolpcev
	private String stolpec_metoda; /// metoda v model classi
	private String format_stolpca; /// format za datum ali numeric
	private String stolpec_sirina;
	private String stolpec_max_stevilo_znakov; //
	
	private String tip_polja; /// tip polja lahko je vrednost ali pa prazno (za izdelavo izgleda)
	
	
	
	
	private String kontrola_javascript; ///ima nima kontrolo js
	private String kontrola_javascript_pravilnost; ///ima nima kontrolo js pravilnosti vnosa npr. ce je datum prav vnesen, velja le za datum in numeric
	private String dodatek_javascript;/// dodatki za js, vpisem v txt box
	
	private String vnos_kdaj; /// edit polje pri insertu ali update ali oboje
	private String vnos_kdaj_fiksno; /// polje je readonly
	private String pogoji_inserta; /// text box za dodatek pri insertu, dodatni pogoji
	private String pogoji_update; /// text box pri update, dodatni pogoji
	
	
private String tab_index; /// zaporedje s tabulatorjem


private String datum_vnos_tip; /// ti vnosa datuma, z uro ali brez
private Long templateui_id; /// veza na template ui nad njim, za logiko prikaza v istem polju

private String tip_inserta; /// select, text, textbox, checkbox
private String rows;
private String cols;

private String parameter_drugo_ime; /// drugo ime parametra v primeru prikaza opisa iz ajaxa
private String dodaten_pogoj_prikaza_edit; /// dodaten pogoj za prikaz update ali insert polja, pogoj je na podlagi drugih parametrov iz iste clase;




private String samo_velike_crke;

private TemplateClassClass templateClassClass = new TemplateClassClass();


private TemplateUiDodatno templateuidodatno = new TemplateUiDodatno();


private String javascript_event;
private String javascript_event_uporabi;



private String dodatna_js_kontrola;
private String dodatna_js_kontrola_uporabi;




private String jeslika; /// ce je slika polje
private Integer slika_width; //// sizrina slike
private Integer slika_height; /// visina slike

private String uporabi_ajax_kontrolo; /// kontrola JS preko ajaxa v primeru kontrol v drugih tabelah

//private List templateframes = new ArrayList();
private List templatedds = new ArrayList();

private Integer so_templatedd;


private String dodaten_pogoj_prikaz_say; /// prikazem ali ne vrednost polja v say obliki



private String hint_pomoc; /// tekst za pomoc, 1-je , 0-ni





private String kontrola_numericno; /// kontrola, ce je v polje vnesena numericna vrednosti

//// parametri za touch screen creacijo

private String pozicija; /// pozicija (zgoraj,levo,sredina,desno)

private String dim_zgoraj; /// dimenzija div pozicij
private String dim_levo;
private String dim_sredina;
private String dim_desno;




private String dwidth;
private String dheight;
private String dtop;
private String dleft;
private String dbarvag;
private String dbarvagc;
private String dslikag;


private String dposition; /// pozicija, absolute ali relative, ce relative se rabi class, ce ne se vpise style spodaj
private String dstyle; /// celoten style css, ki se vpise v tag, za star nacin se rabi tudi, se da namesto defaulta, samo za inpute


private String ddivname; /// id in ime diva
private String ddivsrc; /// src diva

private String dtablewidth;
private String dinputh; /// velikost polja za input



private String dinputsl; /// sirina dela prevoda pri input tagih

private String dinputsd; /// sirina dela inputa pri input tagih

private String dimage; /// slika 

private String dnextto;/// ce ima nextto, samo za ze obstojece nextto
private String dnexttodir;/// kako naj razdeli nextto (vertikalno | ali horizontalno ---)


private String dtarget; /// target gumba , (vsi parent frame in vsi divi z iframe)
private String dtargettemp; /// target gumba template, prva stopnja
private String dtargetroc; /// rocen target, vnese jsp 
private String dtargetrocjs; /// rocen target klice JS

private String ddivclasscus; /// ime class v custom.css
private String ddivclasscusf; /// ime class v custom.css za fonte


private String dtipbutton; /// type of input button (button,submit)

private String tip_inserta_p; /// ne uposteva prevod in s tem se premakne view vrednost na desno


private String ddivclasscusin;  /// ime class v custom.css za input elemente
private String ddivcontainer; /// ime class v custom.css za container nexto-jev

private String ddivclasscustd;  /// ime class v custom.css za td elemente

private String dbuttontextvisible; /// touch button nima viden prevod

private String dspan; /// span oz. koliko stolpcev zajema element, na podlagi dcolnums v tabeli templateframe, pazi na sumo elementov da ni vecja kot stevilo stolpcev


private String ddivfirsttable; /// css za prvo tabelo

private String dpogojprikazg; /// veza na gumb lista


private String dfilename; /// ime uploadane datoteke, ce je tip inserta file
private Integer dfilesize; /// max velikost uploadane datoteke, ce je tip insera file

private String dcontenttype; /// content type za uploadano datoteko

private String jeslikaizbaze;/// ce je slika iz baze
private Long templateprikazslike; /// template ki klicem z idjem za prikaz slike, tipa OB


private String navodila_obdelana; /// navodila opravljena, da ne
private String navodila; /// navodila tekst


private String rocni_css; /// rocno vnesena class


private String load_sifrant_konec; /// load sifranta na koncu, ko klikne na potrdi, user mora imeti ustrezen pogoj , da dela (vezano na user)

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

@Column(name="load_sifrant_konec",length=1)


public String getLoad_sifrant_konec() {
	return load_sifrant_konec;
}

public void setLoad_sifrant_konec(String load_sifrant_konec) {
	this.load_sifrant_konec = load_sifrant_konec;
}

@Column(name="rocni_css",length=70)



public String getRocni_css() {
	return rocni_css;
}

public void setRocni_css(String rocni_css) {
	this.rocni_css = rocni_css;
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
@Column(name="dcontenttype",length=70)




public String getDcontenttype() {
	return dcontenttype;
}
public void setDcontenttype(String dcontenttype) {
	this.dcontenttype = dcontenttype;
}
@Column(name="dfilename",length=70)


public String getDfilename() {
	return dfilename;
}
public void setDfilename(String dfilename) {
	this.dfilename = dfilename;
}


@Column(name="dfilesize")


public Integer getDfilesize() {
	return dfilesize;
}
public void setDfilesize(Integer dfilesize) {
	this.dfilesize = dfilesize;
}
@Column(name="dpogojprikazg",length=1500)





public String getDpogojprikazg() {
	return dpogojprikazg;
}
public void setDpogojprikazg(String dpogojprikazg) {
	this.dpogojprikazg = dpogojprikazg;
}





@Column(name="ddivcontainer",length=70)



public String getDdivcontainer() {
	return ddivcontainer;
}

public void setDdivcontainer(String ddivcontainer) {
	this.ddivcontainer = ddivcontainer;
}

@Column(name="ddivfirsttable",length=70)



public String getDdivfirsttable() {
	return ddivfirsttable;
}

public void setDdivfirsttable(String ddivfirsttable) {
	this.ddivfirsttable = ddivfirsttable;
}
@Column(name="dspan",length=2)



public String getDspan() {
	return dspan;
}
public void setDspan(String dspan) {
	this.dspan = dspan;
}
@Column(name="dbuttontextvisible",length=1)


public String getDbuttontextvisible() {
	return dbuttontextvisible;
}
public void setDbuttontextvisible(String dbuttontextvisible) {
	this.dbuttontextvisible = dbuttontextvisible;
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





@Column(name="ddivclasscustd",length=70)







public String getDdivclasscustd() {
	return ddivclasscustd;
}


public void setDdivclasscustd(String ddivclasscustd) {
	this.ddivclasscustd = ddivclasscustd;
}


@Column(name="ddivclasscusin",length=70)




public String getDdivclasscusin() {
	return ddivclasscusin;
}


public void setDdivclasscusin(String ddivclasscusin) {
	this.ddivclasscusin = ddivclasscusin;
}


@Column(name="tip_inserta_p",length=1)



public String getTip_inserta_p() {
	return tip_inserta_p;
}


public void setTip_inserta_p(String tip_inserta_p) {
	this.tip_inserta_p = tip_inserta_p;
}


@Column(name="dtipbutton",length=8)


public String getDtipbutton() {
	return dtipbutton;
}


public void setDtipbutton(String dtipbutton) {
	this.dtipbutton = dtipbutton;
}


@Column(name="ddivclasscusf",length=70)



public String getDdivclasscusf() {
	return ddivclasscusf;
}


public void setDdivclasscusf(String ddivclasscusf) {
	this.ddivclasscusf = ddivclasscusf;
}


@Column(name="ddivclasscus",length=70)




public String getDdivclasscus() {
	return ddivclasscus;
}


public void setDdivclasscus(String ddivclasscus) {
	this.ddivclasscus = ddivclasscus;
}


@Column(name="dtarget",length=70)



public String getDtarget() {
	return dtarget;
}


public void setDtarget(String dtarget) {
	this.dtarget = dtarget;
}

@Column(name="dtargettemp",length=70)

public String getDtargettemp() {
	return dtargettemp;
}


public void setDtargettemp(String dtargettemp) {
	this.dtargettemp = dtargettemp;
}


@Column(name="dtargetroc",length=150)

public String getDtargetroc() {
	return dtargetroc;
}


public void setDtargetroc(String dtargetroc) {
	this.dtargetroc = dtargetroc;
}

@Column(name="dtargetrocjs",length=450)

public String getDtargetrocjs() {
	return dtargetrocjs;
}


public void setDtargetrocjs(String dtargetrocjs) {
	this.dtargetrocjs = dtargetrocjs;
}


@Column(name="dnextto",length=1)



public String getDnextto() {
	return dnextto;
}


public void setDnextto(String dnextto) {
	this.dnextto = dnextto;
}

@Column(name="dnexttodir",length=1)


public String getDnexttodir() {
	return dnexttodir;
}


public void setDnexttodir(String dnexttodir) {
	this.dnexttodir = dnexttodir;
}


@Column(name="dimage",length=25)



public String getDimage() {
	return dimage;
}


public void setDimage(String dimage) {
	this.dimage = dimage;
}


@Column(name="dinputsl",length=6)



public String getDinputsl() {
	return dinputsl;
}


public void setDinputsl(String dinputsl) {
	this.dinputsl = dinputsl;
}
@Column(name="dinputsd",length=6)


public String getDinputsd() {
	return dinputsd;
}


public void setDinputsd(String dinputsd) {
	this.dinputsd = dinputsd;
}


@Column(name="dinputh",length=6)



public String getDinputh() {
	return dinputh;
}


public void setDinputh(String dinputh) {
	this.dinputh = dinputh;
}


@Column(name="dtablewidth",length=6)




public String getDtablewidth() {
	return dtablewidth;
}


public void setDtablewidth(String dtablewidth) {
	this.dtablewidth = dtablewidth;
}


@Column(name="ddivname",length=35)



public String getDdivname() {
	return ddivname;
}


public void setDdivname(String ddivname) {
	this.ddivname = ddivname;
}

@Column(name="ddivsrc",length=450)

public String getDdivsrc() {
	return ddivsrc;
}


public void setDdivsrc(String ddivsrc) {
	this.ddivsrc = ddivsrc;
}


@Column(name="dposition",length=15)


public String getDposition() {
	return dposition;
}


public void setDposition(String dposition) {
	this.dposition = dposition;
}

@Column(name="dstyle",length=450)

public String getDstyle() {
	return dstyle;
}


public void setDstyle(String dstyle) {
	this.dstyle = dstyle;
}


@Column(name="dslikag",length=25)



public String getDslikag() {
	return dslikag;
}


public void setDslikag(String dslikag) {
	this.dslikag = dslikag;
}


@Column(name="dbarvag",length=7)


public String getDbarvag() {
	return dbarvag;
}


public void setDbarvag(String dbarvag) {
	this.dbarvag = dbarvag;
}

@Column(name="dbarvagc",length=7)

public String getDbarvagc() {
	return dbarvagc;
}


public void setDbarvagc(String dbarvagc) {
	this.dbarvagc = dbarvagc;
}


@Column(name="dwidth",length=8)



public String getDwidth() {
	return dwidth;
}


public void setDwidth(String dwidth) {
	this.dwidth = dwidth;
}

@Column(name="dheight",length=8)

public String getDheight() {
	return dheight;
}


public void setDheight(String dheight) {
	this.dheight = dheight;
}

@Column(name="dtop",length=8)

public String getDtop() {
	return dtop;
}


public void setDtop(String dtop) {
	this.dtop = dtop;
}

@Column(name="dleft",length=8)

public String getDleft() {
	return dleft;
}


public void setDleft(String dleft) {
	this.dleft = dleft;
}


@Column(name="dim_zgoraj",length=8)

public String getDim_zgoraj() {
	return dim_zgoraj;
}


public void setDim_zgoraj(String dim_zgoraj) {
	this.dim_zgoraj = dim_zgoraj;
}

@Column(name="dim_levo",length=8)

public String getDim_levo() {
	return dim_levo;
}


public void setDim_levo(String dim_levo) {
	this.dim_levo = dim_levo;
}

@Column(name="dim_sredina",length=8)

public String getDim_sredina() {
	return dim_sredina;
}


public void setDim_sredina(String dim_sredina) {
	this.dim_sredina = dim_sredina;
}

@Column(name="dim_desno",length=8)

public String getDim_desno() {
	return dim_desno;
}


public void setDim_desno(String dim_desno) {
	this.dim_desno = dim_desno;
}


@Column(name="pozicija",length=10)


public String getPozicija() {
	return pozicija;
}


public void setPozicija(String pozicija) {
	this.pozicija = pozicija;
}


@Column(name="kontrola_numericno",length=1)




public String getKontrola_numericno() {
	return kontrola_numericno;
}


public void setKontrola_numericno(String kontrola_numericno) {
	this.kontrola_numericno = kontrola_numericno;
}





@Column(name="hint_pomoc",length=1)




public String getHint_pomoc() {
	return hint_pomoc;
}


public void setHint_pomoc(String hint_pomoc) {
	this.hint_pomoc = hint_pomoc;
}


@Column(name="dodaten_pogoj_prikaz_say",length=1)




public String getDodaten_pogoj_prikaz_say() {
	return dodaten_pogoj_prikaz_say;
}


public void setDodaten_pogoj_prikaz_say(String dodaten_pogoj_prikaz_say) {
	this.dodaten_pogoj_prikaz_say = dodaten_pogoj_prikaz_say;
}



@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.LAZY,mappedBy="templateui")
//@JoinColumn(name="templateui_id",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)

public TemplateUiDodatno getTemplateuidodatno() {
	return templateuidodatno;
}


public void setTemplateuidodatno(TemplateUiDodatno templateuidodatno) {
	this.templateuidodatno = templateuidodatno;
}


@Formula("(select count(*) from templatedd tdd where tdd.templateui_id=id) ")

public Integer getSo_templatedd() {
	return so_templatedd;
}


public void setSo_templatedd(Integer so_templatedd) {
	this.so_templatedd = so_templatedd;
}




@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateDD.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templateui_id",referencedColumnName="id")



public List getTemplatedds() {
	return templatedds;
}


public void setTemplatedds(List templatedds) {
	this.templatedds = templatedds;
}


@Column(name="uporabi_ajax_kontrolo",length=1)



public String getUporabi_ajax_kontrolo() {
	return uporabi_ajax_kontrolo;
}


public void setUporabi_ajax_kontrolo(String uporabi_ajax_kontrolo) {
	this.uporabi_ajax_kontrolo = uporabi_ajax_kontrolo;
}


@Column(name="vnos_kdaj_fiksno",length=1)


public String getVnos_kdaj_fiksno() {
	return vnos_kdaj_fiksno;
}


public void setVnos_kdaj_fiksno(String vnos_kdaj_fiksno) {
	this.vnos_kdaj_fiksno = vnos_kdaj_fiksno;
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




@Column(name="dodatna_js_kontrola")


public String getDodatna_js_kontrola() {
	return dodatna_js_kontrola;
}


public void setDodatna_js_kontrola(String dodatna_js_kontrola) {
	this.dodatna_js_kontrola = dodatna_js_kontrola;
}







@Column(name="dodaten_pogoj_prikaza_edit",length=400)





public String getDodaten_pogoj_prikaza_edit() {
	return dodaten_pogoj_prikaza_edit;
}


public void setDodaten_pogoj_prikaza_edit(String dodaten_pogoj_prikaza_edit) {
	this.dodaten_pogoj_prikaza_edit = dodaten_pogoj_prikaza_edit;
}


@Column(name="dodatna_js_kontrola_uporabi",length=1)

public String getDodatna_js_kontrola_uporabi() {
	return dodatna_js_kontrola_uporabi;
}


public void setDodatna_js_kontrola_uporabi(String dodatna_js_kontrola_uporabi) {
	this.dodatna_js_kontrola_uporabi = dodatna_js_kontrola_uporabi;
}


@Column(name="javascript_event",length=255)

public String getJavascript_event() {
	return javascript_event;
}


public void setJavascript_event(String javascript_event) {
	this.javascript_event = javascript_event;
}

@Column(name="javascript_event_uporabi",length=1)

public String getJavascript_event_uporabi() {
	return javascript_event_uporabi;
}


public void setJavascript_event_uporabi(String javascript_event_uporabi) {
	this.javascript_event_uporabi = javascript_event_uporabi;
}





@Column(name="parameter_drugo_ime",length=35)

public String getParameter_drugo_ime() {
	return parameter_drugo_ime;
}


public void setParameter_drugo_ime(String parameter_drugo_ime) {
	this.parameter_drugo_ime = parameter_drugo_ime;
}


@Column(name="kontrola_javascript_pravilnost",length=1)




public String getKontrola_javascript_pravilnost() {
	return kontrola_javascript_pravilnost;
}


public void setKontrola_javascript_pravilnost(
		String kontrola_javascript_pravilnost) {
	this.kontrola_javascript_pravilnost = kontrola_javascript_pravilnost;
}


@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templateui")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)


public TemplateClassClass getTemplateClassClass() {
	return templateClassClass;
}


public void setTemplateClassClass(TemplateClassClass templateClassClass) {
	this.templateClassClass = templateClassClass;
}








@Column(name="samo_velike_crke",length=1)




public String getSamo_velike_crke() {
	return samo_velike_crke;
}


public void setSamo_velike_crke(String samo_velike_crke) {
	this.samo_velike_crke = samo_velike_crke;
}


@Column(name="rows2",length=4)


public String getRows() {
	return rows;
}


public void setRows(String rows) {
	this.rows = rows;
}

@Column(name="cols",length=4)

public String getCols() {
	return cols;
}


public void setCols(String cols) {
	this.cols = cols;
}


/// vezava na TemplateClass, ce jo ima
@Column(name="tip_inserta",length=10)

public String getTip_inserta() {
	return tip_inserta;
}


public void setTip_inserta(String tip_inserta) {
	this.tip_inserta = tip_inserta;
}




private Integer so_templateclasses;

@Formula("(select count(*) from templateclass tc where tc.templatehead_id=id) ")

public Integer getSo_templateclasses() {
	return so_templateclasses;
}

public void setSo_templateclasses(Integer so_templateclasses) {
	this.so_templateclasses = so_templateclasses;
}



private List templateClasses = new ArrayList();
 






@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateClass.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatehead_id",referencedColumnName="id")
@OrderBy("zaporedje")



public List getTemplateClasses() {
	return templateClasses;
}





public void setTemplateClasses(List templateClasses) {
	this.templateClasses = templateClasses;
}



private Integer so_childi;

@Formula("(select count(*) from templateui us where us.templateui_id=id) ")


public Integer getSo_childi() {
	return so_childi;
}

public void setSo_childi(Integer so_childi) {
	this.so_childi = so_childi;
}




private List templateuis = new ArrayList(); /// list vseh templateui pod template ui


@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateUi.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templateui_id",referencedColumnName="id")
@OrderBy("zaporedje")


public List getTemplateuis() {
	return templateuis;
}


public void setTemplateuis(List templateuis) {
	this.templateuis = templateuis;
}

@Column(name="stolpec_sirina",length=10)

public String getStolpec_sirina() {
	return stolpec_sirina;
}





public void setStolpec_sirina(String stolpec_sirina) {
	this.stolpec_sirina = stolpec_sirina;
}



@Column(name="stolpec_max_stevilo_znakov",length=10)


public String getStolpec_max_stevilo_znakov() {
	return stolpec_max_stevilo_znakov;
}





public void setStolpec_max_stevilo_znakov(String stolpec_max_stevilo_znakov) {
	this.stolpec_max_stevilo_znakov = stolpec_max_stevilo_znakov;
}





@Index(name="templateui_id")
@Column(name="templateui_id")

public Long getTemplateui_id() {
	return templateui_id;
}


public void setTemplateui_id(Long templateui_id) {
	this.templateui_id = templateui_id;
}


@Column(name="datum_vnos_tip",length=1)

public String getDatum_vnos_tip() {
	return datum_vnos_tip;
}


public void setDatum_vnos_tip(String datum_vnos_tip) {
	this.datum_vnos_tip = datum_vnos_tip;
}


@Index(name="tab_index")
@Column(name="tab_index",length=4)

	
	
public String getTab_index() {
return tab_index;
}


public void setTab_index(String tab_index) {
	this.tab_index = tab_index;
}


@Column(name="kontrola_javascript",length=2)

	public String getKontrola_javascript() {
		return kontrola_javascript;
	}


	public void setKontrola_javascript(String kontrola_javascript) {
		this.kontrola_javascript = kontrola_javascript;
	}

@Column(name="dodatek_javascript")

	public String getDodatek_javascript() {
		return dodatek_javascript;
	}


	public void setDodatek_javascript(String dodatek_javascript) {
		this.dodatek_javascript = dodatek_javascript;
	}

	
@Column(name="vnos_kdaj",length=2)

	public String getVnos_kdaj() {
		return vnos_kdaj;
	}


	public void setVnos_kdaj(String vnos_kdaj) {
		this.vnos_kdaj = vnos_kdaj;
	}

@Column(name="pogoji_inserta")

	public String getPogoji_inserta() {
		return pogoji_inserta;
	}


	public void setPogoji_inserta(String pogoji_inserta) {
		this.pogoji_inserta = pogoji_inserta;
	}

@Column(name="pogoji_update")

	public String getPogoji_update() {
		return pogoji_update;
	}


	public void setPogoji_update(String pogoji_update) {
		this.pogoji_update = pogoji_update;
	}




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
		TemplateUi other = (TemplateUi) obj;
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
