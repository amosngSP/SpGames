<%@ page import = "htmlUtils.BootstrapAlerts" %>
<%@ page import="db.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	SqlDAO DBSQL = new SqlDAOImpl();
	GameDAO Games_DAO = new GameDAOImpl(DBSQL);
	ArrayList<Game> games = Games_DAO.GetGamesList(0);
	ArrayList<Game> preownedgames = Games_DAO.GetPreownedGamesList(1);
	ArrayList<Game> newgames = Games_DAO.GetPreownedGamesList(0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>HEXGEAR - Buy Pre-owned and New Games</title>
<%@ include file="/etc/header-import.html"%>
<style type="text/css">
.product-img {
	display: flex;
	align-items: center;
	justify-content: center;
}

.product-img img {
	max-width: 260px;
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
					<li class="active"><a href="index.jsp">Home</a></li>
					<li><a href="search.jsp">Advanced Search</a></li>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
		<!-- /container -->
	</nav>
	<!-- /NAVIGATION -->

	<%
		if (games.size() > 3 || games.size() == 3) {
	%>
	<div class="section">
		<div class="container" style="text-align: center;">

			<div class="banner-slider col-12" id="banner-slider">

				<div class="banner-slide">
					<a href="game.jsp?game_id=<%=games.get(1).GetGameID()%>"><img
						alt="<%=games.get(1).GetGameTitle()%>" width="500px"
						src="gameimage.jsp?game_id=<%=games.get(1).GetGameID()%>" /></a>
				</div>
				<div class="banner-slide">
					<a href="game.jsp?game_id=<%=games.get(2).GetGameID()%>"><img
						alt="<%=games.get(2).GetGameTitle()%>" width="500px"
						src="gameimage.jsp?game_id=<%=games.get(2).GetGameID()%>" /></a>
				</div>
				<div class="banner-slide">
					<a href="game.jsp?game_id=<%=games.get(3).GetGameID()%>"><img
						alt="<%=games.get(3).GetGameTitle()%>" width="500px"
						src="gameimage.jsp?game_id=<%=games.get(3).GetGameID()%>" /></a>
				</div>

			</div>

		</div>
	</div>
	<%
		}
	%>
	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">

				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
						<h3 class="title">Games for Sale</h3>
						<div class="section-nav">
							<ul class="section-tab-nav tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1"
									id="linktab1">All</a></li>
								<%
									if (!newgames.isEmpty()) {
								%><li><a data-toggle="tab"
									href="#tab2" id="linktab2">Brand New Games</a></li>
								<%
									}
								%>
								<%
									if (!preownedgames.isEmpty()) {
								%><li><a data-toggle="tab"
									href="#tab3" id="linktab3">Pre-Owned Games</a></li>
								<%
									}
								%>
							</ul>
						</div>
					</div>
				</div>
				<!-- /section title -->

				<!-- Products tab & slick -->
				<div class="col-md-12">
					<div class="row">
						<div class="products-tabs">

							<!-- tab -->
							<div role="tabpanel" id="tab1" class="tab-pane active">
								<div class="products-slick" data-nav="#slick-nav-1">

									<%
										if (games.isEmpty()) {
											out.print("There are no games to show.");
										} else {

											for (int i = 0; i < games.size(); i++) {
												Game row = games.get(i);
									%>
									<!-- product -->
									<div class="product">
										<div class="product-img">

											<a href="game.jsp?game_id=<%=row.GetGameID()%>"><img
												src="gameimage.jsp?game_id=<%=row.GetGameID()%>" alt=""
												style=""></a>

										</div>
										<div class="product-body">
											<p class="product-category">
												<%
													if (row.GetPreOwned() == 0) {
																out.print("Brand New");
															} else {
																out.print("Pre-Owned");
															}
												%>
											</p>
											<h3 class="product-name">
												<a href="game.jsp?game_id=<%=row.GetGameID()%>"><%=row.GetGameTitle()%></a>
											</h3>
											<h4 class="product-price"><%=row.GetPrice()%></h4>
										</div>
									</div>
									<!-- /product -->
									<%
										}
										}
									%>




								</div>
								<div id="slick-nav-1" class="products-slick-nav"></div>
							</div>
							<!-- /tab -->

							<!-- tab -->
							<div role="tabpanel" id="tab2" class="tab-pane fade">
								<div class="products-slick2" data-nav="#slick-nav-2">

									<%
										if (newgames.isEmpty()) {
											out.print("There are no games to show.");
										} else {

											for (int i = 0; i < newgames.size(); i++) {
												Game row = newgames.get(i);
									%>
									<!-- product -->
									<div class="product">
										<div class="product-img">

											<a href="game.jsp?game_id=<%=row.GetGameID()%>"><img
												src="gameimage.jsp?game_id=<%=row.GetGameID()%>" alt=""
												style=""> </a>
										</div>
										<div class="product-body">
											<p class="product-category">
												<%
													if (row.GetPreOwned() == 0) {
																out.print("Brand New");
															} else {
																out.print("Pre-Owned");
															}
												%>
											</p>
											<h3 class="product-name">
												<a href="game.jsp?game_id=<%=row.GetGameID()%>"><%=row.GetGameTitle()%></a>
											</h3>
											<h4 class="product-price"><%=row.GetPrice()%></h4>
										</div>
									</div>
									<!-- /product -->
									<%
										}
										}
									%>




								</div>
								<div id="slick-nav-2" class="products-slick-nav"></div>
							</div>
							<!-- /tab -->
							<!-- tab -->
							<div role="tabpanel" id="tab3" class="tab-pane fade">
								<div class="products-slick3" data-nav="#slick-nav-3">

									<%
										if (preownedgames.isEmpty()) {
											out.print("There are no games to show.");
										} else {

											for (int i = 0; i < preownedgames.size(); i++) {
												Game row = preownedgames.get(i);
									%>
									<!-- product -->
									<div class="product">
										<div class="product-img">
											<a href="game.jsp?game_id=<%=row.GetGameID()%>"> <img
												src="gameimage.jsp?game_id=<%=row.GetGameID()%>" alt=""
												style="">
											</a>
										</div>
										<div class="product-body">
											<p class="product-category">
												<%
													if (row.GetPreOwned() == 0) {
																out.print("Brand New");
															} else {
																out.print("Pre-Owned");
															}
												%>
											</p>
											<h3 class="product-name">
												<a href="game.jsp?game_id=<%=row.GetGameID()%>"><%=row.GetGameTitle()%></a>
											</h3>
											<h4 class="product-price"><%=row.GetPrice()%></h4>
										</div>
									</div>
									<!-- /product -->
									<%
										}
										}
									%>




								</div>
								<div id="slick-nav-3" class="products-slick-nav"></div>
							</div>
							<!-- /tab -->
						</div>
					</div>
				</div>
				<!-- Products tab & slick -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->





	<%@include file="etc/footer.html"%>


	<script>
		
	<%if (newgames.size() != 0) {%>
		$('.products-slick2').each(function() {
			var $this = $(this), $nav = $this.attr('data-nav');

			$this.slick({
				slidesToShow : 4,
				slidesToScroll : 1,
				autoplay : true,
				infinite : true,
				speed : 300,
				dots : false,
				arrows : true,
				appendArrows : $nav ? $nav : false,
				responsive : [ {
					breakpoint : 991,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 1,
					}
				}, {
					breakpoint : 480,
					settings : {
						slidesToShow : 1,
						slidesToScroll : 1,
					}
				}, ]
			});
		});
	<%}
			if (preownedgames.size() != 0) {%>
		$('.products-slick3').each(function() {
			var $this = $(this), $nav = $this.attr('data-nav');

			$this.slick({
				slidesToShow : 4,
				slidesToScroll : 1,
				autoplay : true,
				infinite : true,
				speed : 300,
				dots : false,
				arrows : true,
				appendArrows : $nav ? $nav : false,
				responsive : [ {
					breakpoint : 991,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 1,
					}
				}, {
					breakpoint : 480,
					settings : {
						slidesToShow : 1,
						slidesToScroll : 1,
					}
				}, ]
			});
		});
	<%}%>
		$("#linktab1").click(function() {
			$('.products-slick').slick('refresh');
		});

		$("#linktab2").click(function() {
			$('.products-slick2').slick('refresh');
		});

		$("#linktab3").click(function() {
			$('.products-slick3').slick('refresh');
		});
	</script>
</body>
</html>
