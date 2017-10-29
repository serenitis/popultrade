
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.TemplateClassClass;

import com.popultrade.dao.TemplateClassClassDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;

import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateClassClassDAOHibernate extends BaseDAOHibernate implements TemplateClassClassDAO {

	
    
  public List getTemplateClassClasss(final TemplateClassClass templateMailList,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateClassClass order by datum_TemplateClassClassa");
	  
      Example ex = Example.create(templateMailList).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateClassClass.class).add(ex);
        if (templateMailList.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateMailList.getId()));
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
     * @see com.popultrade.dao.TemplateClassClassDAO#getTemplateClassClasss(com.popultrade.model.TemplateClassClass)
     */
    public List getTemplateClassClasss(final TemplateClassClass templateClassClass) {
        return getHibernateTemplate().find("from TemplateClassClass where id_veza="+templateClassClass.getId_veza());

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateClassClass == null) {
            return getHibernateTemplate().find("from TemplateClassClass");
        } else {
            // filter on properties set in the templateClassClass
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateClassClass).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateClassClass.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateClassClassDAO#getTemplateClassClass(Long id)
     */
    public TemplateClassClass getTemplateClassClass(final Long id) {
        TemplateClassClass templateClassClass = (TemplateClassClass) getHibernateTemplate().get(TemplateClassClass.class, id);
        if (templateClassClass == null) {
            log.warn("uh oh, templateClassClass with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateClassClass.class, id);
        }

        return templateClassClass;
    }

    /**
     * @see com.popultrade.dao.TemplateClassClassDAO#saveTemplateClassClass(TemplateClassClass templateClassClass)
     */    
    public void saveTemplateClassClass(final TemplateClassClass templateClassClass) {
        getHibernateTemplate().saveOrUpdate(templateClassClass);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateClassClassDAO#removeTemplateClassClass(Long id)
     */
    public void removeTemplateClassClass(final Long id) {
        getHibernateTemplate().delete(getTemplateClassClass(id));
        getHibernateTemplate().flush();
    }
}
