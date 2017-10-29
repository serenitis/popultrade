
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplatePP;

import com.popultrade.dao.TemplatePPDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplatePPDAOHibernate extends BaseDAOHibernate implements TemplatePPDAO {

    /**
     * @see com.popultrade.dao.TemplatePPDAO#getTemplatePPs(com.popultrade.model.TemplatePP)
     */
	
	
	
	
	
	
	
	 public List getTemplatePPs(final TemplatePP templatePP,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplatePP order by datum_TemplatePPa");

	      Example ex = Example.create(templatePP).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplatePP.class).add(ex);
	        if (templatePP.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templatePP.getId()));
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
	
	
	
	
	
	
	
	
	
    public List getTemplatePPs(final TemplatePP templatePP) {
 

        if (templatePP == null) {
            return getHibernateTemplate().find("from TemplatePP");
        } else {
            // filter on properties set in the templatePP
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templatePP).ignoreCase().enableLike(MatchMode.EXACT);
                    return session.createCriteria(TemplatePP.class).add(ex).addOrder(Order.asc("zaporedje")).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplatePPDAO#getTemplatePP(Long id)
     */
    public TemplatePP getTemplatePP(final Long id) {
        TemplatePP templatePP = (TemplatePP) getHibernateTemplate().get(TemplatePP.class, id);
        if (templatePP == null) {
            log.warn("uh oh, templatePP with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplatePP.class, id);
        }

        return templatePP;
    }

    /**
     * @see com.popultrade.dao.TemplatePPDAO#saveTemplatePP(TemplatePP templatePP)
     */    
    public void saveTemplatePP(final TemplatePP templatePP) {
        getHibernateTemplate().saveOrUpdate(templatePP);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplatePPDAO#removeTemplatePP(Long id)
     */
    public void removeTemplatePP(final Long id) {
        getHibernateTemplate().delete(getTemplatePP(id));
        getHibernateTemplate().flush();
    }
}
