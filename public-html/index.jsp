        <%@ page import ="db.*" %>
        <%@ page import ="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>

        <%
        Spgames con = new Spgames();
        con.setValues();
        ArrayList<game_entry> games = con.gamesList();
        ArrayList<game_entry> preownedgames = con.preownedGamesList();
        ArrayList<game_entry> newgames = con.newGamesList();
        %>
<!DOCTYPE html>
<html lang="en">
	<head>
			<title>HEXGEAR - Buy Pre-owned and New Games</title>
			<%@ include file="/etc/header-import.html" %>
		<style type="text/css">
		.product-img{
	display: flex;
  align-items: center;
  justify-content: center;
		}
		</style>
    </head>
	<body>
<%@ include file="/etc/body-header.html" %>


		<% if (games.size()>3||games.size()==3){ %>
		<div class="section">
		<div class="container" style="text-align:center;">
		
		<div class="banner-slider col-12" id="banner-slider">
		
		<div class="banner-slide"><a href="game.jsp?game_id=<%=games.get(1).get_game_id()%>" alt="<%=games.get(1).get_game_title()  %>"><img width="500px" src="gameimage.jsp?game_id=<%=games.get(1).get_game_id()%>"/></a></div>
		<div class="banner-slide"><a href="game.jsp?game_id=<%=games.get(2).get_game_id()%>" alt="<%=games.get(2).get_game_title()  %>"><img width="500px" src="gameimage.jsp?game_id=<%=games.get(2).get_game_id()%>"/></a></div>
		<div class="banner-slide"><a href="game.jsp?game_id=<%=games.get(3).get_game_id()%>" alt="<%=games.get(3).get_game_title()  %>"><img width="500px" src="gameimage.jsp?game_id=<%=games.get(3).get_game_id()%>"/></a></div>
		
		</div>
		
		</div>
		</div>
		<% } %>
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
									<li class="active"><a data-toggle="tab" href="#tab1" id="linktab1">All</a></li>
									<%if(!preownedgames.isEmpty()){ %><li><a data-toggle="tab" href="#tab2" id="linktab2">Brand New Games</a></li> <% } %>
									<%if(!newgames.isEmpty()){ %><li><a data-toggle="tab" href="#tab3" id="linktab3">Pre-Owned Games</a></li> <% }%>
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
								<div id="tab1" class="tab-pane active">
									<div class="products-slick" data-nav="#slick-nav-1">
										
										<% 

if (games.isEmpty()){
	out.print("There are no games to show.");
} else { 

    for (int i = 0; i < games.size(); i++) {
        game_entry row = games.get(i);
       



%>										
										<!-- product -->
										<div class="product">
											<div class="product-img">
								
												<img src="gameimage.jsp?game_id=<%= row.get_game_id() %>" alt="" style="">
												
											</div>
											<div class="product-body">
												<p class="product-category"><% if(row.get_preowned() ==0){out.print("Brand New");} else {out.print("Pre-Owned");} %></p>
												<h3 class="product-name"><a href="game.jsp?game_id=<%= row.get_game_id() %>"><%=row.get_game_title() %></a></h3>
												<h4 class="product-price"><%= row.get_price() %></h4>
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
								<div id="tab2" class="tab-pane fade" >
									<div class="products-slick2"  data-nav="#slick-nav-2">
										
										<% 


if (newgames.isEmpty()){
	out.print("There are no games to show.");
} else { 

    for (int i = 0; i < newgames.size(); i++) {
        game_entry row = newgames.get(i);
       



%>										
										<!-- product -->
										<div class="product">
											<div class="product-img">
								
												<img src="gameimage.jsp?game_id=<%= row.get_game_id() %>" alt="" style="">
												
											</div>
											<div class="product-body">
												<p class="product-category"><% if(row.get_preowned() ==0){out.print("Brand New");} else {out.print("Pre-Owned");} %></p>
												<h3 class="product-name"><a href="game.jsp?game_id=<%= row.get_game_id() %>"><%=row.get_game_title() %></a></h3>
												<h4 class="product-price"><%= row.get_price() %></h4>
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
								<div id="tab3" class="tab-pane fade" >
									<div class="products-slick3"  data-nav="#slick-nav-3">
										
										<% 

if (preownedgames.isEmpty()){
	out.print("There are no games to show.");
} else { 

    for (int i = 0; i < preownedgames.size(); i++) {
        game_entry row = preownedgames.get(i);
       



%>										
										<!-- product -->
										<div class="product">
											<div class="product-img">
								
												<img src="gameimage.jsp?game_id=<%= row.get_game_id() %>" alt="" style="">
												
											</div>
											<div class="product-body">
												<p class="product-category"><% if(row.get_preowned() ==0){out.print("Brand New");} else {out.print("Pre-Owned");} %></p>
												<h3 class="product-name"><a href="game.jsp?game_id=<%= row.get_game_id() %>"><%=row.get_game_title() %></a></h3>
												<h4 class="product-price"><%= row.get_price() %></h4>
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


	


		<%@include file="etc/footer.html" %>
 
		
		<script>
		$(window).ready(function(){
var divWidth = $('.img1').width(); 
    $('.img1').height(divWidth);
});


$(window).resize(function(){
var divWidth = $('.img1').width(); 
    $('.img1').height(divWidth);
});
<%if(newgames.size()!=0){ %>
$('.products-slick2').each(function() {
	var $this = $(this),
			$nav = $this.attr('data-nav');

	$this.slick({
		slidesToShow: 4,
		slidesToScroll: 1,
		autoplay: true,
		infinite: true,
		speed: 300,
		dots: false,
		arrows: true,
		appendArrows: $nav ? $nav : false,
		responsive: [{
        breakpoint: 991,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        }
      },
    ]
	});
});
<% } if(preownedgames.size()!=0){%>
$('.products-slick3').each(function() {
	var $this = $(this),
			$nav = $this.attr('data-nav');

	$this.slick({
		slidesToShow: 4,
		slidesToScroll: 1,
		autoplay: true,
		infinite: true,
		speed: 300,
		dots: false,
		arrows: true,
		appendArrows: $nav ? $nav : false,
		responsive: [{
        breakpoint: 991,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        }
      },
    ]
	});
});
<% }%>
$("#linktab1").click(function(){
	$('.products-slick').slick('refresh');
	});

	$("#linktab2").click(function(){
	$('.products-slick2').slick('refresh');
	});

	$("#linktab3").click(function(){
	$('.products-slick3').slick('refresh');
	});
		</script>
	</body>
</html>
