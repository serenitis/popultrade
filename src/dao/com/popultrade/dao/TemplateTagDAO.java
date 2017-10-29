
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateTag;

public interface TemplateTagDAO extends DAO {
	public int getStTemplateTag(final TemplateTag tf);
	public List getTemplateTags(final TemplateTag tf,final int pageNumber,final int pageSize);
	public TemplateTag getTemplateTagByVezaId(String veza_id);
	
	
	 public List getTemplateTags(final TemplateTag templateTag,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
			
    /**
     * Retrieves all of the templateTags
     */
    public List getTemplateTags(TemplateTag templateTag);

    /**
     * Gets templateTag's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateTag's id
     * @return templateTag populated templateTag object
     */
    public TemplateTag getTemplateTag(final Long id);

    /**
     * Saves a templateTag's information
     * @param templateTag the object to be saved
     */	
    public void saveTemplateTag(TemplateTag templateTag);

	/**
     * Removes a templateTag from the database by id
     * @param id the templateTag's id
     */
    public void removeTemplateTag(final Long id);
}

