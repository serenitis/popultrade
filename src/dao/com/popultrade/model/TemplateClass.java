package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import java.io.Serializable;


@Entity
@Table (name="templateclass")


public class TemplateClass extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = -9086132786110266786L;
	private Long id;
	private Long templatehead_id;
	private String ime_pogoja; /// ime funkcije oz metode v model clasi
	private String vrednost_pogoja; /// vrednost metode, lahko dobim iz konstant pri logu ali vpise z roko
	private String opis_pogoja; /// kratek opis pogoja
	/////////// spodaj velja za izdelavo pogojev
	private String tip_pogoja; /// tip pogoja, vecje , manjse, enako, ni enako
	private Integer zaporedje;
	
	private String vezani_pogoj; /// ce gre za vezani pogoj (and ali or)
	private Long templateclass_id; /// pogoj vezan na ze obstojeci templaye clas preko vezani pogoj
	private String predpona_pogoja; /// if , else if, else
	private String sestavljeni_pogoj; /// v primeru , ce se pogoj sestavi s pomocjo web template
	private String dodaten_hql_pogoj; /// vpisem pogoj v obliki HQL, doda se po where stavku
	
	private String vrsta_pogoja; /// je pogoj iz classe ali ne, v primeru procedur je tukaj tip parametra ki dam v proceduro (int,string,long,double itd)
	
	private String uporabi_kot_rezultat; /// uporabim kot rezultat in ne dam v string
	
	private String uporabi_hql; /// ce rabim hql pogoj pri kreaciji selecta, velja le za list in pdf
	
	private String kot_rezultat_uporabi_prevod; /// uporabim oz. prikazem prevod kot rezultat
	
	//private String funkcija_formata;/// ime funkcije formata
	private String funkcija_formata1; /// ime funkcije, ki klicem za format vrednosti ;prvi del
	private String funkcija_formata2; /// ime funkcije, ki klicem za format vrednosti ;drugi del
	private String funkcija_formata3; /// ime funkcije, ki klicem za format vrednosti ;tretji del
	
	
	private String izvor_vrednosti; /// izvor vrednosti , uporabi se pri funkciji v primeru enakih imen v tabeli
	
	
	private String izvor_vrednosti_pogoj; /// izvor vrednosti za pogoj , uporabi se pri funkciji v primeru enakih imen v tabeli
	
	
	private String dodaten_pogoj_za_request; /// pogoj za pridobljene requeste
	
	
	private String uporabi_kot_neznanka; /// uporabim za definicijo nezanak
	
	
	private String rocna_vrednost;
	private String rocna_vrednost_rabi;
	
	private String nosql; /// ce gre za nosql value iz druge classe
	
	
	
	
	
	
	
	

	private TemplateGumbi templategumbi;
	
private TemplateView templateview;
	


@OneToOne
@JoinColumn(name = "templatehead_id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	
	
	public TemplateView getTemplateview() {
	return templateview;
}

public void setTemplateview(TemplateView templateview) {
	this.templateview = templateview;
}




	@OneToOne
    @JoinColumn(name = "templatehead_id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
public TemplateGumbi getTemplategumbi() {
		return templategumbi;
	}

	public void setTemplategumbi(TemplateGumbi templategumbi) {
		this.templategumbi = templategumbi;
	}

	
	
	@Column(name="nosql",length=1)
	public String getNosql() {
		return nosql;
	}

	public void setNosql(String nosql) {
		this.nosql = nosql;
	}
	
@Column(name="rocna_vrednost",length=500)

	
	public String getRocna_vrednost() {
		return rocna_vrednost;
	}

	public void setRocna_vrednost(String rocna_vrednost) {
		this.rocna_vrednost = rocna_vrednost;
	}
	
@Column(name="rocna_vrednost_rabi",length=1)

	public String getRocna_vrednost_rabi() {
		return rocna_vrednost_rabi;
	}
	public void setRocna_vrednost_rabi(String rocna_vrednost_rabi) {
		this.rocna_vrednost_rabi = rocna_vrednost_rabi;
	}
@Column(name="uporabi_kot_neznanka",length=1)

	
	
	public String getUporabi_kot_neznanka() {
		return uporabi_kot_neznanka;
	}
	public void setUporabi_kot_neznanka(String uporabi_kot_neznanka) {
		this.uporabi_kot_neznanka = uporabi_kot_neznanka;
	}
@Column(name="dodaten_pogoj_za_request",length=350)

	
	
	public String getDodaten_pogoj_za_request() {
		return dodaten_pogoj_za_request;
	}
	public void setDodaten_pogoj_za_request(String dodaten_pogoj_za_request) {
		this.dodaten_pogoj_za_request = dodaten_pogoj_za_request;
	}
@Column(name="izvor_vrednosti_pogoj",length=1)

	
	
	
	public String getIzvor_vrednosti_pogoj() {
		return izvor_vrednosti_pogoj;
	}
	public void setIzvor_vrednosti_pogoj(String izvor_vrednosti_pogoj) {
		this.izvor_vrednosti_pogoj = izvor_vrednosti_pogoj;
	}
@Column(name="izvor_vrednosti",length=1)

	
	public String getIzvor_vrednosti() {
		return izvor_vrednosti;
	}
	public void setIzvor_vrednosti(String izvor_vrednosti) {
		this.izvor_vrednosti = izvor_vrednosti;
	}
@Column(name="funkcija_formata1",length=60)

	public String getFunkcija_formata1() {
		return funkcija_formata1;
	}
	public void setFunkcija_formata1(String funkcija_formata1) {
		this.funkcija_formata1 = funkcija_formata1;
	}
@Column(name="funkcija_formata2",length=60)

	public String getFunkcija_formata2() {
		return funkcija_formata2;
	}
	public void setFunkcija_formata2(String funkcija_formata2) {
		this.funkcija_formata2 = funkcija_formata2;
	}
@Column(name="funkcija_formata3",length=550)

	public String getFunkcija_formata3() {
		return funkcija_formata3;
	}
	public void setFunkcija_formata3(String funkcija_formata3) {
		this.funkcija_formata3 = funkcija_formata3;
	}
@Column(name="uporabi_kot_rezultat",length=1)

	
	
	
	public String getUporabi_kot_rezultat() {
		return uporabi_kot_rezultat;
	}
	public void setUporabi_kot_rezultat(String uporabi_kot_rezultat) {
		this.uporabi_kot_rezultat = uporabi_kot_rezultat;
	}
@Column(name="kot_rezultat_uporabi_prevod",length=1)

	public String getKot_rezultat_uporabi_prevod() {
		return kot_rezultat_uporabi_prevod;
	}
	public void setKot_rezultat_uporabi_prevod(String kot_rezultat_uporabi_prevod) {
		this.kot_rezultat_uporabi_prevod = kot_rezultat_uporabi_prevod;
	}
@Column(name="uporabi_hql",length=1)

	
	public String getUporabi_hql() {
		return uporabi_hql;
	}
	public void setUporabi_hql(String uporabi_hql) {
		this.uporabi_hql = uporabi_hql;
	}
@Column(name="vrsta_pogoja",length=10)

	
	public String getVrsta_pogoja() {
		return vrsta_pogoja;
	}
	public void setVrsta_pogoja(String vrsta_pogoja) {
		this.vrsta_pogoja = vrsta_pogoja;
	}
	private TemplateClassClass templateClassClass = new TemplateClassClass();
	
	

@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templateclass")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateClassClass getTemplateClassClass() {
		return templateClassClass;
	}
	public void setTemplateClassClass(TemplateClassClass templateClassClass) {
		this.templateClassClass = templateClassClass;
	}
@Column(name="zaporedje")

	
	public Integer getZaporedje() {
		return zaporedje;
	}
	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
	}
@Column(name="dodaten_hql_pogoj",length=2000)

	public String getDodaten_hql_pogoj() {
		return dodaten_hql_pogoj;
	}
	public void setDodaten_hql_pogoj(String dodaten_hql_pogoj) {
		this.dodaten_hql_pogoj = dodaten_hql_pogoj;
	}
@Column(name="predpona_pogoja",length=10)

	public String getPredpona_pogoja() {
		return predpona_pogoja;
	}
	public void setPredpona_pogoja(String predpona_pogoja) {
		this.predpona_pogoja = predpona_pogoja;
	}
	
@Column(name="sestavljeni_pogoj",length=250)

	public String getSestavljeni_pogoj() {
		return sestavljeni_pogoj;
	}
	public void setSestavljeni_pogoj(String sestavljeni_pogoj) {
		this.sestavljeni_pogoj = sestavljeni_pogoj;
	}
	
	
@Id
@Column(name="id")
@SequenceGenerator(name="template_seq", sequenceName="template_seq", allocationSize=1)
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
	
	
@Column(name="ime_pogoja",length=55)

	public String getIme_pogoja() {
		return ime_pogoja;
	}
	public void setIme_pogoja(String ime_pogoja) {
		this.ime_pogoja = ime_pogoja;
	}
	
	
@Column(name="vrednost_pogoja",length=550)

	public String getVrednost_pogoja() {
		return vrednost_pogoja;
	}
	public void setVrednost_pogoja(String vrednost_pogoja) {
		this.vrednost_pogoja = vrednost_pogoja;
	}
	
	
	
@Column(name="opis_pogoja",length=70)

	public String getOpis_pogoja() {
		return opis_pogoja;
	}
	public void setOpis_pogoja(String opis_pogoja) {
		this.opis_pogoja = opis_pogoja;
	}
	
	
@Column(name="tip_pogoja",length=2)

	public String getTip_pogoja() {
		return tip_pogoja;
	}
	public void setTip_pogoja(String tip_pogoja) {
		this.tip_pogoja = tip_pogoja;
	}
	
@Column(name="vezani_pogoj",length=1)

	public String getVezani_pogoj() {
		return vezani_pogoj;
	}
	public void setVezani_pogoj(String vezani_pogoj) {
		this.vezani_pogoj = vezani_pogoj;
	}
	
	
@Index(name="templateclass_id")
@Column(name="templateclass_id")

	public Long getTemplateclass_id() {
		return templateclass_id;
	}
	public void setTemplateclass_id(Long templateclass_id) {
		this.templateclass_id = templateclass_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((ime_pogoja == null) ? 0 : ime_pogoja.hashCode());
		result = prime * result
				+ ((opis_pogoja == null) ? 0 : opis_pogoja.hashCode());
		result = prime * result
				+ ((predpona_pogoja == null) ? 0 : predpona_pogoja.hashCode());
		result = prime
				+ ((sestavljeni_pogoj == null) ? 0 : sestavljeni_pogoj
						.hashCode());
		result = prime
				+ ((templateclass_id == null) ? 0 : templateclass_id.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
		result = prime * result
				+ ((tip_pogoja == null) ? 0 : tip_pogoja.hashCode());
		result = prime * result
				+ ((vezani_pogoj == null) ? 0 : vezani_pogoj.hashCode());
		result = prime * result
				+ ((vrednost_pogoja == null) ? 0 : vrednost_pogoja.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateClass other = (TemplateClass) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (ime_pogoja == null) {
			if (other.ime_pogoja != null)
				return false;
		} else if (!ime_pogoja.equals(other.ime_pogoja))
			return false;
		if (opis_pogoja == null) {
			if (other.opis_pogoja != null)
				return false;
		} else if (!opis_pogoja.equals(other.opis_pogoja))
			return false;
		if (predpona_pogoja == null) {
			if (other.predpona_pogoja != null)
				return false;
		} else if (!predpona_pogoja.equals(other.predpona_pogoja))
			return false;
		if (sestavljeni_pogoj == null) {
			if (other.sestavljeni_pogoj != null)
				return false;
		} else if (!sestavljeni_pogoj.equals(other.sestavljeni_pogoj))
			return false;
		if (templateclass_id == null) {
			if (other.templateclass_id != null)
				return false;
		} else if (!templateclass_id.equals(other.templateclass_id))
			return false;
		if (templatehead_id == null) {
			if (other.templatehead_id != null)
				return false;
		} else if (!templatehead_id.equals(other.templatehead_id))
			return false;
		if (tip_pogoja == null) {
			if (other.tip_pogoja != null)
				return false;
		} else if (!tip_pogoja.equals(other.tip_pogoja))
			return false;
		if (vezani_pogoj == null) {
			if (other.vezani_pogoj != null)
				return false;
		} else if (!vezani_pogoj.equals(other.vezani_pogoj))
			return false;
		if (vrednost_pogoja == null) {
			if (other.vrednost_pogoja != null)
				return false;
		} else if (!vrednost_pogoja.equals(other.vrednost_pogoja))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	

}
