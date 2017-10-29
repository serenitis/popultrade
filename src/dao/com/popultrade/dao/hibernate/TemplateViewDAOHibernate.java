
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateView;


import com.popultrade.dao.TemplateViewDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateViewDAOHibernate extends BaseDAOHibernate implements TemplateViewDAO {

	
	 public List getTemplateViews(final TemplateView templateView,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateView order by datum_TemplateViewa");

	      Example ex = Example.create(templateView).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateView.class).add(ex);
	        if (templateView.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateView.getId()));
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
     * @see com.popultrade.dao.TemplateViewDAO#getTemplateViews(com.popultrade.model.TemplateView)
     */
    public List getTemplateViews(final TemplateView templateView) {
   
        if (templateView == null) {
            return getHibernateTemplate().find("from TemplateView");
        } else {
            // filter on properties set in the templateView
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateView).ignoreCase();
                    //return session.createCriteria(TemplateView.class).add(ex).list();
                    return session.createCriteria(TemplateView.class).add(ex).add(Restrictions.isNull("templateview_id")).addOrder(Order.asc("zaporedje")).list();
                    
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateViewDAO#getTemplateView(Long id)
     */
    public TemplateView getTemplateView(final Long id) {
        TemplateView templateView = (TemplateView) getHibernateTemplate().get(TemplateView.class, id);
        if (templateView == null) {
            log.warn("uh oh, templateView with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateView.class, id);
        }

        return templateView;
    }

    /**
     * @see com.popultrade.dao.TemplateViewDAO#saveTemplateView(TemplateView templateView)
     */    
    public void saveTemplateView(final TemplateView templateView) {
        getHibernateTemplate().saveOrUpdate(templateView);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateViewDAO#removeTemplateView(Long id)
     */
    public void removeTemplateView(final Long id) {
        getHibernateTemplate().delete(getTemplateView(id));
        getHibernateTemplate().flush();
    }
}
