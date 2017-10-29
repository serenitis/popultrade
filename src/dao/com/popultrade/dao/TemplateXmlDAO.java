
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateXml;

public interface TemplateXmlDAO extends DAO {

	public List getTemplateXmls(final TemplateXml templateXml,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateXml(final TemplateXml templateXml,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();
	public boolean updateZaporedja(Long temxml_id,String zaporedje);
	public List getTemplateXmls2(final TemplateXml templateXml,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateXmls(final TemplateXml templateXml,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateXmls
     */
    public List getTemplateXmls(TemplateXml templateXml);

    /**
     * Gets templateXml's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateXml's id
     * @return templateXml populated templateXml object
     */
    public TemplateXml getTemplateXml(final Long id);

    /**
     * Saves a templateXml's information
     * @param templateXml the object to be saved
     */	
    public void saveTemplateXml(TemplateXml templateXml);

	/**
     * Removes a templateXml from the database by id
     * @param id the templateXml's id
     */
    public void removeTemplateXml(final Long id);
}

