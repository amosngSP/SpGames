<%@page import="db.*" %>
<% 
try{
	if(session.getAttribute("name")!=null&&request.getParameter("submit")!=null){
		Spgames dbcon = new Spgames();
		int genre_id = Integer.parseInt(request.getParameter("genre_id"));
		int del_genre = dbcon.undelete_genre(genre_id);
		if(del_genre == 1){
			response.sendRedirect("editgenres.jsp?fail=4");
		} else if(del_genre == 0){
			response.sendRedirect("editgenres.jsp?success=4");
		}
	} else{
		response.sendRedirect("index.jsp");
	}
	
	
} catch (Exception e){
	response.sendRedirect("index.jsp");
}

%>