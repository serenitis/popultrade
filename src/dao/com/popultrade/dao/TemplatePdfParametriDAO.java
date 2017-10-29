
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplatePdfParametri;

public interface TemplatePdfParametriDAO extends DAO {
	  public TemplatePdfParametri getTemplatePdfParametriByVezaId(final Long id);
	  
	  public TemplatePdfParametri getTemplatePdfParametriByVezaIdType(final Long id,String type);
	  
	  
    /**
     * Retrieves all of the templatePdfParametris
     */
    public List getTemplatePdfParametris(TemplatePdfParametri templatePdfParametri);
	 public List getTemplatePdfParametris(final TemplatePdfParametri templatePdfParametri,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);

    /**
     * Gets templatePdfParametri's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templatePdfParametri's id
     * @return templatePdfParametri populated templatePdfParametri object
     */
    public TemplatePdfParametri getTemplatePdfParametri(final Long id);

    /**
     * Saves a templatePdfParametri's information
     * @param templatePdfParametri the object to be saved
     */	
    public void saveTemplatePdfParametri(TemplatePdfParametri templatePdfParametri);

	/**
     * Removes a templatePdfParametri from the database by id
     * @param id the templatePdfParametri's id
     */
    public void removeTemplatePdfParametri(final Long id);
}

