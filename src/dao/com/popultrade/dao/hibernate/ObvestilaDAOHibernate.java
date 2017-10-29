
package com.popultrade.dao.hibernate;

import java.util.Date;
import java.util.List;


import com.popultrade.model.Obvestila;
import com.popultrade.dao.ObvestilaDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class ObvestilaDAOHibernate extends BaseDAOHibernate implements ObvestilaDAO {

	
	   
	public int getStObvestila(final Obvestila obvestila,String dodatni_sql_pogoji) {
		
		try {
			Example ex = Example.create(obvestila).ignoreCase().excludeZeroes().enableLike(MatchMode.START);
			Criteria criteria = currentSession().createCriteria(Obvestila.class).add(ex) ; 
		    if (obvestila.getId()!=null) {
		    	criteria.add(Restrictions.eq("id",obvestila.getId()));
	        }
			criteria.setProjection(Projections.rowCount()); 
			   if (!dodatni_sql_pogoji.equals("")) {
				   criteria.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
		        }
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
   
   
    public List getObvestilas(final Obvestila obvestila,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from Obvestila order by datum_Obvestilaa");

      Example ex = Example.create(obvestila).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        
      
      
        Criteria cri = currentSession().createCriteria(Obvestila.class).add(ex);
        if (obvestila.getId()!=null) {
	    	cri.add(Restrictions.eq("id",obvestila.getId()));
        }
        if (!orderby.equals("")) {
        	if (orderby_smer.equals("asc")) {
        cri.addOrder(Order.asc(orderby));
        	}
        	else {
        		cri.addOrder(Order.desc(orderby));	
        	}
        }
        if (!dodatni_sql_pogoji.equals("")) {
        	cri.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
        }
 
        
        return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
	
	
	
	public int getStObvestila(final Obvestila obvestila) {
		
		try {
			 Example ex = Example.create(obvestila).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(Obvestila.class).add(ex) ; 
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getObvestilas(final Obvestila obvestila,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from Obvestila order by datum_Obvestilaa");

      Example ex = Example.create(obvestila).ignoreCase().excludeZeroes();     
        
        return currentSession().createCriteria(Obvestila.class).add(ex).addOrder(Order.desc("id")).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
	
	
	
	public int getStObvestilap(final Obvestila obvestila) {
		
		try {
			 Example ex = Example.create(obvestila).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(Obvestila.class).add(ex) ; 
			
				criteria.add(Restrictions.or(Restrictions.le("datum_v_od",new Date()),Restrictions.isNull("datum_v_od")));
				criteria.add(Restrictions.or(Restrictions.ge("datum_v_do",new Date()),Restrictions.isNull("datum_v_do")));
				
				//criteria.add(Restrictions.or(Restrictions.eq("usp_oznnar",obvestila.getUsp_oznnar()),Restrictions.isNull("usp_oznnar")));
				
			criteria.setProjection(Projections.rowCount()); 
			
			
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getObvestilasp(final Obvestila obvestila,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from Obvestila order by datum_Obvestilaa");

      Example ex = Example.create(obvestila).ignoreCase().excludeZeroes();     
        
        Criteria cri= currentSession().createCriteria(Obvestila.class).add(ex);
        cri.add(Restrictions.or(Restrictions.le("datum_v_od",new Date()),Restrictions.isNull("datum_v_od")));
		cri.add(Restrictions.or(Restrictions.ge("datum_v_do",new Date()),Restrictions.isNull("datum_v_do")));
		
		
		//cri.add(Restrictions.or(Restrictions.eq("usp_oznnar",obvestila.getUsp_oznnar()),Restrictions.isNull("usp_oznnar")));
		
		
		
      return  cri.addOrder(Order.desc("id")).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
        
    }
	
	
	
	
	
    /**
     * @see com.popultrade.dao.ObvestilaDAO#getObvestilas(com.popultrade.model.Obvestila)
     */
    public List getObvestilas(final Obvestila obvestila) {
        return getHibernateTemplate().find("from Obvestila order by datkre desc");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (obvestila == null) {
            return getHibernateTemplate().find("from Obvestila");
        } else {
            // filter on properties set in the obvestila
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(obvestila).ignoreCase().enableLike(MatchMode.ANYWHERE);
                    return session.createCriteria(Obvestila.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.ObvestilaDAO#getObvestila(Long id)
     */
    public Obvestila getObvestila(final Long id) {
        Obvestila obvestila = (Obvestila) getHibernateTemplate().get(Obvestila.class, id);
        if (obvestila == null) {
            log.warn("uh oh, obvestila with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Obvestila.class, id);
        }

        return obvestila;
    }

    /**
     * @see com.popultrade.dao.ObvestilaDAO#saveObvestila(Obvestila obvestila)
     */    
    public void saveObvestila(final Obvestila obvestila) {
        getHibernateTemplate().saveOrUpdate(obvestila);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.ObvestilaDAO#removeObvestila(Long id)
     */
    public void removeObvestila(final Long id) {
        getHibernateTemplate().delete(getObvestila(id));
getHibernateTemplate().flush();

    }
}
