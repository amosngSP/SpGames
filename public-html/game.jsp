
<%@ page import="db.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	int gameid = 0;
	try {
		gameid = Integer.parseInt(request.getParameter("game_id"));

	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("index.jsp");
		System.out.println("Validation fail!");
		throw new javax.servlet.jsp.SkipPageException();
	}
	SqlDAO DBSQL = new SqlDAOImpl();
	GameDAO Game_DAO = new GameDAOImpl(DBSQL);
	Game game = Game_DAO.GetGameInfo(gameid);
	CommentDAO Comment_DAO = new CommentDAOImpl(DBSQL);
	ArrayList<Comment> comment_list = Comment_DAO.GetComments(gameid);
	if (game == null) {
		response.sendRedirect("index.jsp");
		System.out.println("Returning null!");
		throw new javax.servlet.jsp.SkipPageException();
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>


<title>HEXGEAR - Buy Pre-owned and New Gamese</title>
<%@ include file="/etc/header-import.html"%>
<style>
.checked {
	color: orange;
}
</style>
</head>
<body>
	<!-- HEADER -->
	<header>
		<!-- TOP HEADER -->
		<%@ include file="/etc/top-header.jsp"%>
		<!-- /TOP HEADER -->

		<!-- MAIN HEADER -->
		<div id="header">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- LOGO -->
					<%@ include file="/etc/logo-import.html"%>
					<!-- /LOGO -->

					<!-- SEARCH BAR -->
					<%@ include file="/etc/searchbar-import.jsp"%>
					<!-- /SEARCH BAR -->

					<!-- ACCOUNT -->
					<div class="col-md-3 clearfix">
						<div class="header-ctn">
							<!-- Wishlist -->
							<!-- /Cart -->

							<!-- Menu Toogle -->
							<div class="menu-toggle">
								<a href="#"> <i class="fa fa-bars"></i> <span>Menu</span>
								</a>
							</div>
							<!-- /Menu Toogle -->
						</div>
					</div>
					<!-- /ACCOUNT -->
				</div>
				<!-- row -->
			</div>
			<!-- container -->
		</div>
		<!-- /MAIN HEADER -->
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<!-- container -->
		<div class="container">
			<!-- responsive-nav -->
			<div id="responsive-nav">
				<!-- NAV -->
				<ul class="main-nav nav navbar-nav">
					<li><a href="index.jsp">Home</a></li>
					<li><a href="search.jsp">Advanced Search</a></li>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
		<!-- /container -->
	</nav>
	<!-- /NAVIGATION -->

	<!-- BREADCRUMB -->
	<div id="breadcrumb" class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<h3 class="breadcrumb-header"><%=game.GetGameTitle()%></h3>
					<ul class="breadcrumb-tree">
						<li><a href="index.jsp">Home</a></li>
					</ul>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /BREADCRUMB -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<%
					if (request.getParameter("success") != null) {
						if (request.getParameter("success").equals("1")) {
				%>
				<div class="alert alert-success">
					<strong>Success!</strong> Your comment has been added in.
				</div>
				<%
					} else if (request.getParameter("success").equals("0")) {
				%>
				<div class="alert alert-danger">
					<strong>Error!</strong> An error occurred and your comment wasn't
					added in.
				</div>
				<%
					}
					}
				%>
				<table style="margin: auto;">
					<tr>
						<td colspan="2" style="text-align: center;"><h1><%=game.GetGameTitle()%></h1></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;"><img
							src="gameimage.jsp?game_id=<%=gameid%>" alt=""
							style="max-width: 80%;"></td>
					</tr>

					<tr>
						<td style="width: 25%;">
							<p>
								<label for="preowned">Pre-Owned:</label>
								<%
									if (game.GetPreOwned() == 0) {
										out.print("No");
									} else {
										out.print("Yes");
									}
								%>
							</p>
							<p>
								<label for="company">Company:</label>
								<%=game.GetCompany()%></p>
							<p>
								<label for="releaseDate">Release Date:</label>
								<%=game.GetReleaseDate()%></p>
						</td>
						<td width="25%;">
							<p>
								<label for="price">Price:</label> $<%=game.GetPrice()%></p>
							<p>
								<label for="genres">Genres:</label>
								<%=game.GetGenres().get(0).GetGenreName()%>
								<%
									for (int i = 1; i < game.GetGenres().size(); i++) {
										out.print(", " + game.GetGenres().get(i).GetGenreName());
									}
								%>
							</p>
							<p>
							<label for="quantity">Quantity Available:</label>
							<%=game.GetQty() %>
							</p>

						</td>
					</tr>

					<tr>
						<td colspan="2"><h2>Description</h2></td>
					</tr>
					<tr>
						<td colspan="2"><%=game.GetDescription()%></td>
					</tr>
				</table>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row" style="width: 50%; margin: auto;">
				<h2>Comments</h2>


				<%
					//Printing comments
					if (!comment_list.isEmpty()) {
				%>
				<table>
					<%
						for (int i = 0; i < comment_list.size(); i++) {
								Comment row = comment_list.get(i);
					%>
					<tr>
						<td>
							<p>
							<h4><%=row.GetUsername()%></h4>
							</p>
							<p><%=row.GetDate()%></p>
							<p>
								<%
									for (int j = 0; j != row.GetRating(); j++) {
								%>
								<span class="fa fa-star checked"></span>
								<%
									}
											for (int k = 0; k != 5 - row.GetRating(); k++) {
								%>
								<span class="fa fa-star"></span>
								<%
									}
								%>

							</p>
							<p><%=row.GetComment()%></p>
						</td>
					</tr>

					<%
						}
					%>
				</table>
				<%
					} else {
				%>
				<h5>Well, there are no comments! Be the first to comment!</h5>
				<%
					}
				%>
				<form action="ServletAddComment" method="POST">
					<input type="hidden" name="game_id" value="<%=gameid%>">
					<div class="form-group">
						<label for="username">Display Name:</label>
						<%
							if (session.getAttribute("name") == null) {
						%>
						<input type="text" name="username" class="form-control" required>
						<%
							} else {
						%>
						<input type="hidden" name="userid" value="<%=session.getAttribute("userid")%>">
						<input type="text" value="<%=session.getAttribute("name")%>"
							class="form-control" disabled>
						<%
							}
						%>
					</div>
					<div class="form-group">
						<label for="rating">Rating:</label> <label class="radio-inline"><input
							type="radio" name="rating" value="0" checked="checked"> 0
							Stars</label><label class="radio-inline"><input type="radio"
							name="rating" value="1" checked="checked">1 Star</label><label
							class="radio-inline"><input type="radio" name="rating"
							value="2" checked="checked"> 2 Stars</label><label
							class="radio-inline"><input type="radio" name="rating"
							value="3" checked="checked"> 3 Stars</label><label
							class="radio-inline"><input type="radio" name="rating"
							value="4" checked="checked"> 4 Stars</label><label
							class="radio-inline"><input type="radio" name="rating"
							value="5" checked="checked"> 5 Stars</label>
					</div>

					<div class="form-group">
						<label for="review">Review:</label>
						<textarea name="review" class="form-control" required></textarea>
					</div>
					<div class="form-group">
						<input type="submit" name="submit" value="Submit"
							class="form-control">
					</div>
				</form>
			</div>
		</div>
	</div>


	<%@include file="etc/footer.html"%>

</body>
</html>
