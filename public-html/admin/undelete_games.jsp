<%@ page import="db.*" %>
<%@ page import="java.*" %>
<%@ page import="javax.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameter("game_id") != null){
		GameDAO Game_DAO = new GameDAOImpl();
		if(Game_DAO.UndoDeleteGame(Integer.parseInt(request.getParameter("game_id")))){
			 response.sendRedirect("editgames.jsp?del=1&success=4");
		} else {
			response.sendRedirect("editgames.jsp?del=1&fail=4");
		}
	} else {
		response.sendRedirect("index.jsp"); 
	}
%>