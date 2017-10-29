
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateHead;

public interface TemplateHeadDAO extends DAO {
	  public List getTemplateHeads(final TemplateHead TemplateHead,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
		  
	public TemplateHead getTemplateHeadNadGumb(String thid);
	public List getTemplateHeadImaGumb(String thid);
	public List getTemplateHeads2(final TemplateHead templateHead);
	public int getStTemplateHead(final TemplateHead templateHead);
	public List getTemplateHeads(final TemplateHead templateHead,final int pageNumber,final int pageSize);
    /**
     * Retrieves all of the templateHeads
     */
    public List getTemplateHeads(TemplateHead templateHead);

    /**
     * Gets templateHead's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateHead's id
     * @return templateHead populated templateHead object
     */
    public TemplateHead getTemplateHead(final Long id);

    /**
     * Saves a templateHead's information
     * @param templateHead the object to be saved
     */	
    public void saveTemplateHead(TemplateHead templateHead);

	/**
     * Removes a templateHead from the database by id
     * @param id the templateHead's id
     */
    public void removeTemplateHead(final Long id);
}

