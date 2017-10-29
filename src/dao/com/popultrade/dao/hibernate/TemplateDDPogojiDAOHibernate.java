package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.TemplateDDPogoji;
import com.popultrade.dao.TemplateDDPogojiDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateDDPogojiDAOHibernate extends BaseDAOHibernate implements TemplateDDPogojiDAO {

	
	


	 public List getTemplateDDPogojis(final TemplateDDPogoji templateDDPogoji,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateDDPogoji order by datum_TemplateDDPogojia");

	      Example ex = Example.create(templateDDPogoji).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateDDPogoji.class).add(ex);
	        if (templateDDPogoji.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateDDPogoji.getId()));
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
     * @see com.popultrade.dao.TemplateDDPogojiDAO#getTemplateDDPogojis(com.popultrade.model.TemplateDDPogoji)
     */
    public List getTemplateDDPogojis(final TemplateDDPogoji templateDDPogoji) {
 
        if (templateDDPogoji == null) {
            return getHibernateTemplate().find("from TemplateDDPogoji");
        } else {
            // filter on properties set in the templateDDPogoji
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateDDPogoji).ignoreCase().enableLike(MatchMode.EXACT);
                    return session.createCriteria(TemplateDDPogoji.class).add(ex).addOrder(Order.asc("zaporedje")).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateDDPogojiDAO#getTemplateDDPogoji(Long id)
     */
    public TemplateDDPogoji getTemplateDDPogoji(final Long id) {
        TemplateDDPogoji templateDDPogoji = (TemplateDDPogoji) getHibernateTemplate().get(TemplateDDPogoji.class, id);
        if (templateDDPogoji == null) {
            log.warn("uh oh, templateDDPogoji with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateDDPogoji.class, id);
        }

        return templateDDPogoji;
    }

    /**
     * @see com.popultrade.dao.TemplateDDPogojiDAO#saveTemplateDDPogoji(TemplateDDPogoji templateDDPogoji)
     */    
    public void saveTemplateDDPogoji(final TemplateDDPogoji templateDDPogoji) {
        getHibernateTemplate().saveOrUpdate(templateDDPogoji);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateDDPogojiDAO#removeTemplateDDPogoji(Long id)
     */
    public void removeTemplateDDPogoji(final Long id) {
        getHibernateTemplate().delete(getTemplateDDPogoji(id));
        getHibernateTemplate().flush();
    }
}
