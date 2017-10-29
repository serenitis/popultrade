
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.Jeziki;

public interface JezikiDAO extends DAO {

    /**
     * Retrieves all of the jezikis
     */
    public List getJezikis(Jeziki jeziki);

    /**
     * Gets jeziki's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param SIFRA_JEZ the jeziki's SIFRA_JEZ
     * @return jeziki populated jeziki object
     */
    public Jeziki getJeziki(final String SIFRA_JEZ);

    /**
     * Saves a jeziki's information
     * @param jeziki the object to be saved
     */	
    public void saveJeziki(Jeziki jeziki);

	/**
     * Removes a jeziki from the database by SIFRA_JEZ
     * @param SIFRA_JEZ the jeziki's SIFRA_JEZ
     */
    public void removeJeziki(final String SIFRA_JEZ);
}

