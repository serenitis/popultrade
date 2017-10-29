
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.Obvestila;

public interface ObvestilaDAO extends DAO {

	public int getStObvestilap(final Obvestila obvestila);
	public List getObvestilasp(final Obvestila obvestila,final int pageNumber,final int pageSize);
  
	public int getStObvestila(final Obvestila obvestila,String dodatni_sql_pogoji);
	 public List getObvestilas(final Obvestila obvestila,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) ;
	public int getStObvestila(final Obvestila obvestila);
	public List getObvestilas(final Obvestila obvestila,final int pageNumber,final int pageSize);
    /**
     * Retrieves all of the obvestilas
     */
    public List getObvestilas(Obvestila obvestila);

    /**
     * Gets obvestila's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the obvestila's id
     * @return obvestila populated obvestila object
     */
    public Obvestila getObvestila(final Long id);

    /**
     * Saves a obvestila's information
     * @param obvestila the object to be saved
     */	
    public void saveObvestila(Obvestila obvestila);

	/**
     * Removes a obvestila from the database by id
     * @param id the obvestila's id
     */
    public void removeObvestila(final Long id);
}

