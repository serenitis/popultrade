
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.Stevci;

import com.popultrade.dao.StevciDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class StevciDAOHibernate extends BaseDAOHibernate implements StevciDAO {
	   
	   
    public List getStevcis(final Stevci stevci,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from Stevci order by datum_Stevcia");

      Example ex = Example.create(stevci).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        
        Criteria cri = currentSession().createCriteria(Stevci.class).add(ex);

        if (stevci.getId()!=null) {
        	cri.add(Restrictions.eq("id",stevci.getId()));
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
     * @see org.appfuse.dao.StevciDAO#getStevcis(org.appfuse.model.Stevci)
     */
    public List getStevcis(final Stevci stevci) {
    
        if (stevci == null) {
            return getHibernateTemplate().find("from Stevci");
        } else {
            // filter on properties set in the stevci
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(stevci).ignoreCase().enableLike(MatchMode.EXACT);
                    return session.createCriteria(Stevci.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see org.appfuse.dao.StevciDAO#getStevci(Long id)
     */
    public Stevci getStevci(final Long id) {
        Stevci stevci = (Stevci) getHibernateTemplate().get(Stevci.class, id);
        if (stevci == null) {
            log.warn("uh oh, stevci with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Stevci.class, id);
        }

        return stevci;
    }

    /**
     * @see org.appfuse.dao.StevciDAO#saveStevci(Stevci stevci)
     */    
    public void saveStevci(final Stevci stevci) {
        getHibernateTemplate().saveOrUpdate(stevci);
        getHibernateTemplate().flush();
    }

    /**
     * @see org.appfuse.dao.StevciDAO#removeStevci(Long id)
     */
    public void removeStevci(final Long id) {
        getHibernateTemplate().delete(getStevci(id));
getHibernateTemplate().flush();

    }
}
