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
@Table (name="templatepp")


public class TemplatePP extends BaseObject implements Serializable { /// template pred strani

	
	private static final long serialVersionUID = 1432534265433463388L;
	private Long id;
	private Long templatehead_id;
	
	
	
	private Integer zaporedje; /// zaporedje prikaza stolpcev
	private String stolpec_metoda; /// metoda v model classi
	private String format_stolpca; /// format za datum ali numeric
	private String stolpec_sirina;
	private String stolpec_max_stevilo_znakov; //
	

	
	
	private String kontrola_javascript; ///ima nima kontrolo js
	
	private TemplateDD templateDD = new TemplateDD();

	
	
private String tab_index; /// zaporedje s tabulatorjem


private String datum_vnos_tip; /// ti vnosa datuma, z uro ali brez

private String tip_inserta; /// select, text, textbox, checkbox
private String rows;
private String cols;




private String razlicno_ime_inputa; /// razlicno ime input polja

private List prevodis = new ArrayList();



@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templatepp")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)

public TemplateDD getTemplateDD() {
	return templateDD;
}


public void setTemplateDD(TemplateDD templateDD) {
	this.templateDD = templateDD;
}


@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="prevod_id",referencedColumnName="id")


public List getPrevodis() {
	return prevodis;
}

public void setPrevodis(List prevodis) {
	this.prevodis = prevodis;
}




@Column(name="razlicno_ime_inputa",length=30)



public String getRazlicno_ime_inputa() {
	return razlicno_ime_inputa;
}
public void setRazlicno_ime_inputa(String razlicno_ime_inputa) {
	this.razlicno_ime_inputa = razlicno_ime_inputa;
}




private TemplateClassClass templateClassClass = new TemplateClassClass();



@OneToOne(cascade = CascadeType.REMOVE,fetch=FetchType.EAGER,mappedBy="templatepp")
//@JoinColumn(name="id_veza",referencedColumnName="id",insertable=false,updatable=false,nullable=true)
@NotFound(action = NotFoundAction.IGNORE)
public TemplateClassClass getTemplateClassClass() {
	return templateClassClass;
}
public void setTemplateClassClass(TemplateClassClass templateClassClass) {
	this.templateClassClass = templateClassClass;
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
		result = prime * result + ((cols == null) ? 0 : cols.hashCode());
		result = prime * result
				+ ((datum_vnos_tip == null) ? 0 : datum_vnos_tip.hashCode());
		result = prime * result
				+ ((format_stolpca == null) ? 0 : format_stolpca.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				+ ((kontrola_javascript == null) ? 0 : kontrola_javascript
						.hashCode());
		result = prime * result + ((rows == null) ? 0 : rows.hashCode());
		result = prime
				+ ((stolpec_max_stevilo_znakov == null) ? 0
						: stolpec_max_stevilo_znakov.hashCode());
		result = prime * result
				+ ((stolpec_metoda == null) ? 0 : stolpec_metoda.hashCode());
		result = prime * result
				+ ((stolpec_sirina == null) ? 0 : stolpec_sirina.hashCode());
		result = prime * result
				+ ((tab_index == null) ? 0 : tab_index.hashCode());
		result = prime * result
				+ ((templateClasses == null) ? 0 : templateClasses.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
		result = prime * result
				+ ((tip_inserta == null) ? 0 : tip_inserta.hashCode());
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
		TemplatePP other = (TemplatePP) obj;
		if (cols == null) {
			if (other.cols != null)
				return false;
		} else if (!cols.equals(other.cols))
			return false;
		if (datum_vnos_tip == null) {
			if (other.datum_vnos_tip != null)
				return false;
		} else if (!datum_vnos_tip.equals(other.datum_vnos_tip))
			return false;
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
		if (kontrola_javascript == null) {
			if (other.kontrola_javascript != null)
				return false;
		} else if (!kontrola_javascript.equals(other.kontrola_javascript))
			return false;
		if (rows == null) {
			if (other.rows != null)
				return false;
		} else if (!rows.equals(other.rows))
			return false;
		if (stolpec_max_stevilo_znakov == null) {
			if (other.stolpec_max_stevilo_znakov != null)
				return false;
		} else if (!stolpec_max_stevilo_znakov
				.equals(other.stolpec_max_stevilo_znakov))
			return false;
		if (stolpec_metoda == null) {
			if (other.stolpec_metoda != null)
				return false;
		} else if (!stolpec_metoda.equals(other.stolpec_metoda))
			return false;
		if (stolpec_sirina == null) {
			if (other.stolpec_sirina != null)
				return false;
		} else if (!stolpec_sirina.equals(other.stolpec_sirina))
			return false;
		if (tab_index == null) {
			if (other.tab_index != null)
				return false;
		} else if (!tab_index.equals(other.tab_index))
			return false;
		if (templateClasses == null) {
			if (other.templateClasses != null)
				return false;
		} else if (!templateClasses.equals(other.templateClasses))
			return false;
		if (templatehead_id == null) {
			if (other.templatehead_id != null)
				return false;
		} else if (!templatehead_id.equals(other.templatehead_id))
			return false;
		if (tip_inserta == null) {
			if (other.tip_inserta != null)
				return false;
		} else if (!tip_inserta.equals(other.tip_inserta))
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
