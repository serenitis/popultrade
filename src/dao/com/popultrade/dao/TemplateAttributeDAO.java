
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateAttribute;

public interface TemplateAttributeDAO extends DAO {

	public List getTemplateAttributes(final TemplateAttribute templateAttribute,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateAttribute(final TemplateAttribute templateAttribute,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateAttributes2(final TemplateAttribute templateAttribute,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateAttributes(final TemplateAttribute templateAttribute,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateAttributes
     */
    public List getTemplateAttributes(TemplateAttribute templateAttribute);

    /**
     * Gets templateAttribute's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateAttribute's id
     * @return templateAttribute populated templateAttribute object
     */
    public TemplateAttribute getTemplateAttribute(final Long id);

    /**
     * Saves a templateAttribute's information
     * @param templateAttribute the object to be saved
     */	
    public void saveTemplateAttribute(TemplateAttribute templateAttribute);

	/**
     * Removes a templateAttribute from the database by id
     * @param id the templateAttribute's id
     */
    public void removeTemplateAttribute(final Long id);
}

