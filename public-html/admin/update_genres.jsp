<%@page import="db.*" %>
<%
try{
if(session.getAttribute("name") != null&&request.getParameter("submit")!=null){
	Spgames dbcon = new Spgames();
	dbcon.setValues();
	int genre_id = Integer.parseInt(request.getParameter("genre_id"));
	String genre_name = request.getParameter("genre_name");
	boolean update = dbcon.update_genre(genre_id,genre_name);
	if(update){
		response.sendRedirect("editgenres.jsp?success=1");
	} else{
		response.sendRedirect("editgenres.jsp?fail=1");
	}
} else {
	response.sendRedirect("index.jsp");
}
} catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("index.jsp");
}
%>