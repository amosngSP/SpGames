<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="db.*" %>
    <%@ page import ="java.io.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
    <%@ page import ="org.apache.commons.fileupload.*" %>
    <%@ page import ="org.apache.commons.fileupload.disk.*" %>
    <%@ page import ="org.apache.commons.fileupload.servlet.*" %>
    <%@ page import ="org.apache.commons.io.output.*" %>
    <% if(session.getAttribute("name")== null){response.sendRedirect("index.jsp");} %>
    <%
    if(request.getParameter("submit") != null){
  	Part file = request.getPart("file");
  	InputStream fileio = file.getInputStream();
  	
    } 
    
    
    
    
    
    %>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>SPGames - Administration - Add Games</title>
</head>
<body>
<form action="uploadServlet" method="POST" enctype="multipart/form-data">
Game Title: <input type="text" name="game_title"><br>
Company: <input type="text" name="company"><br>
Release Date: <input type="date" name="release_date"><br>
Pre-owned: <select name="preowned"><option value="0">No</option><option value="1">Yes</option></select><br>
Price: <input type="number" step="0.01" min="0.01" name="price"><br>
Image: <input type="file" name="image_file"><br>
Genres: 
<select name="genre" multiple="multiple">
<%
Spgames con = new Spgames();
con.setValues();
ArrayList<genres> genre_list = con.get_genres();
for (int i = 0; i< genre_list.size();i++){
	out.print("<option value='"+genre_list.get(i).get_genre_id()+"'>"+genre_list.get(i).get_genre_name()+"</option>\r\n");
}
%>

</select>
Description:
<textarea name="description">
</textarea>
<input type="submit" name="submit" value="Submit">
</form>
</body>
</html>
