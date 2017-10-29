
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplatePages;

public interface TemplatePagesDAO extends DAO {

	public List getTemplatePagess(final TemplatePages templatePages,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplatePages(final TemplatePages templatePages,String dodatni_sql_pogoji);
	public List getTemplatePagess2(final TemplatePages templatePages,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplatePagess(final TemplatePages templatePages,final String orderby,final String orderby_smer);
	
    /**
     * Retrieves all of the templatePagess
     */
    public List getTemplatePagess(TemplatePages templatePages);

    /**
     * Gets templatePages's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templatePages's id
     * @return templatePages populated templatePages object
     */
    public TemplatePages getTemplatePages(final Long id);

    /**
     * Saves a templatePages's information
     * @param templatePages the object to be saved
     */	
    public void saveTemplatePages(TemplatePages templatePages);

	/**
     * Removes a templatePages from the database by id
     * @param id the templatePages's id
     */
    public void removeTemplatePages(final Long id);
}

