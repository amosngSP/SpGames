<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import ="db.Spgames" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Spgames dbcon = new Spgames();
out.print(dbcon.passwordhash("nani", "12"));
%>
</body>
</html>