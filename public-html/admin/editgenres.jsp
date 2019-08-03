<%@include file="header.jsp" %>
      <div class="container-fluid">
        <h1 class="mt-4">Edit Genres</h1>
               <%if (request.getParameter("success") != null){
	if (request.getParameter("success").equals("1")){%>
<div class="alert alert-success" style="">
  <strong>Success!</strong> The genre has been updated!
</div>
<% } else if(request.getParameter("success").equals("2")) {
	%>
<div class="alert alert-success">
  <strong>Success!</strong> The genre has been deleted.
</div>	
	<% 
} else if(request.getParameter("success").equals("3")) {
	
	%>
<div class="alert alert-success">
  <strong>Success!</strong> The genre has been added.
</div>		
	<% 
}else if(request.getParameter("success").equals("4")) {
	
} %>
<div class="alert alert-success">
  <strong>Success!</strong> The genre has been brought back from the dead.
</div>		
	<% 	
	
} else if (request.getParameter("fail")!= null){
	if(request.getParameter("fail").equals("1")){
		%>
		<div class="alert alert-danger">
  <strong>Error!</strong> Updating of genre failed as it is currently in use! 
</div>
		<% 
	} else if(request.getParameter("fail").equals("2")){
		%>
		<div class="alert alert-danger">
  <strong>Error!</strong> This genre is in use! Please remove it from the games that are using it in order to delete!
</div>
		<% 
	} else if(request.getParameter("fail").equals("3")){
		
		%>
		<div class="alert alert-danger">
  <strong>Error!</strong> Adding of genre failed! Could there be another genre with the same name already? Was it previously deleted before? Please recover the genre name instead!
</div>
		<% 
	}else if(request.getParameter("fail").equals("3")){
		%>
		<div class="alert alert-danger">
  <strong>Error!</strong> Unable to bring the genre back to existence. It decided to stay dead.
</div>
		<% 
	}
	
	
}%>
        <div class="addgame">
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal">Add Genre</button>
<% if(request.getParameter("del")== null){%>
<a href="editgenres.jsp?del=1" class="btn btn-primary">See deleted entries too</a>
<%}else if(request.getParameter("del").equals("1")){ %>
<a href="editgenres.jsp" class="btn btn-primary">See not deleted entries only</a>
<% }%>
</div>
        <table id="data_table" class="table table-striped" style="width: 100%; margin:auto;">
        <thead>
        <tr>
        <th scope="row">Genre ID</th>
        <th>Genre Name</th>
        <th>Deleted</th> 
        <th>Actions</th>
        </tr>
        <% ArrayList<Genres> genre_list = new ArrayList<Genres>();
        SqlDAO DBSQL = new SqlDAOImpl();
        GenresDAO Genres_DAO = new GenresDAOImpl(DBSQL);
        if(request.getParameter("del")== null){
        	genre_list = Genres_DAO.GetGenresList(0);
        } else if(request.getParameter("del").equals("1")){
        	genre_list = Genres_DAO.GetGenresList(-1);
        }
			for(Genres s: genre_list){        
        %>
        <tr><td><%= s.GetGenreID() %></td><td><%= s.GetGenreName() %></td><td><%= s.GetDeleted() %></td><td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal" data-genreid="<%= s.GetGenreID() %>" data-genrename="<%= s.GetGenreName() %>">Edit</button>

<%if (s.GetDeleted() == 0){ %>
<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" data-genreid="<%= s.GetGenreID() %>" >Delete</button> 
<%} else { %>
<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#UNdeleteModal" data-genreid="<%= s.GetGenreID() %>" >Undo Delete</button>

<%} %></td></tr>
        <%} %> 
        </thead> 
        </table>
      </div>
      
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Adding Genre</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div><form id="modal-form" action="add_genre.jsp" method="POST">
      <div class="modal-body">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Genre Name:</label>
            <input type="text" class="form-control" id="genre-name" name="genre_name" required>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <input type="submit" class="btn btn-primary" value="Submit" name="submit">
      </div>
      </form>
    </div>
  </div>
</div>      

<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Editing</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div><form id="modal-form" action="update_genres.jsp" method="POST">
      <div class="modal-body">
        
        <input type="hidden" name="genre_id" id="genre-id">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Genre Name:</label>
            <input type="text" class="form-control" id="genre-name" name="genre_name" required>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <input type="submit" class="btn btn-primary" value="Submit" name="submit">
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Deleting</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div><form id="modal-form" action="delete_genres.jsp" method="POST">
        
      <div class="modal-body">
      <input type="hidden" name="genre_id" id="genre-id">
        <strong>Are you sure you want to delete this genre?</strong>
        This action cannot be undone!
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
        <input type="submit" class="btn btn-primary" value="Yes" name="submit">
      </div>
      </form>
    </div>
  </div>
</div>
<div class="modal fade" id="UNdeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Undo Delete</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div><form id="modal-form" action="undelete_genre.jsp" method="POST">
        
      <div class="modal-body">
      <input type="hidden" name="genre_id" id="genre-id">
        <strong>Are you ready to bring it back alive?</strong>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
        <input type="submit" class="btn btn-primary" value="Yes" name="submit">
      </div>
      </form>
    </div>
  </div>
</div>
    <!-- /#page-content-wrapper -->
 <script src="js/genrescript.js"></script> 
<%@include file="footer.jsp" %>


