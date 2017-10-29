package com.popultrade.webapp;


public class OpisiPodjetij {

	
	private String naziv;
	private String naslov;
	private String ean;
	private String tip;
	private String posta;
	private String kraj;
	private String dza_sifra;
	private String ddv="";
	private String maticna="";
	public OpisiPodjetij(String naziv,String naslov,String ean,String tip,String posta,String kraj,String dza_sifra) {
		this.naziv=naziv;
		this.naslov = naslov;
		this.ean = ean;
		this.tip = tip;
		this.posta=posta;
		this.kraj=kraj;
		this.dza_sifra=dza_sifra;
	}
	
	public OpisiPodjetij(String naziv,String naslov,String ean,String tip,String posta,String kraj,String dza_sifra,String ddv,String maticna) {
		this.naziv=naziv;
		this.naslov = naslov;
		this.ean = ean;
		this.tip = tip;
		this.posta=posta;
		this.kraj=kraj;
		this.dza_sifra=dza_sifra;
		this.ddv=ddv;
		this.maticna=maticna;
	}
	public String getDza_sifra() {
		return dza_sifra;
	}
	public void setDza_sifra(String dza_sifra) {
		this.dza_sifra = dza_sifra;
	}
	public String getEan() {
		return ean;
	}
	public void setEan(String ean) {
		this.ean = ean;
	}
	public String getKraj() {
		return kraj;
	}
	public void setKraj(String kraj) {
		this.kraj = kraj;
	}
	public String getNaslov() {
		return naslov;
	}
	public void setNaslov(String naslov) {
		this.naslov = naslov;
	}
	public String getNaziv() {
		return naziv;
	}
	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}
	public String getPosta() {
		return posta;
	}
	public void setPosta(String posta) {
		this.posta = posta;
	}
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	public String getDdv() {
		return ddv;
	}
	public void setDdv(String ddv) {
		this.ddv = ddv;
	}
	public String getMaticna() {
		return maticna;
	}
	public void setMaticna(String maticna) {
		this.maticna = maticna;
	}
	
	
}
