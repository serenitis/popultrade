
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateList;

public interface TemplateListDAO extends DAO {
	 public List getTemplateLists(final TemplateList templateList,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) ;

    /**
     * Retrieves all of the templateLists
     */
    public List getTemplateLists(TemplateList templateList);

    /**
     * Gets templateList's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateList's id
     * @return templateList populated templateList object
     */
    public TemplateList getTemplateList(final Long id);

    /**
     * Saves a templateList's information
     * @param templateList the object to be saved
     */	
    public void saveTemplateList(TemplateList templateList);

	/**
     * Removes a templateList from the database by id
     * @param id the templateList's id
     */
    public void removeTemplateList(final Long id);
}

