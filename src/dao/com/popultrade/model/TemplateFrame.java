package com.popultrade.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.*;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;


@Entity
@Table (name="templateframe")


public class TemplateFrame extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 4233565661926544441L;
	private Long id;

	private String opis; /// opis 
	private Long templateui_id;
	private String tip; /// tip frame strukture (elementi v tabeli, elementi absolute/relative pozicije)
	private String pozicija; /// zgoraj,levo,sredina,desno
	
	private String ime; /// lahko dodas order by
	
private Long veza_na_id; /// id na drugi templateframe, ce rabim drugega, ce je vrednost ne rabim drugih parametrov
private String dimenzija_tabele; /// dimenzija tabele v % 

private String visinasirina; /// visina oz. sirina frame , odvisno od pozicije
private String dimenzija_tabele_h; /// dimenzija tabele v % height

private String ddivclasscus; /// ime class v custom.css
private String dstyle; /// celoten style css, ki se vpise v tag


private String ddefaultcont; /// default div for all containers in a frame, mostly for borders

private String dpadding;
private String dspacing;

private String ismenu; /// ima menu frame

private String dcolnums; /// stevilo stolpcev preden zacne nova vrstica (oz. koliko elemntov lahko das v eno vrstico brez nextto)

private String dalign; /// align vse vsebine
private String dvalign; /// align vse vsebine vertikalno
private Long idmenu; /// veza na menu



private String trcontent; /// content of tr elements , text added to tr element











@Column(name="trcontent",length=500)




public String getTrcontent() {
	return trcontent;
}


public void setTrcontent(String trcontent) {
	this.trcontent = trcontent;
}


@Column(name="idmenu")




public Long getIdmenu() {
	return idmenu;
}


public void setIdmenu(Long idmenu) {
	this.idmenu = idmenu;
}


@Column(name="dvalign",length=8)



public String getDvalign() {
	return dvalign;
}


public void setDvalign(String dvalign) {
	this.dvalign = dvalign;
}


@Column(name="dalign",length=7)




public String getDalign() {
	return dalign;
}


public void setDalign(String dalign) {
	this.dalign = dalign;
}


@Column(name="dcolnums",length=2)




public String getDcolnums() {
	return dcolnums;
}


public void setDcolnums(String dcolnums) {
	this.dcolnums = dcolnums;
}


@Column(name="ismenu",length=1)




public String getIsmenu() {
	return ismenu;
}


public void setIsmenu(String ismenu) {
	this.ismenu = ismenu;
}


@Column(name="dpadding",length=4)



public String getDpadding() {
	return dpadding;
}


public void setDpadding(String dpadding) {
	this.dpadding = dpadding;
}


@Column(name="dspacing",length=4)

public String getDspacing() {
	return dspacing;
}


public void setDspacing(String dspacing) {
	this.dspacing = dspacing;
}


@Column(name="ddefaultcont",length=70)



public String getDdefaultcont() {
	return ddefaultcont;
}


public void setDdefaultcont(String ddefaultcont) {
	this.ddefaultcont = ddefaultcont;
}


@Column(name="dstyle",length=450)

public String getDstyle() {
	return dstyle;
}


public void setDstyle(String dstyle) {
	this.dstyle = dstyle;
}

@Column(name="ddivclasscus",length=70)




public String getDdivclasscus() {
	return ddivclasscus;
}


public void setDdivclasscus(String ddivclasscus) {
	this.ddivclasscus = ddivclasscus;
}





@Column(name="dimenzija_tabele_h",length=6)



public String getDimenzija_tabele_h() {
	return dimenzija_tabele_h;
}
public void setDimenzija_tabele_h(String dimenzija_tabele_h) {
	this.dimenzija_tabele_h = dimenzija_tabele_h;
}
@Column(name="visinasirina",length=6)


	public String getVisinasirina() {
	return visinasirina;
}
public void setVisinasirina(String visinasirina) {
	this.visinasirina = visinasirina;
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
	
	

@Column(name="dimenzija_tabele",length=6)

	
	public String getDimenzija_tabele() {
		return dimenzija_tabele;
	}
	public void setDimenzija_tabele(String dimenzija_tabele) {
		this.dimenzija_tabele = dimenzija_tabele;
	}
@Column(name="opis",length=450)

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
	
	
@Column(name="tip",length=10)

	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	
	
@Column(name="ime",length=100)

	public String getIme() {
		return ime;
	}
	public void setIme(String ime) {
		this.ime = ime;
	}
	
	
	
@Column(name="pozicija",length=10)

	public String getPozicija() {
		return pozicija;
	}
	public void setPozicija(String pozicija) {
		this.pozicija = pozicija;
	}
	
	
	
@Column(name="veza_na_id")

	public Long getVeza_na_id() {
		return veza_na_id;
	}
	public void setVeza_na_id(Long veza_na_id) {
		this.veza_na_id = veza_na_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((ime == null) ? 0 : ime.hashCode());
		result = prime * result
				+ ((pozicija == null) ? 0 : pozicija.hashCode());
		result = prime * result + ((opis == null) ? 0 : opis.hashCode());
		result = prime * result
				+ ((templateui_id == null) ? 0 : templateui_id.hashCode());
		result = prime * result + ((tip == null) ? 0 : tip.hashCode());
		result = prime * result
				+ ((veza_na_id == null) ? 0 : veza_na_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TemplateFrame other = (TemplateFrame) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (ime == null) {
			if (other.ime != null)
				return false;
		} else if (!ime.equals(other.ime))
			return false;
		if (pozicija == null) {
			if (other.pozicija != null)
				return false;
		} else if (!pozicija.equals(other.pozicija))
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
		if (tip == null) {
			if (other.tip != null)
				return false;
		} else if (!tip.equals(other.tip))
			return false;
		if (veza_na_id == null) {
			if (other.veza_na_id != null)
				return false;
		} else if (!veza_na_id.equals(other.veza_na_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
