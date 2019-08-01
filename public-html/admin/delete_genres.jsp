<%@page import="db.*" %>
<% 
try{
	if(session.getAttribute("name")!=null&&request.getParameter("submit")!=null){
		GenresDAO Genres_Class = new GenresDAOImpl();
		int genre_id = Integer.parseInt(request.getParameter("genre_id"));
		int del_genre = Genres_Class.DeleteGenre(genre_id);
		if(del_genre == 1){
			response.sendRedirect("editgenres.jsp?fail=2");
		} else if(del_genre == 0){
			response.sendRedirect("editgenres.jsp?success=2");
		}
	} else{
		response.sendRedirect("index.jsp");
	}
	
	
} catch (Exception e){
	response.sendRedirect("index.jsp");
}

%>