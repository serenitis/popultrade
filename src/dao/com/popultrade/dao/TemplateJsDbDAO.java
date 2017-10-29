
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateJsDb;

public interface TemplateJsDbDAO extends DAO {

	
	  public void deleteAll();
	
	
	public List getTemplateJsDbs(final TemplateJsDb templateJsDb,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateJsDb(final TemplateJsDb templateJsDb,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateJsDbs2(final TemplateJsDb templateJsDb,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateJsDbs(final TemplateJsDb templateJsDb,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateJsDbs
     */
    public List getTemplateJsDbs(TemplateJsDb templateJsDb);

    /**
     * Gets templateJsDb's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateJsDb's id
     * @return templateJsDb populated templateJsDb object
     */
    public TemplateJsDb getTemplateJsDb(final Long id);

    /**
     * Saves a templateJsDb's information
     * @param templateJsDb the object to be saved
     */	
    public void saveTemplateJsDb(TemplateJsDb templateJsDb);

	/**
     * Removes a templateJsDb from the database by id
     * @param id the templateJsDb's id
     */
    public void removeTemplateJsDb(final Long id);
}

