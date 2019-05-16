<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
            <%@ page import ="db.*" %>
                    <%@ page import ="java.util.ArrayList" %>
    <%
    int gameid = 0;
    try {
    	gameid = Integer.parseInt(request.getParameter("id"));
    	
    } catch (Exception e){
    	e.printStackTrace();
    	response.sendRedirect("index.jsp");
    	throw new javax.servlet.jsp.SkipPageException();
    }
    Spgames con = new Spgames();
    con.setValues();
    game_entry game = con.get_game_info(gameid);
    ArrayList<comment> comment_list = con.get_comments(gameid);
    if (game == null){response.sendRedirect("index.jsp"); throw new javax.servlet.jsp.SkipPageException();}
    else {
    	
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
//Printing game info
out.print(game.get_game_title()+game.get_company()+game.get_description()+game.get_image_location()+game.get_release_date()+game.get_price()+game.get_preowned());

%>
<h1>Comments</h1>
<% 
//Printing comments
if(comment_list != null){

for (int i = 0; i<comment_list.size(); i++){
	comment row = comment_list.get(i);
	out.print(row.get_username()+"<br>"+row.get_rating()+"<br>"+row.get_review());
}
	
}
else {
	out.print("No comments!");
}
%>
<form action="addcomment.jsp" method="POST">
<input type="hidden" name="game_id" value="<%= gameid%>">
<p>Username: <input type="text" name="username"></p>
<p>Rating: <input type="radio" name="rating" value="0"> 0 Stars<input type="radio" name="rating" value="1"> 1 Star<input type="radio" name="rating" value="2"> 2 Stars<input type="radio" name="rating" value="3"> 3 Stars<input type="radio" name="rating" value="4"> 4 Stars<input type="radio" name="rating" value="5"> 5 Stars</p>
  Review:
  <textarea name="review">
  
  </textarea> <br>
 <p> <input type="submit" name="submit" value="Submit"></p>
</form>

</body>
</html>
<%



    }
%>