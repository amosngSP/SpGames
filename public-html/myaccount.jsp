
<%@ page import="db.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	
%>
<%
	if (session.getAttribute("name") == null) {
		response.sendRedirect("index.jsp");
	} else {
%>

<%
	int userid = (int) session.getAttribute("userid");
		UserLoginDAO UserLogin_DAO = new UserLoginDAOImpl();
		UserLogin UserData = UserLogin_DAO.GetUserDetails(userid);
		TransactionDAO Trans_DAO = new TransactionDAOImpl();
		GameDAO Game_DAO = new GameDAOImpl();
		ArrayList<Transaction> purchase_history = Trans_DAO.GetPurchaseHistory(userid);
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
				<div id="accordion">

					<div class="card-header" id="headingOne">
						<h5 class="mb-0">
							<button class="btn btn-link" data-toggle="collapse"
								data-target="#collapseOne" aria-expanded="true"
								aria-controls="collapseOne">Purchase History</button>
						</h5>
					</div>
					<div id="collapseOne" class="collapse show"
						aria-labelledby="headingOne" data-parent="#accordion">
						<div class="card-body">
							<!-- Individual Purchase -->
							<div id="accordion1">


								<%
									int i = 0;
										if (purchase_history != null) {
											Iterator<Transaction> Transaction_Iterator = purchase_history.iterator();
											while (Transaction_Iterator.hasNext()) {
												Transaction t = Transaction_Iterator.next();
												float CartTotal = 0;
												int transid = t.GetTransID();
												String date = t.GetDateTime();
												ArrayList<TransactionData> TransData = t.GetTransDataList();
												Iterator<TransactionData> TransData_Iterator;

													TransData_Iterator = TransData.iterator();
												
								%>
								<div class="card">
									<div class="card-header" id="headingPurchase<%=i%>">
										<h5 class="mb-0">
											<button class="btn btn-link" data-toggle="collapse"
												data-target="#collapsePurchase<%=i%>" aria-expanded="true"
												aria-controls="collapsePurchase<%=i%>">
												Transaction ID:<%=transid%>
												Date and Time:
												<%=date%></button>
										</h5>
									</div>
									<div id="collapsePurchase<%=i%>" class="collapse"
										aria-labelledby="headingPurchase<%=i%>"
										data-parent="#accordion1">
										<div class="card-body">
											<%
												if (TransData_Iterator != null) {
											%>
											<table style="width:100%; font-size:17px;" class="table">
												<tr>
													<th>Game Image</th>
													<th>Game Title</th>
													<th>Price</th>
													<th>Qty</th>
													<th>Total Price</th>
												</tr>
												<%
													while (TransData_Iterator.hasNext()) {
																		TransactionData s = TransData_Iterator.next();
																		int gameid = s.GetGameID();
																		int preowned = s.GetPreOwned();
																		int qty = s.GetQty();
																		String costprice = s.GetCostPrice();
																		Game GameDetails = Game_DAO.GetGameInfo(gameid);
																		String GameTitle = GameDetails.GetGameTitle();
																		float TotalPrice = Float.parseFloat(costprice) * qty;
																		java.util.Formatter formatter = new java.util.Formatter();
																		formatter.format("%.2f", TotalPrice);
																		String TotalPriceFormat = formatter.toString();
																		formatter.close();
																		CartTotal += TotalPrice;
												%>
												<tr>
													<td><img src="gameimage.jsp?game_id=<%=gameid%>" width="150px"></td>
													<td><%=GameTitle%></td>
													<td><%=costprice%></td>
													<td><%=qty%></td>
													<td><%=TotalPriceFormat%></td>
												</tr>
												<%
													}

																	java.util.Formatter formatter = new java.util.Formatter();
																	formatter.format("%.2f", CartTotal);
																	String FormatTotal = formatter.toString();
																	formatter.close();
												%>
												<tr>
													<td colspan="4"><span  style="float:right; font-weight:bold;">Shipping:</span></td>
													<td>FREE</td>
												</tr>
												<tr>
													<td colspan="4"><span  style="float:right; font-weight:bold;">Grand Total:</span></td>
													<td><%=FormatTotal%></td>
												</tr>
											</table>
											<%
												}
											%>
											<!-- This Div Tag closes card-body -->
										</div>
										<!-- This Div Tag closes collapsePurchase{i} -->
									</div>
									<!-- This div tag closes the card -->
									</div>
									<%
										i++;
													/*else {
													//only one item in the arraylist
													TransactionData s = TransData.get(0);
													int gameid = s.GetGameID();
													int preowned = s.GetPreOwned();
													int qty = s.GetQty();
													String costprice = s.GetCostPrice();
													Game GameDetails = Game_DAO.GetGameInfo(gameid);
													String GameTitle = GameDetails.GetGameTitle();
													float TotalPrice = Float.parseFloat(costprice) * qty;
													}*/
									%>

									<%
										}
											} else {
									%>
									You have not bought anything yet!
									<%
										}
									%>






								</div>
								<!-- This should close Accordion 1 -->
								<!-- /Individual Purchase -->
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-header" id="headingTwo">
							<h5 class="mb-0">
								<button class="btn btn-link collapsed" data-toggle="collapse"
									data-target="#collapseTwo" aria-expanded="false"
									aria-controls="collapseTwo">Update Info</button>
							</h5>
						</div>
						<div id="collapseTwo" class="collapse"
							aria-labelledby="headingTwo" data-parent="#accordion">
							<div class="card-body">
								<div style="width: 80%; margin: auto; max-width: 500px;">
									<form action="ServletUserUpdate" method="POST"
										id="register_form">
										<div id="warning"></div>
										<div class="form-group">
											<label for="Username">Username</label> <input type="text"
												class="form-control" aria-describedby="Username"
												value="<%=UserData.GetUsername()%>" disabled>
										</div>
										<div class="form-group">
											<label for="Email">Email address</label> <input type="email"
												class="form-control" name="email" aria-describedby="Email"
												placeholder="Enter email" value="<%=UserData.GetEmail()%>"
												required>
										</div>
										<div class="form-group">
											<label for="Password">Contact Number</label> <input
												type="number" class="form-control" name="contact"
												aria-describedby="Contact Number" placeholder="Password"
												id="contact" min="10000000" max="99999999" step="1"
												value="<%=UserData.GetContactNumber()%>" required>
										</div>
										<div class="form-group">
											<label for="Username">Full Name</label> <input type="text"
												class="form-control" name="displayname"
												aria-describedby="Full Name" id="displayname"
												placeholder="Enter Full Name"
												value="<%=UserData.GetDisplayName()%>" required> <small
												class="form-text text-muted">We will use this name
												to address you.</small>
										</div>

										<div class="form-group">
											<label for="Username">Shipping Address</label>
											<textarea class="form-control" id="address" name="address"
												required><%=UserData.GetAddress()%></textarea>
										</div>

										<input type="submit" class="form-control" value="Submit">
									</form>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>


	<!-- /SECTION -->





	<%@include file="etc/footer.html"%>
	<%
		}
	%>

</body>
</html>
