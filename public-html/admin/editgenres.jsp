<%@include file="header.jsp" %>
      <div class="container-fluid">
        <h1 class="mt-4">Edit Genres</h1>
        
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
        <td>Genre ID</td>
        <td>Genre Name</td>
        <td>Actions</td>
        </tr>
        <% ArrayList<genres> genre_list = new ArrayList<genres>();
        Spgames dbcon = new Spgames();
        dbcon.setValues();
        if(request.getParameter("del")== null){
        	genre_list = dbcon.get_genres();
        } else if(request.getParameter("del").equals("1")){
        	genre_list = dbcon.get_all_genres();
        }
			for(genres s: genre_list){        
        %>
        <tr><td><%= s.get_genre_id() %></td><td><%= s.get_genre_name() %></td><td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal" data-genreid="<%= s.get_genre_id() %>" data-genre_name="<%= s.get_genre_name() %>">Edit</button>

<%if (s.get_deleted() == 0){ %>
<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" data-genreid="<%= s.get_genre_id() %>" >Delete</button> 
<%} else { %>
<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#UNdeleteModal" data-genreid="<%= s.get_genre_id() %>" >Undo Delete</button>

<%} %></td></tr>
        <%} %>
        </thead>
        </table>
      </div>
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Editing</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div><form id="modal-form" action="updateServlet" method="POST">
      <div class="modal-body">
        
        <input type="hidden" name="genre_id" id="genre-id">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Genre Title:</label>
            <input type="text" class="form-control" id="genre-title" name="genre_title" required>
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
    <!-- /#page-content-wrapper -->
 <script src="js/genrecript.js"></script> 
<%@include file="footer.jsp" %>


