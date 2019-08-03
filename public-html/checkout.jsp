
<%@ page import="db.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	Cart cartItemList = new Cart((Cart) session.getAttribute("cart_list"));
	if (session.getAttribute("name") == null) {
		response.sendRedirect("index.jsp");
	} else if (session.getAttribute("cart_list") == null) {
		response.sendRedirect("displaycart.jsp");
	} else {
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
							<%@ include file="/etc/minicart.jsp"%>
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
					<h3 class="breadcrumb-header">Checkout</h3>
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
				<form action="ServletCheckout" method="POST">
					<div class="col-md-7">
						<!-- Billing Details -->
						<div class="billing-details">
							<div class="section-title">
								<h3 class="title">Review your Billing Information</h3>
							</div>
							<%
								int userid = (int) session.getAttribute("userid");
									UserLoginDAO UserLogin_DAO = new UserLoginDAOImpl();
									UserLogin UserData = UserLogin_DAO.GetUserDetails(userid);
							%>

							<div class="form-group col-md-12">
								<label for="Email">Email address</label> <input type="email"
									class="form-control" aria-describedby="Email"
									placeholder="Enter email" value="<%=UserData.GetEmail()%>"
									disabled>
							</div>
							<div class="form-group col-md-12">
								<label for="Password">Contact Number</label> <input
									type="number" class="form-control"
									aria-describedby="Contact Number" placeholder="Password"
									id="contact" min="10000000" max="99999999" step="1"
									value="<%=UserData.GetContactNumber()%>" disabled>
							</div>
							<div class="form-group col-md-12">
								<label for="Username">Full Name</label> <input type="text"
									class="form-control" aria-describedby="Full Name"
									id="displayname" placeholder="Enter Full Name"
									value="<%=UserData.GetDisplayName()%>" disabled> <small
									class="form-text text-muted">We will use this name on
									your parcel.</small>
							</div>

							<div class="form-group col-md-12">
								<label for="Username">Shipping Address</label>
								<textarea class="form-control" id="address" disabled><%=UserData.GetAddress()%></textarea>
							</div>

						</div>
						<!-- /Billing Details -->

						<!-- Shipping Details -->
						<div class="shiping-details">
							<div class="section-title">
								<h3 class="title">Credit Card Information</h3>
							</div>
							<div class="form-group col-md-12">
								<label for="Card No">Card Number</label> <input type="number"
									class="form-control" name="creditcard"
									aria-describedby="Full Name" id="displayname"
									placeholder="Enter Credit Card Number"> <small
									class="form-text text-muted">We will never share your
									credit card information with anyone else.</small>
							</div>
							<div class="form-group col-md-12">
								<label for="NameOnCard">Name on Card</label> <input type="text"
									class="form-control" name="creditcard"
									aria-describedby="Full Name" id="displayname"
									placeholder="Enter Credit Card Number">
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="expiration-date">Expiration Date</label> <input
										type="date" class="form-control"
										placeholder="Enter Expiration Date">
								</div>
								<div class="form-group col-md-6">
									<label for="CVV">Security Code</label> <input type="number"
										class="form-control" placeholder="Enter your Security Code">
								</div>
							</div>
						</div>
						<!-- /Shipping Details -->
					</div>

					<!-- Order Details -->
					<div class="col-md-5 order-details">
						<div class="section-title text-center">
							<h3 class="title">Your Order</h3>
						</div>
						<div class="order-summary">
							<div class="order-col">
								<div>
									<strong>PRODUCT</strong>
								</div>
								<div>
									<strong>TOTAL</strong>
								</div>
							</div>
							<div class="order-products">
								<%
									Iterator<Item> Item_Iterator = cartItemList.GetIterator();
										GameDAO Game_DAO = new GameDAOImpl();
										float final_total = 0;
										while (Item_Iterator.hasNext()) {
											Item temp = Item_Iterator.next();
											Game Game_Details = Game_DAO.GetGameInfo(temp.GetGameID());
											float item_total = Float.parseFloat(Game_Details.GetPrice()) * temp.GetQty();
											final_total += item_total;
											java.util.Formatter formatter = new java.util.Formatter();
											formatter.format("%.2f", item_total);
											String FormatTotal = formatter.toString();
											formatter.close();
								%>
								<div class="order-col">
									<div><%=temp.GetQty()%>x
										<%=Game_Details.GetGameTitle()%></div>
									<div>
										$<%=FormatTotal%></div>
								</div>
								<%
									}
										java.util.Formatter formatter = new java.util.Formatter();
										formatter.format("%.2f", final_total);
										String FormatTotal = formatter.toString();
										formatter.close();
								%>
							</div>
							<div class="order-col">
								<div>Shipping</div>
								<div>
									<strong>FREE</strong>
								</div>
							</div>
							<div class="order-col">
								<div>
									<strong>TOTAL</strong>
								</div>
								<div>
									<strong class="order-total">$<%=FormatTotal%></strong>
								</div>
							</div>
						</div>
						<div class="input-checkbox">
							<input type="checkbox" id="terms"> <label for="terms">
								<span></span> I've read and accept the <a href="#">terms &
									conditions</a>
							</label>
						</div>
						<button type="submit" class="primary-btn order-submit">Place
							order</button>
					</div>
					<!-- /Order Details -->
				</form>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->





	<%@include file="etc/footer.html"%>

</body>
</html>
<%
	}
%>