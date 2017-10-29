
package com.popultrade.dao.hibernate;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.popultrade.model.TemplateTables;
import com.popultrade.dao.TemplateTablesDAO;
import org.springframework.orm.ObjectRetrievalFailureException;

import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.spi.SessionFactoryImplementor;

import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateTablesDAOHibernate extends BaseDAOHibernate implements TemplateTablesDAO {

	
	//// get table structure
	/*
	public Hashtable getTableStructure(String tablename) {
		
		
		Hashtable retu = new Hashtable();
		
//			String que = "delete from Esd11  where zapst="+zapst+" and e10_ide10="+e10_ide10;
			
//			getSession().createQuery(que).executeUpdate();
			Session session = this.currentSession();
		String	que = "SELECT column_name,udt_name,data_type FROM INFORMATION_SCHEMA.COLUMNS WHERE lower(table_name) = lower('"+tablename+"') order by column_name";
			
	//	List lio = session.createQuery(que).list();
		
		//Session session = factory.openSession();
	      Transaction tx = null;
	      try{
	        // tx = session.beginTransaction();
	       
	         SQLQuery query = session.createSQLQuery(que);
	         query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	         List data = query.list();

	         //System.out.println("---------"+data.size());
	         
	         for(Object object : data)
	         {
	            Map row = (Map)object;
	          //  System.out.print("column_name: " + row.get("column_name")); 
	         //   System.out.println(", data_type: " + row.get("data_type")); 
	            
	            retu.put(row.get("column_name"), row.get("data_type") + "-----"+row.get("udt_name"));
	            
	         }
	       //  tx.commit();
	      }catch (HibernateException e) {
	         if (tx!=null) tx.rollback();
	         e.printStackTrace(); 
	      }finally {
	     //    session.close(); 
	      }
		
		
	return retu;
	
	
}
	
	*/
	
	
	/// oracle
	public Hashtable getTableStructure(String tablename) {
		
		
		Hashtable retu = new Hashtable();
		
//			String que = "delete from Esd11  where zapst="+zapst+" and e10_ide10="+e10_ide10;
			
//			getSession().createQuery(que).executeUpdate();
			Session session = this.currentSession();
		//String	que = "SELECT column_name,udt_name,data_type FROM INFORMATION_SCHEMA.COLUMNS WHERE lower(table_name) = lower('"+tablename+"') order by column_name";
			
	//	List lio = session.createQuery(que).list();
		// oracle
		
					String	que = "select * from user_tab_columns where lower(table_name) = lower('"+tablename+"') order by column_name";
		//Session session = factory.openSession();
	      Transaction tx = null;
	      try{
	        // tx = session.beginTransaction();
	       
	         SQLQuery query = session.createSQLQuery(que);
	         query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	         List data = query.list();

	         //System.out.println("---------"+data.size());
	         
	         for(Object object : data)
	         {
	            Map row = (Map)object;
	          //  System.out.print("column_name: " + row.get("column_name")); 
	         //   System.out.println(", data_type: " + row.get("data_type")); 
	            
	          //  retu.put(row.get("column_name"), row.get("data_type") + "-----"+row.get("udt_name"));
	            retu.put(row.get("COLUMN_NAME").toString().toLowerCase(), row.get("DATA_TYPE").toString().toLowerCase() + "-----"+row.get("DATA_LENGTH").toString().toLowerCase()+" "+(row.get("DATA_PRECISION")==null?"":"("+row.get("DATA_PRECISION")+")")+"");
		           
	         }
	       //  tx.commit();
	      }catch (HibernateException e) {
	         if (tx!=null) tx.rollback();
	         e.printStackTrace(); 
	      }finally {
	     //    session.close(); 
	      }
		
		
	return retu;
	
	
}
	
	
	
	
	
	
	
	
  public List getTemplateTabless(final TemplateTables templateTables,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateTables order by datum_TemplateTablesa");

      Example ex = Example.create(templateTables).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateTables.class).add(ex);
        if (templateTables.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateTables.getId()));
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

	public int getStTemplateTables(final TemplateTables templateTables,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateTables).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateTables.class).add(ex) ; 

			  if (templateTables.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateTables.getId()));
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
    public List getTemplateTabless(final TemplateTables templateTables,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateTables");

          if (templateTables == null) {
              return getHibernateTemplate().find("from TemplateTables");
          } else {
              // filter on properties set in the templateTables
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateTables.getSFT_SIFRA());
                  	Example ex = Example.create(templateTables).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateTables.class).add(ex);
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
    public List getTemplateTabless2(final TemplateTables templateTables,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateTables");

          if (templateTables == null) {
              return getHibernateTemplate().find("from TemplateTables");
          } else {
              // filter on properties set in the templateTables
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateTables.getSFT_SIFRA());
                  	Example ex = Example.create(templateTables).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateTables.class).add(ex);
                   if (templateTables.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateTables.getId()));
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
     * @see com.popultrade.dao.TemplateTablesDAO#getTemplateTabless(com.popultrade.model.TemplateTables)
     */
    public List getTemplateTabless(final TemplateTables templateTables) {
       if (templateTables == null) {
            return getHibernateTemplate().find("from TemplateTables");
        } else {
            // filter on properties set in the templateTables
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateTables).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateTables.class).add(ex);
if (templateTables.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateTables.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateTablesDAO#getTemplateTables(Long id)
     */
    public TemplateTables getTemplateTables(final Long id) {
        TemplateTables templateTables = (TemplateTables) getHibernateTemplate().get(TemplateTables.class, id);
        if (templateTables == null) {
            log.warn("uh oh, templateTables with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateTables.class, id);
        }

        return templateTables;
    }

    /**
     * @see com.popultrade.dao.TemplateTablesDAO#saveTemplateTables(TemplateTables templateTables)
     */    
    public void saveTemplateTables(final TemplateTables templateTables) {
        getHibernateTemplate().saveOrUpdate(templateTables);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateTablesDAO#removeTemplateTables(Long id)
     */
    public void removeTemplateTables(final Long id) {
        getHibernateTemplate().delete(getTemplateTables(id));
        getHibernateTemplate().flush();
    }
}
