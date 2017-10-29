
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateConversion;

public interface TemplateConversionDAO extends DAO {

	public List getTemplateConversions(final TemplateConversion templateConversion,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateConversion(final TemplateConversion templateConversion,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateConversions2(final TemplateConversion templateConversion,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateConversions(final TemplateConversion templateConversion,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateConversions
     */
    public List getTemplateConversions(TemplateConversion templateConversion);

    /**
     * Gets templateConversion's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateConversion's id
     * @return templateConversion populated templateConversion object
     */
    public TemplateConversion getTemplateConversion(final Long id);

    /**
     * Saves a templateConversion's information
     * @param templateConversion the object to be saved
     */	
    public void saveTemplateConversion(TemplateConversion templateConversion);

	/**
     * Removes a templateConversion from the database by id
     * @param id the templateConversion's id
     */
    public void removeTemplateConversion(final Long id);
}

