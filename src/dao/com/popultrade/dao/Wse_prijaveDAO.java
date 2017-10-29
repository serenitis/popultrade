
package com.popultrade.dao;

import java.sql.Connection;
import java.util.List;

import com.popultrade.model.Wse_prijave;


public interface Wse_prijaveDAO extends DAO {

	public List getWse_prijaves(final Wse_prijave wse_prijave,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStWse_prijave(final Wse_prijave wse_prijave,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getWse_prijaves2(final Wse_prijave wse_prijave,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getWse_prijaves(final Wse_prijave wse_prijave,final String orderby,final String orderby_smer);
	
	
	public int getStWse_prijave(final Wse_prijave wse_prijave);
	 public List getWse_prijaves(final Wse_prijave wse_prijave,final int pageNumber,final int pageSize);
    /**
     * Retrieves all of the wse_prijaves
     */
    public List getWse_prijaves(Wse_prijave wse_prijave);

    /**
     * Gets wse_prijave's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the wse_prijave's id
     * @return wse_prijave populated wse_prijave object
     */
    public Wse_prijave getWse_prijave(final Long id);

    /**
     * Saves a wse_prijave's information
     * @param wse_prijave the object to be saved
     */	
    public void saveWse_prijave(Wse_prijave wse_prijave);

	/**
     * Removes a wse_prijave from the database by id
     * @param id the wse_prijave's id
     */
    public void removeWse_prijave(final Long id);
}

