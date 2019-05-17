<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% if(session.getAttribute("name")== null){response.sendRedirect("index.jsp");} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1"> 
<title>SPGames - Administration</title>
</head>
<body>
Welcome!<br>
<a href="addgame.jsp">Add Games</a>
<a href="logout.jsp">Log Out</a>
</body>
</html>