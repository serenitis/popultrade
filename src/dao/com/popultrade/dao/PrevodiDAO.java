
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.Prevodi;

public interface PrevodiDAO extends DAO {
	public Prevodi getPrevodiCopy(final Prevodi prevodi);
	public List getPrevodisHint(final Prevodi prevodi);
	public List getPrevodis();
	public List getPrevodisByVrsta(String sif_jez,String vrsta);
	public List getPrevodisDodatno(final Prevodi prevodi);
	public List getPrevodisByJezik(String sif_jez);
	public String getPrevodEn(String sif_jez,String vrsta,String prevodid);
	public String getPrevodEnId(String prevodid);
    /**
     * Retrieves all of the prevodis
     */ 
    public List getPrevodis(Prevodi prevodi);

    /**
     * Gets prevodi's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the prevodi's id
     * @return prevodi populated prevodi object
     */
    public Prevodi getPrevodi(final Long id);

    /**
     * Saves a prevodi's information
     * @param prevodi the object to be saved
     */	
    public void savePrevodi(Prevodi prevodi);

	/**
     * Removes a prevodi from the database by id
     * @param id the prevodi's id
     */
    public void removePrevodi(final Long id);
}

