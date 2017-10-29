
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.TemplateFunkcija;
import com.popultrade.dao.TemplateFunkcijaDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateFunkcijaDAOHibernate extends BaseDAOHibernate implements TemplateFunkcijaDAO {

	
	

	 public List getTemplateFunkcijas(final TemplateFunkcija templateFunkcija,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateFunkcija order by datum_TemplateFunkcijaa");

	      Example ex = Example.create(templateFunkcija).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateFunkcija.class).add(ex);
	        if (templateFunkcija.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateFunkcija.getId()));
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
	
	
	
	public int getStTemplateFunkcija(final TemplateFunkcija esd50) {
		
		try {
			 Example ex = Example.create(esd50).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(TemplateFunkcija.class).add(ex).add(Restrictions.isNull("templatefunkcija_id")) ; 
			
	
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getTemplateFunkcijas(final TemplateFunkcija esd50,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from TemplateFunkcija order by datum_TemplateFunkcijaa");

      Example ex = Example.create(esd50).ignoreCase().excludeZeroes();     
        
        Criteria cri =  currentSession().createCriteria(TemplateFunkcija.class).add(ex).add(Restrictions.isNull("templatefunkcija_id")).addOrder(Order.desc("zaporedje"));

        
        
        return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
	
	
	
	
	
	
	
	
	
	
	
	
    /**
     * @see com.popultrade.dao.TemplateFunkcijaDAO#getTemplateFunkcijas(com.popultrade.model.TemplateFunkcija)
     */
    public List getTemplateFunkcijas(final TemplateFunkcija templateFunkcija) {
        return getHibernateTemplate().find("from TemplateFunkcija");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateFunkcija == null) {
            return getHibernateTemplate().find("from TemplateFunkcija");
        } else {
            // filter on properties set in the templateFunkcija
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateFunkcija).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateFunkcija.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateFunkcijaDAO#getTemplateFunkcija(Long id)
     */
    public TemplateFunkcija getTemplateFunkcija(final Long id) {
        TemplateFunkcija templateFunkcija = (TemplateFunkcija) getHibernateTemplate().get(TemplateFunkcija.class, id);
        if (templateFunkcija == null) {
            log.warn("uh oh, templateFunkcija with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateFunkcija.class, id);
        }

        return templateFunkcija;
    }

    /**
     * @see com.popultrade.dao.TemplateFunkcijaDAO#saveTemplateFunkcija(TemplateFunkcija templateFunkcija)
     */    
    public void saveTemplateFunkcija(final TemplateFunkcija templateFunkcija) {
        getHibernateTemplate().saveOrUpdate(templateFunkcija);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateFunkcijaDAO#removeTemplateFunkcija(Long id)
     */
    public void removeTemplateFunkcija(final Long id) {
        getHibernateTemplate().delete(getTemplateFunkcija(id));
        getHibernateTemplate().flush();
    }
}
