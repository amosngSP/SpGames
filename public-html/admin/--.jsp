<%@ page import="db.game_entry" %>
<%@ page import="db.Spgames" %>
<%@ page import="db.*" %>
<%@ page import="java.*,java.util.*,javax.*" %>
<% 
if(request.getParameter("submit") != null){
	int game_id = Integer.parseInt(request.getParameter("game_id"));
	String game_title = request.getParameter("game_title");
	String company = request.getParameter("company");
	String release_date = request.getParameter("release_date");
	String[] genres_form = request.getParameterValues("genres");
	String price = request.getParameter("price");
	int preowned = Integer.parseInt(request.getParameter("preowned"));
	String description = request.getParameter("description");
	game_entry temp = new game_entry();
	temp.set_game_id(game_id);
	temp.set_game_title(game_title);
	temp.set_company(company);
	temp.set_release_date(release_date);
	ArrayList<genres> temp2 = new ArrayList<genres>();
	for (String s: genres_form){
		genres temp3 = new genres();
		temp3.set_genre_id(Integer.parseInt(s));
		temp2.add(temp3);
	}
	temp.set_genres_list(temp2);
	temp.set_price(price);
	temp.set_preowned(preowned);
	temp.set_description(description);
	
	
} else {
	response.sendRedirect("index.jsp");
}

%>