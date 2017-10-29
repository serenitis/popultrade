
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateClassClass;


public interface TemplateClassClassDAO extends DAO {
	
	 public List getTemplateClassClasss(final TemplateClassClass templateClassClass_vrednosti,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
		
    /**
     * Retrieves all of the templateClassClasss
     */
    public List getTemplateClassClasss(TemplateClassClass templateClassClass);

    /**
     * Gets templateClassClass's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateClassClass's id
     * @return templateClassClass populated templateClassClass object
     */
    public TemplateClassClass getTemplateClassClass(final Long id);

    /**
     * Saves a templateClassClass's information
     * @param templateClassClass the object to be saved
     */	
    public void saveTemplateClassClass(TemplateClassClass templateClassClass);

	/**
     * Removes a templateClassClass from the database by id
     * @param id the templateClassClass's id
     */
    public void removeTemplateClassClass(final Long id);
}

