
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.Pgnclientsschedule;

public interface PgnclientsscheduleDAO extends DAO {

	public List getPgnclientsschedules(final Pgnclientsschedule pgnclientsschedule,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStPgnclientsschedule(final Pgnclientsschedule pgnclientsschedule,String dodatni_sql_pogoji);
	public List getPgnclientsschedules2(final Pgnclientsschedule pgnclientsschedule,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getPgnclientsschedules(final Pgnclientsschedule pgnclientsschedule,final String orderby,final String orderby_smer);
	public Session getSessionProcedura();

    /**
     * Retrieves all of the pgnclientsschedules
     */
    public List getPgnclientsschedules(Pgnclientsschedule pgnclientsschedule);

    /**
     * Gets pgnclientsschedule's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the pgnclientsschedule's id
     * @return pgnclientsschedule populated pgnclientsschedule object
     */
    public Pgnclientsschedule getPgnclientsschedule(final Long id);

    /**
     * Saves a pgnclientsschedule's information
     * @param pgnclientsschedule the object to be saved
     */	
    public void savePgnclientsschedule(Pgnclientsschedule pgnclientsschedule);

	/**
     * Removes a pgnclientsschedule from the database by id
     * @param id the pgnclientsschedule's id
     */
    public void removePgnclientsschedule(final Long id);
}

