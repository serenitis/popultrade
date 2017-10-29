
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateHeadReset;
import com.popultrade.dao.TemplateHeadResetDAO;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateHeadResetDAOHibernate extends BaseDAOHibernate implements TemplateHeadResetDAO {

    /**
     * @see com.popultrade.dao.TemplateHeadResetDAO#getTemplateHeadResets(com.popultrade.model.TemplateHeadReset)
     */
    public List getTemplateHeadResets(final TemplateHeadReset templateHeadReset) {
 
        if (templateHeadReset == null) {
            return getHibernateTemplate().find("from TemplateHeadReset");
        } else {
            // filter on properties set in the templateHeadReset
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateHeadReset).ignoreCase().enableLike(MatchMode.EXACT);
                    return session.createCriteria(TemplateHeadReset.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateHeadResetDAO#getTemplateHeadReset(Long id)
     */
    public TemplateHeadReset getTemplateHeadReset(final Long id) {
        TemplateHeadReset templateHeadReset = (TemplateHeadReset) getHibernateTemplate().get(TemplateHeadReset.class, id);
        if (templateHeadReset == null) {
            log.warn("uh oh, templateHeadReset with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateHeadReset.class, id);
        }

        return templateHeadReset;
    }

    /**
     * @see com.popultrade.dao.TemplateHeadResetDAO#saveTemplateHeadReset(TemplateHeadReset templateHeadReset)
     */    
    public void saveTemplateHeadReset(final TemplateHeadReset templateHeadReset) {
        getHibernateTemplate().saveOrUpdate(templateHeadReset);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateHeadResetDAO#removeTemplateHeadReset(Long id)
     */
    public void removeTemplateHeadReset(final Long id) {
        getHibernateTemplate().delete(getTemplateHeadReset(id));
        getHibernateTemplate().flush();
    }
}
