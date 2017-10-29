
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateFrame;

public interface TemplateFrameDAO extends DAO {

	public List getTemplateFrames(final TemplateFrame templateFrame,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateFrame(final TemplateFrame templateFrame,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();
	public TemplateFrame getTemplateFrame(String idt,String pozicija);
	public List getTemplateFrames2(final TemplateFrame templateFrame,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateFrames(final TemplateFrame templateFrame,final String orderby,final String orderby_smer);
	public List getTemplateFrameVeze(String pozicija);
	public boolean obstajaTemplateFrame(String idt,String pozicija);
    /**
     * Retrieves all of the templateFrames
     */
    public List getTemplateFrames(TemplateFrame templateFrame);

    /**
     * Gets templateFrame's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateFrame's id
     * @return templateFrame populated templateFrame object
     */
    public TemplateFrame getTemplateFrame(final Long id);

    /**
     * Saves a templateFrame's information
     * @param templateFrame the object to be saved
     */	
    public void saveTemplateFrame(TemplateFrame templateFrame);

	/**
     * Removes a templateFrame from the database by id
     * @param id the templateFrame's id
     */
    public void removeTemplateFrame(final Long id);
}

