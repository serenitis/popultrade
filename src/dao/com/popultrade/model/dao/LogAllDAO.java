package com.popultrade.model.dao;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
 import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Persistence;
import javax.persistence.EntityManagerFactory;
import com.popultrade.model.LogAll;
import com.popultrade.model.CreateLogFromClass;
public class LogAllDAO {
	
	
	
	
public LogAll getLogAll(String id,EntityManagerFactory emm) {
EntityManager em = emm.createEntityManager();
LogAll la = em.find(LogAll.class, id);
return la;
}

public void removeLogAll(String id,EntityManagerFactory emm) {

	
	EntityManager em = emm.createEntityManager();
	
	
	LogAll la = this.getLogAll(id, emm);
	
	la = em.merge(la);
	
	em.remove(la);

}



public boolean saveLogAll(LogAll la,EntityManagerFactory emm) {
try {
EntityManager em = emm.createEntityManager();

em.merge(la);

//em.persist(la);
return true;
}
catch (Exception exmo) {
exmo.printStackTrace();
}
return true;
}



public int getStLogAll(LogAll la,EntityManagerFactory emm) {
EntityManager em = emm.createEntityManager();
CreateLogFromClass clc = new CreateLogFromClass();
Object lis =em.createNativeQuery( "db.logall.count({"+clc.getSearchFromClass((Object)la)+"})" ).getSingleResult();
int vre = 0;
try {
vre = Integer.parseInt(lis.toString());
}
catch (Exception ecm) {
}
return vre;
}
public List<LogAll> getLogAlls(LogAll la,EntityManagerFactory emm,String orderb,final int pageNumber,final int pageSize) {
String orderk = "";
if (orderb!=null && !orderb.equals("")) {
orderb = orderb.replaceAll(" ", "");
if (orderb.indexOf(",")!=-1) {
String[] orde = orderb.split(",");
boolean nomk = false;
for (int k=0;k>orde.length;k++) {
if (!nomk) {
nomk=true;
}
else {
orderk += ",";
}
if (orde[k].endsWith("asc")) {
orderk += orde[k].replace("asc", ":1");
}
else if (orde[k].endsWith("desc")) {
orderk += orde[k].replace("desc", ":-1");
}
}
}
else {
if (orderb.endsWith("asc")) {
orderk += orderb.replace("asc", ":1");
}
else if (orderb.endsWith("desc")) {
orderk += orderb.replace("desc", ":-1");
}
}
orderk = ",$orderby:{"+orderk+"}";
}
	System.out.println(orderk);
EntityManager em = emm.createEntityManager();
CreateLogFromClass clc = new CreateLogFromClass();
List lis =em.createNativeQuery( "{$query:{"+clc.getSearchFromClass((Object)la)+"}"+orderk+"}",LogAll.class ).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).getResultList();
return lis;
}
 }
