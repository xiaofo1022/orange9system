<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="text-align:center;padding-left:60px;">
	<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	<a onclick="logout()" class="logout">退出</a>
</div>
<script>
function logout() {
	$.get("<c:url value='/logout'/>", function() {
		location.replace("<c:url value='/'/>");
	});
}
</script>