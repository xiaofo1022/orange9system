<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String link = request.getParameter("link"); %>
<div class="index-pic-row">
	<img class="index-row-header" src="<c:url value='/images/logo2.png'/>"/>
</div>
<div class="index-row">
	<nav class="index-nav">
		<% if (link != null && link.equals("enu")) { %>
			<a class="index-nav-item active" href="<c:url value='/enu'/>">欧美</a>
		<% } else { %>
			<a class="index-nav-item" href="<c:url value='/enu'/>">欧美</a>
		<% } %>
		<% if (link != null && link.equals("jnk")) { %>
			<a class="index-nav-item active" href="<c:url value='/jnk'/>">日韩</a>
		<% } else { %>
			<a class="index-nav-item" href="<c:url value='/jnk'/>">日韩</a>
		<% } %>
		<% if (link != null && link.equals("tog")) { %>
			<a class="index-nav-item active" href="<c:url value='/tog'/>">街拍</a>
		<% } else { %>
			<a class="index-nav-item" href="<c:url value='/tog'/>">街拍</a>
		<% } %>
		<% if (link != null && link.equals("sta")) { %>
			<a class="index-nav-item active" href="<c:url value='/sta'/>">海报</a>
		<% } else { %>
			<a class="index-nav-item" href="<c:url value='/sta'/>">海报</a>
		<% } %>
		<% if (link != null && link.equals("lgn")) { %>
			<a class="index-nav-item active">登录</a>
		<% } else { %>
			<a class="index-nav-item" href="<c:url value='/lgn'/>">登录</a>
		<% } %>
	</nav>
</div>