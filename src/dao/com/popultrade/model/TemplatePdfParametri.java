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
@Table (name="templatepdfparametri")


public class TemplatePdfParametri extends BaseObject implements Serializable {
	
	
	
	
	private static final long serialVersionUID = 1221321312324242411L;
	private Long id;
	private Long veza_id; //// veza na templatelist ali templateview
	
	private String pdf_font_size; ///velikost fontov vrednost
	private String pdf_font_size_prevod; /// velikost fontov prevod
	
	private String pdf_font_width; ///debelina fonta
	private String pdf_font_size_prevod_width; /// debelina fonta prevod
	
	private String pdf_header_font_size; /// header font size
	private String pdf_header_width; /// ce gre za header debelina fonta
	
	private String pdf_header_bgcolor_prevod; /// barva ozadja prevoda
	
	
	private String pdf_cell_width_value; /// sirina stolpca
	private String pdf_cell_width_prevod; /// sirina stolpca prevod
	
	
	private String pdf_head_glava_lista_font_size; /// font head liste
	private String pdf_head_glava_lista_font_width; /// font head liste bold
	private String pdf_list_okvir; /// ce dam okvir okoli tabele list
	
	
	private String pdf_list_brez_head; /// tabela brez opisov stolpcev
	
	
	
	
	private String uporabi_page_break; /// da na novo stran po vsakem headerju
	
	
	private String pdf_header_padding; //// padding od tabele
	private String pdf_header_spacing; /// spcing od tabele
	
	private String margin_top; /// razdalja zgoraj od prejsnjega elementa
	private String margin_bottom; /// razdalja headerja od naslednjega elementa
	
	
	
	
	
	
	
	private String xml_dodatno;
	private String fo_header;
	private String fo_footer;
	
	private String java_koda;
	
	
	
	private String head_height="";
	private String footer_height="";
	private String type=""; /// where pdf parameters are linked (v - value, t - translation) 
	
	
	private String padding_top="";
	//private String padding="";
	private String line_height="";
	
	
	
	
	
	
	
	
	
//	background-color => bgc
		 	   /// text-align => talign
		 	   /// color (font) => tcolor
		 	   /// font-weight => fweight
		 	   /// line-height => lheight
		 	   /// padding => padding
		 	   /// padding-top => tpadding
		 	/// padding-left => lpadding
		 	/// padding-right => rpadding
		 	/// padding-bottom => bpadding
		 	   /// font-size => fsize
		 	   /// font-family => ffamily
		 	   /// margin => margin
		 	/// margin-left => lmargin
		 	/// margin-top => tmargin
		 	/// margin-right => rmargin
		 	/// margin-bottom => bmargin
	
	
	
	@Column(name="padding_top",length=5)

	public String getPadding_top() {
		return padding_top;
	}
	public void setPadding_top(String padding_top) {
		this.padding_top = padding_top;
	}
	
	@Column(name="line_height",length=5)
	public String getLine_height() {
		return line_height;
	}
	public void setLine_height(String line_height) {
		this.line_height = line_height;
	}

	private String  bgc="";
	private String  talign="";
	private String  tcolor="";
	private String  fweight="";
	private String  lheight="";
	private String  padding="";
	private String  tpadding="";
	private String  lpadding="";
	private String  rpadding="";
	private String  bpadding="";
	private String  fsize="";
	private String  ffamily="";
	private String  margin="";
	private String  lmargin="";
	private String  tmargin="";
	private String  rmargin="";
	private String  bmargin="";
	
	
	
	
	private String footerlevospodaj = "";
	private String footerdesnospodaj="";
	
	
	
	
	
	
	
	@Column(name="footerlevospodaj",length=100)

	
	public String getFooterlevospodaj() {
		return footerlevospodaj;
	}
	public void setFooterlevospodaj(String footerlevospodaj) {
		this.footerlevospodaj = footerlevospodaj;
	}
	
	@Column(name="footerdesnospodaj",length=100)

	
	public String getFooterdesnospodaj() {
		return footerdesnospodaj;
	}
	public void setFooterdesnospodaj(String footerdesnospodaj) {
		this.footerdesnospodaj = footerdesnospodaj;
	}
	
	
	
	
	@Column(name="type_",length=1)

	

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	
	
	@Column(name="bgc",length=25)

	
	public String getBgc() {
		return bgc;
	}
	public void setBgc(String bgc) {
		this.bgc = bgc;
	}
	
	
	@Column(name="talign",length=6)

	
	public String getTalign() {
		return talign;
	}
	public void setTalign(String talign) {
		this.talign = talign;
	}	
	
	@Column(name="tcolor",length=25)

	
	public String getTcolor() {
		return tcolor;
	}
	public void setTcolor(String tcolor) {
		this.tcolor = tcolor;
	}	
	
	@Column(name="fweight",length=6)

	
	public String getFweight() {
		return fweight;
	}
	public void setFweight(String fweight) {
		this.fweight = fweight;
	}	
	
	@Column(name="lheight",length=6)

	
	public String getLheight() {
		return lheight;
	}
	public void setLheight(String lheight) {
		this.lheight = lheight;
	}	
	
	@Column(name="padding",length=6)

	
	public String getPadding() {
		return padding;
	}
	public void setPadding(String padding) {
		this.padding = padding;
	}	
	
	@Column(name="tpadding",length=6)

	
	public String getTpadding() {
		return tpadding;
	}
	public void setTpadding(String tpadding) {
		this.tpadding = tpadding;
	}	
	
	@Column(name="lpadding",length=6)

	
	public String getLpadding() {
		return lpadding;
	}
	public void setLpadding(String lpadding) {
		this.lpadding = lpadding;
	}	
	
	@Column(name="rpadding",length=6)

	
	public String getRpadding() {
		return rpadding;
	}
	public void setRpadding(String rpadding) {
		this.rpadding = rpadding;
	}	
	
	@Column(name="bpadding",length=6)

	
	public String getBpadding() {
		return bpadding;
	}
	public void setBpadding(String bpadding) {
		this.bpadding = bpadding;
	}	
	
	@Column(name="fsize",length=6)

	
	public String getFsize() {
		return fsize;
	}
	public void setFsize(String fsize) {
		this.fsize = fsize;
	}	
	
	@Column(name="ffamily",length=25)

	
	public String getFfamily() {
		return ffamily;
	}
	public void setFfamily(String ffamily) {
		this.ffamily = ffamily;
	}	
	
	@Column(name="margin",length=6)

	
	public String getMargin() {
		return margin;
	}
	public void setMargin(String margin) {
		this.margin = margin;
	}	
	
	@Column(name="lmargin",length=6)

	
	public String getLmargin() {
		return lmargin;
	}
	public void setLmargin(String lmargin) {
		this.lmargin = lmargin;
	}	
	
	@Column(name="tmargin",length=6)

	
	public String getTmargin() {
		return tmargin;
	}
	public void setTmargin(String tmargin) {
		this.tmargin = tmargin;
	}	
	
	@Column(name="rmargin",length=6)

	
	public String getRmargin() {
		return rmargin;
	}
	public void setRmargin(String rmargin) {
		this.rmargin = rmargin;
	}	
	
	@Column(name="bmargin",length=6)

	
	public String getBmargin() {
		return bmargin;
	}
	public void setBmargin(String bmargin) {
		this.bmargin = bmargin;
	}
	
	
	
	
	
	
	
	
	
	@Column(name="head_height",length=5)
	
	public String getHead_height() {
		return head_height;
	}
	public void setHead_height(String head_height) {
		this.head_height = head_height;
	}
	
	@Column(name="footer_height",length=5)
	public String getFooter_height() {
		return footer_height;
	}
	public void setFooter_height(String footer_height) {
		this.footer_height = footer_height;
	}
	
	
	
	@Column(name="java_koda")

	
	
	public String getJava_koda() {
		return java_koda;
	}
	public void setJava_koda(String java_koda) {
		this.java_koda = java_koda;
	}
	
	
	@Column(name="xml_dodatno")

	
	public String getXml_dodatno() {
		return xml_dodatno;
	}
	public void setXml_dodatno(String xml_dodatno) {
		this.xml_dodatno = xml_dodatno;
	}
	
	@Column(name="fo_header")
	
	public String getFo_header() {
		return fo_header;
	}
	public void setFo_header(String fo_header) {
		this.fo_header = fo_header;
	}
	
	
	@Column(name="fo_footer")
	
	public String getFo_footer() {
		return fo_footer;
	}
	public void setFo_footer(String fo_footer) {
		this.fo_footer = fo_footer;
	}
	
	
	@Column(name="margin_bottom",length=5)

	
	
	public String getMargin_bottom() {
		return margin_bottom;
	}
	public void setMargin_bottom(String margin_bottom) {
		this.margin_bottom = margin_bottom;
	}
	
	
	@Column(name="margin_top",length=5)

public String getMargin_top() {
		return margin_top;
	}
	public void setMargin_top(String margin_top) {
		this.margin_top = margin_top;
	}
	
	/////// opcije za footer
	
	private String f_verzija;
	private String f_vrednost_pod_crto;
	
	
	private TemplateFunkcijaStart templatefunkcijastart;
	
	
	@OneToOne
    @JoinColumn(name = "veza_id",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
	public TemplateFunkcijaStart getTemplatefunkcijastart() {
		return templatefunkcijastart;
	}
	public void setTemplatefunkcijastart(TemplateFunkcijaStart templatefunkcijastart) {
		this.templatefunkcijastart = templatefunkcijastart;
	}	
	
	/////// opcija za header strani
	
@Column(name="pdf_header_padding",length=2)


	public String getPdf_header_padding() {
		return pdf_header_padding;
	}


	public void setPdf_header_padding(String pdfHeaderPadding) {
		pdf_header_padding = pdfHeaderPadding;
	}

@Column(name="pdf_header_spacing",length=2)

	public String getPdf_header_spacing() {
		return pdf_header_spacing;
	}


	public void setPdf_header_spacing(String pdfHeaderSpacing) {
		pdf_header_spacing = pdfHeaderSpacing;
	}

	
	
	
@Column(name="pdf_header_bgcolor_prevod",length=6)

	
	public String getPdf_header_bgcolor_prevod() {
		return pdf_header_bgcolor_prevod;
	}



	public void setPdf_header_bgcolor_prevod(String pdf_header_bgcolor_prevod) {
		this.pdf_header_bgcolor_prevod = pdf_header_bgcolor_prevod;
	}

@Column(name="f_verzija",length=70)

	public String getF_verzija() {
		return f_verzija;
	}


	public void setF_verzija(String f_verzija) {
		this.f_verzija = f_verzija;
	}

@Column(name="f_vrednost_pod_crto",length=400)

	public String getF_vrednost_pod_crto() {
		return f_vrednost_pod_crto;
	}


	public void setF_vrednost_pod_crto(String f_vrednost_pod_crto) {
		this.f_vrednost_pod_crto = f_vrednost_pod_crto;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
@Column(name="uporabi_page_break",length=1)

	
	public String getUporabi_page_break() {
		return uporabi_page_break;
	}


	

	public void setUporabi_page_break(String uporabi_page_break) {
		this.uporabi_page_break = uporabi_page_break;
	}


@Column(name="pdf_list_brez_head",length=1)

	
	
	public String getPdf_list_brez_head() {
		return pdf_list_brez_head;
	}


	public void setPdf_list_brez_head(String pdf_list_brez_head) {
		this.pdf_list_brez_head = pdf_list_brez_head;
	}


@Column(name="pdf_head_glava_lista_font_size",length=5)

	
	public String getPdf_head_glava_lista_font_size() {
		return pdf_head_glava_lista_font_size;
	}


	public void setPdf_head_glava_lista_font_size(
			String pdf_head_glava_lista_font_size) {
		this.pdf_head_glava_lista_font_size = pdf_head_glava_lista_font_size;
	}

@Column(name="pdf_head_glava_lista_fontwidth",length=1)

	public String getPdf_head_glava_lista_font_width() {
		return pdf_head_glava_lista_font_width;
	}


	public void setPdf_head_glava_lista_font_width(
			String pdf_head_glava_lista_font_width) {
		this.pdf_head_glava_lista_font_width = pdf_head_glava_lista_font_width;
	}

@Column(name="pdf_list_okvir",length=1)

	public String getPdf_list_okvir() {
		return pdf_list_okvir;
	}


	public void setPdf_list_okvir(String pdf_list_okvir) {
		this.pdf_list_okvir = pdf_list_okvir;
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

@Index(name="veza_id")
@Column(name="veza_id")

	public Long getVeza_id() {
		return veza_id;
	}


	public void setVeza_id(Long veza_id) {
		this.veza_id = veza_id;
	}

@Column(name="pdf_header_font_size",length=5)

	public String getPdf_header_font_size() {
		return pdf_header_font_size;
	}


	public void setPdf_header_font_size(String pdf_header_font_size) {
		this.pdf_header_font_size = pdf_header_font_size;
	}

@Column(name="pdf_header_width",length=1)

	public String getPdf_header_width() {
		return pdf_header_width;
	}


	public void setPdf_header_width(String pdf_header_width) {
		this.pdf_header_width = pdf_header_width;
	}


@Column(name="pdf_font_size",length=5)

	
	
	public String getPdf_font_size() {
		return pdf_font_size;
	}


	public void setPdf_font_size(String pdf_font_size) {
		this.pdf_font_size = pdf_font_size;
	}

@Column(name="pdf_font_size_prevod",length=5)

	public String getPdf_font_size_prevod() {
		return pdf_font_size_prevod;
	}


	public void setPdf_font_size_prevod(String pdf_font_size_prevod) {
		this.pdf_font_size_prevod = pdf_font_size_prevod;
	}

@Column(name="pdf_font_width",length=1)

	public String getPdf_font_width() {
		return pdf_font_width;
	}


	public void setPdf_font_width(String pdf_font_width) {
		this.pdf_font_width = pdf_font_width;
	}

@Column(name="pdf_font_size_prevod_width",length=1)

	public String getPdf_font_size_prevod_width() {
		return pdf_font_size_prevod_width;
	}


	public void setPdf_font_size_prevod_width(String pdf_font_size_prevod_width) {
		this.pdf_font_size_prevod_width = pdf_font_size_prevod_width;
	}



@Column(name="pdf_cell_width_value",length=5)


	public String getPdf_cell_width_value() {
		return pdf_cell_width_value;
	}


	public void setPdf_cell_width_value(String pdf_cell_width_value) {
		this.pdf_cell_width_value = pdf_cell_width_value;
	}

@Column(name="pdf_cell_width_prevod",length=5)

	public String getPdf_cell_width_prevod() {
		return pdf_cell_width_prevod;
	}


	public void setPdf_cell_width_prevod(String pdf_cell_width_prevod) {
		this.pdf_cell_width_prevod = pdf_cell_width_prevod;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				+ ((pdf_cell_width_prevod == null) ? 0 : pdf_cell_width_prevod
						.hashCode());
		result = prime
				+ ((pdf_cell_width_value == null) ? 0 : pdf_cell_width_value
						.hashCode());
		result = prime * result
				+ ((pdf_font_size == null) ? 0 : pdf_font_size.hashCode());
		result = prime
				+ ((pdf_font_size_prevod == null) ? 0 : pdf_font_size_prevod
						.hashCode());
		result = prime
				+ ((pdf_font_size_prevod_width == null) ? 0
						: pdf_font_size_prevod_width.hashCode());
		result = prime * result
				+ ((pdf_font_width == null) ? 0 : pdf_font_width.hashCode());
		result = prime
				+ ((pdf_header_font_size == null) ? 0 : pdf_header_font_size
						.hashCode());
		result = prime
				+ ((pdf_header_width == null) ? 0 : pdf_header_width.hashCode());
		result = prime * result + ((veza_id == null) ? 0 : veza_id.hashCode());
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplatePdfParametri other = (TemplatePdfParametri) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (pdf_cell_width_prevod == null) {
			if (other.pdf_cell_width_prevod != null)
				return false;
		} else if (!pdf_cell_width_prevod.equals(other.pdf_cell_width_prevod))
			return false;
		if (pdf_cell_width_value == null) {
			if (other.pdf_cell_width_value != null)
				return false;
		} else if (!pdf_cell_width_value.equals(other.pdf_cell_width_value))
			return false;
		if (pdf_font_size == null) {
			if (other.pdf_font_size != null)
				return false;
		} else if (!pdf_font_size.equals(other.pdf_font_size))
			return false;
		if (pdf_font_size_prevod == null) {
			if (other.pdf_font_size_prevod != null)
				return false;
		} else if (!pdf_font_size_prevod.equals(other.pdf_font_size_prevod))
			return false;
		if (pdf_font_size_prevod_width == null) {
			if (other.pdf_font_size_prevod_width != null)
				return false;
		} else if (!pdf_font_size_prevod_width
				.equals(other.pdf_font_size_prevod_width))
			return false;
		if (pdf_font_width == null) {
			if (other.pdf_font_width != null)
				return false;
		} else if (!pdf_font_width.equals(other.pdf_font_width))
			return false;
		if (pdf_header_font_size == null) {
			if (other.pdf_header_font_size != null)
				return false;
		} else if (!pdf_header_font_size.equals(other.pdf_header_font_size))
			return false;
		if (pdf_header_width == null) {
			if (other.pdf_header_width != null)
				return false;
		} else if (!pdf_header_width.equals(other.pdf_header_width))
			return false;
		if (veza_id == null) {
			if (other.veza_id != null)
				return false;
		} else if (!veza_id.equals(other.veza_id))
			return false;
		return true;
	}


	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}
