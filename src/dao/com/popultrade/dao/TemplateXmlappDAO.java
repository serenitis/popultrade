
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateXmlapp;

public interface TemplateXmlappDAO extends DAO {

	public List getTemplateXmlapps(final TemplateXmlapp templateXmlapp,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateXmlapp(final TemplateXmlapp templateXmlapp,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateXmlapps2(final TemplateXmlapp templateXmlapp,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateXmlapps(final TemplateXmlapp templateXmlapp,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateXmlapps
     */
    public List getTemplateXmlapps(TemplateXmlapp templateXmlapp);

    /**
     * Gets templateXmlapp's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateXmlapp's id
     * @return templateXmlapp populated templateXmlapp object
     */
    public TemplateXmlapp getTemplateXmlapp(final Long id);

    /**
     * Saves a templateXmlapp's information
     * @param templateXmlapp the object to be saved
     */	
    public void saveTemplateXmlapp(TemplateXmlapp templateXmlapp);

	/**
     * Removes a templateXmlapp from the database by id
     * @param id the templateXmlapp's id
     */
    public void removeTemplateXmlapp(final Long id);
}

