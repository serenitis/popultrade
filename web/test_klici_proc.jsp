<div id="pricing-table"  style="margin-left:-28;">
	<table  cellspacing=35 >
<tr>

<%
com.popultrade.model.Dashboard modx = new com.popultrade.model.Dashboard();
	
modx.setId_job(new Long(request.getParameter("idt")));

com.popultrade.dao.DashboardDAO doax =(com.popultrade.dao.DashboardDAO)contextUtil.getBeanDao("dashboardDAO",pageContext.getServletContext());


List allta = doax.getDashboards(modx, 1, 10000,"id_dashboard is null", "title", "");
if (allta.size()>0) {
    
	for (int k=0;k<allta.size();k++) {
		com.popultrade.model.Dashboard dash= (com.popultrade.model.Dashboard)allta.get(k);

%>
<td>
<table  >
<tr>

<td valign=top>
<div class="plan plan4">
<div class="header"><%=nul.getDatumFormatFromDate(dash.getDate_create(), "dd-MM-yyyy") %></div>
<a href="" id='tas_185' onClick="parent.frames[1].location='task_view593.jsp?id=<%=dash.getId()%>';return false;"   title="View task"  style='text-decoration:none;color:black'  > <%=nul.jeN(dash.getTitle()) %></a>       	
<%
if (dash.getId_job()!=null) {
%>
<a href="" id='tas_185' onClick="parent.frames[1].location='job_view224.jsp?opcija=spremeni&siframm=new&sifrant=null&id=<%=dash.getId_job()%>';return false;"  class='btnblued'   title="View job"  style="float:right"   >JOB</a>
<%
}
%>
</div>
</td>
</tr>

<%
if (dash.getDashboards()!=null && dash.getDashboards().size()>0) {
	
	for (int c=0;c<dash.getDashboards().size();c++) {
	
		com.popultrade.model.Dashboard dad = (com.popultrade.model.Dashboard)dash.getDashboards().get(c);
		
%>	

<tr>

<td valign=top>
<div class="plan plan4">
<div class="header"><%=nul.getDatumFormatFromDate(dad.getDate_create(), "dd-MM-yyyy") %></div>
<b> <%=nul.jeNull(dad.getTitle()) %></b><Br>      	
<%=nul.jeNull(dad.getDescription()) %>
</div>
</td>
</tr>



<%	

	}
}

%>

<tr>

<td valign=top>
<div class="plan plan4">
ADD COMMENT TO DASHBOARD 

</div>
</td>
</tr>



</table></td>
<%
        	}
        }
		
        %>
          


<td valign=top>
<div class="plan plan4">
ADD GROUP TO DASHBOARD 

</div>
</td>


</tr>
</table>

