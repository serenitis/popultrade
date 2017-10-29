
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateUpload;

public interface TemplateUploadDAO extends DAO {
	   public TemplateUpload getTemplateUploadByHeadId(String head_id) ;
    /**
     * Retrieves all of the templateUploads
     */
    public List getTemplateUploads(TemplateUpload templateUpload);

    /**
     * Gets templateUpload's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateUpload's id
     * @return templateUpload populated templateUpload object
     */
    public TemplateUpload getTemplateUpload(final Long id);

    /**
     * Saves a templateUpload's information
     * @param templateUpload the object to be saved
     */	
    public void saveTemplateUpload(TemplateUpload templateUpload);

	/**
     * Removes a templateUpload from the database by id
     * @param id the templateUpload's id
     */
    public void removeTemplateUpload(final Long id);
}

