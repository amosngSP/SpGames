<%@ page import="db.*" %>
<%@ page import="java.*" %>
<%@ page import="javax.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameter("game_id") != null){
		Spgames dbcon = new Spgames();
		dbcon.setValues();
		if(dbcon.delete_game(Integer.parseInt(request.getParameter("game_id")))){
			 response.sendRedirect("editgames.jsp?success=2");
		} else {
			response.sendRedirect("editgames.jsp?fail=2");
		}
	} else {
		response.sendRedirect("index.jsp"); 
	}
%>