
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateMenu;

public interface TemplateMenuDAO extends DAO {

	 public List getTemplateMenus(final TemplateMenu templateMenu,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);

	
	public List getTemplateMenus(final TemplateMenu templateHead,final int pageNumber,final int pageSize) ;
	public int getStTemplateMenu(final TemplateMenu templateHead);
    /**
     * Retrieves all of the templateMenus
     */
    public List getTemplateMenus(TemplateMenu templateMenu);

    /**
     * Gets templateMenu's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateMenu's id
     * @return templateMenu populated templateMenu object
     */
    public TemplateMenu getTemplateMenu(final Long id);

    /**
     * Saves a templateMenu's information
     * @param templateMenu the object to be saved
     */	
    public void saveTemplateMenu(TemplateMenu templateMenu);

	/**
     * Removes a templateMenu from the database by id
     * @param id the templateMenu's id
     */
    public void removeTemplateMenu(final Long id);
}

