<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.net.URLDecoder"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />


<%!


public String getColss(int colspa,boolean issubtask) {
	
	return "<td colspan="+colspa+" class='valuecell' "+(issubtask?" style='background-color:#f1f0f0'":"")+"  ></td>\r\n";
	
}


public String getLines(com.popultrade.webapp.chkNull nul,Calendar cal2,Date fromm, Date too,HttpServletRequest request,Date msx,Date tooprog,com.popultrade.dao.TaskDAO dao,String pogoj,boolean issubtask,com.popultrade.webapp.control control) {
	
	//" id_subtask="+idtask
	StringBuffer stb = new StringBuffer();
	com.popultrade.model.Task tasksub =new com.popultrade.model.Task();
	List subt = dao.getTasks(tasksub, 1, 1000, pogoj, "task_start", "asc");
			boolean stro=false;
			int colspan=0;
			int colspan2=0;
			String rek = "";
	if (subt.size()>0) {
		
		for (int hh=0;hh<subt.size();hh++) {
			
			System.out.println("*----------------------****");
			
			com.popultrade.model.Task tass = (com.popultrade.model.Task)subt.get(hh);
			System.out.println("*----------------------**** x1 ");
			 rek = 	this.getOverdo(nul,tass);
			 System.out.println("*----------------------**** x2");
			 stb.append("<tr class=\"opiscell2\" id=\"b_"+tass.getId()+"\"><td  class=\"opiscell\"  draggable=true id='dra_"+tass.getId() +"' onDragStart=\"sourceId=this.id\" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				
					 if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
					
			stb.append((issubtask?"&nbsp;&nbsp;&nbsp;":"")+"<a href=\"\" onclick=\"parent.frames[1].location='task_edit574.jsp?opcija=update&cal=Z&idt="+request.getParameter("idt")+"&id="+tass.getId() +"';return false;\" style=\"color:black;text-decoration:none\">");
					 }
			stb.append((issubtask?"<i>":"")+nul.jeN(tass.getTask_name()) +(issubtask?"</i>":""));
			if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
			 stb.append("</a>");
			}
					 stb.append("</td>");
		
			 stro = false;
			 colspan = 0;
			 colspan2= 0;
			cal2.setTime(fromm);
		while (cal2.getTimeInMillis()<=too.getTime()) { /// days
			if ((nul.jeN(tass.getIsmilestone()).equals("1") && tass.getTask_start().getTime()==cal2.getTime().getTime() ) || (tass.getTask_start().getTime()<=cal2.getTime().getTime() && (tass.getTask_end().getTime()+60000)>=cal2.getTimeInMillis())) {
				//stro = true;
				colspan++;
				
				if (!stro) {
					
					if (colspan2>0) {
						stb.append(getColss(colspan2,issubtask));
						colspan2=0;
					}
					
				stb.append("<td style='background:silver' ");
				if (tass.getTask_begin()==null) {
				stb.append(" draggable=true id='dra_"+tass.getId() +"' onDragStart='sourceId=this.id'  ");
				}
				}
				stro = true;
			
			}
			else {
				if (stro) {
					stro = false;
					
					stb.append("colspan='"+colspan +"'	 onclick=\"parent.frames[1].location='task_view593.jsp?id="+tass.getId() +"';return false;\"	>"+rek +"</td>");
					colspan=0;
				}
				if (nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(new Date(), "yyyy-MM-dd"))) {
					if (colspan2>0) {
						stb.append(getColss(colspan2,issubtask));
						colspan2=0;
					}
					stb.append("<td  style='background:yellow'  ></td>");
				//	System.out.println("YELLLLLLLLLLLLLLLLOOOOOOOOOOOOOOOOOOOOOOOOWWWWWWWWWWWWWWWWWWWWWWWWWW !");
				
				}
				else if (nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(msx, "yyyy-MM-dd"))) {
					if (colspan2>0) {
						stb.append(getColss(colspan2,issubtask));
						colspan2=0;
					}
					stb.append("<td  style='background:#03f319'  ></td>");
					
				}
				else if (nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(tooprog, "yyyy-MM-dd"))) {
					
					if (colspan2>0) {
						stb.append(getColss(colspan2,issubtask));
						colspan2=0;
					}
				
					stb.append("<td  style='background:#4083c7'  ></td>");
					
				}
				else {
					colspan2++;
				//	System.out.println("++++++++++++++++++++++++++++6666666666");
				
				}
			}
			cal2.add(Calendar.DAY_OF_MONTH, 1);
			}
		if (stro) {
			stro = false;
			stb.append("colspan='"+colspan +"' onclick=\"parent.frames[1].location='task_edit574.jsp?opcija=update&cal=Z&idt="+request.getParameter("idt")+"&id="+tass.getId() +"';return false;\"	>"+rek +"</td>\r\n");
			colspan=0;
		}
		
		if (colspan2>0) {
			stb.append(getColss(colspan2,issubtask));
			colspan2=0;
		//	System.out.println("*----------------------**** 77777777777777777b x3");
		}
		
		// System.out.println("*----------------------**** x3");
		
		 stb.append("</tr>\r\n");
		
		
			if (tass.getTask_begin()!=null && !nul.jeN(tass.getTask_state()).equals("6")) {
			
				stb.append("<tr class=\"opiscell2\"><td class=\"valuecell\" >&nbsp;</td>\r\n");
			
			/// real time spended
			cal2.setTime(fromm);
		while (cal2.getTimeInMillis()<=too.getTime() ) { /// days
			
		//	 System.out.println("*----------------------**** x4");
			Date fromco = new Date();

		if (tass.getTask_finish()!=null) {
			
			Calendar col = new GregorianCalendar();
			col.setTime(tass.getTask_finish());
			col.set(Calendar.HOUR, 0);
			col.set(Calendar.MINUTE, 0);
			col.set(Calendar.SECOND, 0);
			col.set(Calendar.HOUR_OF_DAY, 0);
			fromco = col.getTime();
			
		}

		Calendar col = new GregorianCalendar();
		col.setTime(tass.getTask_begin());
		col.set(Calendar.HOUR, 0);
		col.set(Calendar.MINUTE, 0);
		col.set(Calendar.SECOND, 0);
		col.set(Calendar.HOUR_OF_DAY, 0);

		
		if ((nul.getDatumFormatFromDate(col.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd"))) || 
				(nul.getDatumFormatFromDate(fromco, "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd"))) || 
				(col.getTime().getTime()<=cal2.getTime().getTime() && fromco.getTime()>=cal2.getTime().getTime())) {
				//stro = true;
	colspan++;

	if (!stro) {
		
		if (colspan2>0) {
			stb.append(getColss(colspan2,issubtask));
			colspan2=0;
		}
		
		
	stb.append("<td style='background:#e3e3e3' ");
	}
	stro=true;
			}
			else {
				if (stro) {
					stro = false;
					stb.append("colspan='"+colspan +"'	><div class='myDivIdsc'><div  class='contentsc'>&nbsp;</div><div class='progresssc' style='width:100%;background-color:#5390cf'>&nbsp;</div></div></td>\r\n");
					colspan=0;
				}
				
				if (nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(new Date(), "yyyy-MM-dd"))) {
					if (colspan2>0) {
						stb.append(getColss(colspan2,issubtask));
						colspan2=0;
					}
				//	System.out.println("YELLLLLLLLLLLLLLLLOOOOOOOOOOOOOOOOOOOOOOOOWWWWWWWWWWWWWWWWWWWWWWWWWW !");
					stb.append("<td  style='background:yellow'  ></td>");
					
				
				}
				else if (nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(msx, "yyyy-MM-dd"))) {
					if (colspan2>0) {
						stb.append(getColss(colspan2,issubtask));
						colspan2=0;
					}
					stb.append("<td  style='background:#03f319'  ></td>");
					
				}
				else if (nul.getDatumFormatFromDate(cal2.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(tooprog, "yyyy-MM-dd"))) {
					if (colspan2>0) {
						stb.append(getColss(colspan2,issubtask));
						colspan2=0;
					}
					stb.append("<td  style='background:#4083c7'  ></td>");
				
				}
				else {
				colspan2++;
//					stb.append("<td  class='valuecell' "+(issubtask?" style='background-color:#f1f0f0'":"")+"  ></td>\r\n");
			//	System.out.println("++++++++++++ !");
				}
			}
		//	System.out.println("*----------------------**** 333333");
			cal2.add(Calendar.DAY_OF_MONTH, 1);
			}
		if (stro) {
			stro = false;
			stb.append("colspan='"+colspan +"'	></td>"); 
			colspan=0;
		}
		
		
		if (colspan2>0) {
			stb.append(getColss(colspan2,issubtask));
			colspan2=0;
		}
		
		 
		stb.append("</tr>\r\n"); 
			
			
		}
		
			
			Calendar cul = new GregorianCalendar();
			 if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
		stb.append(this.getLines(nul, cul, fromm, too, request, msx, tooprog, dao, " id_subtask="+tass.getId(),true,control));
			 }
		
	}
	}
	
	
	
	
	
	
	return stb.toString();
	
	
	
	
	
	
	
	
	
}





/// get current progress
public Date maxDone(List lis,com.popultrade.webapp.chkNull nul,Date tocheck ) {
	
	
	Object[] progres = this.currentProgress(lis, nul, new Date());


	boolean doing = (boolean)progres[0];
	boolean finished = (boolean)progres[1];
	boolean todoo=(boolean)progres[2];
	Hashtable datumi = (Hashtable)progres[3];



	if (!todoo && doing) { // progress as planned
		
		
	}
	else if (todoo) { // progress is behind planned
		
		// get all behind
		Comparator compa = Collections.reverseOrder();
		List tmp = Collections.list(datumi.keys());
		Collections.sort(tmp,compa);
		
		Iterator itmo = tmp.iterator();
		
		while (itmo.hasNext()) {
			
			String datx = (String)itmo.next();
			
			Date tochk = nul.parseDatumUra(datx, "yyyyMMdd");
			System.out.println(":::::: "+tochk);
			if (tochk.getTime()<=tocheck.getTime()) {
				
				
				Object[] progresx = this.currentProgress(lis, nul, tochk);
				boolean doingx = (boolean)progresx[0];
				boolean finishedx = (boolean)progresx[1];
				boolean todoox=(boolean)progresx[2];
				
				System.out.println(":::::: "+finishedx+ " :: "+doingx+" :: "+todoox);
				if ((finishedx || doingx)  && !todoox) {
					return tochk;
				}
				
				
				
			}
			
			
		}
		
		
		
	}
	else if (finished) { // progress if ahead of planned
		// get all ahead
		Comparator compa = Collections.reverseOrder();
		List tmp = Collections.list(datumi.keys());
		Collections.sort(tmp,compa);
		
		Iterator itmo = tmp.iterator();
		
		while (itmo.hasNext()) {
			
			String datx = (String)itmo.next();
			
			Date tochk = nul.parseDatumUra(datx, "yyyyMMdd");
			System.out.println("::d:::: "+tochk);
			if (tochk.getTime()>tocheck.getTime()) {
				
				
				Object[] progresx = this.currentProgress(lis, nul, tochk);
				boolean doingx = (boolean)progresx[0];
				boolean finishedx = (boolean)progresx[1];
				boolean todoox=(boolean)progresx[2];
				
				
				if ((finishedx || doingx)  && !todoox) {
					return tochk;
				}
				
				
			}
			
			
		}
	}
	
	return null;
}

public Object[] currentProgress(List lis,com.popultrade.webapp.chkNull nul,Date tocheck ) {
	
	Hashtable rolem = new Hashtable();
	Calendar cols = new GregorianCalendar();
	cols.setTime(tocheck);
	cols.set(Calendar.HOUR, 0);
	cols.set(Calendar.MINUTE, 0);
	cols.set(Calendar.SECOND, 0);
	cols.set(Calendar.HOUR_OF_DAY, 0);
	/// check if is up to date
	boolean doing = false;
	boolean finished = false;
	boolean todoo=false;
	for (int i=0;i<lis.size();i++) {
		
		com.popultrade.model.Task tas = (com.popultrade.model.Task)lis.get(i);
		Date fromco = new Date();

		if (tas.getTask_finish()!=null) {
			
			Calendar col = new GregorianCalendar();
			col.setTime(tas.getTask_finish());
			col.set(Calendar.HOUR, 0);
			col.set(Calendar.MINUTE, 0);
			col.set(Calendar.SECOND, 0);
			col.set(Calendar.HOUR_OF_DAY, 0);
			fromco = col.getTime();
			
		//	System.out.println(nul.jeN(tas.getTask_name()) +"-- "+fromco+" ---- "+fromco.getTime() +" --------- "+col.getTime().getTime() +" ------- "+cal.getTime().getTime());
			
		}
	Calendar col = new GregorianCalendar();
	if (tas.getTask_begin()!=null) {
	col.setTime(tas.getTask_begin());
	col.set(Calendar.HOUR, 0);
	col.set(Calendar.MINUTE, 0);
	col.set(Calendar.SECOND, 0);
	col.set(Calendar.HOUR_OF_DAY, 0);
	}

if (nul.jeN(tas.getTask_state()).equals("4") || nul.jeN(tas.getTask_state()).equals("5")) {
	rolem.put(nul.getDatumFormatFromDate(tas.getTask_end(), "yyyyMMdd"), tas.getId());
}

	if (tas.getId_subtask()==null && !nul.jeN(tas.getTask_state()).equals("6")) {
		if (((nul.getDatumFormatFromDate(tas.getTask_start(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(cols.getTime(), "yyyy-MM-dd"))) || 
				(nul.getDatumFormatFromDate(tas.getTask_end(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(cols.getTime(), "yyyy-MM-dd"))) || 
				(tas.getTask_start().getTime()<=cols.getTime().getTime() && tas.getTask_end().getTime()>=cols.getTime().getTime()))  || 
				
				((tas.getTask_begin()==null && tas.getTask_start().getTime()<=cols.getTime().getTime()) || (tas.getTask_start().getTime()<=cols.getTime().getTime() && tas.getTask_finish()==null )  )
				
				) {
			
			if (nul.jeN(tas.getTask_state()).equals("4") || nul.jeN(tas.getTask_state()).equals("5")) {
				//System.out.println("XXXXXXXXXXXXXX "+i+" ::: "+tas.getTask_start());
				finished=true;
			}
			else if (nul.jeN(tas.getTask_state()).equals("1")) {
				todoo=true;
				
				System.out.println("XXXXXXXXXXXXXX on hold or todo "+i+" ::: "+tas.getTask_start());
				//break;
			}
			else if (nul.jeN(tas.getTask_state()).equals("2") || nul.jeN(tas.getTask_state()).equals("3") ) {
				doing=true;
				
				System.out.println("XXXXXXXXXXXXXX in development "+i+" ::: "+tas.getTask_start());
				//break;
			}
			
			
			
			
		}
	}
		
		
		
		
		
	}
	
	
	
	Object[] flok = new Object[4];
	System.out.println("::ff:::: "+finished+ " :: "+doing+" :: "+todoo);
	flok[0]=doing;
	flok[1]=finished;
	flok[2]=todoo;
	flok[3]=rolem;
	
	return flok;
	
}



/// get overdo
public String getOverdo(com.popultrade.webapp.chkNull nul,com.popultrade.model.Task vseb) {
	
	// progres bar
	String overd="";
	boolean overtime=false;
	boolean tostart =false;
	Long days;
	Long hours;
	int perc=0;
	Date noxx = new Date();

	if (!nul.jeN(vseb.getIsmilestone()).equals("1") && nul.jeN(vseb.getTask_state()).equals("1") && (noxx.getTime()<vseb.getTask_start().getTime() || noxx.getTime()>=vseb.getTask_start().getTime())) {
	days = (((vseb.getTask_start().getTime()- (new Date()).getTime())/(1000*60*60*24)));
	hours = (((vseb.getTask_start().getTime()- (new Date()).getTime())/(1000*60*60))%24) ;

	String predd = "";
	if (days==0 && hours<0) {
	predd ="-";
	}
	if (hours<0) {
	hours=hours*-1;
	}

	if (noxx.getTime()>=vseb.getTask_start().getTime()) {
	overd ="Overdo start: "+predd+days+" D "+ hours+" H ";
	}
	else {
	overd ="To start: "+predd+days+" D "+ hours+" H ";
	}
	tostart =true;
	}


	else if (!nul.jeN(vseb.getIsmilestone()).equals("1") && !nul.jeN(vseb.getTask_state()).equals("4") && !nul.jeN(vseb.getTask_state()).equals("5")) {


	Long tasb=(vseb.getTask_start()).getTime();
	if (noxx.getTime()>tasb || (vseb.getTask_begin()!=null && noxx.getTime()>(vseb.getTask_begin()).getTime())) {
	if (vseb.getTask_begin()!=null && vseb.getTask_begin().getTime()<(vseb.getTask_start()).getTime()) {
	tasb=vseb.getTask_begin().getTime();
	}
	
	perc =(int) (((noxx.getTime()-(tasb))*100)/((vseb.getTask_end()).getTime()-tasb));
	
	if (perc>100) {
	days = (((vseb.getTask_end().getTime()- (new Date()).getTime())/(1000*60*60*24)));
	hours = (((vseb.getTask_end().getTime()- (new Date()).getTime())/(1000*60*60))%24) ;
	String predd = "";
	if (days==0 && hours<0) {
	predd ="-";
	}
	if (hours<0) {
	hours=hours*-1;
	}



	overd =predd+" "+days+" D "+ hours+" H ";
	}
	}
	}

	else if (!nul.jeN(vseb.getIsmilestone()).equals("1") && (nul.jeN(vseb.getTask_state()).equals("4") || nul.jeN(vseb.getTask_state()).equals("5"))) {


if (vseb.getTask_finish()!=null) {
days = (((vseb.getTask_finish().getTime()- (vseb.getTask_end()).getTime())/(1000*60*60*24)));
hours = (((vseb.getTask_finish().getTime()- (vseb.getTask_end()).getTime())/(1000*60*60))%24) ;

String predd = "";
if (days==0 && hours<0) {
predd ="-";
}
if (hours<0) {
hours=hours*-1;
}

if (days>0 && hours>0) {
overd = "+" + days+" D "+ hours+" H ";
}
else {
overd =predd+" "+  days+" D "+ hours+" H ";
overtime = true;
}
if (nul.jeN(vseb.getTask_state()).equals("5")) {
	overd="Cancelled: "+overd;
}
else {
overd="Finish: "+overd;
}
}
else {
overd="Cancelled";
}


	}

String yum  = "";
if	(!nul.jeN(vseb.getIsmilestone()).equals("1") && perc<=100 && perc>0) {
	yum = "<div class='myDivIdsc' title='"+perc+"%'><div  class='contentsc'>&nbsp;</div><div class='progresssc' "+(perc<100?"style='width:"+perc+"%'":"")+">"+perc+" % </div></div> ";
	
}
else if ((!nul.jeN(vseb.getIsmilestone()).equals("1") && perc>100)) {
	
	yum = "<div class='myDivIdsc' title='"+overd+"'><div  class='contentsc'>&nbsp;</div><div class='progresssc' style='width:100%;color:#e2aaaa'>"+overd+" &nbsp;</div></div> ";
}
else if ((!nul.jeN(vseb.getIsmilestone()).equals("1") && perc==0)) {
	yum = "<div class='myDivIdsc' title='"+overd+"'><div  class='contentsc'>&nbsp;</div><div class='progresssc' style='width:100%;color:"+(tostart?"#f7f7f7":"#f7f7f7")+"'>"+overd+" &nbsp;</div></div> ";
}
	

return yum;

	
	
}



private Date setDateTo00(Date dotu) {
	
	Calendar calo = new GregorianCalendar();
	calo.setTime(dotu);
	
	calo.set(Calendar.HOUR, 0);
	calo.set(Calendar.MINUTE, 0);
	calo.set(Calendar.SECOND, 0);
	calo.set(Calendar.HOUR_OF_DAY, 0);
	return calo.getTime();
}

private Date getExactDate(Date stdate,com.popultrade.webapp.chkNull nul) {
	
	if (nul.getDatumFormatFromDate(stdate, "HH").equals("23")) {
		Calendar calf = new GregorianCalendar();
		calf.setTime(stdate);
		calf.add(Calendar.HOUR, 1);
		stdate = calf.getTime();
	}
	else if (nul.getDatumFormatFromDate(stdate, "HH").equals("01")) {
		Calendar calf = new GregorianCalendar();
		calf.setTime(stdate);
		calf.add(Calendar.HOUR, -1);
		stdate = calf.getTime();
	}
	return stdate;
	
}

%>




<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%
}
%>

<%
// stevilo prikazov vrstic
int stpri = control.st_vrstic;

int stej = 0;
String[] colors = {"plava1","plava2","silver"};
int stvrstic=0;
boolean iskanje=false;
boolean lahkobrise=true;
try {
	// move date for selected drag
	
	if (request.getParameter("akcijaXY")!=null && request.getParameter("akcijaXY").equals("MOVE"))  {
		
		com.popultrade.dao.TaskDAO dao = (com.popultrade.dao.TaskDAO)contextUtil.getBeanDao("taskDAO",pageContext.getServletContext());
		com.popultrade.model.Task taskk = dao.getTask(new Long(request.getParameter("idrt")));
		
		Date flok =nul.parseDatumUra(request.getParameter("datx"), "dd-MM-yyyy");
		
		if (taskk.getTask_end()!=null) {
		Long zace =flok.getTime()- taskk.getTask_start().getTime();
		//	Long twodat = taskk.getTask_end().getTime()+zace;
			Date stdate = new Date(taskk.getTask_end().getTime()+zace);
			Date nee =getExactDate(stdate,nul);
			
		taskk.setTask_end(nee);
		
		}
		
		taskk.setTask_start(flok);
		
		dao.saveTask(taskk);

	}
	
	
	// move all task to new date
	
		if (request.getParameter("akcijaXY")!=null && request.getParameter("akcijaXY").equals("MOVEALL"))  {
		
		com.popultrade.dao.TaskDAO dao = (com.popultrade.dao.TaskDAO)contextUtil.getBeanDao("taskDAO",pageContext.getServletContext());
		com.popultrade.model.Task taskk = dao.getTask(new Long(request.getParameter("idrt")));
		
		
		com.popultrade.model.Task tasky = new com.popultrade.model.Task();
		tasky.setTask_start1(taskk.getTask_start());
		tasky.setId_job(new Long(request.getParameter("idt")));
		
		
		
		
		
		Date flok =nul.parseDatumUra(request.getParameter("datx"), "dd-MM-yyyy");
		long zace =flok.getTime()- taskk.getTask_start().getTime();
		
		
		// if cant be divided by days add a day
		/*
		int modu = ((int)zace/(1000*60*60))%(24);
		System.out.println("::::::::::::::::::::: ++++ "+modu);
		System.out.println("::::::::::::::::::::: ++++ "+modu);
		System.out.println("::::::::::::::::::::: ++++ "+modu);
		System.out.println("::::::::::::::::::::: ++++ "+modu);
		if (modu!=0) { // add hour
			
			//zace += 1000*60*60;
			System.out.println("::::::::::::::::::::: ++::++ "+zace);
		}
		
		*/
		// move only grouped
		
		String dodpog = "";
		
		if (!nul.jeN(request.getParameter("choic")).equals("") ) {
			dodpog = " and id_task="+request.getParameter("choic")+"";
		}
		if (!nul.jeN(request.getParameter("choic")).equals("") && nul.jeN(request.getParameter("choic")).equals(nul.jeN(request.getParameter("idrt"))) ) {
			dodpog = " and (id_task="+request.getParameter("choic")+" or {alias}.id="+request.getParameter("idrt")+")";
		}
		
		
		List allk = dao.getTasks(tasky, 1, 10000, " task_begin is null "+dodpog, "", "");
		
		
		for (int v=0;v<allk.size();v++) {
			
			com.popultrade.model.Task taso = (com.popultrade.model.Task)allk.get(v);
			Date stdate = new Date(taso.getTask_start().getTime()+zace);
			
			
			taso.setTask_start(getExactDate(stdate,nul));
			
			if (taso.getTask_end()!=null) {
				taso.setTask_end(getExactDate(new Date(taso.getTask_end().getTime()+zace),nul));
			}
			dao.saveTask(taso);
			
		}
		
		
	

	}
	
	
	
	
	
com.popultrade.dao.TaskDAO dao = (com.popultrade.dao.TaskDAO)contextUtil.getBeanDao("taskDAO",pageContext.getServletContext());
com.popultrade.dao.JobDAO daoj = (com.popultrade.dao.JobDAO)contextUtil.getBeanDao("jobDAO",pageContext.getServletContext());

com.popultrade.model.Job job = new com.popultrade.model.Job();





if (request.getParameter("akcijaXY")!=null && request.getParameter("akcijaXY").equals("DELETE"))  {
//if (lahkobrise){
try {
dao.removeTask(new Long(request.getParameter("idrt")));
//prisotnost.addUserNarocilo(control.idUporabnikaLock,request.getParameter("id")+"",new Date(),6,"Task",control.getUserName(),"","Task_list565");
}catch (Exception ec){
	System.out.println("ERROR DELETE "+ec.toString());
}
//} 
}
int pagenum=1;
int stizpisov=stpri;

String stolpci ="";
String orderby = "";
if (!nul.jeNull(request.getParameter("orderup")).equals("")) {
orderby = request.getParameter("orderup");
}
String orderbysmer = "";
if (!nul.jeNull(request.getParameter("orderupsmer")).equals("")) {
orderbysmer =request.getParameter("orderupsmer");
}
String dodpog =""; //" (id_task is null ) ";
com.popultrade.model.Task sif = new com.popultrade.model.Task();
sif.setId_job(new Long(request.getParameter("idt")+""));
String dodaten_sql_pogoj = dodpog;
String sedodatno = "";
String metodo = "";
if (nul.jeNull(request.getParameter("isci")).equals("yes")) {
iskanje = true;
if (!sedodatno.equals("")) {
if (sedodatno.endsWith("and ")) {
sedodatno= sedodatno.substring(0,sedodatno.lastIndexOf("and "));
}
}
dodaten_sql_pogoj += (!dodaten_sql_pogoj.equals("")?(sedodatno.equals("")?"":" and "):"")+ sedodatno;
if (!nul.jeNull(request.getParameter("additional_task")).equals("")) {
sif.setAdditional_task(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("additional_task")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("billable")).equals("")) {
sif.setBillable(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("billable")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("estimated_time")).equals("")) {
sif.setEstimated_time(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("estimated_time")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("id")).equals("")) {
sif.setId(new Long(control.trimLeftRight(nul.jeNull(request.getParameter("id")))));
}
if (!nul.jeNull(request.getParameter("id_job")).equals("")) {
sif.setId_job(new Long(control.trimLeftRight(nul.jeNull(request.getParameter("id_job")))));
}
if (!nul.jeNull(request.getParameter("id_owner")).equals("")) {
sif.setId_owner(new Long(control.trimLeftRight(nul.jeNull(request.getParameter("id_owner")))));
}
if (!nul.jeNull(request.getParameter("id_task")).equals("")) {
sif.setId_task(new Long(control.trimLeftRight(nul.jeNull(request.getParameter("id_task")))));
}
if (!nul.jeNull(request.getParameter("id_worker")).equals("")) {
sif.setId_worker(new Long(control.trimLeftRight(nul.jeNull(request.getParameter("id_worker")))));
}
if (!nul.jeNull(request.getParameter("label")).equals("")) {
sif.setLabel(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("label")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("task")).equals("")) {
sif.setTask(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("task")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("task_description")).equals("")) {
sif.setTask_description(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("task_description")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("task_name")).equals("")) {
sif.setTask_name(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("task_name")))+"", "UTF-8"));
}
session.setAttribute("task_search",sif);
}
else if (nul.jeNull(request.getParameter("isk")).equals("1")) {
iskanje = true;
sif = (com.popultrade.model.Task)session.getAttribute("task_search");
}
else {
session.removeAttribute("task_search");
}
List lis =null;
lis = dao.getTasks(sif,1,20000,dodaten_sql_pogoj+"  id_subtask is null","","");
int strec = lis.size();
lis = dao.getTasks(sif,pagenum,stizpisov,dodaten_sql_pogoj+"  id_subtask is null","task_start asc,id asc","asc");
System.out.println("*----------------------**** 01");
job = daoj.getJob(new Long(request.getParameter("idt")));


/// get real time from/to if tasks takes more time than planned

Date fromm = job.getDuration_from();
Date too = job.getDuration_to();
Date tooprog = job.getDuration_to();
Date fromprog = job.getDuration_from();
//System.out.println("*----------------------**** 02"+fromm + " ::: "+too);

boolean nikoncano = false;
for (int i=0;i<lis.size();i++) {
	
	com.popultrade.model.Task tass = (com.popultrade.model.Task)lis.get(i);
	//System.out.println("*----------------------**** 03");
	if (!nul.jeNull(tass.getIsmilestone()).equals("1")) {
	//	System.out.println("*----------------------**** 03 1");
		
	if (tass.getTask_start()!=null && tass.getTask_start().getTime()<fromm.getTime()) {
		fromm = tass.getTask_start();
	}
	//System.out.println("*----------------------**** 03 2");
	if (tass.getTask_end()!=null && tass.getTask_end().getTime()>too.getTime()) {
		too = tass.getTask_end();
	}
	//System.out.println("*----------------------**** 04 ff "+tass.getTask_begin());
	if (tass.getTask_begin()!=null && setDateTo00(tass.getTask_begin()).getTime()<fromm.getTime()) {
		fromm = setDateTo00(tass.getTask_begin());
	
	}
	if (tass.getTask_finish()!=null && setDateTo00(tass.getTask_finish()).getTime()>too.getTime()) {
		too = setDateTo00(tass.getTask_finish());
	}
	
	}
	
	if (nul.jeN(tass.getTask_state()).equals("1") || nul.jeN(tass.getTask_state()).equals("2") || nul.jeN(tass.getTask_state()).equals("3") ) {
		nikoncano = true;
	}
//	System.out.println("*----------------------**** 04");
	
}

/// add 7 days so it looks nicer

fromm = nul.addDaysToDate(fromm, -7);

too = nul.addDaysToDate(too, 7);

System.out.println("*----------------------**** 04 "+fromm);


if (nikoncano && too.getTime()<(new Date()).getTime()) {
	
	Calendar comd = new GregorianCalendar();
	comd.setTime(new Date());
	comd.add(Calendar.DAY_OF_MONTH, 10);
	
	too = comd.getTime();
	
}




/// get current progress
//Date current = new Date();

Date msx=null;
if (true) {


	 msx = maxDone(lis,nul,new Date());

	System.out.println("*CURRENT ------------ "+msx);

}
System.out.println("*----------------------**** 05");

%>
<%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<html><head><title></title></head>
<style>
body {
overflow-x:show;
}
A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>
<link type='text/css' href='styles/basic.css' rel='stylesheet' media='screen' />
<link type='text/css' href='styles/basic_ie.css' rel='stylesheet' media='screen' />
<style type=text/css>
@import "barveold.css";
@import "tooltipcss.css";
@import "ccss/custom.css";
@import "js/jquery.contextmenu.css";
@import "css_dat/bigbuttons.css";
@import "css_dat/new_list.css";
</style>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="scripts/jquery.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="js/jquery.contextmenu.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="js/jquery.blockUI.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type='text/javascript' src='js/jquery.simplemodal.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script type='text/javascript' src='js/basic.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>

<script language=javascript>
function vprasaj2(alerto,resett,iddd,sem) {
  var a = window.confirm(alerto);
 if (a==true) {
 if (resett=='1') {
   document.getElementById("res"+iddd).innerHTML='';
 if (sem!='' && sem!=null && sem!=undefined) {
 document.location = sem;	
   return false;
 }
  }
   return true;
  }
 else {
   return false;
}
}
function vprasaj(alerto,resett,iddd) {
  var a = window.confirm(alerto);
 if (a==true) {
 if (resett=='1') {
   document.getElementById("res"+iddd).innerHTML='';
  }
   return true;
  }
 else {
   return false;
}
}




function chg() {
	
	parent.frames[1].document.location='nic.jsp';
	
 <%
if (request.getParameter("idback")!=null && !request.getParameter("idback").equals("null") && !request.getParameter("idback").equals("")) {
%>
//kliknivSivo(document.getElementById("spr<%=request.getParameter("idback")%>"),document.getElementById("spr<%=request.getParameter("idback")%>").className);
//window.scroll(1,document.getElementById("spr<%=request.getParameter("idback")%>").offsetTop-15);
<%
}
%>
 <%
if (request.getParameter("idomko")!=null && !request.getParameter("idomko").equals("null") && !request.getParameter("idomko").equals("")) {
if (session.getAttribute("idomko")==null || !session.getAttribute("idomko").toString().equals(request.getParameter("idomko"))) {
session.setAttribute("idomko",request.getParameter("idomko"));
%>
parent.frames[1].document.location='task_edit574.jsp?id=<%=request.getParameter("idomko")%>';
<%
}
}
String requri = nul.jeNull(request.getRequestURI());
if (requri.indexOf("/")!=-1) {
requri = requri.substring(requri.lastIndexOf("/")+1,requri.length());
}
if (control.getFrames().containsKey(requri)) {
com.popultrade.webapp.FrameSizeClass fss = (com.popultrade.webapp.FrameSizeClass)control.getFrames().get(requri);
%>
top.setSize(<%=fss.getFrame1()%>,<%=fss.getFrame2()%>,<%=fss.getFrame3()%>);
<%
}
%>


/// clone first column
var $target = $("#movet");
$(".opiscell2").each(function() {
//	alert(1);
    var $tds = $(this).children(),
        $row = $("<tr></tr>");
    $row.append($tds.eq(0).clone()).appendTo($target);
});
var $target2 = $("#movet2");
$(".smole").each(function() {
//	alert(1);
    var $tds = $(this).children(),
        $row = $("<thead></thead>");
    $row.append($tds.clone()).appendTo($target2);
    
  //  $('#movet2').clone().insertAfter(".smallBox");
    
});

$(window).scroll(function(){
	  $('#movet').css('top',-$(window).scrollTop());
	  $('#movet2').css('left',-$(window).scrollLeft());
	});

document.body.onmouseup = function (e) {
	  // Get IE event object
	  e = e || window.event;
	  // Get target in W3C browsers & IE
	  var elementId = e.target ? e.target.id : e.srcElement.id;
	  //alert(elementId);
	  
	  if (elementId.indexOf("dm_")!=-1) { /// add new task
	  
		//  alert(elementId);
		//  alert(document.getElementById(elementId).getAttribute("datum"));

		  // open new task window
		  
		  var tocc = getChecked();
		 
		  if (tocc!="") {
			  tocc= "&idg="+tocc;
		  }
		  
		  parent.frames[1].location='task_edit574.jsp?opcija=new&cal=x&idt=<%=request.getParameter("idt")%>&dak1='+datfro+'&dak2='+document.getElementById(elementId).getAttribute("datum")+'&idem3=null'+tocc;
		  
	  }
	  
	  var allElements = document.getElementsByTagName("*");
	  document.getElementById("tip").style.display='none';
	  for (var i = 0, n = allElements.length; i < n; ++i) {
	    var el = allElements[i];
	    if (el.id) { 
	    	if (el.id.indexOf("dm_")!=-1) {
	    	document.getElementById(el.id).style.background='#e7eef6';
	    	}
	    }
	  }
	  sourcer="";
	  moused=0;
	}


// move scroll to selected location

<%
if (!nul.jeN(session.getAttribute("idbackk")+"").equals("")) {
	%>
	$('html, body').animate({
        scrollTop: $("#b_<%=session.getAttribute("idbackk")%>").offset().top-75}, 500);
	<%
	session.setAttribute("idbackk","");
}
else if (request.getParameter("datx")!=null) {
	
	%>
	$('html, body').animate({
        scrollTop: $("#b_<%=request.getParameter("idrt")%>").offset().top-75}, 500);
	<%
	
}
%>



}

moused=0;
var datfro = "";
var sourcer;
function rangeA(sourcee) {
	
	sourcer=sourcee.id;
	moused=1;
	datfro = sourcee.getAttribute("datum");
	document.getElementById(sourcer).style.background='red';
}

function highlight(somer,e) {
	

	 
	 
	 
	
	if (sourcer!=null && moused==1) {
		
		
		  var allElements = document.getElementsByTagName("*");
			
		  for (var i = 0, n = allElements.length; i < n; ++i) {
		    var el = allElements[i];
		    if (el.id) { 
		    	if (el.id.indexOf("dm_")!=-1) {
		    	document.getElementById(el.id).style.background='#e7eef6';
		    	}
		    }
		  }
		
	var zace=	Number(sourcer.substring(3));
	var konc = Number(somer.id.substring(3));
	
	if (konc>=zace) {
		
		for (var m=konc;m>=zace;m--) {
			
			document.getElementById("dm_"+m).style.background='red';
			
			
		}
		
		
	}
	
	
	 var x = (e.clientX + 20+$(window).scrollLeft()) + 'px',
     y = (e.clientY + 20+$(window).scrollTop()) + 'px';
	
	document.getElementById("tip").style.top=y;
	document.getElementById("tip").style.left=x;
	document.getElementById("tip").style.display='block';
	
	document.getElementById("tip").innerHTML=konc-zace+1 ;
	}
	
	
	
}
// deselect other checkboxes
function deselect(boxx) {
	var myForm = document.getElementById("dod");
    //Extract Each Element Value
    for (var i = 0; i < myForm.elements.length; i++) {
    if (myForm.elements[i].id.indexOf("cb_")!=-1) {
    	
    	//document.getElementById(myForm.elements[i].id).checked=false;	
    	if ((boxx.id+"")!=(myForm.elements[i].id+"")) {
    		//alert(boxx.id +" :: :: "+ myForm.elements[i].id);
    		document.getElementById(myForm.elements[i].id).checked=false;	
    	}
    	
    	
    }
    
    
    
    }
}


//get selected cb
function getChecked(boxx) {
	var myForm = document.getElementById("dod");
    //Extract Each Element Value
    for (var i = 0; i < myForm.elements.length; i++) {
    if (myForm.elements[i].id.indexOf("cb_")!=-1) {
    	
    	//document.getElementById(myForm.elements[i].id).checked=false;	
    	if (document.getElementById(myForm.elements[i].id).checked) {
    		//alert(boxx.id +" :: :: "+ myForm.elements[i].id);
    		return myForm.elements[i].id.substring(3);
    	}
    	
    	
    }
    
    
    
    }
    
    return "";
}

var sourceId="";




function allowDropX(ev) {
    ev.preventDefault();
}
function dropX(ev) {
    ev.preventDefault();
   // alert(ev.srcElement.id);
//alert(parent.frames[0].sourceId);
var okk = confirm("Please confirm deletion.");

if (okk) {
document.location = 'tasks_calendar.jsp?idt=<%=request.getParameter("idt")%>&akcijaXY=DELETE&idrt='+sourceId.substring(4);
}
//  alert(sourceId);// ev.srcElement.id;
}



function allowDropX2(ev) {
    ev.preventDefault();
}
function dropX2(ev,obje) {
    ev.preventDefault();
    
    
    var choi = getChecked();
    var alle = "Please confirm date change for all following tasks.";
    if (choi!="") {
    	alle = "Please confirm date change for all following tasks in selected group.";
    }
    
var okk = confirm(alle+"");

if (okk) {
document.location = 'tasks_calendar.jsp?idt=<%=request.getParameter("idt")%>&choic='+choi+'&akcijaXY=MOVEALL&idrt='+sourceId.substring(4)+"&datx="+obje.getAttribute("datum");
}
}


function allowDropX3(ev) {
    ev.preventDefault();
}
function dropX3(ev,obje) {
    ev.preventDefault();

    
    var okk = confirm("Please confirm date change for the dragged task.");

if (okk) {
document.location = 'tasks_calendar.jsp?idt=<%=request.getParameter("idt")%>&akcijaXY=MOVE&idrt='+sourceId.substring(4)+"&datx="+obje.getAttribute("datum");
}
}


</script>
<%}%>

<%
Hashtable sifhint=new Hashtable();
Hashtable sifhintp=new Hashtable();
%>


<body   style="margin: 0"  background="podlaga.jpg" bgproperties="fixed"     onLoad="chg();" >

<div id="tip" style="position:absolute;display: none;border-radius: 5px 15px 10px;background: #e3e3e3;z-index:8035; padding: 5px;border: 3px solid #c0c0c0">ASD</div>

<table id="movet0" cellspacing=1  class="fontilist"  style="position:fixed; z-index:8055;float: left; width:290px;">
 <thead><tr><td  class='theaderhint1' align=right>Date:&nbsp;</td></tr>
 <tr><td class="opiscell" align=right>
 <div style="float:left"><b><a href="" onclick="parent.frames[1].location='job_view224.jsp?id=<%=request.getParameter("idt")%>';return false;" style="text-decoration:none;color:black"><%=nul.jeNull(job.getTitle()) %></a></b></div>
 Days:&nbsp;</td></tr> 
  <%
 if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
 %>
 <tr><td class="opiscell" align=right>
 
 

 <a href="" class='btnblueb'  onclick="parent.frames[1].location='task_edit574.jsp?opcija=new&cal=x&idt=<%=request.getParameter("idt")%>';return false;" style='float:left'> NEW TASK </a>&nbsp;&nbsp;&nbsp;&nbsp; 
 <a href="" class='btnblueb'  onclick="parent.frames[1].location='job_edit198.jsp?opcija=update&cal=x&id=<%=request.getParameter("idt")%>';return false;" style='float:left'> JOB </a> 
 
 <div id=rem title="Drag here to remove" style="background-color:red;float:left;padding:3px;color:white;border-radius:3px"  ondrop="dropX(event)" ondragover="allowDropX(event)"> REMOVE </div> 

 Selectiotn:&nbsp;</td></tr>
  <%
 }
 %>
 
 
 </thead>
 
 
 
</table>


<table id="movet" cellspacing=1  class="fontilist"  style="position:fixed;float: left; width:290px; z-index:8050">
 <thead><tr><td  class='theaderhint1' align=right>&nbsp;</td></tr>
  <tr><td class="opiscell" align=right>&nbsp;</td></tr>
   <%
 if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
 %>
 <tr><td class="opiscell" align=right>&nbsp;</td></tr>
   <%
 }
 %>
 </thead>
 
</table>

<table id="movet2" cellspacing=1  class="fontilist"  style="position:fixed;float: left; z-index:8000;table-layout:fixed; z-index:8045">

</table>


<form name=dod id=dod action="">
<table  cellspacing=1 id='ftable'  class="fontilist" style="table-layout:fixed;" >
<thead class='smole'>
<tr class='fakec' ><td colspan=1  class='theaderhint1' aline=right><div style='width:290px'>&nbsp;</div></td><%
/// create date line

Calendar cal = new GregorianCalendar();
cal.setTime(fromm);

int stejj = 0;
int monthp=-1;
boolean prvi=true;
int month=0;
int yearr = 0;
while (cal.getTimeInMillis()<=too.getTime()) { /// months
month=	cal.get(Calendar.MONTH);
if (prvi) {
	monthp=month;
	yearr = cal.get(Calendar.YEAR);
	prvi=false;
}

if (month!=monthp) {

	%><td colspan='<%=stejj %>'  class='theaderhint1'><%=monthp+1 %>/<%=yearr %></td><%
	stejj=0;
	monthp=month;
	yearr = cal.get(Calendar.YEAR);
}
stejj++;
cal.add(Calendar.DAY_OF_MONTH, 1);
}

if (!prvi && stejj>=1) {
	yearr = cal.get(Calendar.YEAR);
	%><td colspan='<%=stejj %>'   class='theaderhint1'><%=monthp+1 %>/<%=yearr %></td><%
	
}

%></tr><tr class='fakec' ><td style='width:290px' class="opiscell" align=right>&nbsp;</td><%
cal.setTime(fromm);
Date danes = new Date();

while (cal.getTimeInMillis()<=too.getTime()) { /// days

	
	if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(danes, "yyyy-MM-dd"))) {
		%><td class="valuecell" style=" background-color:yellow" datum="<%=nul.getDatumFormatFromDate(cal.getTime(), "dd-MM-yyyy") %>"  ondrop="dropX2(event,this)" ondragover="allowDropX2(event)"><div  style='width:13px;border-collapse: collapse; font-family: Verdana; font-size: 7pt; background-color:yellow' ><%=cal.get(Calendar.DAY_OF_MONTH) %></div></td><%
	
	}
	else if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(msx, "yyyy-MM-dd"))) {
		%><td class="valuecell" style=" background-color:#03f319"  datum="<%=nul.getDatumFormatFromDate(cal.getTime(), "dd-MM-yyyy") %>"  ondrop="dropX2(event,this)" ondragover="allowDropX2(event)"><div  style='width:13px;border-collapse: collapse; font-family: Verdana; font-size: 7pt; background-color:#03f319' ><%=cal.get(Calendar.DAY_OF_MONTH) %></div></td><%
	}
	else if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(tooprog, "yyyy-MM-dd"))) {
		%><td class="valuecell" style=" background-color:#4083c7"  datum="<%=nul.getDatumFormatFromDate(cal.getTime(), "dd-MM-yyyy") %>"  ondrop="dropX2(event,this)" ondragover="allowDropX2(event)"><div  style='width:13px;border-collapse: collapse; font-family: Verdana; font-size: 7pt; background-color:#4083c7' ><%=cal.get(Calendar.DAY_OF_MONTH) %></div></td><%
	}
	else {
		
		String dayo = "";
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
        if (dayOfWeek == Calendar.SUNDAY) {
        	dayo = "background-color:#cecece";
        }
        else if (dayOfWeek == Calendar.SATURDAY) {
        	dayo = "background-color:#e1e1e1";
        }
	%><td class="valuecell" style="<%=dayo%>"  datum="<%=nul.getDatumFormatFromDate(cal.getTime(), "dd-MM-yyyy") %>"   ondrop="dropX2(event,this)" ondragover="allowDropX2(event)"><div style='width:13px;border-collapse: collapse; font-family: Verdana; font-size: 7pt' ><%=cal.get(Calendar.DAY_OF_MONTH) %></div></td><%
	}
	%>
	
	
	
	<%

cal.add(Calendar.DAY_OF_MONTH, 1);
}

if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
%>
</tr><tr class='fakec' ><td style='width:290px' class="opiscell" align=right> &nbsp;</td><%
cal.setTime(fromm);

int stemo = 0;
while (cal.getTimeInMillis()<=too.getTime()) { /// days

	stemo++;

	%><td class="valuecell"   ondrop="dropX3(event,this)" ondragover="allowDropX3(event)" style="background-color:#e7eef6" onmouseover="highlight(this,event)"  datum="<%=(cal.get(Calendar.DAY_OF_MONTH)<9?"0"+(cal.get(Calendar.DAY_OF_MONTH)):cal.get(Calendar.DAY_OF_MONTH)) %>-<%=(cal.get(Calendar.MONTH)<9?"0"+(cal.get(Calendar.MONTH)+1):cal.get(Calendar.MONTH)) %>-<%=cal.get(Calendar.YEAR) %>" onmousedown="rangeA(this)" id="dm_<%=stemo %>" ></td><%

cal.add(Calendar.DAY_OF_MONTH, 1);
}

%></tr>

<%
}
%>


</thead>
<tbody>
<%
/// tasks
//System.out.println("*----------------------**** 0");

for (int h=0;h<lis.size();h++) {
	//System.out.println("*----------------------**** xxx "+h);
	com.popultrade.model.Task tas = (com.popultrade.model.Task)lis.get(h);
	if (tas.getId_task()==null) {
	//System.out.println("*----------------------**** 1");
	
	%>
	<tr class="opiscell2"  id="b_<%=tas.getId()%>"><td class="opiscell"  draggable=true id='dra_<%=tas.getId() %>' onDragStart="sourceId=this.id"  >
	 <%
 if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
 %>
	<%if (nul.jeN(tas.getTask_state()).equals("6")) { %><input type='checkbox'   <%=(nul.jeN(session.getAttribute("checkbox")+"").equals(tas.getId()+"")?"checked":"") %>  onclick="deselect(this)"  id="cb_<%=tas.getId()%>" value="1"><%}%><b><a href="" onclick="parent.frames[1].location='task_edit574.jsp?opcija=update&cal=Z&idt=<%=request.getParameter("idt")%>&id=<%=tas.getId() %>';return false;" style="color:black;text-decoration:none">
	<%
	}
	%>
	<%=nul.jeN(tas.getTask_name()) %>
	 <%
 if (nul.jeN(control.getParameter02()).equals("1") || nul.jeN(control.getParameter03()).equals("1") ) {
 %>
	</a>
	<%
 }
	%>
	</b></td>
	<%
	cal.setTime(fromm);
	boolean stro = false;
	int colspan = 0;
	int colspan2=0;

String rek = 	this.getOverdo(nul,tas);
	
while (cal.getTimeInMillis()<=too.getTime()) { /// days
	if ((nul.jeN(tas.getIsmilestone()).equals("1") && tas.getTask_start().getTime()==cal.getTime().getTime() ) || (tas.getTask_start().getTime()<=cal.getTime().getTime() && (tas.getTask_end().getTime()+60000)>=cal.getTimeInMillis())) {
	
	colspan++;
	if (!stro) {
		
		if (colspan2>0) {
			%><%=getColss(colspan2,false)%><%
			colspan2=0;
		}
		
	%><td style='background:silver'  <%if (tas.getTask_begin()==null) { %>  draggable=true id='dra_<%=tas.getId() %>' onDragStart="sourceId=this.id" <%} %>  <%
	}
	stro = true;
	}
	else {
		
		if (stro) {
			stro = false;
			
		
			%>colspan='<%=colspan %>' onclick="parent.frames[1].location='task_view593.jsp?id=<%=tas.getId() %>';return false;"	><%=rek %></td><% 
			colspan=0;
		}
		
		if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(new Date(), "yyyy-MM-dd"))) {
			if (colspan2>0) {
				%><%=getColss(colspan2,false)%><%
				colspan2=0;
			}
			%><td  style='background:yellow'  ></td><%
		
		}
		else if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(msx, "yyyy-MM-dd"))) {
			if (colspan2>0) {
				%><%=getColss(colspan2,false)%><%
				colspan2=0;
			}
			%><td  style='background:#03f319'  ></td><%
		}
		
		else if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(tooprog, "yyyy-MM-dd"))) {
			if (colspan2>0) {
				%><%=getColss(colspan2,false)%><%
				colspan2=0;
			}
			%><td  style='background:#4083c7'  ></td><%
		}
		
		
		else {
			colspan2++;
		}
	}
	//System.out.println("*----------------------**** 2");
	cal.add(Calendar.DAY_OF_MONTH, 1);
	}

if (stro) {
	stro = false;
	%>colspan='<%=colspan %>'	 onclick="parent.frames[1].location='task_edit574.jsp?opcija=update&cal=Z&idt=<%=request.getParameter("idt")%>&id=<%=tas.getId() %>';return false;"><%=rek %></td><% 
	colspan=0;
}
if (colspan2>0) {
	%><%=getColss(colspan2,false)%><%
	colspan2=0;
}

%></tr><%
	if (tas.getTask_begin()!=null && !nul.jeN(tas.getTask_state()).equals("6")) {
	%><tr class="opiscell2"><td class="valuecell" >&nbsp;</td><%
	/// real time spended
	cal.setTime(fromm);
	 stro = false;
	 colspan = 0;
while (cal.getTimeInMillis()<=too.getTime()) { /// days
	
	
	Date fromco = new Date();

	if (tas.getTask_finish()!=null) {
		
		Calendar col = new GregorianCalendar();
		col.setTime(tas.getTask_finish());
		col.set(Calendar.HOUR, 0);
		col.set(Calendar.MINUTE, 0);
		col.set(Calendar.SECOND, 0);
		col.set(Calendar.HOUR_OF_DAY, 0);
		fromco = col.getTime();
		
	//	System.out.println(nul.jeN(tas.getTask_name()) +"-- "+fromco+" ---- "+fromco.getTime() +" --------- "+col.getTime().getTime() +" ------- "+cal.getTime().getTime());
		
	}
Calendar col = new GregorianCalendar();
col.setTime(tas.getTask_begin());
col.set(Calendar.HOUR, 0);
col.set(Calendar.MINUTE, 0);
col.set(Calendar.SECOND, 0);
col.set(Calendar.HOUR_OF_DAY, 0);

	
	if ((nul.getDatumFormatFromDate(col.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd"))) || 
			(nul.getDatumFormatFromDate(fromco, "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd"))) || 
			(col.getTime().getTime()<=cal.getTime().getTime() && fromco.getTime()>=cal.getTime().getTime())) {
	//	stro = true;
	colspan++;
	if (!stro) {
		
		if (colspan2>0) {
			%><%=getColss(colspan2,false)%><%
			colspan2=0;
		}
		
		
	%><td style='background:#e3e3e3' <%
	}
	stro=true;
	}
	else {
		if (stro) {
			stro = false;
			%> colspan='<%=colspan %>'	><div class='myDivIdsc'><div  class='contentsc'>&nbsp;</div><div class='progresssc' style='width:100%;background-color:#5390cf'>&nbsp;</div></div></td><% 
			colspan=0;
		}
		if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(new Date(), "yyyy-MM-dd"))) {
			
			if (colspan2>0) {
				%><%=getColss(colspan2,false)%><%
				colspan2=0;
			}
			%><td  style='background:yellow'  ></td><%
		
		}
		else if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(msx, "yyyy-MM-dd"))) {
			
			if (colspan2>0) {
				%><%=getColss(colspan2,false)%><%
				colspan2=0;
			}
			%><td  style='background:#03f319'  ></td><%
		}
		else if (nul.getDatumFormatFromDate(cal.getTime(), "yyyy-MM-dd").equals(nul.getDatumFormatFromDate(tooprog, "yyyy-MM-dd"))) {
			
			if (colspan2>0) {
				%><%=getColss(colspan2,false)%><%
				colspan2=0;
			}
			%><td  style='background:#4083c7'  ></td><%
		}
		else {
		colspan2++;
		}
	}
//	System.out.println("*----------------------**** 333333");
	cal.add(Calendar.DAY_OF_MONTH, 1);
	}
if (stro) {
	stro = false;
	%>colspan='<%=colspan %>'	></td><% 
	colspan=0;
}

if (colspan2>0) {
	%><%=getColss(colspan2,false)%><%
	colspan2=0;
}

%></tr><%
}
	%><%=this.getLines(nul, cal, fromm, too, request, msx, tooprog, dao, " id_task="+tas.getId(),false,control) %><%
	
	
	
	
	
	
	
	
	
	
	
	/// sub task by users on tasks
	
	
	
	
	/// end sub task by user
	
	
	
	
	
	
	
	
	
	
	
	
	
}
}
%>



</tbody>



</table>
</form>
<%
if (lis.size()==0) {%>

<%}
%>
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<script language=javascript>

<%

%>
function go(asd,vv){
if (vv == 1){
 aaa = "m_task_edit565.jsp?id="+asd;
  parent.frames[2].location = aaa;
}
return false;
}
function godown(asd){
parent.frames[2].location = asd;
return false;
}
function PGAPP(){
}
function odpriVrstico(spat){
evi = document.getElementById("vrst"+spat);
evis = document.getElementById("vimg"+spat);
if(evi.style.display == "block") {
evi.style.display = "none";
evis.src = "od.gif";
}
else {
evi.style.display = "block";
evis.src = "dom.gif";
}
return false;
}
function odpriVrstico2(spat){
evi = document.getElementById("vrst"+spat);
evis = document.getElementById("vimg"+spat);
if(evi.style.display == "block") {
evi.style.display = "none";
evis.innerHTML = "+";
}
else {
evi.style.display = "block";
evis.innerHTML = "--";
}
return false;
}
</script>
<%
if (strec>stizpisov) {
String iskk="";
if (!nul.jeNull(request.getQueryString()).equals("")) {
iskk=nul.jeNull(request.getQueryString()).replaceAll("akcijaXY=DELETE","").replaceAll("pagenumber","XY")+"";
}
else {
iskk="";
}
String orme = "";
if (!nul.jeNull(request.getParameter("orderup")).equals("")) {
orme = "&orderup="+request.getParameter("orderup")+"&orderupsmer="+request.getParameter("orderupsmer");
}
if (!iskk.equals("")) {
iskk="&"+iskk+orme;
}
if (iskanje) {
iskk=iskk+"&isk=1"+orme;
}
%><p align=center>
<table  id='pagebrowse'  class="fontilist" >
<tr bgcolor="ededed">
<td align=center >
Browse page: </td><td>
<a style="text-decoration:none;color:black"  href="task_list565.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>
<%
int vse=0;
int ststr=0;
int prvii=nul.jeNull(session.getValue("pagenumberTask565")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTask565")+"");
if (prvii>1) {
int prej = prvii-1;
%>
<td>
<a style="text-decoration:none;color:black"  href="task_list565.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>
<td>|</td>
<%
}
for (int y=0;y<strec;y++) {
vse++;
if (vse==stizpisov) {
vse=0;
ststr++;
if ((prvii-5)<ststr && ststr<(prvii+5)) {
%>
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTask565")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="task_list565.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%
}
}
}
if (vse!=0) {
%>
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTask565")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="task_list565.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
<%
}
if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="task_list565.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>
<td>|</td>
<%
}
%>
<td><a style="text-decoration:none;color:black"  href="task_list565.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTask565")+"").equals("")?"1":session.getValue("pagenumberTask565")%> of <%=ststr+1%> </td>
<td>|</td>
<td>
records: <%=strec%></td>
</tr>
</table></p>
<%
}
%>
</body></html>
<%
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
