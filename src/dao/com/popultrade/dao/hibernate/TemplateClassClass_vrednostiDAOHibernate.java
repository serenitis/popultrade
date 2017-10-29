
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateClassClass_vrednosti;

import com.popultrade.dao.TemplateClassClass_vrednostiDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateClassClass_vrednostiDAOHibernate extends BaseDAOHibernate implements TemplateClassClass_vrednostiDAO {
    
  public List getTemplateClassClass_vrednostis(final TemplateClassClass_vrednosti templateMailList,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateClassClass_vrednosti order by datum_TemplateClassClass_vrednostia");

      Example ex = Example.create(templateMailList).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateClassClass_vrednosti.class).add(ex);
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
     * @see com.popultrade.dao.TemplateClassClass_vrednostiDAO#getTemplateClassClass_vrednostis(com.popultrade.model.TemplateClassClass_vrednosti)
     */
	
	
	   public void deleteById(String nad_id,String obstaja) {
			
		   
			try {
				
				
				
				String que = "delete from TemplateClassClass_vrednosti where templateclassclass_id="+nad_id+" and id not in ("+obstaja+") ";
				System.out.println(que);
				currentSession().createQuery(que).executeUpdate();
				
		
				
				
			}
			catch (Exception ex) {
				org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
				log.error(ex.toString());
			}
		   
		   
	   }
	
	
    public List getTemplateClassClass_vrednostis(final TemplateClassClass_vrednosti templateClassClass_vrednosti) {
       // return getHibernateTemplate().find("from TemplateClassClass_vrednosti");

    
        if (templateClassClass_vrednosti == null) {
            return getHibernateTemplate().find("from TemplateClassClass_vrednosti");
        } else {
            // filter on properties set in the templateClassClass_vrednosti
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateClassClass_vrednosti).enableLike(MatchMode.EXACT);
                    return session.createCriteria(TemplateClassClass_vrednosti.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateClassClass_vrednostiDAO#getTemplateClassClass_vrednosti(Long id)
     */
    public TemplateClassClass_vrednosti getTemplateClassClass_vrednosti(final Long id) {
        TemplateClassClass_vrednosti templateClassClass_vrednosti = (TemplateClassClass_vrednosti) getHibernateTemplate().get(TemplateClassClass_vrednosti.class, id);
        if (templateClassClass_vrednosti == null) {
            log.warn("uh oh, templateClassClass_vrednosti with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateClassClass_vrednosti.class, id);
        }

        return templateClassClass_vrednosti;
    }

    /**
     * @see com.popultrade.dao.TemplateClassClass_vrednostiDAO#saveTemplateClassClass_vrednosti(TemplateClassClass_vrednosti templateClassClass_vrednosti)
     */    
    public void saveTemplateClassClass_vrednosti(final TemplateClassClass_vrednosti templateClassClass_vrednosti) {
        getHibernateTemplate().saveOrUpdate(templateClassClass_vrednosti);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateClassClass_vrednostiDAO#removeTemplateClassClass_vrednosti(Long id)
     */
    public void removeTemplateClassClass_vrednosti(final Long id) {
        getHibernateTemplate().delete(getTemplateClassClass_vrednosti(id));
        getHibernateTemplate().flush();
    }
}
