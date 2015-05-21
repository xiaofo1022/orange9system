<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<sf:form id="postForm" modelAttribute="pictureData" class="form-horizontal" method="post">
		<input type="hidden" id="orderId" name="orderId"/>
		<input type="hidden" id="fileName" name="fileName"/>
		<input type="hidden" id="base64Data" name="base64Data"/>
	</sf:form>
</body>
</html>