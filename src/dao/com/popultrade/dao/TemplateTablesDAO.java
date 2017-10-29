
package com.popultrade.dao;

import java.util.Hashtable;
import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateTables;

public interface TemplateTablesDAO extends DAO {

	
	
	public Hashtable getTableStructure(String tablename);
		
	public List getTemplateTabless(final TemplateTables templateTables,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateTables(final TemplateTables templateTables,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateTabless2(final TemplateTables templateTables,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateTabless(final TemplateTables templateTables,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateTabless
     */
    public List getTemplateTabless(TemplateTables templateTables);

    /**
     * Gets templateTables's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateTables's id
     * @return templateTables populated templateTables object
     */
    public TemplateTables getTemplateTables(final Long id);

    /**
     * Saves a templateTables's information
     * @param templateTables the object to be saved
     */	
    public void saveTemplateTables(TemplateTables templateTables);

	/**
     * Removes a templateTables from the database by id
     * @param id the templateTables's id
     */
    public void removeTemplateTables(final Long id);
}

