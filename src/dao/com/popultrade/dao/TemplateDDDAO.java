
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateDD;

public interface TemplateDDDAO extends DAO {
	
	
	 public List getTemplateDDs(final TemplateDD templateDD,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
			
	public TemplateDD getTemplateDDs(String idui);
	public TemplateDD getTemplateDDKontrolas(String idui,String kontrola);
    /**
     * Retrieves all of the templateDDs
     */
    public List getTemplateDDs(TemplateDD templateDD);

    /**
     * Gets templateDD's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateDD's id
     * @return templateDD populated templateDD object
     */
    public TemplateDD getTemplateDD(final Long id);

    /**
     * Saves a templateDD's information
     * @param templateDD the object to be saved
     */	
    public void saveTemplateDD(TemplateDD templateDD);

	/**
     * Removes a templateDD from the database by id
     * @param id the templateDD's id
     */
    public void removeTemplateDD(final Long id);
}

