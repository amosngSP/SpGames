
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
	
	Cart CartList = new Cart((Cart) session.getAttribute("cart_list"));
	CartDAO Cart = new CartDAOImpl();
	int CartQty = Cart.GetGameQtyInCart(CartList, gameid);
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
							<!-- Cart -->
							<%@ include file="/etc/minicart.jsp" %>
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
					if (request.getParameter("status") != null) {
						if (request.getParameter("status").equals("1")) {
				%>
				<div class="alert alert-success">
					<strong>Success!</strong> Your comment has been added in.
				</div>
				<%
					} else if (request.getParameter("status").equals("0")) {
				%>
				<div class="alert alert-danger">
					<strong>Error!</strong> An error occurred and your comment wasn't
					added in.
				</div>
				<%
					}
					}
				%>
				<table style="width:80%;margin: auto;">
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
							</p> <label for="quantity">Quantity Available:</label> <%=game.GetQty()%>
							<form action="ServletCart" method="POST">
							<input type="hidden" name="action" value="buy">
							<input type="hidden" name="gameid" value="<%=gameid%>">
							<input type="hidden" name="origin" value="gamepages">
								<%
								if(session.getAttribute("name") == null){
									%>
									<h5>To purchase this game, please <a href="login.jsp">Login Here</a>. Don't have an account? <a href="register.jsp">Register here.</a></h5>
									<% 
								} else { 
								if(CartQty == 0){
								%> 
								
								<div class="input-group">
									<span class="input-group-btn">
										<button type="button" class="btn btn-danger btn-number"
											data-type="minus" data-field="qty">
											<span class="glyphicon glyphicon-minus"></span>
										</button>
									</span> <input type="text" name="qty"
										class="form-control input-number" value="<%=CartQty %>" min="1"
										max="<%=game.GetQty()%>"> <span
										class="input-group-btn">
										<button type="button" class="btn btn-success btn-number"
											data-type="plus" data-field="qty">
											<span class="glyphicon glyphicon-plus"></span>
										</button>
									</span>
								</div>
								<div>
								<p></p>
								<button type="submit" class="btn btn-outline-secondary"><i class="fas fa-shopping-cart"></i>Add To Cart</button>
								</div>
								<% } else { %>
								<div class="input-group">
									<span class="input-group-btn">
										<button type="button" class="btn btn-danger btn-number"
											data-type="minus" data-field="qty">
											<span class="glyphicon glyphicon-minus"></span>
										</button>
									</span> <input type="text" name="qty"
										class="form-control input-number" value="<%=CartQty %>" min="1"
										max="<%=game.GetQty()%>"> <span
										class="input-group-btn">
										<button type="button" class="btn btn-success btn-number"
											data-type="plus" data-field="qty">
											<span class="glyphicon glyphicon-plus"></span>
										</button>
									</span>
								</div>
								<div>
								<p></p>
								<button type="submit" name="RemoveFromCart" class="btn btn-outline-secondary"><i class="fas fa-shopping-cart"></i>Remove from Cart</button>
								<button type="submit" class="btn btn-outline-secondary"><i class="fas fa-shopping-cart"></i>Update Qty</button>
								</div>
								<%} }%>
								
								
							</form>



						</td>
					</tr>
					<%
					GameVideoDAO GameVideo_DAO = new GameVideoDAOImpl();
					GameVideo Game_Video = GameVideo_DAO.Get_Game_Video(gameid);
					if(Game_Video.GetVideoURL() != null){
					String regexp = "^.*((youtu.be\\/)|(v\\/)|(\\/u\\/\\w\\/)|(embed\\/)|(watch\\?))\\??v?=?([^#\\&\\?]*).";
					String videourl = Game_Video.GetVideoURL();
					String[] VideoURLArray = videourl.split("v=");
					
					%>
					<tr>
					<td colspan="2"><h2>Video for the Game</h2></td>
					</tr>
					<tr>
					<td colspan="2">
					<p align="center">
					<iframe width="560" height="315" src="https://www.youtube.com/embed/<%=VideoURLArray[1] %>?autoplay=1&mute=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
					</p>
					</td>
					</tr>
					<%} %>
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
						<input type="hidden" name="userid"
							value="<%=session.getAttribute("userid")%>"> <input
							type="text" value="<%=session.getAttribute("name")%>"
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
	<script type="text/javascript">
//plugin bootstrap minus and plus
//http://jsfiddle.net/laelitenetwork/puJ6G/
$('.btn-number').click(function(e){
  e.preventDefault();
  
  fieldName = $(this).attr('data-field');
  type      = $(this).attr('data-type');
  var input = $("input[name='"+fieldName+"']");
  var currentVal = parseInt(input.val());
  if (!isNaN(currentVal)) {
      if(type == 'minus') {
          
          if(currentVal > input.attr('min')) {
              input.val(currentVal - 1).change();
          } 
          if(parseInt(input.val()) == input.attr('min')) {
              $(this).attr('disabled', true);
          }

      } else if(type == 'plus') {

          if(currentVal < input.attr('max')) {
              input.val(currentVal + 1).change();
          }
          if(parseInt(input.val()) == input.attr('max')) {
              $(this).attr('disabled', true);
          }

      }
  } else {
      input.val(0);
  }
});
$('.input-number').focusin(function(){
 $(this).data('oldValue', $(this).val());
});
$('.input-number').change(function() {
   
  minValue =  parseInt($(this).attr('min'));
  maxValue =  parseInt($(this).attr('max'));
  valueCurrent = parseInt($(this).val());
  
  name = $(this).attr('name');
  if(valueCurrent >= minValue) {
      $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
  } else {
      alert('Sorry, the minimum value was reached');
      $(this).val($(this).data('oldValue'));
  }
  if(valueCurrent <= maxValue) {
      $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
  } else {
      alert('Sorry, the maximum value was reached');
      $(this).val($(this).data('oldValue'));
  }
  
  
});
$(".input-number").keydown(function (e) {
      // Allow: backspace, delete, tab, escape, enter and .
      if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
           // Allow: Ctrl+A
          (e.keyCode == 65 && e.ctrlKey === true) || 
           // Allow: home, end, left, right
          (e.keyCode >= 35 && e.keyCode <= 39)) {
               // let it happen, don't do anything
               return;
      }
      // Ensure that it is a number and stop the keypress
      if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
          e.preventDefault();
      }
  });
</script>
</body>
</html>
