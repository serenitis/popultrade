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
@Table (name="uploads")


public class Uploads  extends BaseObject implements Serializable {
	private static final long serialVersionUID = 7152682504439569733L;
	private Long id;
	private Long sifra;
	private String slika1;
	private String slika2;
	private String slika3;
	private String slika4;
	private String slika5;
	private String slika6;
	private String slika7;
	private String slika8;
	private String slika9;
	private String slika10;
	private String slika11;
	private String slika12;
	private String slika13;
	private String slika14;
	private String slika15;
	private String slika16;
	private String slika17;
	private String slika18;
	private String slika19;
	private String slika20;
	private String slika21;
	private String slika22;
	
	
	
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
	
@Index(name="sifra")
@Column(name="sifra")

	public Long getSifra() {
		return sifra;
	}
	public void setSifra(Long sifra) {
		this.sifra = sifra;
	}
	
@Column(name="slika1",length=100)

	public String getSlika1() {
		return slika1;
	}
	public void setSlika1(String slika1) {
		this.slika1 = slika1;
	}
@Column(name="slika2",length=100)

	public String getSlika2() {
		return slika2;
	}
	public void setSlika2(String slika2) {
		this.slika2 = slika2;
	}
@Column(name="slika3",length=100)

	public String getSlika3() {
		return slika3;
	}
	public void setSlika3(String slika3) {
		this.slika3 = slika3;
	}
@Column(name="slika4",length=100)

	public String getSlika4() {
		return slika4;
	}
	public void setSlika4(String slika4) {
		this.slika4 = slika4;
	}
@Column(name="slika5",length=100)

	public String getSlika5() {
		return slika5;
	}
	public void setSlika5(String slika5) {
		this.slika5 = slika5;
	}
@Column(name="slika6",length=100)

	public String getSlika6() {
		return slika6;
	}
	public void setSlika6(String slika6) {
		this.slika6 = slika6;
	}
@Column(name="slika7",length=100)

	public String getSlika7() {
		return slika7;
	}
	public void setSlika7(String slika7) {
		this.slika7 = slika7;
	}
@Column(name="slika8",length=100)

	public String getSlika8() {
		return slika8;
	}
	public void setSlika8(String slika8) {
		this.slika8 = slika8;
	}
@Column(name="slika9",length=100)

	public String getSlika9() {
		return slika9;
	}
	public void setSlika9(String slika9) {
		this.slika9 = slika9;
	}
@Column(name="slika10",length=100)

	public String getSlika10() {
		return slika10;
	}
	public void setSlika10(String slika10) {
		this.slika10 = slika10;
	}
@Column(name="slika11",length=100)

	public String getSlika11() {
		return slika11;
	}
	public void setSlika11(String slika11) {
		this.slika11 = slika11;
	}
@Column(name="slika12",length=100)

	public String getSlika12() {
		return slika12;
	}
	public void setSlika12(String slika12) {
		this.slika12 = slika12;
	}
@Column(name="slika13",length=100)

	public String getSlika13() {
		return slika13;
	}
	public void setSlika13(String slika13) {
		this.slika13 = slika13;
	}
@Column(name="slika14",length=100)

	public String getSlika14() {
		return slika14;
	}
	public void setSlika14(String slika14) {
		this.slika14 = slika14;
	}
@Column(name="slika15",length=100)

	public String getSlika15() {
		return slika15;
	}
	public void setSlika15(String slika15) {
		this.slika15 = slika15;
	}
@Column(name="slika16",length=100)

	public String getSlika16() {
		return slika16;
	}
	public void setSlika16(String slika16) {
		this.slika16 = slika16;
	}
@Column(name="slika17",length=100)

	public String getSlika17() {
		return slika17;
	}
	public void setSlika17(String slika17) {
		this.slika17 = slika17;
	}
@Column(name="slika18",length=100)

	public String getSlika18() {
		return slika18;
	}
	public void setSlika18(String slika18) {
		this.slika18 = slika18;
	}
@Column(name="slika19",length=100)

	public String getSlika19() {
		return slika19;
	}
	public void setSlika19(String slika19) {
		this.slika19 = slika19;
	}
@Column(name="slika20",length=100)

	public String getSlika20() {
		return slika20;
	}
	public void setSlika20(String slika20) {
		this.slika20 = slika20;
	}
@Column(name="slika21",length=100)

	public String getSlika21() {
		return slika21;
	}
	public void setSlika21(String slika21) {
		this.slika21 = slika21;
	}
@Column(name="slika22",length=100)

	public String getSlika22() {
		return slika22;
	}
	public void setSlika22(String slika22) {
		this.slika22 = slika22;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((sifra == null) ? 0 : sifra.hashCode());
		result = prime * result + ((slika1 == null) ? 0 : slika1.hashCode());
		result = prime * result + ((slika10 == null) ? 0 : slika10.hashCode());
		result = prime * result + ((slika11 == null) ? 0 : slika11.hashCode());
		result = prime * result + ((slika12 == null) ? 0 : slika12.hashCode());
		result = prime * result + ((slika13 == null) ? 0 : slika13.hashCode());
		result = prime * result + ((slika14 == null) ? 0 : slika14.hashCode());
		result = prime * result + ((slika15 == null) ? 0 : slika15.hashCode());
		result = prime * result + ((slika16 == null) ? 0 : slika16.hashCode());
		result = prime * result + ((slika17 == null) ? 0 : slika17.hashCode());
		result = prime * result + ((slika18 == null) ? 0 : slika18.hashCode());
		result = prime * result + ((slika19 == null) ? 0 : slika19.hashCode());
		result = prime * result + ((slika2 == null) ? 0 : slika2.hashCode());
		result = prime * result + ((slika20 == null) ? 0 : slika20.hashCode());
		result = prime * result + ((slika21 == null) ? 0 : slika21.hashCode());
		result = prime * result + ((slika22 == null) ? 0 : slika22.hashCode());
		result = prime * result + ((slika3 == null) ? 0 : slika3.hashCode());
		result = prime * result + ((slika4 == null) ? 0 : slika4.hashCode());
		result = prime * result + ((slika5 == null) ? 0 : slika5.hashCode());
		result = prime * result + ((slika6 == null) ? 0 : slika6.hashCode());
		result = prime * result + ((slika7 == null) ? 0 : slika7.hashCode());
		result = prime * result + ((slika8 == null) ? 0 : slika8.hashCode());
		result = prime * result + ((slika9 == null) ? 0 : slika9.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		final Uploads other = (Uploads) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (sifra == null) {
			if (other.sifra != null)
				return false;
		} else if (!sifra.equals(other.sifra))
			return false;
		if (slika1 == null) {
			if (other.slika1 != null)
				return false;
		} else if (!slika1.equals(other.slika1))
			return false;
		if (slika10 == null) {
			if (other.slika10 != null)
				return false;
		} else if (!slika10.equals(other.slika10))
			return false;
		if (slika11 == null) {
			if (other.slika11 != null)
				return false;
		} else if (!slika11.equals(other.slika11))
			return false;
		if (slika12 == null) {
			if (other.slika12 != null)
				return false;
		} else if (!slika12.equals(other.slika12))
			return false;
		if (slika13 == null) {
			if (other.slika13 != null)
				return false;
		} else if (!slika13.equals(other.slika13))
			return false;
		if (slika14 == null) {
			if (other.slika14 != null)
				return false;
		} else if (!slika14.equals(other.slika14))
			return false;
		if (slika15 == null) {
			if (other.slika15 != null)
				return false;
		} else if (!slika15.equals(other.slika15))
			return false;
		if (slika16 == null) {
			if (other.slika16 != null)
				return false;
		} else if (!slika16.equals(other.slika16))
			return false;
		if (slika17 == null) {
			if (other.slika17 != null)
				return false;
		} else if (!slika17.equals(other.slika17))
			return false;
		if (slika18 == null) {
			if (other.slika18 != null)
				return false;
		} else if (!slika18.equals(other.slika18))
			return false;
		if (slika19 == null) {
			if (other.slika19 != null)
				return false;
		} else if (!slika19.equals(other.slika19))
			return false;
		if (slika2 == null) {
			if (other.slika2 != null)
				return false;
		} else if (!slika2.equals(other.slika2))
			return false;
		if (slika20 == null) {
			if (other.slika20 != null)
				return false;
		} else if (!slika20.equals(other.slika20))
			return false;
		if (slika21 == null) {
			if (other.slika21 != null)
				return false;
		} else if (!slika21.equals(other.slika21))
			return false;
		if (slika22 == null) {
			if (other.slika22 != null)
				return false;
		} else if (!slika22.equals(other.slika22))
			return false;
		if (slika3 == null) {
			if (other.slika3 != null)
				return false;
		} else if (!slika3.equals(other.slika3))
			return false;
		if (slika4 == null) {
			if (other.slika4 != null)
				return false;
		} else if (!slika4.equals(other.slika4))
			return false;
		if (slika5 == null) {
			if (other.slika5 != null)
				return false;
		} else if (!slika5.equals(other.slika5))
			return false;
		if (slika6 == null) {
			if (other.slika6 != null)
				return false;
		} else if (!slika6.equals(other.slika6))
			return false;
		if (slika7 == null) {
			if (other.slika7 != null)
				return false;
		} else if (!slika7.equals(other.slika7))
			return false;
		if (slika8 == null) {
			if (other.slika8 != null)
				return false;
		} else if (!slika8.equals(other.slika8))
			return false;
		if (slika9 == null) {
			if (other.slika9 != null)
				return false;
		} else if (!slika9.equals(other.slika9))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	public String getSliko(int slika) {
		
		if (slika==1) {
			return this.getSlika1();
		}
		if (slika==2) {
			return this.getSlika2();
		}
		if (slika==3) {
			return this.getSlika3();
		}
		if (slika==4) {
			return this.getSlika4();
		}
		if (slika==5) {
			return this.getSlika5();
		}
		if (slika==6) {
			return this.getSlika6();
		}
		if (slika==7) {
			return this.getSlika7();
		}
		if (slika==8) {
			return this.getSlika8();
		}
		if (slika==9) {
			return this.getSlika9();
		}
		if (slika==10) {
			return this.getSlika10();
		}
		if (slika==11) {
			return this.getSlika11();
		}
		if (slika==12) {
			return this.getSlika12();
		}
		if (slika==13) {
			return this.getSlika13();
		}
		if (slika==14) {
			return this.getSlika14();
		}
		if (slika==15) {
			return this.getSlika15();
		}
		if (slika==16) {
			return this.getSlika16();
		}
		if (slika==17) {
			return this.getSlika17();
		}
		if (slika==18) {
			return this.getSlika18();
		}
		if (slika==19) {
			return this.getSlika19();
		}
		if (slika==20) {
			return this.getSlika20();
		}
		if (slika==21) {
			return this.getSlika21();
		}
		if (slika==22) {
			return this.getSlika22();
		}
		
		return null;
	}
	
	
	
	
	
	
	
	
	
}

