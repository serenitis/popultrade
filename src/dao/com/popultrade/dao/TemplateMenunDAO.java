
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateMenun;

public interface TemplateMenunDAO extends DAO {

	public List getTemplateMenuns(final TemplateMenun templateMenun,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateMenun(final TemplateMenun templateMenun,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateMenuns2(final TemplateMenun templateMenun,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateMenuns(final TemplateMenun templateMenun,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateMenuns
     */
    public List getTemplateMenuns(TemplateMenun templateMenun);

    /**
     * Gets templateMenun's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateMenun's id
     * @return templateMenun populated templateMenun object
     */
    public TemplateMenun getTemplateMenun(final Long id);

    /**
     * Saves a templateMenun's information
     * @param templateMenun the object to be saved
     */	
    public void saveTemplateMenun(TemplateMenun templateMenun);

	/**
     * Removes a templateMenun from the database by id
     * @param id the templateMenun's id
     */
    public void removeTemplateMenun(final Long id);
}

