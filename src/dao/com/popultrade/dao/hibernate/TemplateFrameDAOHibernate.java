
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateFrame;

import com.popultrade.dao.TemplateFrameDAO;
import org.springframework.orm.ObjectRetrievalFailureException;

import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.spi.SessionFactoryImplementor;

import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateFrameDAOHibernate extends BaseDAOHibernate implements TemplateFrameDAO {

	
	
	
    public TemplateFrame getTemplateFrame(String idt,String pozicija) {
        List li = getHibernateTemplate().find("from TemplateFrame where templateui_id="+idt+" and pozicija='"+pozicija+"'");
        
        try {
        	if (li.size()==1) {
        	return (TemplateFrame)li.get(0);
        	}
        	
        }
        catch (Exception j) {
        	
        }
        return null;
    }
    
    
    public boolean obstajaTemplateFrame(String idt,String pozicija) {
        List li = getHibernateTemplate().find("from TemplateFrame where templateui_id="+idt+" and pozicija='"+pozicija+"'");
        
        try {
        	if (li.size()==1) {
        	return true;
        	}
        	
        }
        catch (Exception j) {
        	
        }
        return false;
    }
    
    
    
	
	
	
    public List getTemplateFrameVeze(String pozicija) {
        List li = getHibernateTemplate().find("from TemplateFrame where (veza_na_id is null) and pozicija='"+pozicija+"'");
        
     
        return li;
    }
	
	
	
	
	
  public List getTemplateFrames(final TemplateFrame templateFrame,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateFrame order by datum_TemplateFramea");

      Example ex = Example.create(templateFrame).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateFrame.class).add(ex);
        if (templateFrame.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateFrame.getId()));
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

	public int getStTemplateFrame(final TemplateFrame templateFrame,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateFrame).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateFrame.class).add(ex) ; 

			  if (templateFrame.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateFrame.getId()));
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

	public Connection pridobiConnectionZaProceduro() {
		  
		    java.sql.Connection connection = null;
		 
		    return connection;
	}
    public List getTemplateFrames(final TemplateFrame templateFrame,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateFrame");

          if (templateFrame == null) {
              return getHibernateTemplate().find("from TemplateFrame");
          } else {
              // filter on properties set in the templateFrame
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateFrame.getSFT_SIFRA());
                  	Example ex = Example.create(templateFrame).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateFrame.class).add(ex);
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
                     return cri.list();
                  }
              };
              return (List) getHibernateTemplate().execute(callback);
          }
      }
    public List getTemplateFrames2(final TemplateFrame templateFrame,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateFrame");

          if (templateFrame == null) {
              return getHibernateTemplate().find("from TemplateFrame");
          } else {
              // filter on properties set in the templateFrame
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateFrame.getSFT_SIFRA());
                  	Example ex = Example.create(templateFrame).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateFrame.class).add(ex);
                   if (templateFrame.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateFrame.getId()));
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
                      if (!dodaten_hql.equals("")) {
                      	cri.add(Restrictions.sqlRestriction(dodaten_hql));
                      }
                     return cri.list();
                  }
              };
              return (List) getHibernateTemplate().execute(callback);
          }
      }

    /**
     * @see com.popultrade.dao.TemplateFrameDAO#getTemplateFrames(com.popultrade.model.TemplateFrame)
     */
    public List getTemplateFrames(final TemplateFrame templateFrame) {
       if (templateFrame == null) {
            return getHibernateTemplate().find("from TemplateFrame");
        } else {
            // filter on properties set in the templateFrame
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateFrame).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateFrame.class).add(ex);
if (templateFrame.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateFrame.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateFrameDAO#getTemplateFrame(Long id)
     */
    public TemplateFrame getTemplateFrame(final Long id) {
        TemplateFrame templateFrame = (TemplateFrame) getHibernateTemplate().get(TemplateFrame.class, id);
        if (templateFrame == null) {
            log.warn("uh oh, templateFrame with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateFrame.class, id);
        }

        return templateFrame;
    }

    /**
     * @see com.popultrade.dao.TemplateFrameDAO#saveTemplateFrame(TemplateFrame templateFrame)
     */    
    public void saveTemplateFrame(final TemplateFrame templateFrame) {
        getHibernateTemplate().saveOrUpdate(templateFrame);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateFrameDAO#removeTemplateFrame(Long id)
     */
    public void removeTemplateFrame(final Long id) {
        getHibernateTemplate().delete(getTemplateFrame(id));
        getHibernateTemplate().flush();
    }
}
