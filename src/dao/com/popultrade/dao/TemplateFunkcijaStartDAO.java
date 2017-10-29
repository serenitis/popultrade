
package com.popultrade.dao;

import java.util.List;


import com.popultrade.model.TemplateFunkcijaStart;

public interface TemplateFunkcijaStartDAO extends DAO {
	public int getStTemplateFunkcijaStart(final TemplateFunkcijaStart tf);
	public List getTemplateFunkcijaStarts(final TemplateFunkcijaStart tf,final int pageNumber,final int pageSize);
	
	 public List getTemplateFunkcijaStarts(final TemplateFunkcijaStart templateFunkcijaStart,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);

	public List getTemplateFunkcijaStartByVezaId(String veza_id);
	
    /**
     * Retrieves all of the templateFunkcijaStarts
     */
    public List getTemplateFunkcijaStarts(TemplateFunkcijaStart templateFunkcijaStart);

    /**
     * Gets templateFunkcijaStart's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateFunkcijaStart's id
     * @return templateFunkcijaStart populated templateFunkcijaStart object
     */
    public TemplateFunkcijaStart getTemplateFunkcijaStart(final Long id);

    /**
     * Saves a templateFunkcijaStart's information
     * @param templateFunkcijaStart the object to be saved
     */	
    public void saveTemplateFunkcijaStart(TemplateFunkcijaStart templateFunkcijaStart);

	/**
     * Removes a templateFunkcijaStart from the database by id
     * @param id the templateFunkcijaStart's id
     */
    public void removeTemplateFunkcijaStart(final Long id);
}

