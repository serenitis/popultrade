package com.popultrade.model;
import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import java.util.List;

@Entity
@Table (name="wse_sporocila")

public class Wse_sporocila extends BaseObject implements Serializable {


private static final long serialVersionUID = 556148964892548927L;
private String test;
private String stev_izmenj;
private String status_frs;
private String smer;
private String potrditev;
private String pje_sifra_prejemnik;
private String pje_sifra;
private String opomba;
private String operspre;
private String operkre;
private Long lad_id;
private Long id;
private String dek_vda_sifra;
private String dek_pje_sifra;
private Date datum;
private Date datspre;
private Date datkre;


@Column(name="test",length=1)
public String getTest() {
return test;
}
public void setTest(String test) {
this.test = test;
}


@Column(name="stev_izmenj",length=14)
public String getStev_izmenj() {
return stev_izmenj;
}
public void setStev_izmenj(String stev_izmenj) {
this.stev_izmenj = stev_izmenj;
}


@Column(name="status_frs",length=1)
public String getStatus_frs() {
return status_frs;
}
public void setStatus_frs(String status_frs) {
this.status_frs = status_frs;
}


@Column(name="smer",length=1)
public String getSmer() {
return smer;
}
public void setSmer(String smer) {
this.smer = smer;
}


@Column(name="potrditev",length=1)
public String getPotrditev() {
return potrditev;
}
public void setPotrditev(String potrditev) {
this.potrditev = potrditev;
}


@Column(name="pje_sifra_prejemnik",length=35)
public String getPje_sifra_prejemnik() {
return pje_sifra_prejemnik;
}
public void setPje_sifra_prejemnik(String pje_sifra_prejemnik) {
this.pje_sifra_prejemnik = pje_sifra_prejemnik;
}


@Column(name="pje_sifra",length=35)
public String getPje_sifra() {
return pje_sifra;
}
public void setPje_sifra(String pje_sifra) {
this.pje_sifra = pje_sifra;
}


@Column(name="opomba",length=70)
public String getOpomba() {
return opomba;
}
public void setOpomba(String opomba) {
this.opomba = opomba;
}


@Column(name="operspre",length=30)
public String getOperspre() {
return operspre;
}
public void setOperspre(String operspre) {
this.operspre = operspre;
}


@Column(name="operkre",length=30)
public String getOperkre() {
return operkre;
}
public void setOperkre(String operkre) {
this.operkre = operkre;
}


@Column(name="lad_id",length=9)
public Long getLad_id() {
return lad_id;
}
public void setLad_id(Long lad_id) {
this.lad_id = lad_id;
}


@Id
@Column(name="id")
@SequenceGenerator(name="wse_stevilke_seq", sequenceName="wse_stevilke_seq",allocationSize=1)
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="wse_stevilke_seq")
public Long getId() {
return id;
}
public void setId(Long id) {
this.id = id;
}


@Column(name="dek_vda_sifra",length=6)
public String getDek_vda_sifra() {
return dek_vda_sifra;
}
public void setDek_vda_sifra(String dek_vda_sifra) {
this.dek_vda_sifra = dek_vda_sifra;
}


@Column(name="dek_pje_sifra",length=35)
public String getDek_pje_sifra() {
return dek_pje_sifra;
}
public void setDek_pje_sifra(String dek_pje_sifra) {
this.dek_pje_sifra = dek_pje_sifra;
}


@Column(name="datum")
public Date getDatum() {
return datum;
}
public void setDatum(Date datum) {
this.datum = datum;
}


@Column(name="datspre")
public Date getDatspre() {
return datspre;
}
public void setDatspre(Date datspre) {
this.datspre = datspre;
}


@Column(name="datkre")
public Date getDatkre() {
return datkre;
}
public void setDatkre(Date datkre) {
this.datkre = datkre;
}


public int hashCode() {
final int prime = 31;
int result = 1;
result = prime * result + ((test == null) ? 0 : test.hashCode());
result = prime * result + ((stev_izmenj == null) ? 0 : stev_izmenj.hashCode());
result = prime * result + ((status_frs == null) ? 0 : status_frs.hashCode());
result = prime * result + ((smer == null) ? 0 : smer.hashCode());
result = prime * result + ((potrditev == null) ? 0 : potrditev.hashCode());
result = prime * result + ((pje_sifra_prejemnik == null) ? 0 : pje_sifra_prejemnik.hashCode());
result = prime * result + ((pje_sifra == null) ? 0 : pje_sifra.hashCode());
result = prime * result + ((opomba == null) ? 0 : opomba.hashCode());
result = prime * result + ((operspre == null) ? 0 : operspre.hashCode());
result = prime * result + ((operkre == null) ? 0 : operkre.hashCode());
result = prime * result + ((id == null) ? 0 : id.hashCode());
result = prime * result + ((dek_vda_sifra == null) ? 0 : dek_vda_sifra.hashCode());
result = prime * result + ((dek_pje_sifra == null) ? 0 : dek_pje_sifra.hashCode());
return result;
}


public boolean equals(Object obj) {
if (this == obj)
return true;
if (getClass() != obj.getClass())
return false;
Wse_sporocila other = (Wse_sporocila) obj;
if (test == null) {
if (other.test != null)
return false;
} else if (!test.equals(other.test))
return false;
if (stev_izmenj == null) {
if (other.stev_izmenj != null)
return false;
} else if (!stev_izmenj.equals(other.stev_izmenj))
return false;
if (status_frs == null) {
if (other.status_frs != null)
return false;
} else if (!status_frs.equals(other.status_frs))
return false;
if (smer == null) {
if (other.smer != null)
return false;
} else if (!smer.equals(other.smer))
return false;
if (potrditev == null) {
if (other.potrditev != null)
return false;
} else if (!potrditev.equals(other.potrditev))
return false;
if (pje_sifra_prejemnik == null) {
if (other.pje_sifra_prejemnik != null)
return false;
} else if (!pje_sifra_prejemnik.equals(other.pje_sifra_prejemnik))
return false;
if (pje_sifra == null) {
if (other.pje_sifra != null)
return false;
} else if (!pje_sifra.equals(other.pje_sifra))
return false;
if (opomba == null) {
if (other.opomba != null)
return false;
} else if (!opomba.equals(other.opomba))
return false;
if (operspre == null) {
if (other.operspre != null)
return false;
} else if (!operspre.equals(other.operspre))
return false;
if (operkre == null) {
if (other.operkre != null)
return false;
} else if (!operkre.equals(other.operkre))
return false;
if (id == null) {
if (other.id != null)
return false;
} else if (!id.equals(other.id))
return false;
if (dek_vda_sifra == null) {
if (other.dek_vda_sifra != null)
return false;
} else if (!dek_vda_sifra.equals(other.dek_vda_sifra))
return false;
if (dek_pje_sifra == null) {
if (other.dek_pje_sifra != null)
return false;
} else if (!dek_pje_sifra.equals(other.dek_pje_sifra))
return false;

return true;
}


public String toString() {
return null;
}


}
