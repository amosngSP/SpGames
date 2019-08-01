
<%@ page import="db.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	
%>
         <% if(session.getAttribute("name")== null){response.sendRedirect("index.jsp");} else{ %>
         
         <%
         	int userid = (int) session.getAttribute("userid");
         UserLoginDAO UserLogin_DAO = new UserLoginDAOImpl();
         UserLogin UserData = UserLogin_DAO.GetUserDetails(userid);
         %>
<!DOCTYPE html>
<html lang="en">
<head>


<title>HEXGEAR - Buy Pre-owned and New Games</title>
<%@ include file="/etc/header-import.html"%>
<!-- <script type="text/javascript" src="js/inputvalidation.js"></script>-->
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
					<h3 class="breadcrumb-header">My Account</h3>
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
					<form action="ServletUserUpdate" method="POST" id="register_form">
						<div id="warning"></div>
						<div class="form-group">
							<label for="Username">Username</label> <input type="text"
								class="form-control" aria-describedby="Username"
								value="<%=UserData.GetUsername() %>" disabled>
						</div>
						<div class="form-group">
							<label for="Email">Email address</label> <input type="email"
								class="form-control" name="email" aria-describedby="Email"
								placeholder="Enter email" value="<%=UserData.GetEmail() %>" required>
						</div>
						<div class="form-group">
							<label for="Password">Contact Number</label> <input type="number"
								class="form-control" name="contact" aria-describedby="Contact Number"
								placeholder="Password" id="contact" min="10000000" max="99999999" step="1" value="<%=UserData.GetContactNumber()%>"required>
						</div>
						<div class="form-group">
							<label for="Username">Full Name</label> <input type="text"
								class="form-control" name="displayname"
								aria-describedby="Full Name" id="displayname" placeholder="Enter Full Name" value="<%=UserData.GetDisplayName() %>" required>
							<small class="form-text text-muted">We will use this name
								to address you.</small>
						</div>

						<div class="form-group">
							<label for="Username">Shipping Address</label>
							<textarea class="form-control" id="address" name="address" required><%=UserData.GetAddress() %></textarea>
						</div>

						<input type="submit" class="form-control" value="Submit">
					</form>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->





	<%@include file="etc/footer.html"%>
<%} %>
</body>
</html>
