
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateConversions;

public interface TemplateConversionsDAO extends DAO {

	public List getTemplateConversionss(final TemplateConversions templateConversions,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateConversions(final TemplateConversions templateConversions,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateConversionss2(final TemplateConversions templateConversions,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateConversionss(final TemplateConversions templateConversions,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateConversionss
     */
    public List getTemplateConversionss(TemplateConversions templateConversions);

    /**
     * Gets templateConversions's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateConversions's id
     * @return templateConversions populated templateConversions object
     */
    public TemplateConversions getTemplateConversions(final Long id);

    /**
     * Saves a templateConversions's information
     * @param templateConversions the object to be saved
     */	
    public void saveTemplateConversions(TemplateConversions templateConversions);

	/**
     * Removes a templateConversions from the database by id
     * @param id the templateConversions's id
     */
    public void removeTemplateConversions(final Long id);
}

