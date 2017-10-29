
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateTablesCol;

public interface TemplateTablesColDAO extends DAO {

	public List getTemplateTablesCols(final TemplateTablesCol templateTablesCol,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateTablesCol(final TemplateTablesCol templateTablesCol,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateTablesCols2(final TemplateTablesCol templateTablesCol,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateTablesCols(final TemplateTablesCol templateTablesCol,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateTablesCols
     */
    public List getTemplateTablesCols(TemplateTablesCol templateTablesCol);

    /**
     * Gets templateTablesCol's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateTablesCol's id
     * @return templateTablesCol populated templateTablesCol object
     */
    public TemplateTablesCol getTemplateTablesCol(final Long id);

    /**
     * Saves a templateTablesCol's information
     * @param templateTablesCol the object to be saved
     */	
    public void saveTemplateTablesCol(TemplateTablesCol templateTablesCol);

	/**
     * Removes a templateTablesCol from the database by id
     * @param id the templateTablesCol's id
     */
    public void removeTemplateTablesCol(final Long id);
}

