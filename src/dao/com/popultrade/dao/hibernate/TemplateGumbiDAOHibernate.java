
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateGumbi;
import com.popultrade.dao.TemplateGumbiDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateGumbiDAOHibernate extends BaseDAOHibernate implements TemplateGumbiDAO {

	 public List getTemplateGumbis(final TemplateGumbi templateGumbi,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateGumbi order by datum_TemplateGumbia");

	      Example ex = Example.create(templateGumbi).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateGumbi.class).add(ex);
	        if (templateGumbi.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateGumbi.getId()));
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
     * @see com.popultrade.dao.TemplateGumbiDAO#getTemplateGumbis(com.popultrade.model.TemplateGumbi)
     */
    public List getTemplateGumbis(final TemplateGumbi templateGumbi) {
      //  return getHibernateTemplate().find("from TemplateGumbi");

   
        if (templateGumbi == null) {
            return getHibernateTemplate().find("from TemplateGumbi");
        } else {
            // filter on properties set in the templateGumbi
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateGumbi).ignoreCase().enableLike(MatchMode.EXACT);
                    return session.createCriteria(TemplateGumbi.class).addOrder(Order.asc("lokacija_gumba")).addOrder(Order.asc("zaporedje")).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateGumbiDAO#getTemplateGumbi(Long id)
     */
    public TemplateGumbi getTemplateGumbi(final Long id) {
        TemplateGumbi templateGumbi = (TemplateGumbi) getHibernateTemplate().get(TemplateGumbi.class, id);
        if (templateGumbi == null) {
            log.warn("uh oh, templateGumbi with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateGumbi.class, id);
        }

        return templateGumbi;
    }

    /**
     * @see com.popultrade.dao.TemplateGumbiDAO#saveTemplateGumbi(TemplateGumbi templateGumbi)
     */    
    public void saveTemplateGumbi(final TemplateGumbi templateGumbi) {
        getHibernateTemplate().saveOrUpdate(templateGumbi);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateGumbiDAO#removeTemplateGumbi(Long id)
     */
    public void removeTemplateGumbi(final Long id) {
        getHibernateTemplate().delete(getTemplateGumbi(id));
        getHibernateTemplate().flush();
    }
}
