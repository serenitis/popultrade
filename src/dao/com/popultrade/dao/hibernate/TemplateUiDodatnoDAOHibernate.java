
package com.popultrade.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.popultrade.model.TemplateUiDodatno;

import com.popultrade.dao.TemplateUiDodatnoDAO;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.spi.SessionFactoryImplementor;

import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateUiDodatnoDAOHibernate extends BaseDAOHibernate implements TemplateUiDodatnoDAO {
	
	
	
	
	 public List getTemplateUiDodatnos(final TemplateUiDodatno templateUiDodatno,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateUiDodatno order by datum_TemplateUiDodatnoa");

	      Example ex = Example.create(templateUiDodatno).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateUiDodatno.class).add(ex);
	        if (templateUiDodatno.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateUiDodatno.getId()));
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
	
    public TemplateUiDodatno getTemplateUiDodatnos(String idui) {
        List li = getHibernateTemplate().find("from TemplateUiDodatno where templateui_id="+idui);
        
        if (li.size()>0) {
        	return (TemplateUiDodatno)li.get(0);
        }
        else {
        	return new TemplateUiDodatno();
        }
        
        
    }
    
    
    public void updateClob(String id,String polje,String vrednost) {
        // Create a PreparedStatement object.
        PreparedStatement pstmt = null;
        Connection conn=null;
      

        
        
    }
    
    
    
    /**
     * @see com.popultrade.dao.TemplateUiDodatnoDAO#getTemplateUiDodatnos(com.popultrade.model.TemplateUiDodatno)
     */
    public List getTemplateUiDodatnos(final TemplateUiDodatno templateUiDodatno) {
        return getHibernateTemplate().find("from TemplateUiDodatno");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateUiDodatno == null) {
            return getHibernateTemplate().find("from TemplateUiDodatno");
        } else {
            // filter on properties set in the templateUiDodatno
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateUiDodatno).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateUiDodatno.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateUiDodatnoDAO#getTemplateUiDodatno(Long id)
     */
    public TemplateUiDodatno getTemplateUiDodatno(final Long id) {
        TemplateUiDodatno templateUiDodatno = (TemplateUiDodatno) getHibernateTemplate().get(TemplateUiDodatno.class, id);
        if (templateUiDodatno == null) {
            log.warn("uh oh, templateUiDodatno with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateUiDodatno.class, id);
        }

        return templateUiDodatno;
    }

    /**
     * @see com.popultrade.dao.TemplateUiDodatnoDAO#saveTemplateUiDodatno(TemplateUiDodatno templateUiDodatno)
     */    
    public void saveTemplateUiDodatno(final TemplateUiDodatno templateUiDodatno) {
    	try {
        getHibernateTemplate().saveOrUpdate(templateUiDodatno);
        getHibernateTemplate().flush();
    	}
    	catch (Exception ex) {
    		System.out.println("EXXC "+ex.toString());
    	}
    }

    /**
     * @see com.popultrade.dao.TemplateUiDodatnoDAO#removeTemplateUiDodatno(Long id)
     */
    public void removeTemplateUiDodatno(final Long id) {
        getHibernateTemplate().delete(getTemplateUiDodatno(id));
        getHibernateTemplate().flush();
    }
}
