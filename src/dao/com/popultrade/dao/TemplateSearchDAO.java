
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateSearch;

public interface TemplateSearchDAO extends DAO {

	public List getTemplateSearchs(final TemplateSearch templateSearch,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateSearch(final TemplateSearch templateSearch,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateSearchs2(final TemplateSearch templateSearch,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateSearchs(final TemplateSearch templateSearch,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateSearchs
     */
    public List getTemplateSearchs(TemplateSearch templateSearch);

    /**
     * Gets templateSearch's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateSearch's id
     * @return templateSearch populated templateSearch object
     */
    public TemplateSearch getTemplateSearch(final Long id);

    /**
     * Saves a templateSearch's information
     * @param templateSearch the object to be saved
     */	
    public void saveTemplateSearch(TemplateSearch templateSearch);

	/**
     * Removes a templateSearch from the database by id
     * @param id the templateSearch's id
     */
    public void removeTemplateSearch(final Long id);
}

