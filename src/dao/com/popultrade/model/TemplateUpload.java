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
@Table (name="templateupload")


public class TemplateUpload extends BaseObject implements Serializable {
	
	
	
	private static final long serialVersionUID = 6564354565476576571L;
	private Long id;
	private Long templatehead_id;
	
	
	private String upload_filter; /// filter extensiona datotek
	private String upload_stevilo_polj; /// st moznih upload hkrati max 10
	
	private String refresh_po_upload; /// kateri frame refresh po upload, v primeru da ga ni refresha galerijo
	private String uporabi_watermark; /// watermark na sliki
	private String lokacija_watermark; /// watermark lokacija, celoten path na disku
	
	
	private String upload_slika_resize;
	private Integer upload_slika_width;
	private Integer upload_slika_height;
	
	
	private String upload_slika_v_resize;
	private Integer upload_slika_v_width;
	private Integer upload_slika_v_height;
	
	
	
	
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
	
	
@Column(name="upload_filter",length=70)

	public String getUpload_filter() {
		return upload_filter;
	}
	public void setUpload_filter(String upload_filter) {
		this.upload_filter = upload_filter;
	}
	
	
@Column(name="upload_stevilo_polj",length=2)

	public String getUpload_stevilo_polj() {
		return upload_stevilo_polj;
	}
	public void setUpload_stevilo_polj(String upload_stevilo_polj) {
		this.upload_stevilo_polj = upload_stevilo_polj;
	}
	
@Column(name="refresh_po_upload",length=2)

	public String getRefresh_po_upload() {
		return refresh_po_upload;
	}
	public void setRefresh_po_upload(String refresh_po_upload) {
		this.refresh_po_upload = refresh_po_upload;
	}
	
	
	
@Column(name="uporabi_watermark",length=1)

	public String getUporabi_watermark() {
		return uporabi_watermark;
	}
	public void setUporabi_watermark(String uporabi_watermark) {
		this.uporabi_watermark = uporabi_watermark;
	}
	
	
@Column(name="lokacija_watermark",length=100)

	public String getLokacija_watermark() {
		return lokacija_watermark;
	}
	public void setLokacija_watermark(String lokacija_watermark) {
		this.lokacija_watermark = lokacija_watermark;
	}
	
@Column(name="upload_slika_resize",length=1)

	public String getUpload_slika_resize() {
		return upload_slika_resize;
	}
	public void setUpload_slika_resize(String upload_slika_resize) {
		this.upload_slika_resize = upload_slika_resize;
	}
	
@Column(name="upload_slika_width")

	public Integer getUpload_slika_width() {
		return upload_slika_width;
	}
	public void setUpload_slika_width(Integer upload_slika_width) {
		this.upload_slika_width = upload_slika_width;
	}
	
@Column(name="upload_slika_height")

	public Integer getUpload_slika_height() {
		return upload_slika_height;
	}
	public void setUpload_slika_height(Integer upload_slika_height) {
		this.upload_slika_height = upload_slika_height;
	}
	
@Column(name="upload_slika_v_resize",length=1)

	public String getUpload_slika_v_resize() {
		return upload_slika_v_resize;
	}
	public void setUpload_slika_v_resize(String upload_slika_v_resize) {
		this.upload_slika_v_resize = upload_slika_v_resize;
	}
	
@Column(name="upload_slika_v_width")

	public Integer getUpload_slika_v_width() {
		return upload_slika_v_width;
	}
	public void setUpload_slika_v_width(Integer upload_slika_v_width) {
		this.upload_slika_v_width = upload_slika_v_width;
	}
	
@Column(name="upload_slika_v_height")

	public Integer getUpload_slika_v_height() {
		return upload_slika_v_height;
	}
	public void setUpload_slika_v_height(Integer upload_slika_v_height) {
		this.upload_slika_v_height = upload_slika_v_height;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				+ ((lokacija_watermark == null) ? 0 : lokacija_watermark
						.hashCode());
		result = prime
				+ ((refresh_po_upload == null) ? 0 : refresh_po_upload
						.hashCode());
		result = prime * result
				+ ((templatehead_id == null) ? 0 : templatehead_id.hashCode());
		result = prime * result
				+ ((upload_filter == null) ? 0 : upload_filter.hashCode());
		result = prime
				+ ((upload_slika_height == null) ? 0 : upload_slika_height
						.hashCode());
		result = prime
				+ ((upload_slika_resize == null) ? 0 : upload_slika_resize
						.hashCode());
		result = prime
				+ ((upload_slika_v_height == null) ? 0 : upload_slika_v_height
						.hashCode());
		result = prime
				+ ((upload_slika_v_resize == null) ? 0 : upload_slika_v_resize
						.hashCode());
		result = prime
				+ ((upload_slika_v_width == null) ? 0 : upload_slika_v_width
						.hashCode());
		result = prime
				+ ((upload_slika_width == null) ? 0 : upload_slika_width
						.hashCode());
		result = prime
				+ ((upload_stevilo_polj == null) ? 0 : upload_stevilo_polj
						.hashCode());
		result = prime
				+ ((uporabi_watermark == null) ? 0 : uporabi_watermark
						.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		TemplateUpload other = (TemplateUpload) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (lokacija_watermark == null) {
			if (other.lokacija_watermark != null)
				return false;
		} else if (!lokacija_watermark.equals(other.lokacija_watermark))
			return false;
		if (refresh_po_upload == null) {
			if (other.refresh_po_upload != null)
				return false;
		} else if (!refresh_po_upload.equals(other.refresh_po_upload))
			return false;
		if (templatehead_id == null) {
			if (other.templatehead_id != null)
				return false;
		} else if (!templatehead_id.equals(other.templatehead_id))
			return false;
		if (upload_filter == null) {
			if (other.upload_filter != null)
				return false;
		} else if (!upload_filter.equals(other.upload_filter))
			return false;
		if (upload_slika_height == null) {
			if (other.upload_slika_height != null)
				return false;
		} else if (!upload_slika_height.equals(other.upload_slika_height))
			return false;
		if (upload_slika_resize == null) {
			if (other.upload_slika_resize != null)
				return false;
		} else if (!upload_slika_resize.equals(other.upload_slika_resize))
			return false;
		if (upload_slika_v_height == null) {
			if (other.upload_slika_v_height != null)
				return false;
		} else if (!upload_slika_v_height.equals(other.upload_slika_v_height))
			return false;
		if (upload_slika_v_resize == null) {
			if (other.upload_slika_v_resize != null)
				return false;
		} else if (!upload_slika_v_resize.equals(other.upload_slika_v_resize))
			return false;
		if (upload_slika_v_width == null) {
			if (other.upload_slika_v_width != null)
				return false;
		} else if (!upload_slika_v_width.equals(other.upload_slika_v_width))
			return false;
		if (upload_slika_width == null) {
			if (other.upload_slika_width != null)
				return false;
		} else if (!upload_slika_width.equals(other.upload_slika_width))
			return false;
		if (upload_stevilo_polj == null) {
			if (other.upload_stevilo_polj != null)
				return false;
		} else if (!upload_stevilo_polj.equals(other.upload_stevilo_polj))
			return false;
		if (uporabi_watermark == null) {
			if (other.uporabi_watermark != null)
				return false;
		} else if (!uporabi_watermark.equals(other.uporabi_watermark))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
