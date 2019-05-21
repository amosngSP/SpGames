            <%@ page import ="db.*" %>
                    <%@ page import ="java.util.ArrayList" %>
    <%
    int gameid = 0;
    try {
    	gameid = Integer.parseInt(request.getParameter("game_id"));
    	
    } catch (Exception e){
    	e.printStackTrace();
    	response.sendRedirect("index.jsp");
    	throw new javax.servlet.jsp.SkipPageException();
    }
    Spgames con = new Spgames();
    con.setValues();
    game_entry game = con.get_game_info(gameid);
    ArrayList<comment> comment_list = con.get_comments(gameid);
    if (game == null){response.sendRedirect("index.jsp"); throw new javax.servlet.jsp.SkipPageException();}

    	
    
    %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>Electro - HTML Ecommerce Template</title>

 		<!-- Google font -->
 		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

 		<!-- Bootstrap -->
 		<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

 		<!-- Slick -->
 		<link type="text/css" rel="stylesheet" href="css/slick.css"/>
 		<link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

 		<!-- nouislider -->
 		<link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

 		<!-- Font Awesome Icon -->
 		<link rel="stylesheet" href="css/font-awesome.min.css">

 		<!-- Custom stlylesheet -->
 		<link type="text/css" rel="stylesheet" href="css/style.css"/>

 		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
 		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
 		<!--[if lt IE 9]>
 		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
 		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
 		<![endif]-->
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
			<div id="top-header">
				<div class="container">
					<ul class="header-links pull-right">
						<li><a href="admin"><i class="fas fa-sign-in-alt"></i>Admin Log-in</a></li>
					</ul>
				</div>
			</div>
			<!-- /TOP HEADER -->

			<!-- MAIN HEADER -->
			<div id="header">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<!-- LOGO -->
						<%@ include file="/etc/logo-import.html" %>
						<!-- /LOGO -->

						<!-- SEARCH BAR -->
						<%@ include file="/etc/searchbar-import.jsp" %>
						<!-- /SEARCH BAR -->

						<!-- ACCOUNT -->
						<div class="col-md-3 clearfix">
							<div class="header-ctn">
								<!-- Wishlist -->
								<!-- /Cart -->

								<!-- Menu Toogle -->
								<div class="menu-toggle">
									<a href="#">
										<i class="fa fa-bars"></i>
										<span>Menu</span>
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
						<h3 class="breadcrumb-header"><%= game.get_game_title() %></h3>
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
					<%if (request.getParameter("success") != null){ if(request.getParameter("success").equals("1")){%>
				<div class="alert alert-success">
  <strong>Success!</strong> Your comment has been added in.
</div>	
<% }else if(request.getParameter("success").equals("0")){
%>	
<div class="alert alert-danger">
  <strong>Error!</strong> An error occurred and your comment wasn't added in.
</div>	
<% 
} }%>
				<table style="margin:auto;"> 
				<tr><td colspan="2" style="text-align:center;"><h1><%= game.get_game_title()%></h1></td></tr>
				<tr><td colspan="2" style="text-align:center;"><img src="gameimage.jsp?game_id=<%= gameid%>" alt="" style="max-width:80%;"></td></tr>
				
				<tr><td style="width: 25%;">
				<p><label for="preowned">Pre-Owned:</label><% if(game.get_preowned() == 0){out.print("No");} else{out.print("Yes");} %>  </p>
				<p><label for="company">Company:</label> <%=game.get_company() %></p>
				<p><label for="releaseDate">Release Date:</label> <%=game.get_release_date() %></p>
				</td>
				<td width="25%;">
				<p><label for="price">Price:</label> $<%=game.get_price() %></p>
				<p><label for="genres">Genres:</label> <%=game.get_genres().get(0).get_genre_name() %><% for(int i =1; i < game.get_genres().size(); i++){
					out.print(", "+game.get_genres().get(i).get_genre_name());
				} %></p>
				
				</td></tr>
				
				<tr><td colspan="2"><h2>Description</h2></td></tr>
				<tr><td colspan="2"><%= game.get_description() %></td></tr>
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
				<div class="row" style="width: 50%; margin:auto;">
				<h2>Comments</h2> 
			

				<% 
//Printing comments
if(!comment_list.isEmpty()){
%>
<table>
<% 
for (int i = 0; i<comment_list.size(); i++){
	comment row = comment_list.get(i);
	%>
	<tr><td>
	<p><h4><%=row.get_username() %></h4></p>
	<p><%=row.get_date() %></p>
	<p>
	<%
	for (int j = 0; j != row.get_rating(); j++){
		%>
		<span class="fa fa-star checked"></span>
		<% 
	}
	for (int k = 0; k != 5-row.get_rating(); k++){
		%>
		<span class="fa fa-star"></span>
		<% 
	}
	%>
	
	</p>
	<p><%= row.get_review() %></p>
	</td></tr>
	
	<% 

}
	%>
	</table>
	<% 
}
else {
	%>
	<h5>Well, there are no comments! Be the first to comment!</h5>
	<% 
}
     
%>  
<form action="addcomment.jsp" method="POST">
<input type="hidden" name="game_id" value="<%= gameid%>">
<div class="form-group">
<label for="username">Username:</label> <input type="text" name="username" class="form-control" required>
</div>
<div class="form-group">
<label for="rating">Rating:</label> <label class="radio-inline"><input type="radio" name="rating" value="0" checked="checked"> 0 Stars</label><label class="radio-inline"><input type="radio" name="rating" value="1" checked="checked">1 Star</label><label class="radio-inline"><input type="radio" name="rating" value="2" checked="checked"> 2 Stars</label><label class="radio-inline"><input type="radio" name="rating" value="3" checked="checked"> 3 Stars</label><label class="radio-inline"><input type="radio" name="rating" value="4" checked="checked"> 4 Stars</label><label class="radio-inline"><input type="radio" name="rating" value="5" checked="checked"> 5 Stars</label>
  </div>
 
 <div class="form-group"> <label for="review">Review:</label>
  <textarea name="review" class="form-control" required></textarea></div>
 <div class="form-group"> <input type="submit" name="submit" value="Submit" class="form-control"></div>
</form>
				</div>
			</div>
		</div>


		<!-- FOOTER -->
		<footer id="footer">
			<!-- top footer -->
			<div class="section">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<div class="col-md-3 col-xs-6">
							<div class="footer">
								<h3 class="footer-title">About Us</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut.</p>
								<ul class="footer-links">
									<li><a href="#"><i class="fa fa-map-marker"></i>1734 Stonecoal Road</a></li>
									<li><a href="#"><i class="fa fa-phone"></i>+021-95-51-84</a></li>
									<li><a href="#"><i class="fa fa-envelope-o"></i>email@email.com</a></li>
								</ul>
							</div>
						</div>

						<div class="col-md-3 col-xs-6">
							<div class="footer">
								<h3 class="footer-title">Categories</h3>
								<ul class="footer-links">
									<li><a href="#">Hot deals</a></li>
									<li><a href="#">Laptops</a></li>
									<li><a href="#">Smartphones</a></li>
									<li><a href="#">Cameras</a></li>
									<li><a href="#">Accessories</a></li>
								</ul>
							</div>
						</div>

						<div class="clearfix visible-xs"></div>

						<div class="col-md-3 col-xs-6">
							<div class="footer">
								<h3 class="footer-title">Information</h3>
								<ul class="footer-links">
									<li><a href="#">About Us</a></li>
									<li><a href="#">Contact Us</a></li>
									<li><a href="#">Privacy Policy</a></li>
									<li><a href="#">Orders and Returns</a></li>
									<li><a href="#">Terms & Conditions</a></li>
								</ul>
							</div>
						</div>

						<div class="col-md-3 col-xs-6">
							<div class="footer">
								<h3 class="footer-title">Service</h3>
								<ul class="footer-links">
									<li><a href="#">My Account</a></li>
									<li><a href="#">View Cart</a></li>
									<li><a href="#">Wishlist</a></li>
									<li><a href="#">Track My Order</a></li>
									<li><a href="#">Help</a></li>
								</ul>
							</div>
						</div>
					</div>
					<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /top footer -->

			<!-- bottom footer -->
			<div id="bottom-footer" class="section">
				<div class="container">
					<!-- row -->
					<div class="row">
						<div class="col-md-12 text-center">
							<ul class="footer-payments">
								<li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
								<li><a href="#"><i class="fa fa-credit-card"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
							</ul>
							<span class="copyright">
								<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
								Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							</span>


						</div>
					</div>
						<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /bottom footer -->
		</footer>
		<!-- /FOOTER -->

		<!-- jQuery Plugins -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/slick.min.js"></script>
		<script src="js/nouislider.min.js"></script>
		<script src="js/jquery.zoom.min.js"></script>
		<script src="js/main.js"></script>

	</body>
</html>
