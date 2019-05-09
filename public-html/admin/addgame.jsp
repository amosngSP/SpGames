<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% if(session.getAttribute("name")== null){response.sendRedirect("index.jsp");} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPGames - Administration - Add Games</title>
</head>
<body>
<form action="addgame.jsp" method="POST">

</form>
</body>
</html>