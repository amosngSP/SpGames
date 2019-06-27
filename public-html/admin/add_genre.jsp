<%@page import="db.*" %>
<% 
try{
	if(session.getAttribute("name") != null && request.getParameter("submit") != null){
		String genre_name = request.getParameter("genre_name");
		Spgames dbcon = new Spgames();
		int insert = dbcon.insert_genre(genre_name);
		if(insert == 1){
			response.sendRedirect("editgenres.jsp?success=3");
		} else if(insert == 0) {
			response.sendRedirect("editgenres.jsp?fail=3");
		} else{
			response.sendRedirect("editgenres.jsp?fail=3");
		}
	} else {
		response.sendRedirect("index.jsp");
	}
	
} catch(Exception e){
	e.printStackTrace();
	response.sendRedirect("index.jsp");
}

%>