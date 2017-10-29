
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateGumbi;

public interface TemplateGumbiDAO extends DAO {
	 public List getTemplateGumbis(final TemplateGumbi templateGumbi,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
			
    /**
     * Retrieves all of the templateGumbis
     */
    public List getTemplateGumbis(TemplateGumbi templateGumbi);

    /**
     * Gets templateGumbi's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateGumbi's id
     * @return templateGumbi populated templateGumbi object
     */
    public TemplateGumbi getTemplateGumbi(final Long id);

    /**
     * Saves a templateGumbi's information
     * @param templateGumbi the object to be saved
     */	
    public void saveTemplateGumbi(TemplateGumbi templateGumbi);

	/**
     * Removes a templateGumbi from the database by id
     * @param id the templateGumbi's id
     */
    public void removeTemplateGumbi(final Long id);
}

