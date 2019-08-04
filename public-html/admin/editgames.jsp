<%@include file="header.jsp"%>
<%@ page import="htmlUtils.*"%>
<div class="container-fluid">
	<h1 class="mt-4">Edit Games</h1>
	<%
		SqlDAO DBSQL = new SqlDAOImpl();
		BootstrapAlerts Alerts = new BootstrapAlerts();
		if (request.getParameter("success") != null) {

			if (request.getParameter("success").equals("1")) {
				out.print(Alerts.SuccessAlert("The data has been updated!"));
			} else if (request.getParameter("success").equals("2")) {
				out.print(Alerts.SuccessAlert("The game entry has been deleted."));
			} else if (request.getParameter("success").equals("3")) {
				out.print(Alerts.SuccessAlert("The game entry has been added."));
			} else if (request.getParameter("success").equals("4")) {
				out.print(Alerts.SuccessAlert("The game entry has been brought back from the dead."));
			} else if (request.getParameter("success").equals("5")) {
				out.print(Alerts.SuccessAlert("The game image has been deleted."));
			}
		} else if (request.getParameter("fail") != null) {
			if (request.getParameter("fail").equals("1")) {
				out.print(Alerts.CritAlert("There was an error while trying to update the game."));
			} else if (request.getParameter("fail").equals("2")) {
				out.print(Alerts.CritAlert("There was an error while trying to delete the game."));
			} else if (request.getParameter("fail").equals("3")) {
				out.print(Alerts.CritAlert("File size too big! Please choose a smaller file."));
			} else if (request.getParameter("fail").equals("3a")) {
				out.print(Alerts.CritAlert("There was an error while trying to create the game."));
			} else if (request.getParameter("fail").equals("3b")) {
				out.print(Alerts.CritAlert("There was an error while trying to upload the video game url."));
			} else if (request.getParameter("fail").equals("4")) {
				out.print(Alerts.CritAlert("Game decided to stay dead, it thought it was playing dead."));
			} else if (request.getParameter("fail").equals("5")) {
				out.print(Alerts.CritAlert("There was an error while trying to delete the image."));
			}
		}
	%>
	<div class="addgame">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#addModal">Add game</button>
		<%
			if (request.getParameter("del") == null) {
		%>
		<a href="editgames.jsp?del=1" class="btn btn-primary">See deleted
			entries too</a>
		<%
			} else if (request.getParameter("del").equals("1")) {
		%>
		<a href="editgames.jsp" class="btn btn-primary">See not deleted
			entries only</a>
		<%
			}
		%>
	</div>
	<table id="data_table" class="table table-striped"
		style="width: 100%; margin: auto;">
		<thead>
			<tr>
				<th scope="row">Game ID</th>
				<th>Pre Owned</th>
				<th>Game Image</th>
				<th>Game Title</th>
				<th>Video URL</th>
				<th>Company Name</th>
				<th>Release Date</th>
				<th style="width: 500px;">Description</th>
				<th>Genres</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Deleted</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<%
				int del = 0;
				//ArrayList<game_entry> game_list = dbcon.return_all_gamesList();
				if (request.getParameter("del") != null) {
					if (request.getParameter("del").equals("0")) {
						del = 0;
					} else if (request.getParameter("del").equals("1")) {
						del = 1;
					}
				}
				GameDAO Game_DAO = new GameDAOImpl(DBSQL);
				GameVideoDAO GameVideo_DAO = new GameVideoDAOImpl(DBSQL);
				ArrayList<Game> game_list = Game_DAO.GetGamesList(0);
				for (Game game : game_list) {
					GameVideo GameVideo_Temp = GameVideo_DAO.Get_Game_Video(game.GetGameID());
			%>
			<tr id="<%=game.GetGameID()%>">
				<td><%=game.GetGameID()%></td>
				<td>
					<%
						if (game.GetPreOwned() == 1) {
								out.print("Yes");
							} else {
								out.print("No");
							}
					%>
				</td>
				<td><img src="gameimage.jsp?game_id=<%=game.GetGameID()%>"
					width="100"></td>
				<td><%=game.GetGameTitle()%></td>
				<td>
					<%
						if (GameVideo_Temp.GetVideoURL() == null) {
								out.print("No URL");
							} else {
								out.print(GameVideo_Temp.GetVideoURL());
							}
					%>
				</td>
				<td><%=game.GetCompany()%></td>
				<td><%=game.GetReleaseDate()%></td>
				<td><%=game.GetDescription()%></td>
				<td>
					<%
						String genre_ids = "";
							for (Genres s : game.GetGenres()) {
								out.print(s.GetGenreName() + ", ");
								genre_ids = genre_ids + s.GetGenreID() + " ";
							}
					%>
				</td>
				<td><%=game.GetPrice()%></td>
				<td><%=game.GetQty()%></td>
				<td><%=game.GetDeleted()%></td>
				<td><button type="button" class="btn btn-primary"
						data-toggle="modal" data-target="#editModal"
						data-gameid="<%=game.GetGameID()%>"
						data-gametitle="<%=game.GetGameTitle()%>"
						data-videourl="<%if (GameVideo_Temp.GetVideoURL() == null) {
				} else {
					out.print(GameVideo_Temp.GetVideoURL());
				}%>"
						data-company="<%=game.GetCompany()%>"
						data-releasedate="<%=game.GetReleaseDate()%>"
						data-description="<%=game.GetDescription()%>"
						data-price="<%=game.GetPrice()%>"
						data-preowned="<%=game.GetPreOwned()%>"
						data-genres="<%=genre_ids.trim()%>" data-qty="<%=game.GetQty()%>">Edit</button>
					<button type="button" class="btn btn-danger" data-toggle="modal"
						data-target="#deleteImageModal"
						data-gameid="<%=game.GetGameID()%>">Delete Image</button> <%
 	if (game.GetDeleted() == 0) {
 %>
					<button type="button" class="btn btn-danger" data-toggle="modal"
						data-target="#deleteModal" data-gameid="<%=game.GetGameID()%>">Delete</button>
					<%
						} else {
					%>
					<button type="button" class="btn btn-danger" data-toggle="modal"
						data-target="#UNdeleteModal" data-gameid="<%=game.GetGameID()%>">Undo
						Delete</button> <%
 	}
 %></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>

	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Add game</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="modal-form" action="ServletUpload" method="POST"
					enctype="multipart/form-data">
					<div class="modal-body">

						<input type="hidden" name="game_id" id="game-id">
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Game
								Title:</label> <input type="text" class="form-control" id="game-title"
								name="game_title" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Video
								URL:</label> <input type="text" class="form-control" id="video-url"
								name="video_url" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Image:</label>
							<input type="file" class="form-control" name="image_file">
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Company
								Name:</label> <input type="text" class="form-control" id="company"
								name="company" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Release
								Date:</label> <input type="date" class="form-control" id="release_date"
								name="release_date" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Genres:</label>
							<select name="genres" class="form-control selectpicker"
								multiple="multiple" id="genres" required>
								<%
									ArrayList<Genres> genre_list = new ArrayList<Genres>();
									GenresDAO Genres_DAO = new GenresDAOImpl(DBSQL);
									genre_list = Genres_DAO.GetGenresList(0);
									for (Genres g : genre_list) {
								%>
								<option value="<%=g.GetGenreID()%>"><%=g.GetGenreName()%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Price:</label>
							<input type="number" step="0.01" min="0.01" class="form-control"
								id="price" name="price" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Quantity:</label>
							<input type="number" step="1" min="0" class="form-control"
								id="qty" name="qty" required> <small
								class="form-text text-muted">Setting the Quantity to '0'
								will reflect it as sold out!</small>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Pre-Owned:</label>
							<select name="preowned" class="form-control" id="preowned"
								required>
								<option value="0">No</option>
								<option value="1">Yes</option>
							</select>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">Description:</label>
							<textarea class="form-control" id="description"
								name="description" required></textarea>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<input type="submit" class="btn btn-primary" value="Submit"
							name="submit">
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Editing</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="modal-form" action="ServletUpdate" method="POST"
					enctype="multipart/form-data">
					<div class="modal-body">

						<input type="hidden" name="game_id" id="game-id">
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Game
								Title:</label> <input type="text" class="form-control" id="game-title"
								name="game_title" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Video
								URL:</label> <input type="text" class="form-control" id="video-url"
								name="video_url" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Image:</label>
							<input type="file" class="form-control" name="image_file">
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Company
								Name:</label> <input type="text" class="form-control" id="company"
								name="company" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Release
								Date:</label> <input type="date" class="form-control" id="release_date"
								name="release_date" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Genres:</label>
							<select name="genres" class="form-control selectpicker"
								multiple="multiple" id="genres" required>
								<%
									for (Genres g : genre_list) {
								%>
								<option value="<%=g.GetGenreID()%>"><%=g.GetGenreName()%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Price:</label>
							<input type="number" step="0.01" min="0.01" class="form-control"
								id="price" name="price" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Quantity:</label>
							<input type="number" step="1" min="0" class="form-control"
								id="qty" name="qty" required> <small
								class="form-text text-muted">Setting the Quantity to '0'
								will reflect it as sold out!</small>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">Pre-Owned:</label>
							<!--   <input type="text" class="form-control" id="game-title" name="game_title"> -->
							<select name="preowned" class="form-control" id="preowned"
								required>
								<option value="0">No</option>
								<option value="1">Yes</option>
							</select>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">Description:</label>
							<textarea class="form-control" id="description"
								name="description" required></textarea>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<input type="submit" class="btn btn-primary" value="Submit"
							name="submit">
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="deleteImageModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Deleting</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="modal-form" action="ServletDeleteImage" method="POST">

					<div class="modal-body">
						<input type="hidden" name="gameid" id="game-id"> <strong>Are
							you sure you want to remove the image for this game?</strong>
						<p>This action cannot be undone!</p>




					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<input type="submit" class="btn btn-danger" value="Delete Image"
							name="submit">
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Deleting</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="modal-form" action="ServletGameDelete" method="POST">
					<div class="modal-body">
						<input type="hidden" name="game_id" id="game-id"> <strong>Are
							you sure you want to delete this game?</strong>
						<p>This action cannot be undone!</p>




					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<input type="submit" class="btn btn-danger" value="Delete"
							name="submit">
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="UNdeleteModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Deleting</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="modal-form" action="ServletGameUnDelete" method="POST">
					<div class="modal-body">
						<input type="hidden" name="game_id" id="game-id"> <strong>Are
							you sure you want to bring this game back?</strong>





					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">No</button>
						<input type="submit" class="btn btn-danger" value="Yes"
							name="submit">
					</div>
				</form>
			</div>
		</div>
	</div>


	<script src="js/gamescript.js"></script>
</div>
<%@include file="footer.jsp"%>
