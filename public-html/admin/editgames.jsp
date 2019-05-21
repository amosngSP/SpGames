<%@include file="header.jsp" %>
      <div class="container-fluid">
        <h1 class="mt-4">Edit Games</h1>
        <%if (request.getParameter("success") != null){
	if (request.getParameter("success").equals("1")){%>
<div class="alert alert-success" style="">
  <strong>Success!</strong> The data has been updated!
</div>
<% } else if(request.getParameter("success").equals("2")) {
	%>
<div class="alert alert-success">
  <strong>Success!</strong> The game entry has been deleted.
</div>	
	<% 
} else if (request.getParameter("success").equals("3")){
	%>
<div class="alert alert-success">
  <strong>Success!</strong> The game entry has been added.
</div>	

<% 
	} else if (request.getParameter("success").equals("4")){
		%>
		<div class="alert alert-success">
  <strong>Success!</strong> The game entry has been brought back from the dead.
</div>
		<% 
	}
} else if (request.getParameter("fail")!= null){
	if(request.getParameter("fail").equals("3")){
		%>
		<div class="alert alert-danger">
  <strong>Error!</strong> File size too big! Please choose a smaller file. 
</div>
		<% 
	} else if(request.getParameter("fail").equals("4")){
		%>
		<div class="alert alert-danger">
  <strong>Error!</strong> Game decided to stay dead, it thought it was playing dead.
</div>
		<% 
	}
	
	
}%>
<div class="addgame">
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal">Add game</button>
<% if(request.getParameter("del")== null){%>
<a href="editgames.jsp?del=1" class="btn btn-primary">See deleted entries too</a>
<%}else if(request.getParameter("del").equals("1")){ %>
<a href="editgames.jsp" class="btn btn-primary">See not deleted entries only</a>
<% }%>
</div>
<table id="data_table" class="table table-striped" style="width: 100%; margin:auto;">
<thead>
<tr>
<th>Game ID</th>
<th>Game Image</th>
<th>Game Title</th>
<th>Company Name</th>
<th>Release Date</th>
<th style="width: 500px;">Description</th>
<th>Genres</th>
<th>Price</th>
<th>Pre-Owned</th>
<th>Deleted</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
Spgames dbcon = new Spgames();
dbcon.setValues();
int del = 0;
//ArrayList<game_entry> game_list = dbcon.return_all_gamesList();
if(request.getParameter("del") != null){
	if(request.getParameter("del").equals("0")){
		del = 0;
	} else if(request.getParameter("del").equals("1")) {
		del = 1;
	}
}
ArrayList<game_entry> game_list = dbcon.return_all_gamesList(del);
for(game_entry game: game_list){
%>
<tr id="<%= game.get_game_id() %>">
<td><%= game.get_game_id() %></td>
<td><img src="gameimage.jsp?game_id=<%= game.get_game_id() %>" width="100"></td>
<td><%= game.get_game_title() %></td>
<td><%= game.get_company() %></td>
<td><%= game.get_release_date()%></td>
<td><%= game.get_description() %></td>
<td><%
String genre_ids = "";
for (genres s: game.get_genres()){
	out.print(s.get_genre_name()+", ");
	genre_ids = genre_ids + s.get_genre_id() + " ";
}
%></td>
<td><%= game.get_price() %></td>
<td><% if(game.get_preowned() == 1){out.print("Yes");} else {out.print("No");} %></td>
<td><%= game.get_deleted() %></td>
<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal" data-gameid="<%= game.get_game_id() %>" data-gametitle="<%= game.get_game_title() %>" data-company="<%= game.get_company() %>" data-releasedate="<%= game.get_release_date()%>" data-description="<%= game.get_description() %>" data-price="<%= game.get_price() %>" data-preowned="<%= game.get_preowned() %>" data-genres="<%=genre_ids.trim() %>">Edit</button>

<%if (game.get_deleted() == 0){ %>
<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" data-gameid="<%= game.get_game_id() %>" >Delete</button> 
<%} else { %>
<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#UNdeleteModal" data-gameid="<%= game.get_game_id() %>" >Undo Delete</button>

<%} %>
</td>
</tr>
<% } %>
</tbody>
</table>

<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add game</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div><form id="modal-form" action="uploadServlet" method="POST" enctype="multipart/form-data">
      <div class="modal-body">
        
        <input type="hidden" name="game_id" id="game-id">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Game Title:</label>
            <input type="text" class="form-control" id="game-title" name="game_title" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Image:</label>
            <input type="file" class="form-control" name="image_file">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Company Name:</label>
            <input type="text" class="form-control" id="company" name="company" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Release Date:</label>
            <input type="date" class="form-control" id="release_date" name="release_date" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Genres:</label>
            <select name="genres" class="form-control selectpicker" multiple="multiple" id="genres"  required>
            <% 
            ArrayList<genres> genre_list = new ArrayList<genres>();
            genre_list = dbcon.get_genres();
            		for (genres g: genre_list){
            %>
            <option value="<%=g.get_genre_id() %>"><%=g.get_genre_name() %></option>
            <%
            		}
            %>
            </select>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Price:</label>
            <input type="number" step="0.01" min="0.01" class="form-control" id="price" name="price" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Pre-Owned:</label>
            <select name="preowned" class="form-control" id="preowned" required>
            	<option value="0">No</option>
            	<option value="1">Yes</option>
            </select>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">Description:</label>
            <textarea class="form-control" id="description" name="description" required></textarea>
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
      </div><form id="modal-form" action="updateServlet" method="POST" enctype="multipart/form-data">
      <div class="modal-body">
        
        <input type="hidden" name="game_id" id="game-id">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Game Title:</label>
            <input type="text" class="form-control" id="game-title" name="game_title" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Image:</label>
            <input type="file" class="form-control" name="image_file">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Company Name:</label>
            <input type="text" class="form-control" id="company" name="company" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Release Date:</label>
            <input type="date" class="form-control" id="release_date" name="release_date" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Genres:</label>
            <select name="genres" class="form-control selectpicker" multiple="multiple" id="genres"  required>
            <% 
            		for (genres g: genre_list){
            %>
            <option value="<%=g.get_genre_id() %>"><%=g.get_genre_name() %></option>
            <%
            		}
            %>
            </select>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Price:</label>
            <input type="number" step="0.01" min="0.01" class="form-control" id="price" name="price" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Pre-Owned:</label>
          <!--   <input type="text" class="form-control" id="game-title" name="game_title"> -->
            <select name="preowned" class="form-control" id="preowned" required>
            	<option value="0">No</option>
            	<option value="1">Yes</option>
            </select>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">Description:</label>
            <textarea class="form-control" id="description" name="description" required></textarea>
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
      </div><form id="modal-form" action="delete_games.jsp" method="POST">
      <div class="modal-body">
      <input type="hidden" name="game_id" id="game-id">
        <strong>Are you sure you want to delete this game?</strong>
        <p>This action cannot be undone!</p>



        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <input type="submit" class="btn btn-danger" value="Delete" name="submit">
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="UNdeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Deleting</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div><form id="modal-form" action="undelete_games.jsp" method="POST">
      <div class="modal-body">
      <input type="hidden" name="game_id" id="game-id">
        <strong>Are you sure you want to bring this game back?</strong>




        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
        <input type="submit" class="btn btn-danger" value="Yes" name="submit">
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
      </div><form id="modal-form" action="updateServlet" method="POST" enctype="multipart/form-data">
      <div class="modal-body">
        
        <input type="hidden" name="game_id" id="game-id">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Game Title:</label>
            <input type="text" class="form-control" id="game-title" name="game_title" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Image:</label>
            <input type="file" class="form-control" name="image_file">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Company Name:</label>
            <input type="text" class="form-control" id="company" name="company" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Release Date:</label>
            <input type="date" class="form-control" id="release_date" name="release_date" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Genres:</label>
            <select name="genres" class="form-control selectpicker" multiple="multiple" id="genres"  required>
            <% 
            		for (genres g: genre_list){
            %>
            <option value="<%=g.get_genre_id() %>"><%=g.get_genre_name() %></option>
            <%
            		}
            %>
            </select>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Price:</label>
            <input type="number" step="0.01" min="0.01" class="form-control" id="price" name="price" required>
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Pre-Owned:</label>
          <!--   <input type="text" class="form-control" id="game-title" name="game_title"> -->
            <select name="preowned" class="form-control" id="preowned" required>
            	<option value="0">No</option>
            	<option value="1">Yes</option>
            </select>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">Description:</label>
            <textarea class="form-control" id="description" name="description" required></textarea>
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
<script src="js/gamescript.js"></script> </div>
<%@include file="footer.jsp" %>
