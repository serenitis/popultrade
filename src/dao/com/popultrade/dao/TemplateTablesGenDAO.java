
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateTablesGen;

public interface TemplateTablesGenDAO extends DAO {

	public List getTemplateTablesGens(final TemplateTablesGen templateTablesGen,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateTablesGen(final TemplateTablesGen templateTablesGen,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateTablesGens2(final TemplateTablesGen templateTablesGen,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateTablesGens(final TemplateTablesGen templateTablesGen,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateTablesGens
     */
    public List getTemplateTablesGens(TemplateTablesGen templateTablesGen);

    /**
     * Gets templateTablesGen's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateTablesGen's id
     * @return templateTablesGen populated templateTablesGen object
     */
    public TemplateTablesGen getTemplateTablesGen(final Long id);

    /**
     * Saves a templateTablesGen's information
     * @param templateTablesGen the object to be saved
     */	
    public void saveTemplateTablesGen(TemplateTablesGen templateTablesGen);

	/**
     * Removes a templateTablesGen from the database by id
     * @param id the templateTablesGen's id
     */
    public void removeTemplateTablesGen(final Long id);
}

