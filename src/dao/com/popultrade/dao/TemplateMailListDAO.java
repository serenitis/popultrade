
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateMailList;

public interface TemplateMailListDAO extends DAO {

	public List getTemplateMailLists(final TemplateMailList templateMailList,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateMailList(final TemplateMailList templateMailList,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();
	public TemplateMailList getTemplateMailListByVezaId(final Long id);
	public List getTemplateMailLists2(final TemplateMailList templateMailList,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateMailLists(final TemplateMailList templateMailList,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateMailLists
     */
    public List getTemplateMailLists(TemplateMailList templateMailList);

    /**
     * Gets templateMailList's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateMailList's id
     * @return templateMailList populated templateMailList object
     */
    public TemplateMailList getTemplateMailList(final Long id);

    /**
     * Saves a templateMailList's information
     * @param templateMailList the object to be saved
     */	
    public void saveTemplateMailList(TemplateMailList templateMailList);

	/**
     * Removes a templateMailList from the database by id
     * @param id the templateMailList's id
     */
    public void removeTemplateMailList(final Long id);
}

