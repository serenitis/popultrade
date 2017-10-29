
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateCssDefault;

public interface TemplateCssDefaultDAO extends DAO {

	public List getTemplateCssDefaults(final TemplateCssDefault templateCssDefault,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateCssDefault(final TemplateCssDefault templateCssDefault,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateCssDefaults2(final TemplateCssDefault templateCssDefault,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateCssDefaults(final TemplateCssDefault templateCssDefault,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateCssDefaults
     */
    public List getTemplateCssDefaults(TemplateCssDefault templateCssDefault);

    /**
     * Gets templateCssDefault's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateCssDefault's id
     * @return templateCssDefault populated templateCssDefault object
     */
    public TemplateCssDefault getTemplateCssDefault(final Long id);

    /**
     * Saves a templateCssDefault's information
     * @param templateCssDefault the object to be saved
     */	
    public void saveTemplateCssDefault(TemplateCssDefault templateCssDefault);

	/**
     * Removes a templateCssDefault from the database by id
     * @param id the templateCssDefault's id
     */
    public void removeTemplateCssDefault(final Long id);
}

