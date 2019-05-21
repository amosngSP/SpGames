        <%@ page import ="db.*" %>
<%
try {
if(request.getParameter("submit") != null){
	String username = request.getParameter("username");
	String review = request.getParameter("review");
	int rating = Integer.parseInt(request.getParameter("rating"));
	int game_id = Integer.parseInt(request.getParameter("game_id"));
	comment cmt = new comment();
	cmt.set_game_id(game_id);
	cmt.set_rating(rating);
	cmt.set_review(review);
	cmt.set_username(username);
	Spgames con = new Spgames();
	con.setValues();
	if(con.add_comment(cmt)){
		response.sendRedirect("game.jsp?game_id="+game_id+"&success=1");
	} else{
		response.sendRedirect("game.jsp?game_id="+game_id+"&success=0");
	}
} else{
	//response.sendRedirect("index.jsp");
} } catch (Exception e){
	e.printStackTrace();
}
%>