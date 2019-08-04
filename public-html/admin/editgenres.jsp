<%@include file="header.jsp" %>
<%@page import="htmlUtils.*" %>
      <div class="container-fluid">
        <h1 class="mt-4">Edit Genres</h1>
<%

BootstrapAlerts Alerts = new BootstrapAlerts();
if (request.getParameter("success") != null) {

	if (request.getParameter("success").equals("1")) {
		out.print(Alerts.SuccessAlert("The genre has been updated!"));
	} else if (request.getParameter("success").equals("2")) {
		out.print(Alerts.SuccessAlert("The genre has been deleted."));
	} else if (request.getParameter("success").equals("3")) {
		out.print(Alerts.SuccessAlert("The genre has been added."));
	} else if (request.getParameter("success").equals("4")) {
		out.print(Alerts.SuccessAlert("The genre has been brought back from the dead."));
	}
} else if (request.getParameter("fail") != null) {
	if (request.getParameter("fail").equals("1")) {
		out.print(Alerts.CritAlert("There was an error while trying to update the genre."));
	} else if (request.getParameter("fail").equals("2")) {
		out.print(Alerts.CritAlert("There was an error while trying to delete the genre. Is the genre still in use? If so, please diassociate the genre with the game before proceeding to delete the genre."));
	} else if (request.getParameter("fail").equals("3")) {
		out.print(Alerts.CritAlert("There was an error while trying to add the game."));
	} else if (request.getParameter("fail").equals("4")) {
		out.print(Alerts.CritAlert("Genre decided to stay dead, it thought it was playing dead."));
	} 
}
%>
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
      </div><form id="modal-form" action="ServletGenreAdd" method="POST">
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
      </div><form id="modal-form" action="ServletGenreUpdate" method="POST">
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
      </div><form id="modal-form" action="ServletGenreDelete" method="POST">
        
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
      </div><form id="modal-form" action="ServletGenreUnDelete" method="POST">
        
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


