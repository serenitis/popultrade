
package com.popultrade.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import com.popultrade.model.Codes;
import com.popultrade.model.Prevodi;
import com.popultrade.dao.CodesDAO;
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

public class CodesDAOHibernate extends BaseDAOHibernate implements CodesDAO {

  public List getCodess(final Codes codes,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from Codes order by datum_Codesa");

      Example ex = Example.create(codes).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(Codes.class).add(ex);
        if (codes.getId()!=null) {
        	cri.add(Restrictions.eq("id",codes.getId()));
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

        
        List retu = new ArrayList();
        
        List limo = cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();
        
        
        for (int i=0;i<limo.size();i++) {

        	Codes coo = (Codes)limo.get(i);
        	
        	List vsex = coo.getTranslation();
        	
        	for (int j=0;j<vsex.size();j++) {
        		Prevodi pr = (Prevodi)vsex.get(j);
        		System.out.println("XC 10");        		
        		if (pr.getSifra_jez().equals(codes.getLanguage())) {
        			System.out.println("XC 11");
        			coo.setLang_text(pr.getPrevod());
        			System.out.println("XC 111");
        			coo.setLanguage(codes.getLanguage());
        			System.out.println("XC 12");
        			break;
        		}
        		
        	}
        	System.out.println("XC 0");
        	boolean foundd = false;
        	boolean pogoj = false;
        	if (codes.getLanguage()!=null && !codes.getLanguage().equals("") ) {
        		pogoj=true;
        		System.out.println("XC 1 " +coo.getLanguage());
        		if (coo.getLanguage()!=null && coo.getLanguage().equals(codes.getLanguage())) {
        			foundd = true;
        		}
        		System.out.println("XC 1x1");
        		
        	}
        	if (codes.getLang_text()!=null && !codes.getLang_text().equals("")) {
        		pogoj=true;
        		System.out.println("XC 1x2");
        		if (coo.getLanguage()!=null && coo.getLang_text().toLowerCase().indexOf(codes.getLang_text().toLowerCase())!=-1) {
        			foundd = true;
        		}
        		
        	}
        	System.out.println("XC 2");
        		if (foundd || !pogoj) {
        			System.out.println("XC 3");
        		retu.add(coo);
        		}
        }
        
        
        return retu;

    }

	public int getStCodes(final Codes codes,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(codes).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(Codes.class).add(ex) ; 

			  if (codes.getId()!=null) {
				  criteria.add(Restrictions.eq("id",codes.getId()));
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



    public List getCodess(final Codes codes,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from Codes");

          if (codes == null) {
              return getHibernateTemplate().find("from Codes");
          } else {
              // filter on properties set in the codes
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+codes.getSFT_SIFRA());
                  	Example ex = Example.create(codes).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(Codes.class).add(ex);
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
                      
                      
                      
                      
                      
                      
                      
                      List retu = new ArrayList();
                      
                      List limo = cri.list();
                      
                      
                      for (int i=0;i<limo.size();i++) {

                      	Codes coo = (Codes)limo.get(i);
                      	
                      	List vsex = coo.getTranslation();
                      	
                      	for (int j=0;j<vsex.size();j++) {
                      		Prevodi pr = (Prevodi)vsex.get(j);
                      		
                      		if (pr.getSifra_jez().equals(codes.getLanguage())) {
                      			coo.setLang_text(pr.getPrevod());
                      			coo.setLanguage(codes.getLanguage());
                      			break;
                      		}
                      		
                      	}
                      	
                      	boolean foundd = false;
                      	boolean pogoj = false;
                      	if (codes.getLanguage()!=null && !codes.getLanguage().equals("")) {
                      		pogoj=true;
                      		if (coo.getLanguage()!=null && coo.getLanguage().equals(codes.getLanguage())) {
                      			foundd = true;
                      		}
                      		
                      	}
                      	if (codes.getLang_text()!=null && !codes.getLang_text().equals("")) {
                      		pogoj=true;
                      		if (coo.getLanguage()!=null && coo.getLang_text().toLowerCase().indexOf(codes.getLang_text().toLowerCase())!=-1) {
                      			foundd = true;
                      		}
                      		
                      	}
                      		if (foundd || !pogoj) {
                      		retu.add(coo);
                      		}
                      }
                      
                      
                      
                      
                      
                      
                      
                      
                     return retu;
                  }
              };
              
              
              
              
              List retu = new ArrayList();
              
              List limo = (List) getHibernateTemplate().execute(callback);
              
              
              for (int i=0;i<limo.size();i++) {

              	Codes coo = (Codes)limo.get(i);
              	
              	List vsex = coo.getTranslation();
              	
              	for (int j=0;j<vsex.size();j++) {
              		Prevodi pr = (Prevodi)vsex.get(j);
              		
              		if (pr.getSifra_jez().equals(codes.getLanguage())) {
              			coo.setLang_text(pr.getPrevod());
              			coo.setLanguage(codes.getLanguage());
              			break;
              		}
              		
              	}
              	
               	boolean foundd = false;
              	boolean pogoj = false;
              	if (codes.getLanguage()!=null && !codes.getLanguage().equals("")) {
              		pogoj=true;
              		if (coo.getLanguage()!=null && coo.getLanguage().equals(codes.getLanguage())) {
              			foundd = true;
              		}
              		
              	}
              	if (codes.getLang_text()!=null && !codes.getLang_text().equals("")) {
              		pogoj=true;
              		if (coo.getLanguage()!=null && coo.getLang_text().toLowerCase().indexOf(codes.getLang_text().toLowerCase())!=-1) {
              			foundd = true;
              		}
              		
              	}
              		if (foundd || !pogoj) {
              		retu.add(coo);
              		}
              }
              
              
              
              
              
              return retu ;
          }
      }
    public List getCodess2(final Codes codes,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from Codes");

          if (codes == null) {
              return getHibernateTemplate().find("from Codes");
          } else {
              // filter on properties set in the codes
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+codes.getSFT_SIFRA());
                  	Example ex = Example.create(codes).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(Codes.class).add(ex);
                   if (codes.getId()!=null) {
        	cri.add(Restrictions.eq("id",codes.getId()));
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
                      
                      List retu = new ArrayList();
                      
                      List limo = cri.list();
                      
                      
                      for (int i=0;i<limo.size();i++) {

                      	Codes coo = (Codes)limo.get(i);
                      	
                      	List vsex = coo.getTranslation();
                      	
                      	for (int j=0;j<vsex.size();j++) {
                      		Prevodi pr = (Prevodi)vsex.get(j);
                      		
                      		if (pr.getSifra_jez().equals(codes.getLanguage())) {
                      			coo.setLang_text(pr.getPrevod());
                      			coo.setLanguage(codes.getLanguage());
                      			break;
                      		}
                      		
                      	}
                      	
                      	boolean foundd = false;
                      	boolean pogoj = false;
                      	if (codes.getLanguage()!=null && !codes.getLanguage().equals("")) {
                      		pogoj=true;
                      		if (coo.getLanguage()!=null && coo.getLanguage().equals(codes.getLanguage())) {
                      			foundd = true;
                      		}
                      		
                      	}
                      	if (codes.getLang_text()!=null && !codes.getLang_text().equals("")) {
                      		pogoj=true;
                      		if (coo.getLanguage()!=null && coo.getLang_text().toLowerCase().indexOf(codes.getLang_text().toLowerCase())!=-1) {
                      			foundd = true;
                      		}
                      		
                      	}
                      		if (foundd || !pogoj) {
                      		retu.add(coo);
                      		}
                      }
                      
                      
                      
                      
                      
                      
                      
                      
                     return retu;
                  }
              };
              
              
         List retu = new ArrayList();
              
              List limo = (List) getHibernateTemplate().execute(callback);
              
              
              for (int i=0;i<limo.size();i++) {

              	Codes coo = (Codes)limo.get(i);
              	
              	List vsex = coo.getTranslation();
              	
              	for (int j=0;j<vsex.size();j++) {
              		Prevodi pr = (Prevodi)vsex.get(j);
              		
              		if (pr.getSifra_jez().equals(codes.getLanguage())) {
              			coo.setLang_text(pr.getPrevod());
              			coo.setLanguage(codes.getLanguage());
              			break;
              		}
              		
              	}
              	
               	boolean foundd = false;
              	boolean pogoj = false;
              	if (codes.getLanguage()!=null && !codes.getLanguage().equals("")) {
              		pogoj=true;
              		if (coo.getLanguage()!=null && coo.getLanguage().equals(codes.getLanguage())) {
              			foundd = true;
              		}
              		
              	}
              	if (codes.getLang_text()!=null && !codes.getLang_text().equals("")) {
              		pogoj=true;
              		if (coo.getLanguage()!=null && coo.getLang_text().toLowerCase().indexOf(codes.getLang_text().toLowerCase())!=-1) {
              			foundd = true;
              		}
              		
              	}
              		if (foundd || !pogoj) {
              		retu.add(coo);
              		}
              }
              
              
              return retu;
          }
      }

    /**
     * @see com.popultrade.dao.CodesDAO#getCodess(com.popultrade.model.Codes)
     */
    public List getCodess(final Codes codes) {
       if (codes == null) {
            return getHibernateTemplate().find("from Codes");
        } else {
            // filter on properties set in the codes
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(codes).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(Codes.class).add(ex);
if (codes.getId()!=null) {
                    cri.add(Restrictions.eq("id",codes.getId()));	
                    }
                return cri.list();
                }
            };
            
            
            List retu = new ArrayList();
            
            List limo = (List) getHibernateTemplate().execute(callback);
            
            
            for (int i=0;i<limo.size();i++) {

            	Codes coo = (Codes)limo.get(i);
            	
            	List vsex = coo.getTranslation();
            	
            	for (int j=0;j<vsex.size();j++) {
            		Prevodi pr = (Prevodi)vsex.get(j);
            		System.out.println("CODE LOOKFOR LANG --------------------- 1 ");
            		if (pr.getSifra_jez().equals(codes.getLanguage())) {
            			System.out.println("CODE LOOKFOR LANG --------------------- 2 found ");
            			coo.setLang_text(pr.getPrevod());
            			coo.setLanguage(codes.getLanguage());
            			break;
            		}
            		
            	}
            	
               	boolean foundd = false;
              	boolean pogoj = false;
              	if (codes.getLanguage()!=null && !codes.getLanguage().equals("")) {
              		pogoj=true;
              		if (coo.getLanguage()!=null && coo.getLanguage().equals(codes.getLanguage())) {
              			foundd = true;
              		}
              		
              	}
              	if (codes.getLang_text()!=null && !codes.getLang_text().equals("")) {
              		pogoj=true;
              		if (coo.getLanguage()!=null && coo.getLang_text().toLowerCase().indexOf(codes.getLang_text().toLowerCase())!=-1) {
              			foundd = true;
              		}
              		
              	}
              		if (foundd || !pogoj) {
              			
              			System.out.println("CODE ADDD --------------------- ");
              			
              		retu.add(coo);
              		}
            }
            
            
            return retu;
        }
    }

    /**
     * @see com.popultrade.dao.CodesDAO#getCodes(Long id)
     */
    public Codes getCodes(final Long id) {
        Codes codes = (Codes) getHibernateTemplate().get(Codes.class, id);
        if (codes == null) {
            log.warn("uh oh, codes with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Codes.class, id);
        }

        return codes;
    }

    /**
     * @see com.popultrade.dao.CodesDAO#saveCodes(Codes codes)
     */    
    public void saveCodes(final Codes codes) {
        getHibernateTemplate().saveOrUpdate(codes);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.CodesDAO#removeCodes(Long id)
     */
    public void removeCodes(final Long id) {
        getHibernateTemplate().delete(getCodes(id));
        getHibernateTemplate().flush();
    }
}
