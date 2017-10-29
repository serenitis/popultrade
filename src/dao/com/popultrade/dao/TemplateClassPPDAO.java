
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateClassPP;

public interface TemplateClassPPDAO extends DAO {
	public TemplateClassPP getTemplateClassPPs(String idui);
	public List getTemplateClassPPs(final TemplateClassPP templateClassPP,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateClassPP(final TemplateClassPP templateClassPP,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getTemplateClassPPs2(final TemplateClassPP templateClassPP,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateClassPPs(final TemplateClassPP templateClassPP,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateClassPPs
     */
    public List getTemplateClassPPs(TemplateClassPP templateClassPP);

    /**
     * Gets templateClassPP's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateClassPP's id
     * @return templateClassPP populated templateClassPP object
     */
    public TemplateClassPP getTemplateClassPP(final Long id);

    /**
     * Saves a templateClassPP's information
     * @param templateClassPP the object to be saved
     */	
    public void saveTemplateClassPP(TemplateClassPP templateClassPP);

	/**
     * Removes a templateClassPP from the database by id
     * @param id the templateClassPP's id
     */
    public void removeTemplateClassPP(final Long id);
}

