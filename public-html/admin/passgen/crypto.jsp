<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="db.*" %>
<% 
String password = request.getParameter("password");
String shadow = request.getParameter("shadow");

if ("POST".equalsIgnoreCase(request.getMethod()) && password != null) {
	PassCrypt crypto;
	if (shadow.equals("")) {
		crypto = new PassCrypt(password);
	} else {
		crypto = new PassCrypt(password,shadow);
	}
	String output = crypto.get();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>User Registration</title>
</head>
<body>
	<h1>Super Secure Service</h1>
	<h2></h2>
	<p>Output: <%=output %></p>
</body>
</html>

<%
} else {
	response.setStatus(500);
}
%>