
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.Stevci;

public interface StevciDAO extends DAO {
	public List getStevcis(final Stevci stevci,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) ;
    /**
     * Retrieves all of the stevcis
     */
    public List getStevcis(Stevci stevci);

    /**
     * Gets stevci's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the stevci's id
     * @return stevci populated stevci object
     */
    public Stevci getStevci(final Long id);

    /**
     * Saves a stevci's information
     * @param stevci the object to be saved
     */	
    public void saveStevci(Stevci stevci);

	/**
     * Removes a stevci from the database by id
     * @param id the stevci's id
     */
    public void removeStevci(final Long id);
}

