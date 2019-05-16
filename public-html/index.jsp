<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import ="db.Spgames" %>
        <%@ page import ="db.game_entry" %>
        <%@ page import ="java.util.ArrayList" %>
    <%-- This will contain the games --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPGames Shop</title>
<style>
table{
background-color: black;
} 
td,th{
background-color: white;
}
</style>
</head>
<body>
<table>
<tr><th>Game Title</th><th>Company</th><th>Release Date</th><th>Description</th><th>Price</th><th>Image Location</th><th>Genres</th><th>Pre-Owned</th></tr>
<% 
Spgames con = new Spgames();
con.setValues();
ArrayList<game_entry> games = con.gamesList();
if (games.isEmpty()){
	out.print("<tr><td colspan='8'>There are no games to show.</td></tr>");
} else {
	 StringBuilder tr = new StringBuilder();
    for (int i = 0; i < games.size(); i++) {
        game_entry row = games.get(i);
       
        tr.append("<tr>");
        tr.append("<td><a href='game.jsp?id="+row.get_game_id()+"'>"+row.get_game_title()+"</a></td>");
        tr.append("<td>"+row.get_company()+"</td>");
        tr.append("<td>"+row.get_release_date()+"</td>");
        tr.append("<td>"+row.get_description()+"</td>");
        tr.append("<td>"+row.get_price()+"</td>");
        tr.append("<td>"+row.get_image_location()+"</td>");
        tr.append("<td>");
        for (int j = 0; j < row.get_genres().size(); j++) {
        	String genre_name = row.get_genres().get(j);
        	tr.append(genre_name+", ");
        }
        tr.append("</td>");
        tr.append("<td>"+row.get_preowned()+"</td>");
        tr.append("</tr>");
      }
    out.print(tr.toString());
}

%>
</table>
</body>
</html>