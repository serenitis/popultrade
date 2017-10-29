
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateClass;


public interface TemplateClassDAO extends DAO {
	
	 public List getTemplateClasss(final TemplateClass templateClassClass_vrednosti,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
		
	public List getTemplateClasss(final TemplateClass templateClass,final int pageNumber,final int pageSize);
	public int getStTemplateClass(final TemplateClass templateClass);
    /**
     * Retrieves all of the templateClasss
     */
	
	public TemplateClass getTemplateClassDodatnos(String idui);
    public List getTemplateClasss(TemplateClass templateClass);

    /**
     * Gets templateClass's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateClass's id
     * @return templateClass populated templateClass object
     */
    public TemplateClass getTemplateClass(final Long id);

    /**
     * Saves a templateClass's information
     * @param templateClass the object to be saved
     */	
    public void saveTemplateClass(TemplateClass templateClass);

	/**
     * Removes a templateClass from the database by id
     * @param id the templateClass's id
     */
    public void removeTemplateClass(final Long id);
}

