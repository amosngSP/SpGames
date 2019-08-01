
<%@ page import="db.*"%>
<%@ page import="htmlUtils.*"%>
<%@ page import="java.util.ArrayList"%>
         <% if(session.getAttribute("name")!= null){response.sendRedirect("index.jsp");} %>
<!DOCTYPE html>
<html lang="en">
<head>


<title>HEXGEAR - Buy Pre-owned and New Games</title>
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
		<%@ include file="/etc/top-header.jsp" %>
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
					<h3 class="breadcrumb-header">Login</h3>
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
				<div style="width: 80%; margin: auto; max-width: 500px;">
					<form action="ServletLogin" method="POST">
						<% 
						if(request.getParameter("fail")!= null){
						if(request.getParameter("fail").equals("1")) {
							BootstrapAlerts Alerts = new BootstrapAlerts();
							out.print(Alerts.CritAlert("Invalid Username/Email or Password!"));
							}
						}
						%>
						<div class="form-group">
							<label for="Username">Username/Email</label> <input type="text"
								class="form-control" name="username" aria-describedby="Username"
								placeholder="Enter Username" required>
						</div>
						<div class="form-group">
							<label for="Password">Password</label> <input type="password"
								class="form-control" name="password" aria-describedby="Password"
								placeholder="Password" required>
						</div>
	

						<input type="submit" class="form-control" name="submit" value="Submit">
					</form>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->





	<%@include file="etc/footer.html"%>

</body>
</html>
