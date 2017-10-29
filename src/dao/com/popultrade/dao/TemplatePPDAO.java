
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplatePP;


public interface TemplatePPDAO extends DAO {
	 public List getTemplatePPs(final TemplatePP templatePp,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);

    /**
     * Retrieves all of the templatePPs
     */
    public List getTemplatePPs(TemplatePP templatePP);

    /**
     * Gets templatePP's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templatePP's id
     * @return templatePP populated templatePP object
     */
    public TemplatePP getTemplatePP(final Long id);

    /**
     * Saves a templatePP's information
     * @param templatePP the object to be saved
     */	
    public void saveTemplatePP(TemplatePP templatePP);

	/**
     * Removes a templatePP from the database by id
     * @param id the templatePP's id
     */
    public void removeTemplatePP(final Long id);
}

