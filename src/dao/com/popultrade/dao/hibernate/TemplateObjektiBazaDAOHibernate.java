
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.TemplateObjektiBaza;
import com.popultrade.dao.TemplateObjektiBazaDAO;
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

public class TemplateObjektiBazaDAOHibernate extends BaseDAOHibernate implements TemplateObjektiBazaDAO {
	
	
    public TemplateObjektiBaza getTemplateObjektiBazaByVezaId(final Long id) {
        List mi =  getHibernateTemplate().find("from TemplateObjektiBaza where templatehead_id="+id+" ");
try {
        if (mi.size()>0) {
        	return (com.popultrade.model.TemplateObjektiBaza)mi.get(0);
        }
}
catch (Exception ex) {
	System.out.println("Napaka pri pridobivanju TemplateObjektiBaza: "+ex.toString());
}
return null;
    }
    
    
  public List getTemplateObjektiBazas(final TemplateObjektiBaza templateObjektiBaza,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateObjektiBaza order by datum_TemplateObjektiBazaa");

      Example ex = Example.create(templateObjektiBaza).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateObjektiBaza.class).add(ex);
        if (templateObjektiBaza.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateObjektiBaza.getId()));
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

	public int getStTemplateObjektiBaza(final TemplateObjektiBaza templateObjektiBaza,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateObjektiBaza).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateObjektiBaza.class).add(ex) ; 

			  if (templateObjektiBaza.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateObjektiBaza.getId()));
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
    public List getTemplateObjektiBazas(final TemplateObjektiBaza templateObjektiBaza,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateObjektiBaza");

          if (templateObjektiBaza == null) {
              return getHibernateTemplate().find("from TemplateObjektiBaza");
          } else {
              // filter on properties set in the templateObjektiBaza
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateObjektiBaza.getSFT_SIFRA());
                  	Example ex = Example.create(templateObjektiBaza).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateObjektiBaza.class).add(ex);
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
    public List getTemplateObjektiBazas2(final TemplateObjektiBaza templateObjektiBaza,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateObjektiBaza");

          if (templateObjektiBaza == null) {
              return getHibernateTemplate().find("from TemplateObjektiBaza");
          } else {
              // filter on properties set in the templateObjektiBaza
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateObjektiBaza.getSFT_SIFRA());
                  	Example ex = Example.create(templateObjektiBaza).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateObjektiBaza.class).add(ex);
                   if (templateObjektiBaza.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateObjektiBaza.getId()));
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
     * @see com.popultrade.dao.TemplateObjektiBazaDAO#getTemplateObjektiBazas(com.popultrade.model.TemplateObjektiBaza)
     */
    public List getTemplateObjektiBazas(final TemplateObjektiBaza templateObjektiBaza) {
       if (templateObjektiBaza == null) {
            return getHibernateTemplate().find("from TemplateObjektiBaza");
        } else {
            // filter on properties set in the templateObjektiBaza
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateObjektiBaza).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateObjektiBaza.class).add(ex);
if (templateObjektiBaza.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateObjektiBaza.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateObjektiBazaDAO#getTemplateObjektiBaza(Long id)
     */
    public TemplateObjektiBaza getTemplateObjektiBaza(final Long id) {
        TemplateObjektiBaza templateObjektiBaza = (TemplateObjektiBaza) getHibernateTemplate().get(TemplateObjektiBaza.class, id);
        if (templateObjektiBaza == null) {
            log.warn("uh oh, templateObjektiBaza with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateObjektiBaza.class, id);
        }

        return templateObjektiBaza;
    }

    /**
     * @see com.popultrade.dao.TemplateObjektiBazaDAO#saveTemplateObjektiBaza(TemplateObjektiBaza templateObjektiBaza)
     */    
    public void saveTemplateObjektiBaza(final TemplateObjektiBaza templateObjektiBaza) {
        getHibernateTemplate().saveOrUpdate(templateObjektiBaza);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateObjektiBazaDAO#removeTemplateObjektiBaza(Long id)
     */
    public void removeTemplateObjektiBaza(final Long id) {
        getHibernateTemplate().delete(getTemplateObjektiBaza(id));
        getHibernateTemplate().flush();
    }
}
