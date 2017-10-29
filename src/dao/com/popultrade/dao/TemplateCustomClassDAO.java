
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateCustomClass;

public interface TemplateCustomClassDAO extends DAO {

	public List getTemplateCustomClasss(final TemplateCustomClass templateCustomClass,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateCustomClass(final TemplateCustomClass templateCustomClass,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();
	public TemplateCustomClass getTemplateCustomClass(String thid);
	public List getTemplateCustomClasss2(final TemplateCustomClass templateCustomClass,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateCustomClasss(final TemplateCustomClass templateCustomClass,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateCustomClasss
     */
    public List getTemplateCustomClasss(TemplateCustomClass templateCustomClass);

    /**
     * Gets templateCustomClass's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateCustomClass's id
     * @return templateCustomClass populated templateCustomClass object
     */
    public TemplateCustomClass getTemplateCustomClass(final Long id);

    /**
     * Saves a templateCustomClass's information
     * @param templateCustomClass the object to be saved
     */	
    public void saveTemplateCustomClass(TemplateCustomClass templateCustomClass);

	/**
     * Removes a templateCustomClass from the database by id
     * @param id the templateCustomClass's id
     */
    public void removeTemplateCustomClass(final Long id);
}

