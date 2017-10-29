
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateUi;

import com.popultrade.dao.TemplateUiDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateUiDAOHibernate extends BaseDAOHibernate implements TemplateUiDAO {

	
	 public List getTemplateUis(final TemplateUi templateUi,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateUi order by datum_TemplateUia");

	      Example ex = Example.create(templateUi).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateUi.class).add(ex);
	        if (templateUi.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateUi.getId()));
	        }

	        if (!orderby.equals("")) {

	        	if (orderby.indexOf(",")!=-1) {
	        	String[] yum = orderby.split(",");
	        	for (int i=0;i<yum.length;i++) {
	        		if (yum[i].indexOf(" ")!=-1) {
	        			if (yum[i].indexOf("asc")!=-1) {
	        				cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(" "))));	
	        			}
	        			else {
	        				cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(" "))));	
	        			}
	        		}
	        		else {
	        			cri.addOrder(Order.desc(yum[i].trim()));	
	        		}
	        	}

	        	}
	        	else {
	        	if (orderby_smer.equals("asc")) {
	        cri.addOrder(Order.asc(orderby));
	        	}
	        	else {
	        		cri.addOrder(Order.desc(orderby));	
	        	}
	        	}

	        }
	        if (!dodatni_sql_pogoji.equals("")) {
	        	cri.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
	        }

	        return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

	    }
	
	
	
    /**
     * @see com.popultrade.dao.TemplateUiDAO#getTemplateUis(com.popultrade.model.TemplateUi)
     */
    public List getTemplateUis(final TemplateUi templateUi) {
  
        if (templateUi == null) {
            return getHibernateTemplate().find("from TemplateUi");
        } else {
            // filter on properties set in the templateUi
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateUi).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateUi.class).add(ex).add(Restrictions.isNull("templateui_id")).addOrder(Order.asc("zaporedje")).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateUiDAO#getTemplateUi(Long id)
     */
    public TemplateUi getTemplateUi(final Long id) {
        TemplateUi templateUi = (TemplateUi) getHibernateTemplate().get(TemplateUi.class, id);
        if (templateUi == null) {
            log.warn("uh oh, templateUi with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateUi.class, id);
        }

        return templateUi;
    }

    /**
     * @see com.popultrade.dao.TemplateUiDAO#saveTemplateUi(TemplateUi templateUi)
     */    
    public void saveTemplateUi(final TemplateUi templateUi) {
        getHibernateTemplate().saveOrUpdate(templateUi);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateUiDAO#removeTemplateUi(Long id)
     */
    public void removeTemplateUi(final Long id) {
        getHibernateTemplate().delete(getTemplateUi(id));
        getHibernateTemplate().flush();
    }
}
