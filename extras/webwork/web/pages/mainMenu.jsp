<%@ include file="/common/taglibs.jsp"%>

<title><fmt:message key="mainMenu.title"/></title>
<content tag="heading"><fmt:message key="mainMenu.heading"/></content>

<fmt:message key="mainMenu.message"/>

<div class="separator"></div>

<ul class="glassList">
    <li>
        <a href="<c:url value="/editProfile.html"/>"><fmt:message key="menu.user"/></a>
    </li>
    <li>
        <a href="<c:url value="/uploadFile!default.html"/>"><fmt:message key="menu.selectFile"/></a>
    </li>
</ul>
