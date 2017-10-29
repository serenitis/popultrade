
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;

import com.popultrade.model.TemplateMailList;
import com.popultrade.model.TemplateObjektiBaza;

public interface TemplateObjektiBazaDAO extends DAO {

	public List getTemplateObjektiBazas(final TemplateObjektiBaza templateObjektiBaza,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateObjektiBaza(final TemplateObjektiBaza templateObjektiBaza,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();
	 public TemplateObjektiBaza getTemplateObjektiBazaByVezaId(final Long id);
	public List getTemplateObjektiBazas2(final TemplateObjektiBaza templateObjektiBaza,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateObjektiBazas(final TemplateObjektiBaza templateObjektiBaza,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the templateObjektiBazas
     */
    public List getTemplateObjektiBazas(TemplateObjektiBaza templateObjektiBaza);

    /**
     * Gets templateObjektiBaza's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateObjektiBaza's id
     * @return templateObjektiBaza populated templateObjektiBaza object
     */
    public TemplateObjektiBaza getTemplateObjektiBaza(final Long id);

    /**
     * Saves a templateObjektiBaza's information
     * @param templateObjektiBaza the object to be saved
     */	
    public void saveTemplateObjektiBaza(TemplateObjektiBaza templateObjektiBaza);

	/**
     * Removes a templateObjektiBaza from the database by id
     * @param id the templateObjektiBaza's id
     */
    public void removeTemplateObjektiBaza(final Long id);
}

