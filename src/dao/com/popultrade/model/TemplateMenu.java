package com.popultrade.model;

import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table (name="templatemenu")


public class TemplateMenu extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 987654579763234441L;
	private Long id; /// menu id
	private String menu_naziv; /// ime polja v meniju
	private Integer zaporedje; /// zaporedje prikaza
	private Integer stopnja; /// stopnja oz globina polja
	private String dodatni_pogoji; /// dodatni pogoji, ki se posljejo preko menuja, ter uporabi pri listu
	
	private String pogoj_prikaza; /// pogoj prikaza menija pri izbiri izdelave userja
	
	
	
	private Long templatemenu_id; /// veza na template menu
	
	private List templatemenus = new ArrayList();
	
	private Long templatehead_id; /// veza na templatehead
	
	private Long menu;
	private String show_wo_login; /// shows menu without login
	
	private String split_frame_v; /// odpri v split frametu
	private String split_frame_h; /// odpri v split frametu	
	
	private String rocen_url; /// rocen url
	
	private String dodaten_pogoj; /// dodaten parameter
	
	
	
	@Column(name="dodaten_pogoj",length=250)

	
	
	
	

	public String getDodaten_pogoj() {
		return dodaten_pogoj;
	}

	public void setDodaten_pogoj(String dodaten_pogoj) {
		this.dodaten_pogoj = dodaten_pogoj;
	}

	@Column(name="rocen_url",length=90)

	
	public String getRocen_url() {
		return rocen_url;
	}

	public void setRocen_url(String rocen_url) {
		this.rocen_url = rocen_url;
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
	
	private String okno11; /// sirina prvega okna slit frameta
	
	private String okno22; /// sirina drugega okna slit frameta
	
	
	
	
	
	
	
	
	
	
	
	
	@Column(name="okno11",length=3)

	
	public String getOkno11() {
		return okno11;
	}

	public void setOkno11(String okno11) {
		this.okno11 = okno11;
	}
	
	
	@Column(name="okno22",length=3)
	public String getOkno22() {
		return okno22;
	}

	public void setOkno22(String okno22) {
		this.okno22 = okno22;
	}

	@Column(name="split_frame_v",length=1)

	public String getSplit_frame_v() {
		return split_frame_v;
	}

	public void setSplit_frame_v(String split_frame_v) {
		this.split_frame_v = split_frame_v;
	}
	
	
	
	@Column(name="split_frame_h",length=1)
	public String getSplit_frame_h() {
		return split_frame_h;
	}

	public void setSplit_frame_h(String split_frame_h) {
		this.split_frame_h = split_frame_h;
	}

	@Column(name="pogoj_prikaza",length=400)


	public String getPogoj_prikaza() {
		return pogoj_prikaza;
	}

	public void setPogoj_prikaza(String pogoj_prikaza) {
		this.pogoj_prikaza = pogoj_prikaza;
	}


	
	
@Column(name="show_wo_login",length=1)


	public String getShow_wo_login() {
		return show_wo_login;
	}
	public void setShow_wo_login(String show_wo_login) {
		this.show_wo_login = show_wo_login;
	}
	
	
@Column(name="menu")

	
	
	public Long getMenu() {
		return menu;
	}
	public void setMenu(Long menu) {
		this.menu = menu;
	}
@Column(name="dodatni_pogoji",length=70)

	
	
	public String getDodatni_pogoji() {
		return dodatni_pogoji;
	}
	public void setDodatni_pogoji(String dodatni_pogoji) {
		this.dodatni_pogoji = dodatni_pogoji;
	}
@Index(name="templatehead_id")
@Column(name="templatehead_id")

	public Long getTemplatehead_id() {
		return templatehead_id;
	}
	public void setTemplatehead_id(Long templatehead_id) {
		this.templatehead_id = templatehead_id;
	}
@Index(name="templatemenu_id")
@Column(name="templatemenu_id")

	
	public Long getTemplatemenu_id() {
		return templatemenu_id;
	}
	public void setTemplatemenu_id(Long templatemenu_id) {
		this.templatemenu_id = templatemenu_id;
	}
	
	

@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateMenu.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="templatemenu_id",referencedColumnName="id")
@OrderBy("zaporedje asc")

	
	public List getTemplatemenus() {
		return templatemenus;
	}
	public void setTemplatemenus(List templatemenus) {
		this.templatemenus = templatemenus;
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
	
@Column(name="menu_naziv",length=55)

	public String getMenu_naziv() {
		return menu_naziv;
	}
	public void setMenu_naziv(String menu_naziv) {
		this.menu_naziv = menu_naziv;
	}
	
@Column(name="zaporedje")

	public Integer getZaporedje() {
		return zaporedje;
	}
	public void setZaporedje(Integer zaporedje) {
		this.zaporedje = zaporedje;
	}
@Column(name="stopnja")

	public Integer getStopnja() {
		return stopnja;
	}
	public void setStopnja(Integer stopnja) {
		this.stopnja = stopnja;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((menu_naziv == null) ? 0 : menu_naziv.hashCode());
		result = prime * result + ((stopnja == null) ? 0 : stopnja.hashCode());
		result = prime * result
				+ ((templatemenu_id == null) ? 0 : templatemenu_id.hashCode());
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
		TemplateMenu other = (TemplateMenu) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (menu_naziv == null) {
			if (other.menu_naziv != null)
				return false;
		} else if (!menu_naziv.equals(other.menu_naziv))
			return false;
		if (stopnja == null) {
			if (other.stopnja != null)
				return false;
		} else if (!stopnja.equals(other.stopnja))
			return false;
		if (templatemenu_id == null) {
			if (other.templatemenu_id != null)
				return false;
		} else if (!templatemenu_id.equals(other.templatemenu_id))
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
