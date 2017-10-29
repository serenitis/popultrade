
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateUpload;
import com.popultrade.dao.TemplateUploadDAO;

import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateUploadDAOHibernate extends BaseDAOHibernate implements TemplateUploadDAO {

    /**
     * @see com.popultrade.dao.TemplateUploadDAO#getTemplateUploads(com.popultrade.model.TemplateUpload)
     */
	
	
    public TemplateUpload getTemplateUploadByHeadId(String head_id) {
        List li = getHibernateTemplate().find("from TemplateUpload where templatehead_id="+head_id);
        
        
        if (li.size()>0) {
        	return (TemplateUpload)li.get(0);
        }
        
        return null;
        
    }
	
	
    public List getTemplateUploads(final TemplateUpload templateUpload) {
        return getHibernateTemplate().find("from TemplateUpload");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateUpload == null) {
            return getHibernateTemplate().find("from TemplateUpload");
        } else {
            // filter on properties set in the templateUpload
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateUpload).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateUpload.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateUploadDAO#getTemplateUpload(Long id)
     */
    public TemplateUpload getTemplateUpload(final Long id) {
        TemplateUpload templateUpload = (TemplateUpload) getHibernateTemplate().get(TemplateUpload.class, id);
        if (templateUpload == null) {
            log.warn("uh oh, templateUpload with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateUpload.class, id);
        }

        return templateUpload;
    }

    /**
     * @see com.popultrade.dao.TemplateUploadDAO#saveTemplateUpload(TemplateUpload templateUpload)
     */    
    public void saveTemplateUpload(final TemplateUpload templateUpload) {
        getHibernateTemplate().saveOrUpdate(templateUpload);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateUploadDAO#removeTemplateUpload(Long id)
     */
    public void removeTemplateUpload(final Long id) {
        getHibernateTemplate().delete(getTemplateUpload(id));
        getHibernateTemplate().flush();
    }
}
