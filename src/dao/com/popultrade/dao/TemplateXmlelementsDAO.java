
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateXmlelements;

public interface TemplateXmlelementsDAO extends DAO {

	public List getTemplateXmlelementss(final TemplateXmlelements templateXmlelements,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateXmlelements(final TemplateXmlelements templateXmlelements,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateXmlelementss2(final TemplateXmlelements templateXmlelements,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateXmlelementss(final TemplateXmlelements templateXmlelements,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateXmlelementss
     */
    public List getTemplateXmlelementss(TemplateXmlelements templateXmlelements);

    /**
     * Gets templateXmlelements's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateXmlelements's id
     * @return templateXmlelements populated templateXmlelements object
     */
    public TemplateXmlelements getTemplateXmlelements(final Long id);

    /**
     * Saves a templateXmlelements's information
     * @param templateXmlelements the object to be saved
     */	
    public void saveTemplateXmlelements(TemplateXmlelements templateXmlelements);

	/**
     * Removes a templateXmlelements from the database by id
     * @param id the templateXmlelements's id
     */
    public void removeTemplateXmlelements(final Long id);
}

