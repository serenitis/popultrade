
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateClassClass_vrednosti;


public interface TemplateClassClass_vrednostiDAO extends DAO {

	  public List getTemplateClassClass_vrednostis(final TemplateClassClass_vrednosti templateClassClass_vrednosti,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
		  
	public void deleteById(String nad_id,String obstaja);
    /**
     * Retrieves all of the templateClassClass_vrednostis
     */
    public List getTemplateClassClass_vrednostis(TemplateClassClass_vrednosti templateClassClass_vrednosti);

    /**
     * Gets templateClassClass_vrednosti's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateClassClass_vrednosti's id
     * @return templateClassClass_vrednosti populated templateClassClass_vrednosti object
     */
    public TemplateClassClass_vrednosti getTemplateClassClass_vrednosti(final Long id);

    /**
     * Saves a templateClassClass_vrednosti's information
     * @param templateClassClass_vrednosti the object to be saved
     */	
    public void saveTemplateClassClass_vrednosti(TemplateClassClass_vrednosti templateClassClass_vrednosti);

	/**
     * Removes a templateClassClass_vrednosti from the database by id
     * @param id the templateClassClass_vrednosti's id
     */
    public void removeTemplateClassClass_vrednosti(final Long id);
}

