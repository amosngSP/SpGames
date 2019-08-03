<%@include file="header.jsp"%>
<%@ page import="htmlUtils.*"%>
<div class="container-fluid">
	<h1 class="mt-4">Games Report</h1>
	<div class="addgame">
	<form action="stockreport.jsp" method="POST">
<div class="form-group"><label for="qty_report">Games below this Quantity:</label>	<input type="number" min="1" step="1" name="qty_report"></div>
	<input type="submit" name="submit" class="btn btn-primary">
	</form>
	</div>
	<table id="data_table" class="table table-striped"
		style="width: 100%; margin: auto;">
		<thead>
			<tr>
				<th scope="row">Game ID</th>
				<th>Pre Owned</th>
				<th>Game Image</th>
				<th>Game Title</th>
				<th>Company Name</th>
				<th>Release Date</th>
				<th style="width: 500px;">Description</th>
				<th>Genres</th>
				<th>Price</th>
				<th>Quantity</th>
			</tr>
		</thead>
		<tbody>
			<%
			if(request.getParameter("qty_report") != null){
				
			
			SqlDAO DBSQL = new SqlDAOImpl();
				GameDAO Game_DAO = new GameDAOImpl(DBSQL);
				ArrayList<Game> game_list = Game_DAO.GetGamesReport(Integer.parseInt(request.getParameter("qty_report")));
				for (Game game : game_list) {
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
			</tr>
			<%
				}
			}
			%>
		</tbody>
	</table>










</div>
<%@include file="footer.jsp"%>
