package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table (name="templatetablescol")


public class TemplateTablesCol extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 4233565666556544441L;
	private Long id;
	private Long id_nad; /// id template tables
	private String field_name; /// ime polja , hibernate
	private String type; /// tip polja v bazi
	
	private String width; /// dolzina polja
	private String width_decimals; /// dolzina polja z decimalkami , samo za dokumentacijo
	private String st_decimal; /// st decimalk
	
	
	private String is_index; /// char 1
	private String index_name ; ///char 25
	
	private String description ; ///char 400 opis polja v tabeli (kaj, kdaj, zakaj, )
	
	
	private String is_primarykey ; ///char 1
	private String increment_type ; ///char 25 --- (tip incrementa: sekvenca, native, autoincrement,)
	private String sequence_name; /// char 35 --- ime sekvence ce je increment type sequence
	
	
	private String h_type; /// char 25 --- tip polja (za hibernate , polje je lahko property, column,)
	private String h_type_java ; ///35 --- tip polja v javi (string, text, long,integer,double, datetime)
	
	
	private String h_connection_type ; ///char 35 --- povezava na drugo tabelo - hibernate
	private String h_connection_table ; ///char 35 --- ime tabele povezane na to
	private String h_connection_join; /// char 1 --- outer / inner join
	
	private String h_connection_cascade; /// char 1 --- cascade kaj naredi ko zbrisem record
	
	private String h_connection_property_ref; /// char 45 --- property referenca na stolpec druge tabele - hibernate
	private String h_connection_column ; ///char 45 --- stolpec vezave do druge tabele
	
	private String h_mapped_by;/// char 45 --- mapped by property za onetoone
	
	
	private String h_property_formula_name ; ///char 35 --- ime property formule  
	private String h_property_formula ; ///char 400 --- select za property formula
	
	private String h_null ; ///char 1 --- je not null ali ne
	private String production_status ; ///char 1 status polja za v produ (1-daj v prod, 2-ne dat v prod) 
	private String field_name_db; /// ime polja v bazi, ce razlicno od field name

	private String h_datefromto; /// naredim datum od do v hibernate za iskanje
	
	private String comments; /// komentar
	
	
	
	private String content_key; /// vsebinski kljuc 200
	
	
	private String access_field_type; /// tip dostopa do polja
	
	private String orderby_relations; /// order by for onetomany, manytoone
	
	
	
	
	@Column(name="orderby_relations")
	
	
	
	public String getOrderby_relations() {
		return orderby_relations;
	}

	public void setOrderby_relations(String orderby_relations) {
		this.orderby_relations = orderby_relations;
	}

	@Column(name="width_decimals")
	
	
	
	public String getWidth_decimals() {
		return width_decimals;
	}

	public void setWidth_decimals(String width_decimals) {
		this.width_decimals = width_decimals;
	}

	@Column(name="access_field_type",length=50)
	
	
	public String getAccess_field_type() {
		return access_field_type;
	}

	public void setAccess_field_type(String access_field_type) {
		this.access_field_type = access_field_type;
	}
	
	
	@Column(name="content_key",length=200)
	
	
	public String getContent_key() {
		return content_key;
	}
	public void setContent_key(String content_key) {
		this.content_key = content_key;
	}
	
	
	
	@Column(name="comments",length=4000)
	
	
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	
	
	@Column(name="h_datefromto",length=1)
	
	public String getH_datefromto() {
		return h_datefromto;
	}
	public void setH_datefromto(String h_datefromto) {
		this.h_datefromto = h_datefromto;
	}
	
	
	
	@Column(name="field_name_db",length=55)
	
	public String getField_name_db() {
		return field_name_db;
	}
	public void setField_name_db(String field_name_db) {
		this.field_name_db = field_name_db;
	}
	
	
	
	@Column(name="h_mapped_by",length=45)
	
	public String getH_mapped_by() {
		return h_mapped_by;
	}
	public void setH_mapped_by(String h_mapped_by) {
		this.h_mapped_by = h_mapped_by;
	}
	/**
     * 
     * @hibernate.id column="id"
     */
	
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
	
	@Column(name="id_nad")
	public Long getId_nad() {
		return id_nad;
	}
	public void setId_nad(Long id_nad) {
		this.id_nad = id_nad;
	}
	
	

	
	@Column(name="field_name")
	
	public String getField_name() {
		return field_name;
	}
	public void setField_name(String field_name) {
		this.field_name = field_name;
	}
	
	
	@Column(name="type")
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	@Column(name="width")
	
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	
	
	@Column(name="st_decimal")
	
	public String getSt_decimal() {
		return st_decimal;
	}
	public void setSt_decimal(String st_decimal) {
		this.st_decimal = st_decimal;
	}
	
	
	@Column(name="is_index",length=1)
	
	public String getIs_index() {
		return is_index;
	}
	public void setIs_index(String is_index) {
		this.is_index = is_index;
	}
	
	
	@Column(name="index_name",length=35)
	
	public String getIndex_name() {
		return index_name;
	}
	public void setIndex_name(String index_name) {
		this.index_name = index_name;
	}
	
	
	@Column(name="description",length=400)
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	@Column(name="is_primarykey",length=1)
	
	public String getIs_primarykey() {
		return is_primarykey;
	}
	public void setIs_primarykey(String is_primarykey) {
		this.is_primarykey = is_primarykey;
	}
	
	
	@Column(name="increment_type",length=25)
	
	public String getIncrement_type() {
		return increment_type;
	}
	public void setIncrement_type(String increment_type) {
		this.increment_type = increment_type;
	}
	
	
	@Column(name="sequence_name",length=35)
	
	public String getSequence_name() {
		return sequence_name;
	}
	public void setSequence_name(String sequence_name) {
		this.sequence_name = sequence_name;
	}
	
	
	@Column(name="h_type",length=35)
	
	public String getH_type() {
		return h_type;
	}
	public void setH_type(String h_type) {
		this.h_type = h_type;
	}
	
	
	@Column(name="h_type_java",length=35)
	
	public String getH_type_java() {
		return h_type_java;
	}
	public void setH_type_java(String h_type_java) {
		this.h_type_java = h_type_java;
	}
	
	
	@Column(name="h_connection_type",length=35)
	
	public String getH_connection_type() {
		return h_connection_type;
	}
	public void setH_connection_type(String h_connection_type) {
		this.h_connection_type = h_connection_type;
	}
	
	
	@Column(name="h_connection_table",length=45)
	
	public String getH_connection_table() {
		return h_connection_table;
	}
	public void setH_connection_table(String h_connection_table) {
		this.h_connection_table = h_connection_table;
	}
	
	
	@Column(name="h_connection_join",length=35)
	
	public String getH_connection_join() {
		return h_connection_join;
	}
	public void setH_connection_join(String h_connection_join) {
		this.h_connection_join = h_connection_join;
	}
	
	
	@Column(name="h_connection_cascade",length=35)
	
	public String getH_connection_cascade() {
		return h_connection_cascade;
	}
	public void setH_connection_cascade(String h_connection_cascade) {
		this.h_connection_cascade = h_connection_cascade;
	}
	
	
	@Column(name="h_connection_property_ref",length=45)
	
	public String getH_connection_property_ref() {
		return h_connection_property_ref;
	}
	public void setH_connection_property_ref(String h_connection_property_ref) {
		this.h_connection_property_ref = h_connection_property_ref;
	}
	
	
	@Column(name="h_connection_column",length=45)
	
	public String getH_connection_column() {
		return h_connection_column;
	}
	public void setH_connection_column(String h_connection_column) {
		this.h_connection_column = h_connection_column;
	}
	
	
	@Column(name="h_property_formula_name",length=35)
	
	public String getH_property_formula_name() {
		return h_property_formula_name;
	}
	public void setH_property_formula_name(String h_property_formula_name) {
		this.h_property_formula_name = h_property_formula_name;
	}
	
	
	@Column(name="h_property_formula",length=250)
	
	public String getH_property_formula() {
		return h_property_formula;
	}
	public void setH_property_formula(String h_property_formula) {
		this.h_property_formula = h_property_formula;
	}
	
	
	@Column(name="h_null",length=1)
	
	public String getH_null() {
		return h_null;
	}
	public void setH_null(String h_null) {
		this.h_null = h_null;
	}
	
	
	@Column(name="production_status",length=1)
	
	public String getProduction_status() {
		return production_status;
	}
	public void setProduction_status(String production_status) {
		this.production_status = production_status;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result
				+ ((field_name == null) ? 0 : field_name.hashCode());
		result = prime
				* result
				+ ((h_connection_cascade == null) ? 0 : h_connection_cascade
						.hashCode());
		result = prime
				* result
				+ ((h_connection_column == null) ? 0 : h_connection_column
						.hashCode());
		result = prime
				* result
				+ ((h_connection_join == null) ? 0 : h_connection_join
						.hashCode());
		result = prime
				* result
				+ ((h_connection_property_ref == null) ? 0
						: h_connection_property_ref.hashCode());
		result = prime
				* result
				+ ((h_connection_table == null) ? 0 : h_connection_table
						.hashCode());
		result = prime
				* result
				+ ((h_connection_type == null) ? 0 : h_connection_type
						.hashCode());
		result = prime * result + ((h_null == null) ? 0 : h_null.hashCode());
		result = prime
				* result
				+ ((h_property_formula == null) ? 0 : h_property_formula
						.hashCode());
		result = prime
				* result
				+ ((h_property_formula_name == null) ? 0
						: h_property_formula_name.hashCode());
		result = prime * result + ((h_type == null) ? 0 : h_type.hashCode());
		result = prime * result
				+ ((h_type_java == null) ? 0 : h_type_java.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((id_nad == null) ? 0 : id_nad.hashCode());
		result = prime * result
				+ ((increment_type == null) ? 0 : increment_type.hashCode());
		result = prime * result
				+ ((index_name == null) ? 0 : index_name.hashCode());
		result = prime * result
				+ ((is_index == null) ? 0 : is_index.hashCode());
		result = prime * result
				+ ((is_primarykey == null) ? 0 : is_primarykey.hashCode());
		result = prime
				* result
				+ ((production_status == null) ? 0 : production_status
						.hashCode());
		result = prime * result
				+ ((sequence_name == null) ? 0 : sequence_name.hashCode());
		result = prime * result
				+ ((st_decimal == null) ? 0 : st_decimal.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		result = prime * result + ((width == null) ? 0 : width.hashCode());
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
		TemplateTablesCol other = (TemplateTablesCol) obj;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (field_name == null) {
			if (other.field_name != null)
				return false;
		} else if (!field_name.equals(other.field_name))
			return false;
		if (h_connection_cascade == null) {
			if (other.h_connection_cascade != null)
				return false;
		} else if (!h_connection_cascade.equals(other.h_connection_cascade))
			return false;
		if (h_connection_column == null) {
			if (other.h_connection_column != null)
				return false;
		} else if (!h_connection_column.equals(other.h_connection_column))
			return false;
		if (h_connection_join == null) {
			if (other.h_connection_join != null)
				return false;
		} else if (!h_connection_join.equals(other.h_connection_join))
			return false;
		if (h_connection_property_ref == null) {
			if (other.h_connection_property_ref != null)
				return false;
		} else if (!h_connection_property_ref
				.equals(other.h_connection_property_ref))
			return false;
		if (h_connection_table == null) {
			if (other.h_connection_table != null)
				return false;
		} else if (!h_connection_table.equals(other.h_connection_table))
			return false;
		if (h_connection_type == null) {
			if (other.h_connection_type != null)
				return false;
		} else if (!h_connection_type.equals(other.h_connection_type))
			return false;
		if (h_null == null) {
			if (other.h_null != null)
				return false;
		} else if (!h_null.equals(other.h_null))
			return false;
		if (h_property_formula == null) {
			if (other.h_property_formula != null)
				return false;
		} else if (!h_property_formula.equals(other.h_property_formula))
			return false;
		if (h_property_formula_name == null) {
			if (other.h_property_formula_name != null)
				return false;
		} else if (!h_property_formula_name
				.equals(other.h_property_formula_name))
			return false;
		if (h_type == null) {
			if (other.h_type != null)
				return false;
		} else if (!h_type.equals(other.h_type))
			return false;
		if (h_type_java == null) {
			if (other.h_type_java != null)
				return false;
		} else if (!h_type_java.equals(other.h_type_java))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (id_nad == null) {
			if (other.id_nad != null)
				return false;
		} else if (!id_nad.equals(other.id_nad))
			return false;
		if (increment_type == null) {
			if (other.increment_type != null)
				return false;
		} else if (!increment_type.equals(other.increment_type))
			return false;
		if (index_name == null) {
			if (other.index_name != null)
				return false;
		} else if (!index_name.equals(other.index_name))
			return false;
		if (is_index == null) {
			if (other.is_index != null)
				return false;
		} else if (!is_index.equals(other.is_index))
			return false;
		if (is_primarykey == null) {
			if (other.is_primarykey != null)
				return false;
		} else if (!is_primarykey.equals(other.is_primarykey))
			return false;
		if (production_status == null) {
			if (other.production_status != null)
				return false;
		} else if (!production_status.equals(other.production_status))
			return false;
		if (sequence_name == null) {
			if (other.sequence_name != null)
				return false;
		} else if (!sequence_name.equals(other.sequence_name))
			return false;
		if (st_decimal == null) {
			if (other.st_decimal != null)
				return false;
		} else if (!st_decimal.equals(other.st_decimal))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		if (width == null) {
			if (other.width != null)
				return false;
		} else if (!width.equals(other.width))
			return false;
		return true;
	}

	
	
	

}
