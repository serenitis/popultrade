
package com.popultrade.dao;

import java.util.List;


import com.popultrade.model.TemplateView;

public interface TemplateViewDAO extends DAO {
	 public List getTemplateViews(final TemplateView templateView,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
			
    /**
     * Retrieves all of the templateViews
     */
    public List getTemplateViews(TemplateView templateView);

    /**
     * Gets templateView's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateView's id
     * @return templateView populated templateView object
     */
    public TemplateView getTemplateView(final Long id);

    /**
     * Saves a templateView's information
     * @param templateView the object to be saved
     */	
    public void saveTemplateView(TemplateView templateView);

	/**
     * Removes a templateView from the database by id
     * @param id the templateView's id
     */
    public void removeTemplateView(final Long id);
}

