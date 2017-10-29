
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.Codes;

public interface CodesDAO extends DAO {

	public List getCodess(final Codes codes,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStCodes(final Codes codes,String dodatni_sql_pogoji);
	public List getCodess2(final Codes codes,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getCodess(final Codes codes,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the codess
     */
    public List getCodess(Codes codes);

    /**
     * Gets codes's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the codes's id
     * @return codes populated codes object
     */
    public Codes getCodes(final Long id);

    /**
     * Saves a codes's information
     * @param codes the object to be saved
     */	
    public void saveCodes(Codes codes);

	/**
     * Removes a codes from the database by id
     * @param id the codes's id
     */
    public void removeCodes(final Long id);
}

