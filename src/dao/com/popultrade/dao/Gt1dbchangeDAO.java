
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.Gt1dbchange;

public interface Gt1dbchangeDAO extends DAO {

	public List getGt1dbchanges(final Gt1dbchange gt1dbchange,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStGt1dbchange(final Gt1dbchange gt1dbchange,String dodatni_sql_pogoji);
	public List getGt1dbchanges2(final Gt1dbchange gt1dbchange,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getGt1dbchanges(final Gt1dbchange gt1dbchange,final String orderby,final String orderby_smer);
	
    /**
     * Retrieves all of the gt1dbchanges
     */
    public List getGt1dbchanges(Gt1dbchange gt1dbchange);

    /**
     * Gets gt1dbchange's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the gt1dbchange's id
     * @return gt1dbchange populated gt1dbchange object
     */
    public Gt1dbchange getGt1dbchange(final Long id);

    /**
     * Saves a gt1dbchange's information
     * @param gt1dbchange the object to be saved
     */	
    public void saveGt1dbchange(Gt1dbchange gt1dbchange);

	/**
     * Removes a gt1dbchange from the database by id
     * @param id the gt1dbchange's id
     */
    public void removeGt1dbchange(final Long id);
}

