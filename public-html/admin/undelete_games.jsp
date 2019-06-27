<%@ page import="db.*" %>
<%@ page import="java.*" %>
<%@ page import="javax.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameter("game_id") != null){
		Spgames dbcon = new Spgames();
		if(dbcon.undelete_game(Integer.parseInt(request.getParameter("game_id")))){
			 response.sendRedirect("editgames.jsp?del=1&success=4");
		} else {
			response.sendRedirect("editgames.jsp?del=1&fail=4");
		}
	} else {
		response.sendRedirect("index.jsp"); 
	}
%>