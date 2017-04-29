<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../baseAttr.tag" %>


<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>

<span class="glyphicon ${cssClass}" aria-hidden="true"><jsp:doBody/></span>
